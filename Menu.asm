
_codetxt_to_ramtxt:

;Menu.c,50 :: 		char * codetxt_to_ramtxt(const char* ctxt)
;Menu.c,54 :: 		for(i =0; ctxt[i] != '\0'; i++){
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
;Menu.c,54 :: 		for(i =0; ctxt[i] != '\0'; i++){
	INCF       R3+0, 1
;Menu.c,56 :: 		}
	GOTO       L_codetxt_to_ramtxt0
L_codetxt_to_ramtxt1:
;Menu.c,57 :: 		txt[i] = '\0';
	MOVF       R3+0, 0
	ADDLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Menu.c,58 :: 		return txt;
	MOVLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R0+0
;Menu.c,59 :: 		}
L_end_codetxt_to_ramtxt:
	RETURN
; end of _codetxt_to_ramtxt

_menuPortPinInt:

;Menu.c,61 :: 		void menuPortPinInt(){
;Menu.c,64 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,65 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,66 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,67 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,70 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_saveValue:

;Menu.c,75 :: 		void saveValue(){
;Menu.c,76 :: 		switch(crntMenu){
	GOTO       L_saveValue3
;Menu.c,77 :: 		case Date:
L_saveValue5:
;Menu.c,78 :: 		switch(subMenu){
	GOTO       L_saveValue6
;Menu.c,79 :: 		case DateDay:
L_saveValue8:
;Menu.c,80 :: 		write_ds1307(0x04,editValue);
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,81 :: 		break;
	GOTO       L_saveValue7
;Menu.c,82 :: 		case DateMonth:
L_saveValue9:
;Menu.c,83 :: 		write_ds1307(0x05,editValue);
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,84 :: 		break;
	GOTO       L_saveValue7
;Menu.c,85 :: 		case DateYear:
L_saveValue10:
;Menu.c,86 :: 		write_ds1307(0x06,editValue);
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,87 :: 		break;
	GOTO       L_saveValue7
;Menu.c,88 :: 		case DateWeekDay:
L_saveValue11:
;Menu.c,89 :: 		write_ds1307(0x03,editValue);
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,90 :: 		break;
	GOTO       L_saveValue7
;Menu.c,91 :: 		}
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
;Menu.c,92 :: 		break;
	GOTO       L_saveValue4
;Menu.c,93 :: 		case Time:
L_saveValue12:
;Menu.c,94 :: 		switch(subMenu){
	GOTO       L_saveValue13
;Menu.c,95 :: 		case TimeHour:
L_saveValue15:
;Menu.c,96 :: 		write_ds1307(0x02,editValue);
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,97 :: 		break;
	GOTO       L_saveValue14
;Menu.c,98 :: 		case TimeMinute:
L_saveValue16:
;Menu.c,99 :: 		write_ds1307(0x01,editValue);
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,100 :: 		break;
	GOTO       L_saveValue14
;Menu.c,101 :: 		}
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
;Menu.c,102 :: 		break;
	GOTO       L_saveValue4
;Menu.c,103 :: 		}
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
;Menu.c,104 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_checkKey:

;Menu.c,111 :: 		void checkKey(){
;Menu.c,115 :: 		do{
L_checkKey17:
;Menu.c,116 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey140
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey141
L__checkKey140:
	BSF        _cashedPortD+0, 7
L__checkKey141:
;Menu.c,117 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey142
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey143
L__checkKey142:
	BSF        _cashedPortD+0, 6
L__checkKey143:
;Menu.c,118 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey144
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey145
L__checkKey144:
	BSF        _cashedPortD+0, 5
L__checkKey145:
;Menu.c,119 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey146
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey147
L__checkKey146:
	BSF        _cashedPortD+0, 4
L__checkKey147:
;Menu.c,120 :: 		if(cashedPortD > 0)
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey20
;Menu.c,122 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,123 :: 		delay_ms(100);
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
;Menu.c,124 :: 		}
L_checkKey20:
;Menu.c,125 :: 		if(cMENU == ON){
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey22
;Menu.c,126 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,127 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey23
;Menu.c,128 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,129 :: 		}else{
	GOTO       L_checkKey24
L_checkKey23:
;Menu.c,130 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,131 :: 		}
L_checkKey24:
;Menu.c,132 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,133 :: 		if(crntMenu>OnOFFTime)
	MOVF       _crntMenu+0, 0
	SUBLW      7
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey25
;Menu.c,135 :: 		waitCount = 100;
	MOVLW      100
	MOVWF      _waitCount+0
	MOVLW      0
	MOVWF      _waitCount+1
;Menu.c,136 :: 		}
L_checkKey25:
;Menu.c,137 :: 		}
L_checkKey22:
;Menu.c,138 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey26
;Menu.c,140 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,141 :: 		}
L_checkKey26:
;Menu.c,142 :: 		switch(crntMenu)
	GOTO       L_checkKey27
;Menu.c,144 :: 		case None:
L_checkKey29:
;Menu.c,145 :: 		break;
	GOTO       L_checkKey28
;Menu.c,146 :: 		case Date:
L_checkKey30:
;Menu.c,147 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey31
;Menu.c,149 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,150 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,151 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,152 :: 		}
	GOTO       L_checkKey32
L_checkKey31:
;Menu.c,155 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey33
;Menu.c,157 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,158 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey148
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey148:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey34
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey34:
;Menu.c,159 :: 		}
L_checkKey33:
;Menu.c,160 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey35
;Menu.c,162 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,163 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey149
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey149:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey36
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey36:
;Menu.c,164 :: 		}
L_checkKey35:
;Menu.c,165 :: 		switch(subMenu)
	GOTO       L_checkKey37
;Menu.c,168 :: 		case DateDay:
L_checkKey39:
;Menu.c,169 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey40
;Menu.c,171 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,172 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,173 :: 		}
L_checkKey40:
;Menu.c,174 :: 		if(cPLUS == ON){
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey41
;Menu.c,175 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey150
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey150:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey42
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey42:
;Menu.c,176 :: 		}
L_checkKey41:
;Menu.c,177 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey43
;Menu.c,179 :: 		if(editValue == 0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey151
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey151:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey44
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey44:
;Menu.c,180 :: 		}
L_checkKey43:
;Menu.c,181 :: 		break;
	GOTO       L_checkKey38
;Menu.c,182 :: 		case DateMonth:
L_checkKey45:
;Menu.c,183 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey46
;Menu.c,185 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,186 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,187 :: 		}
L_checkKey46:
;Menu.c,188 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey47
;Menu.c,190 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey152
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey152:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey48
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey48:
;Menu.c,191 :: 		}
L_checkKey47:
;Menu.c,192 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey49
;Menu.c,194 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey153
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey153:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey50
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey50:
;Menu.c,195 :: 		}
L_checkKey49:
;Menu.c,197 :: 		break;
	GOTO       L_checkKey38
;Menu.c,198 :: 		case DateYear:
L_checkKey51:
;Menu.c,199 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey52
;Menu.c,201 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,202 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,203 :: 		}
L_checkKey52:
;Menu.c,204 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey53
;Menu.c,206 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey154
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey154:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey54
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey54:
;Menu.c,207 :: 		}
L_checkKey53:
;Menu.c,208 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey55
;Menu.c,210 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey155
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey155:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey56
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey56:
;Menu.c,211 :: 		}
L_checkKey55:
;Menu.c,213 :: 		break;
	GOTO       L_checkKey38
;Menu.c,214 :: 		case DateWeekDay:
L_checkKey57:
;Menu.c,215 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey58
;Menu.c,217 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,218 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,219 :: 		}
L_checkKey58:
;Menu.c,220 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey59
;Menu.c,222 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey156
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey156:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey60
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey60:
;Menu.c,223 :: 		}
L_checkKey59:
;Menu.c,224 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey61
;Menu.c,226 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey157
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey157:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey62
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey62:
;Menu.c,227 :: 		}
L_checkKey61:
;Menu.c,228 :: 		break;
	GOTO       L_checkKey38
;Menu.c,230 :: 		}
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
;Menu.c,231 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey135
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey135
	GOTO       L_checkKey65
L__checkKey135:
;Menu.c,233 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey66
;Menu.c,235 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,236 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,237 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,238 :: 		}
	GOTO       L_checkKey67
L_checkKey66:
;Menu.c,241 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,242 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,243 :: 		}
L_checkKey67:
;Menu.c,244 :: 		}
L_checkKey65:
;Menu.c,246 :: 		}
L_checkKey32:
;Menu.c,247 :: 		break;
	GOTO       L_checkKey28
;Menu.c,248 :: 		case Time:
L_checkKey68:
;Menu.c,249 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey69
;Menu.c,251 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,252 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,253 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,254 :: 		}
	GOTO       L_checkKey70
L_checkKey69:
;Menu.c,257 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey71
;Menu.c,259 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,260 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey158
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey158:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey72
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey72:
;Menu.c,261 :: 		}
L_checkKey71:
;Menu.c,262 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey73
;Menu.c,264 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,265 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey159
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey159:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey74
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey74:
;Menu.c,266 :: 		}
L_checkKey73:
;Menu.c,267 :: 		switch(subMenu)
	GOTO       L_checkKey75
;Menu.c,269 :: 		case TimeHour:
L_checkKey77:
;Menu.c,270 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey78
;Menu.c,272 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,273 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,274 :: 		}
L_checkKey78:
;Menu.c,275 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey79
;Menu.c,277 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey160
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey160:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey80
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey80:
;Menu.c,278 :: 		}
L_checkKey79:
;Menu.c,279 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey81
;Menu.c,281 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey161
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey161:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey82
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey82:
;Menu.c,282 :: 		}
L_checkKey81:
;Menu.c,283 :: 		break;
	GOTO       L_checkKey76
;Menu.c,284 :: 		case TimeMinute:
L_checkKey83:
;Menu.c,285 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey84
;Menu.c,287 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,288 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,289 :: 		}
L_checkKey84:
;Menu.c,290 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey85
;Menu.c,292 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey162
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey162:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey86
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey86:
;Menu.c,293 :: 		}
L_checkKey85:
;Menu.c,294 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey87
;Menu.c,296 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey163
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey163:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey88
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey88:
;Menu.c,297 :: 		}
L_checkKey87:
;Menu.c,298 :: 		break;
	GOTO       L_checkKey76
;Menu.c,299 :: 		}
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
;Menu.c,300 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey134
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey134
	GOTO       L_checkKey91
L__checkKey134:
;Menu.c,302 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,303 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,304 :: 		}
L_checkKey91:
;Menu.c,305 :: 		}
L_checkKey70:
;Menu.c,306 :: 		break;
	GOTO       L_checkKey28
;Menu.c,307 :: 		case   Voltage:
L_checkKey92:
;Menu.c,308 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey93
;Menu.c,310 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,311 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,312 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,313 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,314 :: 		}
	GOTO       L_checkKey94
L_checkKey93:
;Menu.c,317 :: 		switch(subMenu)
	GOTO       L_checkKey95
;Menu.c,319 :: 		case VoltageEnable:
L_checkKey97:
;Menu.c,320 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey98
;Menu.c,322 :: 		subMenu = VoltageHigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,323 :: 		}
L_checkKey98:
;Menu.c,324 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey133
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey133
	GOTO       L_checkKey101
L__checkKey133:
;Menu.c,326 :: 		isEnabled = !isEnabled;
	MOVLW      1
	XORWF      _editValue+0, 1
;Menu.c,327 :: 		if (isEnabled)
	BTFSS      _editValue+0, 0
	GOTO       L_checkKey102
;Menu.c,329 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,330 :: 		}
L_checkKey102:
;Menu.c,331 :: 		}
L_checkKey101:
;Menu.c,332 :: 		break;
	GOTO       L_checkKey96
;Menu.c,333 :: 		case VoltageHigh:
L_checkKey103:
;Menu.c,334 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey104
;Menu.c,336 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,337 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,338 :: 		}
L_checkKey104:
;Menu.c,339 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey105
;Menu.c,341 :: 		editValue += 2;
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
;Menu.c,342 :: 		if (editValue > 221)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey164
	MOVF       R1+0, 0
	SUBLW      221
L__checkKey164:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey106
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey106:
;Menu.c,344 :: 		}
L_checkKey105:
;Menu.c,345 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey107
;Menu.c,347 :: 		editValue += 2;
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
;Menu.c,348 :: 		if (editValue < 81) editValue = 221;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey165
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey165:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey108
	MOVLW      221
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey108:
;Menu.c,349 :: 		}
L_checkKey107:
;Menu.c,350 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey132
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey132
	GOTO       L_checkKey111
L__checkKey132:
;Menu.c,352 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,353 :: 		}
L_checkKey111:
;Menu.c,354 :: 		break;
	GOTO       L_checkKey96
;Menu.c,355 :: 		case VoltageLow:
L_checkKey112:
;Menu.c,356 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey113
;Menu.c,358 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,359 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,360 :: 		}
L_checkKey113:
;Menu.c,361 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey114
;Menu.c,363 :: 		editValue += 2;
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
;Menu.c,364 :: 		if (editValue > 221)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey166
	MOVF       R1+0, 0
	SUBLW      221
L__checkKey166:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey115
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey115:
;Menu.c,366 :: 		}
L_checkKey114:
;Menu.c,367 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey116
;Menu.c,369 :: 		editValue += 2;
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
;Menu.c,370 :: 		if (editValue < 81) editValue = 221;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey167
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey167:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey117
	MOVLW      221
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey117:
;Menu.c,371 :: 		}
L_checkKey116:
;Menu.c,372 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey131
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey131
	GOTO       L_checkKey120
L__checkKey131:
;Menu.c,374 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageLow),editValue,0);
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
;Menu.c,375 :: 		}
L_checkKey120:
;Menu.c,376 :: 		break;
	GOTO       L_checkKey96
;Menu.c,378 :: 		}
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
;Menu.c,379 :: 		}
L_checkKey94:
;Menu.c,380 :: 		break;
	GOTO       L_checkKey28
;Menu.c,381 :: 		case Current:
L_checkKey121:
;Menu.c,382 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey122
;Menu.c,384 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,385 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,386 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,387 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,388 :: 		}
	GOTO       L_checkKey123
L_checkKey122:
;Menu.c,391 :: 		}
L_checkKey123:
;Menu.c,392 :: 		break;
	GOTO       L_checkKey28
;Menu.c,393 :: 		case LDRVal:
L_checkKey124:
;Menu.c,394 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey125
;Menu.c,396 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,397 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,398 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,399 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,400 :: 		}
	GOTO       L_checkKey126
L_checkKey125:
;Menu.c,403 :: 		}
L_checkKey126:
;Menu.c,404 :: 		break;
	GOTO       L_checkKey28
;Menu.c,405 :: 		default:
L_checkKey127:
;Menu.c,406 :: 		waitCount = 100;
	MOVLW      100
	MOVWF      _waitCount+0
	MOVLW      0
	MOVWF      _waitCount+1
;Menu.c,407 :: 		break;
	GOTO       L_checkKey28
;Menu.c,408 :: 		}
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
	GOTO       L_checkKey127
L_checkKey28:
;Menu.c,409 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey128
;Menu.c,410 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,411 :: 		}
L_checkKey128:
;Menu.c,413 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey129:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey129
	DECFSZ     R12+0, 1
	GOTO       L_checkKey129
	DECFSZ     R11+0, 1
	GOTO       L_checkKey129
	NOP
	NOP
;Menu.c,414 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,415 :: 		if(waitCount>20){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey168
	MOVF       _waitCount+0, 0
	SUBLW      20
L__checkKey168:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey130
;Menu.c,416 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,417 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,418 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,419 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,420 :: 		}
L_checkKey130:
;Menu.c,423 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey17
;Menu.c,424 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,426 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
