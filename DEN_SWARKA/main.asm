;CodeVisionAVR C Compiler V1.24.1d Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.ro
;e-mail:office@hpinfotech.ro

;Chip type           : ATmega168
;Program type        : Application
;Clock frequency     : 1,000000 MHz
;Memory model        : Small
;Optimize for        : Size
;(s)printf features  : int, width
;(s)scanf features   : long, width
;External SRAM size  : 0
;Data Stack size     : 256 byte(s)
;Heap size           : 0 byte(s)
;Promote char to int : No
;char is unsigned    : Yes
;8 bit enums         : Yes
;Enhanced core instructions    : On
;Automatic register allocation : On

	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "main.vec"
	.INCLUDE "main.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	IN   R26,MCUSR
	OUT  MCUSR,R30
	STS  WDTCSR,R31
	STS  WDTCSR,R30
	OUT  MCUSR,R26

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	LDI  R30,__GPIOR1_INIT
	OUT  GPIOR1,R30
	LDI  R30,__GPIOR2_INIT
	OUT  GPIOR2,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x4FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x4FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x200)
	LDI  R29,HIGH(0x200)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x200
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.24.1d Standard
;       4 Automatic Program Generator
;       5 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.ro
;       7 e-mail:office@hpinfotech.ro
;       8 
;       9 Project : 
;      10 Version : 
;      11 Date    : 02.04.2017
;      12 Author  : PAL
;      13 Company : HOME
;      14 Comments: 
;      15 
;      16 
;      17 Chip type           : ATmega168
;      18 Program type        : Application
;      19 Clock frequency     : 1,000000 MHz
;      20 Memory model        : Small
;      21 External SRAM size  : 0
;      22 Data Stack size     : 256
;      23 *****************************************************/
;      24 
;      25 #include <mega168.h>
;      26 char ind_cnt;
;      27 flash char STROB[2]={0b11101111,0b11011111}; 

	.CSEG
;      28 flash char DIGISYM[14]={0b00110000,0b11111100,0b00010110,0b10010100,0b11011000,0b10010001,0b00010001,0b11110100,0b00010000,0b10010000,0b11111111,0b11111111,0b11111111,0b11111111};
;      29 char ind_out[2]={0b10010100,0b11011000}; 

	.DSEG
_ind_out:
	.BYTE 0x2
;      30 char dig[3]; 
_dig:
	.BYTE 0x3
;      31 bit zero_on; 
;      32 bit bIN_ENC;
;      33 eeprom signed short plazma;

	.ESEG
_plazma:
	.DW  0x0
;      34 signed short plazma_plazma;
;      35 
;      36 //-----------------------------------------------
;      37 void bin2bcd_char(char in)
;      38 {

	.CSEG
_bin2bcd_char:
;      39 char i;
;      40 
;      41 for(i=0;i<3;i++)
	ST   -Y,R16
;	in -> Y+1
;	i -> R16
	LDI  R16,LOW(0)
_0x5:
	CPI  R16,3
	BRSH _0x6
;      42 	{
;      43 	dig[i]=in%10;
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_dig)
	SBCI R31,HIGH(-_dig)
	PUSH R31
	PUSH R30
	LDD  R26,Y+1
	LDI  R30,LOW(10)
	CALL __MODB21U
	POP  R26
	POP  R27
	ST   X,R30
;      44 	in/=10;
	LDD  R26,Y+1
	LDI  R30,LOW(10)
	CALL __DIVB21U
	STD  Y+1,R30
;      45 	}
	SUBI R16,-1
	RJMP _0x5
_0x6:
;      46 }
	LDD  R16,Y+0
	ADIW R28,2
	RET
;      47 
;      48 //-----------------------------------------------
;      49 void bcd2ind_zero()
;      50 {
_bcd2ind_zero:
;      51 char i;
;      52 zero_on=1;
	ST   -Y,R16
;	i -> R16
	SBI  0x1E,0
;      53 for (i=2;i>0;i--)
	LDI  R16,LOW(2)
_0x8:
	LDI  R30,LOW(0)
	CP   R30,R16
	BRSH _0x9
;      54 	{
;      55 	if(zero_on&&(!dig[i-1])&&(i-1))
	SBIS 0x1E,0
	RJMP _0xB
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_dig)
	SBCI R31,HIGH(-_dig)
	LD   R30,Z
	CPI  R30,0
	BRNE _0xB
	MOV  R30,R16
	SUBI R30,LOW(1)
	BRNE _0xC
_0xB:
	RJMP _0xA
_0xC:
;      56 		{
;      57 		ind_out[i-1]=0b11111111;
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_ind_out)
	SBCI R31,HIGH(-_ind_out)
	MOVW R26,R30
	LDI  R30,LOW(255)
	ST   X,R30
;      58 		}
;      59 	else
	RJMP _0xD
_0xA:
;      60 		{
;      61 		ind_out[i-1]=DIGISYM[dig[i-1]];
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_ind_out)
	SBCI R31,HIGH(-_ind_out)
	PUSH R31
	PUSH R30
	LDI  R30,LOW(_DIGISYM*2)
	LDI  R31,HIGH(_DIGISYM*2)
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-_dig)
	SBCI R31,HIGH(-_dig)
	LD   R30,Z
	POP  R26
	POP  R27
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;      62 		zero_on=0;
	CBI  0x1E,0
;      63 		}
_0xD:
;      64 	}
	SUBI R16,1
	RJMP _0x8
_0x9:
;      65 }
	LD   R16,Y+
	RET
;      66 
;      67 
;      68 
;      69 //-----------------------------------------------
;      70 void char2ind(unsigned long in)
;      71 {
_char2ind:
;      72 
;      73 bin2bcd_char(in);
	__GETD1S 0
	ST   -Y,R30
	RCALL _bin2bcd_char
;      74 bcd2ind_zero();
	RCALL _bcd2ind_zero
;      75 
;      76 }
	ADIW R28,4
	RET
;      77 
;      78 //-----------------------------------------------
;      79 // Timer 0 overflow interrupt service routine
;      80 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;      81 {
_timer0_ovf_isr:
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;      82 TCNT0=-160;
	LDI  R30,LOW(65376)
	LDI  R31,HIGH(65376)
	OUT  0x26,R30
;      83 
;      84 ind_cnt++;
	INC  R4
;      85 if(ind_cnt>1)ind_cnt=0;
	LDI  R30,LOW(1)
	CP   R30,R4
	BRSH _0xE
	CLR  R4
;      86 
;      87 
;      88 DDRB=0; 
_0xE:
	LDI  R30,LOW(0)
	OUT  0x4,R30
;      89 
;      90 DDRD|=0b00110000;
	IN   R30,0xA
	ORI  R30,LOW(0x30)
	OUT  0xA,R30
;      91 PORTD|=0b00110000;
	IN   R30,0xB
	ORI  R30,LOW(0x30)
	OUT  0xB,R30
;      92 PORTD&=STROB[ind_cnt]; 
	IN   R30,0xB
	PUSH R30
	LDI  R26,LOW(_STROB*2)
	LDI  R27,HIGH(_STROB*2)
	MOV  R30,R4
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	POP  R26
	AND  R30,R26
	OUT  0xB,R30
;      93 /*
;      94 DDRD.4=1;
;      95 DDRD.5=1;
;      96 PORTD.4=1;
;      97 PORTD.5=1;
;      98 if(ind_cnt)
;      99 	{
;     100      PORTD.4=0;
;     101 	}         
;     102 else PORTD.5=0;*/
;     103 PORTB=ind_out[ind_cnt];
	MOV  R30,R4
	LDI  R31,0
	SUBI R30,LOW(-_ind_out)
	SBCI R31,HIGH(-_ind_out)
	LD   R30,Z
	OUT  0x5,R30
;     104 DDRB=0xff;
	LDI  R30,LOW(255)
	OUT  0x4,R30
;     105 
;     106 
;     107 DDRC.5=0; 
	CBI  0x7,5
;     108 DDRD.2=0;
	CBI  0xA,2
;     109 PORTC.5=1;
	SBI  0x8,5
;     110 PORTD.2=1;
	SBI  0xB,2
;     111                
;     112 if(PINC.5!=bIN_ENC)
	LDI  R30,0
	SBIC 0x6,5
	LDI  R30,1
	PUSH R30
	LDI  R30,0
	SBIC 0x1E,1
	LDI  R30,1
	POP  R26
	CP   R30,R26
	BRNE PC+3
	JMP _0xF
;     113 	{
;     114 	if(PINC.5!=PIND.2)
	LDI  R30,0
	SBIC 0x6,5
	LDI  R30,1
	PUSH R30
	LDI  R30,0
	SBIC 0x9,2
	LDI  R30,1
	POP  R26
	CP   R30,R26
	BREQ _0x10
;     115 		{
;     116 		if(plazma<99)plazma++;
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x63)
	LDI  R26,HIGH(0x63)
	CPC  R31,R26
	BRGE _0x11
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;     117 		if(plazma>=99)plazma=99;
_0x11:
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x63)
	LDI  R26,HIGH(0x63)
	CPC  R31,R26
	BRLT _0x12
	LDI  R30,LOW(99)
	LDI  R31,HIGH(99)
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMWRW
;     118 		}                       
_0x12:
;     119 	else 
	RJMP _0x13
_0x10:
;     120 		{
;     121 		if(plazma)plazma--;
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	SBIW R30,0
	BREQ _0x14
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;     122 		if(plazma<0)plazma=0;
_0x14:
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	MOVW R26,R30
	SBIW R26,0
	BRGE _0x15
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMWRW
;     123 		}
_0x15:
_0x13:
;     124 	}
;     125 
;     126 bIN_ENC=PINC.5;
_0xF:
	CLT
	SBIC 0x6,5
	SET
	IN   R30,0x1E
	BLD  R30,1
	OUT  0x1E,R30
;     127 
;     128 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	RETI
;     129 
;     130 // Declare your global variables here
;     131 
;     132 //-----------------------------------------------
;     133 //-----------------------------------------------
;     134 //-----------------------------------------------
;     135 //-----------------------------------------------
;     136 void main(void)
;     137 {
_main:
;     138 // Declare your local variables here
;     139 
;     140 // Crystal Oscillator division factor: 1
;     141 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  0x61,R30
;     142 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  0x61,R30
;     143 
;     144 // Input/Output Ports initialization
;     145 // Port B initialization
;     146 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     147 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     148 PORTB=0x00;
	OUT  0x5,R30
;     149 DDRB=0x00;
	OUT  0x4,R30
;     150 
;     151 // Port C initialization
;     152 // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     153 // State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     154 PORTC=0x00;
	OUT  0x8,R30
;     155 DDRC=0x00;
	OUT  0x7,R30
;     156 
;     157 // Port D initialization
;     158 // Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=In Func1=In Func0=In 
;     159 // State7=T State6=T State5=T State4=T State3=0 State2=T State1=T State0=T 
;     160 PORTD=0x00;
	OUT  0xB,R30
;     161 DDRD=0x08;
	LDI  R30,LOW(8)
	OUT  0xA,R30
;     162 
;     163 // Timer/Counter 0 initialization
;     164 // Clock source: System Clock
;     165 // Clock value: 3,906 kHz
;     166 // Mode: Normal top=FFh
;     167 // OC0A output: Disconnected
;     168 // OC0B output: Disconnected
;     169 TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
;     170 TCCR0B=0x04;
	LDI  R30,LOW(4)
	OUT  0x25,R30
;     171 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x26,R30
;     172 OCR0A=0x00;
	OUT  0x27,R30
;     173 OCR0B=0x00;
	OUT  0x28,R30
;     174 
;     175 // Timer/Counter 1 initialization
;     176 // Clock source: System Clock
;     177 // Clock value: Timer 1 Stopped
;     178 // Mode: Normal top=FFFFh
;     179 // OC1A output: Discon.
;     180 // OC1B output: Discon.
;     181 // Noise Canceler: Off
;     182 // Input Capture on Falling Edge
;     183 TCCR1A=0x00;
	STS  0x80,R30
;     184 TCCR1B=0x00;
	STS  0x81,R30
;     185 TCNT1H=0x00;
	STS  0x85,R30
;     186 TCNT1L=0x00;
	STS  0x84,R30
;     187 ICR1H=0x00;
	STS  0x87,R30
;     188 ICR1L=0x00;
	STS  0x86,R30
;     189 OCR1AH=0x00;
	STS  0x89,R30
;     190 OCR1AL=0x00;
	STS  0x88,R30
;     191 OCR1BH=0x00;
	STS  0x8B,R30
;     192 OCR1BL=0x00;
	STS  0x8A,R30
;     193 
;     194 // Timer/Counter 2 initialization
;     195 // Clock source: System Clock
;     196 // Clock value: 1000,000 kHz
;     197 // Mode: Fast PWM top=FFh
;     198 // OC2A output: Disconnected
;     199 // OC2B output: Non-Inverted PWM
;     200 ASSR=0x00;
	STS  0xB6,R30
;     201 TCCR2A=0x23;
	LDI  R30,LOW(35)
	STS  0xB0,R30
;     202 TCCR2B=0x01;
	LDI  R30,LOW(1)
	STS  0xB1,R30
;     203 TCNT2=0x00;
	LDI  R30,LOW(0)
	STS  0xB2,R30
;     204 OCR2A=0x30;
	LDI  R30,LOW(48)
	STS  0xB3,R30
;     205 OCR2B=0x50;
	LDI  R30,LOW(80)
	STS  0xB4,R30
;     206 
;     207 // External Interrupt(s) initialization
;     208 // INT0: Off
;     209 // INT1: Off
;     210 // Interrupt on any change on pins PCINT0-7: Off
;     211 // Interrupt on any change on pins PCINT8-14: Off
;     212 // Interrupt on any change on pins PCINT16-23: Off
;     213 EICRA=0x00;
	LDI  R30,LOW(0)
	STS  0x69,R30
;     214 EIMSK=0x00;
	OUT  0x1D,R30
;     215 PCICR=0x00;
	STS  0x68,R30
;     216 
;     217 // Timer/Counter 0 Interrupt(s) initialization
;     218 TIMSK0=0x01;
	LDI  R30,LOW(1)
	STS  0x6E,R30
;     219 // Timer/Counter 1 Interrupt(s) initialization
;     220 TIMSK1=0x00;
	LDI  R30,LOW(0)
	STS  0x6F,R30
;     221 // Timer/Counter 2 Interrupt(s) initialization
;     222 TIMSK2=0x00;
	STS  0x70,R30
;     223 
;     224 // Analog Comparator initialization
;     225 // Analog Comparator: Off
;     226 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     227 // Analog Comparator Output: Off
;     228 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
;     229 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  0x7B,R30
;     230 
;     231 // Global enable interrupts
;     232 #asm("sei")
	sei
;     233 
;     234 while (1)
_0x16:
;     235 	{
;     236      char2ind(plazma);
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	CALL __CWD1
	CALL __PUTPARD1
	RCALL _char2ind
;     237 	plazma_plazma=plazma*25;
	LDI  R26,LOW(_plazma)
	LDI  R27,HIGH(_plazma)
	CALL __EEPROMRDW
	LDI  R26,LOW(25)
	LDI  R27,HIGH(25)
	CALL __MULW12
	__PUTW1R 5,6
;     238 	plazma_plazma/=10;
	__GETW2R 5,6
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	__PUTW1R 5,6
;     239 	if(plazma_plazma<0)plazma_plazma=0;
	CLR  R0
	CP   R5,R0
	CPC  R6,R0
	BRGE _0x19
	CLR  R5
	CLR  R6
;     240 	if(plazma_plazma>250)plazma_plazma=250; 
_0x19:
	LDI  R30,LOW(250)
	LDI  R31,HIGH(250)
	CP   R30,R5
	CPC  R31,R6
	BRGE _0x1A
	__PUTW1R 5,6
;     241 	OCR2B=(char)plazma_plazma;
_0x1A:
	STS  180,R5
;     242 	};
	RJMP _0x16
;     243 }
_0x1B:
	RJMP _0x1B

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x0:
	MOV  R30,R16
	SUBI R30,LOW(1)
	LDI  R31,0
	RET

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__CWD1:
	LDI  R22,0
	LDI  R23,0
	SBRS R31,7
	RET
	SER  R22
	SER  R23
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODB21U:
	RCALL __DIVB21U
	MOV  R30,R26
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIC EECR,EEWE
	RJMP __EEPROMWRB
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

