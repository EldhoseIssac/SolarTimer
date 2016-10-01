
_initTmr1:

;tmr1.c,1 :: 		void initTmr1(){
;tmr1.c,2 :: 		T1CON=0x30;
	MOVLW      48
	MOVWF      T1CON+0
;tmr1.c,3 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;tmr1.c,4 :: 		INTCON.PEIE=1;
	BSF        INTCON+0, 6
;tmr1.c,5 :: 		T1CON.TMR1ON=0;
	BCF        T1CON+0, 0
;tmr1.c,6 :: 		TMR1H=0;
	CLRF       TMR1H+0
;tmr1.c,7 :: 		TMR1L=0;                 //delay=(60*t)/(0.524288)  ;t in minute
	CLRF       TMR1L+0
;tmr1.c,8 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;tmr1.c,9 :: 		PIE1.TMR1IE=1;
	BSF        PIE1+0, 0
;tmr1.c,10 :: 		T1CON.TMR1ON=1;
	BSF        T1CON+0, 0
;tmr1.c,11 :: 		}
L_end_initTmr1:
	RETURN
; end of _initTmr1
