//#define DEBUG
#define RELEASE
#define MIN_U	100

#include <Mega8.h>
#include <delay.h> 

#ifdef DEBUG
#include "usart.c"
#include "cmd.c"
#include <stdio.h>
#endif


#ifdef DEBUG
#define LED_NET PORTB.0
#define LED_PER PORTB.1
#define LED_DEL PORTB.2
#define KL1 PORTB.7
#define KL2 PORTB.6
#endif
/*
#ifdef RELEASE
#define LED_REC PORTD.0
#define LED_PER PORTD.1
#define LED_DEL PORTD.2
#define LED_NET PORTC.3
#define KL2 PORTD.3
#define KL1 PORTD.4
#define KL3 PORTB.4
#endif
*/
bit bT0;
bit b100Hz;
bit b10Hz;
bit b5Hz;
bit b2Hz;
bit b1Hz;
bit n_but;
bit bCNT;

char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4;
//unsigned int bankA,bankB,bankC;
//unsigned int adc_bankU[3][25],ADCU,adc_bankU_[3];
//unsigned int del_cnt;
char flags;
char deltas;
//char adc_cntA,adc_cntB,adc_cntC;
//bit bA_,bB_,bC_;
//bit bA,bB,bC;
unsigned int adc_data;
char cnt_x;
//char cher[3]={5,6,7};
int cher_cnt=25; 
//char reset_cnt=25;
char pcnt[3];
bit bNN,bNN_;
enum char {iMn,iSetP,iSetD}ind;
bit bFl;
//eeprom char delta; 
//char cnt_butS_,cnt_butR,cnt_butR_; 
//bit butR,butR_,butS_;
//flash char DF[]={0,0,10,15,20,25,30,35};
//char per_cnt/*,zan_cnt*/;
//char nn_cnt;

//bit bDOPon;
//bit bDOPoff;
//bit bKL2;


bit bFL1;
bit bFL2;
//bit bM1;
//bit bM2;

//char dop_cnt;
char led_cnt; 
eeprom char del_ee;
char led_del_cnt;
//unsigned long led_del_buff;



char in_drv_cntA,in_drv_cntB,in_drv_cntC,in_drv_cntD;
short in_drv_cntA_block;
char in_drv_cntL,in_drv_cntR;
bit bINA,bINB,bINC,bIND;
bit bTOP_LIGHT;
bit bTUMAN;
bit bHEAD; 
bit bINL,bINR;
bit bAVAR;
short l_cnt,r_cnt;
//-----------------------------------------------
void t0_init(void)
{
TCCR0=0x03;
TCNT0=-78;
TIMSK|=0b00000001;
} 

//-----------------------------------------------
void t2_init(void)
{
//TIFR|=0b01000000;
TCNT2=-97;
TCCR2=0x07;
OCR2=-80;
TIMSK|=0b11000000;
}  

//-----------------------------------------------
void gran_char(signed char *adr, signed char min, signed char max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 



//-----------------------------------------------
void del_hndl(void)
{
} 







//-----------------------------------------------
void in_drv(void)
{
DDRC&=0b11111000;
PORTC|=0b00000111; 

DDRB&=0b11001111;
PORTB|=0b00110000;

DDRD&=0b11111101;
PORTD|=0b00000010; 

if(PINC.1)
	{
	if(!in_drv_cntA_block)
		{
		if(in_drv_cntA<3)
			{
			in_drv_cntA++;
			if(in_drv_cntA>=3)
				{
				bINA=1;
				in_drv_cntA_block=200;
		    		}
		    	} 
		}
	}
else 
	{
	in_drv_cntA=0;
	if(in_drv_cntA_block)in_drv_cntA_block--;
	}
	
if(PINC.2)
	{
	if(in_drv_cntB<10)
		{
		in_drv_cntB++;
		if(in_drv_cntB>=10)
			{
			bINB=1;
			} 
		}
	}
else 
	{
	in_drv_cntB=0;
	}
		
if(PINC.0)
	{
	if(in_drv_cntC<10)
		{
		in_drv_cntC++;
		if(in_drv_cntC>=10)
			{
			bINC=1;
			} 
		}
	}
else 
	{
	in_drv_cntC=0;
	}	     

if(PIND.1)
	{
	if(in_drv_cntD<10)
		{
		in_drv_cntD++;
		if(in_drv_cntD>=10)
			{
			bIND=1;
			} 
		}
	}
else 
	{
	in_drv_cntD=0;
	}
	
if(!PINB.4)
	{
	if(in_drv_cntL<10)
		{
		in_drv_cntL++;
		if(in_drv_cntL>=10)
			{
			bINL=1;
			} 
		}
	}
else 
	{
	in_drv_cntL=0;
	bINL=0;
	}

if(!PINB.5)
	{
	if(in_drv_cntR<10)
		{
		in_drv_cntR++;
		if(in_drv_cntR>=10)
			{
			bINR=1;
			} 
		}
	}
else 
	{
	in_drv_cntR=0;
	bINR=0;
	}
}


//-----------------------------------------------
void out_drv(void)
{
DDRD|=0b00011101;
DDRC|=0b00001000;

if(bTOP_LIGHT) PORTD.4=1;
else PORTD.4=0;

if(bTUMAN) PORTD.3=1;
else PORTD.3=0; 

if(bHEAD) PORTD.2=1;
else PORTD.2=0;

/*if(bFL1)PORTC.3=0;
else PORTC.3=1;  

if(bFL1)PORTD.0=0;
else PORTD.0=1;*/

//PORTC.3=1;
//PORTD.0=1;

/*if(bINL)PORTD.1=0;
else PORTD.1=1;


if(bINR) PORTD.2=0;
else PORTD.2=1; */
if(bAVAR)
	{
    	if((l_cnt==0)&&(r_cnt==0))
		{
		l_cnt=100;
		r_cnt=100;
		}
	}


if((l_cnt==200)||(l_cnt==100))PORTC.3=0;//PORTD.1=0;
if((l_cnt==150)||(l_cnt==50)||(l_cnt==0))PORTC.3=1;//PORTD.1=1;

if((r_cnt==200)||(r_cnt==100))PORTD.0=0;//PORTD.2=0;
if((r_cnt==150)||(r_cnt==50)||(r_cnt==0))PORTD.0=1;//PORTD.2=1;

if(l_cnt)l_cnt--;
if(r_cnt)r_cnt--;
}

//-----------------------------------------------
void in_an(void)
{
if(bINC)
	{
	bTOP_LIGHT=!bTOP_LIGHT;
	
	}
 
if(bINB)
	{
	bTUMAN=!bTUMAN;
	}

if(bINA)
	{
	bHEAD=!bHEAD;
	}

if(bIND)
	{
	bAVAR=!bAVAR;

	}
	
if(bINL)
	{
	if((l_cnt==0)/*||(l_cnt==100)*/)l_cnt=100;
	}
/*if(!bINL)
	{
	if(l_cnt==100)l_cnt=0;
	}*/

if(bINR)
	{
	if((r_cnt==0)/*||(r_cnt==100)*/)r_cnt=100;
	}
/*if(!bINR)
	{
	if(r_cnt==100)r_cnt=0;
	} */
				
but_an_end:
bINA=0;
bINB=0;
bINC=0;
bIND=0;
//butR_=0;
//butS_=0;
}











//***********************************************
//***********************************************
//***********************************************
//***********************************************
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
t0_init();
bT0=!bT0;

if(!bT0) goto lbl_000;
b100Hz=1;
if(++t0_cnt0>=10)
	{
	t0_cnt0=0;
	b10Hz=1;
	bFl=!bFl;
     if(++led_cnt>=16) led_cnt=0;
	} 
if(++t0_cnt1>=20)
	{
	t0_cnt1=0;
	b5Hz=1;


	}
if(++t0_cnt2>=50)
	{
	t0_cnt2=0;
	b2Hz=1;
			  	bFL1=!bFL1;
	  	if(!bFL1)
	  		{
	  		bFL2=!bFL2;
	  		}
	}	
		
if(++t0_cnt3>=100)
	{
	t0_cnt3=0;
	b1Hz=1;
	}		
lbl_000:
}

//-----------------------------------------------
// Timer 2 output compare interrupt service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
t2_init();



}

//-----------------------------------------------
// Timer 2 output compare interrupt service routine
interrupt [TIM2_COMP] void timer2_comp_isr(void)
{

	

} 


//-----------------------------------------------
//#pragma savereg-
interrupt [ADC_INT] void adc_isr(void)
{

register static unsigned char input_index=0;
// Read the AD conversion result
adc_data=ADCW;


#asm("sei")
}

//===============================================
//===============================================
//===============================================
//===============================================
void main(void)
{

ASSR=0;
OCR2=0;

// ADC initialization

ADMUX=0b01000011;
ADCSRA=0xCC;

t0_init();
//t2_init(); 
//del_init();
#asm("sei")

ind=iMn;

while (1)
	{
	//DDRC.3=1; 
	//PORTC.3=0; 
    //	DDRD.0=1;
	//PORTD.0=0;
	if(b100Hz)
		{
		b100Hz=0;
          out_drv();
		in_drv();
		in_an();
		}   
	if(b10Hz)
		{
		b10Hz=0;
		}
	if(b5Hz)
		{
		b5Hz=0;
	  	 
		//deltas=delta;
								
		}
	if(b2Hz)
		{
		b2Hz=0;
		//bHEAD=!bHEAD;
		}		 
    	if(b1Hz)
		{
		b1Hz=0;
		//del_hndl();
		DDRD.4=1;
		DDRD.3=1;
		//PORTD.3=!PORTD.3;
		//PORTD.4=!PORTD.4; 
		}
     #asm("wdr")	
	}
}
