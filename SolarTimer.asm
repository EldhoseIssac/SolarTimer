
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SolarTimer.c,20 :: 		void interrupt()
;SolarTimer.c,27 :: 		if(PIR1.TMR1IF)
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
;SolarTimer.c,29 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;SolarTimer.c,32 :: 		dispUpdateCount++;
	INCF       _dispUpdateCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _dispUpdateCount+1, 1
;SolarTimer.c,33 :: 		if (dispUpdateCount > 2){
	MOVF       _dispUpdateCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt20
	MOVF       _dispUpdateCount+0, 0
	SUBLW      2
L__interrupt20:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
;SolarTimer.c,34 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,35 :: 		dispUpdateCount = 0;
	CLRF       _dispUpdateCount+0
	CLRF       _dispUpdateCount+1
;SolarTimer.c,36 :: 		}
L_interrupt1:
;SolarTimer.c,37 :: 		}
L_interrupt0:
;SolarTimer.c,38 :: 		}
L_end_interrupt:
L__interrupt19:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SolarTimer.c,45 :: 		void main() {
;SolarTimer.c,50 :: 		lastTimeCheckValue = 0;
	CLRF       _lastTimeCheckValue+0
	CLRF       _lastTimeCheckValue+1
;SolarTimer.c,52 :: 		ansel  = 7;
	MOVLW      7
	MOVWF      ANSEL+0
;SolarTimer.c,53 :: 		anselh  = 0;
	CLRF       ANSELH+0
;SolarTimer.c,54 :: 		trisb = 0;
	CLRF       TRISB+0
;SolarTimer.c,55 :: 		trisd = 0;
	CLRF       TRISD+0
;SolarTimer.c,56 :: 		ADC_Init();
	CALL       _ADC_Init+0
;SolarTimer.c,57 :: 		initLCD();
	CALL       _initLCD+0
;SolarTimer.c,58 :: 		InitRTC();
	CALL       _InitRTC+0
;SolarTimer.c,59 :: 		initTmr1();
	CALL       _initTmr1+0
;SolarTimer.c,60 :: 		menuPortPinInt();
	CALL       _menuPortPinInt+0
;SolarTimer.c,62 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,63 :: 		Lcd_Out(1,1,"Welcome");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_SolarTimer+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;SolarTimer.c,64 :: 		while(1);
L_main2:
	GOTO       L_main2
;SolarTimer.c,108 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
