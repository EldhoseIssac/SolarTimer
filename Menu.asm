
_codetxt_to_ramtxt:

;Menu.c,76 :: 		char * codetxt_to_ramtxt(const char* ctxt)
;Menu.c,80 :: 		for(i =0; ctxt[i] != '\0'; i++){
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
;Menu.c,81 :: 		txt[i] = ctxt[i];
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
;Menu.c,80 :: 		for(i =0; ctxt[i] != '\0'; i++){
	INCF       R3+0, 1
;Menu.c,82 :: 		}
	GOTO       L_codetxt_to_ramtxt0
L_codetxt_to_ramtxt1:
;Menu.c,83 :: 		txt[i] = '\0';
	MOVF       R3+0, 0
	ADDLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Menu.c,84 :: 		return txt;
	MOVLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R0+0
;Menu.c,85 :: 		}
L_end_codetxt_to_ramtxt:
	RETURN
; end of _codetxt_to_ramtxt

_menuPortPinInt:

;Menu.c,87 :: 		void menuPortPinInt(){
;Menu.c,90 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,91 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,92 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,93 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,94 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;Menu.c,97 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_saveValue:

;Menu.c,103 :: 		void saveValue(){
;Menu.c,104 :: 		if (!isEdited){
	BTFSC      _isEdited+0, BitPos(_isEdited+0)
	GOTO       L_saveValue3
;Menu.c,105 :: 		return;
	GOTO       L_end_saveValue
;Menu.c,106 :: 		}
L_saveValue3:
;Menu.c,107 :: 		isEdited = 0;
	BCF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,108 :: 		switch(crntMenu){
	GOTO       L_saveValue4
;Menu.c,109 :: 		case None:
L_saveValue6:
;Menu.c,110 :: 		break;
	GOTO       L_saveValue5
;Menu.c,111 :: 		case Date:
L_saveValue7:
;Menu.c,112 :: 		switch(subMenu){
	GOTO       L_saveValue8
;Menu.c,113 :: 		case DateDay:
L_saveValue10:
;Menu.c,114 :: 		write_ds1307(0x04,editValue);
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,115 :: 		break;
	GOTO       L_saveValue9
;Menu.c,116 :: 		case DateMonth:
L_saveValue11:
;Menu.c,117 :: 		write_ds1307(0x05,editValue);
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,118 :: 		break;
	GOTO       L_saveValue9
;Menu.c,119 :: 		case DateYear:
L_saveValue12:
;Menu.c,120 :: 		write_ds1307(0x06,editValue);
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,121 :: 		break;
	GOTO       L_saveValue9
;Menu.c,122 :: 		case DateWeekDay:
L_saveValue13:
;Menu.c,123 :: 		write_ds1307(0x03,editValue);
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,124 :: 		break;
	GOTO       L_saveValue9
;Menu.c,125 :: 		}
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
;Menu.c,126 :: 		break;
	GOTO       L_saveValue5
;Menu.c,127 :: 		case Time:
L_saveValue14:
;Menu.c,128 :: 		switch(subMenu){
	GOTO       L_saveValue15
;Menu.c,129 :: 		case TimeHour:
L_saveValue17:
;Menu.c,130 :: 		write_ds1307(0x02,editValue);
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,131 :: 		break;
	GOTO       L_saveValue16
;Menu.c,132 :: 		case TimeMinute:
L_saveValue18:
;Menu.c,133 :: 		write_ds1307(0x01,editValue);
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,134 :: 		break;
	GOTO       L_saveValue16
;Menu.c,135 :: 		}
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
;Menu.c,136 :: 		break;
	GOTO       L_saveValue5
;Menu.c,137 :: 		case Voltage:
L_saveValue19:
;Menu.c,138 :: 		switch(submenu){
	GOTO       L_saveValue20
;Menu.c,139 :: 		case VoltageLow:
L_saveValue22:
;Menu.c,140 :: 		ee_write(EEPADDR_VoltageLow,editValue);
	MOVLW      4
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,141 :: 		break;
	GOTO       L_saveValue21
;Menu.c,142 :: 		case VoltageHigh:
L_saveValue23:
;Menu.c,143 :: 		ee_write(EEPADDR_VoltageHigh,editValue);
	MOVLW      2
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,144 :: 		break;
	GOTO       L_saveValue21
;Menu.c,145 :: 		}
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
;Menu.c,146 :: 		break;
	GOTO       L_saveValue5
;Menu.c,147 :: 		case Current:
L_saveValue24:
;Menu.c,148 :: 		switch(submenu){
	GOTO       L_saveValue25
;Menu.c,149 :: 		case CurrentHeigh:
L_saveValue27:
;Menu.c,150 :: 		ee_write(EEPADDR_CurrentHeigh,editValue);
	MOVLW      6
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,151 :: 		break;
	GOTO       L_saveValue26
;Menu.c,152 :: 		case CurrentLow:
L_saveValue28:
;Menu.c,153 :: 		ee_write(EEPADDR_CurrentLow,editValue);
	MOVLW      8
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,154 :: 		break;
	GOTO       L_saveValue26
;Menu.c,155 :: 		}
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
;Menu.c,156 :: 		break;
	GOTO       L_saveValue5
;Menu.c,157 :: 		case LDRVal:
L_saveValue29:
;Menu.c,158 :: 		switch(submenu){
	GOTO       L_saveValue30
;Menu.c,159 :: 		case LDRValLow:
L_saveValue32:
;Menu.c,160 :: 		ee_write(EEPADDR_LDRvalLow,editValue);
	MOVLW      12
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,161 :: 		break;
	GOTO       L_saveValue31
;Menu.c,162 :: 		case LDRValHeigh:
L_saveValue33:
;Menu.c,163 :: 		ee_write(EEPADDR_LDRvalHeigh,editValue);
	MOVLW      10
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,164 :: 		break;
	GOTO       L_saveValue31
;Menu.c,165 :: 		}
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
;Menu.c,166 :: 		break;
	GOTO       L_saveValue5
;Menu.c,167 :: 		default:
L_saveValue34:
;Menu.c,168 :: 		if(crntMenu<(OnOFFTime+8))
	MOVLW      14
	SUBWF      _crntMenu+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_saveValue35
;Menu.c,170 :: 		ee_write(timeEEAddr,editValue);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,171 :: 		}
L_saveValue35:
;Menu.c,172 :: 		break;
	GOTO       L_saveValue5
;Menu.c,174 :: 		}
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
;Menu.c,175 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_checkKey:

;Menu.c,194 :: 		void checkKey(){
;Menu.c,196 :: 		unsigned int timeEditTemp = 0;
	CLRF       checkKey_timeEditTemp_L0+0
	CLRF       checkKey_timeEditTemp_L0+1
;Menu.c,197 :: 		timeEEAddr = EEPADDR_OnOFFTimeEdit1-2;
	MOVLW      14
	MOVWF      _timeEEAddr+0
;Menu.c,198 :: 		do{
L_checkKey36:
;Menu.c,199 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey267
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey268
L__checkKey267:
	BSF        _cashedPortD+0, 7
L__checkKey268:
;Menu.c,200 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey269
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey270
L__checkKey269:
	BSF        _cashedPortD+0, 6
L__checkKey270:
;Menu.c,201 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey271
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey272
L__checkKey271:
	BSF        _cashedPortD+0, 5
L__checkKey272:
;Menu.c,202 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey273
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey274
L__checkKey273:
	BSF        _cashedPortD+0, 4
L__checkKey274:
;Menu.c,206 :: 		if(cashedPortD < 0xF0)
	MOVLW      240
	SUBWF      _cashedPortD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey39
;Menu.c,210 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,211 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey40:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey40
	DECFSZ     R12+0, 1
	GOTO       L_checkKey40
	DECFSZ     R11+0, 1
	GOTO       L_checkKey40
	NOP
;Menu.c,212 :: 		}
L_checkKey39:
;Menu.c,213 :: 		if(cMENU == ON){
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey41
;Menu.c,214 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,215 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey42
;Menu.c,216 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,217 :: 		}else{
	GOTO       L_checkKey43
L_checkKey42:
;Menu.c,218 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,219 :: 		}
L_checkKey43:
;Menu.c,220 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,221 :: 		if(crntMenu>(OnOFFTime+8))
	MOVF       _crntMenu+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey44
;Menu.c,223 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,224 :: 		}
L_checkKey44:
;Menu.c,225 :: 		}
L_checkKey41:
;Menu.c,226 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey45
;Menu.c,228 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,229 :: 		}
L_checkKey45:
;Menu.c,230 :: 		switch(crntMenu)
	GOTO       L_checkKey46
;Menu.c,232 :: 		case None:
L_checkKey48:
;Menu.c,233 :: 		break;
	GOTO       L_checkKey47
;Menu.c,234 :: 		case Date:
L_checkKey49:
;Menu.c,235 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey50
;Menu.c,237 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,238 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,239 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,240 :: 		}
	GOTO       L_checkKey51
L_checkKey50:
;Menu.c,243 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey52
;Menu.c,245 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,246 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey275
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey275:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey53
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey53:
;Menu.c,247 :: 		}
L_checkKey52:
;Menu.c,248 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey54
;Menu.c,250 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,251 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey276
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey276:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey55
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey55:
;Menu.c,252 :: 		}
L_checkKey54:
;Menu.c,253 :: 		switch(subMenu)
	GOTO       L_checkKey56
;Menu.c,256 :: 		case DateDay:
L_checkKey58:
;Menu.c,257 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey59
;Menu.c,259 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,260 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,261 :: 		}
L_checkKey59:
;Menu.c,262 :: 		if(cPLUS == ON){
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey60
;Menu.c,263 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey277
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey277:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey61
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey61:
;Menu.c,264 :: 		}
L_checkKey60:
;Menu.c,265 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey62
;Menu.c,267 :: 		if(editValue == 0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey278
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey278:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey63
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey63:
;Menu.c,268 :: 		}
L_checkKey62:
;Menu.c,269 :: 		break;
	GOTO       L_checkKey57
;Menu.c,270 :: 		case DateMonth:
L_checkKey64:
;Menu.c,271 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey65
;Menu.c,273 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,274 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,275 :: 		}
L_checkKey65:
;Menu.c,276 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey66
;Menu.c,278 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey279
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey279:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey67
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey67:
;Menu.c,279 :: 		}
L_checkKey66:
;Menu.c,280 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey68
;Menu.c,282 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey280
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey280:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey69
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey69:
;Menu.c,283 :: 		}
L_checkKey68:
;Menu.c,285 :: 		break;
	GOTO       L_checkKey57
;Menu.c,286 :: 		case DateYear:
L_checkKey70:
;Menu.c,287 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey71
;Menu.c,289 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,290 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,291 :: 		}
L_checkKey71:
;Menu.c,292 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey72
;Menu.c,294 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey281
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey281:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey73
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey73:
;Menu.c,295 :: 		}
L_checkKey72:
;Menu.c,296 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey74
;Menu.c,298 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey282
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey282:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey75
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey75:
;Menu.c,299 :: 		}
L_checkKey74:
;Menu.c,301 :: 		break;
	GOTO       L_checkKey57
;Menu.c,302 :: 		case DateWeekDay:
L_checkKey76:
;Menu.c,303 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey77
;Menu.c,305 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,306 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,307 :: 		}
L_checkKey77:
;Menu.c,308 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey78
;Menu.c,310 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey283
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey283:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey79
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey79:
;Menu.c,311 :: 		}
L_checkKey78:
;Menu.c,312 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey80
;Menu.c,314 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey284
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey284:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey81
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey81:
;Menu.c,315 :: 		}
L_checkKey80:
;Menu.c,316 :: 		break;
	GOTO       L_checkKey57
;Menu.c,318 :: 		}
L_checkKey56:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey58
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey64
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey70
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey76
L_checkKey57:
;Menu.c,319 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey262
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey262
	GOTO       L_checkKey84
L__checkKey262:
;Menu.c,321 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey85
;Menu.c,323 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,324 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,325 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,326 :: 		}
	GOTO       L_checkKey86
L_checkKey85:
;Menu.c,329 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,330 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,331 :: 		}
L_checkKey86:
;Menu.c,332 :: 		}
L_checkKey84:
;Menu.c,334 :: 		}
L_checkKey51:
;Menu.c,335 :: 		break;
	GOTO       L_checkKey47
;Menu.c,336 :: 		case Time:
L_checkKey87:
;Menu.c,337 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey88
;Menu.c,339 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,340 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,341 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,342 :: 		}
	GOTO       L_checkKey89
L_checkKey88:
;Menu.c,345 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey90
;Menu.c,347 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,348 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey285
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey285:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey91
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey91:
;Menu.c,349 :: 		}
L_checkKey90:
;Menu.c,350 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey92
;Menu.c,352 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,353 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey286
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey286:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey93
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey93:
;Menu.c,354 :: 		}
L_checkKey92:
;Menu.c,355 :: 		switch(subMenu)
	GOTO       L_checkKey94
;Menu.c,357 :: 		case TimeHour:
L_checkKey96:
;Menu.c,358 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey97
;Menu.c,360 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,361 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,362 :: 		}
L_checkKey97:
;Menu.c,363 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey98
;Menu.c,365 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey287
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey287:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey99
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey99:
;Menu.c,366 :: 		}
L_checkKey98:
;Menu.c,367 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey100
;Menu.c,369 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey288
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey288:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey101
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey101:
;Menu.c,370 :: 		}
L_checkKey100:
;Menu.c,371 :: 		break;
	GOTO       L_checkKey95
;Menu.c,372 :: 		case TimeMinute:
L_checkKey102:
;Menu.c,373 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey103
;Menu.c,375 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,376 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,377 :: 		}
L_checkKey103:
;Menu.c,378 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey104
;Menu.c,380 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey289
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey289:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey105
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey105:
;Menu.c,381 :: 		}
L_checkKey104:
;Menu.c,382 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey106
;Menu.c,384 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey290
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey290:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey107
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey107:
;Menu.c,385 :: 		}
L_checkKey106:
;Menu.c,386 :: 		break;
	GOTO       L_checkKey95
;Menu.c,387 :: 		}
L_checkKey94:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey96
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey102
L_checkKey95:
;Menu.c,388 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey261
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey261
	GOTO       L_checkKey110
L__checkKey261:
;Menu.c,390 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,391 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,392 :: 		}
L_checkKey110:
;Menu.c,393 :: 		}
L_checkKey89:
;Menu.c,394 :: 		break;
	GOTO       L_checkKey47
;Menu.c,395 :: 		case   Voltage:
L_checkKey111:
;Menu.c,396 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey112
;Menu.c,398 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,399 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,400 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,401 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,402 :: 		}
	GOTO       L_checkKey113
L_checkKey112:
;Menu.c,405 :: 		switch(subMenu)
	GOTO       L_checkKey114
;Menu.c,407 :: 		case VoltageEnable:
L_checkKey116:
;Menu.c,408 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey117
;Menu.c,410 :: 		subMenu = VoltageHigh;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,411 :: 		}
L_checkKey117:
;Menu.c,412 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey260
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey260
	GOTO       L_checkKey120
L__checkKey260:
;Menu.c,414 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,415 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,416 :: 		}
L_checkKey120:
;Menu.c,417 :: 		break;
	GOTO       L_checkKey115
;Menu.c,418 :: 		case VoltageHigh:
L_checkKey121:
;Menu.c,419 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey122
;Menu.c,421 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,422 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,423 :: 		}
L_checkKey122:
;Menu.c,424 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey123
;Menu.c,426 :: 		editValue += 2;
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
;Menu.c,427 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey291
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey291:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey124
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey124:
;Menu.c,429 :: 		}
L_checkKey123:
;Menu.c,430 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey125
;Menu.c,432 :: 		editValue -= 2;
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
;Menu.c,433 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey292
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey292:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey126
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey126:
;Menu.c,434 :: 		}
L_checkKey125:
;Menu.c,435 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey259
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey259
	GOTO       L_checkKey129
L__checkKey259:
;Menu.c,437 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,438 :: 		}
L_checkKey129:
;Menu.c,439 :: 		break;
	GOTO       L_checkKey115
;Menu.c,440 :: 		case VoltageLow:
L_checkKey130:
;Menu.c,441 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey131
;Menu.c,443 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,444 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,445 :: 		}
L_checkKey131:
;Menu.c,446 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey132
;Menu.c,448 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,449 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey293
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey293:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey133
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey133:
;Menu.c,451 :: 		}
L_checkKey132:
;Menu.c,452 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey134
;Menu.c,454 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,455 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey294
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey294:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey135
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey135:
;Menu.c,456 :: 		}
L_checkKey134:
;Menu.c,457 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey258
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey258
	GOTO       L_checkKey138
L__checkKey258:
;Menu.c,459 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
;Menu.c,460 :: 		}
L_checkKey138:
;Menu.c,461 :: 		break;
	GOTO       L_checkKey115
;Menu.c,463 :: 		}
L_checkKey114:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey116
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey121
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey130
L_checkKey115:
;Menu.c,464 :: 		}
L_checkKey113:
;Menu.c,465 :: 		break;
	GOTO       L_checkKey47
;Menu.c,466 :: 		case Current:
L_checkKey139:
;Menu.c,467 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey140
;Menu.c,469 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,470 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,471 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,472 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,473 :: 		}
	GOTO       L_checkKey141
L_checkKey140:
;Menu.c,476 :: 		switch(subMenu)
	GOTO       L_checkKey142
;Menu.c,478 :: 		case CurrentEnable:
L_checkKey144:
;Menu.c,479 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey145
;Menu.c,481 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,482 :: 		}
L_checkKey145:
;Menu.c,483 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey257
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey257
	GOTO       L_checkKey148
L__checkKey257:
;Menu.c,485 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,486 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,488 :: 		}
L_checkKey148:
;Menu.c,489 :: 		break;
	GOTO       L_checkKey143
;Menu.c,490 :: 		case CurrentHeigh:
L_checkKey149:
;Menu.c,491 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey150
;Menu.c,493 :: 		subMenu = CurrentLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,494 :: 		editValue =  ee_read(EEPADDR_CurrentLow);
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,495 :: 		}
L_checkKey150:
;Menu.c,496 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey151
;Menu.c,498 :: 		editValue += 2;
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
;Menu.c,499 :: 		if (editValue > 201)   editValue = 11;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey295
	MOVF       R1+0, 0
	SUBLW      201
L__checkKey295:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey152
	MOVLW      11
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey152:
;Menu.c,501 :: 		}
L_checkKey151:
;Menu.c,502 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey153
;Menu.c,504 :: 		editValue -= 2;
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
;Menu.c,505 :: 		if (editValue < 11) editValue = 201;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey296
	MOVLW      11
	SUBWF      R1+0, 0
L__checkKey296:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey154
	MOVLW      201
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey154:
;Menu.c,506 :: 		}
L_checkKey153:
;Menu.c,507 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey256
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey256
	GOTO       L_checkKey157
L__checkKey256:
;Menu.c,509 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,510 :: 		}
L_checkKey157:
;Menu.c,511 :: 		break;
	GOTO       L_checkKey143
;Menu.c,512 :: 		case CurrentLow:
L_checkKey158:
;Menu.c,513 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey159
;Menu.c,515 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,516 :: 		editValue =  ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,517 :: 		}
L_checkKey159:
;Menu.c,518 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey160
;Menu.c,520 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,521 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey297
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey297:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey161
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey161:
;Menu.c,523 :: 		}
L_checkKey160:
;Menu.c,524 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey162
;Menu.c,526 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,527 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey298
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey298:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey163
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey163:
;Menu.c,528 :: 		}
L_checkKey162:
;Menu.c,529 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey255
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey255
	GOTO       L_checkKey166
L__checkKey255:
;Menu.c,531 :: 		loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
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
;Menu.c,532 :: 		}
L_checkKey166:
;Menu.c,533 :: 		break;
	GOTO       L_checkKey143
;Menu.c,535 :: 		}
L_checkKey142:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey144
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey149
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey158
L_checkKey143:
;Menu.c,536 :: 		}
L_checkKey141:
;Menu.c,537 :: 		break;
	GOTO       L_checkKey47
;Menu.c,538 :: 		case LDRVal:
L_checkKey167:
;Menu.c,539 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey168
;Menu.c,541 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,542 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,543 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,544 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,545 :: 		}
	GOTO       L_checkKey169
L_checkKey168:
;Menu.c,548 :: 		switch(subMenu)
	GOTO       L_checkKey170
;Menu.c,550 :: 		case LDRValEnable:
L_checkKey172:
;Menu.c,551 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey173
;Menu.c,553 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,554 :: 		}
L_checkKey173:
;Menu.c,555 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey254
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey254
	GOTO       L_checkKey176
L__checkKey254:
;Menu.c,557 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,558 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,559 :: 		}
L_checkKey176:
;Menu.c,560 :: 		break;
	GOTO       L_checkKey171
;Menu.c,561 :: 		case LDRValHeigh:
L_checkKey177:
;Menu.c,562 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey178
;Menu.c,564 :: 		subMenu = LDRValLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,565 :: 		editValue =  ee_read(EEPADDR_LDRValLow);
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,566 :: 		}
L_checkKey178:
;Menu.c,567 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey179
;Menu.c,569 :: 		editValue += 2;
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
;Menu.c,570 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey299
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey299:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey180
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey180:
;Menu.c,572 :: 		}
L_checkKey179:
;Menu.c,573 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey181
;Menu.c,575 :: 		editValue -= 2;
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
;Menu.c,576 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey300
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey300:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey182
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey182:
;Menu.c,577 :: 		}
L_checkKey181:
;Menu.c,578 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey253
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey253
	GOTO       L_checkKey185
L__checkKey253:
;Menu.c,580 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,581 :: 		}
L_checkKey185:
;Menu.c,582 :: 		break;
	GOTO       L_checkKey171
;Menu.c,583 :: 		case LDRValLow:
L_checkKey186:
;Menu.c,584 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey187
;Menu.c,586 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,587 :: 		editValue =  ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,588 :: 		}
L_checkKey187:
;Menu.c,589 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey188
;Menu.c,591 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,592 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey301
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey301:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey189
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey189:
;Menu.c,594 :: 		}
L_checkKey188:
;Menu.c,595 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey190
;Menu.c,597 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,598 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey302
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey302:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey191
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey191:
;Menu.c,599 :: 		}
L_checkKey190:
;Menu.c,600 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey252
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey252
	GOTO       L_checkKey194
L__checkKey252:
;Menu.c,602 :: 		loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
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
;Menu.c,603 :: 		}
L_checkKey194:
;Menu.c,604 :: 		break;
	GOTO       L_checkKey171
;Menu.c,606 :: 		}
L_checkKey170:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey172
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey177
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey186
L_checkKey171:
;Menu.c,607 :: 		}
L_checkKey169:
;Menu.c,608 :: 		break;
	GOTO       L_checkKey47
;Menu.c,609 :: 		default:
L_checkKey195:
;Menu.c,610 :: 		if(crntMenu<(OnOFFTime+8))
	MOVLW      14
	SUBWF      _crntMenu+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey196
;Menu.c,612 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey197
;Menu.c,614 :: 		subMenu = OnOFFTimeEditEnable;
	CLRF       _subMenu+0
;Menu.c,615 :: 		timeEEAddr += 2;
	MOVLW      2
	ADDWF      _timeEEAddr+0, 1
;Menu.c,616 :: 		strcpy(lcdrow1,codetxt_to_ramtxt("Time1 Day  Hr:Mn"));
	MOVLW      ?lstr_4_Menu+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_4_Menu+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strcpy_from+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strcpy_to+0
	CALL       _strcpy+0
;Menu.c,617 :: 		lcdrow1[4]= crntMenu - OnOFFTime + '0' + 1;
	MOVLW      6
	SUBWF      _crntMenu+0, 0
	MOVWF      _lcdrow1+4
	MOVLW      48
	ADDWF      _lcdrow1+4, 1
	INCF       _lcdrow1+4, 1
;Menu.c,618 :: 		Lcd_Out(1,1,lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,619 :: 		editValue = ee_read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,620 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,621 :: 		}
	GOTO       L_checkKey198
L_checkKey197:
;Menu.c,624 :: 		switch (subMenu) {
	GOTO       L_checkKey199
;Menu.c,625 :: 		case OnOFFTimeEditEnable:
L_checkKey201:
;Menu.c,626 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey202
;Menu.c,628 :: 		if (isEnabled)
	BTFSS      _isEnabled+0, BitPos(_isEnabled+0)
	GOTO       L_checkKey203
;Menu.c,630 :: 		subMenu = OnOFFTimeEditOnOff;
	MOVLW      4
	MOVWF      _subMenu+0
;Menu.c,631 :: 		}
L_checkKey203:
;Menu.c,633 :: 		}
L_checkKey202:
;Menu.c,634 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey251
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey251
	GOTO       L_checkKey206
L__checkKey251:
;Menu.c,636 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,637 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,638 :: 		}
L_checkKey206:
;Menu.c,639 :: 		break;
	GOTO       L_checkKey200
;Menu.c,640 :: 		case OnOFFTimeEditOnOff:
L_checkKey207:
;Menu.c,641 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey208
;Menu.c,643 :: 		subMenu = OnOFFTimeEditWeekDay;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,644 :: 		}
L_checkKey208:
;Menu.c,645 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey250
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey250
	GOTO       L_checkKey211
L__checkKey250:
;Menu.c,647 :: 		shouldON = !shouldON;
	MOVLW
	XORWF      _shouldON+0, 1
;Menu.c,648 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,649 :: 		}
L_checkKey211:
;Menu.c,650 :: 		break;
	GOTO       L_checkKey200
;Menu.c,651 :: 		case OnOFFTimeEditWeekDay:
L_checkKey212:
;Menu.c,652 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey213
;Menu.c,654 :: 		subMenu = OnOFFTimeEditHour;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,655 :: 		}
L_checkKey213:
;Menu.c,657 :: 		timeEditTemp = editValue;
	MOVF       _editValue+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       _editValue+1, 0
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,658 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey214
;Menu.c,660 :: 		timeEditTemp += 4;
	MOVLW      4
	ADDWF      checkKey_timeEditTemp_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       checkKey_timeEditTemp_L0+1, 1
;Menu.c,661 :: 		}
L_checkKey214:
;Menu.c,662 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey215
;Menu.c,664 :: 		timeEditTemp -= 4;
	MOVLW      4
	SUBWF      checkKey_timeEditTemp_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       checkKey_timeEditTemp_L0+1, 1
;Menu.c,665 :: 		}
L_checkKey215:
;Menu.c,666 :: 		if (cPLUS == ON || cMINUS == ON) {
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey249
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey249
	GOTO       L_checkKey218
L__checkKey249:
;Menu.c,667 :: 		editValue = (editValue & 0xFFE3) | (timeEditTemp & 0x001C);
	MOVLW      227
	ANDWF      _editValue+0, 1
	MOVLW      255
	ANDWF      _editValue+1, 1
	MOVLW      28
	ANDWF      checkKey_timeEditTemp_L0+0, 0
	MOVWF      R0+0
	MOVF       checkKey_timeEditTemp_L0+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      _editValue+0, 1
	MOVF       R0+1, 0
	IORWF      _editValue+1, 1
;Menu.c,668 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,669 :: 		}
L_checkKey218:
;Menu.c,670 :: 		break;
	GOTO       L_checkKey200
;Menu.c,671 :: 		case OnOFFTimeEditHour:
L_checkKey219:
;Menu.c,672 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey220
;Menu.c,674 :: 		subMenu = OnOFFTimeEditMint;
	MOVLW      14
	MOVWF      _subMenu+0
;Menu.c,675 :: 		}
L_checkKey220:
;Menu.c,676 :: 		timeEditTemp = editValue & 0x03E0;
	MOVLW      224
	ANDWF      _editValue+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       _editValue+1, 0
	ANDLW      3
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,677 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey221
;Menu.c,679 :: 		timeEditTemp += 32;
	MOVLW      32
	ADDWF      checkKey_timeEditTemp_L0+0, 0
	MOVWF      R1+0
	MOVF       checkKey_timeEditTemp_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       R1+1, 0
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,680 :: 		if (timeEditTemp > 736)
	MOVF       R1+1, 0
	SUBLW      2
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey303
	MOVF       R1+0, 0
	SUBLW      224
L__checkKey303:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey222
;Menu.c,682 :: 		timeEditTemp = 0;
	CLRF       checkKey_timeEditTemp_L0+0
	CLRF       checkKey_timeEditTemp_L0+1
;Menu.c,683 :: 		}
L_checkKey222:
;Menu.c,684 :: 		}
L_checkKey221:
;Menu.c,685 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey223
;Menu.c,687 :: 		if(timeEditTemp == 0)
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey304
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+0, 0
L__checkKey304:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey224
;Menu.c,689 :: 		timeEditTemp = 736;
	MOVLW      224
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVLW      2
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,690 :: 		}
	GOTO       L_checkKey225
L_checkKey224:
;Menu.c,693 :: 		timeEditTemp -= 32;
	MOVLW      32
	SUBWF      checkKey_timeEditTemp_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       checkKey_timeEditTemp_L0+1, 1
;Menu.c,694 :: 		}
L_checkKey225:
;Menu.c,696 :: 		}
L_checkKey223:
;Menu.c,697 :: 		if (cPLUS == ON || cMINUS == ON) {
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey248
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey248
	GOTO       L_checkKey228
L__checkKey248:
;Menu.c,698 :: 		editValue = (editValue & 0xFC1F) | timeEditTemp;
	MOVLW      31
	ANDWF      _editValue+0, 1
	MOVLW      252
	ANDWF      _editValue+1, 1
	MOVF       checkKey_timeEditTemp_L0+0, 0
	IORWF      _editValue+0, 1
	MOVF       checkKey_timeEditTemp_L0+1, 0
	IORWF      _editValue+1, 1
;Menu.c,699 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,700 :: 		}
L_checkKey228:
;Menu.c,702 :: 		break;
	GOTO       L_checkKey200
;Menu.c,703 :: 		case OnOFFTimeEditMint:
L_checkKey229:
;Menu.c,704 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey230
;Menu.c,706 :: 		subMenu = OnOFFTimeEditEnable;
	CLRF       _subMenu+0
;Menu.c,707 :: 		}
L_checkKey230:
;Menu.c,708 :: 		timeEditTemp = editValue & 0xFC00;
	MOVLW      0
	ANDWF      _editValue+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       _editValue+1, 0
	ANDLW      252
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,709 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey231
;Menu.c,711 :: 		timeEditTemp += 1024;
	MOVLW      0
	ADDWF      checkKey_timeEditTemp_L0+0, 0
	MOVWF      R1+0
	MOVF       checkKey_timeEditTemp_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      4
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       R1+1, 0
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,712 :: 		if (timeEditTemp > 60416)
	MOVF       R1+1, 0
	SUBLW      236
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey305
	MOVF       R1+0, 0
	SUBLW      0
L__checkKey305:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey232
;Menu.c,714 :: 		timeEditTemp = 0;
	CLRF       checkKey_timeEditTemp_L0+0
	CLRF       checkKey_timeEditTemp_L0+1
;Menu.c,715 :: 		}
L_checkKey232:
;Menu.c,716 :: 		}
L_checkKey231:
;Menu.c,717 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey233
;Menu.c,719 :: 		if(timeEditTemp == 0)
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey306
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+0, 0
L__checkKey306:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey234
;Menu.c,721 :: 		timeEditTemp = 60416;
	MOVLW      0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVLW      236
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,722 :: 		}
	GOTO       L_checkKey235
L_checkKey234:
;Menu.c,725 :: 		timeEditTemp -= 1024;
	MOVLW      0
	SUBWF      checkKey_timeEditTemp_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       checkKey_timeEditTemp_L0+1, 1
	MOVLW      4
	SUBWF      checkKey_timeEditTemp_L0+1, 1
;Menu.c,726 :: 		}
L_checkKey235:
;Menu.c,728 :: 		}
L_checkKey233:
;Menu.c,729 :: 		if (cPLUS == ON || cMINUS == ON) {
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey247
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey247
	GOTO       L_checkKey238
L__checkKey247:
;Menu.c,730 :: 		editValue = (editValue & 0x03FF) | timeEditTemp;
	MOVLW      255
	ANDWF      _editValue+0, 1
	MOVLW      3
	ANDWF      _editValue+1, 1
	MOVF       checkKey_timeEditTemp_L0+0, 0
	IORWF      _editValue+0, 1
	MOVF       checkKey_timeEditTemp_L0+1, 0
	IORWF      _editValue+1, 1
;Menu.c,731 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,732 :: 		}
L_checkKey238:
;Menu.c,734 :: 		break;
	GOTO       L_checkKey200
;Menu.c,735 :: 		}
L_checkKey199:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey201
	MOVF       _subMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey207
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey212
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey219
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey229
L_checkKey200:
;Menu.c,736 :: 		}
L_checkKey198:
;Menu.c,740 :: 		}
	GOTO       L_checkKey239
L_checkKey196:
;Menu.c,743 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,744 :: 		}
L_checkKey239:
;Menu.c,746 :: 		break;
	GOTO       L_checkKey47
;Menu.c,747 :: 		}
L_checkKey46:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey48
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey49
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey87
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey111
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey139
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey167
	GOTO       L_checkKey195
L_checkKey47:
;Menu.c,748 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey240
;Menu.c,749 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,750 :: 		}
L_checkKey240:
;Menu.c,751 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey246
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey246
	GOTO       L_checkKey243
L__checkKey246:
;Menu.c,753 :: 		isEdited = 1;
	BSF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,754 :: 		}
L_checkKey243:
;Menu.c,756 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey244:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey244
	DECFSZ     R12+0, 1
	GOTO       L_checkKey244
	DECFSZ     R11+0, 1
	GOTO       L_checkKey244
	NOP
;Menu.c,757 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,758 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey307
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey307:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey245
;Menu.c,759 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,760 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,761 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,762 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,763 :: 		}
L_checkKey245:
;Menu.c,766 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey36
;Menu.c,767 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,769 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
