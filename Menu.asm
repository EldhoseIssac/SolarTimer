
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
;Menu.c,178 :: 		if ((crntMenu - OnOFFTimeDay) % 2 == 0 ) {
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
;Menu.c,223 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,224 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,225 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,226 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,227 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,228 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,229 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,230 :: 		editValue = EEPROM_Read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,231 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,232 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,233 :: 		if ((crntMenu - OnOFFTimeDay) % 2 == 1 )
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
;Menu.c,235 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,236 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,237 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,238 :: 		}
L_OnOFFTimeDayDisplay46:
;Menu.c,240 :: 		}
	GOTO       L_OnOFFTimeDayDisplay47
L_OnOFFTimeDayDisplay45:
;Menu.c,243 :: 		if ((crntMenu - OnOFFTimeDay) % 2 == 0 ) {
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
;Menu.c,245 :: 		if (cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay49
;Menu.c,247 :: 		subMenu +=2;
	MOVLW      2
	ADDWF      _subMenu+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _subMenu+0
;Menu.c,248 :: 		tmp++;
	INCF       _tmp+0, 1
;Menu.c,249 :: 		if (subMenu>OnOFFTimeDaySat) {
	MOVF       R1+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay50
;Menu.c,250 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,251 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,252 :: 		}
L_OnOFFTimeDayDisplay50:
;Menu.c,253 :: 		}
L_OnOFFTimeDayDisplay49:
;Menu.c,254 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay273
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay273
	GOTO       L_OnOFFTimeDayDisplay53
L__OnOFFTimeDayDisplay273:
;Menu.c,256 :: 		editValue = editValue ^ (1<<tmp);
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
;Menu.c,257 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,258 :: 		}
L_OnOFFTimeDayDisplay53:
;Menu.c,260 :: 		}
	GOTO       L_OnOFFTimeDayDisplay54
L_OnOFFTimeDayDisplay48:
;Menu.c,263 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay55
;Menu.c,265 :: 		tmp++;
	INCF       _tmp+0, 1
;Menu.c,266 :: 		if((tmp & 0x0F )>9) tmp += 6;
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
;Menu.c,267 :: 		}
L_OnOFFTimeDayDisplay55:
;Menu.c,268 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay57
;Menu.c,270 :: 		tmp--;
	DECF       _tmp+0, 1
;Menu.c,271 :: 		if((tmp & 0x0F )>9) tmp -= 6;
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
;Menu.c,272 :: 		}
L_OnOFFTimeDayDisplay57:
;Menu.c,273 :: 		switch (subMenu) {
	GOTO       L_OnOFFTimeDayDisplay59
;Menu.c,275 :: 		case OnOFFTimeOnHr:
L_OnOFFTimeDayDisplay61:
;Menu.c,276 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay62
;Menu.c,278 :: 		subMenu = OnOFFTimeOnMin;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,279 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,280 :: 		}
L_OnOFFTimeDayDisplay62:
;Menu.c,282 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay63
;Menu.c,284 :: 		if (tmp > 0x23) {
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay64
;Menu.c,285 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,286 :: 		}
L_OnOFFTimeDayDisplay64:
;Menu.c,287 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,289 :: 		}
L_OnOFFTimeDayDisplay63:
;Menu.c,290 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay65
;Menu.c,292 :: 		if (!tmp) {
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay66
;Menu.c,293 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      _tmp+0
;Menu.c,294 :: 		}
L_OnOFFTimeDayDisplay66:
;Menu.c,295 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,296 :: 		}
L_OnOFFTimeDayDisplay65:
;Menu.c,297 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,298 :: 		case OnOFFTimeOnMin:
L_OnOFFTimeDayDisplay67:
;Menu.c,299 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay68
;Menu.c,301 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,302 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,303 :: 		tmp = Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
;Menu.c,304 :: 		}
L_OnOFFTimeDayDisplay68:
;Menu.c,305 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay69
;Menu.c,308 :: 		if (tmp > 0x59)
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay70
;Menu.c,310 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,311 :: 		}
L_OnOFFTimeDayDisplay70:
;Menu.c,312 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,314 :: 		}
L_OnOFFTimeDayDisplay69:
;Menu.c,315 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay71
;Menu.c,317 :: 		if (!tmp)
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay72
;Menu.c,319 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      _tmp+0
;Menu.c,320 :: 		}
L_OnOFFTimeDayDisplay72:
;Menu.c,321 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,322 :: 		}
L_OnOFFTimeDayDisplay71:
;Menu.c,323 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,324 :: 		case OnOFFTimeOffHr:
L_OnOFFTimeDayDisplay73:
;Menu.c,325 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay74
;Menu.c,327 :: 		subMenu = OnOFFTimeOffMin;
	MOVLW      14
	MOVWF      _subMenu+0
;Menu.c,328 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,329 :: 		}
L_OnOFFTimeDayDisplay74:
;Menu.c,330 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay75
;Menu.c,332 :: 		if (tmp > 0x23) {
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay76
;Menu.c,333 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,334 :: 		}
L_OnOFFTimeDayDisplay76:
;Menu.c,335 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,337 :: 		}
L_OnOFFTimeDayDisplay75:
;Menu.c,338 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay77
;Menu.c,340 :: 		if (!tmp) {
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay78
;Menu.c,341 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      _tmp+0
;Menu.c,342 :: 		}
L_OnOFFTimeDayDisplay78:
;Menu.c,343 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,344 :: 		}
L_OnOFFTimeDayDisplay77:
;Menu.c,345 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,346 :: 		case OnOFFTimeOffMin:
L_OnOFFTimeDayDisplay79:
;Menu.c,347 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay80
;Menu.c,349 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,350 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,351 :: 		tmp =  Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
;Menu.c,353 :: 		}
L_OnOFFTimeDayDisplay80:
;Menu.c,354 :: 		if (cPLUS == ON )
	BTFSC      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay81
;Menu.c,357 :: 		if (tmp > 0x59)
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay82
;Menu.c,359 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,360 :: 		}
L_OnOFFTimeDayDisplay82:
;Menu.c,361 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,363 :: 		}
L_OnOFFTimeDayDisplay81:
;Menu.c,364 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay83
;Menu.c,366 :: 		if (!tmp)
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay84
;Menu.c,368 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      _tmp+0
;Menu.c,369 :: 		}
L_OnOFFTimeDayDisplay84:
;Menu.c,370 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,371 :: 		}
L_OnOFFTimeDayDisplay83:
;Menu.c,373 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,374 :: 		}
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
;Menu.c,375 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay272
	BTFSS      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay272
	GOTO       L_OnOFFTimeDayDisplay87
L__OnOFFTimeDayDisplay272:
;Menu.c,377 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,378 :: 		}
L_OnOFFTimeDayDisplay87:
;Menu.c,379 :: 		}
L_OnOFFTimeDayDisplay54:
;Menu.c,382 :: 		}
L_OnOFFTimeDayDisplay47:
;Menu.c,384 :: 		}
L_end_OnOFFTimeDayDisplay:
	RETURN
; end of _OnOFFTimeDayDisplay

_checkKey:

;Menu.c,386 :: 		void checkKey(){
;Menu.c,389 :: 		timeEEAddr =30 ;              //EEPADDR_OnOFFTimeDay1-5
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,390 :: 		do{
L_checkKey88:
;Menu.c,391 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey296
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey297
L__checkKey296:
	BSF        _cashedPortD+0, 7
L__checkKey297:
;Menu.c,392 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey298
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey299
L__checkKey298:
	BSF        _cashedPortD+0, 6
L__checkKey299:
;Menu.c,393 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey300
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey301
L__checkKey300:
	BSF        _cashedPortD+0, 5
L__checkKey301:
;Menu.c,394 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey302
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey303
L__checkKey302:
	BSF        _cashedPortD+0, 4
L__checkKey303:
;Menu.c,398 :: 		if(cashedPortD < 0xF0)
	MOVLW      240
	SUBWF      _cashedPortD+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey91
;Menu.c,402 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,403 :: 		delay_ms(100);
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
;Menu.c,404 :: 		}
L_checkKey91:
;Menu.c,405 :: 		if(cMENU == ON){
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey93
;Menu.c,406 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,407 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey94
;Menu.c,408 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,409 :: 		}else{
	GOTO       L_checkKey95
L_checkKey94:
;Menu.c,410 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,411 :: 		}
L_checkKey95:
;Menu.c,412 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,413 :: 		if(crntMenu > (OnOFFTime + 16))
	MOVF       _crntMenu+0, 0
	SUBLW      23
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey96
;Menu.c,415 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,416 :: 		}
L_checkKey96:
;Menu.c,417 :: 		}
L_checkKey93:
;Menu.c,418 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey97
;Menu.c,420 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,421 :: 		}
L_checkKey97:
;Menu.c,422 :: 		switch(crntMenu)
	GOTO       L_checkKey98
;Menu.c,424 :: 		case None:
L_checkKey100:
;Menu.c,425 :: 		break;
	GOTO       L_checkKey99
;Menu.c,426 :: 		case Date:
L_checkKey101:
;Menu.c,427 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey102
;Menu.c,429 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,430 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,431 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,432 :: 		}
	GOTO       L_checkKey103
L_checkKey102:
;Menu.c,435 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey104
;Menu.c,437 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,438 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
;Menu.c,439 :: 		}
L_checkKey104:
;Menu.c,440 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey106
;Menu.c,442 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,443 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
;Menu.c,444 :: 		}
L_checkKey106:
;Menu.c,445 :: 		switch(subMenu)
	GOTO       L_checkKey108
;Menu.c,448 :: 		case DateDay:
L_checkKey110:
;Menu.c,449 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey111
;Menu.c,451 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,452 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,453 :: 		}
L_checkKey111:
;Menu.c,454 :: 		if(cPLUS == ON){
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey112
;Menu.c,455 :: 		if(editValue>0x31)  editValue = 1;
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
;Menu.c,456 :: 		}
L_checkKey112:
;Menu.c,457 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey114
;Menu.c,459 :: 		if(editValue == 0x0) editValue = 0x31;
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
;Menu.c,460 :: 		}
L_checkKey114:
;Menu.c,461 :: 		break;
	GOTO       L_checkKey109
;Menu.c,462 :: 		case DateMonth:
L_checkKey116:
;Menu.c,463 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey117
;Menu.c,465 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,466 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,467 :: 		}
L_checkKey117:
;Menu.c,468 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey118
;Menu.c,470 :: 		if(editValue>0x12)  editValue = 1;
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
;Menu.c,471 :: 		}
L_checkKey118:
;Menu.c,472 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey120
;Menu.c,474 :: 		if(editValue == 0) editValue = 0x01;
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
;Menu.c,475 :: 		}
L_checkKey120:
;Menu.c,477 :: 		break;
	GOTO       L_checkKey109
;Menu.c,478 :: 		case DateYear:
L_checkKey122:
;Menu.c,479 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey123
;Menu.c,481 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,482 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,483 :: 		}
L_checkKey123:
;Menu.c,484 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey124
;Menu.c,486 :: 		if(editValue>0x99)  editValue = 1;
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
;Menu.c,487 :: 		}
L_checkKey124:
;Menu.c,488 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey126
;Menu.c,490 :: 		if(editValue == 0) editValue = 0x99;
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
;Menu.c,491 :: 		}
L_checkKey126:
;Menu.c,493 :: 		break;
	GOTO       L_checkKey109
;Menu.c,494 :: 		case DateWeekDay:
L_checkKey128:
;Menu.c,495 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey129
;Menu.c,497 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,498 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,499 :: 		}
L_checkKey129:
;Menu.c,500 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey130
;Menu.c,502 :: 		if(editValue>0x07)  editValue = 1;
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
;Menu.c,503 :: 		}
L_checkKey130:
;Menu.c,504 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey132
;Menu.c,506 :: 		if(editValue == 0) editValue = 0x07;
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
;Menu.c,507 :: 		}
L_checkKey132:
;Menu.c,508 :: 		break;
	GOTO       L_checkKey109
;Menu.c,510 :: 		}
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
;Menu.c,511 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey285
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey285
	GOTO       L_checkKey136
L__checkKey285:
;Menu.c,513 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey137
;Menu.c,515 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,516 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,517 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,518 :: 		}
	GOTO       L_checkKey138
L_checkKey137:
;Menu.c,521 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,522 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,523 :: 		}
L_checkKey138:
;Menu.c,524 :: 		}
L_checkKey136:
;Menu.c,526 :: 		}
L_checkKey103:
;Menu.c,527 :: 		break;
	GOTO       L_checkKey99
;Menu.c,528 :: 		case Time:
L_checkKey139:
;Menu.c,529 :: 		if (cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey140
;Menu.c,531 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,532 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,533 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,534 :: 		}
	GOTO       L_checkKey141
L_checkKey140:
;Menu.c,537 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey142
;Menu.c,539 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,540 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
;Menu.c,541 :: 		}
L_checkKey142:
;Menu.c,542 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey144
;Menu.c,544 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,545 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
;Menu.c,546 :: 		}
L_checkKey144:
;Menu.c,547 :: 		switch(subMenu)
	GOTO       L_checkKey146
;Menu.c,549 :: 		case TimeHour:
L_checkKey148:
;Menu.c,550 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey149
;Menu.c,552 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,553 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,554 :: 		}
L_checkKey149:
;Menu.c,555 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey150
;Menu.c,557 :: 		if(editValue>0x23)  editValue = 0;
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
;Menu.c,558 :: 		}
L_checkKey150:
;Menu.c,559 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey152
;Menu.c,561 :: 		if(editValue > 0x23) editValue = 0x23;
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
;Menu.c,562 :: 		}
L_checkKey152:
;Menu.c,563 :: 		break;
	GOTO       L_checkKey147
;Menu.c,564 :: 		case TimeMinute:
L_checkKey154:
;Menu.c,565 :: 		if(cSELECT == ON)
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey155
;Menu.c,567 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,568 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,569 :: 		}
L_checkKey155:
;Menu.c,570 :: 		if(cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey156
;Menu.c,572 :: 		if(editValue>0x59)  editValue = 0;
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
;Menu.c,573 :: 		}
L_checkKey156:
;Menu.c,574 :: 		if(cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey158
;Menu.c,576 :: 		if(editValue > 0x59) editValue = 0x59;
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
;Menu.c,577 :: 		}
L_checkKey158:
;Menu.c,578 :: 		break;
	GOTO       L_checkKey147
;Menu.c,579 :: 		}
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
;Menu.c,580 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey284
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey284
	GOTO       L_checkKey162
L__checkKey284:
;Menu.c,582 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,583 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,584 :: 		}
L_checkKey162:
;Menu.c,585 :: 		}
L_checkKey141:
;Menu.c,586 :: 		break;
	GOTO       L_checkKey99
;Menu.c,587 :: 		case   Voltage:
L_checkKey163:
;Menu.c,588 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey164
;Menu.c,590 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,591 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,592 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,593 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,594 :: 		}
	GOTO       L_checkKey165
L_checkKey164:
;Menu.c,597 :: 		switch(subMenu)
	GOTO       L_checkKey166
;Menu.c,599 :: 		case VoltageEnable:
L_checkKey168:
;Menu.c,600 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey169
;Menu.c,602 :: 		subMenu = VoltageHigh;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,603 :: 		}
L_checkKey169:
;Menu.c,604 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey283
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey283
	GOTO       L_checkKey172
L__checkKey283:
;Menu.c,606 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,607 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,608 :: 		}
L_checkKey172:
;Menu.c,609 :: 		break;
	GOTO       L_checkKey167
;Menu.c,610 :: 		case VoltageHigh:
L_checkKey173:
;Menu.c,611 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey174
;Menu.c,613 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,614 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,615 :: 		}
L_checkKey174:
;Menu.c,616 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey175
;Menu.c,618 :: 		editValue += 2;
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
;Menu.c,619 :: 		if (editValue > 441)   editValue = 81;
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
;Menu.c,621 :: 		}
L_checkKey175:
;Menu.c,622 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey177
;Menu.c,624 :: 		editValue -= 2;
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
;Menu.c,625 :: 		if (editValue < 81) editValue = 441;
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
;Menu.c,626 :: 		}
L_checkKey177:
;Menu.c,627 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey282
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey282
	GOTO       L_checkKey181
L__checkKey282:
;Menu.c,629 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,630 :: 		}
L_checkKey181:
;Menu.c,631 :: 		break;
	GOTO       L_checkKey167
;Menu.c,632 :: 		case VoltageLow:
L_checkKey182:
;Menu.c,633 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey183
;Menu.c,635 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,636 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,637 :: 		}
L_checkKey183:
;Menu.c,638 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey184
;Menu.c,640 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,641 :: 		if (editValue > 220)   editValue = 80;
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
;Menu.c,643 :: 		}
L_checkKey184:
;Menu.c,644 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey186
;Menu.c,646 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,647 :: 		if (editValue < 80) editValue = 220;
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
;Menu.c,648 :: 		}
L_checkKey186:
;Menu.c,649 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey281
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey281
	GOTO       L_checkKey190
L__checkKey281:
;Menu.c,651 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
;Menu.c,652 :: 		}
L_checkKey190:
;Menu.c,653 :: 		break;
	GOTO       L_checkKey167
;Menu.c,655 :: 		}
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
;Menu.c,656 :: 		}
L_checkKey165:
;Menu.c,657 :: 		break;
	GOTO       L_checkKey99
;Menu.c,658 :: 		case Current:
L_checkKey191:
;Menu.c,659 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey192
;Menu.c,661 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,662 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,663 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,664 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,665 :: 		}
	GOTO       L_checkKey193
L_checkKey192:
;Menu.c,668 :: 		switch(subMenu)
	GOTO       L_checkKey194
;Menu.c,670 :: 		case CurrentEnable:
L_checkKey196:
;Menu.c,671 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey197
;Menu.c,673 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,674 :: 		}
L_checkKey197:
;Menu.c,675 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey280
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey280
	GOTO       L_checkKey200
L__checkKey280:
;Menu.c,677 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,678 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,680 :: 		}
L_checkKey200:
;Menu.c,681 :: 		break;
	GOTO       L_checkKey195
;Menu.c,682 :: 		case CurrentHeigh:
L_checkKey201:
;Menu.c,683 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey202
;Menu.c,685 :: 		subMenu = CurrentLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,686 :: 		editValue =  ee_read(EEPADDR_CurrentLow);
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,687 :: 		}
L_checkKey202:
;Menu.c,688 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey203
;Menu.c,690 :: 		editValue += 2;
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
;Menu.c,691 :: 		if (editValue > 201)   editValue = 11;
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
;Menu.c,693 :: 		}
L_checkKey203:
;Menu.c,694 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey205
;Menu.c,696 :: 		editValue -= 2;
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
;Menu.c,697 :: 		if (editValue < 11) editValue = 201;
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
;Menu.c,698 :: 		}
L_checkKey205:
;Menu.c,699 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey279
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey279
	GOTO       L_checkKey209
L__checkKey279:
;Menu.c,701 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,702 :: 		}
L_checkKey209:
;Menu.c,703 :: 		break;
	GOTO       L_checkKey195
;Menu.c,704 :: 		case CurrentLow:
L_checkKey210:
;Menu.c,705 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey211
;Menu.c,707 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,708 :: 		editValue =  ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,709 :: 		}
L_checkKey211:
;Menu.c,710 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey212
;Menu.c,712 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,713 :: 		if (editValue > 220)   editValue = 80;
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
;Menu.c,715 :: 		}
L_checkKey212:
;Menu.c,716 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey214
;Menu.c,718 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,719 :: 		if (editValue < 80) editValue = 220;
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
;Menu.c,720 :: 		}
L_checkKey214:
;Menu.c,721 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey278
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey278
	GOTO       L_checkKey218
L__checkKey278:
;Menu.c,723 :: 		loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
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
;Menu.c,724 :: 		}
L_checkKey218:
;Menu.c,725 :: 		break;
	GOTO       L_checkKey195
;Menu.c,727 :: 		}
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
;Menu.c,728 :: 		}
L_checkKey193:
;Menu.c,729 :: 		break;
	GOTO       L_checkKey99
;Menu.c,730 :: 		case LDRVal:
L_checkKey219:
;Menu.c,731 :: 		if(cMENU == ON)
	BTFSC      _cashedPortD+0, 7
	GOTO       L_checkKey220
;Menu.c,733 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,734 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,735 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,736 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,737 :: 		}
	GOTO       L_checkKey221
L_checkKey220:
;Menu.c,740 :: 		switch(subMenu)
	GOTO       L_checkKey222
;Menu.c,742 :: 		case LDRValEnable:
L_checkKey224:
;Menu.c,743 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey225
;Menu.c,745 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,746 :: 		}
L_checkKey225:
;Menu.c,747 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey277
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey277
	GOTO       L_checkKey228
L__checkKey277:
;Menu.c,749 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,750 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,751 :: 		}
L_checkKey228:
;Menu.c,752 :: 		break;
	GOTO       L_checkKey223
;Menu.c,753 :: 		case LDRValHeigh:
L_checkKey229:
;Menu.c,754 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey230
;Menu.c,756 :: 		subMenu = LDRValLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,757 :: 		editValue =  ee_read(EEPADDR_LDRValLow);
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,758 :: 		}
L_checkKey230:
;Menu.c,759 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey231
;Menu.c,761 :: 		editValue += 2;
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
;Menu.c,762 :: 		if (editValue > 441)   editValue = 81;
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
;Menu.c,764 :: 		}
L_checkKey231:
;Menu.c,765 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey233
;Menu.c,767 :: 		editValue -= 2;
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
;Menu.c,768 :: 		if (editValue < 81) editValue = 441;
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
;Menu.c,769 :: 		}
L_checkKey233:
;Menu.c,770 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey276
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey276
	GOTO       L_checkKey237
L__checkKey276:
;Menu.c,772 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,773 :: 		}
L_checkKey237:
;Menu.c,774 :: 		break;
	GOTO       L_checkKey223
;Menu.c,775 :: 		case LDRValLow:
L_checkKey238:
;Menu.c,776 :: 		if(cSELECT == ON )
	BTFSC      _cashedPortD+0, 6
	GOTO       L_checkKey239
;Menu.c,778 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,779 :: 		editValue =  ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,780 :: 		}
L_checkKey239:
;Menu.c,781 :: 		if (cPLUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L_checkKey240
;Menu.c,783 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,784 :: 		if (editValue > 220)   editValue = 80;
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
;Menu.c,786 :: 		}
L_checkKey240:
;Menu.c,787 :: 		if (cMINUS == ON)
	BTFSC      _cashedPortD+0, 4
	GOTO       L_checkKey242
;Menu.c,789 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,790 :: 		if (editValue < 80) editValue = 220;
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
;Menu.c,791 :: 		}
L_checkKey242:
;Menu.c,792 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey275
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey275
	GOTO       L_checkKey246
L__checkKey275:
;Menu.c,794 :: 		loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
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
;Menu.c,795 :: 		}
L_checkKey246:
;Menu.c,796 :: 		break;
	GOTO       L_checkKey223
;Menu.c,798 :: 		}
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
;Menu.c,799 :: 		}
L_checkKey221:
;Menu.c,800 :: 		break;
	GOTO       L_checkKey99
;Menu.c,801 :: 		case OnOFFTimeDay:
L_checkKey247:
;Menu.c,802 :: 		timeEEAddr=20;
	MOVLW      20
	MOVWF      _timeEEAddr+0
;Menu.c,803 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,804 :: 		break;
	GOTO       L_checkKey99
;Menu.c,805 :: 		case OnOFFTimeDay+1:
L_checkKey248:
;Menu.c,806 :: 		timeEEAddr=20;
	MOVLW      20
	MOVWF      _timeEEAddr+0
;Menu.c,807 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,808 :: 		break;
	GOTO       L_checkKey99
;Menu.c,809 :: 		case OnOFFTimeDay+2:
L_checkKey249:
;Menu.c,810 :: 		timeEEAddr=25;
	MOVLW      25
	MOVWF      _timeEEAddr+0
;Menu.c,811 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,812 :: 		break;
	GOTO       L_checkKey99
;Menu.c,813 :: 		case OnOFFTimeDay+3:
L_checkKey250:
;Menu.c,814 :: 		timeEEAddr=25;
	MOVLW      25
	MOVWF      _timeEEAddr+0
;Menu.c,815 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,816 :: 		break;
	GOTO       L_checkKey99
;Menu.c,817 :: 		case OnOFFTimeDay+4:
L_checkKey251:
;Menu.c,818 :: 		timeEEAddr=30;
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,819 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,820 :: 		break;
	GOTO       L_checkKey99
;Menu.c,821 :: 		case OnOFFTimeDay+5:
L_checkKey252:
;Menu.c,822 :: 		timeEEAddr=30;
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,823 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,824 :: 		break;
	GOTO       L_checkKey99
;Menu.c,825 :: 		case OnOFFTimeDay+6:
L_checkKey253:
;Menu.c,826 :: 		timeEEAddr=35;
	MOVLW      35
	MOVWF      _timeEEAddr+0
;Menu.c,827 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,828 :: 		break;
	GOTO       L_checkKey99
;Menu.c,829 :: 		case OnOFFTimeDay+7:
L_checkKey254:
;Menu.c,830 :: 		timeEEAddr=35;
	MOVLW      35
	MOVWF      _timeEEAddr+0
;Menu.c,831 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,832 :: 		break;
	GOTO       L_checkKey99
;Menu.c,833 :: 		case OnOFFTimeDay+8:
L_checkKey255:
;Menu.c,834 :: 		timeEEAddr=40;
	MOVLW      40
	MOVWF      _timeEEAddr+0
;Menu.c,835 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,836 :: 		break;
	GOTO       L_checkKey99
;Menu.c,837 :: 		case OnOFFTimeDay+9:
L_checkKey256:
;Menu.c,838 :: 		timeEEAddr=40;
	MOVLW      40
	MOVWF      _timeEEAddr+0
;Menu.c,839 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,840 :: 		break;
	GOTO       L_checkKey99
;Menu.c,841 :: 		case OnOFFTimeDay+10:
L_checkKey257:
;Menu.c,842 :: 		timeEEAddr=45;
	MOVLW      45
	MOVWF      _timeEEAddr+0
;Menu.c,843 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,844 :: 		break;
	GOTO       L_checkKey99
;Menu.c,845 :: 		case OnOFFTimeDay+11:
L_checkKey258:
;Menu.c,846 :: 		timeEEAddr=45;
	MOVLW      45
	MOVWF      _timeEEAddr+0
;Menu.c,847 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,848 :: 		break;
	GOTO       L_checkKey99
;Menu.c,849 :: 		case OnOFFTimeDay+12:
L_checkKey259:
;Menu.c,850 :: 		timeEEAddr=50;
	MOVLW      50
	MOVWF      _timeEEAddr+0
;Menu.c,851 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,852 :: 		break;
	GOTO       L_checkKey99
;Menu.c,853 :: 		case OnOFFTimeDay+13:
L_checkKey260:
;Menu.c,854 :: 		timeEEAddr=50;
	MOVLW      50
	MOVWF      _timeEEAddr+0
;Menu.c,855 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,856 :: 		break;
	GOTO       L_checkKey99
;Menu.c,857 :: 		case OnOFFTimeDay+14:
L_checkKey261:
;Menu.c,858 :: 		timeEEAddr=55;
	MOVLW      55
	MOVWF      _timeEEAddr+0
;Menu.c,859 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,860 :: 		break;
	GOTO       L_checkKey99
;Menu.c,861 :: 		case OnOFFTimeDay+15:
L_checkKey262:
;Menu.c,862 :: 		timeEEAddr=55;
	MOVLW      55
	MOVWF      _timeEEAddr+0
;Menu.c,863 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,864 :: 		break;
	GOTO       L_checkKey99
;Menu.c,865 :: 		default:
L_checkKey263:
;Menu.c,866 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,867 :: 		break;
	GOTO       L_checkKey99
;Menu.c,868 :: 		}
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
;Menu.c,869 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey264
;Menu.c,870 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,871 :: 		}
L_checkKey264:
;Menu.c,872 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L__checkKey274
	BTFSS      _cashedPortD+0, 4
	GOTO       L__checkKey274
	GOTO       L_checkKey267
L__checkKey274:
;Menu.c,874 :: 		isEdited = 1;
	BSF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,875 :: 		}
L_checkKey267:
;Menu.c,877 :: 		delay_ms(100);
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
;Menu.c,878 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,879 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey332
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey332:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey269
;Menu.c,880 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,881 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,882 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,883 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,884 :: 		}
L_checkKey269:
;Menu.c,887 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey88
;Menu.c,888 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,890 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
