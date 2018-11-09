   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2173                     	switch	.data
2174  0000               _b100Hz:
2175  0000 00            	dc.b	0
2176  0001               _b10Hz:
2177  0001 00            	dc.b	0
2178  0002               _b5Hz:
2179  0002 00            	dc.b	0
2180  0003               _b1Hz:
2181  0003 00            	dc.b	0
2182  0004               L3241_t0_cnt0:
2183  0004 00            	dc.b	0
2184  0005               L5241_t0_cnt1:
2185  0005 00            	dc.b	0
2186  0006               L7241_t0_cnt2:
2187  0006 00            	dc.b	0
2188  0007               L1341_t0_cnt3:
2189  0007 00            	dc.b	0
2190                     	bsct
2191  0000               _airSensorErrorStat:
2192  0000 55            	dc.b	85
2193                     	switch	.data
2194  0008               _tx_buffer:
2195  0008 00            	dc.b	0
2196  0009 000000000000  	ds.b	29
2197                     	bsct
2198  0001               _temperdeb:
2199  0001 04d2          	dc.w	1234
2228                     ; 54 void t4_init(void)
2228                     ; 55 {
2230                     	switch	.text
2231  0000               _t4_init:
2235                     ; 56 TIM4->PSCR = 3;
2237  0000 35035347      	mov	21319,#3
2238                     ; 57 TIM4->ARR= 158;
2240  0004 359e5348      	mov	21320,#158
2241                     ; 58 TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2243  0008 72105343      	bset	21315,#0
2244                     ; 60 TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2246  000c 35855340      	mov	21312,#133
2247                     ; 62 }
2250  0010 81            	ret
2286                     ; 65 char wire1_w1ts(void)
2286                     ; 66 {
2287                     	switch	.text
2288  0011               _wire1_w1ts:
2290  0011 89            	pushw	x
2291       00000002      OFST:	set	2
2294                     ; 68 GPIOC->DDR|=(1<<7);
2296  0012 721e500c      	bset	20492,#7
2297                     ; 69 GPIOC->ODR&=~(1<<7);
2299  0016 721f500a      	bres	20490,#7
2300                     ; 72 for(i=0;i<10;i++)
2302  001a 5f            	clrw	x
2303  001b 1f01          	ldw	(OFST-1,sp),x
2304  001d               L7641:
2305                     ; 74 	__nop();
2308  001d 9d            nop
2310                     ; 72 for(i=0;i<10;i++)
2312  001e 1e01          	ldw	x,(OFST-1,sp)
2313  0020 1c0001        	addw	x,#1
2314  0023 1f01          	ldw	(OFST-1,sp),x
2317  0025 9c            	rvf
2318  0026 1e01          	ldw	x,(OFST-1,sp)
2319  0028 a3000a        	cpw	x,#10
2320  002b 2ff0          	jrslt	L7641
2321                     ; 76 GPIOC->ODR|=(1<<7);
2323  002d 721e500a      	bset	20490,#7
2324                     ; 79 for(i=0;i<90;i++)
2326  0031 5f            	clrw	x
2327  0032 1f01          	ldw	(OFST-1,sp),x
2328  0034               L5741:
2329                     ; 81 	__nop();
2332  0034 9d            nop
2334                     ; 79 for(i=0;i<90;i++)
2336  0035 1e01          	ldw	x,(OFST-1,sp)
2337  0037 1c0001        	addw	x,#1
2338  003a 1f01          	ldw	(OFST-1,sp),x
2341  003c 9c            	rvf
2342  003d 1e01          	ldw	x,(OFST-1,sp)
2343  003f a3005a        	cpw	x,#90
2344  0042 2ff0          	jrslt	L5741
2345                     ; 83 }
2348  0044 85            	popw	x
2349  0045 81            	ret
2385                     ; 86 char wire1_w0ts(void)
2385                     ; 87 {
2386                     	switch	.text
2387  0046               _wire1_w0ts:
2389  0046 89            	pushw	x
2390       00000002      OFST:	set	2
2393                     ; 89 GPIOC->DDR|=(1<<7);
2395  0047 721e500c      	bset	20492,#7
2396                     ; 90 GPIOC->ODR&=~(1<<7);
2398  004b 721f500a      	bres	20490,#7
2399                     ; 93 for(i=0;i<90;i++)
2401  004f 5f            	clrw	x
2402  0050 1f01          	ldw	(OFST-1,sp),x
2403  0052               L1251:
2404                     ; 95 	__nop();
2407  0052 9d            nop
2409                     ; 93 for(i=0;i<90;i++)
2411  0053 1e01          	ldw	x,(OFST-1,sp)
2412  0055 1c0001        	addw	x,#1
2413  0058 1f01          	ldw	(OFST-1,sp),x
2416  005a 9c            	rvf
2417  005b 1e01          	ldw	x,(OFST-1,sp)
2418  005d a3005a        	cpw	x,#90
2419  0060 2ff0          	jrslt	L1251
2420                     ; 97 GPIOC->ODR|=(1<<7);
2422  0062 721e500a      	bset	20490,#7
2423                     ; 100 for(i=0;i<10;i++)
2425  0066 5f            	clrw	x
2426  0067 1f01          	ldw	(OFST-1,sp),x
2427  0069               L7251:
2428                     ; 102 	__nop();
2431  0069 9d            nop
2433                     ; 100 for(i=0;i<10;i++)
2435  006a 1e01          	ldw	x,(OFST-1,sp)
2436  006c 1c0001        	addw	x,#1
2437  006f 1f01          	ldw	(OFST-1,sp),x
2440  0071 9c            	rvf
2441  0072 1e01          	ldw	x,(OFST-1,sp)
2442  0074 a3000a        	cpw	x,#10
2443  0077 2ff0          	jrslt	L7251
2444                     ; 104 }
2447  0079 85            	popw	x
2448  007a 81            	ret
2502                     ; 107 void wire1_send_byte(char in)
2502                     ; 108 {
2503                     	switch	.text
2504  007b               _wire1_send_byte:
2506  007b 89            	pushw	x
2507       00000002      OFST:	set	2
2510                     ; 110 ii=in;
2512  007c 6b02          	ld	(OFST+0,sp),a
2513                     ; 112 for(i=0;i<8;i++)
2515  007e 0f01          	clr	(OFST-1,sp)
2516  0080               L3651:
2517                     ; 114 	if(ii&0x01)wire1_w1ts();
2519  0080 7b02          	ld	a,(OFST+0,sp)
2520  0082 a501          	bcp	a,#1
2521  0084 2704          	jreq	L1751
2524  0086 ad89          	call	_wire1_w1ts
2527  0088 2002          	jra	L3751
2528  008a               L1751:
2529                     ; 115 	else wire1_w0ts();
2531  008a adba          	call	_wire1_w0ts
2533  008c               L3751:
2534                     ; 116 	ii>>=1;
2536  008c 0402          	srl	(OFST+0,sp)
2537                     ; 112 for(i=0;i<8;i++)
2539  008e 0c01          	inc	(OFST-1,sp)
2542  0090 7b01          	ld	a,(OFST-1,sp)
2543  0092 a108          	cp	a,#8
2544  0094 25ea          	jrult	L3651
2545                     ; 118 }
2548  0096 85            	popw	x
2549  0097 81            	ret
2593                     ; 121 char wire1_read_byte(void)
2593                     ; 122 {
2594                     	switch	.text
2595  0098               _wire1_read_byte:
2597  0098 89            	pushw	x
2598       00000002      OFST:	set	2
2601                     ; 124 ii=0;
2603  0099 0f02          	clr	(OFST+0,sp)
2604                     ; 126 for(i=0;i<8;i++)
2606  009b 0f01          	clr	(OFST-1,sp)
2607  009d               L7161:
2608                     ; 128 	ii>>=1;
2610  009d 0402          	srl	(OFST+0,sp)
2611                     ; 129 	if(wire1_rts())ii|=0x80;
2613  009f ad1d          	call	_wire1_rts
2615  00a1 4d            	tnz	a
2616  00a2 2708          	jreq	L5261
2619  00a4 7b02          	ld	a,(OFST+0,sp)
2620  00a6 aa80          	or	a,#128
2621  00a8 6b02          	ld	(OFST+0,sp),a
2623  00aa 2006          	jra	L7261
2624  00ac               L5261:
2625                     ; 130 	else ii&=0x7f;
2627  00ac 7b02          	ld	a,(OFST+0,sp)
2628  00ae a47f          	and	a,#127
2629  00b0 6b02          	ld	(OFST+0,sp),a
2630  00b2               L7261:
2631                     ; 126 for(i=0;i<8;i++)
2633  00b2 0c01          	inc	(OFST-1,sp)
2636  00b4 7b01          	ld	a,(OFST-1,sp)
2637  00b6 a108          	cp	a,#8
2638  00b8 25e3          	jrult	L7161
2639                     ; 132 return ii;
2641  00ba 7b02          	ld	a,(OFST+0,sp)
2644  00bc 85            	popw	x
2645  00bd 81            	ret
2691                     ; 136 char wire1_rts(void)
2691                     ; 137 {
2692                     	switch	.text
2693  00be               _wire1_rts:
2695  00be 5204          	subw	sp,#4
2696       00000004      OFST:	set	4
2699                     ; 140 GPIOC->DDR|=(1<<7);
2701  00c0 721e500c      	bset	20492,#7
2702                     ; 141 GPIOC->ODR&=~(1<<7);
2704  00c4 721f500a      	bres	20490,#7
2705                     ; 144 for(i=0;i<2;i++)
2707  00c8 5f            	clrw	x
2708  00c9 1f03          	ldw	(OFST-1,sp),x
2709  00cb               L3561:
2710                     ; 146 	__nop();
2713  00cb 9d            nop
2715                     ; 144 for(i=0;i<2;i++)
2717  00cc 1e03          	ldw	x,(OFST-1,sp)
2718  00ce 1c0001        	addw	x,#1
2719  00d1 1f03          	ldw	(OFST-1,sp),x
2722  00d3 9c            	rvf
2723  00d4 1e03          	ldw	x,(OFST-1,sp)
2724  00d6 a30002        	cpw	x,#2
2725  00d9 2ff0          	jrslt	L3561
2726                     ; 149 GPIOC->ODR|=(1<<7);
2728  00db 721e500a      	bset	20490,#7
2729                     ; 151 for(i=0;i<10;i++)
2731  00df 5f            	clrw	x
2732  00e0 1f03          	ldw	(OFST-1,sp),x
2733  00e2               L1661:
2734                     ; 153 	__nop();
2737  00e2 9d            nop
2739                     ; 151 for(i=0;i<10;i++)
2741  00e3 1e03          	ldw	x,(OFST-1,sp)
2742  00e5 1c0001        	addw	x,#1
2743  00e8 1f03          	ldw	(OFST-1,sp),x
2746  00ea 9c            	rvf
2747  00eb 1e03          	ldw	x,(OFST-1,sp)
2748  00ed a3000a        	cpw	x,#10
2749  00f0 2ff0          	jrslt	L1661
2750                     ; 155 if(GPIOC->IDR&(1<<7))	ii=1;
2752  00f2 c6500b        	ld	a,20491
2753  00f5 a580          	bcp	a,#128
2754  00f7 2707          	jreq	L7661
2757  00f9 ae0001        	ldw	x,#1
2758  00fc 1f01          	ldw	(OFST-3,sp),x
2760  00fe 2003          	jra	L1761
2761  0100               L7661:
2762                     ; 156 else ii=0;
2764  0100 5f            	clrw	x
2765  0101 1f01          	ldw	(OFST-3,sp),x
2766  0103               L1761:
2767                     ; 159 for(i=0;i<50;i++)
2769  0103 5f            	clrw	x
2770  0104 1f03          	ldw	(OFST-1,sp),x
2771  0106               L3761:
2772                     ; 161 	__nop();
2775  0106 9d            nop
2777                     ; 159 for(i=0;i<50;i++)
2779  0107 1e03          	ldw	x,(OFST-1,sp)
2780  0109 1c0001        	addw	x,#1
2781  010c 1f03          	ldw	(OFST-1,sp),x
2784  010e 9c            	rvf
2785  010f 1e03          	ldw	x,(OFST-1,sp)
2786  0111 a30032        	cpw	x,#50
2787  0114 2ff0          	jrslt	L3761
2788                     ; 163 return ii;
2790  0116 7b02          	ld	a,(OFST-2,sp)
2793  0118 5b04          	addw	sp,#4
2794  011a 81            	ret
2841                     ; 166 char wire1_polling(void)
2841                     ; 167 {
2842                     	switch	.text
2843  011b               _wire1_polling:
2845  011b 5204          	subw	sp,#4
2846       00000004      OFST:	set	4
2849                     ; 169 GPIOC->CR1&=~(1<<7);
2851  011d 721f500d      	bres	20493,#7
2852                     ; 170 GPIOC->CR2&=~(1<<7);
2854  0121 721f500e      	bres	20494,#7
2855                     ; 171 GPIOC->DDR|=(1<<7);
2857  0125 721e500c      	bset	20492,#7
2858                     ; 174 GPIOC->ODR&=~(1<<7);
2860  0129 721f500a      	bres	20490,#7
2861                     ; 177 for(i=0;i<600;i++)
2863  012d 5f            	clrw	x
2864  012e 1f03          	ldw	(OFST-1,sp),x
2865  0130               L3371:
2866                     ; 179 	__nop();
2869  0130 9d            nop
2871                     ; 177 for(i=0;i<600;i++)
2873  0131 1e03          	ldw	x,(OFST-1,sp)
2874  0133 1c0001        	addw	x,#1
2875  0136 1f03          	ldw	(OFST-1,sp),x
2878  0138 9c            	rvf
2879  0139 1e03          	ldw	x,(OFST-1,sp)
2880  013b a30258        	cpw	x,#600
2881  013e 2ff0          	jrslt	L3371
2882                     ; 181 GPIOC->ODR|=(1<<7);
2884  0140 721e500a      	bset	20490,#7
2885                     ; 184 for(i=0;i<15;i++)
2887  0144 5f            	clrw	x
2888  0145 1f03          	ldw	(OFST-1,sp),x
2889  0147               L1471:
2890                     ; 186 	__nop();
2893  0147 9d            nop
2895                     ; 184 for(i=0;i<15;i++)
2897  0148 1e03          	ldw	x,(OFST-1,sp)
2898  014a 1c0001        	addw	x,#1
2899  014d 1f03          	ldw	(OFST-1,sp),x
2902  014f 9c            	rvf
2903  0150 1e03          	ldw	x,(OFST-1,sp)
2904  0152 a3000f        	cpw	x,#15
2905  0155 2ff0          	jrslt	L1471
2906                     ; 190 for(i=0;i<20;i++)
2908  0157 5f            	clrw	x
2909  0158 1f03          	ldw	(OFST-1,sp),x
2910  015a               L7471:
2911                     ; 192 	__nop();
2914  015a 9d            nop
2916                     ; 193 	__nop();
2919  015b 9d            nop
2921                     ; 194 	__nop();
2924  015c 9d            nop
2926                     ; 195 	if(!(GPIOC->IDR&(1<<7)))goto ibatton_polling_lbl_000;
2928  015d c6500b        	ld	a,20491
2929  0160 a580          	bcp	a,#128
2930  0162 2623          	jrne	L5571
2932                     ; 199 ibatton_polling_lbl_000:
2932                     ; 200 
2932                     ; 201 //измеряем длительность ответного импульса не дольше 300мкс
2932                     ; 202 for(i=0;i<220;i++)
2934  0164 5f            	clrw	x
2935  0165 1f03          	ldw	(OFST-1,sp),x
2936  0167               L7571:
2937                     ; 204 	if(GPIOC->IDR&(1<<7))
2939  0167 c6500b        	ld	a,20491
2940  016a a580          	bcp	a,#128
2941  016c 272c          	jreq	L5671
2942                     ; 206 		__nop();
2945  016e 9d            nop
2947                     ; 207 		__nop();
2950  016f 9d            nop
2952                     ; 208 		num_out=10;
2954                     ; 209 		goto ibatton_polling_lbl_001;	//continue;
2955                     ; 216 ibatton_polling_lbl_001:
2955                     ; 217 //выдержка 15мкс
2955                     ; 218 for(i=0;i<30;i++)
2957  0170 5f            	clrw	x
2958  0171 1f03          	ldw	(OFST-1,sp),x
2959  0173               L7671:
2960                     ; 220 	__nop();
2963  0173 9d            nop
2965                     ; 218 for(i=0;i<30;i++)
2967  0174 1e03          	ldw	x,(OFST-1,sp)
2968  0176 1c0001        	addw	x,#1
2969  0179 1f03          	ldw	(OFST-1,sp),x
2972  017b 9c            	rvf
2973  017c 1e03          	ldw	x,(OFST-1,sp)
2974  017e a3001e        	cpw	x,#30
2975  0181 2ff0          	jrslt	L7671
2976                     ; 222 ibatton_polling_lbl_success_exit:
2976                     ; 223 return 1;
2978  0183 a601          	ld	a,#1
2980  0185 2010          	jra	L22
2981  0187               L5571:
2982                     ; 190 for(i=0;i<20;i++)
2984  0187 1e03          	ldw	x,(OFST-1,sp)
2985  0189 1c0001        	addw	x,#1
2986  018c 1f03          	ldw	(OFST-1,sp),x
2989  018e 9c            	rvf
2990  018f 1e03          	ldw	x,(OFST-1,sp)
2991  0191 a30014        	cpw	x,#20
2992  0194 2fc4          	jrslt	L7471
2993                     ; 198 return 0;
2995  0196 4f            	clr	a
2997  0197               L22:
2999  0197 5b04          	addw	sp,#4
3000  0199 81            	ret
3001  019a               L5671:
3002                     ; 202 for(i=0;i<220;i++)
3004  019a 1e03          	ldw	x,(OFST-1,sp)
3005  019c 1c0001        	addw	x,#1
3006  019f 1f03          	ldw	(OFST-1,sp),x
3009  01a1 9c            	rvf
3010  01a2 1e03          	ldw	x,(OFST-1,sp)
3011  01a4 a300dc        	cpw	x,#220
3012  01a7 2fbe          	jrslt	L7571
3013                     ; 214 return 5;
3015  01a9 a605          	ld	a,#5
3017  01ab 20ea          	jra	L22
3040                     ; 229 void uart_init (void)
3040                     ; 230 {
3041                     	switch	.text
3042  01ad               _uart_init:
3046                     ; 231 GPIOD->DDR&=~(1<<5);	
3048  01ad 721b5011      	bres	20497,#5
3049                     ; 232 GPIOD->CR1|=(1<<5);
3051  01b1 721a5012      	bset	20498,#5
3052                     ; 233 GPIOD->CR2&=~(1<<5);
3054  01b5 721b5013      	bres	20499,#5
3055                     ; 235 UART1->CR1&=~UART1_CR1_M;					
3057  01b9 72195234      	bres	21044,#4
3058                     ; 236 UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
3060  01bd c65236        	ld	a,21046
3061                     ; 237 UART1->BRR2= 0x03;
3063  01c0 35035233      	mov	21043,#3
3064                     ; 238 UART1->BRR1= 0x68;
3066  01c4 35685232      	mov	21042,#104
3067                     ; 239 UART1->CR2|= UART1_CR2_TEN /*| UART3_CR2_REN | UART3_CR2_RIEN*/;	
3069  01c8 72165235      	bset	21045,#3
3070                     ; 240 }
3073  01cc 81            	ret
3110                     ; 243 void putchar(char c)
3110                     ; 244 {
3111                     	switch	.text
3112  01cd               _putchar:
3114  01cd 88            	push	a
3115       00000000      OFST:	set	0
3118  01ce               L5202:
3119                     ; 245 while (tx_counter == TX_BUFFER_SIZE);
3121  01ce c60000        	ld	a,_tx_counter
3122  01d1 a11e          	cp	a,#30
3123  01d3 27f9          	jreq	L5202
3124                     ; 247 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
3126  01d5 725d0000      	tnz	_tx_counter
3127  01d9 2607          	jrne	L3302
3129  01db c65230        	ld	a,21040
3130  01de a580          	bcp	a,#128
3131  01e0 2620          	jrne	L1302
3132  01e2               L3302:
3133                     ; 249    tx_buffer[tx_wr_index]=c;
3135  01e2 5f            	clrw	x
3136  01e3 b66c          	ld	a,_tx_wr_index
3137  01e5 2a01          	jrpl	L03
3138  01e7 53            	cplw	x
3139  01e8               L03:
3140  01e8 97            	ld	xl,a
3141  01e9 7b01          	ld	a,(OFST+1,sp)
3142  01eb d70008        	ld	(_tx_buffer,x),a
3143                     ; 250    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
3145  01ee 3c6c          	inc	_tx_wr_index
3146  01f0 b66c          	ld	a,_tx_wr_index
3147  01f2 a11e          	cp	a,#30
3148  01f4 2602          	jrne	L5302
3151  01f6 3f6c          	clr	_tx_wr_index
3152  01f8               L5302:
3153                     ; 251    ++tx_counter;
3155  01f8 725c0000      	inc	_tx_counter
3157  01fc               L7302:
3158                     ; 255 UART1->CR2|= UART1_CR2_TIEN;
3160  01fc 721e5235      	bset	21045,#7
3161                     ; 257 }
3164  0200 84            	pop	a
3165  0201 81            	ret
3166  0202               L1302:
3167                     ; 253 else UART1->DR=c;
3169  0202 7b01          	ld	a,(OFST+1,sp)
3170  0204 c75231        	ld	21041,a
3171  0207 20f3          	jra	L7302
3202                     ; 263 @far @interrupt void TIM4_UPD_Interrupt (void) 
3202                     ; 264 {
3204                     	switch	.text
3205  0209               f_TIM4_UPD_Interrupt:
3209                     ; 265 if(++t0_cnt0>=125)
3211  0209 725c0004      	inc	L3241_t0_cnt0
3212  020d c60004        	ld	a,L3241_t0_cnt0
3213  0210 a17d          	cp	a,#125
3214  0212 2541          	jrult	L1502
3215                     ; 267   t0_cnt0=0;
3217  0214 725f0004      	clr	L3241_t0_cnt0
3218                     ; 268   b100Hz=1;
3220  0218 35010000      	mov	_b100Hz,#1
3221                     ; 270 	if(++t0_cnt1>=10)
3223  021c 725c0005      	inc	L5241_t0_cnt1
3224  0220 c60005        	ld	a,L5241_t0_cnt1
3225  0223 a10a          	cp	a,#10
3226  0225 2508          	jrult	L3502
3227                     ; 272 		t0_cnt1=0;
3229  0227 725f0005      	clr	L5241_t0_cnt1
3230                     ; 273 		b10Hz=1;
3232  022b 35010001      	mov	_b10Hz,#1
3233  022f               L3502:
3234                     ; 276 	if(++t0_cnt2>=20)
3236  022f 725c0006      	inc	L7241_t0_cnt2
3237  0233 c60006        	ld	a,L7241_t0_cnt2
3238  0236 a114          	cp	a,#20
3239  0238 2508          	jrult	L5502
3240                     ; 278 		t0_cnt2=0;
3242  023a 725f0006      	clr	L7241_t0_cnt2
3243                     ; 279 		b5Hz=1;
3245  023e 35010002      	mov	_b5Hz,#1
3246  0242               L5502:
3247                     ; 282 	if(++t0_cnt3>=100)
3249  0242 725c0007      	inc	L1341_t0_cnt3
3250  0246 c60007        	ld	a,L1341_t0_cnt3
3251  0249 a164          	cp	a,#100
3252  024b 2508          	jrult	L1502
3253                     ; 284 		t0_cnt3=0;
3255  024d 725f0007      	clr	L1341_t0_cnt3
3256                     ; 285 		b1Hz=1;
3258  0251 35010003      	mov	_b1Hz,#1
3259  0255               L1502:
3260                     ; 288 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
3262  0255 72115344      	bres	21316,#0
3263                     ; 289 return;
3266  0259 80            	iret
3291                     ; 293 @far @interrupt void UARTTxInterrupt (void) 
3291                     ; 294 {
3292                     	switch	.text
3293  025a               f_UARTTxInterrupt:
3297                     ; 295 if (tx_counter)
3299  025a 725d0000      	tnz	_tx_counter
3300  025e 271d          	jreq	L1702
3301                     ; 297 	--tx_counter;
3303  0260 725a0000      	dec	_tx_counter
3304                     ; 298 	UART1->DR=tx_buffer[tx_rd_index];
3306  0264 5f            	clrw	x
3307  0265 b66b          	ld	a,_tx_rd_index
3308  0267 2a01          	jrpl	L63
3309  0269 53            	cplw	x
3310  026a               L63:
3311  026a 97            	ld	xl,a
3312  026b d60008        	ld	a,(_tx_buffer,x)
3313  026e c75231        	ld	21041,a
3314                     ; 299 	if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
3316  0271 3c6b          	inc	_tx_rd_index
3317  0273 b66b          	ld	a,_tx_rd_index
3318  0275 a11e          	cp	a,#30
3319  0277 2608          	jrne	L5702
3322  0279 3f6b          	clr	_tx_rd_index
3323  027b 2004          	jra	L5702
3324  027d               L1702:
3325                     ; 304 	UART1->CR2&= ~UART1_CR2_TIEN;
3327  027d 721f5235      	bres	21045,#7
3328  0281               L5702:
3329                     ; 306 }
3332  0281 80            	iret
3354                     ; 309 @far @interrupt void UARTRxInterrupt (void) 
3354                     ; 310 {
3355                     	switch	.text
3356  0282               f_UARTRxInterrupt:
3360                     ; 312 }
3363  0282 80            	iret
3432                     ; 318 main()
3432                     ; 319 {
3434                     	switch	.text
3435  0283               _main:
3437  0283 5206          	subw	sp,#6
3438       00000006      OFST:	set	6
3441                     ; 320 CLK->CKDIVR=0;
3443  0285 725f50c6      	clr	20678
3444                     ; 322 GPIOC->DDR|=(1<<6);
3446  0289 721c500c      	bset	20492,#6
3447                     ; 323 GPIOC->CR1|=(1<<6);
3449  028d 721c500d      	bset	20493,#6
3450                     ; 324 GPIOC->CR2|=(1<<6);
3452  0291 721c500e      	bset	20494,#6
3453                     ; 326 t4_init();
3455  0295 cd0000        	call	_t4_init
3457                     ; 327 uart_init();
3459  0298 cd01ad        	call	_uart_init
3461                     ; 328 enableInterrupts();
3464  029b 9a            rim
3466  029c               L5312:
3467                     ; 337 	if(b100Hz)
3469  029c 725d0000      	tnz	_b100Hz
3470  02a0 2704          	jreq	L1412
3471                     ; 339 		b100Hz=0;
3473  02a2 725f0000      	clr	_b100Hz
3474  02a6               L1412:
3475                     ; 347 	if(b10Hz)
3477  02a6 725d0001      	tnz	_b10Hz
3478  02aa 2704          	jreq	L3412
3479                     ; 349 		b10Hz=0;
3481  02ac 725f0001      	clr	_b10Hz
3482  02b0               L3412:
3483                     ; 356 	if(b5Hz)
3485  02b0 725d0002      	tnz	_b5Hz
3486  02b4 2704          	jreq	L5412
3487                     ; 358 		b5Hz=0;
3489  02b6 725f0002      	clr	_b5Hz
3490  02ba               L5412:
3491                     ; 364 	if(b1Hz)
3493  02ba 725d0003      	tnz	_b1Hz
3494  02be 27dc          	jreq	L5312
3495                     ; 366 		b1Hz=0;
3497  02c0 725f0003      	clr	_b1Hz
3498                     ; 368 		if(!bCONV)
3500  02c4 3d6d          	tnz	_bCONV
3501  02c6 265a          	jrne	L1512
3502                     ; 371 			bCONV=1;
3504  02c8 3501006d      	mov	_bCONV,#1
3505                     ; 372 			temp=wire1_polling();
3507  02cc cd011b        	call	_wire1_polling
3509  02cf 6b06          	ld	(OFST+0,sp),a
3510                     ; 373 			if(temp==1)
3512  02d1 7b06          	ld	a,(OFST+0,sp)
3513  02d3 a101          	cp	a,#1
3514  02d5 2616          	jrne	L3512
3515                     ; 375 				wire1_send_byte(0xCC);
3517  02d7 a6cc          	ld	a,#204
3518  02d9 cd007b        	call	_wire1_send_byte
3520                     ; 376 				wire1_send_byte(0x44);
3522  02dc a644          	ld	a,#68
3523  02de cd007b        	call	_wire1_send_byte
3525                     ; 378 				ds18b20ErrorHiCnt=0;
3527  02e1 3f7a          	clr	_ds18b20ErrorHiCnt
3528                     ; 379 				ds18b20ErrorLoCnt=0;
3530  02e3 3f79          	clr	_ds18b20ErrorLoCnt
3531                     ; 380 				airSensorErrorStat=esNORM;		
3533  02e5 35550000      	mov	_airSensorErrorStat,#85
3535  02e9 aca003a0      	jpf	L3712
3536  02ed               L3512:
3537                     ; 384 				if(temp==0)
3539  02ed 0d06          	tnz	(OFST+0,sp)
3540  02ef 2614          	jrne	L7512
3541                     ; 386 					if(ds18b20ErrorHiCnt<10)
3543  02f1 b67a          	ld	a,_ds18b20ErrorHiCnt
3544  02f3 a10a          	cp	a,#10
3545  02f5 240c          	jruge	L1612
3546                     ; 388 						ds18b20ErrorHiCnt++;
3548  02f7 3c7a          	inc	_ds18b20ErrorHiCnt
3549                     ; 389 						if(ds18b20ErrorHiCnt>=10)
3551  02f9 b67a          	ld	a,_ds18b20ErrorHiCnt
3552  02fb a10a          	cp	a,#10
3553  02fd 2504          	jrult	L1612
3554                     ; 391 							airSensorErrorStat=esHI;	
3556  02ff 35010000      	mov	_airSensorErrorStat,#1
3557  0303               L1612:
3558                     ; 394 					ds18b20ErrorLoCnt=0;
3560  0303 3f79          	clr	_ds18b20ErrorLoCnt
3561  0305               L7512:
3562                     ; 397 				if(temp==5)
3564  0305 7b06          	ld	a,(OFST+0,sp)
3565  0307 a105          	cp	a,#5
3566  0309 2703          	jreq	L64
3567  030b cc03a0        	jp	L3712
3568  030e               L64:
3569                     ; 399 					if(ds18b20ErrorLoCnt<10)
3571  030e b679          	ld	a,_ds18b20ErrorLoCnt
3572  0310 a10a          	cp	a,#10
3573  0312 240a          	jruge	L7612
3574                     ; 401 						ds18b20ErrorLoCnt++;
3576  0314 3c79          	inc	_ds18b20ErrorLoCnt
3577                     ; 402 						if(ds18b20ErrorLoCnt>=10)
3579  0316 b679          	ld	a,_ds18b20ErrorLoCnt
3580  0318 a10a          	cp	a,#10
3581  031a 2502          	jrult	L7612
3582                     ; 404 							airSensorErrorStat=esLO;	
3584  031c 3f00          	clr	_airSensorErrorStat
3585  031e               L7612:
3586                     ; 407 					ds18b20ErrorHiCnt=0;
3588  031e 3f7a          	clr	_ds18b20ErrorHiCnt
3589  0320 207e          	jra	L3712
3590  0322               L1512:
3591                     ; 415 			bCONV=0;
3593  0322 3f6d          	clr	_bCONV
3594                     ; 416 			temp=wire1_polling();
3596  0324 cd011b        	call	_wire1_polling
3598  0327 6b06          	ld	(OFST+0,sp),a
3599                     ; 417 			if(temp==1)
3601  0329 7b06          	ld	a,(OFST+0,sp)
3602  032b a101          	cp	a,#1
3603  032d 2641          	jrne	L5712
3604                     ; 419 				wire1_send_byte(0xCC);
3606  032f a6cc          	ld	a,#204
3607  0331 cd007b        	call	_wire1_send_byte
3609                     ; 420 				wire1_send_byte(0xBE);
3611  0334 a6be          	ld	a,#190
3612  0336 cd007b        	call	_wire1_send_byte
3614                     ; 421 				wire1_in[0]=wire1_read_byte();
3616  0339 cd0098        	call	_wire1_read_byte
3618  033c b77b          	ld	_wire1_in,a
3619                     ; 422 				wire1_in[1]=wire1_read_byte();
3621  033e cd0098        	call	_wire1_read_byte
3623  0341 b77c          	ld	_wire1_in+1,a
3624                     ; 423 				wire1_in[2]=wire1_read_byte();
3626  0343 cd0098        	call	_wire1_read_byte
3628  0346 b77d          	ld	_wire1_in+2,a
3629                     ; 424 				wire1_in[3]=wire1_read_byte();
3631  0348 cd0098        	call	_wire1_read_byte
3633  034b b77e          	ld	_wire1_in+3,a
3634                     ; 425 				wire1_in[4]=wire1_read_byte();
3636  034d cd0098        	call	_wire1_read_byte
3638  0350 b77f          	ld	_wire1_in+4,a
3639                     ; 426 				wire1_in[5]=wire1_read_byte();
3641  0352 cd0098        	call	_wire1_read_byte
3643  0355 b780          	ld	_wire1_in+5,a
3644                     ; 427 				wire1_in[6]=wire1_read_byte();
3646  0357 cd0098        	call	_wire1_read_byte
3648  035a b781          	ld	_wire1_in+6,a
3649                     ; 428 				wire1_in[7]=wire1_read_byte();
3651  035c cd0098        	call	_wire1_read_byte
3653  035f b782          	ld	_wire1_in+7,a
3654                     ; 429 				wire1_in[8]=wire1_read_byte();
3656  0361 cd0098        	call	_wire1_read_byte
3658  0364 b783          	ld	_wire1_in+8,a
3659                     ; 431 				ds18b20ErrorHiCnt=0;
3661  0366 3f7a          	clr	_ds18b20ErrorHiCnt
3662                     ; 432 				ds18b20ErrorLoCnt=0;
3664  0368 3f79          	clr	_ds18b20ErrorLoCnt
3665                     ; 433 				airSensorErrorStat=esNORM;
3667  036a 35550000      	mov	_airSensorErrorStat,#85
3669  036e 2030          	jra	L3712
3670  0370               L5712:
3671                     ; 437 				if(temp==0)
3673  0370 0d06          	tnz	(OFST+0,sp)
3674  0372 2614          	jrne	L1022
3675                     ; 439 					if(ds18b20ErrorHiCnt<10)
3677  0374 b67a          	ld	a,_ds18b20ErrorHiCnt
3678  0376 a10a          	cp	a,#10
3679  0378 240c          	jruge	L3022
3680                     ; 441 						ds18b20ErrorHiCnt++;
3682  037a 3c7a          	inc	_ds18b20ErrorHiCnt
3683                     ; 442 						if(ds18b20ErrorHiCnt>=10)
3685  037c b67a          	ld	a,_ds18b20ErrorHiCnt
3686  037e a10a          	cp	a,#10
3687  0380 2504          	jrult	L3022
3688                     ; 444 							airSensorErrorStat=esHI;	
3690  0382 35010000      	mov	_airSensorErrorStat,#1
3691  0386               L3022:
3692                     ; 447 					ds18b20ErrorLoCnt=0;
3694  0386 3f79          	clr	_ds18b20ErrorLoCnt
3695  0388               L1022:
3696                     ; 450 				if(temp==5)
3698  0388 7b06          	ld	a,(OFST+0,sp)
3699  038a a105          	cp	a,#5
3700  038c 2612          	jrne	L3712
3701                     ; 452 					if(ds18b20ErrorLoCnt<10)
3703  038e b679          	ld	a,_ds18b20ErrorLoCnt
3704  0390 a10a          	cp	a,#10
3705  0392 240a          	jruge	L1122
3706                     ; 454 						ds18b20ErrorLoCnt++;
3708  0394 3c79          	inc	_ds18b20ErrorLoCnt
3709                     ; 455 						if(ds18b20ErrorLoCnt>=10)
3711  0396 b679          	ld	a,_ds18b20ErrorLoCnt
3712  0398 a10a          	cp	a,#10
3713  039a 2502          	jrult	L1122
3714                     ; 457 							airSensorErrorStat=esLO;	
3716  039c 3f00          	clr	_airSensorErrorStat
3717  039e               L1122:
3718                     ; 460 					ds18b20ErrorHiCnt=0;
3720  039e 3f7a          	clr	_ds18b20ErrorHiCnt
3721  03a0               L3712:
3722                     ; 466 		if(wire1_in[1]&0xf0)
3724  03a0 b67c          	ld	a,_wire1_in+1
3725  03a2 a5f0          	bcp	a,#240
3726  03a4 2620          	jrne	L7122
3728                     ; 474 			temper_temp=(((short)wire1_in[1])<<8)+((short)wire1_in[0]);
3730  03a6 b67b          	ld	a,_wire1_in
3731  03a8 5f            	clrw	x
3732  03a9 97            	ld	xl,a
3733  03aa 1f03          	ldw	(OFST-3,sp),x
3734  03ac b67c          	ld	a,_wire1_in+1
3735  03ae 5f            	clrw	x
3736  03af 97            	ld	xl,a
3737  03b0 4f            	clr	a
3738  03b1 02            	rlwa	x,a
3739  03b2 72fb03        	addw	x,(OFST-3,sp)
3740  03b5 1f05          	ldw	(OFST-1,sp),x
3741                     ; 475 			temper_temp>>=4;
3743  03b7 a604          	ld	a,#4
3744  03b9               L44:
3745  03b9 0705          	sra	(OFST-1,sp)
3746  03bb 0606          	rrc	(OFST+0,sp)
3747  03bd 4a            	dec	a
3748  03be 26f9          	jrne	L44
3749                     ; 476 			temper_temp&=0x00ff;
3751  03c0 0f05          	clr	(OFST-1,sp)
3752                     ; 478 			temper=(short)temper_temp;
3754  03c2 1e05          	ldw	x,(OFST-1,sp)
3755  03c4 bf76          	ldw	_temper,x
3756  03c6               L7122:
3757                     ; 481 		temperCRC = (temper%10)+((temper/10)%10)+((temper/100)%10);
3759  03c6 be76          	ldw	x,_temper
3760  03c8 a664          	ld	a,#100
3761  03ca cd0000        	call	c_sdivx
3763  03cd a60a          	ld	a,#10
3764  03cf cd0000        	call	c_smodx
3766  03d2 1f03          	ldw	(OFST-3,sp),x
3767  03d4 be76          	ldw	x,_temper
3768  03d6 a60a          	ld	a,#10
3769  03d8 cd0000        	call	c_sdivx
3771  03db a60a          	ld	a,#10
3772  03dd cd0000        	call	c_smodx
3774  03e0 1f01          	ldw	(OFST-5,sp),x
3775  03e2 be76          	ldw	x,_temper
3776  03e4 a60a          	ld	a,#10
3777  03e6 cd0000        	call	c_smodx
3779  03e9 72fb01        	addw	x,(OFST-5,sp)
3780  03ec 72fb03        	addw	x,(OFST-3,sp)
3781  03ef bf74          	ldw	_temperCRC,x
3782                     ; 482 		temperCRC*=-1;
3784  03f1 be74          	ldw	x,_temperCRC
3785  03f3 50            	negw	x
3786  03f4 bf74          	ldw	_temperCRC,x
3787                     ; 504 		if(airSensorErrorStat==esHI) printf("ERRORHI\n");
3789  03f6 b600          	ld	a,_airSensorErrorStat
3790  03f8 a101          	cp	a,#1
3791  03fa 260a          	jrne	L1222
3794  03fc ae0014        	ldw	x,#L3222
3795  03ff cd0000        	call	_printf
3798  0402 ac9c029c      	jpf	L5312
3799  0406               L1222:
3800                     ; 505 		else if(airSensorErrorStat==esLO) printf("ERRORLO\n");
3802  0406 3d00          	tnz	_airSensorErrorStat
3803  0408 260a          	jrne	L7222
3806  040a ae000b        	ldw	x,#L1322
3807  040d cd0000        	call	_printf
3810  0410 ac9c029c      	jpf	L5312
3811  0414               L7222:
3812                     ; 506 		else if(airSensorErrorStat==esNORM) printf("OK%dCRC%d\n",temper,temperCRC);
3814  0414 b600          	ld	a,_airSensorErrorStat
3815  0416 a155          	cp	a,#85
3816  0418 2703          	jreq	L05
3817  041a cc029c        	jp	L5312
3818  041d               L05:
3821  041d be74          	ldw	x,_temperCRC
3822  041f 89            	pushw	x
3823  0420 be76          	ldw	x,_temper
3824  0422 89            	pushw	x
3825  0423 ae0000        	ldw	x,#L7322
3826  0426 cd0000        	call	_printf
3828  0429 5b04          	addw	sp,#4
3829  042b ac9c029c      	jpf	L5312
4167                     	xdef	_main
4168                     	xdef	f_UARTRxInterrupt
4169                     	xdef	f_UARTTxInterrupt
4170                     	xdef	f_TIM4_UPD_Interrupt
4171                     	xdef	_putchar
4172                     	xdef	_uart_init
4173                     	xdef	_wire1_polling
4174                     	xdef	_wire1_read_byte
4175                     	xdef	_wire1_send_byte
4176                     	xdef	_wire1_w0ts
4177                     	xdef	_wire1_w1ts
4178                     	xdef	_t4_init
4179                     	xdef	_temperdeb
4180                     	switch	.ubsct
4181  0000               _out_string2:
4182  0000 0000          	ds.b	2
4183                     	xdef	_out_string2
4184  0002               _out_string1:
4185  0002 0000          	ds.b	2
4186                     	xdef	_out_string1
4187  0004               _out_string:
4188  0004 0000          	ds.b	2
4189                     	xdef	_out_string
4190  0006               _buf:
4191  0006 000000000000  	ds.b	100
4192                     	xdef	_buf
4193  006a               _bOUT_FREE:
4194  006a 00            	ds.b	1
4195                     	xdef	_bOUT_FREE
4196  006b               _tx_rd_index:
4197  006b 00            	ds.b	1
4198                     	xdef	_tx_rd_index
4199  006c               _tx_wr_index:
4200  006c 00            	ds.b	1
4201                     	xdef	_tx_wr_index
4202                     	switch	.bss
4203  0000               _tx_counter:
4204  0000 00            	ds.b	1
4205                     	xdef	_tx_counter
4206                     	xdef	_tx_buffer
4207                     	switch	.ubsct
4208  006d               _bCONV:
4209  006d 00            	ds.b	1
4210                     	xdef	_bCONV
4211  006e               _out_buff_digits:
4212  006e 0000          	ds.b	2
4213                     	xdef	_out_buff_digits
4214  0070               _out_buff_preffiks:
4215  0070 0000          	ds.b	2
4216                     	xdef	_out_buff_preffiks
4217  0072               _out_buff:
4218  0072 0000          	ds.b	2
4219                     	xdef	_out_buff
4220  0074               _temperCRC:
4221  0074 0000          	ds.b	2
4222                     	xdef	_temperCRC
4223  0076               _temper:
4224  0076 0000          	ds.b	2
4225                     	xdef	_temper
4226                     	xdef	_b1Hz
4227                     	xdef	_b5Hz
4228                     	xdef	_b10Hz
4229                     	xdef	_b100Hz
4230                     	xref	_printf
4231                     	xdef	_wire1_rts
4232                     	xdef	_airSensorErrorStat
4233  0078               _ds18b20ErrorOffCnt:
4234  0078 00            	ds.b	1
4235                     	xdef	_ds18b20ErrorOffCnt
4236  0079               _ds18b20ErrorLoCnt:
4237  0079 00            	ds.b	1
4238                     	xdef	_ds18b20ErrorLoCnt
4239  007a               _ds18b20ErrorHiCnt:
4240  007a 00            	ds.b	1
4241                     	xdef	_ds18b20ErrorHiCnt
4242  007b               _wire1_in:
4243  007b 000000000000  	ds.b	10
4244                     	xdef	_wire1_in
4245                     .const:	section	.text
4246  0000               L7322:
4247  0000 4f4b25644352  	dc.b	"OK%dCRC%d",10,0
4248  000b               L1322:
4249  000b 4552524f524c  	dc.b	"ERRORLO",10,0
4250  0014               L3222:
4251  0014 4552524f5248  	dc.b	"ERRORHI",10,0
4252                     	xref.b	c_x
4272                     	xref	c_sdivx
4273                     	xref	c_smody
4274                     	xref	c_sdivy
4275                     	xref	c_smodx
4276                     	end
