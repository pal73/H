   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2229                     	switch	.data
2230  0000               _b100Hz:
2231  0000 00            	dc.b	0
2232  0001               _b10Hz:
2233  0001 00            	dc.b	0
2234  0002               _b5Hz:
2235  0002 00            	dc.b	0
2236  0003               _b1Hz:
2237  0003 00            	dc.b	0
2238  0004               L1541_t0_cnt0:
2239  0004 00            	dc.b	0
2240  0005               L3541_t0_cnt1:
2241  0005 00            	dc.b	0
2242  0006               L5541_t0_cnt2:
2243  0006 00            	dc.b	0
2244  0007               L7541_t0_cnt3:
2245  0007 00            	dc.b	0
2246                     	bsct
2247  0000               _airSensorErrorStat:
2248  0000 55            	dc.b	85
2249                     	switch	.data
2250  0008               _tx_buffer:
2251  0008 00            	dc.b	0
2252  0009 000000000000  	ds.b	29
2253                     	bsct
2254  0001               _temperdeb:
2255  0001 04d2          	dc.w	1234
2256  0003               _sensor:
2257  0003 00            	dc.b	0
2258  0004               _bWFI:
2259  0004 00            	dc.b	0
2288                     ; 65 void t4_init(void)
2288                     ; 66 {
2290                     	switch	.text
2291  0000               _t4_init:
2295                     ; 67 TIM4->PSCR = 3;
2297  0000 35035347      	mov	21319,#3
2298                     ; 68 TIM4->ARR= 158;
2300  0004 359e5348      	mov	21320,#158
2301                     ; 69 TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2303  0008 72105343      	bset	21315,#0
2304                     ; 71 TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2306  000c 35855340      	mov	21312,#133
2307                     ; 73 }
2310  0010 81            	ret
2346                     ; 76 char wire1_w1ts(void)
2346                     ; 77 {
2347                     	switch	.text
2348  0011               _wire1_w1ts:
2350  0011 89            	pushw	x
2351       00000002      OFST:	set	2
2354                     ; 79 GPIOC->DDR|=(1<<7);
2356  0012 721e500c      	bset	20492,#7
2357                     ; 80 GPIOC->ODR&=~(1<<7);
2359  0016 721f500a      	bres	20490,#7
2360                     ; 83 for(i=0;i<10;i++)
2362  001a 5f            	clrw	x
2363  001b 1f01          	ldw	(OFST-1,sp),x
2364  001d               L5151:
2365                     ; 85 	__nop();
2368  001d 9d            nop
2370                     ; 83 for(i=0;i<10;i++)
2372  001e 1e01          	ldw	x,(OFST-1,sp)
2373  0020 1c0001        	addw	x,#1
2374  0023 1f01          	ldw	(OFST-1,sp),x
2377  0025 9c            	rvf
2378  0026 1e01          	ldw	x,(OFST-1,sp)
2379  0028 a3000a        	cpw	x,#10
2380  002b 2ff0          	jrslt	L5151
2381                     ; 87 GPIOC->ODR|=(1<<7);
2383  002d 721e500a      	bset	20490,#7
2384                     ; 90 for(i=0;i<90;i++)
2386  0031 5f            	clrw	x
2387  0032 1f01          	ldw	(OFST-1,sp),x
2388  0034               L3251:
2389                     ; 92 	__nop();
2392  0034 9d            nop
2394                     ; 90 for(i=0;i<90;i++)
2396  0035 1e01          	ldw	x,(OFST-1,sp)
2397  0037 1c0001        	addw	x,#1
2398  003a 1f01          	ldw	(OFST-1,sp),x
2401  003c 9c            	rvf
2402  003d 1e01          	ldw	x,(OFST-1,sp)
2403  003f a3005a        	cpw	x,#90
2404  0042 2ff0          	jrslt	L3251
2405                     ; 94 }
2408  0044 85            	popw	x
2409  0045 81            	ret
2445                     ; 97 char wire1_w0ts(void)
2445                     ; 98 {
2446                     	switch	.text
2447  0046               _wire1_w0ts:
2449  0046 89            	pushw	x
2450       00000002      OFST:	set	2
2453                     ; 100 GPIOC->DDR|=(1<<7);
2455  0047 721e500c      	bset	20492,#7
2456                     ; 101 GPIOC->ODR&=~(1<<7);
2458  004b 721f500a      	bres	20490,#7
2459                     ; 104 for(i=0;i<90;i++)
2461  004f 5f            	clrw	x
2462  0050 1f01          	ldw	(OFST-1,sp),x
2463  0052               L7451:
2464                     ; 106 	__nop();
2467  0052 9d            nop
2469                     ; 104 for(i=0;i<90;i++)
2471  0053 1e01          	ldw	x,(OFST-1,sp)
2472  0055 1c0001        	addw	x,#1
2473  0058 1f01          	ldw	(OFST-1,sp),x
2476  005a 9c            	rvf
2477  005b 1e01          	ldw	x,(OFST-1,sp)
2478  005d a3005a        	cpw	x,#90
2479  0060 2ff0          	jrslt	L7451
2480                     ; 108 GPIOC->ODR|=(1<<7);
2482  0062 721e500a      	bset	20490,#7
2483                     ; 111 for(i=0;i<10;i++)
2485  0066 5f            	clrw	x
2486  0067 1f01          	ldw	(OFST-1,sp),x
2487  0069               L5551:
2488                     ; 113 	__nop();
2491  0069 9d            nop
2493                     ; 111 for(i=0;i<10;i++)
2495  006a 1e01          	ldw	x,(OFST-1,sp)
2496  006c 1c0001        	addw	x,#1
2497  006f 1f01          	ldw	(OFST-1,sp),x
2500  0071 9c            	rvf
2501  0072 1e01          	ldw	x,(OFST-1,sp)
2502  0074 a3000a        	cpw	x,#10
2503  0077 2ff0          	jrslt	L5551
2504                     ; 115 }
2507  0079 85            	popw	x
2508  007a 81            	ret
2562                     ; 118 void wire1_send_byte(char in)
2562                     ; 119 {
2563                     	switch	.text
2564  007b               _wire1_send_byte:
2566  007b 89            	pushw	x
2567       00000002      OFST:	set	2
2570                     ; 121 ii=in;
2572  007c 6b02          	ld	(OFST+0,sp),a
2573                     ; 123 for(i=0;i<8;i++)
2575  007e 0f01          	clr	(OFST-1,sp)
2576  0080               L1161:
2577                     ; 125 	if(ii&0x01)wire1_w1ts();
2579  0080 7b02          	ld	a,(OFST+0,sp)
2580  0082 a501          	bcp	a,#1
2581  0084 2704          	jreq	L7161
2584  0086 ad89          	call	_wire1_w1ts
2587  0088 2002          	jra	L1261
2588  008a               L7161:
2589                     ; 126 	else wire1_w0ts();
2591  008a adba          	call	_wire1_w0ts
2593  008c               L1261:
2594                     ; 127 	ii>>=1;
2596  008c 0402          	srl	(OFST+0,sp)
2597                     ; 123 for(i=0;i<8;i++)
2599  008e 0c01          	inc	(OFST-1,sp)
2602  0090 7b01          	ld	a,(OFST-1,sp)
2603  0092 a108          	cp	a,#8
2604  0094 25ea          	jrult	L1161
2605                     ; 129 }
2608  0096 85            	popw	x
2609  0097 81            	ret
2653                     ; 132 char wire1_read_byte(void)
2653                     ; 133 {
2654                     	switch	.text
2655  0098               _wire1_read_byte:
2657  0098 89            	pushw	x
2658       00000002      OFST:	set	2
2661                     ; 135 ii=0;
2663  0099 0f02          	clr	(OFST+0,sp)
2664                     ; 137 for(i=0;i<8;i++)
2666  009b 0f01          	clr	(OFST-1,sp)
2667  009d               L5461:
2668                     ; 139 	ii>>=1;
2670  009d 0402          	srl	(OFST+0,sp)
2671                     ; 140 	if(wire1_rts())ii|=0x80;
2673  009f ad1d          	call	_wire1_rts
2675  00a1 4d            	tnz	a
2676  00a2 2708          	jreq	L3561
2679  00a4 7b02          	ld	a,(OFST+0,sp)
2680  00a6 aa80          	or	a,#128
2681  00a8 6b02          	ld	(OFST+0,sp),a
2683  00aa 2006          	jra	L5561
2684  00ac               L3561:
2685                     ; 141 	else ii&=0x7f;
2687  00ac 7b02          	ld	a,(OFST+0,sp)
2688  00ae a47f          	and	a,#127
2689  00b0 6b02          	ld	(OFST+0,sp),a
2690  00b2               L5561:
2691                     ; 137 for(i=0;i<8;i++)
2693  00b2 0c01          	inc	(OFST-1,sp)
2696  00b4 7b01          	ld	a,(OFST-1,sp)
2697  00b6 a108          	cp	a,#8
2698  00b8 25e3          	jrult	L5461
2699                     ; 143 return ii;
2701  00ba 7b02          	ld	a,(OFST+0,sp)
2704  00bc 85            	popw	x
2705  00bd 81            	ret
2751                     ; 147 char wire1_rts(void)
2751                     ; 148 {
2752                     	switch	.text
2753  00be               _wire1_rts:
2755  00be 5204          	subw	sp,#4
2756       00000004      OFST:	set	4
2759                     ; 151 GPIOC->DDR|=(1<<7);
2761  00c0 721e500c      	bset	20492,#7
2762                     ; 152 GPIOC->ODR&=~(1<<7);
2764  00c4 721f500a      	bres	20490,#7
2765                     ; 155 for(i=0;i<2;i++)
2767  00c8 5f            	clrw	x
2768  00c9 1f03          	ldw	(OFST-1,sp),x
2769  00cb               L1071:
2770                     ; 157 	__nop();
2773  00cb 9d            nop
2775                     ; 155 for(i=0;i<2;i++)
2777  00cc 1e03          	ldw	x,(OFST-1,sp)
2778  00ce 1c0001        	addw	x,#1
2779  00d1 1f03          	ldw	(OFST-1,sp),x
2782  00d3 9c            	rvf
2783  00d4 1e03          	ldw	x,(OFST-1,sp)
2784  00d6 a30002        	cpw	x,#2
2785  00d9 2ff0          	jrslt	L1071
2786                     ; 160 GPIOC->ODR|=(1<<7);
2788  00db 721e500a      	bset	20490,#7
2789                     ; 162 for(i=0;i<10;i++)
2791  00df 5f            	clrw	x
2792  00e0 1f03          	ldw	(OFST-1,sp),x
2793  00e2               L7071:
2794                     ; 164 	__nop();
2797  00e2 9d            nop
2799                     ; 162 for(i=0;i<10;i++)
2801  00e3 1e03          	ldw	x,(OFST-1,sp)
2802  00e5 1c0001        	addw	x,#1
2803  00e8 1f03          	ldw	(OFST-1,sp),x
2806  00ea 9c            	rvf
2807  00eb 1e03          	ldw	x,(OFST-1,sp)
2808  00ed a3000a        	cpw	x,#10
2809  00f0 2ff0          	jrslt	L7071
2810                     ; 166 if(GPIOC->IDR&(1<<7))	ii=1;
2812  00f2 c6500b        	ld	a,20491
2813  00f5 a580          	bcp	a,#128
2814  00f7 2707          	jreq	L5171
2817  00f9 ae0001        	ldw	x,#1
2818  00fc 1f01          	ldw	(OFST-3,sp),x
2820  00fe 2003          	jra	L7171
2821  0100               L5171:
2822                     ; 167 else ii=0;
2824  0100 5f            	clrw	x
2825  0101 1f01          	ldw	(OFST-3,sp),x
2826  0103               L7171:
2827                     ; 170 for(i=0;i<50;i++)
2829  0103 5f            	clrw	x
2830  0104 1f03          	ldw	(OFST-1,sp),x
2831  0106               L1271:
2832                     ; 172 	__nop();
2835  0106 9d            nop
2837                     ; 170 for(i=0;i<50;i++)
2839  0107 1e03          	ldw	x,(OFST-1,sp)
2840  0109 1c0001        	addw	x,#1
2841  010c 1f03          	ldw	(OFST-1,sp),x
2844  010e 9c            	rvf
2845  010f 1e03          	ldw	x,(OFST-1,sp)
2846  0111 a30032        	cpw	x,#50
2847  0114 2ff0          	jrslt	L1271
2848                     ; 174 return ii;
2850  0116 7b02          	ld	a,(OFST-2,sp)
2853  0118 5b04          	addw	sp,#4
2854  011a 81            	ret
2901                     ; 177 char wire1_polling(void)
2901                     ; 178 {
2902                     	switch	.text
2903  011b               _wire1_polling:
2905  011b 5204          	subw	sp,#4
2906       00000004      OFST:	set	4
2909                     ; 180 GPIOC->CR1&=~(1<<7);
2911  011d 721f500d      	bres	20493,#7
2912                     ; 181 GPIOC->CR2&=~(1<<7);
2914  0121 721f500e      	bres	20494,#7
2915                     ; 182 GPIOC->DDR|=(1<<7);
2917  0125 721e500c      	bset	20492,#7
2918                     ; 185 GPIOC->ODR&=~(1<<7);
2920  0129 721f500a      	bres	20490,#7
2921                     ; 188 for(i=0;i<600;i++)
2923  012d 5f            	clrw	x
2924  012e 1f03          	ldw	(OFST-1,sp),x
2925  0130               L1671:
2926                     ; 190 	__nop();
2929  0130 9d            nop
2931                     ; 188 for(i=0;i<600;i++)
2933  0131 1e03          	ldw	x,(OFST-1,sp)
2934  0133 1c0001        	addw	x,#1
2935  0136 1f03          	ldw	(OFST-1,sp),x
2938  0138 9c            	rvf
2939  0139 1e03          	ldw	x,(OFST-1,sp)
2940  013b a30258        	cpw	x,#600
2941  013e 2ff0          	jrslt	L1671
2942                     ; 192 GPIOC->ODR|=(1<<7);
2944  0140 721e500a      	bset	20490,#7
2945                     ; 195 for(i=0;i<15;i++)
2947  0144 5f            	clrw	x
2948  0145 1f03          	ldw	(OFST-1,sp),x
2949  0147               L7671:
2950                     ; 197 	__nop();
2953  0147 9d            nop
2955                     ; 195 for(i=0;i<15;i++)
2957  0148 1e03          	ldw	x,(OFST-1,sp)
2958  014a 1c0001        	addw	x,#1
2959  014d 1f03          	ldw	(OFST-1,sp),x
2962  014f 9c            	rvf
2963  0150 1e03          	ldw	x,(OFST-1,sp)
2964  0152 a3000f        	cpw	x,#15
2965  0155 2ff0          	jrslt	L7671
2966                     ; 201 for(i=0;i<20;i++)
2968  0157 5f            	clrw	x
2969  0158 1f03          	ldw	(OFST-1,sp),x
2970  015a               L5771:
2971                     ; 203 	__nop();
2974  015a 9d            nop
2976                     ; 204 	__nop();
2979  015b 9d            nop
2981                     ; 205 	__nop();
2984  015c 9d            nop
2986                     ; 206 	if(!(GPIOC->IDR&(1<<7)))goto ibatton_polling_lbl_000;
2988  015d c6500b        	ld	a,20491
2989  0160 a580          	bcp	a,#128
2990  0162 2623          	jrne	L3002
2992                     ; 210 ibatton_polling_lbl_000:
2992                     ; 211 
2992                     ; 212 //измеряем длительность ответного импульса не дольше 300мкс
2992                     ; 213 for(i=0;i<220;i++)
2994  0164 5f            	clrw	x
2995  0165 1f03          	ldw	(OFST-1,sp),x
2996  0167               L5002:
2997                     ; 215 	if(GPIOC->IDR&(1<<7))
2999  0167 c6500b        	ld	a,20491
3000  016a a580          	bcp	a,#128
3001  016c 272c          	jreq	L3102
3002                     ; 217 		__nop();
3005  016e 9d            nop
3007                     ; 218 		__nop();
3010  016f 9d            nop
3012                     ; 219 		num_out=10;
3014                     ; 220 		goto ibatton_polling_lbl_001;	//continue;
3015                     ; 227 ibatton_polling_lbl_001:
3015                     ; 228 //выдержка 15мкс
3015                     ; 229 for(i=0;i<30;i++)
3017  0170 5f            	clrw	x
3018  0171 1f03          	ldw	(OFST-1,sp),x
3019  0173               L5102:
3020                     ; 231 	__nop();
3023  0173 9d            nop
3025                     ; 229 for(i=0;i<30;i++)
3027  0174 1e03          	ldw	x,(OFST-1,sp)
3028  0176 1c0001        	addw	x,#1
3029  0179 1f03          	ldw	(OFST-1,sp),x
3032  017b 9c            	rvf
3033  017c 1e03          	ldw	x,(OFST-1,sp)
3034  017e a3001e        	cpw	x,#30
3035  0181 2ff0          	jrslt	L5102
3036                     ; 233 ibatton_polling_lbl_success_exit:
3036                     ; 234 return 1;
3038  0183 a601          	ld	a,#1
3040  0185 2010          	jra	L22
3041  0187               L3002:
3042                     ; 201 for(i=0;i<20;i++)
3044  0187 1e03          	ldw	x,(OFST-1,sp)
3045  0189 1c0001        	addw	x,#1
3046  018c 1f03          	ldw	(OFST-1,sp),x
3049  018e 9c            	rvf
3050  018f 1e03          	ldw	x,(OFST-1,sp)
3051  0191 a30014        	cpw	x,#20
3052  0194 2fc4          	jrslt	L5771
3053                     ; 209 return 0;
3055  0196 4f            	clr	a
3057  0197               L22:
3059  0197 5b04          	addw	sp,#4
3060  0199 81            	ret
3061  019a               L3102:
3062                     ; 213 for(i=0;i<220;i++)
3064  019a 1e03          	ldw	x,(OFST-1,sp)
3065  019c 1c0001        	addw	x,#1
3066  019f 1f03          	ldw	(OFST-1,sp),x
3069  01a1 9c            	rvf
3070  01a2 1e03          	ldw	x,(OFST-1,sp)
3071  01a4 a300dc        	cpw	x,#220
3072  01a7 2fbe          	jrslt	L5002
3073                     ; 225 return 5;
3075  01a9 a605          	ld	a,#5
3077  01ab 20ea          	jra	L22
3100                     ; 240 void uart_init (void)
3100                     ; 241 {
3101                     	switch	.text
3102  01ad               _uart_init:
3106                     ; 242 GPIOD->DDR&=~(1<<5);	
3108  01ad 721b5011      	bres	20497,#5
3109                     ; 243 GPIOD->CR1|=(1<<5);
3111  01b1 721a5012      	bset	20498,#5
3112                     ; 244 GPIOD->CR2&=~(1<<5);
3114  01b5 721b5013      	bres	20499,#5
3115                     ; 246 UART1->CR1&=~UART1_CR1_M;					
3117  01b9 72195234      	bres	21044,#4
3118                     ; 247 UART1->CR3|= (0<<4) & UART1_CR3_STOP;	
3120  01bd c65236        	ld	a,21046
3121                     ; 248 UART1->BRR2= 0x03;
3123  01c0 35035233      	mov	21043,#3
3124                     ; 249 UART1->BRR1= 0x68;
3126  01c4 35685232      	mov	21042,#104
3127                     ; 250 UART1->CR2|= UART1_CR2_TEN /*| UART3_CR2_REN | UART3_CR2_RIEN*/;	
3129  01c8 72165235      	bset	21045,#3
3130                     ; 251 }
3133  01cc 81            	ret
3170                     ; 254 void putchar(char c)
3170                     ; 255 {
3171                     	switch	.text
3172  01cd               _putchar:
3174  01cd 88            	push	a
3175       00000000      OFST:	set	0
3178  01ce               L3502:
3179                     ; 256 while (tx_counter == TX_BUFFER_SIZE);
3181  01ce c60000        	ld	a,_tx_counter
3182  01d1 a11e          	cp	a,#30
3183  01d3 27f9          	jreq	L3502
3184                     ; 258 if (tx_counter || ((UART1->SR & UART1_SR_TXE)==0))
3186  01d5 725d0000      	tnz	_tx_counter
3187  01d9 2607          	jrne	L1602
3189  01db c65230        	ld	a,21040
3190  01de a580          	bcp	a,#128
3191  01e0 2620          	jrne	L7502
3192  01e2               L1602:
3193                     ; 260    tx_buffer[tx_wr_index]=c;
3195  01e2 5f            	clrw	x
3196  01e3 b66f          	ld	a,_tx_wr_index
3197  01e5 2a01          	jrpl	L03
3198  01e7 53            	cplw	x
3199  01e8               L03:
3200  01e8 97            	ld	xl,a
3201  01e9 7b01          	ld	a,(OFST+1,sp)
3202  01eb d70008        	ld	(_tx_buffer,x),a
3203                     ; 261    if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
3205  01ee 3c6f          	inc	_tx_wr_index
3206  01f0 b66f          	ld	a,_tx_wr_index
3207  01f2 a11e          	cp	a,#30
3208  01f4 2602          	jrne	L3602
3211  01f6 3f6f          	clr	_tx_wr_index
3212  01f8               L3602:
3213                     ; 262    ++tx_counter;
3215  01f8 725c0000      	inc	_tx_counter
3217  01fc               L5602:
3218                     ; 266 UART1->CR2|= UART1_CR2_TIEN;
3220  01fc 721e5235      	bset	21045,#7
3221                     ; 268 }
3224  0200 84            	pop	a
3225  0201 81            	ret
3226  0202               L7502:
3227                     ; 264 else UART1->DR=c;
3229  0202 7b01          	ld	a,(OFST+1,sp)
3230  0204 c75231        	ld	21041,a
3231  0207 20f3          	jra	L5602
3257                     ; 271 void watchdog_enable(void)
3257                     ; 272 {
3258                     	switch	.text
3259  0209               _watchdog_enable:
3263                     ; 273 IWDG_KR=KEY_ENABLE;
3265  0209 35cc50e0      	mov	_IWDG_KR,#204
3266                     ; 274 IWDG_KR=KEY_ACCESS;
3268  020d 355550e0      	mov	_IWDG_KR,#85
3269                     ; 275 IWDG_PR=6;
3271  0211 350650e1      	mov	_IWDG_PR,#6
3272                     ; 276 IWDG_RLR=250;
3274  0215 35fa50e2      	mov	_IWDG_RLR,#250
3275                     ; 278 }
3278  0219 81            	ret
3310                     ; 284 @far @interrupt void TIM4_UPD_Interrupt (void) 
3310                     ; 285 {
3312                     	switch	.text
3313  021a               f_TIM4_UPD_Interrupt:
3317                     ; 286 if(++t0_cnt0>=125)
3319  021a 725c0004      	inc	L1541_t0_cnt0
3320  021e c60004        	ld	a,L1541_t0_cnt0
3321  0221 a17d          	cp	a,#125
3322  0223 2543          	jrult	L7012
3323                     ; 288   t0_cnt0=0;
3325  0225 725f0004      	clr	L1541_t0_cnt0
3326                     ; 289   b100Hz=1;
3328  0229 35010000      	mov	_b100Hz,#1
3329                     ; 292 	if(++t0_cnt1>=10)
3331  022d 725c0005      	inc	L3541_t0_cnt1
3332  0231 c60005        	ld	a,L3541_t0_cnt1
3333  0234 a10a          	cp	a,#10
3334  0236 2508          	jrult	L1112
3335                     ; 294 		t0_cnt1=0;
3337  0238 725f0005      	clr	L3541_t0_cnt1
3338                     ; 295 		b10Hz=1;
3340  023c 35010001      	mov	_b10Hz,#1
3341  0240               L1112:
3342                     ; 299 	if(++t0_cnt2>=20)
3344  0240 725c0006      	inc	L5541_t0_cnt2
3345  0244 c60006        	ld	a,L5541_t0_cnt2
3346  0247 a114          	cp	a,#20
3347  0249 2508          	jrult	L3112
3348                     ; 301 		t0_cnt2=0;
3350  024b 725f0006      	clr	L5541_t0_cnt2
3351                     ; 302 		b5Hz=1;
3353  024f 35010002      	mov	_b5Hz,#1
3354  0253               L3112:
3355                     ; 306 	if(++t0_cnt3>=100)
3357  0253 725c0007      	inc	L7541_t0_cnt3
3358  0257 c60007        	ld	a,L7541_t0_cnt3
3359  025a a164          	cp	a,#100
3360  025c 250a          	jrult	L7012
3361                     ; 308 		t0_cnt3=0;
3363  025e 725f0007      	clr	L7541_t0_cnt3
3364                     ; 309 		b1Hz=1;
3366  0262 35010003      	mov	_b1Hz,#1
3367                     ; 310 		bWFI=0;
3369  0266 3f04          	clr	_bWFI
3370  0268               L7012:
3371                     ; 313 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
3373  0268 72115344      	bres	21316,#0
3374                     ; 314 return;
3377  026c 80            	iret
3404                     ; 318 @far @interrupt void UARTTxInterrupt (void) 
3404                     ; 319 {
3405                     	switch	.text
3406  026d               f_UARTTxInterrupt:
3410                     ; 320 if (tx_counter)
3412  026d 725d0000      	tnz	_tx_counter
3413  0271 271d          	jreq	L7212
3414                     ; 322 	--tx_counter;
3416  0273 725a0000      	dec	_tx_counter
3417                     ; 323 	UART1->DR=tx_buffer[tx_rd_index];
3419  0277 5f            	clrw	x
3420  0278 b66e          	ld	a,_tx_rd_index
3421  027a 2a01          	jrpl	L04
3422  027c 53            	cplw	x
3423  027d               L04:
3424  027d 97            	ld	xl,a
3425  027e d60008        	ld	a,(_tx_buffer,x)
3426  0281 c75231        	ld	21041,a
3427                     ; 324 	if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
3429  0284 3c6e          	inc	_tx_rd_index
3430  0286 b66e          	ld	a,_tx_rd_index
3431  0288 a11e          	cp	a,#30
3432  028a 2610          	jrne	L3312
3435  028c 3f6e          	clr	_tx_rd_index
3436  028e 200c          	jra	L3312
3437  0290               L7212:
3438                     ; 329 	UART1->CR2&= ~UART1_CR2_TIEN;
3440  0290 721f5235      	bres	21045,#7
3441                     ; 330 	bWFI=1;
3443  0294 35010004      	mov	_bWFI,#1
3444                     ; 333 	powerOffTimer=2;
3446  0298 35020002      	mov	_powerOffTimer,#2
3447  029c               L3312:
3448                     ; 337 }
3451  029c 80            	iret
3473                     ; 340 @far @interrupt void UARTRxInterrupt (void) 
3473                     ; 341 {
3474                     	switch	.text
3475  029d               f_UARTRxInterrupt:
3479                     ; 343 }
3482  029d 80            	iret
3574                     ; 349 main()
3574                     ; 350 {
3576                     	switch	.text
3577  029e               _main:
3579  029e 5209          	subw	sp,#9
3580       00000009      OFST:	set	9
3583                     ; 352 CLK->CKDIVR=0;
3585  02a0 725f50c6      	clr	20678
3586                     ; 354 GPIOC->DDR|=(1<<6);
3588  02a4 721c500c      	bset	20492,#6
3589                     ; 355 GPIOC->CR1|=(1<<6);
3591  02a8 721c500d      	bset	20493,#6
3592                     ; 356 GPIOC->CR2|=(1<<6);
3594  02ac 721c500e      	bset	20494,#6
3595                     ; 358 FLASH_DUKR=0xae;
3597  02b0 35ae5064      	mov	_FLASH_DUKR,#174
3598                     ; 359 FLASH_DUKR=0x56;
3600  02b4 35565064      	mov	_FLASH_DUKR,#86
3601                     ; 361 plazma_ee++;
3603  02b8 c60000        	ld	a,_plazma_ee
3604  02bb 4c            	inc	a
3605  02bc ae0000        	ldw	x,#_plazma_ee
3606  02bf cd0000        	call	c_eewrc
3608                     ; 362 if(plazma_ee>=80)plazma_ee=0;
3610  02c2 c60000        	ld	a,_plazma_ee
3611  02c5 a150          	cp	a,#80
3612  02c7 2507          	jrult	L7712
3615  02c9 4f            	clr	a
3616  02ca ae0000        	ldw	x,#_plazma_ee
3617  02cd cd0000        	call	c_eewrc
3619  02d0               L7712:
3620                     ; 385 sensor=sensOFF;
3622  02d0 3f03          	clr	_sensor
3623                     ; 387 t4_init();
3625  02d2 cd0000        	call	_t4_init
3627                     ; 388 uart_init();
3629  02d5 cd01ad        	call	_uart_init
3631                     ; 389 enableInterrupts();
3634  02d8 9a            rim
3636                     ; 390 watchdog_enable();
3639  02d9 cd0209        	call	_watchdog_enable
3641                     ; 392 i2c_setup();
3643  02dc cd0000        	call	_i2c_setup
3645                     ; 393 buff11[0]=1;
3647  02df a601          	ld	a,#1
3648  02e1 6b07          	ld	(OFST-2,sp),a
3649                     ; 394 buff11[1]=0x40;
3651  02e3 a640          	ld	a,#64
3652  02e5 6b08          	ld	(OFST-1,sp),a
3653                     ; 395 i2c_7bit_send(buff11, 2, 0);
3655  02e7 4b00          	push	#0
3656  02e9 4b02          	push	#2
3657  02eb 96            	ldw	x,sp
3658  02ec 1c0009        	addw	x,#OFST+0
3659  02ef cd0000        	call	_i2c_7bit_send
3661  02f2 85            	popw	x
3662                     ; 413 			i2c_setup();
3664  02f3 cd0000        	call	_i2c_setup
3666                     ; 414 			i2c_7bit_send_onebyte(0, 1);
3668  02f6 ae0001        	ldw	x,#1
3669  02f9 4f            	clr	a
3670  02fa 95            	ld	xh,a
3671  02fb cd0000        	call	_i2c_7bit_send_onebyte
3673                     ; 415 			temper=i2c_7bit_receive_twobyte((char*)&i2c_temp,0);
3675  02fe 4b00          	push	#0
3676  0300 ae0000        	ldw	x,#_i2c_temp
3677  0303 cd0000        	call	_i2c_7bit_receive_twobyte
3679  0306 5b01          	addw	sp,#1
3680  0308 5f            	clrw	x
3681  0309 97            	ld	xl,a
3682  030a bf7d          	ldw	_temper,x
3683                     ; 416 			if(temper!=I2C_OK)printf("ERRORHI\n");
3685  030c be7d          	ldw	x,_temper
3686  030e 2708          	jreq	L1022
3689  0310 ae0022        	ldw	x,#L3022
3690  0313 cd0000        	call	_printf
3693  0316 2068          	jra	L1122
3694  0318               L1022:
3695                     ; 419 				temper_1=i2c_temp>>8;
3697  0318 be00          	ldw	x,_i2c_temp
3698  031a 4f            	clr	a
3699  031b 5d            	tnzw	x
3700  031c 2a01          	jrpl	L64
3701  031e 43            	cpl	a
3702  031f               L64:
3703  031f 97            	ld	xl,a
3704  0320 5e            	swapw	x
3705  0321 bf7b          	ldw	_temper_1,x
3706                     ; 420 				temper_2=(((short)(((char)(i2c_temp))>>5))*125)/100;
3708  0323 b601          	ld	a,_i2c_temp+1
3709  0325 4e            	swap	a
3710  0326 44            	srl	a
3711  0327 a407          	and	a,#7
3712  0329 5f            	clrw	x
3713  032a 97            	ld	xl,a
3714  032b 90ae007d      	ldw	y,#125
3715  032f cd0000        	call	c_imul
3717  0332 a664          	ld	a,#100
3718  0334 cd0000        	call	c_sdivx
3720  0337 bf79          	ldw	_temper_2,x
3721                     ; 421 				temperCRC = (temper%10)+((temper/10)%10)+((temper/100)%10);
3723  0339 be7d          	ldw	x,_temper
3724  033b a664          	ld	a,#100
3725  033d cd0000        	call	c_sdivx
3727  0340 a60a          	ld	a,#10
3728  0342 cd0000        	call	c_smodx
3730  0345 1f03          	ldw	(OFST-6,sp),x
3731  0347 be7d          	ldw	x,_temper
3732  0349 a60a          	ld	a,#10
3733  034b cd0000        	call	c_sdivx
3735  034e a60a          	ld	a,#10
3736  0350 cd0000        	call	c_smodx
3738  0353 1f01          	ldw	(OFST-8,sp),x
3739  0355 be7d          	ldw	x,_temper
3740  0357 a60a          	ld	a,#10
3741  0359 cd0000        	call	c_smodx
3743  035c 72fb01        	addw	x,(OFST-8,sp)
3744  035f 72fb03        	addw	x,(OFST-6,sp)
3745  0362 bf77          	ldw	_temperCRC,x
3746                     ; 422 				temperCRC*=-1;
3748  0364 be77          	ldw	x,_temperCRC
3749  0366 50            	negw	x
3750  0367 bf77          	ldw	_temperCRC,x
3751                     ; 423 				temperCRC=-33;
3753  0369 aeffdf        	ldw	x,#65503
3754  036c bf77          	ldw	_temperCRC,x
3755                     ; 424 				printf("OK%d.%dCRC%d\n",temper_1,temper_2,temperCRC);
3757  036e aeffdf        	ldw	x,#65503
3758  0371 89            	pushw	x
3759  0372 be79          	ldw	x,_temper_2
3760  0374 89            	pushw	x
3761  0375 be7b          	ldw	x,_temper_1
3762  0377 89            	pushw	x
3763  0378 ae0014        	ldw	x,#L7022
3764  037b cd0000        	call	_printf
3766  037e 5b06          	addw	sp,#6
3767  0380               L1122:
3768                     ; 441 	if(b100Hz)
3770  0380 725d0000      	tnz	_b100Hz
3771  0384 270f          	jreq	L5122
3772                     ; 443 		b100Hz=0;
3774  0386 725f0000      	clr	_b100Hz
3775                     ; 444 if(powerOffTimer)
3777  038a 3d02          	tnz	_powerOffTimer
3778  038c 2707          	jreq	L5122
3779                     ; 446 	powerOffTimer--;
3781  038e 3a02          	dec	_powerOffTimer
3782                     ; 447 	if(!powerOffTimer)halt();
3784  0390 3d02          	tnz	_powerOffTimer
3785  0392 2601          	jrne	L5122
3789  0394 8e            halt
3791  0395               L5122:
3792                     ; 455 	if(b10Hz)
3794  0395 725d0001      	tnz	_b10Hz
3795  0399 2704          	jreq	L3222
3796                     ; 457 		b10Hz=0;
3798  039b 725f0001      	clr	_b10Hz
3799  039f               L3222:
3800                     ; 464 	if(b5Hz)
3802  039f 725d0002      	tnz	_b5Hz
3803  03a3 2704          	jreq	L5222
3804                     ; 466 		b5Hz=0;
3806  03a5 725f0002      	clr	_b5Hz
3807  03a9               L5222:
3808                     ; 472 	if(b1Hz)
3810  03a9 725d0003      	tnz	_b1Hz
3811  03ad 27d1          	jreq	L1122
3812                     ; 474 		b1Hz=0;
3814  03af 725f0003      	clr	_b1Hz
3815                     ; 479 		if(sensor==sens18B20)
3817  03b3 b603          	ld	a,_sensor
3818  03b5 a101          	cp	a,#1
3819  03b7 2703          	jreq	L45
3820  03b9 cc0527        	jp	L1322
3821  03bc               L45:
3822                     ; 482 			if(!bCONV)
3824  03bc 3d70          	tnz	_bCONV
3825  03be 265a          	jrne	L3322
3826                     ; 485 				bCONV=1;
3828  03c0 35010070      	mov	_bCONV,#1
3829                     ; 486 				temp=wire1_polling();
3831  03c4 cd011b        	call	_wire1_polling
3833  03c7 6b06          	ld	(OFST-3,sp),a
3834                     ; 487 				if(temp==1)
3836  03c9 7b06          	ld	a,(OFST-3,sp)
3837  03cb a101          	cp	a,#1
3838  03cd 2616          	jrne	L5322
3839                     ; 489 					wire1_send_byte(0xCC);
3841  03cf a6cc          	ld	a,#204
3842  03d1 cd007b        	call	_wire1_send_byte
3844                     ; 490 					wire1_send_byte(0x44);
3846  03d4 a644          	ld	a,#68
3847  03d6 cd007b        	call	_wire1_send_byte
3849                     ; 492 					ds18b20ErrorHiCnt=0;
3851  03d9 3f81          	clr	_ds18b20ErrorHiCnt
3852                     ; 493 					ds18b20ErrorLoCnt=0;
3854  03db 3f80          	clr	_ds18b20ErrorLoCnt
3855                     ; 494 					airSensorErrorStat=esNORM;		
3857  03dd 35550000      	mov	_airSensorErrorStat,#85
3859  03e1 ac980498      	jpf	L5522
3860  03e5               L5322:
3861                     ; 498 					if(temp==0)
3863  03e5 0d06          	tnz	(OFST-3,sp)
3864  03e7 2614          	jrne	L1422
3865                     ; 500 						if(ds18b20ErrorHiCnt<10)
3867  03e9 b681          	ld	a,_ds18b20ErrorHiCnt
3868  03eb a10a          	cp	a,#10
3869  03ed 240c          	jruge	L3422
3870                     ; 502 							ds18b20ErrorHiCnt++;
3872  03ef 3c81          	inc	_ds18b20ErrorHiCnt
3873                     ; 503 							if(ds18b20ErrorHiCnt>=10)
3875  03f1 b681          	ld	a,_ds18b20ErrorHiCnt
3876  03f3 a10a          	cp	a,#10
3877  03f5 2504          	jrult	L3422
3878                     ; 505 								airSensorErrorStat=esHI;	
3880  03f7 35010000      	mov	_airSensorErrorStat,#1
3881  03fb               L3422:
3882                     ; 508 						ds18b20ErrorLoCnt=0;
3884  03fb 3f80          	clr	_ds18b20ErrorLoCnt
3885  03fd               L1422:
3886                     ; 511 					if(temp==5)
3888  03fd 7b06          	ld	a,(OFST-3,sp)
3889  03ff a105          	cp	a,#5
3890  0401 2703          	jreq	L65
3891  0403 cc0498        	jp	L5522
3892  0406               L65:
3893                     ; 513 						if(ds18b20ErrorLoCnt<10)
3895  0406 b680          	ld	a,_ds18b20ErrorLoCnt
3896  0408 a10a          	cp	a,#10
3897  040a 240a          	jruge	L1522
3898                     ; 515 							ds18b20ErrorLoCnt++;
3900  040c 3c80          	inc	_ds18b20ErrorLoCnt
3901                     ; 516 							if(ds18b20ErrorLoCnt>=10)
3903  040e b680          	ld	a,_ds18b20ErrorLoCnt
3904  0410 a10a          	cp	a,#10
3905  0412 2502          	jrult	L1522
3906                     ; 518 								airSensorErrorStat=esLO;	
3908  0414 3f00          	clr	_airSensorErrorStat
3909  0416               L1522:
3910                     ; 521 						ds18b20ErrorHiCnt=0;
3912  0416 3f81          	clr	_ds18b20ErrorHiCnt
3913  0418 207e          	jra	L5522
3914  041a               L3322:
3915                     ; 529 				bCONV=0;
3917  041a 3f70          	clr	_bCONV
3918                     ; 530 				temp=wire1_polling();
3920  041c cd011b        	call	_wire1_polling
3922  041f 6b06          	ld	(OFST-3,sp),a
3923                     ; 531 				if(temp==1)
3925  0421 7b06          	ld	a,(OFST-3,sp)
3926  0423 a101          	cp	a,#1
3927  0425 2641          	jrne	L7522
3928                     ; 533 					wire1_send_byte(0xCC);
3930  0427 a6cc          	ld	a,#204
3931  0429 cd007b        	call	_wire1_send_byte
3933                     ; 534 					wire1_send_byte(0xBE);
3935  042c a6be          	ld	a,#190
3936  042e cd007b        	call	_wire1_send_byte
3938                     ; 535 					wire1_in[0]=wire1_read_byte();
3940  0431 cd0098        	call	_wire1_read_byte
3942  0434 b782          	ld	_wire1_in,a
3943                     ; 536 					wire1_in[1]=wire1_read_byte();
3945  0436 cd0098        	call	_wire1_read_byte
3947  0439 b783          	ld	_wire1_in+1,a
3948                     ; 537 					wire1_in[2]=wire1_read_byte();
3950  043b cd0098        	call	_wire1_read_byte
3952  043e b784          	ld	_wire1_in+2,a
3953                     ; 538 					wire1_in[3]=wire1_read_byte();
3955  0440 cd0098        	call	_wire1_read_byte
3957  0443 b785          	ld	_wire1_in+3,a
3958                     ; 539 					wire1_in[4]=wire1_read_byte();
3960  0445 cd0098        	call	_wire1_read_byte
3962  0448 b786          	ld	_wire1_in+4,a
3963                     ; 540 					wire1_in[5]=wire1_read_byte();
3965  044a cd0098        	call	_wire1_read_byte
3967  044d b787          	ld	_wire1_in+5,a
3968                     ; 541 					wire1_in[6]=wire1_read_byte();
3970  044f cd0098        	call	_wire1_read_byte
3972  0452 b788          	ld	_wire1_in+6,a
3973                     ; 542 					wire1_in[7]=wire1_read_byte();
3975  0454 cd0098        	call	_wire1_read_byte
3977  0457 b789          	ld	_wire1_in+7,a
3978                     ; 543 					wire1_in[8]=wire1_read_byte();
3980  0459 cd0098        	call	_wire1_read_byte
3982  045c b78a          	ld	_wire1_in+8,a
3983                     ; 545 					ds18b20ErrorHiCnt=0;
3985  045e 3f81          	clr	_ds18b20ErrorHiCnt
3986                     ; 546 					ds18b20ErrorLoCnt=0;
3988  0460 3f80          	clr	_ds18b20ErrorLoCnt
3989                     ; 547 					airSensorErrorStat=esNORM;
3991  0462 35550000      	mov	_airSensorErrorStat,#85
3993  0466 2030          	jra	L5522
3994  0468               L7522:
3995                     ; 551 					if(temp==0)
3997  0468 0d06          	tnz	(OFST-3,sp)
3998  046a 2614          	jrne	L3622
3999                     ; 553 						if(ds18b20ErrorHiCnt<10)
4001  046c b681          	ld	a,_ds18b20ErrorHiCnt
4002  046e a10a          	cp	a,#10
4003  0470 240c          	jruge	L5622
4004                     ; 555 							ds18b20ErrorHiCnt++;
4006  0472 3c81          	inc	_ds18b20ErrorHiCnt
4007                     ; 556 							if(ds18b20ErrorHiCnt>=10)
4009  0474 b681          	ld	a,_ds18b20ErrorHiCnt
4010  0476 a10a          	cp	a,#10
4011  0478 2504          	jrult	L5622
4012                     ; 558 								airSensorErrorStat=esHI;	
4014  047a 35010000      	mov	_airSensorErrorStat,#1
4015  047e               L5622:
4016                     ; 561 						ds18b20ErrorLoCnt=0;
4018  047e 3f80          	clr	_ds18b20ErrorLoCnt
4019  0480               L3622:
4020                     ; 564 					if(temp==5)
4022  0480 7b06          	ld	a,(OFST-3,sp)
4023  0482 a105          	cp	a,#5
4024  0484 2612          	jrne	L5522
4025                     ; 566 						if(ds18b20ErrorLoCnt<10)
4027  0486 b680          	ld	a,_ds18b20ErrorLoCnt
4028  0488 a10a          	cp	a,#10
4029  048a 240a          	jruge	L3722
4030                     ; 568 							ds18b20ErrorLoCnt++;
4032  048c 3c80          	inc	_ds18b20ErrorLoCnt
4033                     ; 569 							if(ds18b20ErrorLoCnt>=10)
4035  048e b680          	ld	a,_ds18b20ErrorLoCnt
4036  0490 a10a          	cp	a,#10
4037  0492 2502          	jrult	L3722
4038                     ; 571 								airSensorErrorStat=esLO;	
4040  0494 3f00          	clr	_airSensorErrorStat
4041  0496               L3722:
4042                     ; 574 						ds18b20ErrorHiCnt=0;
4044  0496 3f81          	clr	_ds18b20ErrorHiCnt
4045  0498               L5522:
4046                     ; 580 			if(wire1_in[1]&0xf0)
4048  0498 b683          	ld	a,_wire1_in+1
4049  049a a5f0          	bcp	a,#240
4050  049c 2620          	jrne	L1032
4052                     ; 588 				temper_temp=(((short)wire1_in[1])<<8)+((short)wire1_in[0]);
4054  049e b682          	ld	a,_wire1_in
4055  04a0 5f            	clrw	x
4056  04a1 97            	ld	xl,a
4057  04a2 1f03          	ldw	(OFST-6,sp),x
4058  04a4 b683          	ld	a,_wire1_in+1
4059  04a6 5f            	clrw	x
4060  04a7 97            	ld	xl,a
4061  04a8 4f            	clr	a
4062  04a9 02            	rlwa	x,a
4063  04aa 72fb03        	addw	x,(OFST-6,sp)
4064  04ad 1f05          	ldw	(OFST-4,sp),x
4065                     ; 589 				temper_temp>>=4;
4067  04af a604          	ld	a,#4
4068  04b1               L05:
4069  04b1 0705          	sra	(OFST-4,sp)
4070  04b3 0606          	rrc	(OFST-3,sp)
4071  04b5 4a            	dec	a
4072  04b6 26f9          	jrne	L05
4073                     ; 590 				temper_temp&=0x00ff;
4075  04b8 0f05          	clr	(OFST-4,sp)
4076                     ; 592 				temper=(short)temper_temp;
4078  04ba 1e05          	ldw	x,(OFST-4,sp)
4079  04bc bf7d          	ldw	_temper,x
4080  04be               L1032:
4081                     ; 595 			temperCRC = (temper%10)+((temper/10)%10)+((temper/100)%10);
4083  04be be7d          	ldw	x,_temper
4084  04c0 a664          	ld	a,#100
4085  04c2 cd0000        	call	c_sdivx
4087  04c5 a60a          	ld	a,#10
4088  04c7 cd0000        	call	c_smodx
4090  04ca 1f03          	ldw	(OFST-6,sp),x
4091  04cc be7d          	ldw	x,_temper
4092  04ce a60a          	ld	a,#10
4093  04d0 cd0000        	call	c_sdivx
4095  04d3 a60a          	ld	a,#10
4096  04d5 cd0000        	call	c_smodx
4098  04d8 1f01          	ldw	(OFST-8,sp),x
4099  04da be7d          	ldw	x,_temper
4100  04dc a60a          	ld	a,#10
4101  04de cd0000        	call	c_smodx
4103  04e1 72fb01        	addw	x,(OFST-8,sp)
4104  04e4 72fb03        	addw	x,(OFST-6,sp)
4105  04e7 bf77          	ldw	_temperCRC,x
4106                     ; 596 			temperCRC*=-1;
4108  04e9 be77          	ldw	x,_temperCRC
4109  04eb 50            	negw	x
4110  04ec bf77          	ldw	_temperCRC,x
4111                     ; 618 			if(airSensorErrorStat==esHI) printf("ERRORHI\n");
4113  04ee b600          	ld	a,_airSensorErrorStat
4114  04f0 a101          	cp	a,#1
4115  04f2 260a          	jrne	L3032
4118  04f4 ae0022        	ldw	x,#L3022
4119  04f7 cd0000        	call	_printf
4122  04fa ac800380      	jpf	L1122
4123  04fe               L3032:
4124                     ; 619 			else if(airSensorErrorStat==esLO) printf("ERRORLO\n");
4126  04fe 3d00          	tnz	_airSensorErrorStat
4127  0500 260a          	jrne	L7032
4130  0502 ae000b        	ldw	x,#L1132
4131  0505 cd0000        	call	_printf
4134  0508 ac800380      	jpf	L1122
4135  050c               L7032:
4136                     ; 620 			else if(airSensorErrorStat==esNORM) printf("OK%dCRC%d\n",temper,temperCRC);
4138  050c b600          	ld	a,_airSensorErrorStat
4139  050e a155          	cp	a,#85
4140  0510 2703          	jreq	L06
4141  0512 cc0380        	jp	L1122
4142  0515               L06:
4145  0515 be77          	ldw	x,_temperCRC
4146  0517 89            	pushw	x
4147  0518 be7d          	ldw	x,_temper
4148  051a 89            	pushw	x
4149  051b ae0000        	ldw	x,#L7132
4150  051e cd0000        	call	_printf
4152  0521 5b04          	addw	sp,#4
4153  0523 ac800380      	jpf	L1122
4154  0527               L1322:
4155                     ; 622 		else if(sensor==sens1775)
4157  0527 b603          	ld	a,_sensor
4158  0529 a102          	cp	a,#2
4159  052b 2703          	jreq	L26
4160  052d cc0380        	jp	L1122
4161  0530               L26:
4162                     ; 624 			i2c_setup();
4164  0530 cd0000        	call	_i2c_setup
4166                     ; 625 			i2c_7bit_send_onebyte(0, 1);
4168  0533 ae0001        	ldw	x,#1
4169  0536 4f            	clr	a
4170  0537 95            	ld	xh,a
4171  0538 cd0000        	call	_i2c_7bit_send_onebyte
4173                     ; 626 			temper=i2c_7bit_receive_twobyte((char*)&i2c_temp,0);
4175  053b 4b00          	push	#0
4176  053d ae0000        	ldw	x,#_i2c_temp
4177  0540 cd0000        	call	_i2c_7bit_receive_twobyte
4179  0543 5b01          	addw	sp,#1
4180  0545 5f            	clrw	x
4181  0546 97            	ld	xl,a
4182  0547 bf7d          	ldw	_temper,x
4183                     ; 627 			if(temper!=I2C_OK)printf("ERRORHI\n");
4185  0549 be7d          	ldw	x,_temper
4186  054b 270a          	jreq	L5232
4189  054d ae0022        	ldw	x,#L3022
4190  0550 cd0000        	call	_printf
4193  0553 ac800380      	jpf	L1122
4194  0557               L5232:
4195                     ; 630 				temper_1=i2c_temp>>8;
4197  0557 be00          	ldw	x,_i2c_temp
4198  0559 4f            	clr	a
4199  055a 5d            	tnzw	x
4200  055b 2a01          	jrpl	L25
4201  055d 43            	cpl	a
4202  055e               L25:
4203  055e 97            	ld	xl,a
4204  055f 5e            	swapw	x
4205  0560 bf7b          	ldw	_temper_1,x
4206                     ; 631 				temper_2=(((short)(((char)(i2c_temp))>>5))*125)/100;
4208  0562 b601          	ld	a,_i2c_temp+1
4209  0564 4e            	swap	a
4210  0565 44            	srl	a
4211  0566 a407          	and	a,#7
4212  0568 5f            	clrw	x
4213  0569 97            	ld	xl,a
4214  056a 90ae007d      	ldw	y,#125
4215  056e cd0000        	call	c_imul
4217  0571 a664          	ld	a,#100
4218  0573 cd0000        	call	c_sdivx
4220  0576 bf79          	ldw	_temper_2,x
4221                     ; 632 				temperCRC = (temper%10)+((temper/10)%10)+((temper/100)%10);
4223  0578 be7d          	ldw	x,_temper
4224  057a a664          	ld	a,#100
4225  057c cd0000        	call	c_sdivx
4227  057f a60a          	ld	a,#10
4228  0581 cd0000        	call	c_smodx
4230  0584 1f03          	ldw	(OFST-6,sp),x
4231  0586 be7d          	ldw	x,_temper
4232  0588 a60a          	ld	a,#10
4233  058a cd0000        	call	c_sdivx
4235  058d a60a          	ld	a,#10
4236  058f cd0000        	call	c_smodx
4238  0592 1f01          	ldw	(OFST-8,sp),x
4239  0594 be7d          	ldw	x,_temper
4240  0596 a60a          	ld	a,#10
4241  0598 cd0000        	call	c_smodx
4243  059b 72fb01        	addw	x,(OFST-8,sp)
4244  059e 72fb03        	addw	x,(OFST-6,sp)
4245  05a1 bf77          	ldw	_temperCRC,x
4246                     ; 633 				temperCRC*=-1;
4248  05a3 be77          	ldw	x,_temperCRC
4249  05a5 50            	negw	x
4250  05a6 bf77          	ldw	_temperCRC,x
4251                     ; 634 				temperCRC=-33;
4253  05a8 aeffdf        	ldw	x,#65503
4254  05ab bf77          	ldw	_temperCRC,x
4255                     ; 635 				printf("OK%d.%dCRC%d\n",temper_1,temper_2,temperCRC);
4257  05ad aeffdf        	ldw	x,#65503
4258  05b0 89            	pushw	x
4259  05b1 be79          	ldw	x,_temper_2
4260  05b3 89            	pushw	x
4261  05b4 be7b          	ldw	x,_temper_1
4262  05b6 89            	pushw	x
4263  05b7 ae0014        	ldw	x,#L7022
4264  05ba cd0000        	call	_printf
4266  05bd 5b06          	addw	sp,#6
4267  05bf ac800380      	jpf	L1122
4696                     	xdef	_main
4697                     	xdef	f_UARTRxInterrupt
4698                     	xdef	f_UARTTxInterrupt
4699                     	xdef	f_TIM4_UPD_Interrupt
4700                     	xdef	_watchdog_enable
4701                     	xdef	_putchar
4702                     	xdef	_uart_init
4703                     	xdef	_wire1_polling
4704                     	xdef	_wire1_read_byte
4705                     	xdef	_wire1_send_byte
4706                     	xdef	_wire1_w0ts
4707                     	xdef	_wire1_w1ts
4708                     	xdef	_t4_init
4709                     	xdef	_bWFI
4710                     	switch	.ubsct
4711  0000               _i2c_temp:
4712  0000 0000          	ds.b	2
4713                     	xdef	_i2c_temp
4714  0002               _powerOffTimer:
4715  0002 00            	ds.b	1
4716                     	xdef	_powerOffTimer
4717                     .eeprom:	section	.data
4718  0000               _plazma_ee:
4719  0000 00            	ds.b	1
4720                     	xdef	_plazma_ee
4721                     	xdef	_temperdeb
4722                     	switch	.ubsct
4723  0003               _out_string2:
4724  0003 0000          	ds.b	2
4725                     	xdef	_out_string2
4726  0005               _out_string1:
4727  0005 0000          	ds.b	2
4728                     	xdef	_out_string1
4729  0007               _out_string:
4730  0007 0000          	ds.b	2
4731                     	xdef	_out_string
4732  0009               _buf:
4733  0009 000000000000  	ds.b	100
4734                     	xdef	_buf
4735  006d               _bOUT_FREE:
4736  006d 00            	ds.b	1
4737                     	xdef	_bOUT_FREE
4738  006e               _tx_rd_index:
4739  006e 00            	ds.b	1
4740                     	xdef	_tx_rd_index
4741  006f               _tx_wr_index:
4742  006f 00            	ds.b	1
4743                     	xdef	_tx_wr_index
4744                     	switch	.bss
4745  0000               _tx_counter:
4746  0000 00            	ds.b	1
4747                     	xdef	_tx_counter
4748                     	xdef	_tx_buffer
4749                     	switch	.ubsct
4750  0070               _bCONV:
4751  0070 00            	ds.b	1
4752                     	xdef	_bCONV
4753  0071               _out_buff_digits:
4754  0071 0000          	ds.b	2
4755                     	xdef	_out_buff_digits
4756  0073               _out_buff_preffiks:
4757  0073 0000          	ds.b	2
4758                     	xdef	_out_buff_preffiks
4759  0075               _out_buff:
4760  0075 0000          	ds.b	2
4761                     	xdef	_out_buff
4762  0077               _temperCRC:
4763  0077 0000          	ds.b	2
4764                     	xdef	_temperCRC
4765  0079               _temper_2:
4766  0079 0000          	ds.b	2
4767                     	xdef	_temper_2
4768  007b               _temper_1:
4769  007b 0000          	ds.b	2
4770                     	xdef	_temper_1
4771  007d               _temper:
4772  007d 0000          	ds.b	2
4773                     	xdef	_temper
4774                     	xdef	_b1Hz
4775                     	xdef	_b5Hz
4776                     	xdef	_b10Hz
4777                     	xdef	_b100Hz
4778                     	xref	_i2c_7bit_send
4779                     	xref	_i2c_7bit_receive_twobyte
4780                     	xref	_i2c_7bit_send_onebyte
4781                     	xref	_i2c_setup
4782                     	xref	_printf
4783                     	xdef	_wire1_rts
4784                     	xdef	_sensor
4785                     	xdef	_airSensorErrorStat
4786  007f               _ds18b20ErrorOffCnt:
4787  007f 00            	ds.b	1
4788                     	xdef	_ds18b20ErrorOffCnt
4789  0080               _ds18b20ErrorLoCnt:
4790  0080 00            	ds.b	1
4791                     	xdef	_ds18b20ErrorLoCnt
4792  0081               _ds18b20ErrorHiCnt:
4793  0081 00            	ds.b	1
4794                     	xdef	_ds18b20ErrorHiCnt
4795  0082               _wire1_in:
4796  0082 000000000000  	ds.b	10
4797                     	xdef	_wire1_in
4798                     .const:	section	.text
4799  0000               L7132:
4800  0000 4f4b25644352  	dc.b	"OK%dCRC%d",10,0
4801  000b               L1132:
4802  000b 4552524f524c  	dc.b	"ERRORLO",10,0
4803  0014               L7022:
4804  0014 4f4b25642e25  	dc.b	"OK%d.%dCRC%d",10,0
4805  0022               L3022:
4806  0022 4552524f5248  	dc.b	"ERRORHI",10,0
4807                     	xref.b	c_x
4827                     	xref	c_smody
4828                     	xref	c_sdivy
4829                     	xref	c_smodx
4830                     	xref	c_sdivx
4831                     	xref	c_imul
4832                     	xref	c_eewrc
4833                     	end
