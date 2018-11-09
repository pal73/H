#include "stm8s.h"
#include <iostm8s103.h>
#include "main.h"
#include <stdio.h>
#include <string.h>
#include <stdio.h>
#include "i2c.h"

#define KEY_ENABLE 	0xCC
#define KEY_REFRESH 0xAA
#define KEY_ACCESS 	0x55

@near bool b100Hz=0,b10Hz=0,b5Hz=0,b1Hz=0;
@near static char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0;

//-----------------------------------------------
//Измеряемая температура
short temper;

//-----------------------------------------------
//Контрольная сумма, вычисляется сложением всех десятичных разрядов температуры
short temperCRC;

//-----------------------------------------------
//Строки для отправки в "голову"
char *out_buff;
char *out_buff_preffiks;
char *out_buff_digits;

//-----------------------------------------------
//DS18B20
bool bCONV;
char wire1_in[10];		//Считывание данных, буфер 1wire
char ds18b20ErrorHiCnt; //Счетчик ошибок по замыканию линии в "+" (или отсутствию датчика)
char ds18b20ErrorLoCnt;	//Счетчик ошибок по замыканию линии в "-" 
char ds18b20ErrorOffCnt;//Счетчик нормальных ответов датчика
enumDsErrorStat airSensorErrorStat = esNORM;

//-----------------------------------------------
//UART
#define TX_BUFFER_SIZE	30
@near char tx_buffer[TX_BUFFER_SIZE]={0};
@near signed char tx_counter;
signed char tx_wr_index,tx_rd_index;
char bOUT_FREE;


char buf[100];
char* out_string;
char* out_string1;
char* out_string2;
int temperdeb =1234;


//-----------------------------------------------
enumSensorType sensor=sensOFF;

char i2c_temp;

char bWFI=0;

//char* buf;
//-----------------------------------------------
void t4_init(void)
{
TIM4->PSCR = 3;
TIM4->ARR= 158;
TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt

TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
	
}

//-----------------------------------------------
char wire1_w1ts(void)
{
short i,ii,num_out;
GPIOC->DDR|=(1<<7);
GPIOC->ODR&=~(1<<7);

//импульс 10мкс
for(i=0;i<10;i++)
	{
	__nop();
	}
GPIOC->ODR|=(1<<7);

//выдержка 90мкс
for(i=0;i<90;i++)
	{
	__nop();
	}
}

//-----------------------------------------------
char wire1_w0ts(void)
{
short i,ii,num_out;
GPIOC->DDR|=(1<<7);
GPIOC->ODR&=~(1<<7);

//импульс 90мкс
for(i=0;i<90;i++)
	{
	__nop();
	}
GPIOC->ODR|=(1<<7);

//выдержка 10мкс
for(i=0;i<10;i++)
	{
	__nop();
	}
}

//-----------------------------------------------
void wire1_send_byte(char in)
{
char i,ii;
ii=in;

for(i=0;i<8;i++)
	{
	if(ii&0x01)wire1_w1ts();
	else wire1_w0ts();
	ii>>=1;
	}
}

//-----------------------------------------------
char wire1_read_byte(void)
{
char i,ii;
ii=0;

for(i=0;i<8;i++)
	{
	ii>>=1;
	if(wire1_rts())ii|=0x80;
	else ii&=0x7f;
	}
return ii;
}

//-----------------------------------------------
char wire1_rts(void)
{
short i,ii,num_out;

GPIOC->DDR|=(1<<7);
GPIOC->ODR&=~(1<<7);

//импульс 10мкс
for(i=0;i<2;i++)
	{
	__nop();
	}

GPIOC->ODR|=(1<<7);
//импульс 20мкс
for(i=0;i<10;i++)
	{
	__nop();
	}
if(GPIOC->IDR&(1<<7))	ii=1;
else ii=0;

//выдержка 30мкс
for(i=0;i<50;i++)
	{
	__nop();
	}
return ii;
}
//-----------------------------------------------
char wire1_polling(void)
{
short i,ii,num_out;
GPIOC->CR1&=~(1<<7);
GPIOC->CR2&=~(1<<7);
GPIOC->DDR|=(1<<7);


GPIOC->ODR&=~(1<<7);

//импульс сброса 600мкс
for(i=0;i<600;i++)
	{
	__nop();
	}
GPIOC->ODR|=(1<<7);

//выдержка 15мкс
for(i=0;i<15;i++)
	{
	__nop();
	}

//еще 45мкс ждем сигнала от таблетки
for(i=0;i<20;i++)
	{
	__nop();
	__nop();
	__nop();
	if(!(GPIOC->IDR&(1<<7)))goto ibatton_polling_lbl_000;
	}
//goto ibatton_polling_lbl_zero_exit;
return 0;
ibatton_polling_lbl_000:

//измеряем длительность ответного импульса не дольше 300мкс
for(i=0;i<220;i++)
	{
	if(GPIOC->IDR&(1<<7))
		{
		__nop();
		__nop();
		num_out=10;
		goto ibatton_polling_lbl_001;	//continue;
		}
	}
//num_out=5;
//goto ibatton_polling_lbl_zero_exit;
return 5;

ibatton_polling_lbl_001:
//выдержка 15мкс
for(i=0;i<30;i++)
	{
	__nop();
	}
ibatton_polling_lbl_success_exit:
return 1;
ibatton_polling_lbl_zero_exit:
return 0;
}

//-----------------------------------------------
void uart_init (void)
{
GPIOD->DDR&=~(1<<5);	
GPIOD->CR1|=(1<<5);
GPIOD->CR2&=~(1<<5);

UART1->CR1&=~UART1_CR1_M;					
UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
UART1->BRR2= 0x03;
UART1->BRR1= 0x68;
UART1->CR2|= UART1_CR2_TEN /*| UART3_CR2_REN | UART3_CR2_RIEN*/;	
}

//-----------------------------------------------
void putchar(char c)
{
while (tx_counter == TX_BUFFER_SIZE);
///#asm("cli")
if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
   {
   tx_buffer[tx_wr_index]=c;
   if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
   ++tx_counter;
   }
else UART1->DR=c;

UART1->CR2|= UART1_CR2_TIEN;
///#asm("sei")
}

//-----------------------------------------------
void watchdog_enable(void)
{
IWDG_KR=KEY_ENABLE;
IWDG_KR=KEY_ACCESS;
IWDG_PR=6;
IWDG_RLR=250;

}

//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) 
{
if(++t0_cnt0>=125)
	{
  t0_cnt0=0;
  b100Hz=1;

	if(++t0_cnt1>=10)
		{
		t0_cnt1=0;
		b10Hz=1;
		//bWFI=1;
		}
		
	if(++t0_cnt2>=20)
		{
		t0_cnt2=0;
		b5Hz=1;
		//bWFI=1;
		}
		
	if(++t0_cnt3>=100)
		{
		t0_cnt3=0;
		b1Hz=1;
		bWFI=0;
		}
	}
TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
return;
}

//***********************************************
@far @interrupt void UARTTxInterrupt (void) 
{
if (tx_counter)
	{
	--tx_counter;
	UART1->DR=tx_buffer[tx_rd_index];
	if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
	}
else 
	{
	//bOUT_FREE=1;
	UART1->CR2&= ~UART1_CR2_TIEN;
	bWFI=1;
	watchdog_enable();
	//halt();
	wfi();
	
	}
}

//***********************************************
@far @interrupt void UARTRxInterrupt (void) 
{

}

//===============================================
//===============================================
//===============================================
//===============================================
main()
{
CLK->CKDIVR=0;

GPIOC->DDR|=(1<<6);
GPIOC->CR1|=(1<<6);
GPIOC->CR2|=(1<<6);





{
char i,cnt=0;

cnt=0;
for(i=0;i<100;i++)
	{
	if(wire1_polling()==1)cnt++;
	}
if(cnt>70)sensor=sens18B20;

else
	{
	i2c_setup();
	for(i=0;i<100;i++)
		{
		if(i2c_7bit_receive_onebyte(&i2c_temp)==I2C_OK)cnt++;
		}
	if(cnt>70)sensor=sens1775;
	}
}


t4_init();
uart_init();
enableInterrupts();

/*			if(ibatton_polling())
				{
				ibatton_send_byte(0xCC);
				ibatton_send_byte(0x44);
				}*/
while (1)
	{
	if(bWFI==1)wfi();
	if(b100Hz)
		{
		b100Hz=0;
		
		//GPIOC->DDR|=(1<<7);
		//GPIOC->CR1|=(1<<7);
		//GPIOC->CR2|=(1<<7);	
		//GPIOC->ODR^=(1<<7);
		}  
      	
	if(b10Hz)
		{
		b10Hz=0;
/*   	if(ibatton_polling())
			{
			ibatton_send_byte(0x44);
			}*/
		}
      	 
	if(b5Hz)
		{
		b5Hz=0;
		

			
		}
      	      	
	if(b1Hz)
		{
		b1Hz=0;
		
		if(sensor==sens18B20)
			{
			
			if(!bCONV)
				{
				char temp;
				bCONV=1;
				temp=wire1_polling();
				if(temp==1)
					{
					wire1_send_byte(0xCC);
					wire1_send_byte(0x44);
					
					ds18b20ErrorHiCnt=0;
					ds18b20ErrorLoCnt=0;
					airSensorErrorStat=esNORM;		
					}
				else
					{
					if(temp==0)
						{
						if(ds18b20ErrorHiCnt<10)
							{
							ds18b20ErrorHiCnt++;
							if(ds18b20ErrorHiCnt>=10)
								{
								airSensorErrorStat=esHI;	
								}
							}
						ds18b20ErrorLoCnt=0;
						//ds18b20ErrorOffCnt=0;			
						}
					if(temp==5)
						{
						if(ds18b20ErrorLoCnt<10)
							{
							ds18b20ErrorLoCnt++;
							if(ds18b20ErrorLoCnt>=10)
								{
								airSensorErrorStat=esLO;	
								}
							}
						ds18b20ErrorHiCnt=0;
						//ds18b20ErrorOffCnt=0;			
						}			
					}
				}
			else 
				{
				char temp;
				bCONV=0;
				temp=wire1_polling();
				if(temp==1)
					{
					wire1_send_byte(0xCC);
					wire1_send_byte(0xBE);
					wire1_in[0]=wire1_read_byte();
					wire1_in[1]=wire1_read_byte();
					wire1_in[2]=wire1_read_byte();
					wire1_in[3]=wire1_read_byte();
					wire1_in[4]=wire1_read_byte();
					wire1_in[5]=wire1_read_byte();
					wire1_in[6]=wire1_read_byte();
					wire1_in[7]=wire1_read_byte();
					wire1_in[8]=wire1_read_byte();
					
					ds18b20ErrorHiCnt=0;
					ds18b20ErrorLoCnt=0;
					airSensorErrorStat=esNORM;
					}
				else
					{
					if(temp==0)
						{
						if(ds18b20ErrorHiCnt<10)
							{
							ds18b20ErrorHiCnt++;
							if(ds18b20ErrorHiCnt>=10)
								{
								airSensorErrorStat=esHI;	
								}
							}
						ds18b20ErrorLoCnt=0;
						//ds18b20ErrorOffCnt=0;			
						}
					if(temp==5)
						{
						if(ds18b20ErrorLoCnt<10)
							{
							ds18b20ErrorLoCnt++;
							if(ds18b20ErrorLoCnt>=10)
								{
								airSensorErrorStat=esLO;	
								}
							}
						ds18b20ErrorHiCnt=0;
						//ds18b20ErrorOffCnt=0;			
						}			
					}
				}
				
			if(wire1_in[1]&0xf0)
				{
					//TODO отрицательная температура
				}
			else
				{
				short temper_temp;
				
				temper_temp=(((short)wire1_in[1])<<8)+((short)wire1_in[0]);
				temper_temp>>=4;
				temper_temp&=0x00ff;
				
				temper=(short)temper_temp;
				//temper=23;
				}
			temperCRC = (temper%10)+((temper/10)%10)+((temper/100)%10);
			temperCRC*=-1;
	//		out_string="temper=";
	//		buf[0] = '0';
	//		buf[1] = '\r';
	//		buf[2] = '\n';
	//		strcpy(buf, "first string");
	//		//strcpy(buf, "string");
	//		strcpy(out_string1, "abcdef");
	//		strcpy(buf, out_string);
	//		printf(buf);
			//strcat(buf, “, second string”);
			//sprintf(out_string1,out_string); 
			//printf("mama");
			//puts("mama");
			//temperdeb=29;
			//out_buff_preffiks="OK";
			//sprintf(out_buff_digits,"%d\n",temper);
			//out_buff=out_buff_preffiks+out_buff_digits;
			//out_buff=strcat(out_buff_preffiks,out_buff_digits);
			//out_buff="OK35";
			//puts(out_buff_digits);
			//putchar('m');
			if(airSensorErrorStat==esHI) printf("ERRORHI\n");
			else if(airSensorErrorStat==esLO) printf("ERRORLO\n");
			else if(airSensorErrorStat==esNORM) printf("OK%dCRC%d\n",temper,temperCRC);
			}
		else if(sensor==sens1775)
			{
			i2c_setup();
			i2c_7bit_send_onebyte(0, 1);
			temper=i2c_7bit_receive_onebyte(&i2c_temp);
			if(temper!=I2C_OK)printf("ERRORHI\n");
			else
				{
				temper=i2c_temp;
				temperCRC = (temper%10)+((temper/10)%10)+((temper/100)%10);
				temperCRC*=-1;
				printf("OK%dCRC%d\n",temper,temperCRC);
				}
			}
		}     	     	      
	};
	
}