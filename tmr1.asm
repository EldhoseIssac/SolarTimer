
_initTmr1:

	MOVLW      48
	MOVWF      T1CON+0
	BSF        INTCON+0, 7
	BSF        INTCON+0, 6
	BCF        T1CON+0, 0
	CLRF       TMR1H+0
	CLRF       TMR1L+0
	BCF        PIR1+0, 0
	BSF        PIE1+0, 0
	BSF        T1CON+0, 0
L_end_initTmr1:
	RETURN
; end of _initTmr1
