
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SolarTimer.c,22 :: 		void interrupt()
;SolarTimer.c,29 :: 		if(PIR1.TMR1IF)
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
;SolarTimer.c,31 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;SolarTimer.c,34 :: 		dispUpdateCount++;
	INCF       _dispUpdateCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _dispUpdateCount+1, 1
;SolarTimer.c,35 :: 		if (dispUpdateCount > 2){
	MOVF       _dispUpdateCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt8
	MOVF       _dispUpdateCount+0, 0
	SUBLW      2
L__interrupt8:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
;SolarTimer.c,36 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,37 :: 		dispUpdateCount = 0;
	CLRF       _dispUpdateCount+0
	CLRF       _dispUpdateCount+1
;SolarTimer.c,38 :: 		}
L_interrupt1:
;SolarTimer.c,39 :: 		}
L_interrupt0:
;SolarTimer.c,40 :: 		}
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

;SolarTimer.c,44 :: 		void main() {
;SolarTimer.c,50 :: 		trisb = 0;
	CLRF       TRISB+0
;SolarTimer.c,51 :: 		trisd = 0;
	CLRF       TRISD+0
;SolarTimer.c,52 :: 		ADC_Init();
	CALL       _ADC_Init+0
;SolarTimer.c,53 :: 		initLCD();
	CALL       _initLCD+0
;SolarTimer.c,54 :: 		InitRTC();
	CALL       _InitRTC+0
;SolarTimer.c,55 :: 		initTmr1();
	CALL       _initTmr1+0
;SolarTimer.c,56 :: 		menuPortPinInt();
	CALL       _menuPortPinInt+0
;SolarTimer.c,58 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,59 :: 		while(1){
L_main2:
;SolarTimer.c,60 :: 		readVoltage();
	CALL       _readVoltage+0
;SolarTimer.c,61 :: 		readCurrent();
	CALL       _readCurrent+0
;SolarTimer.c,62 :: 		checkKey();
	CALL       _checkKey+0
;SolarTimer.c,64 :: 		if(shouldLoadDisp)
	BTFSS      _pgmStatus+0, 0
	GOTO       L_main4
;SolarTimer.c,66 :: 		if(crntMenu == None ){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;SolarTimer.c,67 :: 		displayVoltageCurrent();
	CALL       _displayVoltageCurrent+0
;SolarTimer.c,68 :: 		loadTimeAndDate();
	CALL       _loadTimeAndDate+0
;SolarTimer.c,69 :: 		displayTimeDate();
	CALL       _displayTimeDate+0
;SolarTimer.c,70 :: 		}
L_main5:
;SolarTimer.c,72 :: 		loadRamToDisp();
	CALL       _loadRamToDisp+0
;SolarTimer.c,73 :: 		shouldLoadDisp = 0;
	BCF        _pgmStatus+0, 0
;SolarTimer.c,74 :: 		}
L_main4:
;SolarTimer.c,75 :: 		}
	GOTO       L_main2
;SolarTimer.c,76 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
