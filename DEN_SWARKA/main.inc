	.DEF _ind_cnt=R4
_STROB:
	.DB  0xEF,0xDF
_DIGISYM:
	.DB  0x30,0xFC,0x16,0x94,0xD8,0x91,0x11,0xF4
	.DB  0x10,0x90,0xFF,0xFF,0xFF,0xFF
_3:
	.DB  0x94,0xD8
	.DEF _plazma_plazma=R5

;GPIOR0-GPIOR2 INITIALIZATION
	.EQU  __GPIOR0_INIT=0x00
	.EQU  __GPIOR1_INIT=0x00
	.EQU  __GPIOR2_INIT=0x00

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  _ind_out
	.DW  _3*2

	.DW  0
