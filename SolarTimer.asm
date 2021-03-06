
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SolarTimer.c,25 :: 		void interrupt()
;SolarTimer.c,32 :: 		if(PIR1.TMR1IF)
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
;SolarTimer.c,34 :: 		PIR1.TMR1IF=0;
	BCF        PIR1+0, 0
;SolarTimer.c,37 :: 		dispUpdateCount++;
	INCF       _dispUpdateCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _dispUpdateCount+1, 1
;SolarTimer.c,38 :: 		if (dispUpdateCount > 2){
	MOVF       _dispUpdateCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt18
	MOVF       _dispUpdateCount+0, 0
	SUBLW      2
L__interrupt18:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
;SolarTimer.c,39 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,40 :: 		dispUpdateCount = 0;
	CLRF       _dispUpdateCount+0
	CLRF       _dispUpdateCount+1
;SolarTimer.c,41 :: 		}
L_interrupt1:
;SolarTimer.c,42 :: 		}
L_interrupt0:
;SolarTimer.c,43 :: 		}
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

;SolarTimer.c,55 :: 		void main()
;SolarTimer.c,64 :: 		osccon = 0x71;
	MOVLW      113
	MOVWF      OSCCON+0
;SolarTimer.c,65 :: 		ansel  = 7;
	MOVLW      7
	MOVWF      ANSEL+0
;SolarTimer.c,66 :: 		anselh  = 0;
	CLRF       ANSELH+0
;SolarTimer.c,67 :: 		trisb = 0;
	CLRF       TRISB+0
;SolarTimer.c,68 :: 		trisd = 0;
	CLRF       TRISD+0
;SolarTimer.c,69 :: 		trisc = 0;
	CLRF       TRISC+0
;SolarTimer.c,70 :: 		ADC_Init();
	CALL       _ADC_Init+0
;SolarTimer.c,71 :: 		initLCD();
	CALL       _initLCD+0
;SolarTimer.c,72 :: 		InitRTC();
	CALL       _InitRTC+0
;SolarTimer.c,73 :: 		initTmr1();
	CALL       _initTmr1+0
;SolarTimer.c,74 :: 		menuPortPinInt();
	CALL       _menuPortPinInt+0
;SolarTimer.c,76 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,77 :: 		showWelome();
	CALL       _showWelome+0
;SolarTimer.c,78 :: 		mStatus = 0;
	CLRF       _mStatus+0
;SolarTimer.c,80 :: 		while(1)
L_main2:
;SolarTimer.c,83 :: 		readVoltage();
	CALL       _readVoltage+0
;SolarTimer.c,84 :: 		readCurrent();
	CALL       _readCurrent+0
;SolarTimer.c,85 :: 		checkKey();
	CALL       _checkKey+0
;SolarTimer.c,87 :: 		if(shouldLoadDisp)
	BTFSS      _pgmStatus+0, 0
	GOTO       L_main4
;SolarTimer.c,92 :: 		displayVoltageCurrent();
	CALL       _displayVoltageCurrent+0
;SolarTimer.c,93 :: 		loadTimeAndDate();
	CALL       _loadTimeAndDate+0
;SolarTimer.c,94 :: 		displayTimeDate();
	CALL       _displayTimeDate+0
;SolarTimer.c,95 :: 		loadRamToDisp();
	CALL       _loadRamToDisp+0
;SolarTimer.c,97 :: 		shouldLoadDisp = 0;
	BCF        _pgmStatus+0, 0
;SolarTimer.c,98 :: 		for (index = EEPADDR_OnOFFTimeDay1;index<EEPADDR_OnOFFTimeDay9; index+=5)
	MOVLW      20
	MOVWF      main_index_L0+0
L_main5:
	MOVLW      60
	SUBWF      main_index_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main6
;SolarTimer.c,100 :: 		if (mStatus)
	MOVF       _mStatus+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;SolarTimer.c,102 :: 		if (index != onIndex)
	MOVF       main_index_L0+0, 0
	XORWF      _onIndex+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main9
;SolarTimer.c,104 :: 		continue;
	GOTO       L_main7
;SolarTimer.c,105 :: 		}
L_main9:
;SolarTimer.c,106 :: 		}
L_main8:
;SolarTimer.c,107 :: 		editValue = EEPROM_Read(index);
	MOVF       main_index_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;SolarTimer.c,108 :: 		tmp = editValue & (1 << (dday-1));
	DECF       _dday+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main20:
	BTFSC      STATUS+0, 2
	GOTO       L__main21
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main20
L__main21:
	MOVF       _editValue+0, 0
	ANDWF      R0+0, 1
;SolarTimer.c,118 :: 		if(tmp)
	BTFSC      STATUS+0, 2
	GOTO       L_main10
;SolarTimer.c,120 :: 		onVal = ee_read(index+1);
	INCF       main_index_L0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      main_onVal_L0+0
	MOVF       R0+1, 0
	MOVWF      main_onVal_L0+1
;SolarTimer.c,121 :: 		offVal = ee_read(index+3);
	MOVLW      3
	ADDWF      main_index_L0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      main_offVal_L0+0
	MOVF       R0+1, 0
	MOVWF      main_offVal_L0+1
;SolarTimer.c,123 :: 		editValue = onVal;
	MOVF       main_onVal_L0+0, 0
	MOVWF      _editValue+0
	MOVF       main_onVal_L0+1, 0
	MOVWF      _editValue+1
;SolarTimer.c,124 :: 		Hi(onVal) = Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      main_onVal_L0+1
;SolarTimer.c,125 :: 		Lo(onVal) = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      main_onVal_L0+0
;SolarTimer.c,127 :: 		editValue = offVal;
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;SolarTimer.c,128 :: 		Hi(offVal) = Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      main_offVal_L0+1
;SolarTimer.c,129 :: 		Lo(offVal) = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      main_offVal_L0+0
;SolarTimer.c,131 :: 		Hi(minHrVal) = hour;
	MOVF       _hour+0, 0
	MOVWF      main_minHrVal_L0+1
;SolarTimer.c,132 :: 		Lo(minHrVal) = minute;
	MOVF       _minute+0, 0
	MOVWF      main_minHrVal_L0+0
;SolarTimer.c,147 :: 		if (minHrVal >= onVal   && minHrVal < offVal )
	MOVF       main_onVal_L0+1, 0
	SUBWF      main_minHrVal_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVF       main_onVal_L0+0, 0
	SUBWF      main_minHrVal_L0+0, 0
L__main22:
	BTFSS      STATUS+0, 0
	GOTO       L_main13
	MOVF       main_offVal_L0+1, 0
	SUBWF      main_minHrVal_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVF       main_offVal_L0+0, 0
	SUBWF      main_minHrVal_L0+0, 0
L__main23:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
L__main15:
;SolarTimer.c,152 :: 		MOTOR = 1;
	BSF        PORTC+0, 1
;SolarTimer.c,153 :: 		mStatus = 1;
	MOVLW      1
	MOVWF      _mStatus+0
;SolarTimer.c,154 :: 		onIndex = index;
	MOVF       main_index_L0+0, 0
	MOVWF      _onIndex+0
;SolarTimer.c,155 :: 		}else
	GOTO       L_main14
L_main13:
;SolarTimer.c,161 :: 		MOTOR = 0;
	BCF        PORTC+0, 1
;SolarTimer.c,162 :: 		mStatus = 0;
	CLRF       _mStatus+0
;SolarTimer.c,163 :: 		onIndex = 0;
	CLRF       _onIndex+0
;SolarTimer.c,164 :: 		}
L_main14:
;SolarTimer.c,169 :: 		}
L_main10:
;SolarTimer.c,170 :: 		}
L_main7:
;SolarTimer.c,98 :: 		for (index = EEPADDR_OnOFFTimeDay1;index<EEPADDR_OnOFFTimeDay9; index+=5)
	MOVLW      5
	ADDWF      main_index_L0+0, 1
;SolarTimer.c,170 :: 		}
	GOTO       L_main5
L_main6:
;SolarTimer.c,171 :: 		}
L_main4:
;SolarTimer.c,173 :: 		}
	GOTO       L_main2
;SolarTimer.c,174 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
