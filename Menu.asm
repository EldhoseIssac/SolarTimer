
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

;Menu.c,89 :: 		void menuPortPinInt(){
;Menu.c,92 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,93 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,94 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,95 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,96 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;Menu.c,99 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_saveValue:

;Menu.c,105 :: 		void saveValue(){
;Menu.c,106 :: 		if (!isEdited){
	BTFSC      _isEdited+0, BitPos(_isEdited+0)
	GOTO       L_saveValue3
;Menu.c,107 :: 		return;
	GOTO       L_end_saveValue
;Menu.c,108 :: 		}
L_saveValue3:
;Menu.c,109 :: 		isEdited = 0;
	BCF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,110 :: 		switch(crntMenu){
	GOTO       L_saveValue4
;Menu.c,111 :: 		case None:
L_saveValue6:
;Menu.c,112 :: 		break;
	GOTO       L_saveValue5
;Menu.c,113 :: 		case Date:
L_saveValue7:
;Menu.c,114 :: 		switch(subMenu){
	GOTO       L_saveValue8
;Menu.c,115 :: 		case DateDay:
L_saveValue10:
;Menu.c,116 :: 		write_ds1307(0x04,editValue);
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,117 :: 		break;
	GOTO       L_saveValue9
;Menu.c,118 :: 		case DateMonth:
L_saveValue11:
;Menu.c,119 :: 		write_ds1307(0x05,editValue);
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,120 :: 		break;
	GOTO       L_saveValue9
;Menu.c,121 :: 		case DateYear:
L_saveValue12:
;Menu.c,122 :: 		write_ds1307(0x06,editValue);
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,123 :: 		break;
	GOTO       L_saveValue9
;Menu.c,124 :: 		case DateWeekDay:
L_saveValue13:
;Menu.c,125 :: 		write_ds1307(0x03,editValue);
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,126 :: 		break;
	GOTO       L_saveValue9
;Menu.c,127 :: 		}
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
;Menu.c,128 :: 		break;
	GOTO       L_saveValue5
;Menu.c,129 :: 		case Time:
L_saveValue14:
;Menu.c,130 :: 		switch(subMenu){
	GOTO       L_saveValue15
;Menu.c,131 :: 		case TimeHour:
L_saveValue17:
;Menu.c,132 :: 		write_ds1307(0x02,editValue);
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,133 :: 		break;
	GOTO       L_saveValue16
;Menu.c,134 :: 		case TimeMinute:
L_saveValue18:
;Menu.c,135 :: 		write_ds1307(0x01,editValue);
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,136 :: 		break;
	GOTO       L_saveValue16
;Menu.c,137 :: 		}
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
;Menu.c,138 :: 		break;
	GOTO       L_saveValue5
;Menu.c,139 :: 		case Voltage:
L_saveValue19:
;Menu.c,140 :: 		switch(submenu){
	GOTO       L_saveValue20
;Menu.c,141 :: 		case VoltageLow:
L_saveValue22:
;Menu.c,142 :: 		ee_write(EEPADDR_VoltageLow,editValue);
	MOVLW      4
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,143 :: 		break;
	GOTO       L_saveValue21
;Menu.c,144 :: 		case VoltageHigh:
L_saveValue23:
;Menu.c,145 :: 		ee_write(EEPADDR_VoltageHigh,editValue);
	MOVLW      2
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,146 :: 		break;
	GOTO       L_saveValue21
;Menu.c,147 :: 		}
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
;Menu.c,148 :: 		break;
	GOTO       L_saveValue5
;Menu.c,149 :: 		case Current:
L_saveValue24:
;Menu.c,150 :: 		switch(submenu){
	GOTO       L_saveValue25
;Menu.c,151 :: 		case CurrentHeigh:
L_saveValue27:
;Menu.c,152 :: 		ee_write(EEPADDR_CurrentHeigh,editValue);
	MOVLW      6
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,153 :: 		break;
	GOTO       L_saveValue26
;Menu.c,154 :: 		case CurrentLow:
L_saveValue28:
;Menu.c,155 :: 		ee_write(EEPADDR_CurrentLow,editValue);
	MOVLW      8
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,156 :: 		break;
	GOTO       L_saveValue26
;Menu.c,157 :: 		}
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
;Menu.c,158 :: 		break;
	GOTO       L_saveValue5
;Menu.c,159 :: 		case LDRVal:
L_saveValue29:
;Menu.c,160 :: 		switch(submenu){
	GOTO       L_saveValue30
;Menu.c,161 :: 		case LDRValLow:
L_saveValue32:
;Menu.c,162 :: 		ee_write(EEPADDR_LDRvalLow,editValue);
	MOVLW      12
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,163 :: 		break;
	GOTO       L_saveValue31
;Menu.c,164 :: 		case LDRValHeigh:
L_saveValue33:
;Menu.c,165 :: 		ee_write(EEPADDR_LDRvalHeigh,editValue);
	MOVLW      10
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,166 :: 		break;
	GOTO       L_saveValue31
;Menu.c,167 :: 		}
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
;Menu.c,168 :: 		break;
	GOTO       L_saveValue5
;Menu.c,169 :: 		default:
L_saveValue34:
;Menu.c,170 :: 		if(crntMenu<(OnOFFTime+8))
	MOVLW      14
	SUBWF      _crntMenu+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_saveValue35
;Menu.c,172 :: 		ee_write(timeEEAddr,editValue);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,173 :: 		}
L_saveValue35:
;Menu.c,174 :: 		break;
	GOTO       L_saveValue5
;Menu.c,176 :: 		}
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
;Menu.c,177 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_checkKey:

;Menu.c,196 :: 		void checkKey(){
;Menu.c,198 :: 		unsigned int timeEditTemp = 0;
	CLRF       checkKey_timeEditTemp_L0+0
	CLRF       checkKey_timeEditTemp_L0+1
;Menu.c,199 :: 		timeEEAddr = EEPADDR_OnOFFTimeEdit1-2;
	MOVLW      14
	MOVWF      _timeEEAddr+0
;Menu.c,200 :: 		do{
L_checkKey36:
;Menu.c,201 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey267
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey268
L__checkKey267:
	BSF        _cashedPortD+0, 7
L__checkKey268:
;Menu.c,202 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey269
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey270
L__checkKey269:
	BSF        _cashedPortD+0, 6
L__checkKey270:
;Menu.c,203 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey271
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey272
L__checkKey271:
	BSF        _cashedPortD+0, 5
L__checkKey272:
;Menu.c,204 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey273
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey274
L__checkKey273:
	BSF        _cashedPortD+0, 4
L__checkKey274:
;Menu.c,208 :: 		if(cashedPortD < 0xF0)
	MOVLW      240
	SUBWF      _cashedPortD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey39
;Menu.c,212 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,213 :: 		delay_ms(100);
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
;Menu.c,214 :: 		}
L_checkKey39:
;Menu.c,215 :: 		if(cMENU == ON){
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey41
;Menu.c,216 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,217 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey42
;Menu.c,218 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,219 :: 		}else{
	GOTO       L_checkKey43
L_checkKey42:
;Menu.c,220 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,221 :: 		}
L_checkKey43:
;Menu.c,222 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,223 :: 		if(crntMenu>(OnOFFTime+8))
	MOVF       _crntMenu+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey44
;Menu.c,225 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,226 :: 		}
L_checkKey44:
;Menu.c,227 :: 		}
L_checkKey41:
;Menu.c,228 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey45
;Menu.c,230 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,231 :: 		}
L_checkKey45:
;Menu.c,232 :: 		switch(crntMenu)
	GOTO       L_checkKey46
;Menu.c,234 :: 		case None:
L_checkKey48:
;Menu.c,235 :: 		break;
	GOTO       L_checkKey47
;Menu.c,236 :: 		case Date:
L_checkKey49:
;Menu.c,237 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey50
;Menu.c,239 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,240 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,241 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,242 :: 		}
	GOTO       L_checkKey51
L_checkKey50:
;Menu.c,245 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey52
;Menu.c,247 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,248 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
;Menu.c,249 :: 		}
L_checkKey52:
;Menu.c,250 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey54
;Menu.c,252 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,253 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
;Menu.c,254 :: 		}
L_checkKey54:
;Menu.c,255 :: 		switch(subMenu)
	GOTO       L_checkKey56
;Menu.c,258 :: 		case DateDay:
L_checkKey58:
;Menu.c,259 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey59
;Menu.c,261 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,262 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,263 :: 		}
L_checkKey59:
;Menu.c,264 :: 		if(cPLUS == ON){
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey60
;Menu.c,265 :: 		if(editValue>0x31)  editValue = 1;
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
;Menu.c,266 :: 		}
L_checkKey60:
;Menu.c,267 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey62
;Menu.c,269 :: 		if(editValue == 0) editValue = 0x31;
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
;Menu.c,270 :: 		}
L_checkKey62:
;Menu.c,271 :: 		break;
	GOTO       L_checkKey57
;Menu.c,272 :: 		case DateMonth:
L_checkKey64:
;Menu.c,273 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey65
;Menu.c,275 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,276 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,277 :: 		}
L_checkKey65:
;Menu.c,278 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey66
;Menu.c,280 :: 		if(editValue>0x12)  editValue = 1;
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
;Menu.c,281 :: 		}
L_checkKey66:
;Menu.c,282 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey68
;Menu.c,284 :: 		if(editValue == 0) editValue = 0x01;
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
;Menu.c,285 :: 		}
L_checkKey68:
;Menu.c,287 :: 		break;
	GOTO       L_checkKey57
;Menu.c,288 :: 		case DateYear:
L_checkKey70:
;Menu.c,289 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey71
;Menu.c,291 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,292 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,293 :: 		}
L_checkKey71:
;Menu.c,294 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey72
;Menu.c,296 :: 		if(editValue>0x99)  editValue = 1;
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
;Menu.c,297 :: 		}
L_checkKey72:
;Menu.c,298 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey74
;Menu.c,300 :: 		if(editValue == 0) editValue = 0x99;
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
;Menu.c,301 :: 		}
L_checkKey74:
;Menu.c,303 :: 		break;
	GOTO       L_checkKey57
;Menu.c,304 :: 		case DateWeekDay:
L_checkKey76:
;Menu.c,305 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey77
;Menu.c,307 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,308 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,309 :: 		}
L_checkKey77:
;Menu.c,310 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey78
;Menu.c,312 :: 		if(editValue>0x07)  editValue = 1;
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
;Menu.c,313 :: 		}
L_checkKey78:
;Menu.c,314 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey80
;Menu.c,316 :: 		if(editValue == 0) editValue = 0x07;
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
;Menu.c,317 :: 		}
L_checkKey80:
;Menu.c,318 :: 		break;
	GOTO       L_checkKey57
;Menu.c,320 :: 		}
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
;Menu.c,321 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey262
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey262
	GOTO       L_checkKey84
L__checkKey262:
;Menu.c,323 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey85
;Menu.c,325 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,326 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,327 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,328 :: 		}
	GOTO       L_checkKey86
L_checkKey85:
;Menu.c,331 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,332 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,333 :: 		}
L_checkKey86:
;Menu.c,334 :: 		}
L_checkKey84:
;Menu.c,336 :: 		}
L_checkKey51:
;Menu.c,337 :: 		break;
	GOTO       L_checkKey47
;Menu.c,338 :: 		case Time:
L_checkKey87:
;Menu.c,339 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey88
;Menu.c,341 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,342 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,343 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,344 :: 		}
	GOTO       L_checkKey89
L_checkKey88:
;Menu.c,347 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey90
;Menu.c,349 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,350 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
;Menu.c,351 :: 		}
L_checkKey90:
;Menu.c,352 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey92
;Menu.c,354 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,355 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
;Menu.c,356 :: 		}
L_checkKey92:
;Menu.c,357 :: 		switch(subMenu)
	GOTO       L_checkKey94
;Menu.c,359 :: 		case TimeHour:
L_checkKey96:
;Menu.c,360 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey97
;Menu.c,362 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,363 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,364 :: 		}
L_checkKey97:
;Menu.c,365 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey98
;Menu.c,367 :: 		if(editValue>0x23)  editValue = 0;
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
;Menu.c,368 :: 		}
L_checkKey98:
;Menu.c,369 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey100
;Menu.c,371 :: 		if(editValue > 0x23) editValue = 0x23;
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
;Menu.c,372 :: 		}
L_checkKey100:
;Menu.c,373 :: 		break;
	GOTO       L_checkKey95
;Menu.c,374 :: 		case TimeMinute:
L_checkKey102:
;Menu.c,375 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey103
;Menu.c,377 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,378 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,379 :: 		}
L_checkKey103:
;Menu.c,380 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey104
;Menu.c,382 :: 		if(editValue>0x59)  editValue = 0;
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
;Menu.c,383 :: 		}
L_checkKey104:
;Menu.c,384 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey106
;Menu.c,386 :: 		if(editValue > 0x59) editValue = 0x59;
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
;Menu.c,387 :: 		}
L_checkKey106:
;Menu.c,388 :: 		break;
	GOTO       L_checkKey95
;Menu.c,389 :: 		}
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
;Menu.c,390 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey261
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey261
	GOTO       L_checkKey110
L__checkKey261:
;Menu.c,392 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,393 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,394 :: 		}
L_checkKey110:
;Menu.c,395 :: 		}
L_checkKey89:
;Menu.c,396 :: 		break;
	GOTO       L_checkKey47
;Menu.c,397 :: 		case   Voltage:
L_checkKey111:
;Menu.c,398 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey112
;Menu.c,400 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,401 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,402 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,403 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,404 :: 		}
	GOTO       L_checkKey113
L_checkKey112:
;Menu.c,407 :: 		switch(subMenu)
	GOTO       L_checkKey114
;Menu.c,409 :: 		case VoltageEnable:
L_checkKey116:
;Menu.c,410 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey117
;Menu.c,412 :: 		subMenu = VoltageHigh;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,413 :: 		}
L_checkKey117:
;Menu.c,414 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey260
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey260
	GOTO       L_checkKey120
L__checkKey260:
;Menu.c,416 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,417 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,418 :: 		}
L_checkKey120:
;Menu.c,419 :: 		break;
	GOTO       L_checkKey115
;Menu.c,420 :: 		case VoltageHigh:
L_checkKey121:
;Menu.c,421 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey122
;Menu.c,423 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,424 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,425 :: 		}
L_checkKey122:
;Menu.c,426 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey123
;Menu.c,428 :: 		editValue += 2;
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
;Menu.c,429 :: 		if (editValue > 441)   editValue = 81;
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
;Menu.c,431 :: 		}
L_checkKey123:
;Menu.c,432 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey125
;Menu.c,434 :: 		editValue -= 2;
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
;Menu.c,435 :: 		if (editValue < 81) editValue = 441;
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
;Menu.c,436 :: 		}
L_checkKey125:
;Menu.c,437 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey259
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey259
	GOTO       L_checkKey129
L__checkKey259:
;Menu.c,439 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,440 :: 		}
L_checkKey129:
;Menu.c,441 :: 		break;
	GOTO       L_checkKey115
;Menu.c,442 :: 		case VoltageLow:
L_checkKey130:
;Menu.c,443 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey131
;Menu.c,445 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,446 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,447 :: 		}
L_checkKey131:
;Menu.c,448 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey132
;Menu.c,450 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,451 :: 		if (editValue > 220)   editValue = 80;
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
;Menu.c,453 :: 		}
L_checkKey132:
;Menu.c,454 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey134
;Menu.c,456 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,457 :: 		if (editValue < 80) editValue = 220;
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
;Menu.c,458 :: 		}
L_checkKey134:
;Menu.c,459 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey258
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey258
	GOTO       L_checkKey138
L__checkKey258:
;Menu.c,461 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
;Menu.c,462 :: 		}
L_checkKey138:
;Menu.c,463 :: 		break;
	GOTO       L_checkKey115
;Menu.c,465 :: 		}
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
;Menu.c,466 :: 		}
L_checkKey113:
;Menu.c,467 :: 		break;
	GOTO       L_checkKey47
;Menu.c,468 :: 		case Current:
L_checkKey139:
;Menu.c,469 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey140
;Menu.c,471 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,472 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,473 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,474 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,475 :: 		}
	GOTO       L_checkKey141
L_checkKey140:
;Menu.c,478 :: 		switch(subMenu)
	GOTO       L_checkKey142
;Menu.c,480 :: 		case CurrentEnable:
L_checkKey144:
;Menu.c,481 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey145
;Menu.c,483 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,484 :: 		}
L_checkKey145:
;Menu.c,485 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey257
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey257
	GOTO       L_checkKey148
L__checkKey257:
;Menu.c,487 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,488 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,490 :: 		}
L_checkKey148:
;Menu.c,491 :: 		break;
	GOTO       L_checkKey143
;Menu.c,492 :: 		case CurrentHeigh:
L_checkKey149:
;Menu.c,493 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey150
;Menu.c,495 :: 		subMenu = CurrentLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,496 :: 		editValue =  ee_read(EEPADDR_CurrentLow);
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,497 :: 		}
L_checkKey150:
;Menu.c,498 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey151
;Menu.c,500 :: 		editValue += 2;
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
;Menu.c,501 :: 		if (editValue > 201)   editValue = 11;
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
;Menu.c,503 :: 		}
L_checkKey151:
;Menu.c,504 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey153
;Menu.c,506 :: 		editValue -= 2;
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
;Menu.c,507 :: 		if (editValue < 11) editValue = 201;
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
;Menu.c,508 :: 		}
L_checkKey153:
;Menu.c,509 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey256
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey256
	GOTO       L_checkKey157
L__checkKey256:
;Menu.c,511 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,512 :: 		}
L_checkKey157:
;Menu.c,513 :: 		break;
	GOTO       L_checkKey143
;Menu.c,514 :: 		case CurrentLow:
L_checkKey158:
;Menu.c,515 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey159
;Menu.c,517 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,518 :: 		editValue =  ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,519 :: 		}
L_checkKey159:
;Menu.c,520 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey160
;Menu.c,522 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,523 :: 		if (editValue > 220)   editValue = 80;
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
;Menu.c,525 :: 		}
L_checkKey160:
;Menu.c,526 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey162
;Menu.c,528 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,529 :: 		if (editValue < 80) editValue = 220;
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
;Menu.c,530 :: 		}
L_checkKey162:
;Menu.c,531 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey255
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey255
	GOTO       L_checkKey166
L__checkKey255:
;Menu.c,533 :: 		loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
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
;Menu.c,534 :: 		}
L_checkKey166:
;Menu.c,535 :: 		break;
	GOTO       L_checkKey143
;Menu.c,537 :: 		}
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
;Menu.c,538 :: 		}
L_checkKey141:
;Menu.c,539 :: 		break;
	GOTO       L_checkKey47
;Menu.c,540 :: 		case LDRVal:
L_checkKey167:
;Menu.c,541 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey168
;Menu.c,543 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,544 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,545 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,546 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,547 :: 		}
	GOTO       L_checkKey169
L_checkKey168:
;Menu.c,550 :: 		switch(subMenu)
	GOTO       L_checkKey170
;Menu.c,552 :: 		case LDRValEnable:
L_checkKey172:
;Menu.c,553 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey173
;Menu.c,555 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,556 :: 		}
L_checkKey173:
;Menu.c,557 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey254
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey254
	GOTO       L_checkKey176
L__checkKey254:
;Menu.c,559 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,560 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,561 :: 		}
L_checkKey176:
;Menu.c,562 :: 		break;
	GOTO       L_checkKey171
;Menu.c,563 :: 		case LDRValHeigh:
L_checkKey177:
;Menu.c,564 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey178
;Menu.c,566 :: 		subMenu = LDRValLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,567 :: 		editValue =  ee_read(EEPADDR_LDRValLow);
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,568 :: 		}
L_checkKey178:
;Menu.c,569 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey179
;Menu.c,571 :: 		editValue += 2;
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
;Menu.c,572 :: 		if (editValue > 441)   editValue = 81;
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
;Menu.c,574 :: 		}
L_checkKey179:
;Menu.c,575 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey181
;Menu.c,577 :: 		editValue -= 2;
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
;Menu.c,578 :: 		if (editValue < 81) editValue = 441;
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
;Menu.c,579 :: 		}
L_checkKey181:
;Menu.c,580 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey253
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey253
	GOTO       L_checkKey185
L__checkKey253:
;Menu.c,582 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,583 :: 		}
L_checkKey185:
;Menu.c,584 :: 		break;
	GOTO       L_checkKey171
;Menu.c,585 :: 		case LDRValLow:
L_checkKey186:
;Menu.c,586 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey187
;Menu.c,588 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,589 :: 		editValue =  ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,590 :: 		}
L_checkKey187:
;Menu.c,591 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey188
;Menu.c,593 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,594 :: 		if (editValue > 220)   editValue = 80;
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
;Menu.c,596 :: 		}
L_checkKey188:
;Menu.c,597 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey190
;Menu.c,599 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,600 :: 		if (editValue < 80) editValue = 220;
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
;Menu.c,601 :: 		}
L_checkKey190:
;Menu.c,602 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey252
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey252
	GOTO       L_checkKey194
L__checkKey252:
;Menu.c,604 :: 		loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
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
;Menu.c,605 :: 		}
L_checkKey194:
;Menu.c,606 :: 		break;
	GOTO       L_checkKey171
;Menu.c,608 :: 		}
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
;Menu.c,609 :: 		}
L_checkKey169:
;Menu.c,610 :: 		break;
	GOTO       L_checkKey47
;Menu.c,611 :: 		default:
L_checkKey195:
;Menu.c,612 :: 		if(crntMenu<(OnOFFTime+7))
	MOVLW      13
	SUBWF      _crntMenu+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey196
;Menu.c,614 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey197
;Menu.c,616 :: 		subMenu = OnOFFTimeEditEnable;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,617 :: 		timeEEAddr += 2;
	MOVLW      2
	ADDWF      _timeEEAddr+0, 1
;Menu.c,618 :: 		strcpy(lcdrow1,codetxt_to_ramtxt("SuMoTuWeThFrSa"));
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
;Menu.c,620 :: 		Lcd_Out(1,1,lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,621 :: 		editValue = ee_read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,622 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,623 :: 		}
	GOTO       L_checkKey198
L_checkKey197:
;Menu.c,626 :: 		switch (subMenu) {
	GOTO       L_checkKey199
;Menu.c,627 :: 		case OnOFFTimeEditEnable:
L_checkKey201:
;Menu.c,628 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey202
;Menu.c,630 :: 		if (isEnabled)
	BTFSS      _isEnabled+0, BitPos(_isEnabled+0)
	GOTO       L_checkKey203
;Menu.c,632 :: 		subMenu = OnOFFTimeEditHour;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,633 :: 		}
L_checkKey203:
;Menu.c,635 :: 		}
L_checkKey202:
;Menu.c,636 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey251
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey251
	GOTO       L_checkKey206
L__checkKey251:
;Menu.c,638 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,639 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,640 :: 		}
L_checkKey206:
;Menu.c,641 :: 		break;
	GOTO       L_checkKey200
;Menu.c,642 :: 		case OnOFFTimeEditOnOff:
L_checkKey207:
;Menu.c,643 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey208
;Menu.c,645 :: 		subMenu = OnOFFTimeEditWeekDay;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,646 :: 		}
L_checkKey208:
;Menu.c,647 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey250
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey250
	GOTO       L_checkKey211
L__checkKey250:
;Menu.c,649 :: 		shouldON = !shouldON;
	MOVLW
	XORWF      _shouldON+0, 1
;Menu.c,650 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,651 :: 		}
L_checkKey211:
;Menu.c,652 :: 		break;
	GOTO       L_checkKey200
;Menu.c,653 :: 		case OnOFFTimeEditWeekDay:
L_checkKey212:
;Menu.c,654 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey213
;Menu.c,656 :: 		subMenu = OnOFFTimeEditHour;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,657 :: 		}
L_checkKey213:
;Menu.c,659 :: 		timeEditTemp = editValue;
	MOVF       _editValue+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       _editValue+1, 0
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,660 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey214
;Menu.c,662 :: 		timeEditTemp += 4;
	MOVLW      4
	ADDWF      checkKey_timeEditTemp_L0+0, 1
	BTFSC      STATUS+0, 0
	INCF       checkKey_timeEditTemp_L0+1, 1
;Menu.c,663 :: 		}
L_checkKey214:
;Menu.c,664 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey215
;Menu.c,666 :: 		timeEditTemp -= 4;
	MOVLW      4
	SUBWF      checkKey_timeEditTemp_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       checkKey_timeEditTemp_L0+1, 1
;Menu.c,667 :: 		}
L_checkKey215:
;Menu.c,668 :: 		if (cPLUS == ON || cMINUS == ON) {
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey249
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey249
	GOTO       L_checkKey218
L__checkKey249:
;Menu.c,669 :: 		editValue = (editValue & 0xFFE3) | (timeEditTemp & 0x001C);
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
;Menu.c,670 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,671 :: 		}
L_checkKey218:
;Menu.c,672 :: 		break;
	GOTO       L_checkKey200
;Menu.c,673 :: 		case OnOFFTimeEditHour:
L_checkKey219:
;Menu.c,674 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey220
;Menu.c,676 :: 		subMenu = OnOFFTimeEditMint;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,677 :: 		}
L_checkKey220:
;Menu.c,678 :: 		timeEditTemp = editValue & 0x03E0;
	MOVLW      224
	ANDWF      _editValue+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       _editValue+1, 0
	ANDLW      3
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,679 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey221
;Menu.c,681 :: 		timeEditTemp += 32;
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
;Menu.c,682 :: 		if (timeEditTemp > 736)
	MOVF       R1+1, 0
	SUBLW      2
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey303
	MOVF       R1+0, 0
	SUBLW      224
L__checkKey303:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey222
;Menu.c,684 :: 		timeEditTemp = 0;
	CLRF       checkKey_timeEditTemp_L0+0
	CLRF       checkKey_timeEditTemp_L0+1
;Menu.c,685 :: 		}
L_checkKey222:
;Menu.c,686 :: 		}
L_checkKey221:
;Menu.c,687 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey223
;Menu.c,689 :: 		if(timeEditTemp == 0)
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey304
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+0, 0
L__checkKey304:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey224
;Menu.c,691 :: 		timeEditTemp = 736;
	MOVLW      224
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVLW      2
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,692 :: 		}
	GOTO       L_checkKey225
L_checkKey224:
;Menu.c,695 :: 		timeEditTemp -= 32;
	MOVLW      32
	SUBWF      checkKey_timeEditTemp_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       checkKey_timeEditTemp_L0+1, 1
;Menu.c,696 :: 		}
L_checkKey225:
;Menu.c,698 :: 		}
L_checkKey223:
;Menu.c,699 :: 		if (cPLUS == ON || cMINUS == ON) {
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey248
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey248
	GOTO       L_checkKey228
L__checkKey248:
;Menu.c,700 :: 		editValue = (editValue & 0xFC1F) | timeEditTemp;
	MOVLW      31
	ANDWF      _editValue+0, 1
	MOVLW      252
	ANDWF      _editValue+1, 1
	MOVF       checkKey_timeEditTemp_L0+0, 0
	IORWF      _editValue+0, 1
	MOVF       checkKey_timeEditTemp_L0+1, 0
	IORWF      _editValue+1, 1
;Menu.c,701 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,702 :: 		}
L_checkKey228:
;Menu.c,704 :: 		break;
	GOTO       L_checkKey200
;Menu.c,705 :: 		case OnOFFTimeEditMint:
L_checkKey229:
;Menu.c,706 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey230
;Menu.c,708 :: 		subMenu = OnOFFTimeEditEnable;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,709 :: 		}
L_checkKey230:
;Menu.c,710 :: 		timeEditTemp = editValue & 0xFC00;
	MOVLW      0
	ANDWF      _editValue+0, 0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVF       _editValue+1, 0
	ANDLW      252
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,711 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey231
;Menu.c,713 :: 		timeEditTemp += 1024;
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
;Menu.c,714 :: 		if (timeEditTemp > 60416)
	MOVF       R1+1, 0
	SUBLW      236
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey305
	MOVF       R1+0, 0
	SUBLW      0
L__checkKey305:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey232
;Menu.c,716 :: 		timeEditTemp = 0;
	CLRF       checkKey_timeEditTemp_L0+0
	CLRF       checkKey_timeEditTemp_L0+1
;Menu.c,717 :: 		}
L_checkKey232:
;Menu.c,718 :: 		}
L_checkKey231:
;Menu.c,719 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey233
;Menu.c,721 :: 		if(timeEditTemp == 0)
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey306
	MOVLW      0
	XORWF      checkKey_timeEditTemp_L0+0, 0
L__checkKey306:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey234
;Menu.c,723 :: 		timeEditTemp = 60416;
	MOVLW      0
	MOVWF      checkKey_timeEditTemp_L0+0
	MOVLW      236
	MOVWF      checkKey_timeEditTemp_L0+1
;Menu.c,724 :: 		}
	GOTO       L_checkKey235
L_checkKey234:
;Menu.c,727 :: 		timeEditTemp -= 1024;
	MOVLW      0
	SUBWF      checkKey_timeEditTemp_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       checkKey_timeEditTemp_L0+1, 1
	MOVLW      4
	SUBWF      checkKey_timeEditTemp_L0+1, 1
;Menu.c,728 :: 		}
L_checkKey235:
;Menu.c,730 :: 		}
L_checkKey233:
;Menu.c,731 :: 		if (cPLUS == ON || cMINUS == ON) {
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey247
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey247
	GOTO       L_checkKey238
L__checkKey247:
;Menu.c,732 :: 		editValue = (editValue & 0x03FF) | timeEditTemp;
	MOVLW      255
	ANDWF      _editValue+0, 1
	MOVLW      3
	ANDWF      _editValue+1, 1
	MOVF       checkKey_timeEditTemp_L0+0, 0
	IORWF      _editValue+0, 1
	MOVF       checkKey_timeEditTemp_L0+1, 0
	IORWF      _editValue+1, 1
;Menu.c,733 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,734 :: 		}
L_checkKey238:
;Menu.c,736 :: 		break;
	GOTO       L_checkKey200
;Menu.c,737 :: 		}
L_checkKey199:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey201
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey207
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey212
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey219
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey229
L_checkKey200:
;Menu.c,738 :: 		}
L_checkKey198:
;Menu.c,742 :: 		}
	GOTO       L_checkKey239
L_checkKey196:
;Menu.c,745 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,746 :: 		}
L_checkKey239:
;Menu.c,748 :: 		break;
	GOTO       L_checkKey47
;Menu.c,749 :: 		}
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
;Menu.c,750 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey240
;Menu.c,751 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,752 :: 		}
L_checkKey240:
;Menu.c,753 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey246
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey246
	GOTO       L_checkKey243
L__checkKey246:
;Menu.c,755 :: 		isEdited = 1;
	BSF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,756 :: 		}
L_checkKey243:
;Menu.c,758 :: 		delay_ms(100);
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
;Menu.c,759 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,760 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey307
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey307:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey245
;Menu.c,761 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,762 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,763 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,764 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,765 :: 		}
L_checkKey245:
;Menu.c,768 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey36
;Menu.c,769 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,771 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
