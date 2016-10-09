
_codetxt_to_ramtxt:

;Menu.c,50 :: 		char * codetxt_to_ramtxt(const char* ctxt)
;Menu.c,54 :: 		for(i =0; i<20; i++){
	CLRF       R3+0
L_codetxt_to_ramtxt0:
	MOVLW      20
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_codetxt_to_ramtxt1
;Menu.c,55 :: 		txt[i] = ctxt[i];
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
;Menu.c,54 :: 		for(i =0; i<20; i++){
	INCF       R3+0, 1
;Menu.c,56 :: 		}
	GOTO       L_codetxt_to_ramtxt0
L_codetxt_to_ramtxt1:
;Menu.c,57 :: 		return txt;
	MOVLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R0+0
;Menu.c,58 :: 		}
L_end_codetxt_to_ramtxt:
	RETURN
; end of _codetxt_to_ramtxt

_strCpyLimit:

;Menu.c,60 :: 		void strCpyLimit(unsigned char *source,unsigned char *dest,short from,short count)
;Menu.c,62 :: 		unsigned short index = from;
	MOVF       FARG_strCpyLimit_from+0, 0
	MOVWF      R2+0
;Menu.c,63 :: 		unsigned short to = from + count;
	MOVF       FARG_strCpyLimit_count+0, 0
	ADDWF      FARG_strCpyLimit_from+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      FARG_strCpyLimit_from+0, 7
	MOVLW      255
	MOVWF      R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      0
	BTFSC      FARG_strCpyLimit_count+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      R3+0
;Menu.c,64 :: 		for(index = from;index<to;index++){
	MOVF       FARG_strCpyLimit_from+0, 0
	MOVWF      R2+0
L_strCpyLimit3:
	MOVF       R3+0, 0
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_strCpyLimit4
;Menu.c,65 :: 		dest[index - from] = source[index];
	MOVF       FARG_strCpyLimit_from+0, 0
	SUBWF      R2+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      1
	BTFSS      FARG_strCpyLimit_from+0, 7
	MOVLW      0
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_strCpyLimit_dest+0, 0
	MOVWF      R1+0
	MOVF       R2+0, 0
	ADDWF      FARG_strCpyLimit_source+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Menu.c,64 :: 		for(index = from;index<to;index++){
	INCF       R2+0, 1
;Menu.c,66 :: 		}
	GOTO       L_strCpyLimit3
L_strCpyLimit4:
;Menu.c,67 :: 		dest[index - from] = '\0';
	MOVF       FARG_strCpyLimit_from+0, 0
	SUBWF      R2+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      1
	BTFSS      FARG_strCpyLimit_from+0, 7
	MOVLW      0
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      FARG_strCpyLimit_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;Menu.c,68 :: 		}
L_end_strCpyLimit:
	RETURN
; end of _strCpyLimit

_menuPortPinInt:

;Menu.c,69 :: 		void menuPortPinInt(){
;Menu.c,72 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,73 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,74 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,75 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,78 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_checkKey:

;Menu.c,80 :: 		void checkKey(){
;Menu.c,82 :: 		do{
L_checkKey6:
;Menu.c,83 :: 		if (MENU == ON) {
	BTFSS      PORTD+0, 7
	GOTO       L_checkKey9
;Menu.c,84 :: 		editStr[0] = '\0';
	CLRF       _editStr+0
;Menu.c,86 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,87 :: 		switch (crntMenu) {
	GOTO       L_checkKey10
;Menu.c,88 :: 		case None:
L_checkKey12:
;Menu.c,89 :: 		Lcd_Cmd(_LCD_UNDERLINE_ON);
	MOVLW      14
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,90 :: 		crntMenu = Date;
	MOVLW      1
	MOVWF      _crntMenu+0
;Menu.c,91 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,92 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,93 :: 		strCpyLimit(lcdrow2,editStr,0,2);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strCpyLimit_source+0
	MOVLW      _editStr+0
	MOVWF      FARG_strCpyLimit_dest+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      2
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;Menu.c,94 :: 		break;
	GOTO       L_checkKey11
;Menu.c,95 :: 		case Date:
L_checkKey13:
;Menu.c,96 :: 		crntMenu = Time;
	MOVLW      2
	MOVWF      _crntMenu+0
;Menu.c,97 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,98 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,99 :: 		strCpyLimit(lcdrow2,editStr,0,2);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strCpyLimit_source+0
	MOVLW      _editStr+0
	MOVWF      FARG_strCpyLimit_dest+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      2
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;Menu.c,100 :: 		break;
	GOTO       L_checkKey11
;Menu.c,101 :: 		case Time:
L_checkKey14:
;Menu.c,102 :: 		crntMenu = Voltage;
	MOVLW      3
	MOVWF      _crntMenu+0
;Menu.c,103 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,104 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh Low"));
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
;Menu.c,105 :: 		loadEnHeighLow(voltHeigh(),voltLow());
	CALL       _voltLow+0
	MOVF       R0+0, 0
	MOVWF      FLOC__checkKey+0
	MOVF       R0+1, 0
	MOVWF      FLOC__checkKey+1
	CALL       _voltHeigh+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       FLOC__checkKey+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       FLOC__checkKey+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CALL       _loadEnHeighLow+0
;Menu.c,106 :: 		strCpyLimit(lcdrow2,editStr,0,3);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strCpyLimit_source+0
	MOVLW      _editStr+0
	MOVWF      FARG_strCpyLimit_dest+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      3
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;Menu.c,107 :: 		break;
	GOTO       L_checkKey11
;Menu.c,108 :: 		case Voltage:
L_checkKey15:
;Menu.c,109 :: 		crntMenu = Current;
	MOVLW      4
	MOVWF      _crntMenu+0
;Menu.c,110 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,111 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp Heigh Low"));
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
;Menu.c,112 :: 		loadEnHeighLow(currHeigh(),currLow());
	CALL       _currLow+0
	MOVF       R0+0, 0
	MOVWF      FLOC__checkKey+0
	MOVF       R0+1, 0
	MOVWF      FLOC__checkKey+1
	CALL       _currHeigh+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       FLOC__checkKey+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       FLOC__checkKey+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CALL       _loadEnHeighLow+0
;Menu.c,113 :: 		strCpyLimit(lcdrow2,editStr,0,3);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strCpyLimit_source+0
	MOVLW      _editStr+0
	MOVWF      FARG_strCpyLimit_dest+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      3
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;Menu.c,114 :: 		break;
	GOTO       L_checkKey11
;Menu.c,115 :: 		case Current:
L_checkKey16:
;Menu.c,116 :: 		crntMenu = LDRVal;
	MOVLW      5
	MOVWF      _crntMenu+0
;Menu.c,117 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,118 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR Heigh Low"));
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
;Menu.c,119 :: 		loadEnHeighLow(currHeigh(),currLow());
	CALL       _currLow+0
	MOVF       R0+0, 0
	MOVWF      FLOC__checkKey+0
	MOVF       R0+1, 0
	MOVWF      FLOC__checkKey+1
	CALL       _currHeigh+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       FLOC__checkKey+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       FLOC__checkKey+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CALL       _loadEnHeighLow+0
;Menu.c,120 :: 		strCpyLimit(lcdrow2,editStr,0,3);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strCpyLimit_source+0
	MOVLW      _editStr+0
	MOVWF      FARG_strCpyLimit_dest+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      3
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;Menu.c,121 :: 		break;
	GOTO       L_checkKey11
;Menu.c,122 :: 		default:
L_checkKey17:
;Menu.c,123 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,124 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,125 :: 		strCpyLimit(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"),0,16);
	MOVLW      ?lstr_4_Menu+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_4_Menu+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strCpyLimit_dest+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strCpyLimit_source+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      16
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;Menu.c,126 :: 		strCpyLimit(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "),0,16);
	MOVLW      ?lstr_5_Menu+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_5_Menu+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strCpyLimit_dest+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strCpyLimit_source+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      16
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;Menu.c,127 :: 		break;
	GOTO       L_checkKey11
;Menu.c,128 :: 		}
L_checkKey10:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey12
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey13
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey14
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey15
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey16
	GOTO       L_checkKey17
L_checkKey11:
;Menu.c,129 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,130 :: 		}else if (SELECT == ON){
	GOTO       L_checkKey18
L_checkKey9:
	BTFSS      PORTD+0, 6
	GOTO       L_checkKey19
;Menu.c,131 :: 		delay_ms(30);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_checkKey20:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey20
	DECFSZ     R12+0, 1
	GOTO       L_checkKey20
;Menu.c,132 :: 		switch (crntMenu) {
	GOTO       L_checkKey21
;Menu.c,133 :: 		case Date:
L_checkKey23:
;Menu.c,134 :: 		switch(subMenu){
	GOTO       L_checkKey24
;Menu.c,135 :: 		case DateDay:
L_checkKey26:
;Menu.c,136 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,137 :: 		break;
	GOTO       L_checkKey25
;Menu.c,138 :: 		case DateMonth:
L_checkKey27:
;Menu.c,139 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,140 :: 		break;
	GOTO       L_checkKey25
;Menu.c,141 :: 		case DateYear:
L_checkKey28:
;Menu.c,142 :: 		subMenu = DateWeekDay;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,143 :: 		break;
	GOTO       L_checkKey25
;Menu.c,144 :: 		default:
L_checkKey29:
;Menu.c,145 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,146 :: 		}
	GOTO       L_checkKey25
L_checkKey24:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey26
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey27
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey28
	GOTO       L_checkKey29
L_checkKey25:
;Menu.c,147 :: 		break;
	GOTO       L_checkKey22
;Menu.c,148 :: 		case Time:
L_checkKey30:
;Menu.c,149 :: 		switch(subMenu){
	GOTO       L_checkKey31
;Menu.c,150 :: 		case TimeHour:
L_checkKey33:
;Menu.c,151 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,152 :: 		break;
	GOTO       L_checkKey32
;Menu.c,153 :: 		default:
L_checkKey34:
;Menu.c,154 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,155 :: 		}
	GOTO       L_checkKey32
L_checkKey31:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey33
	GOTO       L_checkKey34
L_checkKey32:
;Menu.c,157 :: 		break;
	GOTO       L_checkKey22
;Menu.c,158 :: 		case Voltage:
L_checkKey35:
;Menu.c,159 :: 		switch(subMenu){
	GOTO       L_checkKey36
;Menu.c,160 :: 		case VoltageEnable:
L_checkKey38:
;Menu.c,161 :: 		subMenu = VoltageHigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,162 :: 		break;
	GOTO       L_checkKey37
;Menu.c,163 :: 		case VoltageHigh:
L_checkKey39:
;Menu.c,164 :: 		subMenu = VoltageLow; break;
	MOVLW      13
	MOVWF      _subMenu+0
	GOTO       L_checkKey37
;Menu.c,165 :: 		default:
L_checkKey40:
;Menu.c,166 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,167 :: 		}
	GOTO       L_checkKey37
L_checkKey36:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey38
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey39
	GOTO       L_checkKey40
L_checkKey37:
;Menu.c,168 :: 		break;
	GOTO       L_checkKey22
;Menu.c,169 :: 		case Current:
L_checkKey41:
;Menu.c,170 :: 		switch(subMenu){
	GOTO       L_checkKey42
;Menu.c,171 :: 		case CurrentEnable:
L_checkKey44:
;Menu.c,172 :: 		subMenu = CurrentHeigh; break;
	MOVLW      8
	MOVWF      _subMenu+0
	GOTO       L_checkKey43
;Menu.c,173 :: 		case CurrentHeigh:
L_checkKey45:
;Menu.c,174 :: 		subMenu = CurrentLow; break;
	MOVLW      13
	MOVWF      _subMenu+0
	GOTO       L_checkKey43
;Menu.c,175 :: 		default:
L_checkKey46:
;Menu.c,176 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,177 :: 		}
	GOTO       L_checkKey43
L_checkKey42:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey44
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey45
	GOTO       L_checkKey46
L_checkKey43:
;Menu.c,178 :: 		break;
	GOTO       L_checkKey22
;Menu.c,179 :: 		case LDRVal:
L_checkKey47:
;Menu.c,180 :: 		switch(subMenu){
	GOTO       L_checkKey48
;Menu.c,181 :: 		case LDRValEnable:
L_checkKey50:
;Menu.c,182 :: 		subMenu = LDRValHeigh; break;
	MOVLW      8
	MOVWF      _subMenu+0
	GOTO       L_checkKey49
;Menu.c,183 :: 		case LDRValHeigh:
L_checkKey51:
;Menu.c,184 :: 		subMenu = LDRValLow; break;
	MOVLW      13
	MOVWF      _subMenu+0
	GOTO       L_checkKey49
;Menu.c,185 :: 		default:
L_checkKey52:
;Menu.c,186 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,187 :: 		}
	GOTO       L_checkKey49
L_checkKey48:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey50
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey51
	GOTO       L_checkKey52
L_checkKey49:
;Menu.c,188 :: 		break;
	GOTO       L_checkKey22
;Menu.c,189 :: 		default:
L_checkKey53:
;Menu.c,190 :: 		break;
	GOTO       L_checkKey22
;Menu.c,191 :: 		}
L_checkKey21:
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey23
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey30
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey35
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey41
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey47
	GOTO       L_checkKey53
L_checkKey22:
;Menu.c,192 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,193 :: 		}else if (PLUS == ON){
	GOTO       L_checkKey54
L_checkKey19:
	BTFSS      PORTD+0, 5
	GOTO       L_checkKey55
;Menu.c,194 :: 		delay_ms(30);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_checkKey56:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey56
	DECFSZ     R12+0, 1
	GOTO       L_checkKey56
;Menu.c,196 :: 		}else if (MINUS == ON){
	GOTO       L_checkKey57
L_checkKey55:
	BTFSS      PORTD+0, 5
	GOTO       L_checkKey58
;Menu.c,197 :: 		delay_ms(30);
	MOVLW      78
	MOVWF      R12+0
	MOVLW      235
	MOVWF      R13+0
L_checkKey59:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey59
	DECFSZ     R12+0, 1
	GOTO       L_checkKey59
;Menu.c,199 :: 		}
L_checkKey58:
L_checkKey57:
L_checkKey54:
L_checkKey18:
;Menu.c,200 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey60:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey60
	DECFSZ     R12+0, 1
	GOTO       L_checkKey60
	DECFSZ     R11+0, 1
	GOTO       L_checkKey60
	NOP
;Menu.c,201 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey6
;Menu.c,204 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
