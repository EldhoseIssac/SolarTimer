
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SolarTimer.c,2 :: 		void interrupt()
;SolarTimer.c,4 :: 		if(PIR1.TMR1IF)
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
;SolarTimer.c,6 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;SolarTimer.c,7 :: 		dispUpdateCount++;
	INCF       _dispUpdateCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _dispUpdateCount+1, 1
;SolarTimer.c,8 :: 		if (dispUpdateCount > 2){
	MOVF       _dispUpdateCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt8
	MOVF       _dispUpdateCount+0, 0
	SUBLW      2
L__interrupt8:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
;SolarTimer.c,9 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,10 :: 		dispUpdateCount = 0;
	CLRF       _dispUpdateCount+0
	CLRF       _dispUpdateCount+1
;SolarTimer.c,11 :: 		}
L_interrupt1:
;SolarTimer.c,12 :: 		}
L_interrupt0:
;SolarTimer.c,13 :: 		}
L_end_interrupt:
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SolarTimer.c,14 :: 		void main() {
;SolarTimer.c,16 :: 		osccon = 0x70;
	MOVLW      112
	MOVWF      OSCCON+0
;SolarTimer.c,17 :: 		ansel  = 7;
	MOVLW      7
	MOVWF      ANSEL+0
;SolarTimer.c,18 :: 		anselh  = 0;
	CLRF       ANSELH+0
;SolarTimer.c,19 :: 		trisb = 0;
	CLRF       TRISB+0
;SolarTimer.c,20 :: 		trisd = 0;
	CLRF       TRISD+0
;SolarTimer.c,21 :: 		ADC_Init();
	CALL       _ADC_Init+0
;SolarTimer.c,22 :: 		initLCD();
	CALL       _initLCD+0
;SolarTimer.c,23 :: 		InitRTC();
	CALL       _InitRTC+0
;SolarTimer.c,24 :: 		initTmr1();
	CALL       _initTmr1+0
;SolarTimer.c,25 :: 		menuPortPinInt();
	CALL       _menuPortPinInt+0
;SolarTimer.c,27 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,28 :: 		while(1){
L_main2:
;SolarTimer.c,29 :: 		readVoltage();
	CALL       _readVoltage+0
;SolarTimer.c,30 :: 		readCurrent();
	CALL       _readCurrent+0
;SolarTimer.c,31 :: 		checkKey();
	CALL       _checkKey+0
;SolarTimer.c,33 :: 		if(shouldLoadDisp)
	BTFSS      _pgmStatus+0, 0
	GOTO       L_main4
;SolarTimer.c,35 :: 		if(appStatus.F0 == 0 ){
	BTFSC      _appStatus+0, 0
	GOTO       L_main5
;SolarTimer.c,36 :: 		displayVoltageCurrent();
	CALL       _displayVoltageCurrent+0
;SolarTimer.c,37 :: 		loadTimeAndDate();
	CALL       _loadTimeAndDate+0
;SolarTimer.c,38 :: 		displayTimeDate();
	CALL       _displayTimeDate+0
;SolarTimer.c,39 :: 		}
L_main5:
;SolarTimer.c,41 :: 		loadRamToDisp();
	CALL       _loadRamToDisp+0
;SolarTimer.c,42 :: 		shouldLoadDisp = 0;
	BCF        _pgmStatus+0, 0
;SolarTimer.c,43 :: 		}
L_main4:
;SolarTimer.c,44 :: 		}
	GOTO       L_main2
;SolarTimer.c,45 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
