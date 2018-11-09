   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2173                     	bsct
2174  0000               _addr7r:
2175  0000 91            	dc.b	145
2176  0001               _addr7w:
2177  0001 90            	dc.b	144
2206                     ; 25 void i2c_setup(){
2208                     	switch	.text
2209  0000               _i2c_setup:
2213                     ; 27 	GPIOB->ODR|=(1<<5);		//PORT(I2C_SDA_PORT, ODR) |= I2C_SDA_PIN; // set to 1
2215  0000 721a5005      	bset	20485,#5
2216                     ; 28 	GPIOC->ODR|=(1<<7);		//PORT(I2C_SCL_PORT, ODR) |= I2C_SCL_PIN;
2218  0004 721e500a      	bset	20490,#7
2219                     ; 29 	GPIOB->DDR|=(1<<5);		//PORT(I2C_SDA_PORT, DDR) |= I2C_SDA_PIN;
2221  0008 721a5007      	bset	20487,#5
2222                     ; 30 	GPIOC->DDR|=(1<<7);		//PORT(I2C_SCL_PORT, DDR) |= I2C_SCL_PIN;
2224  000c 721e500c      	bset	20492,#7
2225                     ; 31 	GPIOB->CR2|=(1<<5);		//PORT(I2C_SDA_PORT, CR2) |= I2C_SDA_PIN;
2227  0010 721a5009      	bset	20489,#5
2228                     ; 32 	GPIOC->CR2|=(1<<7);		//PORT(I2C_SCL_PORT, CR2) |= I2C_SCL_PIN;
2230  0014 721e500e      	bset	20494,#7
2231                     ; 33 }
2234  0018 81            	ret
2270                     ; 35 void i2c_set_addr7(char addr){
2271                     	switch	.text
2272  0019               _i2c_set_addr7:
2276                     ; 36 	addr7w = addr << 1;
2278  0019 48            	sll	a
2279  001a b701          	ld	_addr7w,a
2280                     ; 37 	addr7r = addr7w | 1;
2282  001c b601          	ld	a,_addr7w
2283  001e aa01          	or	a,#1
2284  0020 b700          	ld	_addr7r,a
2285                     ; 38 }
2288  0022 81            	ret
2343                     ; 40 void SoftStart(){
2344                     	switch	.text
2345  0023               _SoftStart:
2347  0023 88            	push	a
2348       00000001      OFST:	set	1
2351                     ; 41 	H_SCL;
2353  0024 721e500a      	bset	20490,#7
2355  0028 0f01          	clr	(OFST+0,sp)
2356  002a               L5051:
2357                     ; 42 	H_DEL;
2360  002a 9d            nop
2365  002b 0c01          	inc	(OFST+0,sp)
2368  002d 7b01          	ld	a,(OFST+0,sp)
2369  002f a11e          	cp	a,#30
2370  0031 25f7          	jrult	L5051
2371                     ; 43 	L_SDA;
2374  0033 721b5005      	bres	20485,#5
2376  0037 0f01          	clr	(OFST+0,sp)
2377  0039               L3151:
2378                     ; 44 	H_DEL;
2381  0039 9d            nop
2386  003a 0c01          	inc	(OFST+0,sp)
2389  003c 7b01          	ld	a,(OFST+0,sp)
2390  003e a11e          	cp	a,#30
2391  0040 25f7          	jrult	L3151
2392                     ; 45 	L_SCL;
2395  0042 721f500a      	bres	20490,#7
2397  0046 0f01          	clr	(OFST+0,sp)
2398  0048               L1251:
2399                     ; 46 	H_DEL;
2402  0048 9d            nop
2407  0049 0c01          	inc	(OFST+0,sp)
2410  004b 7b01          	ld	a,(OFST+0,sp)
2411  004d a11e          	cp	a,#30
2412  004f 25f7          	jrult	L1251
2413                     ; 47 }
2417  0051 84            	pop	a
2418  0052 81            	ret
2463                     ; 49 void SoftStop(){
2464                     	switch	.text
2465  0053               _SoftStop:
2467  0053 88            	push	a
2468       00000001      OFST:	set	1
2471                     ; 50 	L_SDA;
2473  0054 721b5005      	bres	20485,#5
2474                     ; 51 	L_SCL;
2476  0058 721f500a      	bres	20490,#7
2478  005c 0f01          	clr	(OFST+0,sp)
2479  005e               L1551:
2480                     ; 52 	H_DEL;
2483  005e 9d            nop
2488  005f 0c01          	inc	(OFST+0,sp)
2491  0061 7b01          	ld	a,(OFST+0,sp)
2492  0063 a11e          	cp	a,#30
2493  0065 25f7          	jrult	L1551
2494                     ; 53 	H_SCL;
2497  0067 721e500a      	bset	20490,#7
2499  006b 0f01          	clr	(OFST+0,sp)
2500  006d               L7551:
2501                     ; 54 	H_DEL;
2504  006d 9d            nop
2509  006e 0c01          	inc	(OFST+0,sp)
2512  0070 7b01          	ld	a,(OFST+0,sp)
2513  0072 a11e          	cp	a,#30
2514  0074 25f7          	jrult	L7551
2515                     ; 55 	H_SDA;
2518  0076 721a5005      	bset	20485,#5
2519                     ; 56 }
2522  007a 84            	pop	a
2523  007b 81            	ret
2606                     ; 61 char softi2c_send(char data)
2606                     ; 62 	{
2607                     	switch	.text
2608  007c               _softi2c_send:
2610  007c 88            	push	a
2611  007d 89            	pushw	x
2612       00000002      OFST:	set	2
2615                     ; 64 	for(i=0; i < 8; i++)
2617  007e 0f02          	clr	(OFST+0,sp)
2618  0080               L7261:
2619                     ; 66 		L_SCL;
2621  0080 721f500a      	bres	20490,#7
2622                     ; 67 		if(data & 0x80)
2624  0084 7b03          	ld	a,(OFST+1,sp)
2625  0086 a580          	bcp	a,#128
2626  0088 2706          	jreq	L5361
2627                     ; 68 			H_SDA;
2629  008a 721a5005      	bset	20485,#5
2631  008e 2004          	jra	L7361
2632  0090               L5361:
2633                     ; 70 			L_SDA;
2635  0090 721b5005      	bres	20485,#5
2636  0094               L7361:
2638  0094 0f01          	clr	(OFST-1,sp)
2639  0096               L1461:
2640                     ; 71 		H_DEL;
2643  0096 9d            nop
2648  0097 0c01          	inc	(OFST-1,sp)
2651  0099 7b01          	ld	a,(OFST-1,sp)
2652  009b a11e          	cp	a,#30
2653  009d 25f7          	jrult	L1461
2654                     ; 72 		H_SCL;
2657  009f 721e500a      	bset	20490,#7
2659  00a3 0f01          	clr	(OFST-1,sp)
2660  00a5               L7461:
2661                     ; 73 		H_DEL;
2664  00a5 9d            nop
2669  00a6 0c01          	inc	(OFST-1,sp)
2672  00a8 7b01          	ld	a,(OFST-1,sp)
2673  00aa a11e          	cp	a,#30
2674  00ac 25f7          	jrult	L7461
2675                     ; 74 		data <<= 1;
2678  00ae 0803          	sll	(OFST+1,sp)
2679                     ; 64 	for(i=0; i < 8; i++)
2681  00b0 0c02          	inc	(OFST+0,sp)
2684  00b2 7b02          	ld	a,(OFST+0,sp)
2685  00b4 a108          	cp	a,#8
2686  00b6 25c8          	jrult	L7261
2687                     ; 77 	L_SCL;
2689  00b8 721f500a      	bres	20490,#7
2690                     ; 78 	H_SDA;
2692  00bc 721a5005      	bset	20485,#5
2694  00c0 0f02          	clr	(OFST+0,sp)
2695  00c2               L5561:
2696                     ; 79 	H_DEL;
2699  00c2 9d            nop
2704  00c3 0c02          	inc	(OFST+0,sp)
2707  00c5 7b02          	ld	a,(OFST+0,sp)
2708  00c7 a11e          	cp	a,#30
2709  00c9 25f7          	jrult	L5561
2710                     ; 80 	H_SCL;
2713  00cb 721e500a      	bset	20490,#7
2715  00cf 0f02          	clr	(OFST+0,sp)
2716  00d1               L3661:
2717                     ; 81 	Q_DEL;
2720  00d1 9d            nop
2725  00d2 0c02          	inc	(OFST+0,sp)
2728  00d4 7b02          	ld	a,(OFST+0,sp)
2729  00d6 a10f          	cp	a,#15
2730  00d8 25f7          	jrult	L3661
2731                     ; 82 	i = !(CHK_SDA);
2734  00da c65006        	ld	a,20486
2735  00dd a520          	bcp	a,#32
2736  00df 2604          	jrne	L61
2737  00e1 a601          	ld	a,#1
2738  00e3 2001          	jra	L02
2739  00e5               L61:
2740  00e5 4f            	clr	a
2741  00e6               L02:
2742  00e6 6b02          	ld	(OFST+0,sp),a
2743                     ; 84 	L_SCL;
2745  00e8 721f500a      	bres	20490,#7
2746                     ; 86 	return i;
2748  00ec 7b02          	ld	a,(OFST+0,sp)
2751  00ee 5b03          	addw	sp,#3
2752  00f0 81            	ret
2844                     ; 91 char softi2c_receive(char ack)
2844                     ; 92 	{
2845                     	switch	.text
2846  00f1               _softi2c_receive:
2848  00f1 88            	push	a
2849  00f2 5203          	subw	sp,#3
2850       00000003      OFST:	set	3
2853                     ; 93 	char data = 0, i;
2855  00f4 0f02          	clr	(OFST-1,sp)
2856                     ; 94 	for(i=0; i<8; i++)
2858  00f6 0f03          	clr	(OFST+0,sp)
2859  00f8               L7371:
2860                     ; 96 		data <<= 1;
2862  00f8 0802          	sll	(OFST-1,sp)
2863                     ; 97 		L_SCL;
2865  00fa 721f500a      	bres	20490,#7
2867  00fe 0f01          	clr	(OFST-2,sp)
2868  0100               L5471:
2869                     ; 98 		H_DEL;
2872  0100 9d            nop
2877  0101 0c01          	inc	(OFST-2,sp)
2880  0103 7b01          	ld	a,(OFST-2,sp)
2881  0105 a11e          	cp	a,#30
2882  0107 25f7          	jrult	L5471
2883                     ; 99 		H_SCL;
2886  0109 721e500a      	bset	20490,#7
2887                     ; 100 		if(CHK_SDA) data |= 1;
2889  010d c65006        	ld	a,20486
2890  0110 a520          	bcp	a,#32
2891  0112 2706          	jreq	L3571
2894  0114 7b02          	ld	a,(OFST-1,sp)
2895  0116 aa01          	or	a,#1
2896  0118 6b02          	ld	(OFST-1,sp),a
2897  011a               L3571:
2899  011a 0f01          	clr	(OFST-2,sp)
2900  011c               L5571:
2901                     ; 101 		H_DEL;
2904  011c 9d            nop
2909  011d 0c01          	inc	(OFST-2,sp)
2912  011f 7b01          	ld	a,(OFST-2,sp)
2913  0121 a11e          	cp	a,#30
2914  0123 25f7          	jrult	L5571
2915                     ; 94 	for(i=0; i<8; i++)
2918  0125 0c03          	inc	(OFST+0,sp)
2921  0127 7b03          	ld	a,(OFST+0,sp)
2922  0129 a108          	cp	a,#8
2923  012b 25cb          	jrult	L7371
2924                     ; 105 	L_SCL;
2926  012d 721f500a      	bres	20490,#7
2927                     ; 106 	if(ack) L_SDA;
2929  0131 0d04          	tnz	(OFST+1,sp)
2930  0133 2706          	jreq	L3671
2933  0135 721b5005      	bres	20485,#5
2935  0139 2004          	jra	L5671
2936  013b               L3671:
2937                     ; 107 	else H_SDA;
2939  013b 721a5005      	bset	20485,#5
2940  013f               L5671:
2942  013f 0f03          	clr	(OFST+0,sp)
2943  0141               L7671:
2944                     ; 108 	H_DEL;
2947  0141 9d            nop
2952  0142 0c03          	inc	(OFST+0,sp)
2955  0144 7b03          	ld	a,(OFST+0,sp)
2956  0146 a11e          	cp	a,#30
2957  0148 25f7          	jrult	L7671
2958                     ; 109 	H_SCL;
2961  014a 721e500a      	bset	20490,#7
2963  014e 0f03          	clr	(OFST+0,sp)
2964  0150               L5771:
2965                     ; 110 	H_DEL;
2968  0150 9d            nop
2973  0151 0c03          	inc	(OFST+0,sp)
2976  0153 7b03          	ld	a,(OFST+0,sp)
2977  0155 a11e          	cp	a,#30
2978  0157 25f7          	jrult	L5771
2979                     ; 111 	L_SCL;
2982  0159 721f500a      	bres	20490,#7
2983                     ; 112 	H_SDA;
2985  015d 721a5005      	bset	20485,#5
2986                     ; 113 	return data;
2988  0161 7b02          	ld	a,(OFST-1,sp)
2991  0163 5b04          	addw	sp,#4
2992  0165 81            	ret
3108                     ; 122 i2c_status i2c_7bit_send_onebyte(char data, char stop){
3109                     	switch	.text
3110  0166               _i2c_7bit_send_onebyte:
3112  0166 89            	pushw	x
3113  0167 89            	pushw	x
3114       00000002      OFST:	set	2
3117                     ; 123 	i2c_status ret = I2C_LINEBUSY;
3119  0168 a601          	ld	a,#1
3120  016a 6b02          	ld	(OFST+0,sp),a
3121                     ; 124 	char err = 1;
3123  016c a601          	ld	a,#1
3124  016e 6b01          	ld	(OFST-1,sp),a
3125                     ; 125 	H_SCL; H_SDA;
3127  0170 721e500a      	bset	20490,#7
3130  0174 721a5005      	bset	20485,#5
3131                     ; 126 	if(!CHK_SDA || !CHK_SCL) goto eotr;
3133  0178 c65006        	ld	a,20486
3134  017b a520          	bcp	a,#32
3135  017d 2722          	jreq	L3002
3137  017f c6500b        	ld	a,20491
3138  0182 a580          	bcp	a,#128
3139  0184 271b          	jreq	L3002
3140                     ; 127 	SoftStart();
3142  0186 cd0023        	call	_SoftStart
3144                     ; 128 	ret = I2C_NACK;
3146  0189 a604          	ld	a,#4
3147  018b 6b02          	ld	(OFST+0,sp),a
3148                     ; 129 	if(!softi2c_send(addr7w)) goto eotr;
3150  018d b601          	ld	a,_addr7w
3151  018f cd007c        	call	_softi2c_send
3153  0192 4d            	tnz	a
3154  0193 270c          	jreq	L3002
3157                     ; 130 	if(softi2c_send(data)){
3159  0195 7b03          	ld	a,(OFST+1,sp)
3160  0197 cd007c        	call	_softi2c_send
3162  019a 4d            	tnz	a
3163  019b 2704          	jreq	L3002
3164                     ; 131 		ret = I2C_OK;
3166  019d 0f02          	clr	(OFST+0,sp)
3167                     ; 132 		err = 0;
3169  019f 0f01          	clr	(OFST-1,sp)
3170  01a1               L3002:
3171                     ; 134 eotr:
3171                     ; 135 	if(stop || err){
3173  01a1 0d04          	tnz	(OFST+2,sp)
3174  01a3 2604          	jrne	L1702
3176  01a5 0d01          	tnz	(OFST-1,sp)
3177  01a7 2703          	jreq	L7602
3178  01a9               L1702:
3179                     ; 136 		SoftStop();
3181  01a9 cd0053        	call	_SoftStop
3183  01ac               L7602:
3184                     ; 138 	return ret;
3186  01ac 7b02          	ld	a,(OFST+0,sp)
3189  01ae 5b04          	addw	sp,#4
3190  01b0 81            	ret
3267                     ; 148 i2c_status i2c_7bit_send(char *data, char datalen, char stop){
3268                     	switch	.text
3269  01b1               _i2c_7bit_send:
3271  01b1 89            	pushw	x
3272  01b2 89            	pushw	x
3273       00000002      OFST:	set	2
3276                     ; 149 	i2c_status ret = I2C_LINEBUSY;
3278                     ; 150 	char err = 1;
3280  01b3 a601          	ld	a,#1
3281  01b5 6b02          	ld	(OFST+0,sp),a
3282                     ; 151 	H_SCL; H_SDA;
3284  01b7 721e500a      	bset	20490,#7
3287  01bb 721a5005      	bset	20485,#5
3288                     ; 152 	if(!CHK_SDA || !CHK_SCL) goto eotr;
3290  01bf c65006        	ld	a,20486
3291  01c2 a520          	bcp	a,#32
3292  01c4 272e          	jreq	L3702
3294  01c6 c6500b        	ld	a,20491
3295  01c9 a580          	bcp	a,#128
3296  01cb 2727          	jreq	L3702
3297                     ; 153 	SoftStart();
3299  01cd cd0023        	call	_SoftStart
3301                     ; 154 	ret = I2C_NACK;
3303                     ; 155 	if(!softi2c_send(addr7w)) goto eotr;
3305  01d0 b601          	ld	a,_addr7w
3306  01d2 cd007c        	call	_softi2c_send
3308  01d5 4d            	tnz	a
3309  01d6 2613          	jrne	L3412
3312  01d8 201a          	jra	L3702
3313  01da               L1412:
3314                     ; 157 		if(!softi2c_send(*data++)) goto eotr;
3316  01da 1e03          	ldw	x,(OFST+1,sp)
3317  01dc 1c0001        	addw	x,#1
3318  01df 1f03          	ldw	(OFST+1,sp),x
3319  01e1 1d0001        	subw	x,#1
3320  01e4 f6            	ld	a,(x)
3321  01e5 cd007c        	call	_softi2c_send
3323  01e8 4d            	tnz	a
3324  01e9 2709          	jreq	L3702
3327  01eb               L3412:
3328                     ; 156 	while(datalen--){
3330  01eb 7b07          	ld	a,(OFST+5,sp)
3331  01ed 0a07          	dec	(OFST+5,sp)
3332  01ef 4d            	tnz	a
3333  01f0 26e8          	jrne	L1412
3334                     ; 159 	ret = I2C_OK;
3336                     ; 160 	err = 0;
3338  01f2 0f02          	clr	(OFST+0,sp)
3339  01f4               L3702:
3340                     ; 161 eotr:
3340                     ; 162 	if(stop || err){
3342  01f4 0d08          	tnz	(OFST+6,sp)
3343  01f6 2604          	jrne	L3512
3345  01f8 0d02          	tnz	(OFST+0,sp)
3346  01fa 2703          	jreq	L1512
3347  01fc               L3512:
3348                     ; 163 		SoftStop();
3350  01fc cd0053        	call	_SoftStop
3352  01ff               L1512:
3353                     ; 165 	return I2C_OK;
3355  01ff 4f            	clr	a
3358  0200 5b04          	addw	sp,#4
3359  0202 81            	ret
3411                     ; 174 i2c_status i2c_7bit_receive_onebyte(char *data)
3411                     ; 175 {
3412                     	switch	.text
3413  0203               _i2c_7bit_receive_onebyte:
3415  0203 89            	pushw	x
3416  0204 88            	push	a
3417       00000001      OFST:	set	1
3420                     ; 176 	i2c_status ret = I2C_NACK;
3422  0205 a604          	ld	a,#4
3423  0207 6b01          	ld	(OFST+0,sp),a
3424                     ; 177 	H_SCL; H_SDA;
3426  0209 721e500a      	bset	20490,#7
3429  020d 721a5005      	bset	20485,#5
3430                     ; 178 	if(!CHK_SDA || !CHK_SCL){
3432  0211 c65006        	ld	a,20486
3433  0214 a520          	bcp	a,#32
3434  0216 2707          	jreq	L3022
3436  0218 c6500b        	ld	a,20491
3437  021b a580          	bcp	a,#128
3438  021d 260c          	jrne	L1022
3439  021f               L3022:
3440                     ; 179 		ret = I2C_LINEBUSY;
3442  021f a601          	ld	a,#1
3443  0221 6b01          	ld	(OFST+0,sp),a
3444                     ; 180 		goto eotr;
3445  0223               L5512:
3446                     ; 186 eotr:
3446                     ; 187 	SoftStop();
3448  0223 cd0053        	call	_SoftStop
3450                     ; 188 	return ret;
3452  0226 7b01          	ld	a,(OFST+0,sp)
3455  0228 5b03          	addw	sp,#3
3456  022a 81            	ret
3457  022b               L1022:
3458                     ; 182 	SoftStart();
3460  022b cd0023        	call	_SoftStart
3462                     ; 183 	if(!softi2c_send(addr7r)) goto eotr;
3464  022e b600          	ld	a,_addr7r
3465  0230 cd007c        	call	_softi2c_send
3467  0233 4d            	tnz	a
3468  0234 27ed          	jreq	L5512
3471                     ; 184 	*data = softi2c_receive(0);
3473  0236 4f            	clr	a
3474  0237 cd00f1        	call	_softi2c_receive
3476  023a 1e02          	ldw	x,(OFST+1,sp)
3477  023c f7            	ld	(x),a
3478                     ; 185 	ret = I2C_OK;
3480  023d 0f01          	clr	(OFST+0,sp)
3481  023f 20e2          	jra	L5512
3542                     ; 197 i2c_status i2c_7bit_receive_twobyte(char *data, char wait){
3543                     	switch	.text
3544  0241               _i2c_7bit_receive_twobyte:
3546  0241 89            	pushw	x
3547  0242 88            	push	a
3548       00000001      OFST:	set	1
3551                     ; 198 	i2c_status ret = I2C_NACK;
3553  0243 a604          	ld	a,#4
3554  0245 6b01          	ld	(OFST+0,sp),a
3555                     ; 199 	H_SCL; H_SDA;
3557  0247 721e500a      	bset	20490,#7
3560  024b 721a5005      	bset	20485,#5
3561                     ; 200 	(void) wait;
3563                     ; 201 	if(!CHK_SDA || !CHK_SCL){
3565  024f c65006        	ld	a,20486
3566  0252 a520          	bcp	a,#32
3567  0254 2707          	jreq	L1422
3569  0256 c6500b        	ld	a,20491
3570  0259 a580          	bcp	a,#128
3571  025b 260c          	jrne	L7322
3572  025d               L1422:
3573                     ; 202 		ret = I2C_LINEBUSY;
3575  025d a601          	ld	a,#1
3576  025f 6b01          	ld	(OFST+0,sp),a
3577                     ; 203 		goto eotr;
3578  0261               L7022:
3579                     ; 210 eotr:
3579                     ; 211 	SoftStop();
3581  0261 cd0053        	call	_SoftStop
3583                     ; 212 	return ret;
3585  0264 7b01          	ld	a,(OFST+0,sp)
3588  0266 5b03          	addw	sp,#3
3589  0268 81            	ret
3590  0269               L7322:
3591                     ; 205 	SoftStart();
3593  0269 cd0023        	call	_SoftStart
3595                     ; 206 	if(!softi2c_send(addr7r)) goto eotr;
3597  026c b600          	ld	a,_addr7r
3598  026e cd007c        	call	_softi2c_send
3600  0271 4d            	tnz	a
3601  0272 27ed          	jreq	L7022
3604                     ; 207 	data[0] = softi2c_receive(1);
3606  0274 a601          	ld	a,#1
3607  0276 cd00f1        	call	_softi2c_receive
3609  0279 1e02          	ldw	x,(OFST+1,sp)
3610  027b f7            	ld	(x),a
3611                     ; 208 	data[1] = softi2c_receive(0);
3613  027c 4f            	clr	a
3614  027d cd00f1        	call	_softi2c_receive
3616  0280 1e02          	ldw	x,(OFST+1,sp)
3617  0282 e701          	ld	(1,x),a
3618                     ; 209 	ret = I2C_OK;
3620  0284 0f01          	clr	(OFST+0,sp)
3621  0286 20d9          	jra	L7022
3654                     	xdef	_softi2c_receive
3655                     	xdef	_softi2c_send
3656                     	xdef	_i2c_set_addr7
3657                     	xdef	_addr7w
3658                     	xdef	_addr7r
3659                     	xdef	_i2c_7bit_send
3660                     	xdef	_i2c_7bit_receive_twobyte
3661                     	xdef	_i2c_7bit_receive_onebyte
3662                     	xdef	_i2c_7bit_send_onebyte
3663                     	xdef	_SoftStop
3664                     	xdef	_SoftStart
3665                     	xdef	_i2c_setup
3684                     	end
