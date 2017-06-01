
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
L_saveValue24:
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
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue24
L_saveValue21:
	GOTO       L_saveValue5
L_saveValue25:
	GOTO       L_saveValue26
L_saveValue28:
L_saveValue29:
	MOVLW      6
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue27
L_saveValue30:
	MOVLW      8
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue27
L_saveValue26:
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue28
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue29
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue30
L_saveValue27:
	GOTO       L_saveValue5
L_saveValue31:
	GOTO       L_saveValue32
L_saveValue34:
	MOVLW      12
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue33
L_saveValue35:
L_saveValue36:
	MOVLW      10
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue33
L_saveValue32:
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue34
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue35
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue36
L_saveValue33:
	GOTO       L_saveValue5
L_saveValue37:
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
	GOTO       L__saveValue292
	MOVLW      0
	XORWF      R0+0, 0
L__saveValue292:
	BTFSS      STATUS+0, 2
	GOTO       L_saveValue38
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	GOTO       L_saveValue39
L_saveValue38:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue274
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue274
	GOTO       L_saveValue42
L__saveValue274:
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
	GOTO       L_saveValue43
L_saveValue42:
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue273
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue273
	GOTO       L_saveValue46
L__saveValue273:
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
L_saveValue46:
L_saveValue43:
L_saveValue39:
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
	GOTO       L_saveValue25
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue31
	GOTO       L_saveValue37
L_saveValue5:
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_saveValue47:
	DECFSZ     R13+0, 1
	GOTO       L_saveValue47
	DECFSZ     R12+0, 1
	GOTO       L_saveValue47
	DECFSZ     R11+0, 1
	GOTO       L_saveValue47
	NOP
	NOP
L_end_saveValue:
	RETURN
; end of _saveValue

_OnOFFTimeDayDisplay:

	BTFSC      _cashedPortD+0, 7
	GOTO       L_OnOFFTimeDayDisplay48
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
	GOTO       L__OnOFFTimeDayDisplay294
	MOVLW      1
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay294:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay49
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
L_OnOFFTimeDayDisplay49:
	GOTO       L_OnOFFTimeDayDisplay50
L_OnOFFTimeDayDisplay48:
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
	GOTO       L__OnOFFTimeDayDisplay295
	MOVLW      0
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay295:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay51
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay52
	MOVLW      2
	ADDWF      _subMenu+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _subMenu+0
	INCF       _tmp+0, 1
	MOVF       R1+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay53
	MOVLW      2
	MOVWF      _subMenu+0
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay53:
L_OnOFFTimeDayDisplay52:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay276
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay276
	GOTO       L_OnOFFTimeDayDisplay56
L__OnOFFTimeDayDisplay276:
	MOVF       _tmp+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__OnOFFTimeDayDisplay296:
	BTFSC      STATUS+0, 2
	GOTO       L__OnOFFTimeDayDisplay297
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__OnOFFTimeDayDisplay296
L__OnOFFTimeDayDisplay297:
	MOVF       R0+0, 0
	XORWF      _editValue+0, 1
	MOVF       R0+1, 0
	XORWF      _editValue+1, 1
	CALL       _loadEnabledDay+0
L_OnOFFTimeDayDisplay56:
	GOTO       L_OnOFFTimeDayDisplay57
L_OnOFFTimeDayDisplay51:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay58
	INCF       _tmp+0, 1
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay59
	MOVLW      6
	ADDWF      _tmp+0, 1
L_OnOFFTimeDayDisplay59:
L_OnOFFTimeDayDisplay58:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay60
	DECF       _tmp+0, 1
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay61
	MOVLW      6
	SUBWF      _tmp+0, 1
L_OnOFFTimeDayDisplay61:
L_OnOFFTimeDayDisplay60:
	GOTO       L_OnOFFTimeDayDisplay62
L_OnOFFTimeDayDisplay64:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay65
	MOVLW      6
	MOVWF      _subMenu+0
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay65:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay66
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay67
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay67:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay66:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay68
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay69
	MOVLW      35
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay69:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay68:
	GOTO       L_OnOFFTimeDayDisplay63
L_OnOFFTimeDayDisplay70:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay71
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
L_OnOFFTimeDayDisplay71:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay72
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay73
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay73:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay72:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay74
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay75
	MOVLW      89
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay75:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay74:
	GOTO       L_OnOFFTimeDayDisplay63
L_OnOFFTimeDayDisplay76:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay77
	MOVLW      14
	MOVWF      _subMenu+0
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay77:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay78
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay79
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay79:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay78:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay80
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay81
	MOVLW      35
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay81:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
L_OnOFFTimeDayDisplay80:
	GOTO       L_OnOFFTimeDayDisplay63
L_OnOFFTimeDayDisplay82:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay83
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
L_OnOFFTimeDayDisplay83:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay84
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay85
	CLRF       _tmp+0
L_OnOFFTimeDayDisplay85:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay84:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay86
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay87
	MOVLW      89
	MOVWF      _tmp+0
L_OnOFFTimeDayDisplay87:
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
L_OnOFFTimeDayDisplay86:
	GOTO       L_OnOFFTimeDayDisplay63
L_OnOFFTimeDayDisplay62:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay64
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay70
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay76
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay82
L_OnOFFTimeDayDisplay63:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay275
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay275
	GOTO       L_OnOFFTimeDayDisplay90
L__OnOFFTimeDayDisplay275:
	CALL       _loadOnOffTime+0
L_OnOFFTimeDayDisplay90:
L_OnOFFTimeDayDisplay57:
L_OnOFFTimeDayDisplay50:
L_end_OnOFFTimeDayDisplay:
	RETURN
; end of _OnOFFTimeDayDisplay

_checkKey:

	MOVLW      30
	MOVWF      _timeEEAddr+0
L_checkKey91:
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey299
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey300
L__checkKey299:
	BSF        _cashedPortD+0, 7
L__checkKey300:
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey301
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey302
L__checkKey301:
	BSF        _cashedPortD+0, 6
L__checkKey302:
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey303
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey304
L__checkKey303:
	BSF        _cashedPortD+0, 5
L__checkKey304:
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey305
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey306
L__checkKey305:
	BSF        _cashedPortD+0, 4
L__checkKey306:
	MOVLW      240
	SUBWF      _cashedPortD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey94
	CLRF       _waitCount+0
	CLRF       _waitCount+1
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey95:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey95
	DECFSZ     R12+0, 1
	GOTO       L_checkKey95
	DECFSZ     R11+0, 1
	GOTO       L_checkKey95
	NOP
	NOP
L_checkKey94:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey96
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey97
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	GOTO       L_checkKey98
L_checkKey97:
	CALL       _saveValue+0
L_checkKey98:
	INCF       _crntMenu+0, 1
	MOVF       _crntMenu+0, 0
	SUBLW      21
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey99
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
L_checkKey99:
L_checkKey96:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey100
	CALL       _saveValue+0
L_checkKey100:
	GOTO       L_checkKey101
L_checkKey103:
	GOTO       L_checkKey102
L_checkKey104:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey105
	CLRF       _subMenu+0
	CALL       _loadDateEdit+0
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
	GOTO       L_checkKey106
L_checkKey105:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey107
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
	GOTO       L__checkKey307
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey307:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey108
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey108:
L_checkKey107:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey109
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
	GOTO       L__checkKey308
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey308:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey110
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey110:
L_checkKey109:
	GOTO       L_checkKey111
L_checkKey113:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey114
	MOVLW      3
	MOVWF      _subMenu+0
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey114:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey115
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey309
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey309:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey116
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey116:
L_checkKey115:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey117
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey310
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey310:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey118
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey118:
L_checkKey117:
	GOTO       L_checkKey112
L_checkKey119:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey120
	MOVLW      6
	MOVWF      _subMenu+0
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey120:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey121
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey311
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey311:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey122
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey122:
L_checkKey121:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey123
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey312
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey312:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey124
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey124:
L_checkKey123:
	GOTO       L_checkKey112
L_checkKey125:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey126
	MOVLW      9
	MOVWF      _subMenu+0
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey126:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey127
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey313
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey313:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey128
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey128:
L_checkKey127:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey129
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey314
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey314:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey130
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey130:
L_checkKey129:
	GOTO       L_checkKey112
L_checkKey131:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey132
	CLRF       _subMenu+0
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey132:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey133
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey315
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey315:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey134
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey134:
L_checkKey133:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey135
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey316
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey316:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey136
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey136:
L_checkKey135:
	GOTO       L_checkKey112
L_checkKey111:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey113
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey119
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey125
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey131
L_checkKey112:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey288
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey288
	GOTO       L_checkKey139
L__checkKey288:
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey140
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
	GOTO       L_checkKey141
L_checkKey140:
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
L_checkKey141:
L_checkKey139:
L_checkKey106:
	GOTO       L_checkKey102
L_checkKey142:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey143
	CLRF       _subMenu+0
	CALL       _loadTimeEdit+0
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
	GOTO       L_checkKey144
L_checkKey143:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey145
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
	GOTO       L__checkKey317
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey317:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey146
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey146:
L_checkKey145:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey147
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
	GOTO       L__checkKey318
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey318:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey148
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey148:
L_checkKey147:
	GOTO       L_checkKey149
L_checkKey151:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey152
	MOVLW      3
	MOVWF      _subMenu+0
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey152:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey153
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey319
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey319:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey154
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey154:
L_checkKey153:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey155
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey320
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey320:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey156
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey156:
L_checkKey155:
	GOTO       L_checkKey150
L_checkKey157:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey158
	CLRF       _subMenu+0
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey158:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey159
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey321
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey321:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey160
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey160:
L_checkKey159:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey161
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey322
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey322:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey162
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey162:
L_checkKey161:
	GOTO       L_checkKey150
L_checkKey149:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey151
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey157
L_checkKey150:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey287
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey287
	GOTO       L_checkKey165
L__checkKey287:
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
L_checkKey165:
L_checkKey144:
	GOTO       L_checkKey102
L_checkKey166:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey167
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
	GOTO       L_checkKey168
L_checkKey167:
	GOTO       L_checkKey169
L_checkKey171:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey172
	MOVLW      7
	MOVWF      _subMenu+0
L_checkKey172:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey286
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey286
	GOTO       L_checkKey175
L__checkKey286:
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
L_checkKey175:
	GOTO       L_checkKey170
L_checkKey176:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey177
	MOVLW      13
	MOVWF      _subMenu+0
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey177:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey178
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
	GOTO       L__checkKey323
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey323:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey179
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey179:
L_checkKey178:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey180
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
	GOTO       L__checkKey324
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey324:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey181
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey181:
L_checkKey180:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey285
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey285
	GOTO       L_checkKey184
L__checkKey285:
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
L_checkKey184:
	GOTO       L_checkKey170
L_checkKey185:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey186
	CLRF       _subMenu+0
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey186:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey187
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey325
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey325:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey188
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey188:
L_checkKey187:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey189
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey326
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey326:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey190
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey190:
L_checkKey189:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey284
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey284
	GOTO       L_checkKey193
L__checkKey284:
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
L_checkKey193:
	GOTO       L_checkKey170
L_checkKey169:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey171
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey176
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey185
L_checkKey170:
L_checkKey168:
	GOTO       L_checkKey102
L_checkKey194:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey195
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
	GOTO       L_checkKey196
L_checkKey195:
	GOTO       L_checkKey197
L_checkKey199:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey200
	MOVLW      8
	MOVWF      _subMenu+0
L_checkKey200:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey283
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey283
	GOTO       L_checkKey203
L__checkKey283:
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
L_checkKey203:
	GOTO       L_checkKey198
L_checkKey204:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey205
	MOVLW      13
	MOVWF      _subMenu+0
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey205:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey206
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
	GOTO       L__checkKey327
	MOVF       R1+0, 0
	SUBLW      201
L__checkKey327:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey207
	MOVLW      11
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey207:
L_checkKey206:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey208
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
	GOTO       L__checkKey328
	MOVLW      11
	SUBWF      R1+0, 0
L__checkKey328:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey209
	MOVLW      201
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey209:
L_checkKey208:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey282
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey282
	GOTO       L_checkKey212
L__checkKey282:
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
L_checkKey212:
	GOTO       L_checkKey198
L_checkKey213:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey214
	CLRF       _subMenu+0
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey214:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey215
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey329
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey329:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey216
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey216:
L_checkKey215:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey217
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey330
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey330:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey218
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey218:
L_checkKey217:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey281
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey281
	GOTO       L_checkKey221
L__checkKey281:
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
L_checkKey221:
	GOTO       L_checkKey198
L_checkKey197:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey199
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey204
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey213
L_checkKey198:
L_checkKey196:
	GOTO       L_checkKey102
L_checkKey222:
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey223
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
	GOTO       L_checkKey224
L_checkKey223:
	GOTO       L_checkKey225
L_checkKey227:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey228
	MOVLW      8
	MOVWF      _subMenu+0
L_checkKey228:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey280
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey280
	GOTO       L_checkKey231
L__checkKey280:
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
L_checkKey231:
	GOTO       L_checkKey226
L_checkKey232:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey233
	MOVLW      13
	MOVWF      _subMenu+0
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey233:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey234
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
	GOTO       L__checkKey331
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey331:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey235
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey235:
L_checkKey234:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey236
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
	GOTO       L__checkKey332
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey332:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey237
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey237:
L_checkKey236:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey279
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey279
	GOTO       L_checkKey240
L__checkKey279:
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
L_checkKey240:
	GOTO       L_checkKey226
L_checkKey241:
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey242
	CLRF       _subMenu+0
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
L_checkKey242:
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey243
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey333
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey333:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey244
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey244:
L_checkKey243:
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey245
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey334
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey334:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey246
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey246:
L_checkKey245:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey278
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey278
	GOTO       L_checkKey249
L__checkKey278:
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
L_checkKey249:
	GOTO       L_checkKey226
L_checkKey225:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey227
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey232
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey241
L_checkKey226:
L_checkKey224:
	GOTO       L_checkKey102
L_checkKey250:
	MOVLW      20
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey251:
	MOVLW      20
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey252:
	MOVLW      25
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey253:
	MOVLW      25
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey254:
	MOVLW      30
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey255:
	MOVLW      30
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey256:
	MOVLW      35
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey257:
	MOVLW      35
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey258:
	MOVLW      40
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey259:
	MOVLW      40
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey260:
	MOVLW      45
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey261:
	MOVLW      45
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey262:
	MOVLW      50
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey263:
	MOVLW      50
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey264:
	MOVLW      55
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey265:
	MOVLW      55
	MOVWF      _timeEEAddr+0
	CALL       _OnOFFTimeDayDisplay+0
	GOTO       L_checkKey102
L_checkKey266:
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
	GOTO       L_checkKey102
L_checkKey101:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey103
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey104
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey142
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey166
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey194
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey222
	MOVF       _crntMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey250
	MOVF       _crntMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey251
	MOVF       _crntMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey252
	MOVF       _crntMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey253
	MOVF       _crntMenu+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey254
	MOVF       _crntMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey255
	MOVF       _crntMenu+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey256
	MOVF       _crntMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey257
	MOVF       _crntMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey258
	MOVF       _crntMenu+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey259
	MOVF       _crntMenu+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey260
	MOVF       _crntMenu+0, 0
	XORLW      17
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey261
	MOVF       _crntMenu+0, 0
	XORLW      18
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey262
	MOVF       _crntMenu+0, 0
	XORLW      19
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey263
	MOVF       _crntMenu+0, 0
	XORLW      20
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey264
	MOVF       _crntMenu+0, 0
	XORLW      21
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey265
	GOTO       L_checkKey266
L_checkKey102:
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey267
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
L_checkKey267:
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey277
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey277
	GOTO       L_checkKey270
L__checkKey277:
	BSF        _isEdited+0, BitPos(_isEdited+0)
L_checkKey270:
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey271:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey271
	DECFSZ     R12+0, 1
	GOTO       L_checkKey271
	DECFSZ     R11+0, 1
	GOTO       L_checkKey271
	NOP
	NOP
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey335
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey335:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey272
	CLRF       _crntMenu+0
	CLRF       _subMenu+0
	CALL       _initLCDRaws+0
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
L_checkKey272:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey91
	CALL       _saveValue+0
L_end_checkKey:
	RETURN
; end of _checkKey
