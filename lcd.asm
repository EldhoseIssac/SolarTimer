
_initLCDRaws:

	MOVLW      ?lstr_1_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_1_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strcpy_from+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strcpy_to+0
	CALL       _strcpy+0
	MOVLW      ?lstr_2_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_2_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strcpy_from+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strcpy_to+0
	CALL       _strcpy+0
L_end_initLCDRaws:
	RETURN
; end of _initLCDRaws

_initLCD:

	CALL       _Lcd_Init+0
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	CALL       _initLCDRaws+0
L_end_initLCD:
	RETURN
; end of _initLCD

_BCD2HignerCh:

	MOVLW      15
	ANDWF      FARG_BCD2HignerCh_bcd+1, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
L_end_BCD2HignerCh:
	RETURN
; end of _BCD2HignerCh

_BCD2UpperCh:

	MOVF       FARG_BCD2UpperCh_bcd+0, 0
	MOVWF      FARG_Swap_input+0
	CALL       _Swap+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      48
	ADDWF      R0+0, 1
L_end_BCD2UpperCh:
	RETURN
; end of _BCD2UpperCh

_BCD2LowerCh:

	MOVLW      15
	ANDWF      FARG_BCD2LowerCh_bcd+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
L_end_BCD2LowerCh:
	RETURN
; end of _BCD2LowerCh

_Binary2BCD:

	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Binary2BCD_a+0, 0
	MOVWF      R0+0
	MOVF       FARG_Binary2BCD_a+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+3
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Binary2BCD_a+0, 0
	MOVWF      R0+0
	MOVF       FARG_Binary2BCD_a+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Binary2BCD+1
	MOVF       R0+1, 0
	MOVWF      FLOC__Binary2BCD+2
	MOVF       FLOC__Binary2BCD+1, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FLOC__Binary2BCD+2, 0
	MOVWF      FARG_Binary2BCD_a+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Binary2BCD+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Binary2BCD+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Binary2BCD+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Binary2BCD+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVLW      0
	ANDWF      R4+1, 1
	MOVF       R4+0, 0
	MOVWF      R2+1
	CLRF       R2+0
	MOVF       FLOC__Binary2BCD+0, 0
	IORWF      FLOC__Binary2BCD+3, 0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
L_end_Binary2BCD:
	RETURN
; end of _Binary2BCD

_BCD2Binary:

	MOVLW      15
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      FLOC__BCD2Binary+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      FLOC__BCD2Binary+1
	MOVLW      0
	ANDWF      FLOC__BCD2Binary+1, 1
	MOVLW      240
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      R3+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      R3+1
	MOVLW      0
	ANDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      FARG_BCD2Binary_a+0
	MOVF       R3+1, 0
	MOVWF      FARG_BCD2Binary_a+1
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__BCD2Binary40:
	BTFSC      STATUS+0, 2
	GOTO       L__BCD2Binary41
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__BCD2Binary40
L__BCD2Binary41:
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__BCD2Binary+0, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__BCD2Binary+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
L_end_BCD2Binary:
	RETURN
; end of _BCD2Binary

_loadDay:

	GOTO       L_loadDay0
L_loadDay2:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay3:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      83
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      117
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      110
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay4:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      77
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      111
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      110
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay5:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      84
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      117
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      101
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay6:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      87
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      101
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay7:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      84
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      104
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      117
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay8:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      70
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      114
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      105
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay9:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      83
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      97
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      116
	MOVWF      INDF+0
	GOTO       L_loadDay1
L_loadDay0:
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay2
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay3
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay4
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay5
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay6
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay7
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay8
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay9
L_loadDay1:
L_end_loadDay:
	RETURN
; end of _loadDay

_displayTimeDate:

	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+0
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+1
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+3
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+4
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+6
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+7
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
	MOVLW      _lcdrow1+13
	MOVWF      FARG_loadDay_arr+0
	MOVF       _dday+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
L_end_displayTimeDate:
	RETURN
; end of _displayTimeDate

_loadTimeEdit:

	MOVLW      ?lstr_3_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_3_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
	MOVLW      58
	MOVWF      _lcdrow2+2
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
	CLRF       _lcdrow2+5
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_end_loadTimeEdit:
	RETURN
; end of _loadTimeEdit

_loadDateEdit:

	MOVLW      ?lstr_4_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_4_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
	MOVLW      47
	MOVWF      _lcdrow2+2
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
	MOVLW      47
	MOVWF      _lcdrow2+5
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
	MOVLW      _lcdrow2+9
	MOVWF      FARG_loadDay_arr+0
	MOVF       _dday+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
	CLRF       _lcdrow2+12
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_end_loadDateEdit:
	RETURN
; end of _loadDateEdit

_setCursorPosition:

	MOVF       _crntMenu+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_setCursorPosition12
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
	GOTO       L__setCursorPosition47
	MOVLW      0
	XORWF      R0+0, 0
L__setCursorPosition47:
	BTFSS      STATUS+0, 2
	GOTO       L_setCursorPosition12
L__setCursorPosition31:
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	GOTO       L_setCursorPosition13
L_setCursorPosition12:
	MOVLW      192
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
L_setCursorPosition13:
	CLRF       setCursorPosition_indx_L0+0
L_setCursorPosition14:
	MOVF       FARG_setCursorPosition_position+0, 0
	SUBWF      setCursorPosition_indx_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setCursorPosition15
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
	INCF       setCursorPosition_indx_L0+0, 1
	GOTO       L_setCursorPosition14
L_setCursorPosition15:
L_end_setCursorPosition:
	RETURN
; end of _setCursorPosition

_loadEnabledDay:

	MOVF       _editValue+0, 0
	MOVWF      loadEnabledDay_tmp_L0+0
	MOVLW      2
	MOVWF      loadEnabledDay_indx_L0+0
	CLRF       loadEnabledDay_i_L0+0
	MOVLW      6
	SUBWF      _crntMenu+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _lcdrow1+0
	INCF       _lcdrow1+0, 1
	MOVLW      41
	MOVWF      _lcdrow1+1
	CLRF       loadEnabledDay_i_L0+0
L_loadEnabledDay17:
	MOVLW      8
	SUBWF      loadEnabledDay_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_loadEnabledDay18
	MOVLW      1
	ANDWF      loadEnabledDay_tmp_L0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnabledDay20
	MOVF       loadEnabledDay_indx_L0+0, 0
	ADDLW      _lcdrow1+0
	MOVWF      FARG_loadDay_arr+0
	INCF       loadEnabledDay_i_L0+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
	GOTO       L_loadEnabledDay21
L_loadEnabledDay20:
	MOVF       loadEnabledDay_indx_L0+0, 0
	ADDLW      _lcdrow1+0
	MOVWF      FARG_loadDay_arr+0
	CLRF       FARG_loadDay_theIndx+0
	CALL       _loadDay+0
L_loadEnabledDay21:
	RRF        loadEnabledDay_tmp_L0+0, 1
	BCF        loadEnabledDay_tmp_L0+0, 7
	MOVLW      2
	ADDWF      loadEnabledDay_indx_L0+0, 1
	INCF       loadEnabledDay_i_L0+0, 1
	GOTO       L_loadEnabledDay17
L_loadEnabledDay18:
	CLRF       _lcdrow1+16
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_end_loadEnabledDay:
	RETURN
; end of _loadEnabledDay

_loadOnOffTime:

	MOVF       _editValue+1, 0
	MOVWF      loadOnOffTime_mi_L0+0
	MOVF       _editValue+0, 0
	MOVWF      loadOnOffTime_hr_L0+0
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__loadOnOffTime32
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L__loadOnOffTime32
	GOTO       L_loadOnOffTime24
L__loadOnOffTime32:
	MOVLW      1
	MOVWF      loadOnOffTime_tmp_L0+0
	MOVLW      0
	MOVWF      loadOnOffTime_tmp_L0+1
	MOVLW      78
	MOVWF      _lcdrow2+0
	GOTO       L_loadOnOffTime25
L_loadOnOffTime24:
	MOVLW      9
	MOVWF      loadOnOffTime_tmp_L0+0
	MOVLW      0
	MOVWF      loadOnOffTime_tmp_L0+1
	MOVLW      70
	MOVWF      _lcdrow2+0
L_loadOnOffTime25:
	MOVLW      62
	MOVWF      _lcdrow2+1
	MOVF       loadOnOffTime_hr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+2
	MOVF       loadOnOffTime_hr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
	MOVLW      58
	MOVWF      _lcdrow2+4
	MOVF       loadOnOffTime_mi_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+5
	MOVF       loadOnOffTime_mi_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
	CLRF       _lcdrow2+7
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       loadOnOffTime_tmp_L0+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_end_loadOnOffTime:
	RETURN
; end of _loadOnOffTime

_loadEnHeighLow:

	MOVF       FARG_loadEnHeighLow_low+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FARG_loadEnHeighLow_low+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_discrr_L0+1
	CLRF       loadEnHeighLow_indx_L0+0
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnHeighLow51
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	SUBLW      0
L__loadEnHeighLow51:
	BTFSC      STATUS+0, 0
	GOTO       L_loadEnHeighLow26
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      79
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      78
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	MOVWF      R0+0
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_disVolt_L0+1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       R0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       R0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       FARG_loadEnHeighLow_shouldUseDecimal+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnHeighLow27
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      46
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
L_loadEnHeighLow27:
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       loadEnHeighLow_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       FARG_loadEnHeighLow_shouldUseDecimal+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnHeighLow28
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      46
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
L_loadEnHeighLow28:
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	CLRF       INDF+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_loadEnHeighLow29
L_loadEnHeighLow26:
	MOVLW      ?lstr_5_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_5_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
L_loadEnHeighLow29:
L_end_loadEnHeighLow:
	RETURN
; end of _loadEnHeighLow

_displayVoltageCurrent:

	MOVF       _lastReadVoltage+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadVoltage+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+1
	MOVF       _lastReadCurrent+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadCurrent+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_discrr_L0+1
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+9
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+10
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+11
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+9
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+10
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+12
L_end_displayVoltageCurrent:
	RETURN
; end of _displayVoltageCurrent

_loadRamToDisp:

	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_end_loadRamToDisp:
	RETURN
; end of _loadRamToDisp

_showWelome:

	MOVLW      ?lstr_6_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_6_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_showWelome30:
	DECFSZ     R13+0, 1
	GOTO       L_showWelome30
	DECFSZ     R12+0, 1
	GOTO       L_showWelome30
	DECFSZ     R11+0, 1
	GOTO       L_showWelome30
	NOP
L_end_showWelome:
	RETURN
; end of _showWelome
