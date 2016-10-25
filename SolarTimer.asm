
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

;SolarTimer.c,50 :: 		void main()
;SolarTimer.c,56 :: 		lastTimeCheckValue = 0;
	CLRF       _lastTimeCheckValue+0
	CLRF       _lastTimeCheckValue+1
;SolarTimer.c,57 :: 		osccon = 0x70;
	MOVLW      112
	MOVWF      OSCCON+0
;SolarTimer.c,58 :: 		ansel  = 7;
	MOVLW      7
	MOVWF      ANSEL+0
;SolarTimer.c,59 :: 		anselh  = 0;
	CLRF       ANSELH+0
;SolarTimer.c,60 :: 		trisb = 0;
	CLRF       TRISB+0
;SolarTimer.c,61 :: 		trisd = 0;
	CLRF       TRISD+0
;SolarTimer.c,62 :: 		ADC_Init();
	CALL       _ADC_Init+0
;SolarTimer.c,63 :: 		initLCD();
	CALL       _initLCD+0
;SolarTimer.c,64 :: 		InitRTC();
	CALL       _InitRTC+0
;SolarTimer.c,65 :: 		initTmr1();
	CALL       _initTmr1+0
;SolarTimer.c,66 :: 		menuPortPinInt();
	CALL       _menuPortPinInt+0
;SolarTimer.c,68 :: 		shouldLoadDisp = 1;
	BSF        _pgmStatus+0, 0
;SolarTimer.c,69 :: 		Lcd_Out(1,1,"Welcome");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_SolarTimer+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;SolarTimer.c,70 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;SolarTimer.c,71 :: 		while(1)
L_main3:
;SolarTimer.c,73 :: 		readVoltage();
	CALL       _readVoltage+0
;SolarTimer.c,74 :: 		readCurrent();
	CALL       _readCurrent+0
;SolarTimer.c,75 :: 		checkKey();
	CALL       _checkKey+0
;SolarTimer.c,77 :: 		if(shouldLoadDisp)
	BTFSS      _pgmStatus+0, 0
	GOTO       L_main5
;SolarTimer.c,79 :: 		displayVoltageCurrent();
	CALL       _displayVoltageCurrent+0
;SolarTimer.c,80 :: 		loadTimeAndDate();
	CALL       _loadTimeAndDate+0
;SolarTimer.c,81 :: 		displayTimeDate();
	CALL       _displayTimeDate+0
;SolarTimer.c,82 :: 		loadRamToDisp();
	CALL       _loadRamToDisp+0
;SolarTimer.c,83 :: 		shouldLoadDisp = 0;
	BCF        _pgmStatus+0, 0
;SolarTimer.c,84 :: 		for (index = EEPADDR_OnOFFTimeDay1;index<EEPADDR_OnOFFTimeDay9; index+=5)
	MOVLW      20
	MOVWF      main_index_L0+0
L_main6:
	MOVLW      60
	SUBWF      main_index_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main7
;SolarTimer.c,86 :: 		editValue = EEPROM_Read(index);
	MOVF       main_index_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;SolarTimer.c,87 :: 		tmp = editValue & (1 << (dday-1));
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
;SolarTimer.c,88 :: 		if(tmp)
	BTFSC      STATUS+0, 2
	GOTO       L_main9
;SolarTimer.c,90 :: 		editValue = ee_read(index+1);
	INCF       main_index_L0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;SolarTimer.c,91 :: 		if(editValue != lastTimeCheckValue)
	MOVF       R0+1, 0
	XORWF      _lastTimeCheckValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVF       _lastTimeCheckValue+0, 0
	XORWF      R0+0, 0
L__main22:
	BTFSC      STATUS+0, 2
	GOTO       L_main10
;SolarTimer.c,93 :: 		if(Hi(editValue) == hour)
	MOVF       _editValue+1, 0
	XORWF      _hour+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;SolarTimer.c,95 :: 		if(Lo(editValue) == minute)
	MOVF       _editValue+0, 0
	XORWF      _minute+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;SolarTimer.c,98 :: 		}
L_main12:
;SolarTimer.c,99 :: 		}
L_main11:
;SolarTimer.c,100 :: 		}else
	GOTO       L_main13
L_main10:
;SolarTimer.c,102 :: 		editValue = ee_read(index+3);
	MOVLW      3
	ADDWF      main_index_L0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;SolarTimer.c,103 :: 		if(editValue != lastTimeCheckValue)
	MOVF       R0+1, 0
	XORWF      _lastTimeCheckValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main23
	MOVF       _lastTimeCheckValue+0, 0
	XORWF      R0+0, 0
L__main23:
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;SolarTimer.c,105 :: 		if(Hi(editValue) == hour)
	MOVF       _editValue+1, 0
	XORWF      _hour+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;SolarTimer.c,108 :: 		}
L_main15:
;SolarTimer.c,109 :: 		}
L_main14:
;SolarTimer.c,111 :: 		}
L_main13:
;SolarTimer.c,114 :: 		}
L_main9:
;SolarTimer.c,84 :: 		for (index = EEPADDR_OnOFFTimeDay1;index<EEPADDR_OnOFFTimeDay9; index+=5)
	MOVLW      5
	ADDWF      main_index_L0+0, 1
;SolarTimer.c,115 :: 		}
	GOTO       L_main6
L_main7:
;SolarTimer.c,116 :: 		}
L_main5:
;SolarTimer.c,118 :: 		}
	GOTO       L_main3
;SolarTimer.c,119 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
