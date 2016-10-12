
_codetxt_to_ramtxt:

;Menu.c,53 :: 		char * codetxt_to_ramtxt(const char* ctxt)
;Menu.c,57 :: 		for(i =0; ctxt[i] != '\0'; i++){
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
;Menu.c,58 :: 		txt[i] = ctxt[i];
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
;Menu.c,57 :: 		for(i =0; ctxt[i] != '\0'; i++){
	INCF       R3+0, 1
;Menu.c,59 :: 		}
	GOTO       L_codetxt_to_ramtxt0
L_codetxt_to_ramtxt1:
;Menu.c,60 :: 		txt[i] = '\0';
	MOVF       R3+0, 0
	ADDLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Menu.c,61 :: 		return txt;
	MOVLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R0+0
;Menu.c,62 :: 		}
L_end_codetxt_to_ramtxt:
	RETURN
; end of _codetxt_to_ramtxt

_menuPortPinInt:

;Menu.c,64 :: 		void menuPortPinInt(){
;Menu.c,67 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,68 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,69 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,70 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,73 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_saveValue:

;Menu.c,78 :: 		void saveValue(){
;Menu.c,79 :: 		switch(crntMenu){
	GOTO       L_saveValue3
;Menu.c,80 :: 		case Date:
L_saveValue5:
;Menu.c,81 :: 		switch(subMenu){
	GOTO       L_saveValue6
;Menu.c,82 :: 		case DateDay:
L_saveValue8:
;Menu.c,83 :: 		write_ds1307(0x04,editValue);
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,84 :: 		break;
	GOTO       L_saveValue7
;Menu.c,85 :: 		case DateMonth:
L_saveValue9:
;Menu.c,86 :: 		write_ds1307(0x05,editValue);
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,87 :: 		break;
	GOTO       L_saveValue7
;Menu.c,88 :: 		case DateYear:
L_saveValue10:
;Menu.c,89 :: 		write_ds1307(0x06,editValue);
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,90 :: 		break;
	GOTO       L_saveValue7
;Menu.c,91 :: 		case DateWeekDay:
L_saveValue11:
;Menu.c,92 :: 		write_ds1307(0x03,editValue);
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,93 :: 		break;
	GOTO       L_saveValue7
;Menu.c,94 :: 		}
L_saveValue6:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue8
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue9
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue10
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue11
L_saveValue7:
;Menu.c,95 :: 		break;
	GOTO       L_saveValue4
;Menu.c,96 :: 		case Time:
L_saveValue12:
;Menu.c,97 :: 		switch(subMenu){
	GOTO       L_saveValue13
;Menu.c,98 :: 		case TimeHour:
L_saveValue15:
;Menu.c,99 :: 		write_ds1307(0x02,editValue);
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,100 :: 		break;
	GOTO       L_saveValue14
;Menu.c,101 :: 		case TimeMinute:
L_saveValue16:
;Menu.c,102 :: 		write_ds1307(0x01,editValue);
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,103 :: 		break;
	GOTO       L_saveValue14
;Menu.c,104 :: 		}
L_saveValue13:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue15
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue16
L_saveValue14:
;Menu.c,105 :: 		break;
	GOTO       L_saveValue4
;Menu.c,106 :: 		}
L_saveValue3:
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue5
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue12
L_saveValue4:
;Menu.c,107 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_checkKey:

;Menu.c,114 :: 		void checkKey(){
;Menu.c,115 :: 		unsigned short timeEEAddr = EEPADDR_OnOFFTimeEdit1-2;
	MOVLW      14
	MOVWF      checkKey_timeEEAddr_L0+0
;Menu.c,117 :: 		do{
L_checkKey17:
;Menu.c,118 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey157
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey158
L__checkKey157:
	BSF        _cashedPortD+0, 7
L__checkKey158:
;Menu.c,119 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey159
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey160
L__checkKey159:
	BSF        _cashedPortD+0, 6
L__checkKey160:
;Menu.c,120 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey161
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey162
L__checkKey161:
	BSF        _cashedPortD+0, 5
L__checkKey162:
;Menu.c,121 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey163
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey164
L__checkKey163:
	BSF        _cashedPortD+0, 4
L__checkKey164:
;Menu.c,123 :: 		if(cashedPortD > 0)
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey20
;Menu.c,129 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,130 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey21:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey21
	DECFSZ     R12+0, 1
	GOTO       L_checkKey21
	DECFSZ     R11+0, 1
	GOTO       L_checkKey21
	NOP
	NOP
;Menu.c,131 :: 		}
L_checkKey20:
;Menu.c,132 :: 		if(cMENU == ON){
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey22
;Menu.c,133 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,134 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey23
;Menu.c,135 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,136 :: 		}else{
	GOTO       L_checkKey24
L_checkKey23:
;Menu.c,137 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,138 :: 		}
L_checkKey24:
;Menu.c,139 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,140 :: 		if(crntMenu>(OnOFFTime+8))
	MOVF       _crntMenu+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey25
;Menu.c,142 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,143 :: 		}
L_checkKey25:
;Menu.c,144 :: 		}
L_checkKey22:
;Menu.c,145 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey26
;Menu.c,147 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,148 :: 		}
L_checkKey26:
;Menu.c,149 :: 		switch(crntMenu)
	GOTO       L_checkKey27
;Menu.c,151 :: 		case None:
L_checkKey29:
;Menu.c,152 :: 		break;
	GOTO       L_checkKey28
;Menu.c,153 :: 		case Date:
L_checkKey30:
;Menu.c,154 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey31
;Menu.c,156 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,157 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,158 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,159 :: 		}
	GOTO       L_checkKey32
L_checkKey31:
;Menu.c,162 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey33
;Menu.c,164 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,165 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey165
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey165:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey34
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey34:
;Menu.c,166 :: 		}
L_checkKey33:
;Menu.c,167 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey35
;Menu.c,169 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,170 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey166
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey166:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey36
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey36:
;Menu.c,171 :: 		}
L_checkKey35:
;Menu.c,172 :: 		switch(subMenu)
	GOTO       L_checkKey37
;Menu.c,175 :: 		case DateDay:
L_checkKey39:
;Menu.c,176 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey40
;Menu.c,178 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,179 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,180 :: 		}
L_checkKey40:
;Menu.c,181 :: 		if(cPLUS == ON){
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey41
;Menu.c,182 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey167
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey167:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey42
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey42:
;Menu.c,183 :: 		}
L_checkKey41:
;Menu.c,184 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey43
;Menu.c,186 :: 		if(editValue == 0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey168
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey168:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey44
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey44:
;Menu.c,187 :: 		}
L_checkKey43:
;Menu.c,188 :: 		break;
	GOTO       L_checkKey38
;Menu.c,189 :: 		case DateMonth:
L_checkKey45:
;Menu.c,190 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey46
;Menu.c,192 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,193 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,194 :: 		}
L_checkKey46:
;Menu.c,195 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey47
;Menu.c,197 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey169
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey169:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey48
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey48:
;Menu.c,198 :: 		}
L_checkKey47:
;Menu.c,199 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey49
;Menu.c,201 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey170
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey170:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey50
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey50:
;Menu.c,202 :: 		}
L_checkKey49:
;Menu.c,204 :: 		break;
	GOTO       L_checkKey38
;Menu.c,205 :: 		case DateYear:
L_checkKey51:
;Menu.c,206 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey52
;Menu.c,208 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,209 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,210 :: 		}
L_checkKey52:
;Menu.c,211 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey53
;Menu.c,213 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey171
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey171:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey54
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey54:
;Menu.c,214 :: 		}
L_checkKey53:
;Menu.c,215 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey55
;Menu.c,217 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey172
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey172:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey56
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey56:
;Menu.c,218 :: 		}
L_checkKey55:
;Menu.c,220 :: 		break;
	GOTO       L_checkKey38
;Menu.c,221 :: 		case DateWeekDay:
L_checkKey57:
;Menu.c,222 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey58
;Menu.c,224 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,225 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,226 :: 		}
L_checkKey58:
;Menu.c,227 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey59
;Menu.c,229 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey173
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey173:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey60
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey60:
;Menu.c,230 :: 		}
L_checkKey59:
;Menu.c,231 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey61
;Menu.c,233 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey174
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey174:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey62
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey62:
;Menu.c,234 :: 		}
L_checkKey61:
;Menu.c,235 :: 		break;
	GOTO       L_checkKey38
;Menu.c,237 :: 		}
L_checkKey37:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey39
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey45
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey51
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey57
L_checkKey38:
;Menu.c,238 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey152
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey152
	GOTO       L_checkKey65
L__checkKey152:
;Menu.c,240 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey66
;Menu.c,242 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,243 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,244 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,245 :: 		}
	GOTO       L_checkKey67
L_checkKey66:
;Menu.c,248 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,249 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,250 :: 		}
L_checkKey67:
;Menu.c,251 :: 		}
L_checkKey65:
;Menu.c,253 :: 		}
L_checkKey32:
;Menu.c,254 :: 		break;
	GOTO       L_checkKey28
;Menu.c,255 :: 		case Time:
L_checkKey68:
;Menu.c,256 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey69
;Menu.c,258 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,259 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,260 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,261 :: 		}
	GOTO       L_checkKey70
L_checkKey69:
;Menu.c,264 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey71
;Menu.c,266 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,267 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey175
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey175:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey72
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey72:
;Menu.c,268 :: 		}
L_checkKey71:
;Menu.c,269 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey73
;Menu.c,271 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,272 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey176
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey176:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey74
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey74:
;Menu.c,273 :: 		}
L_checkKey73:
;Menu.c,274 :: 		switch(subMenu)
	GOTO       L_checkKey75
;Menu.c,276 :: 		case TimeHour:
L_checkKey77:
;Menu.c,277 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey78
;Menu.c,279 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,280 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,281 :: 		}
L_checkKey78:
;Menu.c,282 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey79
;Menu.c,284 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey177
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey177:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey80
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey80:
;Menu.c,285 :: 		}
L_checkKey79:
;Menu.c,286 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey81
;Menu.c,288 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey178
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey178:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey82
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey82:
;Menu.c,289 :: 		}
L_checkKey81:
;Menu.c,290 :: 		break;
	GOTO       L_checkKey76
;Menu.c,291 :: 		case TimeMinute:
L_checkKey83:
;Menu.c,292 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey84
;Menu.c,294 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,295 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,296 :: 		}
L_checkKey84:
;Menu.c,297 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey85
;Menu.c,299 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey179
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey179:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey86
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey86:
;Menu.c,300 :: 		}
L_checkKey85:
;Menu.c,301 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey87
;Menu.c,303 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey180
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey180:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey88
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey88:
;Menu.c,304 :: 		}
L_checkKey87:
;Menu.c,305 :: 		break;
	GOTO       L_checkKey76
;Menu.c,306 :: 		}
L_checkKey75:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey77
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey83
L_checkKey76:
;Menu.c,307 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey151
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey151
	GOTO       L_checkKey91
L__checkKey151:
;Menu.c,309 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,310 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,311 :: 		}
L_checkKey91:
;Menu.c,312 :: 		}
L_checkKey70:
;Menu.c,313 :: 		break;
	GOTO       L_checkKey28
;Menu.c,314 :: 		case   Voltage:
L_checkKey92:
;Menu.c,315 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey93
;Menu.c,317 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,318 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,319 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,320 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,321 :: 		}
	GOTO       L_checkKey94
L_checkKey93:
;Menu.c,324 :: 		switch(subMenu)
	GOTO       L_checkKey95
;Menu.c,326 :: 		case VoltageEnable:
L_checkKey97:
;Menu.c,327 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey98
;Menu.c,329 :: 		subMenu = VoltageHigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,330 :: 		}
L_checkKey98:
;Menu.c,331 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey150
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey150
	GOTO       L_checkKey101
L__checkKey150:
;Menu.c,333 :: 		isEnabled = !isEnabled;
	MOVLW      1
	XORWF      _editValue+0, 1
;Menu.c,334 :: 		if (isEnabled)
	BTFSS      _editValue+0, 0
	GOTO       L_checkKey102
;Menu.c,336 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,337 :: 		}
L_checkKey102:
;Menu.c,338 :: 		}
L_checkKey101:
;Menu.c,339 :: 		break;
	GOTO       L_checkKey96
;Menu.c,340 :: 		case VoltageHigh:
L_checkKey103:
;Menu.c,341 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey104
;Menu.c,343 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,344 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,345 :: 		}
L_checkKey104:
;Menu.c,346 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey105
;Menu.c,348 :: 		editValue += 2;
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
;Menu.c,349 :: 		if (editValue > 221)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey181
	MOVF       R1+0, 0
	SUBLW      221
L__checkKey181:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey106
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey106:
;Menu.c,351 :: 		}
L_checkKey105:
;Menu.c,352 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey107
;Menu.c,354 :: 		editValue += 2;
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
;Menu.c,355 :: 		if (editValue < 81) editValue = 221;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey182
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey182:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey108
	MOVLW      221
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey108:
;Menu.c,356 :: 		}
L_checkKey107:
;Menu.c,357 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey149
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey149
	GOTO       L_checkKey111
L__checkKey149:
;Menu.c,359 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,360 :: 		}
L_checkKey111:
;Menu.c,361 :: 		break;
	GOTO       L_checkKey96
;Menu.c,362 :: 		case VoltageLow:
L_checkKey112:
;Menu.c,363 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey113
;Menu.c,365 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,366 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,367 :: 		}
L_checkKey113:
;Menu.c,368 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey114
;Menu.c,370 :: 		editValue += 2;
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
;Menu.c,371 :: 		if (editValue > 221)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey183
	MOVF       R1+0, 0
	SUBLW      221
L__checkKey183:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey115
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey115:
;Menu.c,373 :: 		}
L_checkKey114:
;Menu.c,374 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey116
;Menu.c,376 :: 		editValue += 2;
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
;Menu.c,377 :: 		if (editValue < 81) editValue = 221;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey184
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey184:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey117
	MOVLW      221
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey117:
;Menu.c,378 :: 		}
L_checkKey116:
;Menu.c,379 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey148
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey148
	GOTO       L_checkKey120
L__checkKey148:
;Menu.c,381 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageLow),editValue,0);
	MOVLW      4
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
;Menu.c,382 :: 		}
L_checkKey120:
;Menu.c,383 :: 		break;
	GOTO       L_checkKey96
;Menu.c,385 :: 		}
L_checkKey95:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey97
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey103
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey112
L_checkKey96:
;Menu.c,386 :: 		}
L_checkKey94:
;Menu.c,387 :: 		break;
	GOTO       L_checkKey28
;Menu.c,388 :: 		case Current:
L_checkKey121:
;Menu.c,389 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey122
;Menu.c,391 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,392 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,393 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,394 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,395 :: 		}
	GOTO       L_checkKey123
L_checkKey122:
;Menu.c,398 :: 		}
L_checkKey123:
;Menu.c,399 :: 		break;
	GOTO       L_checkKey28
;Menu.c,400 :: 		case LDRVal:
L_checkKey124:
;Menu.c,401 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey125
;Menu.c,403 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,404 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,405 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,406 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,407 :: 		}
	GOTO       L_checkKey126
L_checkKey125:
;Menu.c,410 :: 		}
L_checkKey126:
;Menu.c,411 :: 		break;
	GOTO       L_checkKey28
;Menu.c,412 :: 		default:
L_checkKey127:
;Menu.c,413 :: 		if(crntMenu<(OnOFFTime+8))
	MOVLW      14
	SUBWF      _crntMenu+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey128
;Menu.c,415 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey129
;Menu.c,417 :: 		subMenu = OnOFFTimeEditEnable;
	CLRF       _subMenu+0
;Menu.c,418 :: 		timeEEAddr += 2;
	MOVLW      2
	ADDWF      checkKey_timeEEAddr_L0+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      checkKey_timeEEAddr_L0+0
;Menu.c,419 :: 		editValue = ee_read(timeEEAddr);
	MOVF       R0+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,420 :: 		strcpy(lcdrow1,codetxt_to_ramtxt("Time1 Day  Hr:Mn"));
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
;Menu.c,421 :: 		lcdrow1[4]= crntMenu - OnOFFTime + '0' + 1;
	MOVLW      6
	SUBWF      _crntMenu+0, 0
	MOVWF      _lcdrow1+4
	MOVLW      48
	ADDWF      _lcdrow1+4, 1
	INCF       _lcdrow1+4, 1
;Menu.c,422 :: 		Lcd_Out(1,1,lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,423 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,424 :: 		}
L_checkKey129:
;Menu.c,425 :: 		case OnOFFTimeEditEnable:
L_checkKey130:
;Menu.c,426 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey131
;Menu.c,428 :: 		subMenu = OnOFFTimeEditWeekDay;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,429 :: 		}
L_checkKey131:
;Menu.c,430 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey147
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey147
	GOTO       L_checkKey134
L__checkKey147:
;Menu.c,432 :: 		isEnabled = !isEnabled;
	MOVLW      1
	XORWF      _editValue+0, 1
;Menu.c,433 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,434 :: 		}
L_checkKey134:
;Menu.c,435 :: 		break;
	GOTO       L_checkKey28
;Menu.c,436 :: 		case OnOFFTimeEditWeekDay:
L_checkKey135:
;Menu.c,437 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey136
;Menu.c,439 :: 		subMenu = OnOFFTimeEditHour;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,440 :: 		}
L_checkKey136:
;Menu.c,441 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey137
;Menu.c,443 :: 		lowDay = !lowDay;
	MOVLW      2
	XORWF      _editValue+0, 1
;Menu.c,444 :: 		if(!lowDay )
	BTFSC      _editValue+0, 1
	GOTO       L_checkKey138
;Menu.c,446 :: 		MidleDay = !MidleDay;
	MOVLW      4
	XORWF      _editValue+0, 1
;Menu.c,447 :: 		if (!MidleDay)
	BTFSC      _editValue+0, 2
	GOTO       L_checkKey139
;Menu.c,449 :: 		HeighDay = !HeighDay;
	MOVLW      8
	XORWF      _editValue+0, 1
;Menu.c,450 :: 		}
L_checkKey139:
;Menu.c,451 :: 		}
L_checkKey138:
;Menu.c,452 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,453 :: 		}
L_checkKey137:
;Menu.c,454 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey140
;Menu.c,456 :: 		lowDay = !lowDay;
	MOVLW      2
	XORWF      _editValue+0, 1
;Menu.c,457 :: 		if(lowDay )
	BTFSS      _editValue+0, 1
	GOTO       L_checkKey141
;Menu.c,459 :: 		MidleDay = !MidleDay;
	MOVLW      4
	XORWF      _editValue+0, 1
;Menu.c,460 :: 		if (MidleDay)
	BTFSS      _editValue+0, 2
	GOTO       L_checkKey142
;Menu.c,462 :: 		HeighDay = !HeighDay;
	MOVLW      8
	XORWF      _editValue+0, 1
;Menu.c,463 :: 		}
L_checkKey142:
;Menu.c,464 :: 		}
L_checkKey141:
;Menu.c,465 :: 		loadEnDayHrMin();
	CALL       _loadEnDayHrMin+0
;Menu.c,466 :: 		}
L_checkKey140:
;Menu.c,467 :: 		break;
	GOTO       L_checkKey28
;Menu.c,468 :: 		}
L_checkKey128:
;Menu.c,471 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,474 :: 		break;
	GOTO       L_checkKey28
;Menu.c,475 :: 		}
L_checkKey27:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey29
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey30
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey68
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey92
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey121
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey124
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey130
	MOVF       _crntMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey135
	GOTO       L_checkKey127
L_checkKey28:
;Menu.c,476 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey144
;Menu.c,477 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,478 :: 		}
L_checkKey144:
;Menu.c,480 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey145:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey145
	DECFSZ     R12+0, 1
	GOTO       L_checkKey145
	DECFSZ     R11+0, 1
	GOTO       L_checkKey145
	NOP
	NOP
;Menu.c,481 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,482 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey185
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey185:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey146
;Menu.c,483 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,484 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,485 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,486 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,487 :: 		}
L_checkKey146:
;Menu.c,490 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey17
;Menu.c,491 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,493 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
