
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
;Menu.c,170 :: 		if(crntMenu<OnOFFTimeDay9)
	MOVLW      22
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
;Menu.c,198 :: 		timeEEAddr = EEPADDR_OnOFFTimeDay1-5;
	MOVLW      15
	MOVWF      _timeEEAddr+0
;Menu.c,199 :: 		do{
L_checkKey36:
;Menu.c,200 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey222
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey223
L__checkKey222:
	BSF        _cashedPortD+0, 7
L__checkKey223:
;Menu.c,201 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey224
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey225
L__checkKey224:
	BSF        _cashedPortD+0, 6
L__checkKey225:
;Menu.c,202 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey226
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey227
L__checkKey226:
	BSF        _cashedPortD+0, 5
L__checkKey227:
;Menu.c,203 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey228
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey229
L__checkKey228:
	BSF        _cashedPortD+0, 4
L__checkKey229:
;Menu.c,205 :: 		if(cashedPortD > 0)
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey39
;Menu.c,211 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,212 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey40:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey40
	DECFSZ     R12+0, 1
	GOTO       L_checkKey40
	DECFSZ     R11+0, 1
	GOTO       L_checkKey40
	NOP
	NOP
;Menu.c,213 :: 		}
L_checkKey39:
;Menu.c,214 :: 		if(cMENU == ON){
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey41
;Menu.c,215 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,216 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey42
;Menu.c,217 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,218 :: 		}else{
	GOTO       L_checkKey43
L_checkKey42:
;Menu.c,219 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,220 :: 		}
L_checkKey43:
;Menu.c,221 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,222 :: 		if(crntMenu>OnOFFTime8)
	MOVF       _crntMenu+0, 0
	SUBLW      21
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey44
;Menu.c,224 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,225 :: 		}
L_checkKey44:
;Menu.c,226 :: 		}
L_checkKey41:
;Menu.c,227 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey45
;Menu.c,229 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,230 :: 		}
L_checkKey45:
;Menu.c,231 :: 		switch(crntMenu)
	GOTO       L_checkKey46
;Menu.c,233 :: 		case None:
L_checkKey48:
;Menu.c,234 :: 		break;
	GOTO       L_checkKey47
;Menu.c,235 :: 		case Date:
L_checkKey49:
;Menu.c,236 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey50
;Menu.c,238 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,239 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,240 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,241 :: 		}
	GOTO       L_checkKey51
L_checkKey50:
;Menu.c,244 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey52
;Menu.c,246 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,247 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey230
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey230:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey53
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey53:
;Menu.c,248 :: 		}
L_checkKey52:
;Menu.c,249 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey54
;Menu.c,251 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,252 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey231
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey231:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey55
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey55:
;Menu.c,253 :: 		}
L_checkKey54:
;Menu.c,254 :: 		switch(subMenu)
	GOTO       L_checkKey56
;Menu.c,257 :: 		case DateDay:
L_checkKey58:
;Menu.c,258 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey59
;Menu.c,260 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,261 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,262 :: 		}
L_checkKey59:
;Menu.c,263 :: 		if(cPLUS == ON){
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey60
;Menu.c,264 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey232
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey232:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey61
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey61:
;Menu.c,265 :: 		}
L_checkKey60:
;Menu.c,266 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey62
;Menu.c,268 :: 		if(editValue == 0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey233
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey233:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey63
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey63:
;Menu.c,269 :: 		}
L_checkKey62:
;Menu.c,270 :: 		break;
	GOTO       L_checkKey57
;Menu.c,271 :: 		case DateMonth:
L_checkKey64:
;Menu.c,272 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey65
;Menu.c,274 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,275 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,276 :: 		}
L_checkKey65:
;Menu.c,277 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey66
;Menu.c,279 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey234
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey234:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey67
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey67:
;Menu.c,280 :: 		}
L_checkKey66:
;Menu.c,281 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey68
;Menu.c,283 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey235
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey235:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey69
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey69:
;Menu.c,284 :: 		}
L_checkKey68:
;Menu.c,286 :: 		break;
	GOTO       L_checkKey57
;Menu.c,287 :: 		case DateYear:
L_checkKey70:
;Menu.c,288 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey71
;Menu.c,290 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,291 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,292 :: 		}
L_checkKey71:
;Menu.c,293 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey72
;Menu.c,295 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey236
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey236:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey73
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey73:
;Menu.c,296 :: 		}
L_checkKey72:
;Menu.c,297 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey74
;Menu.c,299 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey237
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey237:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey75
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey75:
;Menu.c,300 :: 		}
L_checkKey74:
;Menu.c,302 :: 		break;
	GOTO       L_checkKey57
;Menu.c,303 :: 		case DateWeekDay:
L_checkKey76:
;Menu.c,304 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey77
;Menu.c,306 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,307 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,308 :: 		}
L_checkKey77:
;Menu.c,309 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey78
;Menu.c,311 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey238
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey238:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey79
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey79:
;Menu.c,312 :: 		}
L_checkKey78:
;Menu.c,313 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey80
;Menu.c,315 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey239
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey239:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey81
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey81:
;Menu.c,316 :: 		}
L_checkKey80:
;Menu.c,317 :: 		break;
	GOTO       L_checkKey57
;Menu.c,319 :: 		}
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
;Menu.c,320 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey217
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey217
	GOTO       L_checkKey84
L__checkKey217:
;Menu.c,322 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey85
;Menu.c,324 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,325 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,326 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,327 :: 		}
	GOTO       L_checkKey86
L_checkKey85:
;Menu.c,330 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,331 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,332 :: 		}
L_checkKey86:
;Menu.c,333 :: 		}
L_checkKey84:
;Menu.c,335 :: 		}
L_checkKey51:
;Menu.c,336 :: 		break;
	GOTO       L_checkKey47
;Menu.c,337 :: 		case Time:
L_checkKey87:
;Menu.c,338 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey88
;Menu.c,340 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,341 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,342 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,343 :: 		}
	GOTO       L_checkKey89
L_checkKey88:
;Menu.c,346 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey90
;Menu.c,348 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,349 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey240
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey240:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey91
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey91:
;Menu.c,350 :: 		}
L_checkKey90:
;Menu.c,351 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey92
;Menu.c,353 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,354 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey241
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey241:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey93
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey93:
;Menu.c,355 :: 		}
L_checkKey92:
;Menu.c,356 :: 		switch(subMenu)
	GOTO       L_checkKey94
;Menu.c,358 :: 		case TimeHour:
L_checkKey96:
;Menu.c,359 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey97
;Menu.c,361 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,362 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,363 :: 		}
L_checkKey97:
;Menu.c,364 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey98
;Menu.c,366 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey242
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey242:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey99
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey99:
;Menu.c,367 :: 		}
L_checkKey98:
;Menu.c,368 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey100
;Menu.c,370 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey243
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey243:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey101
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey101:
;Menu.c,371 :: 		}
L_checkKey100:
;Menu.c,372 :: 		break;
	GOTO       L_checkKey95
;Menu.c,373 :: 		case TimeMinute:
L_checkKey102:
;Menu.c,374 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey103
;Menu.c,376 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,377 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,378 :: 		}
L_checkKey103:
;Menu.c,379 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey104
;Menu.c,381 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey244
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey244:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey105
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey105:
;Menu.c,382 :: 		}
L_checkKey104:
;Menu.c,383 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey106
;Menu.c,385 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey245
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey245:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey107
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey107:
;Menu.c,386 :: 		}
L_checkKey106:
;Menu.c,387 :: 		break;
	GOTO       L_checkKey95
;Menu.c,388 :: 		}
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
;Menu.c,389 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey216
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey216
	GOTO       L_checkKey110
L__checkKey216:
;Menu.c,391 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,392 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,393 :: 		}
L_checkKey110:
;Menu.c,394 :: 		}
L_checkKey89:
;Menu.c,395 :: 		break;
	GOTO       L_checkKey47
;Menu.c,396 :: 		case   Voltage:
L_checkKey111:
;Menu.c,397 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey112
;Menu.c,399 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,400 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,401 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,402 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,403 :: 		}
	GOTO       L_checkKey113
L_checkKey112:
;Menu.c,406 :: 		switch(subMenu)
	GOTO       L_checkKey114
;Menu.c,408 :: 		case VoltageEnable:
L_checkKey116:
;Menu.c,409 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey117
;Menu.c,411 :: 		subMenu = VoltageHigh;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,412 :: 		}
L_checkKey117:
;Menu.c,413 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey215
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey215
	GOTO       L_checkKey120
L__checkKey215:
;Menu.c,415 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,416 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,417 :: 		}
L_checkKey120:
;Menu.c,418 :: 		break;
	GOTO       L_checkKey115
;Menu.c,419 :: 		case VoltageHigh:
L_checkKey121:
;Menu.c,420 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey122
;Menu.c,422 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,423 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,424 :: 		}
L_checkKey122:
;Menu.c,425 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey123
;Menu.c,427 :: 		editValue += 2;
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
;Menu.c,428 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey246
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey246:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey124
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey124:
;Menu.c,430 :: 		}
L_checkKey123:
;Menu.c,431 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey125
;Menu.c,433 :: 		editValue -= 2;
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
;Menu.c,434 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey247
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey247:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey126
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey126:
;Menu.c,435 :: 		}
L_checkKey125:
;Menu.c,436 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey214
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey214
	GOTO       L_checkKey129
L__checkKey214:
;Menu.c,438 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,439 :: 		}
L_checkKey129:
;Menu.c,440 :: 		break;
	GOTO       L_checkKey115
;Menu.c,441 :: 		case VoltageLow:
L_checkKey130:
;Menu.c,442 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey131
;Menu.c,444 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,445 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,446 :: 		}
L_checkKey131:
;Menu.c,447 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey132
;Menu.c,449 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,450 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey248
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey248:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey133
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey133:
;Menu.c,452 :: 		}
L_checkKey132:
;Menu.c,453 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey134
;Menu.c,455 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,456 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey249
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey249:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey135
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey135:
;Menu.c,457 :: 		}
L_checkKey134:
;Menu.c,458 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey213
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey213
	GOTO       L_checkKey138
L__checkKey213:
;Menu.c,460 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
;Menu.c,461 :: 		}
L_checkKey138:
;Menu.c,462 :: 		break;
	GOTO       L_checkKey115
;Menu.c,464 :: 		}
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
;Menu.c,465 :: 		}
L_checkKey113:
;Menu.c,466 :: 		break;
	GOTO       L_checkKey47
;Menu.c,467 :: 		case Current:
L_checkKey139:
;Menu.c,468 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey140
;Menu.c,470 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,471 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,472 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,473 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,474 :: 		}
	GOTO       L_checkKey141
L_checkKey140:
;Menu.c,477 :: 		switch(subMenu)
	GOTO       L_checkKey142
;Menu.c,479 :: 		case CurrentEnable:
L_checkKey144:
;Menu.c,480 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey145
;Menu.c,482 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,483 :: 		}
L_checkKey145:
;Menu.c,484 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey212
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey212
	GOTO       L_checkKey148
L__checkKey212:
;Menu.c,486 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,487 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,489 :: 		}
L_checkKey148:
;Menu.c,490 :: 		break;
	GOTO       L_checkKey143
;Menu.c,491 :: 		case CurrentHeigh:
L_checkKey149:
;Menu.c,492 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey150
;Menu.c,494 :: 		subMenu = CurrentLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,495 :: 		editValue =  ee_read(EEPADDR_CurrentLow);
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,496 :: 		}
L_checkKey150:
;Menu.c,497 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey151
;Menu.c,499 :: 		editValue += 2;
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
;Menu.c,500 :: 		if (editValue > 201)   editValue = 11;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey250
	MOVF       R1+0, 0
	SUBLW      201
L__checkKey250:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey152
	MOVLW      11
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey152:
;Menu.c,502 :: 		}
L_checkKey151:
;Menu.c,503 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey153
;Menu.c,505 :: 		editValue -= 2;
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
;Menu.c,506 :: 		if (editValue < 11) editValue = 201;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey251
	MOVLW      11
	SUBWF      R1+0, 0
L__checkKey251:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey154
	MOVLW      201
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey154:
;Menu.c,507 :: 		}
L_checkKey153:
;Menu.c,508 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey211
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey211
	GOTO       L_checkKey157
L__checkKey211:
;Menu.c,510 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,511 :: 		}
L_checkKey157:
;Menu.c,512 :: 		break;
	GOTO       L_checkKey143
;Menu.c,513 :: 		case CurrentLow:
L_checkKey158:
;Menu.c,514 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey159
;Menu.c,516 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,517 :: 		editValue =  ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,518 :: 		}
L_checkKey159:
;Menu.c,519 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey160
;Menu.c,521 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,522 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey252
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey252:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey161
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey161:
;Menu.c,524 :: 		}
L_checkKey160:
;Menu.c,525 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey162
;Menu.c,527 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,528 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey253
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey253:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey163
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey163:
;Menu.c,529 :: 		}
L_checkKey162:
;Menu.c,530 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey210
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey210
	GOTO       L_checkKey166
L__checkKey210:
;Menu.c,532 :: 		loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
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
;Menu.c,533 :: 		}
L_checkKey166:
;Menu.c,534 :: 		break;
	GOTO       L_checkKey143
;Menu.c,536 :: 		}
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
;Menu.c,537 :: 		}
L_checkKey141:
;Menu.c,538 :: 		break;
	GOTO       L_checkKey47
;Menu.c,539 :: 		case LDRVal:
L_checkKey167:
;Menu.c,540 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey168
;Menu.c,542 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,543 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,544 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,545 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,546 :: 		}
	GOTO       L_checkKey169
L_checkKey168:
;Menu.c,549 :: 		switch(subMenu)
	GOTO       L_checkKey170
;Menu.c,551 :: 		case LDRValEnable:
L_checkKey172:
;Menu.c,552 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey173
;Menu.c,554 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,555 :: 		}
L_checkKey173:
;Menu.c,556 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey209
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey209
	GOTO       L_checkKey176
L__checkKey209:
;Menu.c,558 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,559 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,560 :: 		}
L_checkKey176:
;Menu.c,561 :: 		break;
	GOTO       L_checkKey171
;Menu.c,562 :: 		case LDRValHeigh:
L_checkKey177:
;Menu.c,563 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey178
;Menu.c,565 :: 		subMenu = LDRValLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,566 :: 		editValue =  ee_read(EEPADDR_LDRValLow);
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,567 :: 		}
L_checkKey178:
;Menu.c,568 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey179
;Menu.c,570 :: 		editValue += 2;
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
;Menu.c,571 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey254
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey254:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey180
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey180:
;Menu.c,573 :: 		}
L_checkKey179:
;Menu.c,574 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey181
;Menu.c,576 :: 		editValue -= 2;
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
;Menu.c,577 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey255
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey255:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey182
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey182:
;Menu.c,578 :: 		}
L_checkKey181:
;Menu.c,579 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey208
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey208
	GOTO       L_checkKey185
L__checkKey208:
;Menu.c,581 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,582 :: 		}
L_checkKey185:
;Menu.c,583 :: 		break;
	GOTO       L_checkKey171
;Menu.c,584 :: 		case LDRValLow:
L_checkKey186:
;Menu.c,585 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey187
;Menu.c,587 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,588 :: 		editValue =  ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,589 :: 		}
L_checkKey187:
;Menu.c,590 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey188
;Menu.c,592 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,593 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey256
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey256:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey189
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey189:
;Menu.c,595 :: 		}
L_checkKey188:
;Menu.c,596 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey190
;Menu.c,598 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,599 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey257
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey257:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey191
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey191:
;Menu.c,600 :: 		}
L_checkKey190:
;Menu.c,601 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey207
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey207
	GOTO       L_checkKey194
L__checkKey207:
;Menu.c,603 :: 		loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
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
;Menu.c,604 :: 		}
L_checkKey194:
;Menu.c,605 :: 		break;
	GOTO       L_checkKey171
;Menu.c,607 :: 		}
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
;Menu.c,608 :: 		}
L_checkKey169:
;Menu.c,609 :: 		break;
	GOTO       L_checkKey47
;Menu.c,610 :: 		default:
L_checkKey195:
;Menu.c,611 :: 		if(crntMenu<OnOFFTimeDay9)
	MOVLW      22
	SUBWF      _crntMenu+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey196
;Menu.c,613 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey197
;Menu.c,615 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      1
	MOVWF      _subMenu+0
;Menu.c,616 :: 		timeEEAddr += 5;
	MOVLW      5
	ADDWF      _timeEEAddr+0, 1
;Menu.c,617 :: 		strcpy(lcdrow1,codetxt_to_ramtxt("1)"));
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
;Menu.c,618 :: 		lcdrow1[0]= ((crntMenu - OnOFFTimeDay1) >> 1) + '0' + 1;
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
;Menu.c,619 :: 		Lcd_Out(1,1,lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,620 :: 		editValue = EEPROM_Read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,622 :: 		Lcd_Out(1,1,lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,623 :: 		editValue = ee_read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,624 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,625 :: 		}
	GOTO       L_checkKey198
L_checkKey197:
;Menu.c,740 :: 		}
L_checkKey198:
;Menu.c,744 :: 		}
	GOTO       L_checkKey199
L_checkKey196:
;Menu.c,747 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,748 :: 		}
L_checkKey199:
;Menu.c,750 :: 		break;
	GOTO       L_checkKey47
;Menu.c,751 :: 		}
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
;Menu.c,752 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey200
;Menu.c,753 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,754 :: 		}
L_checkKey200:
;Menu.c,755 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey206
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey206
	GOTO       L_checkKey203
L__checkKey206:
;Menu.c,757 :: 		isEdited = 1;
	BSF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,758 :: 		}
L_checkKey203:
;Menu.c,760 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey204:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey204
	DECFSZ     R12+0, 1
	GOTO       L_checkKey204
	DECFSZ     R11+0, 1
	GOTO       L_checkKey204
	NOP
	NOP
;Menu.c,761 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,762 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey258
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey258:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey205
;Menu.c,763 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,764 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,765 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,766 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,767 :: 		}
L_checkKey205:
;Menu.c,770 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey36
;Menu.c,771 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,773 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
