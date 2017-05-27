
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
	BCF        PIR1+0, 0
	INCF       _dispUpdateCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _dispUpdateCount+1, 1
	MOVF       _dispUpdateCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt17
	MOVF       _dispUpdateCount+0, 0
	SUBLW      2
L__interrupt17:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
	BSF        _pgmStatus+0, 0
	CLRF       _dispUpdateCount+0
	CLRF       _dispUpdateCount+1
L_interrupt1:
L_interrupt0:
L_end_interrupt:
L__interrupt16:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

	CLRF       _lastTimeCheckValue+0
	CLRF       _lastTimeCheckValue+1
	CLRF       TRISB+0
	CLRF       TRISD+0
	CALL       _ADC_Init+0
	CALL       _initLCD+0
	CALL       _InitRTC+0
	CALL       _initTmr1+0
	CALL       _menuPortPinInt+0
	BSF        _pgmStatus+0, 0
	CALL       _showWelome+0
L_main2:
	CALL       _readVoltage+0
	CALL       _readCurrent+0
	CALL       _checkKey+0
	BTFSS      _pgmStatus+0, 0
	GOTO       L_main4
	CALL       _displayVoltageCurrent+0
	CALL       _loadTimeAndDate+0
	CALL       _displayTimeDate+0
	CALL       _loadRamToDisp+0
	BCF        _pgmStatus+0, 0
	MOVLW      20
	MOVWF      main_index_L0+0
L_main5:
	MOVLW      60
	SUBWF      main_index_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main6
	MOVF       main_index_L0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
	DECF       _dday+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main19:
	BTFSC      STATUS+0, 2
	GOTO       L__main20
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main19
L__main20:
	MOVF       _editValue+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_main8
	INCF       main_index_L0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVF       R0+1, 0
	XORWF      _lastTimeCheckValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main21
	MOVF       _lastTimeCheckValue+0, 0
	XORWF      R0+0, 0
L__main21:
	BTFSC      STATUS+0, 2
	GOTO       L_main9
	MOVF       _editValue+1, 0
	XORWF      _hour+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main10
	MOVF       _editValue+0, 0
	XORWF      _minute+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	MOVF       _editValue+0, 0
	MOVWF      _lastTimeCheckValue+0
	MOVF       _editValue+1, 0
	MOVWF      _lastTimeCheckValue+1
	BSF        PORTC+0, 0
L_main11:
L_main10:
	GOTO       L_main12
L_main9:
	MOVLW      3
	ADDWF      main_index_L0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVF       R0+1, 0
	XORWF      _lastTimeCheckValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main22
	MOVF       _lastTimeCheckValue+0, 0
	XORWF      R0+0, 0
L__main22:
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVF       _editValue+1, 0
	XORWF      _hour+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main14
	MOVF       _editValue+0, 0
	MOVWF      _lastTimeCheckValue+0
	MOVF       _editValue+1, 0
	MOVWF      _lastTimeCheckValue+1
	BCF        PORTC+0, 0
L_main14:
L_main13:
L_main12:
L_main8:
	MOVLW      5
	ADDWF      main_index_L0+0, 1
	GOTO       L_main5
L_main6:
L_main4:
	GOTO       L_main2
L_end_main:
	GOTO       $+0
; end of _main
