
_codetxt_to_ramtxt:

;Menu.c,83 :: 		char * codetxt_to_ramtxt(const char* ctxt)
;Menu.c,87 :: 		for(i =0; ctxt[i] != '\0'; i++){
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
;Menu.c,88 :: 		txt[i] = ctxt[i];
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
;Menu.c,87 :: 		for(i =0; ctxt[i] != '\0'; i++){
	INCF       R3+0, 1
;Menu.c,89 :: 		}
	GOTO       L_codetxt_to_ramtxt0
L_codetxt_to_ramtxt1:
;Menu.c,90 :: 		txt[i] = '\0';
	MOVF       R3+0, 0
	ADDLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Menu.c,91 :: 		return txt;
	MOVLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R0+0
;Menu.c,92 :: 		}
L_end_codetxt_to_ramtxt:
	RETURN
; end of _codetxt_to_ramtxt

_menuPortPinInt:

;Menu.c,96 :: 		void menuPortPinInt(){
;Menu.c,99 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,100 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,101 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,102 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,103 :: 		TRISC.F0 = 0;
	BCF        TRISC+0, 0
;Menu.c,106 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_saveValue:

;Menu.c,112 :: 		void saveValue(){
;Menu.c,113 :: 		if (!isEdited){
	BTFSC      _isEdited+0, BitPos(_isEdited+0)
	GOTO       L_saveValue3
;Menu.c,114 :: 		return;
	GOTO       L_end_saveValue
;Menu.c,115 :: 		}
L_saveValue3:
;Menu.c,116 :: 		isEdited = 0;
	BCF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,117 :: 		switch(crntMenu){
	GOTO       L_saveValue4
;Menu.c,118 :: 		case None:
L_saveValue6:
;Menu.c,119 :: 		break;
	GOTO       L_saveValue5
;Menu.c,120 :: 		case Date:
L_saveValue7:
;Menu.c,121 :: 		switch(subMenu){
	GOTO       L_saveValue8
;Menu.c,122 :: 		case DateDay:
L_saveValue10:
;Menu.c,123 :: 		write_ds1307(0x04,editValue);
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,124 :: 		break;
	GOTO       L_saveValue9
;Menu.c,125 :: 		case DateMonth:
L_saveValue11:
;Menu.c,126 :: 		write_ds1307(0x05,editValue);
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,127 :: 		break;
	GOTO       L_saveValue9
;Menu.c,128 :: 		case DateYear:
L_saveValue12:
;Menu.c,129 :: 		write_ds1307(0x06,editValue);
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,130 :: 		break;
	GOTO       L_saveValue9
;Menu.c,131 :: 		case DateWeekDay:
L_saveValue13:
;Menu.c,132 :: 		write_ds1307(0x03,editValue);
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,133 :: 		break;
	GOTO       L_saveValue9
;Menu.c,134 :: 		}
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
;Menu.c,135 :: 		break;
	GOTO       L_saveValue5
;Menu.c,136 :: 		case Time:
L_saveValue14:
;Menu.c,137 :: 		switch(subMenu){
	GOTO       L_saveValue15
;Menu.c,138 :: 		case TimeHour:
L_saveValue17:
;Menu.c,139 :: 		write_ds1307(0x02,editValue);
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,140 :: 		break;
	GOTO       L_saveValue16
;Menu.c,141 :: 		case TimeMinute:
L_saveValue18:
;Menu.c,142 :: 		write_ds1307(0x01,editValue);
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,143 :: 		break;
	GOTO       L_saveValue16
;Menu.c,144 :: 		}
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
;Menu.c,145 :: 		break;
	GOTO       L_saveValue5
;Menu.c,146 :: 		case Voltage:
L_saveValue19:
;Menu.c,147 :: 		switch(subMenu){
	GOTO       L_saveValue20
;Menu.c,148 :: 		case VoltageLow:
L_saveValue22:
;Menu.c,149 :: 		ee_write(EEPADDR_VoltageLow,editValue);
	MOVLW      4
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,150 :: 		break;
	GOTO       L_saveValue21
;Menu.c,151 :: 		case VoltageHigh:
L_saveValue23:
;Menu.c,152 :: 		ee_write(EEPADDR_VoltageHigh,editValue);
	MOVLW      2
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,153 :: 		break;
	GOTO       L_saveValue21
;Menu.c,154 :: 		}
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
;Menu.c,155 :: 		break;
	GOTO       L_saveValue5
;Menu.c,156 :: 		case Current:
L_saveValue24:
;Menu.c,157 :: 		switch(subMenu){
	GOTO       L_saveValue25
;Menu.c,158 :: 		case CurrentHeigh:
L_saveValue27:
;Menu.c,159 :: 		ee_write(EEPADDR_CurrentHeigh,editValue);
	MOVLW      6
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,160 :: 		break;
	GOTO       L_saveValue26
;Menu.c,161 :: 		case CurrentLow:
L_saveValue28:
;Menu.c,162 :: 		ee_write(EEPADDR_CurrentLow,editValue);
	MOVLW      8
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,163 :: 		break;
	GOTO       L_saveValue26
;Menu.c,164 :: 		}
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
;Menu.c,165 :: 		break;
	GOTO       L_saveValue5
;Menu.c,166 :: 		case LDRVal:
L_saveValue29:
;Menu.c,167 :: 		switch(subMenu){
	GOTO       L_saveValue30
;Menu.c,168 :: 		case LDRValLow:
L_saveValue32:
;Menu.c,169 :: 		ee_write(EEPADDR_LDRValLow,editValue);
	MOVLW      12
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,170 :: 		break;
	GOTO       L_saveValue31
;Menu.c,171 :: 		case LDRValHeigh:
L_saveValue33:
;Menu.c,172 :: 		ee_write(EEPADDR_LDRValHeigh,editValue);
	MOVLW      10
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,173 :: 		break;
	GOTO       L_saveValue31
;Menu.c,174 :: 		}
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
;Menu.c,175 :: 		break;
	GOTO       L_saveValue5
;Menu.c,176 :: 		default:
L_saveValue34:
;Menu.c,177 :: 		if ((crntMenu - OnOFFTimeDay) % 2 == 0 ) {
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
	GOTO       L__saveValue276
	MOVLW      0
	XORWF      R0+0, 0
L__saveValue276:
	BTFSS      STATUS+0, 2
	GOTO       L_saveValue35
;Menu.c,178 :: 		EEPROM_write(timeEEAddr,editValue);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Menu.c,179 :: 		}
	GOTO       L_saveValue36
L_saveValue35:
;Menu.c,182 :: 		if (subMenu == OnOFFTimeOnHr || subMenu == OnOFFTimeOnMin) {
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue258
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue258
	GOTO       L_saveValue39
L__saveValue258:
;Menu.c,183 :: 		ee_write(timeEEAddr+1,editValue);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,184 :: 		}
	GOTO       L_saveValue40
L_saveValue39:
;Menu.c,185 :: 		else if (subMenu == OnOFFTimeOffHr || subMenu == OnOFFTimeOffMin)
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue257
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue257
	GOTO       L_saveValue43
L__saveValue257:
;Menu.c,187 :: 		ee_write(timeEEAddr+3,editValue);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,188 :: 		}
L_saveValue43:
L_saveValue40:
;Menu.c,189 :: 		}
L_saveValue36:
;Menu.c,190 :: 		break;
	GOTO       L_saveValue5
;Menu.c,192 :: 		}
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
;Menu.c,193 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_saveValue44:
	DECFSZ     R13+0, 1
	GOTO       L_saveValue44
	DECFSZ     R12+0, 1
	GOTO       L_saveValue44
	DECFSZ     R11+0, 1
	GOTO       L_saveValue44
	NOP
;Menu.c,194 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_checkKey:

;Menu.c,214 :: 		void checkKey(){
;Menu.c,216 :: 		unsigned short tmp=0;
	CLRF       checkKey_tmp_L0+0
;Menu.c,217 :: 		timeEEAddr = EEPADDR_OnOFFTimeDay1-5;
	MOVLW      15
	MOVWF      _timeEEAddr+0
;Menu.c,218 :: 		do{
L_checkKey45:
;Menu.c,219 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey278
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey279
L__checkKey278:
	BSF        _cashedPortD+0, 7
L__checkKey279:
;Menu.c,220 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey280
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey281
L__checkKey280:
	BSF        _cashedPortD+0, 6
L__checkKey281:
;Menu.c,221 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey282
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey283
L__checkKey282:
	BSF        _cashedPortD+0, 5
L__checkKey283:
;Menu.c,222 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey284
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey285
L__checkKey284:
	BSF        _cashedPortD+0, 4
L__checkKey285:
;Menu.c,226 :: 		if(cashedPortD < 0xF0)
	MOVLW      240
	SUBWF      _cashedPortD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey48
;Menu.c,230 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,231 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey49:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey49
	DECFSZ     R12+0, 1
	GOTO       L_checkKey49
	DECFSZ     R11+0, 1
	GOTO       L_checkKey49
	NOP
;Menu.c,232 :: 		}
L_checkKey48:
;Menu.c,233 :: 		if(cMENU == ON){
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey50
;Menu.c,234 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,235 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey51
;Menu.c,236 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,237 :: 		}else{
	GOTO       L_checkKey52
L_checkKey51:
;Menu.c,238 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,239 :: 		}
L_checkKey52:
;Menu.c,240 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,241 :: 		if(crntMenu > (OnOFFTime + 16))
	MOVF       _crntMenu+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey53
;Menu.c,243 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,244 :: 		}
L_checkKey53:
;Menu.c,245 :: 		}
L_checkKey50:
;Menu.c,246 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey54
;Menu.c,248 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,249 :: 		}
L_checkKey54:
;Menu.c,250 :: 		switch(crntMenu)
	GOTO       L_checkKey55
;Menu.c,252 :: 		case None:
L_checkKey57:
;Menu.c,253 :: 		break;
	GOTO       L_checkKey56
;Menu.c,254 :: 		case Date:
L_checkKey58:
;Menu.c,255 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey59
;Menu.c,257 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,258 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,259 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,260 :: 		}
	GOTO       L_checkKey60
L_checkKey59:
;Menu.c,263 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey61
;Menu.c,265 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,266 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L_checkKey62
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey62:
;Menu.c,267 :: 		}
L_checkKey61:
;Menu.c,268 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey63
;Menu.c,270 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,271 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey287
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey287:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey64
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey64:
;Menu.c,272 :: 		}
L_checkKey63:
;Menu.c,273 :: 		switch(subMenu)
	GOTO       L_checkKey65
;Menu.c,276 :: 		case DateDay:
L_checkKey67:
;Menu.c,277 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey68
;Menu.c,279 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,280 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,281 :: 		}
L_checkKey68:
;Menu.c,282 :: 		if(cPLUS == ON){
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey69
;Menu.c,283 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey288
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey288:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey70
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey70:
;Menu.c,284 :: 		}
L_checkKey69:
;Menu.c,285 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey71
;Menu.c,287 :: 		if(editValue == 0x0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey289
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey289:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey72
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey72:
;Menu.c,288 :: 		}
L_checkKey71:
;Menu.c,289 :: 		break;
	GOTO       L_checkKey66
;Menu.c,290 :: 		case DateMonth:
L_checkKey73:
;Menu.c,291 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey74
;Menu.c,293 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,294 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,295 :: 		}
L_checkKey74:
;Menu.c,296 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey75
;Menu.c,298 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey290
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey290:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey76
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey76:
;Menu.c,299 :: 		}
L_checkKey75:
;Menu.c,300 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey77
;Menu.c,302 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey291
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey291:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey78
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey78:
;Menu.c,303 :: 		}
L_checkKey77:
;Menu.c,305 :: 		break;
	GOTO       L_checkKey66
;Menu.c,306 :: 		case DateYear:
L_checkKey79:
;Menu.c,307 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey80
;Menu.c,309 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,310 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,311 :: 		}
L_checkKey80:
;Menu.c,312 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey81
;Menu.c,314 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey292
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey292:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey82
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey82:
;Menu.c,315 :: 		}
L_checkKey81:
;Menu.c,316 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey83
;Menu.c,318 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey293
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey293:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey84
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey84:
;Menu.c,319 :: 		}
L_checkKey83:
;Menu.c,321 :: 		break;
	GOTO       L_checkKey66
;Menu.c,322 :: 		case DateWeekDay:
L_checkKey85:
;Menu.c,323 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey86
;Menu.c,325 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,326 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,327 :: 		}
L_checkKey86:
;Menu.c,328 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey87
;Menu.c,330 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey294
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey294:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey88
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey88:
;Menu.c,331 :: 		}
L_checkKey87:
;Menu.c,332 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey89
;Menu.c,334 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey295
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey295:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey90
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey90:
;Menu.c,335 :: 		}
L_checkKey89:
;Menu.c,336 :: 		break;
	GOTO       L_checkKey66
;Menu.c,338 :: 		}
L_checkKey65:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey67
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey73
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey79
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey85
L_checkKey66:
;Menu.c,339 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey272
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey272
	GOTO       L_checkKey93
L__checkKey272:
;Menu.c,341 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey94
;Menu.c,343 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,344 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,345 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,346 :: 		}
	GOTO       L_checkKey95
L_checkKey94:
;Menu.c,349 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,350 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,351 :: 		}
L_checkKey95:
;Menu.c,352 :: 		}
L_checkKey93:
;Menu.c,354 :: 		}
L_checkKey60:
;Menu.c,355 :: 		break;
	GOTO       L_checkKey56
;Menu.c,356 :: 		case Time:
L_checkKey96:
;Menu.c,357 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey97
;Menu.c,359 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,360 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,361 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,362 :: 		}
	GOTO       L_checkKey98
L_checkKey97:
;Menu.c,365 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey99
;Menu.c,367 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,368 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey296
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey296:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey100
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey100:
;Menu.c,369 :: 		}
L_checkKey99:
;Menu.c,370 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey101
;Menu.c,372 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,373 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey297
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey297:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey102
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey102:
;Menu.c,374 :: 		}
L_checkKey101:
;Menu.c,375 :: 		switch(subMenu)
	GOTO       L_checkKey103
;Menu.c,377 :: 		case TimeHour:
L_checkKey105:
;Menu.c,378 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey106
;Menu.c,380 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,381 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,382 :: 		}
L_checkKey106:
;Menu.c,383 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey107
;Menu.c,385 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey298
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey298:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey108
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey108:
;Menu.c,386 :: 		}
L_checkKey107:
;Menu.c,387 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey109
;Menu.c,389 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey299
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey299:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey110
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey110:
;Menu.c,390 :: 		}
L_checkKey109:
;Menu.c,391 :: 		break;
	GOTO       L_checkKey104
;Menu.c,392 :: 		case TimeMinute:
L_checkKey111:
;Menu.c,393 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey112
;Menu.c,395 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,396 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,397 :: 		}
L_checkKey112:
;Menu.c,398 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey113
;Menu.c,400 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey300
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey300:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey114
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey114:
;Menu.c,401 :: 		}
L_checkKey113:
;Menu.c,402 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey115
;Menu.c,404 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey301
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey301:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey116
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey116:
;Menu.c,405 :: 		}
L_checkKey115:
;Menu.c,406 :: 		break;
	GOTO       L_checkKey104
;Menu.c,407 :: 		}
L_checkKey103:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey105
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey111
L_checkKey104:
;Menu.c,408 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey271
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey271
	GOTO       L_checkKey119
L__checkKey271:
;Menu.c,410 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,411 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,412 :: 		}
L_checkKey119:
;Menu.c,413 :: 		}
L_checkKey98:
;Menu.c,414 :: 		break;
	GOTO       L_checkKey56
;Menu.c,415 :: 		case   Voltage:
L_checkKey120:
;Menu.c,416 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey121
;Menu.c,418 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,419 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,420 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,421 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,422 :: 		}
	GOTO       L_checkKey122
L_checkKey121:
;Menu.c,425 :: 		switch(subMenu)
	GOTO       L_checkKey123
;Menu.c,427 :: 		case VoltageEnable:
L_checkKey125:
;Menu.c,428 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey126
;Menu.c,430 :: 		subMenu = VoltageHigh;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,431 :: 		}
L_checkKey126:
;Menu.c,432 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey270
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey270
	GOTO       L_checkKey129
L__checkKey270:
;Menu.c,434 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,435 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,436 :: 		}
L_checkKey129:
;Menu.c,437 :: 		break;
	GOTO       L_checkKey124
;Menu.c,438 :: 		case VoltageHigh:
L_checkKey130:
;Menu.c,439 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey131
;Menu.c,441 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,442 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,443 :: 		}
L_checkKey131:
;Menu.c,444 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey132
;Menu.c,446 :: 		editValue += 2;
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
;Menu.c,447 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey302
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey302:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey133
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey133:
;Menu.c,449 :: 		}
L_checkKey132:
;Menu.c,450 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey134
;Menu.c,452 :: 		editValue -= 2;
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
;Menu.c,453 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey303
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey303:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey135
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey135:
;Menu.c,454 :: 		}
L_checkKey134:
;Menu.c,455 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey269
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey269
	GOTO       L_checkKey138
L__checkKey269:
;Menu.c,457 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,458 :: 		}
L_checkKey138:
;Menu.c,459 :: 		break;
	GOTO       L_checkKey124
;Menu.c,460 :: 		case VoltageLow:
L_checkKey139:
;Menu.c,461 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey140
;Menu.c,463 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,464 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,465 :: 		}
L_checkKey140:
;Menu.c,466 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey141
;Menu.c,468 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,469 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey304
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey304:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey142
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey142:
;Menu.c,471 :: 		}
L_checkKey141:
;Menu.c,472 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey143
;Menu.c,474 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,475 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey305
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey305:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey144
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey144:
;Menu.c,476 :: 		}
L_checkKey143:
;Menu.c,477 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey268
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey268
	GOTO       L_checkKey147
L__checkKey268:
;Menu.c,479 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
;Menu.c,480 :: 		}
L_checkKey147:
;Menu.c,481 :: 		break;
	GOTO       L_checkKey124
;Menu.c,483 :: 		}
L_checkKey123:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey125
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey130
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey139
L_checkKey124:
;Menu.c,484 :: 		}
L_checkKey122:
;Menu.c,485 :: 		break;
	GOTO       L_checkKey56
;Menu.c,486 :: 		case Current:
L_checkKey148:
;Menu.c,487 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey149
;Menu.c,489 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,490 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,491 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,492 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,493 :: 		}
	GOTO       L_checkKey150
L_checkKey149:
;Menu.c,496 :: 		switch(subMenu)
	GOTO       L_checkKey151
;Menu.c,498 :: 		case CurrentEnable:
L_checkKey153:
;Menu.c,499 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey154
;Menu.c,501 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,502 :: 		}
L_checkKey154:
;Menu.c,503 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey267
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey267
	GOTO       L_checkKey157
L__checkKey267:
;Menu.c,505 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,506 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,508 :: 		}
L_checkKey157:
;Menu.c,509 :: 		break;
	GOTO       L_checkKey152
;Menu.c,510 :: 		case CurrentHeigh:
L_checkKey158:
;Menu.c,511 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey159
;Menu.c,513 :: 		subMenu = CurrentLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,514 :: 		editValue =  ee_read(EEPADDR_CurrentLow);
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,515 :: 		}
L_checkKey159:
;Menu.c,516 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey160
;Menu.c,518 :: 		editValue += 2;
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
;Menu.c,519 :: 		if (editValue > 201)   editValue = 11;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey306
	MOVF       R1+0, 0
	SUBLW      201
L__checkKey306:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey161
	MOVLW      11
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey161:
;Menu.c,521 :: 		}
L_checkKey160:
;Menu.c,522 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey162
;Menu.c,524 :: 		editValue -= 2;
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
;Menu.c,525 :: 		if (editValue < 11) editValue = 201;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey307
	MOVLW      11
	SUBWF      R1+0, 0
L__checkKey307:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey163
	MOVLW      201
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey163:
;Menu.c,526 :: 		}
L_checkKey162:
;Menu.c,527 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey266
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey266
	GOTO       L_checkKey166
L__checkKey266:
;Menu.c,529 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,530 :: 		}
L_checkKey166:
;Menu.c,531 :: 		break;
	GOTO       L_checkKey152
;Menu.c,532 :: 		case CurrentLow:
L_checkKey167:
;Menu.c,533 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey168
;Menu.c,535 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,536 :: 		editValue =  ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,537 :: 		}
L_checkKey168:
;Menu.c,538 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey169
;Menu.c,540 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,541 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey308
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey308:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey170
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey170:
;Menu.c,543 :: 		}
L_checkKey169:
;Menu.c,544 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey171
;Menu.c,546 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,547 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey309
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey309:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey172
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey172:
;Menu.c,548 :: 		}
L_checkKey171:
;Menu.c,549 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey265
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey265
	GOTO       L_checkKey175
L__checkKey265:
;Menu.c,551 :: 		loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
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
;Menu.c,552 :: 		}
L_checkKey175:
;Menu.c,553 :: 		break;
	GOTO       L_checkKey152
;Menu.c,555 :: 		}
L_checkKey151:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey153
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey158
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey167
L_checkKey152:
;Menu.c,556 :: 		}
L_checkKey150:
;Menu.c,557 :: 		break;
	GOTO       L_checkKey56
;Menu.c,558 :: 		case LDRVal:
L_checkKey176:
;Menu.c,559 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey177
;Menu.c,561 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,562 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,563 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,564 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,565 :: 		}
	GOTO       L_checkKey178
L_checkKey177:
;Menu.c,568 :: 		switch(subMenu)
	GOTO       L_checkKey179
;Menu.c,570 :: 		case LDRValEnable:
L_checkKey181:
;Menu.c,571 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey182
;Menu.c,573 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,574 :: 		}
L_checkKey182:
;Menu.c,575 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey264
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey264
	GOTO       L_checkKey185
L__checkKey264:
;Menu.c,577 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,578 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,579 :: 		}
L_checkKey185:
;Menu.c,580 :: 		break;
	GOTO       L_checkKey180
;Menu.c,581 :: 		case LDRValHeigh:
L_checkKey186:
;Menu.c,582 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey187
;Menu.c,584 :: 		subMenu = LDRValLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,585 :: 		editValue =  ee_read(EEPADDR_LDRValLow);
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,586 :: 		}
L_checkKey187:
;Menu.c,587 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey188
;Menu.c,589 :: 		editValue += 2;
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
;Menu.c,590 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey310
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey310:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey189
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey189:
;Menu.c,592 :: 		}
L_checkKey188:
;Menu.c,593 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey190
;Menu.c,595 :: 		editValue -= 2;
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
;Menu.c,596 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey311
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey311:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey191
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey191:
;Menu.c,597 :: 		}
L_checkKey190:
;Menu.c,598 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey263
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey263
	GOTO       L_checkKey194
L__checkKey263:
;Menu.c,600 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,601 :: 		}
L_checkKey194:
;Menu.c,602 :: 		break;
	GOTO       L_checkKey180
;Menu.c,603 :: 		case LDRValLow:
L_checkKey195:
;Menu.c,604 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey196
;Menu.c,606 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,607 :: 		editValue =  ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,608 :: 		}
L_checkKey196:
;Menu.c,609 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey197
;Menu.c,611 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,612 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey312
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey312:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey198
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey198:
;Menu.c,614 :: 		}
L_checkKey197:
;Menu.c,615 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey199
;Menu.c,617 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,618 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey313
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey313:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey200
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey200:
;Menu.c,619 :: 		}
L_checkKey199:
;Menu.c,620 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey262
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey262
	GOTO       L_checkKey203
L__checkKey262:
;Menu.c,622 :: 		loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
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
;Menu.c,623 :: 		}
L_checkKey203:
;Menu.c,624 :: 		break;
	GOTO       L_checkKey180
;Menu.c,626 :: 		}
L_checkKey179:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey181
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey186
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey195
L_checkKey180:
;Menu.c,627 :: 		}
L_checkKey178:
;Menu.c,628 :: 		break;
	GOTO       L_checkKey56
;Menu.c,629 :: 		default:
L_checkKey204:
;Menu.c,630 :: 		if(crntMenu<(OnOFFTimeDay + 16))
	MOVLW      22
	SUBWF      _crntMenu+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey205
;Menu.c,632 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey206
;Menu.c,635 :: 		if ((crntMenu - OnOFFTimeDay) % 2 == 0 )
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
	GOTO       L__checkKey314
	MOVLW      0
	XORWF      R0+0, 0
L__checkKey314:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey207
;Menu.c,637 :: 		timeEEAddr += 5;
	MOVLW      5
	ADDWF      _timeEEAddr+0, 1
;Menu.c,638 :: 		}
L_checkKey207:
;Menu.c,639 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,640 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,641 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,642 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,643 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,644 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,645 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,646 :: 		editValue = EEPROM_Read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,647 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,648 :: 		tmp = 0;
	CLRF       checkKey_tmp_L0+0
;Menu.c,649 :: 		if ((crntMenu - OnOFFTimeDay) % 2 == 1 )
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
	GOTO       L__checkKey315
	MOVLW      1
	XORWF      R0+0, 0
L__checkKey315:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey208
;Menu.c,651 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,652 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,653 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      checkKey_tmp_L0+0
;Menu.c,654 :: 		}
L_checkKey208:
;Menu.c,656 :: 		}
	GOTO       L_checkKey209
L_checkKey206:
;Menu.c,659 :: 		if ((crntMenu - OnOFFTimeDay) % 2 == 0 ) {
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
	GOTO       L__checkKey316
	MOVLW      0
	XORWF      R0+0, 0
L__checkKey316:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey210
;Menu.c,661 :: 		if (cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey211
;Menu.c,663 :: 		subMenu +=2;
	MOVLW      2
	ADDWF      _subMenu+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _subMenu+0
;Menu.c,664 :: 		tmp++;
	INCF       checkKey_tmp_L0+0, 1
;Menu.c,665 :: 		if (subMenu>OnOFFTimeDaySat) {
	MOVF       R1+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey212
;Menu.c,666 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,667 :: 		tmp = 0;
	CLRF       checkKey_tmp_L0+0
;Menu.c,668 :: 		}
L_checkKey212:
;Menu.c,669 :: 		}
L_checkKey211:
;Menu.c,670 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey261
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey261
	GOTO       L_checkKey215
L__checkKey261:
;Menu.c,672 :: 		editValue = editValue ^ (1<<tmp);
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__checkKey317:
	BTFSC      STATUS+0, 2
	GOTO       L__checkKey318
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__checkKey317
L__checkKey318:
	MOVF       R0+0, 0
	XORWF      _editValue+0, 1
	MOVF       R0+1, 0
	XORWF      _editValue+1, 1
;Menu.c,673 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,674 :: 		}
L_checkKey215:
;Menu.c,676 :: 		}
	GOTO       L_checkKey216
L_checkKey210:
;Menu.c,679 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey217
;Menu.c,681 :: 		tmp++;
	INCF       checkKey_tmp_L0+0, 1
;Menu.c,682 :: 		if((tmp & 0x0F )>9) tmp += 6;
	MOVLW      15
	ANDWF      checkKey_tmp_L0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey218
	MOVLW      6
	ADDWF      checkKey_tmp_L0+0, 1
L_checkKey218:
;Menu.c,683 :: 		}
L_checkKey217:
;Menu.c,684 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey219
;Menu.c,686 :: 		tmp--;
	DECF       checkKey_tmp_L0+0, 1
;Menu.c,687 :: 		if((tmp & 0x0F )>9) tmp -= 6;
	MOVLW      15
	ANDWF      checkKey_tmp_L0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey220
	MOVLW      6
	SUBWF      checkKey_tmp_L0+0, 1
L_checkKey220:
;Menu.c,688 :: 		}
L_checkKey219:
;Menu.c,689 :: 		switch (subMenu) {
	GOTO       L_checkKey221
;Menu.c,691 :: 		case OnOFFTimeOnHr:
L_checkKey223:
;Menu.c,692 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey224
;Menu.c,694 :: 		subMenu = OnOFFTimeOnMin;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,695 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      checkKey_tmp_L0+0
;Menu.c,696 :: 		}
L_checkKey224:
;Menu.c,698 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey225
;Menu.c,700 :: 		if (tmp > 0x23) {
	MOVF       checkKey_tmp_L0+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey226
;Menu.c,701 :: 		tmp = 0;
	CLRF       checkKey_tmp_L0+0
;Menu.c,702 :: 		}
L_checkKey226:
;Menu.c,703 :: 		Lo(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+0
;Menu.c,705 :: 		}
L_checkKey225:
;Menu.c,706 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey227
;Menu.c,708 :: 		if (!tmp) {
	MOVF       checkKey_tmp_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey228
;Menu.c,709 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      checkKey_tmp_L0+0
;Menu.c,710 :: 		}
L_checkKey228:
;Menu.c,711 :: 		Lo(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+0
;Menu.c,712 :: 		}
L_checkKey227:
;Menu.c,713 :: 		break;
	GOTO       L_checkKey222
;Menu.c,714 :: 		case OnOFFTimeOnMin:
L_checkKey229:
;Menu.c,715 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey230
;Menu.c,717 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,718 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,719 :: 		tmp = Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      checkKey_tmp_L0+0
;Menu.c,720 :: 		}
L_checkKey230:
;Menu.c,721 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey231
;Menu.c,724 :: 		if (tmp > 0x59)
	MOVF       checkKey_tmp_L0+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey232
;Menu.c,726 :: 		tmp = 0;
	CLRF       checkKey_tmp_L0+0
;Menu.c,727 :: 		}
L_checkKey232:
;Menu.c,728 :: 		Hi(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+1
;Menu.c,730 :: 		}
L_checkKey231:
;Menu.c,731 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey233
;Menu.c,733 :: 		if (!tmp)
	MOVF       checkKey_tmp_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey234
;Menu.c,735 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      checkKey_tmp_L0+0
;Menu.c,736 :: 		}
L_checkKey234:
;Menu.c,737 :: 		Hi(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+1
;Menu.c,738 :: 		}
L_checkKey233:
;Menu.c,739 :: 		break;
	GOTO       L_checkKey222
;Menu.c,740 :: 		case OnOFFTimeOffHr:
L_checkKey235:
;Menu.c,741 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey236
;Menu.c,743 :: 		subMenu = OnOFFTimeOffMin;
	MOVLW      14
	MOVWF      _subMenu+0
;Menu.c,744 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      checkKey_tmp_L0+0
;Menu.c,745 :: 		}
L_checkKey236:
;Menu.c,746 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey237
;Menu.c,748 :: 		if (tmp > 0x23) {
	MOVF       checkKey_tmp_L0+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey238
;Menu.c,749 :: 		tmp = 0;
	CLRF       checkKey_tmp_L0+0
;Menu.c,750 :: 		}
L_checkKey238:
;Menu.c,751 :: 		Lo(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+0
;Menu.c,753 :: 		}
L_checkKey237:
;Menu.c,754 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey239
;Menu.c,756 :: 		if (!tmp) {
	MOVF       checkKey_tmp_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey240
;Menu.c,757 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      checkKey_tmp_L0+0
;Menu.c,758 :: 		}
L_checkKey240:
;Menu.c,759 :: 		Lo(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+0
;Menu.c,760 :: 		}
L_checkKey239:
;Menu.c,761 :: 		break;
	GOTO       L_checkKey222
;Menu.c,762 :: 		case OnOFFTimeOffMin:
L_checkKey241:
;Menu.c,763 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey242
;Menu.c,765 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,766 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,767 :: 		tmp =  Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      checkKey_tmp_L0+0
;Menu.c,769 :: 		}
L_checkKey242:
;Menu.c,770 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey243
;Menu.c,773 :: 		if (tmp > 0x59)
	MOVF       checkKey_tmp_L0+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey244
;Menu.c,775 :: 		tmp = 0;
	CLRF       checkKey_tmp_L0+0
;Menu.c,776 :: 		}
L_checkKey244:
;Menu.c,777 :: 		Hi(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+1
;Menu.c,779 :: 		}
L_checkKey243:
;Menu.c,780 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey245
;Menu.c,782 :: 		if (!tmp)
	MOVF       checkKey_tmp_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey246
;Menu.c,784 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      checkKey_tmp_L0+0
;Menu.c,785 :: 		}
L_checkKey246:
;Menu.c,786 :: 		Hi(editValue) = tmp;
	MOVF       checkKey_tmp_L0+0, 0
	MOVWF      _editValue+1
;Menu.c,787 :: 		}
L_checkKey245:
;Menu.c,789 :: 		break;
	GOTO       L_checkKey222
;Menu.c,790 :: 		}
L_checkKey221:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey223
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey229
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey235
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey241
L_checkKey222:
;Menu.c,791 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey260
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey260
	GOTO       L_checkKey249
L__checkKey260:
;Menu.c,793 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,794 :: 		}
L_checkKey249:
;Menu.c,795 :: 		}
L_checkKey216:
;Menu.c,798 :: 		}
L_checkKey209:
;Menu.c,802 :: 		}
	GOTO       L_checkKey250
L_checkKey205:
;Menu.c,805 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,806 :: 		}
L_checkKey250:
;Menu.c,808 :: 		break;
	GOTO       L_checkKey56
;Menu.c,809 :: 		}
L_checkKey55:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey57
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey58
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey96
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey120
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey148
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey176
	GOTO       L_checkKey204
L_checkKey56:
;Menu.c,810 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey251
;Menu.c,811 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,812 :: 		}
L_checkKey251:
;Menu.c,813 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey259
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey259
	GOTO       L_checkKey254
L__checkKey259:
;Menu.c,815 :: 		isEdited = 1;
	BSF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,816 :: 		}
L_checkKey254:
;Menu.c,818 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey255:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey255
	DECFSZ     R12+0, 1
	GOTO       L_checkKey255
	DECFSZ     R11+0, 1
	GOTO       L_checkKey255
	NOP
;Menu.c,819 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,820 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey319
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey319:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey256
;Menu.c,821 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,822 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,823 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,824 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,825 :: 		}
L_checkKey256:
;Menu.c,828 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey45
;Menu.c,829 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,831 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
