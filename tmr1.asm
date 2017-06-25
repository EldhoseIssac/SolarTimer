
_initTmr1:

;tmr1.c,4 :: 		void initTmr1(){
;tmr1.c,6 :: 		T1CON=0x30;
	MOVLW      48
	MOVWF      T1CON+0
;tmr1.c,7 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;tmr1.c,8 :: 		INTCON.PEIE=1;
	BSF        INTCON+0, 6
;tmr1.c,9 :: 		T1CON.TMR1ON=0;
	BCF        T1CON+0, 0
;tmr1.c,10 :: 		TMR1H=0;
	CLRF       TMR1H+0
;tmr1.c,11 :: 		TMR1L=0;                 //delay=(60*t)/(0.524288)  ;t in minute
	CLRF       TMR1L+0
;tmr1.c,12 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;tmr1.c,13 :: 		PIE1.TMR1IE=1;
	BSF        PIE1+0, 0
;tmr1.c,14 :: 		T1CON.TMR1ON=1;
	BSF        T1CON+0, 0
;tmr1.c,16 :: 		}
L_end_initTmr1:
	RETURN
; end of _initTmr1
