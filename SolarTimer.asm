
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
	GOTO       L__interrupt18
	MOVF       _dispUpdateCount+0, 0
	SUBLW      2
L__interrupt18:
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
L__interrupt17:
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
;SolarTimer.c,51 :: 		osccon = 0x70;
	MOVLW      112
	MOVWF      OSCCON+0
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
;SolarTimer.c,63 :: 		while(1){
L_main2:
;SolarTimer.c,64 :: 		readVoltage();
	CALL       _readVoltage+0
;SolarTimer.c,65 :: 		readCurrent();
	CALL       _readCurrent+0
;SolarTimer.c,66 :: 		checkKey();
	CALL       _checkKey+0
;SolarTimer.c,68 :: 		if(shouldLoadDisp)
	BTFSS      _pgmStatus+0, 0
	GOTO       L_main4
;SolarTimer.c,70 :: 		displayVoltageCurrent();
	CALL       _displayVoltageCurrent+0
;SolarTimer.c,71 :: 		loadTimeAndDate();
	CALL       _loadTimeAndDate+0
;SolarTimer.c,72 :: 		displayTimeDate();
	CALL       _displayTimeDate+0
;SolarTimer.c,73 :: 		loadRamToDisp();
	CALL       _loadRamToDisp+0
;SolarTimer.c,74 :: 		shouldLoadDisp = 0;
	BCF        _pgmStatus+0, 0
;SolarTimer.c,75 :: 		for (index = EEPADDR_OnOFFTimeEdit1;index<EEPADDR_OnOFFTimeEdit9;index+=2)
	MOVLW      16
	MOVWF      main_index_L0+0
L_main5:
	MOVLW      32
	SUBWF      main_index_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;SolarTimer.c,77 :: 		editValue = ee_read(index);
	MOVF       main_index_L0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;SolarTimer.c,78 :: 		if(!isEnabled)
	BTFSC      _editValue+0, 0
	GOTO       L_main8
;SolarTimer.c,80 :: 		continue;
	GOTO       L_main7
;SolarTimer.c,81 :: 		}
L_main8:
;SolarTimer.c,82 :: 		if (lastTimeCheckValue != editValue)
	MOVF       _lastTimeCheckValue+1, 0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main20
	MOVF       _editValue+0, 0
	XORWF      _lastTimeCheckValue+0, 0
L__main20:
	BTFSC      STATUS+0, 2
	GOTO       L_main9
;SolarTimer.c,84 :: 		tmp = editValue;
	MOVF       _editValue+0, 0
	MOVWF      main_tmp_L0+0
;SolarTimer.c,85 :: 		tmp = (tmp & 0x1C) >> 2;
	MOVLW      28
	ANDWF      _editValue+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	RRF        R1+0, 1
	BCF        R1+0, 7
	MOVF       R1+0, 0
	MOVWF      main_tmp_L0+0
;SolarTimer.c,86 :: 		if (tmp != 0 || tmp != dday)
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       main_tmp_L0+0, 0
	XORWF      _dday+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	GOTO       L_main12
L__main15:
;SolarTimer.c,88 :: 		continue;
	GOTO       L_main7
;SolarTimer.c,89 :: 		}
L_main12:
;SolarTimer.c,90 :: 		tmp = (editValue & 0x03E0) >> 5;
	MOVLW      224
	ANDWF      _editValue+0, 0
	MOVWF      R3+0
	MOVF       _editValue+1, 0
	ANDLW      3
	MOVWF      R3+1
	MOVLW      5
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	MOVF       R0+0, 0
L__main21:
	BTFSC      STATUS+0, 2
	GOTO       L__main22
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	ADDLW      255
	GOTO       L__main21
L__main22:
	MOVF       R1+0, 0
	MOVWF      main_tmp_L0+0
;SolarTimer.c,91 :: 		if (tmp != hour)
	MOVF       R1+0, 0
	XORWF      _hour+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main13
;SolarTimer.c,93 :: 		continue;
	GOTO       L_main7
;SolarTimer.c,94 :: 		}
L_main13:
;SolarTimer.c,95 :: 		tmp = (editValue & 0xFC00) >> 10;
	MOVLW      0
	ANDWF      _editValue+0, 0
	MOVWF      R3+0
	MOVF       _editValue+1, 0
	ANDLW      252
	MOVWF      R3+1
	MOVLW      10
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	MOVF       R0+0, 0
L__main23:
	BTFSC      STATUS+0, 2
	GOTO       L__main24
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	ADDLW      255
	GOTO       L__main23
L__main24:
	MOVF       R1+0, 0
	MOVWF      main_tmp_L0+0
;SolarTimer.c,96 :: 		if (tmp != minute)
	MOVF       R1+0, 0
	XORWF      _minute+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;SolarTimer.c,98 :: 		continue;
	GOTO       L_main7
;SolarTimer.c,99 :: 		}
L_main14:
;SolarTimer.c,100 :: 		MOTOR = shouldON;
	BTFSC      _editValue+0, 1
	GOTO       L__main25
	BCF        PORTC+0, 0
	GOTO       L__main26
L__main25:
	BSF        PORTC+0, 0
L__main26:
;SolarTimer.c,102 :: 		}
L_main9:
;SolarTimer.c,103 :: 		}
L_main7:
;SolarTimer.c,75 :: 		for (index = EEPADDR_OnOFFTimeEdit1;index<EEPADDR_OnOFFTimeEdit9;index+=2)
	MOVLW      2
	ADDWF      main_index_L0+0, 1
;SolarTimer.c,103 :: 		}
	GOTO       L_main5
L_main6:
;SolarTimer.c,104 :: 		}
L_main4:
;SolarTimer.c,105 :: 		}
	GOTO       L_main2
;SolarTimer.c,106 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
