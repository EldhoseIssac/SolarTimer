
_codetxt_to_ramtxt:

	CLRF       R3+0
L_codetxt_to_ramtxt0:
	MOVF       R3+0, 0
	ADDWF      FARG_codetxt_to_ramtxt_ctxt+0, 0
	MOVWF      R0+0
	MOVF       FARG_codetxt_to_ramtxt_ctxt+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_codetxt_to_ramtxt1
	MOVF       R3+0, 0
	ADDLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R2+0
	MOVF       R3+0, 0
	ADDWF      FARG_codetxt_to_ramtxt_ctxt+0, 0
	MOVWF      R0+0
	MOVF       FARG_codetxt_to_ramtxt_ctxt+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R2+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       R3+0, 1
	GOTO       L_codetxt_to_ramtxt0
L_codetxt_to_ramtxt1:
	MOVF       R3+0, 0
	ADDLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      FSR
	CLRF       INDF+0
	MOVLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R0+0
L_end_codetxt_to_ramtxt:
	RETURN
; end of _codetxt_to_ramtxt

_menuPortPinInt:

	BSF        TRISD+0, 7
	BSF        TRISD+0, 6
	BSF        TRISD+0, 5
	BSF        TRISD+0, 4
	BCF        TRISC+0, 0
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_saveValue:

	BTFSC      _isEdited+0, BitPos(_isEdited+0)
	GOTO       L_saveValue3
	GOTO       L_end_saveValue
L_saveValue3:
	BCF        _isEdited+0, BitPos(_isEdited+0)
	GOTO       L_saveValue4
L_saveValue6:
	GOTO       L_saveValue5
L_saveValue7:
	GOTO       L_saveValue8
L_saveValue10:
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
	GOTO       L_saveValue9
L_saveValue11:
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
	GOTO       L_saveValue9
L_saveValue12:
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
	GOTO       L_saveValue9
L_saveValue13:
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
	GOTO       L_saveValue9
L_saveValue8:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue10
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue11
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue12
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue13
L_saveValue9:
	GOTO       L_saveValue5
L_saveValue14:
	GOTO       L_saveValue15
L_saveValue17:
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
	GOTO       L_saveValue16
L_saveValue18:
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
	GOTO       L_saveValue16
L_saveValue15:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue17
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue18
L_saveValue16:
	GOTO       L_saveValue5
L_saveValue19:
	GOTO       L_saveValue20
L_saveValue22:
	MOVLW      4
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue21
L_saveValue23:
	MOVLW      2
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue21
L_saveValue20:
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue22
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue23
L_saveValue21:
	GOTO       L_saveValue5
L_saveValue24:
	GOTO       L_saveValue25
L_saveValue27:
	MOVLW      6
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue26
L_saveValue28:
	MOVLW      8
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue26
L_saveValue25:
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue27
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue28
L_saveValue26:
	GOTO       L_saveValue5
L_saveValue29:
	GOTO       L_saveValue30
L_saveValue32:
	MOVLW      12
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue31
L_saveValue33:
	MOVLW      10
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue31
L_saveValue30:
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue32
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue33
L_saveValue31:
	GOTO       L_saveValue5
L_saveValue34:
	MOVLW      6
	SUBWF      _crntMenu+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__saveValue289
	MOVLW      0
	XORWF      R0+0, 0
L__saveValue289:
	BTFSS      STATUS+0, 2
	GOTO       L_saveValue35
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	GOTO       L_saveValue36
L_saveValue35:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue271
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue271
	GOTO       L_saveValue39
L__saveValue271:
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue40
L_saveValue39:
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue270
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue270
	GOTO       L_saveValue43
L__saveValue270:
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
L_saveValue43:
L_saveValue40:
L_saveValue36:
	GOTO       L_saveValue5
L_saveValue4:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue6
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue7
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue14
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue19
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue24
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue29
	GOTO       L_saveValue34
L_saveValue5:
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_saveValue44:
	DECFSZ     R13+0, 1
	GOTO       L_saveValue44
	DECFSZ     R12+0, 1
	GOTO       L_saveValue44
	DECFSZ     R11+0, 1
	GOTO       L_saveValue44
	NOP
	NOP
L_end_saveValue:
	RETURN
; end of _saveValue

_OnOFFTimeDayDisplay:

	BTFSC      _cashedPortD+0, 7
	GOTO       L_OnOFFTimeDayDisplay45
	MOVLW      3
	MOVWF      _subMenu+0
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	CALL       _loadOnOffTime+0
	MOVLW      11
	MOVWF      _subMenu+0
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	CALL       _loadOnOffTime+0
	MOVLW      2
	MOVWF      _subMenu+0
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
	CALL       _loadEnabledDay+0
	CLRF       _tmp+0
	MOVLW      6
	SUBWF      _crntMenu+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__OnOFFTimeDayDisplay291
	MOVLW      1
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay291:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay46
	MOVLW      3
	MOVWF      _subMenu+0
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay46:
	GOTO       L_OnOFFTimeDayDisplay47
L_OnOFFTimeDayDisplay45:
	MOVLW      6
	SUBWF      _crntMenu+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__OnOFFTimeDayDisplay292
	MOVLW      0
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay292:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay48
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay49
	MOVLW      2
	ADDWF      _subMenu+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _subMenu+0
	INCF       _tmp+0, 1
	MOVF       R1+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay50
	MOVLW      2
	MOVWF      _subMenu+0
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay50:
L_OnOFFTimeDayDisplay49:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay273
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay273
	GOTO       L_OnOFFTimeDayDisplay53
L__OnOFFTimeDayDisplay273:
	MOVF       _tmp+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__OnOFFTimeDayDisplay293:
	BTFSC      STATUS+0, 2
	GOTO       L__OnOFFTimeDayDisplay294
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__OnOFFTimeDayDisplay293
L__OnOFFTimeDayDisplay294:
	MOVF       R0+0, 0
	XORWF      _editValue+0, 1
	MOVF       R0+1, 0
	XORWF      _editValue+1, 1
	CALL       _loadEnabledDay+0
L_OnOFFTimeDayDisplay53:
	GOTO       L_OnOFFTimeDayDisplay54
L_OnOFFTimeDayDisplay48:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay55
	INCF       _tmp+0, 1
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay56
	MOVLW      6
	ADDWF      _tmp+0, 1
L_OnOFFTimeDayDisplay56:
L_OnOFFTimeDayDisplay55:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay57
	DECF       _tmp+0, 1
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay58
	MOVLW      6
	SUBWF      _tmp+0, 1
L_OnOFFTimeDayDisplay58:
L_OnOFFTimeDayDisplay57:
	GOTO       L_OnOFFTimeDayDisplay59
L_OnOFFTimeDayDisplay61:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay62
	MOVLW      6
	MOVWF      _subMenu+0
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay62:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay63
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay64
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay64:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay63:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay65
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay66
	MOVLW      35
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay66:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay65:
	GOTO       L_OnOFFTimeDayDisplay60
L_OnOFFTimeDayDisplay67:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay68
	MOVLW      11
	MOVWF      _subMenu+0
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay68:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay69
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay70
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay70:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay69:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay71
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay72
	MOVLW      89
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay72:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay71:
	GOTO       L_OnOFFTimeDayDisplay60
L_OnOFFTimeDayDisplay73:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay74
	MOVLW      14
	MOVWF      _subMenu+0
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay74:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay75
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay76
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay76:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay75:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay77
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay78
	MOVLW      35
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay78:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay77:
	GOTO       L_OnOFFTimeDayDisplay60
L_OnOFFTimeDayDisplay79:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay80
	MOVLW      3
	MOVWF      _subMenu+0
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay80:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay81
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay82
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay82:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay81:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay83
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay84
	MOVLW      89
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay84:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay83:
	GOTO       L_OnOFFTimeDayDisplay60
L_OnOFFTimeDayDisplay59:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay61
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay67
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay73
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay79
L_OnOFFTimeDayDisplay60:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay272
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay272
	GOTO       L_OnOFFTimeDayDisplay87
L__OnOFFTimeDayDisplay272:
	CALL       _loadOnOffTime+0
L_OnOFFTimeDayDisplay87:
L_OnOFFTimeDayDisplay54:
L_OnOFFTimeDayDisplay47:
L_end_OnOFFTimeDayDisplay:
	RETURN
; end of _OnOFFTimeDayDisplay

_checkKey:

	MOVLW      30
	MOVWF      _timeEEAddr+0
L_checkKey88:
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey296
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey297
L__checkKey296:
	BSF        _cashedPortD+0, 7
L__checkKey297:
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey298
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey299
L__checkKey298:
	BSF        _cashedPortD+0, 6
L__checkKey299:
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey300
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey301
L__checkKey300:
	BSF        _cashedPortD+0, 5
L__checkKey301:
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey302
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey303
L__checkKey302:
	BSF        _cashedPortD+0, 4
L__checkKey303:
	MOVLW      240
	SUBWF      _cashedPortD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey91
	CLRF       _waitCount+0
	CLRF       _waitCount+1
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey92:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey92
	DECFSZ     R12+0, 1
	GOTO       L_checkKey92
	DECFSZ     R11+0, 1
	GOTO       L_checkKey92
	NOP
	NOP
L_checkKey91:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey93
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey94
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	GOTO       L_checkKey95
L_checkKey94:
	CALL       _saveValue+0
L_checkKey95:
	INCF       _crntMenu+0, 1
	MOVF       _crntMenu+0, 0
	SUBLW      21
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey96
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
L_checkKey96:
L_checkKey93:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey97
	CALL       _saveValue+0
L_checkKey97:
	GOTO       L_checkKey98
L_checkKey100:
	GOTO       L_checkKey99
L_checkKey101:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey102
	CLRF       _subMenu+0
	CALL       _loadDateEdit+0
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
	GOTO       L_checkKey103
L_checkKey102:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey104
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVLW      15
	ANDWF      _editValue+0, 0
	MOVWF      R1+0
	MOVF       _editValue+1, 0
	MOVWF      R1+1
	MOVLW      0
	ANDWF      R1+1, 1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey304
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey304:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey105
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey105:
L_checkKey104:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey106
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      15
	ANDWF      _editValue+0, 0
	MOVWF      R1+0
	MOVF       _editValue+1, 0
	MOVWF      R1+1
	MOVLW      0
	ANDWF      R1+1, 1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey305
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey305:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey107
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey107:
L_checkKey106:
	GOTO       L_checkKey108
L_checkKey110:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey111
	MOVLW      3
	MOVWF      _subMenu+0
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey111:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey112
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey306
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey306:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey113
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey113:
L_checkKey112:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey114
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey307
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey307:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey115
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey115:
L_checkKey114:
	GOTO       L_checkKey109
L_checkKey116:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey117
	MOVLW      6
	MOVWF      _subMenu+0
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey117:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey118
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey308
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey308:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey119
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey119:
L_checkKey118:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey120
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey309
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey309:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey121
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey121:
L_checkKey120:
	GOTO       L_checkKey109
L_checkKey122:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey123
	MOVLW      9
	MOVWF      _subMenu+0
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey123:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey124
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey310
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey310:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey125
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey125:
L_checkKey124:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey126
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey311
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey311:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey127
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey127:
L_checkKey126:
	GOTO       L_checkKey109
L_checkKey128:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey129
	CLRF       _subMenu+0
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey129:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey130
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey312
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey312:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey131
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey131:
L_checkKey130:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey132
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey313
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey313:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey133
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey133:
L_checkKey132:
	GOTO       L_checkKey109
L_checkKey108:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey110
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey116
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey122
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey128
L_checkKey109:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey285
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey285
	GOTO       L_checkKey136
L__checkKey285:
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey137
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
	CLRF       _lcdrow2+3
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_checkKey138
L_checkKey137:
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CALL       _Lcd_Chr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
L_checkKey138:
L_checkKey136:
L_checkKey103:
	GOTO       L_checkKey99
L_checkKey139:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey140
	CLRF       _subMenu+0
	CALL       _loadTimeEdit+0
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
	GOTO       L_checkKey141
L_checkKey140:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey142
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVLW      15
	ANDWF      _editValue+0, 0
	MOVWF      R1+0
	MOVF       _editValue+1, 0
	MOVWF      R1+1
	MOVLW      0
	ANDWF      R1+1, 1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey314
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey314:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey143
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey143:
L_checkKey142:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey144
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      15
	ANDWF      _editValue+0, 0
	MOVWF      R1+0
	MOVF       _editValue+1, 0
	MOVWF      R1+1
	MOVLW      0
	ANDWF      R1+1, 1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey315
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey315:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey145
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey145:
L_checkKey144:
	GOTO       L_checkKey146
L_checkKey148:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey149
	MOVLW      3
	MOVWF      _subMenu+0
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey149:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey150
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey316
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey316:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey151
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey151:
L_checkKey150:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey152
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey317
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey317:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey153
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey153:
L_checkKey152:
	GOTO       L_checkKey147
L_checkKey154:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey155
	CLRF       _subMenu+0
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey155:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey156
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey318
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey318:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey157
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey157:
L_checkKey156:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey158
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey319
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey319:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey159
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey159:
L_checkKey158:
	GOTO       L_checkKey147
L_checkKey146:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey148
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey154
L_checkKey147:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey284
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey284
	GOTO       L_checkKey162
L__checkKey284:
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CALL       _Lcd_Chr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
L_checkKey162:
L_checkKey141:
	GOTO       L_checkKey99
L_checkKey163:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey164
	CLRF       _subMenu+0
	MOVLW      ?lstr_1_Menu+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_1_Menu+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
	GOTO       L_checkKey165
L_checkKey164:
	GOTO       L_checkKey166
L_checkKey168:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey169
	MOVLW      7
	MOVWF      _subMenu+0
L_checkKey169:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey283
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey283
	GOTO       L_checkKey172
L__checkKey283:
	MOVLW
	XORWF      _isEnabled+0, 1
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey172:
	GOTO       L_checkKey167
L_checkKey173:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey174
	MOVLW      13
	MOVWF      _subMenu+0
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey174:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey175
	MOVLW      2
	ADDWF      _editValue+0, 0
	MOVWF      R1+0
	MOVF       _editValue+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _editValue+0
	MOVF       R1+1, 0
	MOVWF      _editValue+1
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey320
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey320:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey176
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey176:
L_checkKey175:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey177
	MOVLW      2
	SUBWF      _editValue+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _editValue+1, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _editValue+0
	MOVF       R1+1, 0
	MOVWF      _editValue+1
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey321
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey321:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey178
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey178:
L_checkKey177:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey282
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey282
	GOTO       L_checkKey181
L__checkKey282:
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey181:
	GOTO       L_checkKey167
L_checkKey182:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey183
	CLRF       _subMenu+0
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey183:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey184
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey322
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey322:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey185
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey185:
L_checkKey184:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey186
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey323
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey323:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey187
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey187:
L_checkKey186:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey281
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey281
	GOTO       L_checkKey190
L__checkKey281:
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey190:
	GOTO       L_checkKey167
L_checkKey166:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey168
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey173
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey182
L_checkKey167:
L_checkKey165:
	GOTO       L_checkKey99
L_checkKey191:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey192
	CLRF       _subMenu+0
	MOVLW      ?lstr_2_Menu+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_2_Menu+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVLW      1
	MOVWF      FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
	GOTO       L_checkKey193
L_checkKey192:
	GOTO       L_checkKey194
L_checkKey196:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey197
	MOVLW      8
	MOVWF      _subMenu+0
L_checkKey197:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey280
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey280
	GOTO       L_checkKey200
L__checkKey280:
	MOVLW
	XORWF      _isEnabled+0, 1
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVLW      1
	MOVWF      FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey200:
	GOTO       L_checkKey195
L_checkKey201:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey202
	MOVLW      13
	MOVWF      _subMenu+0
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey202:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey203
	MOVLW      2
	ADDWF      _editValue+0, 0
	MOVWF      R1+0
	MOVF       _editValue+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _editValue+0
	MOVF       R1+1, 0
	MOVWF      _editValue+1
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey324
	MOVF       R1+0, 0
	SUBLW      201
L__checkKey324:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey204
	MOVLW      11
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey204:
L_checkKey203:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey205
	MOVLW      2
	SUBWF      _editValue+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _editValue+1, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _editValue+0
	MOVF       R1+1, 0
	MOVWF      _editValue+1
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey325
	MOVLW      11
	SUBWF      R1+0, 0
L__checkKey325:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey206
	MOVLW      201
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey206:
L_checkKey205:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey279
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey279
	GOTO       L_checkKey209
L__checkKey279:
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVLW      1
	MOVWF      FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey209:
	GOTO       L_checkKey195
L_checkKey210:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey211
	CLRF       _subMenu+0
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey211:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey212
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey326
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey326:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey213
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey213:
L_checkKey212:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey214
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey327
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey327:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey215
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey215:
L_checkKey214:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey278
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey278
	GOTO       L_checkKey218
L__checkKey278:
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVLW      1
	MOVWF      FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey218:
	GOTO       L_checkKey195
L_checkKey194:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey196
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey201
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey210
L_checkKey195:
L_checkKey193:
	GOTO       L_checkKey99
L_checkKey219:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey220
	CLRF       _subMenu+0
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
	MOVLW      ?lstr_3_Menu+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_3_Menu+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
	GOTO       L_checkKey221
L_checkKey220:
	GOTO       L_checkKey222
L_checkKey224:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey225
	MOVLW      8
	MOVWF      _subMenu+0
L_checkKey225:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey277
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey277
	GOTO       L_checkKey228
L__checkKey277:
	MOVLW
	XORWF      _isEnabled+0, 1
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey228:
	GOTO       L_checkKey223
L_checkKey229:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey230
	MOVLW      13
	MOVWF      _subMenu+0
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey230:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey231
	MOVLW      2
	ADDWF      _editValue+0, 0
	MOVWF      R1+0
	MOVF       _editValue+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _editValue+0
	MOVF       R1+1, 0
	MOVWF      _editValue+1
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey328
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey328:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey232
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey232:
L_checkKey231:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey233
	MOVLW      2
	SUBWF      _editValue+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _editValue+1, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _editValue+0
	MOVF       R1+1, 0
	MOVWF      _editValue+1
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey329
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey329:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey234
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey234:
L_checkKey233:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey276
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey276
	GOTO       L_checkKey237
L__checkKey276:
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey237:
	GOTO       L_checkKey223
L_checkKey238:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey239
	CLRF       _subMenu+0
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey239:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey240
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey330
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey330:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey241
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey241:
L_checkKey240:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey242
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey331
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey331:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey243
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey243:
L_checkKey242:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey275
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey275
	GOTO       L_checkKey246
L__checkKey275:
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CLRF       FARG_loadEnHeighLow_shouldUseDecimal+0
	CALL       _loadEnHeighLow+0
L_checkKey246:
	GOTO       L_checkKey223
L_checkKey222:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey224
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey229
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey238
L_checkKey223:
L_checkKey221:
	GOTO       L_checkKey99
L_checkKey247:
	MOVLW      20
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey248:
	MOVLW      20
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey249:
	MOVLW      25
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey250:
	MOVLW      25
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey251:
	MOVLW      30
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey252:
	MOVLW      30
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey253:
	MOVLW      35
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey254:
	MOVLW      35
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey255:
	MOVLW      40
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey256:
	MOVLW      40
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey257:
	MOVLW      45
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey258:
	MOVLW      45
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey259:
	MOVLW      50
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey260:
	MOVLW      50
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey261:
	MOVLW      55
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey262:
	MOVLW      55
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey99
L_checkKey263:
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
	GOTO       L_checkKey99
L_checkKey98:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey100
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey101
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey139
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey163
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey191
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey219
	MOVF       _crntMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey247
	MOVF       _crntMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey248
	MOVF       _crntMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey249
	MOVF       _crntMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey250
	MOVF       _crntMenu+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey251
	MOVF       _crntMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey252
	MOVF       _crntMenu+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey253
	MOVF       _crntMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey254
	MOVF       _crntMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey255
	MOVF       _crntMenu+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey256
	MOVF       _crntMenu+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey257
	MOVF       _crntMenu+0, 0
	XORLW      17
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey258
	MOVF       _crntMenu+0, 0
	XORLW      18
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey259
	MOVF       _crntMenu+0, 0
	XORLW      19
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey260
	MOVF       _crntMenu+0, 0
	XORLW      20
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey261
	MOVF       _crntMenu+0, 0
	XORLW      21
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey262
	GOTO       L_checkKey263
L_checkKey99:
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey264
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
L_checkKey264:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey274
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey274
	GOTO       L_checkKey267
L__checkKey274:
	BSF        _isEdited+0, BitPos(_isEdited+0)
L_checkKey267:
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey268:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey268
	DECFSZ     R12+0, 1
	GOTO       L_checkKey268
	DECFSZ     R11+0, 1
	GOTO       L_checkKey268
	NOP
	NOP
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey332
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey332:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey269
	CLRF       _crntMenu+0
	CLRF       _subMenu+0
	CALL       _initLCDRaws+0
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
L_checkKey269:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey88
	CALL       _saveValue+0
L_end_checkKey:
	RETURN
; end of _checkKey
