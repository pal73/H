/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.1d Standard
Automatic Program Generator
� Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.ro
e-mail:office@hpinfotech.ro

Project : 
Version : 
Date    : 02.04.2017
Author  : PAL
Company : HOME
Comments: 


Chip type           : ATmega168
Program type        : Application
Clock frequency     : 1,000000 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 256
*****************************************************/

#include <mega168.h>
char ind_cnt;
flash char STROB[2]={0b11101111,0b11011111}; 
flash char DIGISYM[14]={0b00110000,0b11111100,0b00010110,0b10010100,0b11011000,0b10010001,0b00010001,0b11110100,0b00010000,0b10010000,0b11111111,0b11111111,0b11111111,0b11111111};
char ind_out[2]={0b10010100,0b11011000}; 
char dig[3]; 
bit zero_on; 
bit bIN_ENC;
eeprom signed short plazma;
signed short plazma_plazma;

//-----------------------------------------------
void bin2bcd_char(char in)
{
char i;

for(i=0;i<3;i++)
	{
	dig[i]=in%10;
	in/=10;
	}
}

//-----------------------------------------------
void bcd2ind_zero()
{
char i;
zero_on=1;
for (i=2;i>0;i--)
	{
	if(zero_on&&(!dig[i-1])&&(i-1))
		{
		ind_out[i-1]=0b11111111;
		}
	else
		{
		ind_out[i-1]=DIGISYM[dig[i-1]];
		zero_on=0;
		}
	}
}



//-----------------------------------------------
void char2ind(unsigned long in)
{

bin2bcd_char(in);
bcd2ind_zero();

}

//-----------------------------------------------
// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
TCNT0=-160;

ind_cnt++;
if(ind_cnt>1)ind_cnt=0;


DDRB=0; 

DDRD|=0b00110000;
PORTD|=0b00110000;
PORTD&=STROB[ind_cnt]; 
/*
DDRD.4=1;
DDRD.5=1;
PORTD.4=1;
PORTD.5=1;
if(ind_cnt)
	{
     PORTD.4=0;
	}         
else PORTD.5=0;*/
PORTB=ind_out[ind_cnt];
DDRB=0xff;


DDRC.5=0; 
DDRD.2=0;
PORTC.5=1;
PORTD.2=1;
               
if(PINC.5!=bIN_ENC)
	{
	if(PINC.5!=PIND.2)
		{
		if(plazma<99)plazma++;
		if(plazma>=99)plazma=99;
		}                       
	else 
		{
		if(plazma)plazma--;
		if(plazma<0)plazma=0;
		}
	}

bIN_ENC=PINC.5;

}

// Declare your global variables here

//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------
//-----------------------------------------------
void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
CLKPR=0x80;
CLKPR=0x00;

// Input/Output Ports initialization
// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x00;

// Port C initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=0 State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x08;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 3,906 kHz
// Mode: Normal top=FFh
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x00;
TCCR0B=0x04;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer 1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 1000,000 kHz
// Mode: Fast PWM top=FFh
// OC2A output: Disconnected
// OC2B output: Non-Inverted PWM
ASSR=0x00;
TCCR2A=0x23;
TCCR2B=0x01;
TCNT2=0x00;
OCR2A=0x30;
OCR2B=0x50;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// Interrupt on any change on pins PCINT0-7: Off
// Interrupt on any change on pins PCINT8-14: Off
// Interrupt on any change on pins PCINT16-23: Off
EICRA=0x00;
EIMSK=0x00;
PCICR=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=0x01;
// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=0x00;
// Timer/Counter 2 Interrupt(s) initialization
TIMSK2=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
// Analog Comparator Output: Off
ACSR=0x80;
ADCSRB=0x00;

// Global enable interrupts
#asm("sei")

while (1)
	{
     char2ind(plazma);
	plazma_plazma=plazma*25;
	plazma_plazma/=10;
	if(plazma_plazma<0)plazma_plazma=0;
	if(plazma_plazma>250)plazma_plazma=250; 
	OCR2B=(char)plazma_plazma;
	};
}
