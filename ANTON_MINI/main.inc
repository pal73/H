	.DEF _t0_cnt0=R8
	.DEF _t0_cnt1=R9
	.DEF _t0_cnt2=R10
	.DEF _t0_cnt3=R11
	.DEF _t0_cnt4=R12
	.DEF _flags=R13
	.DEF _deltas=R14
_3:
	.DW  0x19

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  _cher_cnt
	.DW  _3*2

	.DW  0
