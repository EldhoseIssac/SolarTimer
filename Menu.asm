
_codetxt_to_ramtxt:

;Menu.c,58 :: 		char * codetxt_to_ramtxt(const char* ctxt)
;Menu.c,62 :: 		for(i =0; ctxt[i] != '\0'; i++){
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
;Menu.c,63 :: 		txt[i] = ctxt[i];
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
;Menu.c,62 :: 		for(i =0; ctxt[i] != '\0'; i++){
	INCF       R3+0, 1
;Menu.c,64 :: 		}
	GOTO       L_codetxt_to_ramtxt0
L_codetxt_to_ramtxt1:
;Menu.c,65 :: 		txt[i] = '\0';
	MOVF       R3+0, 0
	ADDLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      FSR
	CLRF       INDF+0
;Menu.c,66 :: 		return txt;
	MOVLW      codetxt_to_ramtxt_txt_L0+0
	MOVWF      R0+0
;Menu.c,67 :: 		}
L_end_codetxt_to_ramtxt:
	RETURN
; end of _codetxt_to_ramtxt

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

_saveValue:

;Menu.c,83 :: 		void saveValue(){
;Menu.c,84 :: 		switch(crntMenu){
	GOTO       L_saveValue3
;Menu.c,85 :: 		case Date:
L_saveValue5:
;Menu.c,86 :: 		switch(subMenu){
	GOTO       L_saveValue6
;Menu.c,87 :: 		case DateDay:
L_saveValue8:
;Menu.c,88 :: 		write_ds1307(0x04,editValue);
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,89 :: 		break;
	GOTO       L_saveValue7
;Menu.c,90 :: 		case DateMonth:
L_saveValue9:
;Menu.c,91 :: 		write_ds1307(0x05,editValue);
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,92 :: 		break;
	GOTO       L_saveValue7
;Menu.c,93 :: 		case DateYear:
L_saveValue10:
;Menu.c,94 :: 		write_ds1307(0x06,editValue);
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,95 :: 		break;
	GOTO       L_saveValue7
;Menu.c,96 :: 		case DateWeekDay:
L_saveValue11:
;Menu.c,97 :: 		write_ds1307(0x03,editValue);
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,98 :: 		break;
	GOTO       L_saveValue7
;Menu.c,99 :: 		}
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
;Menu.c,100 :: 		break;
	GOTO       L_saveValue4
;Menu.c,101 :: 		case Time:
L_saveValue12:
;Menu.c,102 :: 		switch(subMenu){
	GOTO       L_saveValue13
;Menu.c,103 :: 		case TimeHour:
L_saveValue15:
;Menu.c,104 :: 		write_ds1307(0x02,editValue);
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,105 :: 		break;
	GOTO       L_saveValue14
;Menu.c,106 :: 		case TimeMinute:
L_saveValue16:
;Menu.c,107 :: 		write_ds1307(0x01,editValue);
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,108 :: 		break;
	GOTO       L_saveValue14
;Menu.c,109 :: 		}
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
;Menu.c,110 :: 		break;
	GOTO       L_saveValue4
;Menu.c,111 :: 		}
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
;Menu.c,112 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_checkKey:

;Menu.c,119 :: 		void checkKey(){
;Menu.c,123 :: 		do{
L_checkKey17:
;Menu.c,124 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey111
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey112
L__checkKey111:
	BSF        _cashedPortD+0, 7
L__checkKey112:
;Menu.c,125 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey113
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey114
L__checkKey113:
	BSF        _cashedPortD+0, 6
L__checkKey114:
;Menu.c,126 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey115
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey116
L__checkKey115:
	BSF        _cashedPortD+0, 5
L__checkKey116:
;Menu.c,127 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey117
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey118
L__checkKey117:
	BSF        _cashedPortD+0, 4
L__checkKey118:
;Menu.c,128 :: 		if(cashedPortD > 0)
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey20
;Menu.c,130 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,131 :: 		delay_ms(100);
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
;Menu.c,132 :: 		}
L_checkKey20:
;Menu.c,133 :: 		if(cMENU == ON){
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey22
;Menu.c,134 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,135 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey23
;Menu.c,136 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,137 :: 		}else{
	GOTO       L_checkKey24
L_checkKey23:
;Menu.c,138 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,139 :: 		}
L_checkKey24:
;Menu.c,140 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,141 :: 		if(crntMenu>OnOFFTime)
	MOVF       _crntMenu+0, 0
	SUBLW      7
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey25
;Menu.c,143 :: 		waitCount = 100;
	MOVLW      100
	MOVWF      _waitCount+0
	MOVLW      0
	MOVWF      _waitCount+1
;Menu.c,144 :: 		}
L_checkKey25:
;Menu.c,145 :: 		}
L_checkKey22:
;Menu.c,146 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey26
;Menu.c,148 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,149 :: 		}
L_checkKey26:
;Menu.c,150 :: 		switch(crntMenu)
	GOTO       L_checkKey27
;Menu.c,152 :: 		case None:
L_checkKey29:
;Menu.c,153 :: 		break;
	GOTO       L_checkKey28
;Menu.c,154 :: 		case Date:
L_checkKey30:
;Menu.c,155 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey31
;Menu.c,157 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,158 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,159 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,160 :: 		}
	GOTO       L_checkKey32
L_checkKey31:
;Menu.c,163 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey33
;Menu.c,165 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,166 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey119
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey119:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey34
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey34:
;Menu.c,167 :: 		}
L_checkKey33:
;Menu.c,168 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey35
;Menu.c,170 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,171 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey120
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey120:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey36
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey36:
;Menu.c,172 :: 		}
L_checkKey35:
;Menu.c,173 :: 		switch(subMenu)
	GOTO       L_checkKey37
;Menu.c,176 :: 		case DateDay:
L_checkKey39:
;Menu.c,177 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey40
;Menu.c,179 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,180 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,181 :: 		}
L_checkKey40:
;Menu.c,182 :: 		if(cPLUS == ON){
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey41
;Menu.c,183 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey121
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey121:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey42
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey42:
;Menu.c,184 :: 		}
L_checkKey41:
;Menu.c,185 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey43
;Menu.c,187 :: 		if(editValue == 0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey122
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey122:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey44
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey44:
;Menu.c,188 :: 		}
L_checkKey43:
;Menu.c,189 :: 		break;
	GOTO       L_checkKey38
;Menu.c,190 :: 		case DateMonth:
L_checkKey45:
;Menu.c,191 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey46
;Menu.c,193 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,194 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,195 :: 		}
L_checkKey46:
;Menu.c,196 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey47
;Menu.c,198 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey123
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey123:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey48
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey48:
;Menu.c,199 :: 		}
L_checkKey47:
;Menu.c,200 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey49
;Menu.c,202 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey124
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey124:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey50
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey50:
;Menu.c,203 :: 		}
L_checkKey49:
;Menu.c,205 :: 		break;
	GOTO       L_checkKey38
;Menu.c,206 :: 		case DateYear:
L_checkKey51:
;Menu.c,207 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey52
;Menu.c,209 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,210 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,211 :: 		}
L_checkKey52:
;Menu.c,212 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey53
;Menu.c,214 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey125
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey125:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey54
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey54:
;Menu.c,215 :: 		}
L_checkKey53:
;Menu.c,216 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey55
;Menu.c,218 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey126
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey126:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey56
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey56:
;Menu.c,219 :: 		}
L_checkKey55:
;Menu.c,221 :: 		break;
	GOTO       L_checkKey38
;Menu.c,222 :: 		case DateWeekDay:
L_checkKey57:
;Menu.c,223 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey58
;Menu.c,225 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,226 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,227 :: 		}
L_checkKey58:
;Menu.c,228 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey59
;Menu.c,230 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey127
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey127:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey60
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey60:
;Menu.c,231 :: 		}
L_checkKey59:
;Menu.c,232 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey61
;Menu.c,234 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey128
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey128:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey62
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey62:
;Menu.c,235 :: 		}
L_checkKey61:
;Menu.c,236 :: 		break;
	GOTO       L_checkKey38
;Menu.c,238 :: 		}
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
;Menu.c,239 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey106
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey106
	GOTO       L_checkKey65
L__checkKey106:
;Menu.c,241 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey66
;Menu.c,243 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,244 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,245 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,246 :: 		}
	GOTO       L_checkKey67
L_checkKey66:
;Menu.c,249 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,250 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,251 :: 		}
L_checkKey67:
;Menu.c,252 :: 		}
L_checkKey65:
;Menu.c,254 :: 		}
L_checkKey32:
;Menu.c,255 :: 		break;
	GOTO       L_checkKey28
;Menu.c,256 :: 		case Time:
L_checkKey68:
;Menu.c,257 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey69
;Menu.c,259 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,260 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,261 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,262 :: 		}
	GOTO       L_checkKey70
L_checkKey69:
;Menu.c,265 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey71
;Menu.c,267 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,268 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey129
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey129:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey72
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey72:
;Menu.c,269 :: 		}
L_checkKey71:
;Menu.c,270 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey73
;Menu.c,272 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,273 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey130
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey130:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey74
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey74:
;Menu.c,274 :: 		}
L_checkKey73:
;Menu.c,275 :: 		switch(subMenu)
	GOTO       L_checkKey75
;Menu.c,277 :: 		case TimeHour:
L_checkKey77:
;Menu.c,278 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey78
;Menu.c,280 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,281 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,282 :: 		}
L_checkKey78:
;Menu.c,283 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey79
;Menu.c,285 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey131
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey131:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey80
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey80:
;Menu.c,286 :: 		}
L_checkKey79:
;Menu.c,287 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey81
;Menu.c,289 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey132
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey132:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey82
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey82:
;Menu.c,290 :: 		}
L_checkKey81:
;Menu.c,291 :: 		break;
	GOTO       L_checkKey76
;Menu.c,292 :: 		case TimeMinute:
L_checkKey83:
;Menu.c,293 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey84
;Menu.c,295 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,296 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,297 :: 		}
L_checkKey84:
;Menu.c,298 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey85
;Menu.c,300 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey133
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey133:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey86
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey86:
;Menu.c,301 :: 		}
L_checkKey85:
;Menu.c,302 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey87
;Menu.c,304 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey134
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey134:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey88
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey88:
;Menu.c,305 :: 		}
L_checkKey87:
;Menu.c,306 :: 		break;
	GOTO       L_checkKey76
;Menu.c,307 :: 		}
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
;Menu.c,308 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey105
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey105
	GOTO       L_checkKey91
L__checkKey105:
;Menu.c,310 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,311 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,312 :: 		}
L_checkKey91:
;Menu.c,313 :: 		}
L_checkKey70:
;Menu.c,314 :: 		break;
	GOTO       L_checkKey28
;Menu.c,315 :: 		case   Voltage:
L_checkKey92:
;Menu.c,316 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey93
;Menu.c,318 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,319 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh Low"));
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
;Menu.c,320 :: 		editValue = voltHeigh();
	CALL       _voltHeigh+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,321 :: 		loadEnHeighLow(editValue,voltLow());
	CALL       _voltLow+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CALL       _loadEnHeighLow+0
;Menu.c,322 :: 		}
	GOTO       L_checkKey94
L_checkKey93:
;Menu.c,325 :: 		}
L_checkKey94:
;Menu.c,326 :: 		break;
	GOTO       L_checkKey28
;Menu.c,327 :: 		case Current:
L_checkKey95:
;Menu.c,328 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey96
;Menu.c,330 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,331 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp Heigh Low"));
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
;Menu.c,332 :: 		editValue = currHeigh();
	CALL       _currHeigh+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,333 :: 		loadEnHeighLow(editValue,currLow());
	CALL       _currLow+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CALL       _loadEnHeighLow+0
;Menu.c,334 :: 		}
	GOTO       L_checkKey97
L_checkKey96:
;Menu.c,337 :: 		}
L_checkKey97:
;Menu.c,338 :: 		break;
	GOTO       L_checkKey28
;Menu.c,339 :: 		case LDRVal:
L_checkKey98:
;Menu.c,340 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey99
;Menu.c,342 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,343 :: 		editValue = LDRHeigh();
	CALL       _LDRHeigh+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,344 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR Heigh Low"));
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
;Menu.c,345 :: 		loadEnHeighLow(editValue,LDRLow());
	CALL       _LDRLow+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	CALL       _loadEnHeighLow+0
;Menu.c,346 :: 		}
	GOTO       L_checkKey100
L_checkKey99:
;Menu.c,349 :: 		}
L_checkKey100:
;Menu.c,350 :: 		break;
	GOTO       L_checkKey28
;Menu.c,351 :: 		default:
L_checkKey101:
;Menu.c,352 :: 		waitCount = 100;
	MOVLW      100
	MOVWF      _waitCount+0
	MOVLW      0
	MOVWF      _waitCount+1
;Menu.c,353 :: 		break;
	GOTO       L_checkKey28
;Menu.c,354 :: 		}
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
	GOTO       L_checkKey95
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey98
	GOTO       L_checkKey101
L_checkKey28:
;Menu.c,355 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey102
;Menu.c,356 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,357 :: 		}
L_checkKey102:
;Menu.c,359 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey103:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey103
	DECFSZ     R12+0, 1
	GOTO       L_checkKey103
	DECFSZ     R11+0, 1
	GOTO       L_checkKey103
	NOP
	NOP
;Menu.c,360 :: 		if(waitCount>20){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey135
	MOVF       _waitCount+0, 0
	SUBLW      20
L__checkKey135:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey104
;Menu.c,361 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,362 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,363 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,364 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,365 :: 		}
L_checkKey104:
;Menu.c,368 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey17
;Menu.c,369 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,371 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
