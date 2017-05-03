;CodeVisionAVR C Compiler V1.24.1d Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.ro
;e-mail:office@hpinfotech.ro

;Chip type           : ATmega8
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

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

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

	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70

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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

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
	LDI  R26,0x60
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

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160
;       1 //#define DEBUG
;       2 #define RELEASE
;       3 #define MIN_U	100
;       4 
;       5 #include <Mega8.h>
;       6 #include <delay.h> 
;       7 
;       8 #ifdef DEBUG
;       9 #include "usart.c"
;      10 #include "cmd.c"
;      11 #include <stdio.h>
;      12 #endif
;      13 
;      14 
;      15 #ifdef DEBUG
;      16 #define LED_NET PORTB.0
;      17 #define LED_PER PORTB.1
;      18 #define LED_DEL PORTB.2
;      19 #define KL1 PORTB.7
;      20 #define KL2 PORTB.6
;      21 #endif
;      22 /*
;      23 #ifdef RELEASE
;      24 #define LED_REC PORTD.0
;      25 #define LED_PER PORTD.1
;      26 #define LED_DEL PORTD.2
;      27 #define LED_NET PORTC.3
;      28 #define KL2 PORTD.3
;      29 #define KL1 PORTD.4
;      30 #define KL3 PORTB.4
;      31 #endif
;      32 */
;      33 bit bT0;
;      34 bit b100Hz;
;      35 bit b10Hz;
;      36 bit b5Hz;
;      37 bit b2Hz;
;      38 bit b1Hz;
;      39 bit n_but;
;      40 bit bCNT;
;      41 
;      42 char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4;
;      43 //unsigned int bankA,bankB,bankC;
;      44 //unsigned int adc_bankU[3][25],ADCU,adc_bankU_[3];
;      45 //unsigned int del_cnt;
;      46 char flags;
;      47 char deltas;
;      48 //char adc_cntA,adc_cntB,adc_cntC;
;      49 //bit bA_,bB_,bC_;
;      50 //bit bA,bB,bC;
;      51 unsigned int adc_data;
_adc_data:
	.BYTE 0x2
;      52 char cnt_x;
_cnt_x:
	.BYTE 0x1
;      53 //char cher[3]={5,6,7};
;      54 int cher_cnt=25; 
_cher_cnt:
	.BYTE 0x2
;      55 //char reset_cnt=25;
;      56 char pcnt[3];
_pcnt:
	.BYTE 0x3
;      57 bit bNN,bNN_;
;      58 enum char {iMn,iSetP,iSetD}ind;
_ind:
	.BYTE 0x1
;      59 bit bFl;
;      60 //eeprom char delta; 
;      61 //char cnt_butS_,cnt_butR,cnt_butR_; 
;      62 //bit butR,butR_,butS_;
;      63 //flash char DF[]={0,0,10,15,20,25,30,35};
;      64 //char per_cnt/*,zan_cnt*/;
;      65 //char nn_cnt;
;      66 
;      67 //bit bDOPon;
;      68 //bit bDOPoff;
;      69 //bit bKL2;
;      70 
;      71 
;      72 bit bFL1;
;      73 bit bFL2;
;      74 //bit bM1;
;      75 //bit bM2;
;      76 
;      77 //char dop_cnt;
;      78 char led_cnt; 
_led_cnt:
	.BYTE 0x1
;      79 eeprom char del_ee;

	.ESEG
_del_ee:
	.DB  0x0
;      80 char led_del_cnt;

	.DSEG
_led_del_cnt:
	.BYTE 0x1
;      81 //unsigned long led_del_buff;
;      82 
;      83 
;      84 
;      85 char in_drv_cntA,in_drv_cntB,in_drv_cntC,in_drv_cntD;
_in_drv_cntA:
	.BYTE 0x1
_in_drv_cntB:
	.BYTE 0x1
_in_drv_cntC:
	.BYTE 0x1
_in_drv_cntD:
	.BYTE 0x1
;      86 short in_drv_cntA_block;
_in_drv_cntA_block:
	.BYTE 0x2
;      87 char in_drv_cntL,in_drv_cntR;
_in_drv_cntL:
	.BYTE 0x1
_in_drv_cntR:
	.BYTE 0x1
;      88 bit bINA,bINB,bINC,bIND;
;      89 bit bTOP_LIGHT;
;      90 bit bTUMAN;
;      91 bit bHEAD; 
;      92 bit bINL,bINR;
;      93 bit bAVAR;
;      94 short l_cnt,r_cnt;
_l_cnt:
	.BYTE 0x2
_r_cnt:
	.BYTE 0x2
;      95 //-----------------------------------------------
;      96 void t0_init(void)
;      97 {

	.CSEG
_t0_init:
;      98 TCCR0=0x03;
	LDI  R30,LOW(3)
	OUT  0x33,R30
;      99 TCNT0=-78;
	LDI  R30,LOW(178)
	OUT  0x32,R30
;     100 TIMSK|=0b00000001;
	IN   R30,0x39
	ORI  R30,1
	OUT  0x39,R30
;     101 } 
	RET
;     102 
;     103 //-----------------------------------------------
;     104 void t2_init(void)
;     105 {
_t2_init:
;     106 //TIFR|=0b01000000;
;     107 TCNT2=-97;
	LDI  R30,LOW(159)
	OUT  0x24,R30
;     108 TCCR2=0x07;
	LDI  R30,LOW(7)
	OUT  0x25,R30
;     109 OCR2=-80;
	LDI  R30,LOW(176)
	OUT  0x23,R30
;     110 TIMSK|=0b11000000;
	IN   R30,0x39
	ORI  R30,LOW(0xC0)
	OUT  0x39,R30
;     111 }  
	RET
;     112 
;     113 //-----------------------------------------------
;     114 void gran_char(signed char *adr, signed char min, signed char max)
;     115 {
;     116 if (*adr<min) *adr=min;
;     117 if (*adr>max) *adr=max; 
;     118 } 
;     119 
;     120 
;     121 
;     122 //-----------------------------------------------
;     123 void del_hndl(void)
;     124 {
;     125 } 
;     126 
;     127 
;     128 
;     129 
;     130 
;     131 
;     132 
;     133 //-----------------------------------------------
;     134 void in_drv(void)
;     135 {
_in_drv:
;     136 DDRC&=0b11111000;
	IN   R30,0x14
	ANDI R30,LOW(0xF8)
	OUT  0x14,R30
;     137 PORTC|=0b00000111; 
	IN   R30,0x15
	ORI  R30,LOW(0x7)
	OUT  0x15,R30
;     138 
;     139 DDRB&=0b11001111;
	IN   R30,0x17
	ANDI R30,LOW(0xCF)
	OUT  0x17,R30
;     140 PORTB|=0b00110000;
	IN   R30,0x18
	ORI  R30,LOW(0x30)
	OUT  0x18,R30
;     141 
;     142 DDRD&=0b11111101;
	CBI  0x11,1
;     143 PORTD|=0b00000010; 
	SBI  0x12,1
;     144 
;     145 if(PINC.1)
	SBIS 0x13,1
	RJMP _0x6
;     146 	{
;     147 	if(!in_drv_cntA_block)
	RCALL SUBOPT_0x0
	BRNE _0x7
;     148 		{
;     149 		if(in_drv_cntA<3)
	RCALL SUBOPT_0x1
	BRSH _0x8
;     150 			{
;     151 			in_drv_cntA++;
	LDS  R30,_in_drv_cntA
	SUBI R30,-LOW(1)
	STS  _in_drv_cntA,R30
;     152 			if(in_drv_cntA>=3)
	RCALL SUBOPT_0x1
	BRLO _0x9
;     153 				{
;     154 				bINA=1;
	SET
	BLD  R3,5
;     155 				in_drv_cntA_block=200;
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	STS  _in_drv_cntA_block,R30
	STS  _in_drv_cntA_block+1,R31
;     156 		    		}
;     157 		    	} 
_0x9:
;     158 		}
_0x8:
;     159 	}
_0x7:
;     160 else 
	RJMP _0xA
_0x6:
;     161 	{
;     162 	in_drv_cntA=0;
	LDI  R30,LOW(0)
	STS  _in_drv_cntA,R30
;     163 	if(in_drv_cntA_block)in_drv_cntA_block--;
	RCALL SUBOPT_0x0
	BREQ _0xB
	LDS  R30,_in_drv_cntA_block
	LDS  R31,_in_drv_cntA_block+1
	SBIW R30,1
	STS  _in_drv_cntA_block,R30
	STS  _in_drv_cntA_block+1,R31
;     164 	}
_0xB:
_0xA:
;     165 	
;     166 if(PINC.2)
	SBIS 0x13,2
	RJMP _0xC
;     167 	{
;     168 	if(in_drv_cntB<10)
	RCALL SUBOPT_0x2
	BRSH _0xD
;     169 		{
;     170 		in_drv_cntB++;
	LDS  R30,_in_drv_cntB
	SUBI R30,-LOW(1)
	STS  _in_drv_cntB,R30
;     171 		if(in_drv_cntB>=10)
	RCALL SUBOPT_0x2
	BRLO _0xE
;     172 			{
;     173 			bINB=1;
	SET
	BLD  R3,6
;     174 			} 
;     175 		}
_0xE:
;     176 	}
_0xD:
;     177 else 
	RJMP _0xF
_0xC:
;     178 	{
;     179 	in_drv_cntB=0;
	LDI  R30,LOW(0)
	STS  _in_drv_cntB,R30
;     180 	}
_0xF:
;     181 		
;     182 if(PINC.0)
	SBIS 0x13,0
	RJMP _0x10
;     183 	{
;     184 	if(in_drv_cntC<10)
	RCALL SUBOPT_0x3
	BRSH _0x11
;     185 		{
;     186 		in_drv_cntC++;
	LDS  R30,_in_drv_cntC
	SUBI R30,-LOW(1)
	STS  _in_drv_cntC,R30
;     187 		if(in_drv_cntC>=10)
	RCALL SUBOPT_0x3
	BRLO _0x12
;     188 			{
;     189 			bINC=1;
	SET
	BLD  R3,7
;     190 			} 
;     191 		}
_0x12:
;     192 	}
_0x11:
;     193 else 
	RJMP _0x13
_0x10:
;     194 	{
;     195 	in_drv_cntC=0;
	LDI  R30,LOW(0)
	STS  _in_drv_cntC,R30
;     196 	}	     
_0x13:
;     197 
;     198 if(PIND.1)
	SBIS 0x10,1
	RJMP _0x14
;     199 	{
;     200 	if(in_drv_cntD<10)
	RCALL SUBOPT_0x4
	BRSH _0x15
;     201 		{
;     202 		in_drv_cntD++;
	LDS  R30,_in_drv_cntD
	SUBI R30,-LOW(1)
	STS  _in_drv_cntD,R30
;     203 		if(in_drv_cntD>=10)
	RCALL SUBOPT_0x4
	BRLO _0x16
;     204 			{
;     205 			bIND=1;
	SET
	BLD  R4,0
;     206 			} 
;     207 		}
_0x16:
;     208 	}
_0x15:
;     209 else 
	RJMP _0x17
_0x14:
;     210 	{
;     211 	in_drv_cntD=0;
	LDI  R30,LOW(0)
	STS  _in_drv_cntD,R30
;     212 	}
_0x17:
;     213 	
;     214 if(!PINB.4)
	SBIC 0x16,4
	RJMP _0x18
;     215 	{
;     216 	if(in_drv_cntL<10)
	RCALL SUBOPT_0x5
	BRSH _0x19
;     217 		{
;     218 		in_drv_cntL++;
	LDS  R30,_in_drv_cntL
	SUBI R30,-LOW(1)
	STS  _in_drv_cntL,R30
;     219 		if(in_drv_cntL>=10)
	RCALL SUBOPT_0x5
	BRLO _0x1A
;     220 			{
;     221 			bINL=1;
	SET
	BLD  R4,4
;     222 			} 
;     223 		}
_0x1A:
;     224 	}
_0x19:
;     225 else 
	RJMP _0x1B
_0x18:
;     226 	{
;     227 	in_drv_cntL=0;
	LDI  R30,LOW(0)
	STS  _in_drv_cntL,R30
;     228 	bINL=0;
	CLT
	BLD  R4,4
;     229 	}
_0x1B:
;     230 
;     231 if(!PINB.5)
	SBIC 0x16,5
	RJMP _0x1C
;     232 	{
;     233 	if(in_drv_cntR<10)
	RCALL SUBOPT_0x6
	BRSH _0x1D
;     234 		{
;     235 		in_drv_cntR++;
	LDS  R30,_in_drv_cntR
	SUBI R30,-LOW(1)
	STS  _in_drv_cntR,R30
;     236 		if(in_drv_cntR>=10)
	RCALL SUBOPT_0x6
	BRLO _0x1E
;     237 			{
;     238 			bINR=1;
	SET
	BLD  R4,5
;     239 			} 
;     240 		}
_0x1E:
;     241 	}
_0x1D:
;     242 else 
	RJMP _0x1F
_0x1C:
;     243 	{
;     244 	in_drv_cntR=0;
	LDI  R30,LOW(0)
	STS  _in_drv_cntR,R30
;     245 	bINR=0;
	CLT
	BLD  R4,5
;     246 	}
_0x1F:
;     247 }
	RET
;     248 
;     249 
;     250 //-----------------------------------------------
;     251 void out_drv(void)
;     252 {
_out_drv:
;     253 DDRD|=0b00011101;
	IN   R30,0x11
	ORI  R30,LOW(0x1D)
	OUT  0x11,R30
;     254 DDRC|=0b00001000;
	SBI  0x14,3
;     255 
;     256 if(bTOP_LIGHT) PORTD.4=1;
	SBRS R4,1
	RJMP _0x20
	SBI  0x12,4
;     257 else PORTD.4=0;
	RJMP _0x21
_0x20:
	CBI  0x12,4
_0x21:
;     258 
;     259 if(bTUMAN) PORTD.3=1;
	SBRS R4,2
	RJMP _0x22
	SBI  0x12,3
;     260 else PORTD.3=0; 
	RJMP _0x23
_0x22:
	CBI  0x12,3
_0x23:
;     261 
;     262 if(bHEAD) PORTD.2=1;
	SBRS R4,3
	RJMP _0x24
	SBI  0x12,2
;     263 else PORTD.2=0;
	RJMP _0x25
_0x24:
	CBI  0x12,2
_0x25:
;     264 
;     265 /*if(bFL1)PORTC.3=0;
;     266 else PORTC.3=1;  
;     267 
;     268 if(bFL1)PORTD.0=0;
;     269 else PORTD.0=1;*/
;     270 
;     271 //PORTC.3=1;
;     272 //PORTD.0=1;
;     273 
;     274 /*if(bINL)PORTD.1=0;
;     275 else PORTD.1=1;
;     276 
;     277 
;     278 if(bINR) PORTD.2=0;
;     279 else PORTD.2=1; */
;     280 if(bAVAR)
	SBRS R4,6
	RJMP _0x26
;     281 	{
;     282     	if((l_cnt==0)&&(r_cnt==0))
	RCALL SUBOPT_0x7
	BRNE _0x28
	RCALL SUBOPT_0x8
	BREQ _0x29
_0x28:
	RJMP _0x27
_0x29:
;     283 		{
;     284 		l_cnt=100;
	RCALL SUBOPT_0x9
;     285 		r_cnt=100;
	RCALL SUBOPT_0xA
;     286 		}
;     287 	}
_0x27:
;     288 
;     289 
;     290 if((l_cnt==200)||(l_cnt==100))PORTC.3=0;//PORTD.1=0;
_0x26:
	LDS  R26,_l_cnt
	LDS  R27,_l_cnt+1
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BREQ _0x2B
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRNE _0x2A
_0x2B:
	CBI  0x15,3
;     291 if((l_cnt==150)||(l_cnt==50)||(l_cnt==0))PORTC.3=1;//PORTD.1=1;
_0x2A:
	LDS  R26,_l_cnt
	LDS  R27,_l_cnt+1
	CPI  R26,LOW(0x96)
	LDI  R30,HIGH(0x96)
	CPC  R27,R30
	BREQ _0x2E
	CPI  R26,LOW(0x32)
	LDI  R30,HIGH(0x32)
	CPC  R27,R30
	BREQ _0x2E
	RCALL SUBOPT_0x7
	BRNE _0x2D
_0x2E:
	SBI  0x15,3
;     292 
;     293 if((r_cnt==200)||(r_cnt==100))PORTD.0=0;//PORTD.2=0;
_0x2D:
	LDS  R26,_r_cnt
	LDS  R27,_r_cnt+1
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	BREQ _0x31
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRNE _0x30
_0x31:
	CBI  0x12,0
;     294 if((r_cnt==150)||(r_cnt==50)||(r_cnt==0))PORTD.0=1;//PORTD.2=1;
_0x30:
	LDS  R26,_r_cnt
	LDS  R27,_r_cnt+1
	CPI  R26,LOW(0x96)
	LDI  R30,HIGH(0x96)
	CPC  R27,R30
	BREQ _0x34
	CPI  R26,LOW(0x32)
	LDI  R30,HIGH(0x32)
	CPC  R27,R30
	BREQ _0x34
	RCALL SUBOPT_0x8
	BRNE _0x33
_0x34:
	SBI  0x12,0
;     295 
;     296 if(l_cnt)l_cnt--;
_0x33:
	RCALL SUBOPT_0xB
	BREQ _0x36
	LDS  R30,_l_cnt
	LDS  R31,_l_cnt+1
	SBIW R30,1
	STS  _l_cnt,R30
	STS  _l_cnt+1,R31
;     297 if(r_cnt)r_cnt--;
_0x36:
	RCALL SUBOPT_0xC
	BREQ _0x37
	LDS  R30,_r_cnt
	LDS  R31,_r_cnt+1
	SBIW R30,1
	STS  _r_cnt,R30
	STS  _r_cnt+1,R31
;     298 }
_0x37:
	RET
;     299 
;     300 //-----------------------------------------------
;     301 void in_an(void)
;     302 {
_in_an:
;     303 if(bINC)
	SBRS R3,7
	RJMP _0x38
;     304 	{
;     305 	bTOP_LIGHT=!bTOP_LIGHT;
	LDI  R30,LOW(2)
	EOR  R4,R30
;     306 	
;     307 	}
;     308  
;     309 if(bINB)
_0x38:
	SBRS R3,6
	RJMP _0x39
;     310 	{
;     311 	bTUMAN=!bTUMAN;
	LDI  R30,LOW(4)
	EOR  R4,R30
;     312 	}
;     313 
;     314 if(bINA)
_0x39:
	SBRS R3,5
	RJMP _0x3A
;     315 	{
;     316 	bHEAD=!bHEAD;
	LDI  R30,LOW(8)
	EOR  R4,R30
;     317 	}
;     318 
;     319 if(bIND)
_0x3A:
	SBRS R4,0
	RJMP _0x3B
;     320 	{
;     321 	bAVAR=!bAVAR;
	LDI  R30,LOW(64)
	EOR  R4,R30
;     322 
;     323 	}
;     324 	
;     325 if(bINL)
_0x3B:
	SBRS R4,4
	RJMP _0x3C
;     326 	{
;     327 	if((l_cnt==0)/*||(l_cnt==100)*/)l_cnt=100;
	RCALL SUBOPT_0xB
	BRNE _0x3D
	RCALL SUBOPT_0x9
;     328 	}
_0x3D:
;     329 /*if(!bINL)
;     330 	{
;     331 	if(l_cnt==100)l_cnt=0;
;     332 	}*/
;     333 
;     334 if(bINR)
_0x3C:
	SBRS R4,5
	RJMP _0x3E
;     335 	{
;     336 	if((r_cnt==0)/*||(r_cnt==100)*/)r_cnt=100;
	RCALL SUBOPT_0xC
	BRNE _0x3F
	RCALL SUBOPT_0xA
;     337 	}
_0x3F:
;     338 /*if(!bINR)
;     339 	{
;     340 	if(r_cnt==100)r_cnt=0;
;     341 	} */
;     342 				
;     343 but_an_end:
_0x3E:
;     344 bINA=0;
	CLT
	BLD  R3,5
;     345 bINB=0;
	CLT
	BLD  R3,6
;     346 bINC=0;
	CLT
	BLD  R3,7
;     347 bIND=0;
	CLT
	BLD  R4,0
;     348 //butR_=0;
;     349 //butS_=0;
;     350 }
	RET
;     351 
;     352 
;     353 
;     354 
;     355 
;     356 
;     357 
;     358 
;     359 
;     360 
;     361 
;     362 //***********************************************
;     363 //***********************************************
;     364 //***********************************************
;     365 //***********************************************
;     366 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;     367 {
_timer0_ovf_isr:
	RCALL SUBOPT_0xD
;     368 t0_init();
	RCALL _t0_init
;     369 bT0=!bT0;
	LDI  R30,LOW(1)
	EOR  R2,R30
;     370 
;     371 if(!bT0) goto lbl_000;
	SBRS R2,0
	RJMP _0x42
;     372 b100Hz=1;
	SET
	BLD  R2,1
;     373 if(++t0_cnt0>=10)
	INC  R8
	LDI  R30,LOW(10)
	CP   R8,R30
	BRLO _0x43
;     374 	{
;     375 	t0_cnt0=0;
	CLR  R8
;     376 	b10Hz=1;
	SET
	BLD  R2,2
;     377 	bFl=!bFl;
	LDI  R30,LOW(4)
	EOR  R3,R30
;     378      if(++led_cnt>=16) led_cnt=0;
	LDS  R26,_led_cnt
	SUBI R26,-LOW(1)
	STS  _led_cnt,R26
	CPI  R26,LOW(0x10)
	BRLO _0x44
	LDI  R30,LOW(0)
	STS  _led_cnt,R30
;     379 	} 
_0x44:
;     380 if(++t0_cnt1>=20)
_0x43:
	INC  R9
	LDI  R30,LOW(20)
	CP   R9,R30
	BRLO _0x45
;     381 	{
;     382 	t0_cnt1=0;
	CLR  R9
;     383 	b5Hz=1;
	SET
	BLD  R2,3
;     384 
;     385 
;     386 	}
;     387 if(++t0_cnt2>=50)
_0x45:
	INC  R10
	LDI  R30,LOW(50)
	CP   R10,R30
	BRLO _0x46
;     388 	{
;     389 	t0_cnt2=0;
	CLR  R10
;     390 	b2Hz=1;
	SET
	BLD  R2,4
;     391 			  	bFL1=!bFL1;
	LDI  R30,LOW(8)
	EOR  R3,R30
;     392 	  	if(!bFL1)
	SBRC R3,3
	RJMP _0x47
;     393 	  		{
;     394 	  		bFL2=!bFL2;
	LDI  R30,LOW(16)
	EOR  R3,R30
;     395 	  		}
;     396 	}	
_0x47:
;     397 		
;     398 if(++t0_cnt3>=100)
_0x46:
	INC  R11
	LDI  R30,LOW(100)
	CP   R11,R30
	BRLO _0x48
;     399 	{
;     400 	t0_cnt3=0;
	CLR  R11
;     401 	b1Hz=1;
	SET
	BLD  R2,5
;     402 	}		
;     403 lbl_000:
_0x48:
_0x42:
;     404 }
	RCALL SUBOPT_0xE
	RETI
;     405 
;     406 //-----------------------------------------------
;     407 // Timer 2 output compare interrupt service routine
;     408 interrupt [TIM2_OVF] void timer2_ovf_isr(void)
;     409 {
_timer2_ovf_isr:
	RCALL SUBOPT_0xD
;     410 t2_init();
	RCALL _t2_init
;     411 
;     412 
;     413 
;     414 }
	RCALL SUBOPT_0xE
	RETI
;     415 
;     416 //-----------------------------------------------
;     417 // Timer 2 output compare interrupt service routine
;     418 interrupt [TIM2_COMP] void timer2_comp_isr(void)
;     419 {
_timer2_comp_isr:
;     420 
;     421 	
;     422 
;     423 } 
	RETI
;     424 
;     425 
;     426 //-----------------------------------------------
;     427 //#pragma savereg-
;     428 interrupt [ADC_INT] void adc_isr(void)
;     429 {
_adc_isr:
	ST   -Y,R30
	ST   -Y,R31
;     430 
;     431 register static unsigned char input_index=0;

	.DSEG
_input_index_SA:
	.BYTE 0x1

	.CSEG
;     432 // Read the AD conversion result
;     433 adc_data=ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	STS  _adc_data,R30
	STS  _adc_data+1,R31
;     434 
;     435 
;     436 #asm("sei")
	sei
;     437 }
	LD   R31,Y+
	LD   R30,Y+
	RETI
;     438 
;     439 //===============================================
;     440 //===============================================
;     441 //===============================================
;     442 //===============================================
;     443 void main(void)
;     444 {
_main:
;     445 
;     446 ASSR=0;
	LDI  R30,LOW(0)
	OUT  0x22,R30
;     447 OCR2=0;
	OUT  0x23,R30
;     448 
;     449 // ADC initialization
;     450 
;     451 ADMUX=0b01000011;
	LDI  R30,LOW(67)
	OUT  0x7,R30
;     452 ADCSRA=0xCC;
	LDI  R30,LOW(204)
	OUT  0x6,R30
;     453 
;     454 t0_init();
	RCALL _t0_init
;     455 //t2_init(); 
;     456 //del_init();
;     457 #asm("sei")
	sei
;     458 
;     459 ind=iMn;
	LDI  R30,LOW(0)
	STS  _ind,R30
;     460 
;     461 while (1)
_0x49:
;     462 	{
;     463 	//DDRC.3=1; 
;     464 	//PORTC.3=0; 
;     465     //	DDRD.0=1;
;     466 	//PORTD.0=0;
;     467 	if(b100Hz)
	SBRS R2,1
	RJMP _0x4C
;     468 		{
;     469 		b100Hz=0;
	CLT
	BLD  R2,1
;     470           out_drv();
	RCALL _out_drv
;     471 		in_drv();
	RCALL _in_drv
;     472 		in_an();
	RCALL _in_an
;     473 		}   
;     474 	if(b10Hz)
_0x4C:
	SBRS R2,2
	RJMP _0x4D
;     475 		{
;     476 		b10Hz=0;
	CLT
	BLD  R2,2
;     477 		}
;     478 	if(b5Hz)
_0x4D:
	SBRS R2,3
	RJMP _0x4E
;     479 		{
;     480 		b5Hz=0;
	CLT
	BLD  R2,3
;     481 	  	 
;     482 		//deltas=delta;
;     483 								
;     484 		}
;     485 	if(b2Hz)
_0x4E:
	SBRS R2,4
	RJMP _0x4F
;     486 		{
;     487 		b2Hz=0;
	CLT
	BLD  R2,4
;     488 		//bHEAD=!bHEAD;
;     489 		}		 
;     490     	if(b1Hz)
_0x4F:
	SBRS R2,5
	RJMP _0x50
;     491 		{
;     492 		b1Hz=0;
	CLT
	BLD  R2,5
;     493 		//del_hndl();
;     494 		DDRD.4=1;
	SBI  0x11,4
;     495 		DDRD.3=1;
	SBI  0x11,3
;     496 		//PORTD.3=!PORTD.3;
;     497 		//PORTD.4=!PORTD.4; 
;     498 		}
;     499      #asm("wdr")	
_0x50:
	wdr
;     500 	}
	RJMP _0x49
;     501 }
_0x51:
	RJMP _0x51

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x0:
	LDS  R30,_in_drv_cntA_block
	LDS  R31,_in_drv_cntA_block+1
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1:
	LDS  R26,_in_drv_cntA
	CPI  R26,LOW(0x3)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2:
	LDS  R26,_in_drv_cntB
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3:
	LDS  R26,_in_drv_cntC
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4:
	LDS  R26,_in_drv_cntD
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5:
	LDS  R26,_in_drv_cntL
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6:
	LDS  R26,_in_drv_cntR
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7:
	LDS  R26,_l_cnt
	LDS  R27,_l_cnt+1
	RCALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x8:
	LDS  R26,_r_cnt
	LDS  R27,_r_cnt+1
	RCALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x9:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	STS  _l_cnt,R30
	STS  _l_cnt+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	STS  _r_cnt,R30
	STS  _r_cnt+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB:
	LDS  R30,_l_cnt
	LDS  R31,_l_cnt+1
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xC:
	LDS  R30,_r_cnt
	LDS  R31,_r_cnt+1
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xE:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

