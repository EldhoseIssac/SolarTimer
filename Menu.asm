
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

;Menu.c,113 :: 		void saveValue(){
;Menu.c,114 :: 		if (!isEdited){
	BTFSC      _isEdited+0, BitPos(_isEdited+0)
	GOTO       L_saveValue3
;Menu.c,115 :: 		return;
	GOTO       L_end_saveValue
;Menu.c,116 :: 		}
L_saveValue3:
;Menu.c,117 :: 		isEdited = 0;
	BCF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,118 :: 		switch(crntMenu){
	GOTO       L_saveValue4
;Menu.c,119 :: 		case None:
L_saveValue6:
;Menu.c,120 :: 		break;
	GOTO       L_saveValue5
;Menu.c,121 :: 		case Date:
L_saveValue7:
;Menu.c,122 :: 		switch(subMenu){
	GOTO       L_saveValue8
;Menu.c,123 :: 		case DateDay:
L_saveValue10:
;Menu.c,124 :: 		write_ds1307(0x04,editValue);
	MOVLW      4
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,125 :: 		break;
	GOTO       L_saveValue9
;Menu.c,126 :: 		case DateMonth:
L_saveValue11:
;Menu.c,127 :: 		write_ds1307(0x05,editValue);
	MOVLW      5
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,128 :: 		break;
	GOTO       L_saveValue9
;Menu.c,129 :: 		case DateYear:
L_saveValue12:
;Menu.c,130 :: 		write_ds1307(0x06,editValue);
	MOVLW      6
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,131 :: 		break;
	GOTO       L_saveValue9
;Menu.c,132 :: 		case DateWeekDay:
L_saveValue13:
;Menu.c,133 :: 		write_ds1307(0x03,editValue);
	MOVLW      3
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,134 :: 		break;
	GOTO       L_saveValue9
;Menu.c,135 :: 		}
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
;Menu.c,136 :: 		break;
	GOTO       L_saveValue5
;Menu.c,137 :: 		case Time:
L_saveValue14:
;Menu.c,138 :: 		switch(subMenu){
	GOTO       L_saveValue15
;Menu.c,139 :: 		case TimeHour:
L_saveValue17:
;Menu.c,140 :: 		write_ds1307(0x02,editValue);
	MOVLW      2
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,141 :: 		break;
	GOTO       L_saveValue16
;Menu.c,142 :: 		case TimeMinute:
L_saveValue18:
;Menu.c,143 :: 		write_ds1307(0x01,editValue);
	MOVLW      1
	MOVWF      FARG_write_ds1307_address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;Menu.c,144 :: 		break;
	GOTO       L_saveValue16
;Menu.c,145 :: 		}
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
;Menu.c,146 :: 		break;
	GOTO       L_saveValue5
;Menu.c,147 :: 		case Voltage:
L_saveValue19:
;Menu.c,148 :: 		switch(subMenu){
	GOTO       L_saveValue20
;Menu.c,149 :: 		case VoltageLow:
L_saveValue22:
;Menu.c,150 :: 		ee_write(EEPADDR_VoltageLow,editValue);
	MOVLW      4
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,151 :: 		break;
	GOTO       L_saveValue21
;Menu.c,152 :: 		case VoltageHigh:
L_saveValue23:
;Menu.c,153 :: 		ee_write(EEPADDR_VoltageHigh,editValue);
	MOVLW      2
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,154 :: 		break;
	GOTO       L_saveValue21
;Menu.c,155 :: 		}
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
;Menu.c,156 :: 		break;
	GOTO       L_saveValue5
;Menu.c,157 :: 		case Current:
L_saveValue24:
;Menu.c,158 :: 		switch(subMenu){
	GOTO       L_saveValue25
;Menu.c,159 :: 		case CurrentHeigh:
L_saveValue27:
;Menu.c,160 :: 		ee_write(EEPADDR_CurrentHeigh,editValue);
	MOVLW      6
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,161 :: 		break;
	GOTO       L_saveValue26
;Menu.c,162 :: 		case CurrentLow:
L_saveValue28:
;Menu.c,163 :: 		ee_write(EEPADDR_CurrentLow,editValue);
	MOVLW      8
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,164 :: 		break;
	GOTO       L_saveValue26
;Menu.c,165 :: 		}
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
;Menu.c,166 :: 		break;
	GOTO       L_saveValue5
;Menu.c,167 :: 		case LDRVal:
L_saveValue29:
;Menu.c,168 :: 		switch(subMenu){
	GOTO       L_saveValue30
;Menu.c,169 :: 		case LDRValLow:
L_saveValue32:
;Menu.c,170 :: 		ee_write(EEPADDR_LDRValLow,editValue);
	MOVLW      12
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,171 :: 		break;
	GOTO       L_saveValue31
;Menu.c,172 :: 		case LDRValHeigh:
L_saveValue33:
;Menu.c,173 :: 		ee_write(EEPADDR_LDRValHeigh,editValue);
	MOVLW      10
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,174 :: 		break;
	GOTO       L_saveValue31
;Menu.c,175 :: 		}
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
;Menu.c,176 :: 		break;
	GOTO       L_saveValue5
;Menu.c,177 :: 		default:
L_saveValue34:
;Menu.c,178 :: 		if ((crntMenu - OnOFFTimeDay1) % 2 == 0 ) {
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
	GOTO       L__saveValue289
	MOVLW      0
	XORWF      R0+0, 0
L__saveValue289:
	BTFSS      STATUS+0, 2
	GOTO       L_saveValue35
;Menu.c,179 :: 		EEPROM_write(timeEEAddr,editValue);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Menu.c,180 :: 		}
	GOTO       L_saveValue36
L_saveValue35:
;Menu.c,183 :: 		if (subMenu == OnOFFTimeOnHr || subMenu == OnOFFTimeOnMin) {
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue271
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue271
	GOTO       L_saveValue39
L__saveValue271:
;Menu.c,184 :: 		ee_write(timeEEAddr+1,editValue);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,185 :: 		}
	GOTO       L_saveValue40
L_saveValue39:
;Menu.c,186 :: 		else if (subMenu == OnOFFTimeOffHr || subMenu == OnOFFTimeOffMin)
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue270
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue270
	GOTO       L_saveValue43
L__saveValue270:
;Menu.c,188 :: 		ee_write(timeEEAddr+3,editValue);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,189 :: 		}
L_saveValue43:
L_saveValue40:
;Menu.c,190 :: 		}
L_saveValue36:
;Menu.c,191 :: 		break;
	GOTO       L_saveValue5
;Menu.c,193 :: 		}
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
;Menu.c,194 :: 		delay_ms(100);
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
;Menu.c,195 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_OnOFFTimeDayDisplay:

;Menu.c,214 :: 		void OnOFFTimeDayDisplay(){
;Menu.c,215 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_OnOFFTimeDayDisplay45
;Menu.c,218 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,219 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,220 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,221 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,222 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,223 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,224 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,225 :: 		editValue = EEPROM_Read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,226 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,227 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,228 :: 		if ((crntMenu - OnOFFTimeDay1) % 2 == 1 )
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
	GOTO       L__OnOFFTimeDayDisplay291
	MOVLW      1
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay291:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay46
;Menu.c,230 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,231 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,232 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,233 :: 		}
L_OnOFFTimeDayDisplay46:
;Menu.c,235 :: 		}
	GOTO       L_OnOFFTimeDayDisplay47
L_OnOFFTimeDayDisplay45:
;Menu.c,238 :: 		if ((crntMenu - OnOFFTimeDay1) % 2 == 0 ) {
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
	GOTO       L__OnOFFTimeDayDisplay292
	MOVLW      0
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay292:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay48
;Menu.c,240 :: 		if (cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay49
;Menu.c,242 :: 		subMenu +=2;
	MOVLW      2
	ADDWF      _subMenu+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _subMenu+0
;Menu.c,243 :: 		tmp++;
	INCF       _tmp+0, 1
;Menu.c,244 :: 		if (subMenu>OnOFFTimeDaySat) {
	MOVF       R1+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay50
;Menu.c,245 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,246 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,247 :: 		}
L_OnOFFTimeDayDisplay50:
;Menu.c,248 :: 		}
L_OnOFFTimeDayDisplay49:
;Menu.c,249 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay273
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay273
	GOTO       L_OnOFFTimeDayDisplay53
L__OnOFFTimeDayDisplay273:
;Menu.c,251 :: 		editValue = editValue ^ (1<<tmp);
	MOVF       _tmp+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__OnOFFTimeDayDisplay293:
	BTFSC      STATUS+0, 2
	GOTO       L__OnOFFTimeDayDisplay294
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__OnOFFTimeDayDisplay293
L__OnOFFTimeDayDisplay294:
	MOVF       R0+0, 0
	XORWF      _editValue+0, 1
	MOVF       R0+1, 0
	XORWF      _editValue+1, 1
;Menu.c,252 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,253 :: 		}
L_OnOFFTimeDayDisplay53:
;Menu.c,255 :: 		}
	GOTO       L_OnOFFTimeDayDisplay54
L_OnOFFTimeDayDisplay48:
;Menu.c,258 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay55
;Menu.c,260 :: 		tmp++;
	INCF       _tmp+0, 1
;Menu.c,261 :: 		if((tmp & 0x0F )>9) tmp += 6;
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay56
	MOVLW      6
	ADDWF      _tmp+0, 1
L_OnOFFTimeDayDisplay56:
;Menu.c,262 :: 		}
L_OnOFFTimeDayDisplay55:
;Menu.c,263 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay57
;Menu.c,265 :: 		tmp--;
	DECF       _tmp+0, 1
;Menu.c,266 :: 		if((tmp & 0x0F )>9) tmp -= 6;
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay58
	MOVLW      6
	SUBWF      _tmp+0, 1
L_OnOFFTimeDayDisplay58:
;Menu.c,267 :: 		}
L_OnOFFTimeDayDisplay57:
;Menu.c,268 :: 		switch (subMenu) {
	GOTO       L_OnOFFTimeDayDisplay59
;Menu.c,270 :: 		case OnOFFTimeOnHr:
L_OnOFFTimeDayDisplay61:
;Menu.c,271 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay62
;Menu.c,273 :: 		subMenu = OnOFFTimeOnMin;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,274 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,275 :: 		}
L_OnOFFTimeDayDisplay62:
;Menu.c,277 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay63
;Menu.c,279 :: 		if (tmp > 0x23) {
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay64
;Menu.c,280 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,281 :: 		}
L_OnOFFTimeDayDisplay64:
;Menu.c,282 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,284 :: 		}
L_OnOFFTimeDayDisplay63:
;Menu.c,285 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay65
;Menu.c,287 :: 		if (!tmp) {
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay66
;Menu.c,288 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      _tmp+0
;Menu.c,289 :: 		}
L_OnOFFTimeDayDisplay66:
;Menu.c,290 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,291 :: 		}
L_OnOFFTimeDayDisplay65:
;Menu.c,292 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,293 :: 		case OnOFFTimeOnMin:
L_OnOFFTimeDayDisplay67:
;Menu.c,294 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay68
;Menu.c,296 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,297 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,298 :: 		tmp = Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
;Menu.c,299 :: 		}
L_OnOFFTimeDayDisplay68:
;Menu.c,300 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay69
;Menu.c,303 :: 		if (tmp > 0x59)
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay70
;Menu.c,305 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,306 :: 		}
L_OnOFFTimeDayDisplay70:
;Menu.c,307 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,309 :: 		}
L_OnOFFTimeDayDisplay69:
;Menu.c,310 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay71
;Menu.c,312 :: 		if (!tmp)
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay72
;Menu.c,314 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      _tmp+0
;Menu.c,315 :: 		}
L_OnOFFTimeDayDisplay72:
;Menu.c,316 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,317 :: 		}
L_OnOFFTimeDayDisplay71:
;Menu.c,318 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,319 :: 		case OnOFFTimeOffHr:
L_OnOFFTimeDayDisplay73:
;Menu.c,320 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay74
;Menu.c,322 :: 		subMenu = OnOFFTimeOffMin;
	MOVLW      14
	MOVWF      _subMenu+0
;Menu.c,323 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,324 :: 		}
L_OnOFFTimeDayDisplay74:
;Menu.c,325 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay75
;Menu.c,327 :: 		if (tmp > 0x23) {
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay76
;Menu.c,328 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,329 :: 		}
L_OnOFFTimeDayDisplay76:
;Menu.c,330 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,332 :: 		}
L_OnOFFTimeDayDisplay75:
;Menu.c,333 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay77
;Menu.c,335 :: 		if (!tmp) {
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay78
;Menu.c,336 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      _tmp+0
;Menu.c,337 :: 		}
L_OnOFFTimeDayDisplay78:
;Menu.c,338 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,339 :: 		}
L_OnOFFTimeDayDisplay77:
;Menu.c,340 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,341 :: 		case OnOFFTimeOffMin:
L_OnOFFTimeDayDisplay79:
;Menu.c,342 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay80
;Menu.c,344 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,345 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,346 :: 		tmp =  Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
;Menu.c,348 :: 		}
L_OnOFFTimeDayDisplay80:
;Menu.c,349 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay81
;Menu.c,352 :: 		if (tmp > 0x59)
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay82
;Menu.c,354 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,355 :: 		}
L_OnOFFTimeDayDisplay82:
;Menu.c,356 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,358 :: 		}
L_OnOFFTimeDayDisplay81:
;Menu.c,359 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay83
;Menu.c,361 :: 		if (!tmp)
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay84
;Menu.c,363 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      _tmp+0
;Menu.c,364 :: 		}
L_OnOFFTimeDayDisplay84:
;Menu.c,365 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,366 :: 		}
L_OnOFFTimeDayDisplay83:
;Menu.c,368 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,369 :: 		}
L_OnOFFTimeDayDisplay59:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay61
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay67
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay73
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay79
L_OnOFFTimeDayDisplay60:
;Menu.c,370 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay272
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay272
	GOTO       L_OnOFFTimeDayDisplay87
L__OnOFFTimeDayDisplay272:
;Menu.c,372 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,373 :: 		}
L_OnOFFTimeDayDisplay87:
;Menu.c,374 :: 		}
L_OnOFFTimeDayDisplay54:
;Menu.c,377 :: 		}
L_OnOFFTimeDayDisplay47:
;Menu.c,379 :: 		}
L_end_OnOFFTimeDayDisplay:
	RETURN
; end of _OnOFFTimeDayDisplay

_checkKey:

;Menu.c,381 :: 		void checkKey(){
;Menu.c,384 :: 		timeEEAddr =30 ;              //EEPADDR_OnOFFTimeDay1-5
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,385 :: 		do{
L_checkKey88:
;Menu.c,386 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey296
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey297
L__checkKey296:
	BSF        _cashedPortD+0, 7
L__checkKey297:
;Menu.c,387 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey298
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey299
L__checkKey298:
	BSF        _cashedPortD+0, 6
L__checkKey299:
;Menu.c,388 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey300
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey301
L__checkKey300:
	BSF        _cashedPortD+0, 5
L__checkKey301:
;Menu.c,389 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey302
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey303
L__checkKey302:
	BSF        _cashedPortD+0, 4
L__checkKey303:
;Menu.c,393 :: 		if(cashedPortD < 0xF0)
	MOVLW      240
	SUBWF      _cashedPortD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey91
;Menu.c,397 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,398 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey92:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey92
	DECFSZ     R12+0, 1
	GOTO       L_checkKey92
	DECFSZ     R11+0, 1
	GOTO       L_checkKey92
	NOP
;Menu.c,399 :: 		}
L_checkKey91:
;Menu.c,400 :: 		if(cMENU == ON){
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey93
;Menu.c,401 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,402 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey94
;Menu.c,403 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,404 :: 		}else{
	GOTO       L_checkKey95
L_checkKey94:
;Menu.c,405 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,406 :: 		}
L_checkKey95:
;Menu.c,407 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,408 :: 		if(crntMenu > OnOFFTime8)
	MOVF       _crntMenu+0, 0
	SUBLW      21
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey96
;Menu.c,410 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,411 :: 		}
L_checkKey96:
;Menu.c,412 :: 		}
L_checkKey93:
;Menu.c,413 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey97
;Menu.c,415 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,416 :: 		}
L_checkKey97:
;Menu.c,417 :: 		switch(crntMenu)
	GOTO       L_checkKey98
;Menu.c,419 :: 		case None:
L_checkKey100:
;Menu.c,420 :: 		break;
	GOTO       L_checkKey99
;Menu.c,421 :: 		case Date:
L_checkKey101:
;Menu.c,422 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey102
;Menu.c,424 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,425 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,426 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,427 :: 		}
	GOTO       L_checkKey103
L_checkKey102:
;Menu.c,430 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey104
;Menu.c,432 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,433 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey304
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey304:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey105
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey105:
;Menu.c,434 :: 		}
L_checkKey104:
;Menu.c,435 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey106
;Menu.c,437 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,438 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey305
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey305:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey107
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey107:
;Menu.c,439 :: 		}
L_checkKey106:
;Menu.c,440 :: 		switch(subMenu)
	GOTO       L_checkKey108
;Menu.c,443 :: 		case DateDay:
L_checkKey110:
;Menu.c,444 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey111
;Menu.c,446 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,447 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,448 :: 		}
L_checkKey111:
;Menu.c,449 :: 		if(cPLUS == ON){
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey112
;Menu.c,450 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey306
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey306:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey113
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey113:
;Menu.c,451 :: 		}
L_checkKey112:
;Menu.c,452 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey114
;Menu.c,454 :: 		if(editValue == 0x0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey307
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey307:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey115
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey115:
;Menu.c,455 :: 		}
L_checkKey114:
;Menu.c,456 :: 		break;
	GOTO       L_checkKey109
;Menu.c,457 :: 		case DateMonth:
L_checkKey116:
;Menu.c,458 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey117
;Menu.c,460 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,461 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,462 :: 		}
L_checkKey117:
;Menu.c,463 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey118
;Menu.c,465 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey308
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey308:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey119
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey119:
;Menu.c,466 :: 		}
L_checkKey118:
;Menu.c,467 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey120
;Menu.c,469 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey309
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey309:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey121
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey121:
;Menu.c,470 :: 		}
L_checkKey120:
;Menu.c,472 :: 		break;
	GOTO       L_checkKey109
;Menu.c,473 :: 		case DateYear:
L_checkKey122:
;Menu.c,474 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey123
;Menu.c,476 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,477 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,478 :: 		}
L_checkKey123:
;Menu.c,479 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey124
;Menu.c,481 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey310
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey310:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey125
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey125:
;Menu.c,482 :: 		}
L_checkKey124:
;Menu.c,483 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey126
;Menu.c,485 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey311
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey311:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey127
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey127:
;Menu.c,486 :: 		}
L_checkKey126:
;Menu.c,488 :: 		break;
	GOTO       L_checkKey109
;Menu.c,489 :: 		case DateWeekDay:
L_checkKey128:
;Menu.c,490 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey129
;Menu.c,492 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,493 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,494 :: 		}
L_checkKey129:
;Menu.c,495 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey130
;Menu.c,497 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey312
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey312:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey131
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey131:
;Menu.c,498 :: 		}
L_checkKey130:
;Menu.c,499 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey132
;Menu.c,501 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey313
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey313:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey133
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey133:
;Menu.c,502 :: 		}
L_checkKey132:
;Menu.c,503 :: 		break;
	GOTO       L_checkKey109
;Menu.c,505 :: 		}
L_checkKey108:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey110
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey116
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey122
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey128
L_checkKey109:
;Menu.c,506 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey285
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey285
	GOTO       L_checkKey136
L__checkKey285:
;Menu.c,508 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey137
;Menu.c,510 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,511 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,512 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,513 :: 		}
	GOTO       L_checkKey138
L_checkKey137:
;Menu.c,516 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,517 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,518 :: 		}
L_checkKey138:
;Menu.c,519 :: 		}
L_checkKey136:
;Menu.c,521 :: 		}
L_checkKey103:
;Menu.c,522 :: 		break;
	GOTO       L_checkKey99
;Menu.c,523 :: 		case Time:
L_checkKey139:
;Menu.c,524 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey140
;Menu.c,526 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,527 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,528 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,529 :: 		}
	GOTO       L_checkKey141
L_checkKey140:
;Menu.c,532 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey142
;Menu.c,534 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,535 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey314
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey314:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey143
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey143:
;Menu.c,536 :: 		}
L_checkKey142:
;Menu.c,537 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey144
;Menu.c,539 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,540 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey315
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey315:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey145
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey145:
;Menu.c,541 :: 		}
L_checkKey144:
;Menu.c,542 :: 		switch(subMenu)
	GOTO       L_checkKey146
;Menu.c,544 :: 		case TimeHour:
L_checkKey148:
;Menu.c,545 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey149
;Menu.c,547 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,548 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,549 :: 		}
L_checkKey149:
;Menu.c,550 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey150
;Menu.c,552 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey316
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey316:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey151
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey151:
;Menu.c,553 :: 		}
L_checkKey150:
;Menu.c,554 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey152
;Menu.c,556 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey317
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey317:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey153
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey153:
;Menu.c,557 :: 		}
L_checkKey152:
;Menu.c,558 :: 		break;
	GOTO       L_checkKey147
;Menu.c,559 :: 		case TimeMinute:
L_checkKey154:
;Menu.c,560 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey155
;Menu.c,562 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,563 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,564 :: 		}
L_checkKey155:
;Menu.c,565 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey156
;Menu.c,567 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey318
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey318:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey157
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey157:
;Menu.c,568 :: 		}
L_checkKey156:
;Menu.c,569 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey158
;Menu.c,571 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey319
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey319:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey159
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey159:
;Menu.c,572 :: 		}
L_checkKey158:
;Menu.c,573 :: 		break;
	GOTO       L_checkKey147
;Menu.c,574 :: 		}
L_checkKey146:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey148
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey154
L_checkKey147:
;Menu.c,575 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey284
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey284
	GOTO       L_checkKey162
L__checkKey284:
;Menu.c,577 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,578 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,579 :: 		}
L_checkKey162:
;Menu.c,580 :: 		}
L_checkKey141:
;Menu.c,581 :: 		break;
	GOTO       L_checkKey99
;Menu.c,582 :: 		case   Voltage:
L_checkKey163:
;Menu.c,583 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey164
;Menu.c,585 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,586 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,587 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,588 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,589 :: 		}
	GOTO       L_checkKey165
L_checkKey164:
;Menu.c,592 :: 		switch(subMenu)
	GOTO       L_checkKey166
;Menu.c,594 :: 		case VoltageEnable:
L_checkKey168:
;Menu.c,595 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey169
;Menu.c,597 :: 		subMenu = VoltageHigh;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,598 :: 		}
L_checkKey169:
;Menu.c,599 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey283
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey283
	GOTO       L_checkKey172
L__checkKey283:
;Menu.c,601 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,602 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,603 :: 		}
L_checkKey172:
;Menu.c,604 :: 		break;
	GOTO       L_checkKey167
;Menu.c,605 :: 		case VoltageHigh:
L_checkKey173:
;Menu.c,606 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey174
;Menu.c,608 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,609 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,610 :: 		}
L_checkKey174:
;Menu.c,611 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey175
;Menu.c,613 :: 		editValue += 2;
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
;Menu.c,614 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey320
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey320:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey176
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey176:
;Menu.c,616 :: 		}
L_checkKey175:
;Menu.c,617 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey177
;Menu.c,619 :: 		editValue -= 2;
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
;Menu.c,620 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey321
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey321:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey178
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey178:
;Menu.c,621 :: 		}
L_checkKey177:
;Menu.c,622 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey282
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey282
	GOTO       L_checkKey181
L__checkKey282:
;Menu.c,624 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,625 :: 		}
L_checkKey181:
;Menu.c,626 :: 		break;
	GOTO       L_checkKey167
;Menu.c,627 :: 		case VoltageLow:
L_checkKey182:
;Menu.c,628 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey183
;Menu.c,630 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,631 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,632 :: 		}
L_checkKey183:
;Menu.c,633 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey184
;Menu.c,635 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,636 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey322
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey322:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey185
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey185:
;Menu.c,638 :: 		}
L_checkKey184:
;Menu.c,639 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey186
;Menu.c,641 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,642 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey323
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey323:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey187
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey187:
;Menu.c,643 :: 		}
L_checkKey186:
;Menu.c,644 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey281
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey281
	GOTO       L_checkKey190
L__checkKey281:
;Menu.c,646 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
;Menu.c,647 :: 		}
L_checkKey190:
;Menu.c,648 :: 		break;
	GOTO       L_checkKey167
;Menu.c,650 :: 		}
L_checkKey166:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey168
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey173
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey182
L_checkKey167:
;Menu.c,651 :: 		}
L_checkKey165:
;Menu.c,652 :: 		break;
	GOTO       L_checkKey99
;Menu.c,653 :: 		case Current:
L_checkKey191:
;Menu.c,654 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey192
;Menu.c,656 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,657 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,658 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,659 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,660 :: 		}
	GOTO       L_checkKey193
L_checkKey192:
;Menu.c,663 :: 		switch(subMenu)
	GOTO       L_checkKey194
;Menu.c,665 :: 		case CurrentEnable:
L_checkKey196:
;Menu.c,666 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey197
;Menu.c,668 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,669 :: 		}
L_checkKey197:
;Menu.c,670 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey280
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey280
	GOTO       L_checkKey200
L__checkKey280:
;Menu.c,672 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,673 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,675 :: 		}
L_checkKey200:
;Menu.c,676 :: 		break;
	GOTO       L_checkKey195
;Menu.c,677 :: 		case CurrentHeigh:
L_checkKey201:
;Menu.c,678 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey202
;Menu.c,680 :: 		subMenu = CurrentLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,681 :: 		editValue =  ee_read(EEPADDR_CurrentLow);
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,682 :: 		}
L_checkKey202:
;Menu.c,683 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey203
;Menu.c,685 :: 		editValue += 2;
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
;Menu.c,686 :: 		if (editValue > 201)   editValue = 11;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey324
	MOVF       R1+0, 0
	SUBLW      201
L__checkKey324:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey204
	MOVLW      11
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey204:
;Menu.c,688 :: 		}
L_checkKey203:
;Menu.c,689 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey205
;Menu.c,691 :: 		editValue -= 2;
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
;Menu.c,692 :: 		if (editValue < 11) editValue = 201;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey325
	MOVLW      11
	SUBWF      R1+0, 0
L__checkKey325:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey206
	MOVLW      201
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey206:
;Menu.c,693 :: 		}
L_checkKey205:
;Menu.c,694 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey279
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey279
	GOTO       L_checkKey209
L__checkKey279:
;Menu.c,696 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,697 :: 		}
L_checkKey209:
;Menu.c,698 :: 		break;
	GOTO       L_checkKey195
;Menu.c,699 :: 		case CurrentLow:
L_checkKey210:
;Menu.c,700 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey211
;Menu.c,702 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,703 :: 		editValue =  ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,704 :: 		}
L_checkKey211:
;Menu.c,705 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey212
;Menu.c,707 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,708 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey326
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey326:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey213
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey213:
;Menu.c,710 :: 		}
L_checkKey212:
;Menu.c,711 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey214
;Menu.c,713 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,714 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey327
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey327:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey215
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey215:
;Menu.c,715 :: 		}
L_checkKey214:
;Menu.c,716 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey278
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey278
	GOTO       L_checkKey218
L__checkKey278:
;Menu.c,718 :: 		loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
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
;Menu.c,719 :: 		}
L_checkKey218:
;Menu.c,720 :: 		break;
	GOTO       L_checkKey195
;Menu.c,722 :: 		}
L_checkKey194:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey196
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey201
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey210
L_checkKey195:
;Menu.c,723 :: 		}
L_checkKey193:
;Menu.c,724 :: 		break;
	GOTO       L_checkKey99
;Menu.c,725 :: 		case LDRVal:
L_checkKey219:
;Menu.c,726 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey220
;Menu.c,728 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,729 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,730 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,731 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,732 :: 		}
	GOTO       L_checkKey221
L_checkKey220:
;Menu.c,735 :: 		switch(subMenu)
	GOTO       L_checkKey222
;Menu.c,737 :: 		case LDRValEnable:
L_checkKey224:
;Menu.c,738 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey225
;Menu.c,740 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,741 :: 		}
L_checkKey225:
;Menu.c,742 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey277
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey277
	GOTO       L_checkKey228
L__checkKey277:
;Menu.c,744 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,745 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,746 :: 		}
L_checkKey228:
;Menu.c,747 :: 		break;
	GOTO       L_checkKey223
;Menu.c,748 :: 		case LDRValHeigh:
L_checkKey229:
;Menu.c,749 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey230
;Menu.c,751 :: 		subMenu = LDRValLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,752 :: 		editValue =  ee_read(EEPADDR_LDRValLow);
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,753 :: 		}
L_checkKey230:
;Menu.c,754 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey231
;Menu.c,756 :: 		editValue += 2;
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
;Menu.c,757 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey328
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey328:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey232
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey232:
;Menu.c,759 :: 		}
L_checkKey231:
;Menu.c,760 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey233
;Menu.c,762 :: 		editValue -= 2;
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
;Menu.c,763 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey329
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey329:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey234
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey234:
;Menu.c,764 :: 		}
L_checkKey233:
;Menu.c,765 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey276
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey276
	GOTO       L_checkKey237
L__checkKey276:
;Menu.c,767 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,768 :: 		}
L_checkKey237:
;Menu.c,769 :: 		break;
	GOTO       L_checkKey223
;Menu.c,770 :: 		case LDRValLow:
L_checkKey238:
;Menu.c,771 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey239
;Menu.c,773 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,774 :: 		editValue =  ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,775 :: 		}
L_checkKey239:
;Menu.c,776 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey240
;Menu.c,778 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,779 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey330
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey330:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey241
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey241:
;Menu.c,781 :: 		}
L_checkKey240:
;Menu.c,782 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey242
;Menu.c,784 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,785 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey331
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey331:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey243
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey243:
;Menu.c,786 :: 		}
L_checkKey242:
;Menu.c,787 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey275
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey275
	GOTO       L_checkKey246
L__checkKey275:
;Menu.c,789 :: 		loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
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
;Menu.c,790 :: 		}
L_checkKey246:
;Menu.c,791 :: 		break;
	GOTO       L_checkKey223
;Menu.c,793 :: 		}
L_checkKey222:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey224
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey229
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey238
L_checkKey223:
;Menu.c,794 :: 		}
L_checkKey221:
;Menu.c,795 :: 		break;
	GOTO       L_checkKey99
;Menu.c,796 :: 		case OnOFFTimeDay1:
L_checkKey247:
;Menu.c,797 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay1;
	MOVLW      20
	MOVWF      _timeEEAddr+0
;Menu.c,798 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,799 :: 		break;
	GOTO       L_checkKey99
;Menu.c,800 :: 		case OnOFFTime1:
L_checkKey248:
;Menu.c,801 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay1;
	MOVLW      20
	MOVWF      _timeEEAddr+0
;Menu.c,802 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,803 :: 		break;
	GOTO       L_checkKey99
;Menu.c,804 :: 		case OnOFFTimeDay2:
L_checkKey249:
;Menu.c,805 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay2;
	MOVLW      25
	MOVWF      _timeEEAddr+0
;Menu.c,806 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,807 :: 		break;
	GOTO       L_checkKey99
;Menu.c,808 :: 		case OnOFFTime2:
L_checkKey250:
;Menu.c,809 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay2;
	MOVLW      25
	MOVWF      _timeEEAddr+0
;Menu.c,810 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,811 :: 		break;
	GOTO       L_checkKey99
;Menu.c,812 :: 		case OnOFFTimeDay3:
L_checkKey251:
;Menu.c,813 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay3;
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,814 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,815 :: 		break;
	GOTO       L_checkKey99
;Menu.c,816 :: 		case OnOFFTime3:
L_checkKey252:
;Menu.c,817 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay3;
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,818 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,819 :: 		break;
	GOTO       L_checkKey99
;Menu.c,820 :: 		case OnOFFTimeDay4:
L_checkKey253:
;Menu.c,821 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay4;
	MOVLW      35
	MOVWF      _timeEEAddr+0
;Menu.c,822 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,823 :: 		break;
	GOTO       L_checkKey99
;Menu.c,824 :: 		case OnOFFTime4:
L_checkKey254:
;Menu.c,825 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay4;
	MOVLW      35
	MOVWF      _timeEEAddr+0
;Menu.c,826 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,827 :: 		break;
	GOTO       L_checkKey99
;Menu.c,828 :: 		case OnOFFTimeDay5:
L_checkKey255:
;Menu.c,829 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay5;
	MOVLW      40
	MOVWF      _timeEEAddr+0
;Menu.c,830 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,831 :: 		break;
	GOTO       L_checkKey99
;Menu.c,832 :: 		case OnOFFTime5:
L_checkKey256:
;Menu.c,833 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay5;
	MOVLW      40
	MOVWF      _timeEEAddr+0
;Menu.c,834 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,835 :: 		break;
	GOTO       L_checkKey99
;Menu.c,836 :: 		case OnOFFTimeDay6:
L_checkKey257:
;Menu.c,837 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay6;
	MOVLW      45
	MOVWF      _timeEEAddr+0
;Menu.c,838 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,839 :: 		break;
	GOTO       L_checkKey99
;Menu.c,840 :: 		case OnOFFTime6:
L_checkKey258:
;Menu.c,841 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay6;
	MOVLW      45
	MOVWF      _timeEEAddr+0
;Menu.c,842 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,843 :: 		break;
	GOTO       L_checkKey99
;Menu.c,844 :: 		case OnOFFTimeDay7:
L_checkKey259:
;Menu.c,845 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay7;
	MOVLW      50
	MOVWF      _timeEEAddr+0
;Menu.c,846 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,847 :: 		break;
	GOTO       L_checkKey99
;Menu.c,848 :: 		case OnOFFTime7:
L_checkKey260:
;Menu.c,849 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay7;
	MOVLW      50
	MOVWF      _timeEEAddr+0
;Menu.c,850 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,851 :: 		break;
	GOTO       L_checkKey99
;Menu.c,852 :: 		case OnOFFTimeDay8:
L_checkKey261:
;Menu.c,853 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay8;
	MOVLW      55
	MOVWF      _timeEEAddr+0
;Menu.c,854 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,855 :: 		break;
	GOTO       L_checkKey99
;Menu.c,856 :: 		case OnOFFTime8:
L_checkKey262:
;Menu.c,857 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay8;
	MOVLW      55
	MOVWF      _timeEEAddr+0
;Menu.c,858 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,859 :: 		break;
	GOTO       L_checkKey99
;Menu.c,861 :: 		default:
L_checkKey263:
;Menu.c,862 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,863 :: 		break;
	GOTO       L_checkKey99
;Menu.c,864 :: 		}
L_checkKey98:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey100
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey101
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey139
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey163
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey191
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey219
	MOVF       _crntMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey247
	MOVF       _crntMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey248
	MOVF       _crntMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey249
	MOVF       _crntMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey250
	MOVF       _crntMenu+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey251
	MOVF       _crntMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey252
	MOVF       _crntMenu+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey253
	MOVF       _crntMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey254
	MOVF       _crntMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey255
	MOVF       _crntMenu+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey256
	MOVF       _crntMenu+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey257
	MOVF       _crntMenu+0, 0
	XORLW      17
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey258
	MOVF       _crntMenu+0, 0
	XORLW      18
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey259
	MOVF       _crntMenu+0, 0
	XORLW      19
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey260
	MOVF       _crntMenu+0, 0
	XORLW      20
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey261
	MOVF       _crntMenu+0, 0
	XORLW      21
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey262
	GOTO       L_checkKey263
L_checkKey99:
;Menu.c,865 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey264
;Menu.c,866 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,867 :: 		}
L_checkKey264:
;Menu.c,868 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey274
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey274
	GOTO       L_checkKey267
L__checkKey274:
;Menu.c,870 :: 		isEdited = 1;
	BSF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,871 :: 		}
L_checkKey267:
;Menu.c,873 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey268:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey268
	DECFSZ     R12+0, 1
	GOTO       L_checkKey268
	DECFSZ     R11+0, 1
	GOTO       L_checkKey268
	NOP
;Menu.c,874 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,875 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey332
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey332:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey269
;Menu.c,876 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,877 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,878 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,879 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,880 :: 		}
L_checkKey269:
;Menu.c,883 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey88
;Menu.c,884 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,886 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
