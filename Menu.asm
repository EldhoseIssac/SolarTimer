
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
;Menu.c,103 :: 		TRISC.F1 = 0;
	BCF        TRISC+0, 1
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
;Menu.c,153 :: 		case VoltageEnable:
L_saveValue24:
;Menu.c,154 :: 		ee_write(EEPADDR_VoltageHigh,editValue);
	MOVLW      2
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,155 :: 		break;
	GOTO       L_saveValue21
;Menu.c,156 :: 		}
L_saveValue20:
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue22
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue23
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue24
L_saveValue21:
;Menu.c,157 :: 		break;
	GOTO       L_saveValue5
;Menu.c,158 :: 		case Current:
L_saveValue25:
;Menu.c,159 :: 		switch(subMenu){
	GOTO       L_saveValue26
;Menu.c,160 :: 		case CurrentHeigh:
L_saveValue28:
;Menu.c,161 :: 		case CurrentEnable:
L_saveValue29:
;Menu.c,162 :: 		ee_write(EEPADDR_CurrentHeigh,editValue);
	MOVLW      6
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,163 :: 		break;
	GOTO       L_saveValue27
;Menu.c,164 :: 		case CurrentLow:
L_saveValue30:
;Menu.c,165 :: 		ee_write(EEPADDR_CurrentLow,editValue);
	MOVLW      8
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,166 :: 		break;
	GOTO       L_saveValue27
;Menu.c,167 :: 		}
L_saveValue26:
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue28
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue29
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue30
L_saveValue27:
;Menu.c,168 :: 		break;
	GOTO       L_saveValue5
;Menu.c,169 :: 		case LDRVal:
L_saveValue31:
;Menu.c,170 :: 		switch(subMenu){
	GOTO       L_saveValue32
;Menu.c,171 :: 		case LDRValLow:
L_saveValue34:
;Menu.c,172 :: 		ee_write(EEPADDR_LDRValLow,editValue);
	MOVLW      12
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,173 :: 		break;
	GOTO       L_saveValue33
;Menu.c,174 :: 		case LDRValHeigh:
L_saveValue35:
;Menu.c,175 :: 		case LDRValEnable:
L_saveValue36:
;Menu.c,176 :: 		ee_write(EEPADDR_LDRValHeigh,editValue);
	MOVLW      10
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,177 :: 		break;
	GOTO       L_saveValue33
;Menu.c,178 :: 		}
L_saveValue32:
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue34
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue35
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue36
L_saveValue33:
;Menu.c,179 :: 		break;
	GOTO       L_saveValue5
;Menu.c,180 :: 		default:
L_saveValue37:
;Menu.c,181 :: 		if ((crntMenu - OnOFFTimeDay1) % 2 == 0 ) {
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
	GOTO       L__saveValue292
	MOVLW      0
	XORWF      R0+0, 0
L__saveValue292:
	BTFSS      STATUS+0, 2
	GOTO       L_saveValue38
;Menu.c,182 :: 		EEPROM_write(timeEEAddr,editValue);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;Menu.c,183 :: 		}
	GOTO       L_saveValue39
L_saveValue38:
;Menu.c,186 :: 		if (subMenu == OnOFFTimeOnHr || subMenu == OnOFFTimeOnMin) {
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue274
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue274
	GOTO       L_saveValue42
L__saveValue274:
;Menu.c,187 :: 		ee_write(timeEEAddr+1,editValue);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,188 :: 		}
	GOTO       L_saveValue43
L_saveValue42:
;Menu.c,189 :: 		else if (subMenu == OnOFFTimeOffHr || subMenu == OnOFFTimeOffMin)
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue273
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L__saveValue273
	GOTO       L_saveValue46
L__saveValue273:
;Menu.c,191 :: 		ee_write(timeEEAddr+3,editValue);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_write_addr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_ee_write_value+0
	MOVF       _editValue+1, 0
	MOVWF      FARG_ee_write_value+1
	CALL       _ee_write+0
;Menu.c,192 :: 		}
L_saveValue46:
L_saveValue43:
;Menu.c,193 :: 		}
L_saveValue39:
;Menu.c,194 :: 		break;
	GOTO       L_saveValue5
;Menu.c,196 :: 		}
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
	GOTO       L_saveValue25
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_saveValue31
	GOTO       L_saveValue37
L_saveValue5:
;Menu.c,197 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_saveValue47:
	DECFSZ     R13+0, 1
	GOTO       L_saveValue47
	DECFSZ     R12+0, 1
	GOTO       L_saveValue47
	DECFSZ     R11+0, 1
	GOTO       L_saveValue47
	NOP
;Menu.c,198 :: 		}
L_end_saveValue:
	RETURN
; end of _saveValue

_OnOFFTimeDayDisplay:

;Menu.c,217 :: 		void OnOFFTimeDayDisplay(){
;Menu.c,218 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_OnOFFTimeDayDisplay48
;Menu.c,221 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,222 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,223 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,224 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,225 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,226 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,227 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,228 :: 		editValue = EEPROM_Read(timeEEAddr);
	MOVF       _timeEEAddr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,229 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,230 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,231 :: 		if ((crntMenu - OnOFFTimeDay1) % 2 == 1 )
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
	GOTO       L__OnOFFTimeDayDisplay294
	MOVLW      1
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay294:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay49
;Menu.c,233 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,234 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,235 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,236 :: 		}
L_OnOFFTimeDayDisplay49:
;Menu.c,238 :: 		}
	GOTO       L_OnOFFTimeDayDisplay50
L_OnOFFTimeDayDisplay48:
;Menu.c,241 :: 		if ((crntMenu - OnOFFTimeDay1) % 2 == 0 ) {
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
	GOTO       L__OnOFFTimeDayDisplay295
	MOVLW      0
	XORWF      R0+0, 0
L__OnOFFTimeDayDisplay295:
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay51
;Menu.c,243 :: 		if (cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay52
;Menu.c,245 :: 		subMenu +=2;
	MOVLW      2
	ADDWF      _subMenu+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _subMenu+0
;Menu.c,246 :: 		tmp++;
	INCF       _tmp+0, 1
;Menu.c,247 :: 		if (subMenu>OnOFFTimeDaySat) {
	MOVF       R1+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay53
;Menu.c,248 :: 		subMenu = OnOFFTimeDaySun;
	MOVLW      2
	MOVWF      _subMenu+0
;Menu.c,249 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,250 :: 		}
L_OnOFFTimeDayDisplay53:
;Menu.c,251 :: 		}
L_OnOFFTimeDayDisplay52:
;Menu.c,252 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay276
	BTFSC      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay276
	GOTO       L_OnOFFTimeDayDisplay56
L__OnOFFTimeDayDisplay276:
;Menu.c,254 :: 		editValue = editValue ^ (1<<tmp);
	MOVF       _tmp+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__OnOFFTimeDayDisplay296:
	BTFSC      STATUS+0, 2
	GOTO       L__OnOFFTimeDayDisplay297
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__OnOFFTimeDayDisplay296
L__OnOFFTimeDayDisplay297:
	MOVF       R0+0, 0
	XORWF      _editValue+0, 1
	MOVF       R0+1, 0
	XORWF      _editValue+1, 1
;Menu.c,255 :: 		loadEnabledDay();
	CALL       _loadEnabledDay+0
;Menu.c,256 :: 		}
L_OnOFFTimeDayDisplay56:
;Menu.c,258 :: 		}
	GOTO       L_OnOFFTimeDayDisplay57
L_OnOFFTimeDayDisplay51:
;Menu.c,261 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay58
;Menu.c,263 :: 		tmp++;
	INCF       _tmp+0, 1
;Menu.c,264 :: 		if((tmp & 0x0F )>9) tmp += 6;
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay59
	MOVLW      6
	ADDWF      _tmp+0, 1
L_OnOFFTimeDayDisplay59:
;Menu.c,265 :: 		}
L_OnOFFTimeDayDisplay58:
;Menu.c,266 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay60
;Menu.c,268 :: 		tmp--;
	DECF       _tmp+0, 1
;Menu.c,269 :: 		if((tmp & 0x0F )>9) tmp -= 6;
	MOVLW      15
	ANDWF      _tmp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	SUBLW      9
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay61
	MOVLW      6
	SUBWF      _tmp+0, 1
L_OnOFFTimeDayDisplay61:
;Menu.c,270 :: 		}
L_OnOFFTimeDayDisplay60:
;Menu.c,271 :: 		switch (subMenu) {
	GOTO       L_OnOFFTimeDayDisplay62
;Menu.c,273 :: 		case OnOFFTimeOnHr:
L_OnOFFTimeDayDisplay64:
;Menu.c,274 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay65
;Menu.c,276 :: 		subMenu = OnOFFTimeOnMin;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,277 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,278 :: 		}
L_OnOFFTimeDayDisplay65:
;Menu.c,280 :: 		if (cPLUS == ON )
	BTFSS      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay66
;Menu.c,282 :: 		if (tmp > 0x23) {
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay67
;Menu.c,283 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,284 :: 		}
L_OnOFFTimeDayDisplay67:
;Menu.c,285 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,287 :: 		}
L_OnOFFTimeDayDisplay66:
;Menu.c,288 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay68
;Menu.c,290 :: 		if (!tmp) {
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay69
;Menu.c,291 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      _tmp+0
;Menu.c,292 :: 		}
L_OnOFFTimeDayDisplay69:
;Menu.c,293 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,294 :: 		}
L_OnOFFTimeDayDisplay68:
;Menu.c,295 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay63
;Menu.c,296 :: 		case OnOFFTimeOnMin:
L_OnOFFTimeDayDisplay70:
;Menu.c,297 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay71
;Menu.c,299 :: 		subMenu = OnOFFTimeOffHr;
	MOVLW      11
	MOVWF      _subMenu+0
;Menu.c,300 :: 		editValue = ee_read(timeEEAddr+3);
	MOVLW      3
	ADDWF      _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,301 :: 		tmp = Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
;Menu.c,302 :: 		}
L_OnOFFTimeDayDisplay71:
;Menu.c,303 :: 		if (cPLUS == ON )
	BTFSS      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay72
;Menu.c,306 :: 		if (tmp > 0x59)
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay73
;Menu.c,308 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,309 :: 		}
L_OnOFFTimeDayDisplay73:
;Menu.c,310 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,312 :: 		}
L_OnOFFTimeDayDisplay72:
;Menu.c,313 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay74
;Menu.c,315 :: 		if (!tmp)
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay75
;Menu.c,317 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      _tmp+0
;Menu.c,318 :: 		}
L_OnOFFTimeDayDisplay75:
;Menu.c,319 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,320 :: 		}
L_OnOFFTimeDayDisplay74:
;Menu.c,321 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay63
;Menu.c,322 :: 		case OnOFFTimeOffHr:
L_OnOFFTimeDayDisplay76:
;Menu.c,323 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay77
;Menu.c,325 :: 		subMenu = OnOFFTimeOffMin;
	MOVLW      14
	MOVWF      _subMenu+0
;Menu.c,326 :: 		tmp = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      _tmp+0
;Menu.c,327 :: 		}
L_OnOFFTimeDayDisplay77:
;Menu.c,328 :: 		if (cPLUS == ON )
	BTFSS      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay78
;Menu.c,330 :: 		if (tmp > 0x23) {
	MOVF       _tmp+0, 0
	SUBLW      35
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay79
;Menu.c,331 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,332 :: 		}
L_OnOFFTimeDayDisplay79:
;Menu.c,333 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,335 :: 		}
L_OnOFFTimeDayDisplay78:
;Menu.c,336 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay80
;Menu.c,338 :: 		if (!tmp) {
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay81
;Menu.c,339 :: 		tmp = 0x23;
	MOVLW      35
	MOVWF      _tmp+0
;Menu.c,340 :: 		}
L_OnOFFTimeDayDisplay81:
;Menu.c,341 :: 		Lo(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+0
;Menu.c,342 :: 		}
L_OnOFFTimeDayDisplay80:
;Menu.c,343 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay63
;Menu.c,344 :: 		case OnOFFTimeOffMin:
L_OnOFFTimeDayDisplay82:
;Menu.c,345 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_OnOFFTimeDayDisplay83
;Menu.c,347 :: 		subMenu = OnOFFTimeOnHr;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,348 :: 		editValue = ee_read(timeEEAddr+1);
	INCF       _timeEEAddr+0, 0
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,349 :: 		tmp =  Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      _tmp+0
;Menu.c,351 :: 		}
L_OnOFFTimeDayDisplay83:
;Menu.c,352 :: 		if (cPLUS == ON )
	BTFSS      _cashedPortD+0, 5
	GOTO       L_OnOFFTimeDayDisplay84
;Menu.c,355 :: 		if (tmp > 0x59)
	MOVF       _tmp+0, 0
	SUBLW      89
	BTFSC      STATUS+0, 0
	GOTO       L_OnOFFTimeDayDisplay85
;Menu.c,357 :: 		tmp = 0;
	CLRF       _tmp+0
;Menu.c,358 :: 		}
L_OnOFFTimeDayDisplay85:
;Menu.c,359 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,361 :: 		}
L_OnOFFTimeDayDisplay84:
;Menu.c,362 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_OnOFFTimeDayDisplay86
;Menu.c,364 :: 		if (!tmp)
	MOVF       _tmp+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay87
;Menu.c,366 :: 		tmp = 0x59;
	MOVLW      89
	MOVWF      _tmp+0
;Menu.c,367 :: 		}
L_OnOFFTimeDayDisplay87:
;Menu.c,368 :: 		Hi(editValue) = tmp;
	MOVF       _tmp+0, 0
	MOVWF      _editValue+1
;Menu.c,369 :: 		}
L_OnOFFTimeDayDisplay86:
;Menu.c,371 :: 		break;
	GOTO       L_OnOFFTimeDayDisplay63
;Menu.c,372 :: 		}
L_OnOFFTimeDayDisplay62:
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay64
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay70
	MOVF       _subMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay76
	MOVF       _subMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_OnOFFTimeDayDisplay82
L_OnOFFTimeDayDisplay63:
;Menu.c,373 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__OnOFFTimeDayDisplay275
	BTFSC      _cashedPortD+0, 4
	GOTO       L__OnOFFTimeDayDisplay275
	GOTO       L_OnOFFTimeDayDisplay90
L__OnOFFTimeDayDisplay275:
;Menu.c,375 :: 		loadOnOffTime();
	CALL       _loadOnOffTime+0
;Menu.c,376 :: 		}
L_OnOFFTimeDayDisplay90:
;Menu.c,377 :: 		}
L_OnOFFTimeDayDisplay57:
;Menu.c,380 :: 		}
L_OnOFFTimeDayDisplay50:
;Menu.c,382 :: 		}
L_end_OnOFFTimeDayDisplay:
	RETURN
; end of _OnOFFTimeDayDisplay

_checkKey:

;Menu.c,384 :: 		void checkKey(){
;Menu.c,387 :: 		timeEEAddr =30 ;              //EEPADDR_OnOFFTimeDay1-5
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,388 :: 		do{
L_checkKey91:
;Menu.c,389 :: 		cMENU = MENU;
	BTFSC      PORTD+0, 7
	GOTO       L__checkKey299
	BCF        _cashedPortD+0, 7
	GOTO       L__checkKey300
L__checkKey299:
	BSF        _cashedPortD+0, 7
L__checkKey300:
;Menu.c,390 :: 		cSELECT = SELECT;
	BTFSC      PORTD+0, 6
	GOTO       L__checkKey301
	BCF        _cashedPortD+0, 6
	GOTO       L__checkKey302
L__checkKey301:
	BSF        _cashedPortD+0, 6
L__checkKey302:
;Menu.c,391 :: 		cPLUS = PLUS;
	BTFSC      PORTD+0, 5
	GOTO       L__checkKey303
	BCF        _cashedPortD+0, 5
	GOTO       L__checkKey304
L__checkKey303:
	BSF        _cashedPortD+0, 5
L__checkKey304:
;Menu.c,392 :: 		cMINUS = MINUS;
	BTFSC      PORTD+0, 4
	GOTO       L__checkKey305
	BCF        _cashedPortD+0, 4
	GOTO       L__checkKey306
L__checkKey305:
	BSF        _cashedPortD+0, 4
L__checkKey306:
;Menu.c,394 :: 		if(cashedPortD > 0)
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey94
;Menu.c,400 :: 		waitCount = 0;
	CLRF       _waitCount+0
	CLRF       _waitCount+1
;Menu.c,401 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey95:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey95
	DECFSZ     R12+0, 1
	GOTO       L_checkKey95
	DECFSZ     R11+0, 1
	GOTO       L_checkKey95
	NOP
;Menu.c,402 :: 		}
L_checkKey94:
;Menu.c,403 :: 		if(cMENU == ON){
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey96
;Menu.c,404 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,405 :: 		if(crntMenu == None){
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey97
;Menu.c,406 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW      15
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,407 :: 		}else{
	GOTO       L_checkKey98
L_checkKey97:
;Menu.c,408 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,409 :: 		}
L_checkKey98:
;Menu.c,410 :: 		crntMenu ++;
	INCF       _crntMenu+0, 1
;Menu.c,411 :: 		if(crntMenu > OnOFFTime8)
	MOVF       _crntMenu+0, 0
	SUBLW      21
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey99
;Menu.c,413 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,414 :: 		}
L_checkKey99:
;Menu.c,415 :: 		}
L_checkKey96:
;Menu.c,416 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey100
;Menu.c,418 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,419 :: 		}
L_checkKey100:
;Menu.c,420 :: 		switch(crntMenu)
	GOTO       L_checkKey101
;Menu.c,422 :: 		case None:
L_checkKey103:
;Menu.c,423 :: 		break;
	GOTO       L_checkKey102
;Menu.c,424 :: 		case Date:
L_checkKey104:
;Menu.c,425 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey105
;Menu.c,427 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,428 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,429 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,430 :: 		}
	GOTO       L_checkKey106
L_checkKey105:
;Menu.c,433 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey107
;Menu.c,435 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,436 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey307
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey307:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey108
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey108:
;Menu.c,437 :: 		}
L_checkKey107:
;Menu.c,438 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey109
;Menu.c,440 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,441 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey308
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey308:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey110
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey110:
;Menu.c,442 :: 		}
L_checkKey109:
;Menu.c,443 :: 		switch(subMenu)
	GOTO       L_checkKey111
;Menu.c,446 :: 		case DateDay:
L_checkKey113:
;Menu.c,447 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey114
;Menu.c,449 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,450 :: 		editValue = month;
	MOVF       _month+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,451 :: 		}
L_checkKey114:
;Menu.c,452 :: 		if(cPLUS == ON){
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey115
;Menu.c,453 :: 		if(editValue>0x31)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey309
	MOVF       _editValue+0, 0
	SUBLW      49
L__checkKey309:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey116
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey116:
;Menu.c,454 :: 		}
L_checkKey115:
;Menu.c,455 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey117
;Menu.c,457 :: 		if(editValue == 0x0) editValue = 0x31;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey310
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey310:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey118
	MOVLW      49
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey118:
;Menu.c,458 :: 		}
L_checkKey117:
;Menu.c,459 :: 		break;
	GOTO       L_checkKey112
;Menu.c,460 :: 		case DateMonth:
L_checkKey119:
;Menu.c,461 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey120
;Menu.c,463 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,464 :: 		editValue = year;
	MOVF       _year+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,465 :: 		}
L_checkKey120:
;Menu.c,466 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey121
;Menu.c,468 :: 		if(editValue>0x12)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey311
	MOVF       _editValue+0, 0
	SUBLW      18
L__checkKey311:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey122
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey122:
;Menu.c,469 :: 		}
L_checkKey121:
;Menu.c,470 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey123
;Menu.c,472 :: 		if(editValue == 0) editValue = 0x01;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey312
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey312:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey124
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey124:
;Menu.c,473 :: 		}
L_checkKey123:
;Menu.c,475 :: 		break;
	GOTO       L_checkKey112
;Menu.c,476 :: 		case DateYear:
L_checkKey125:
;Menu.c,477 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey126
;Menu.c,479 :: 		subMenu = DateWeekDay;
	MOVLW      9
	MOVWF      _subMenu+0
;Menu.c,480 :: 		editValue = dday;
	MOVF       _dday+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,481 :: 		}
L_checkKey126:
;Menu.c,482 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey127
;Menu.c,484 :: 		if(editValue>0x99)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey313
	MOVF       _editValue+0, 0
	SUBLW      153
L__checkKey313:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey128
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey128:
;Menu.c,485 :: 		}
L_checkKey127:
;Menu.c,486 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey129
;Menu.c,488 :: 		if(editValue == 0) editValue = 0x99;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey314
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey314:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey130
	MOVLW      153
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey130:
;Menu.c,489 :: 		}
L_checkKey129:
;Menu.c,491 :: 		break;
	GOTO       L_checkKey112
;Menu.c,492 :: 		case DateWeekDay:
L_checkKey131:
;Menu.c,493 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey132
;Menu.c,495 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,496 :: 		editValue = day;
	MOVF       _day+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,497 :: 		}
L_checkKey132:
;Menu.c,498 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey133
;Menu.c,500 :: 		if(editValue>0x07)  editValue = 1;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey315
	MOVF       _editValue+0, 0
	SUBLW      7
L__checkKey315:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey134
	MOVLW      1
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey134:
;Menu.c,501 :: 		}
L_checkKey133:
;Menu.c,502 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey135
;Menu.c,504 :: 		if(editValue == 0) editValue = 0x07;
	MOVLW      0
	XORWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey316
	MOVLW      0
	XORWF      _editValue+0, 0
L__checkKey316:
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey136
	MOVLW      7
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey136:
;Menu.c,505 :: 		}
L_checkKey135:
;Menu.c,506 :: 		break;
	GOTO       L_checkKey112
;Menu.c,508 :: 		}
L_checkKey111:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey113
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey119
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey125
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey131
L_checkKey112:
;Menu.c,509 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey288
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey288
	GOTO       L_checkKey139
L__checkKey288:
;Menu.c,511 :: 		if (subMenu == DateWeekDay)
	MOVF       _subMenu+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey140
;Menu.c,513 :: 		loadDay(lcdrow2,editValue);
	MOVLW      _lcdrow2+0
	MOVWF      FARG_loadDay_arr+0
	MOVF       _editValue+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;Menu.c,514 :: 		lcdrow2[3] = '\0';
	CLRF       _lcdrow2+3
;Menu.c,515 :: 		Lcd_Out(2,subMenu+1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	INCF       _subMenu+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,516 :: 		}
	GOTO       L_checkKey141
L_checkKey140:
;Menu.c,519 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,520 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,521 :: 		}
L_checkKey141:
;Menu.c,522 :: 		}
L_checkKey139:
;Menu.c,524 :: 		}
L_checkKey106:
;Menu.c,525 :: 		break;
	GOTO       L_checkKey102
;Menu.c,526 :: 		case Time:
L_checkKey142:
;Menu.c,527 :: 		if (cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey143
;Menu.c,529 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,530 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,531 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,532 :: 		}
	GOTO       L_checkKey144
L_checkKey143:
;Menu.c,535 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey145
;Menu.c,537 :: 		editValue++;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,538 :: 		if((editValue & 0x0F )>9) editValue += 6;
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
	GOTO       L__checkKey317
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey317:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey146
	MOVLW      6
	ADDWF      _editValue+0, 1
	BTFSC      STATUS+0, 0
	INCF       _editValue+1, 1
L_checkKey146:
;Menu.c,539 :: 		}
L_checkKey145:
;Menu.c,540 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey147
;Menu.c,542 :: 		editValue--;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,543 :: 		if((editValue & 0x0F )>9) editValue -= 6;
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
	GOTO       L__checkKey318
	MOVF       R1+0, 0
	SUBLW      9
L__checkKey318:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey148
	MOVLW      6
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
L_checkKey148:
;Menu.c,544 :: 		}
L_checkKey147:
;Menu.c,545 :: 		switch(subMenu)
	GOTO       L_checkKey149
;Menu.c,547 :: 		case TimeHour:
L_checkKey151:
;Menu.c,548 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey152
;Menu.c,550 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,551 :: 		editValue = minute;
	MOVF       _minute+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,552 :: 		}
L_checkKey152:
;Menu.c,553 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey153
;Menu.c,555 :: 		if(editValue>0x23)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey319
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey319:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey154
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey154:
;Menu.c,556 :: 		}
L_checkKey153:
;Menu.c,557 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey155
;Menu.c,559 :: 		if(editValue > 0x23) editValue = 0x23;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey320
	MOVF       _editValue+0, 0
	SUBLW      35
L__checkKey320:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey156
	MOVLW      35
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey156:
;Menu.c,560 :: 		}
L_checkKey155:
;Menu.c,561 :: 		break;
	GOTO       L_checkKey150
;Menu.c,562 :: 		case TimeMinute:
L_checkKey157:
;Menu.c,563 :: 		if(cSELECT == ON)
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey158
;Menu.c,565 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,566 :: 		editValue = hour;
	MOVF       _hour+0, 0
	MOVWF      _editValue+0
	CLRF       _editValue+1
;Menu.c,567 :: 		}
L_checkKey158:
;Menu.c,568 :: 		if(cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey159
;Menu.c,570 :: 		if(editValue>0x59)  editValue = 0;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey321
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey321:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey160
	CLRF       _editValue+0
	CLRF       _editValue+1
L_checkKey160:
;Menu.c,571 :: 		}
L_checkKey159:
;Menu.c,572 :: 		if(cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey161
;Menu.c,574 :: 		if(editValue > 0x59) editValue = 0x59;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey322
	MOVF       _editValue+0, 0
	SUBLW      89
L__checkKey322:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey162
	MOVLW      89
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey162:
;Menu.c,575 :: 		}
L_checkKey161:
;Menu.c,576 :: 		break;
	GOTO       L_checkKey150
;Menu.c,577 :: 		}
L_checkKey149:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey151
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey157
L_checkKey150:
;Menu.c,578 :: 		if(cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey287
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey287
	GOTO       L_checkKey165
L__checkKey287:
;Menu.c,580 :: 		Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
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
;Menu.c,581 :: 		Lcd_Chr_CP(BCD2LowerCh(editValue));
	MOVF       _editValue+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;Menu.c,582 :: 		}
L_checkKey165:
;Menu.c,583 :: 		}
L_checkKey144:
;Menu.c,584 :: 		break;
	GOTO       L_checkKey102
;Menu.c,585 :: 		case   Voltage:
L_checkKey166:
;Menu.c,586 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey167
;Menu.c,588 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,589 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
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
;Menu.c,590 :: 		editValue = ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,591 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,592 :: 		}
	GOTO       L_checkKey168
L_checkKey167:
;Menu.c,595 :: 		switch(subMenu)
	GOTO       L_checkKey169
;Menu.c,597 :: 		case VoltageEnable:
L_checkKey171:
;Menu.c,598 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey172
;Menu.c,600 :: 		subMenu = VoltageHigh;
	MOVLW      7
	MOVWF      _subMenu+0
;Menu.c,601 :: 		}
L_checkKey172:
;Menu.c,602 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey286
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey286
	GOTO       L_checkKey175
L__checkKey286:
;Menu.c,604 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,605 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,606 :: 		}
L_checkKey175:
;Menu.c,607 :: 		break;
	GOTO       L_checkKey170
;Menu.c,608 :: 		case VoltageHigh:
L_checkKey176:
;Menu.c,609 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey177
;Menu.c,611 :: 		subMenu = VoltageLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,612 :: 		editValue =  ee_read(EEPADDR_VoltageLow);
	MOVLW      4
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,613 :: 		}
L_checkKey177:
;Menu.c,614 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey178
;Menu.c,616 :: 		editValue += 2;
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
;Menu.c,617 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey323
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey323:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey179
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey179:
;Menu.c,619 :: 		}
L_checkKey178:
;Menu.c,620 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey180
;Menu.c,622 :: 		editValue -= 2;
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
;Menu.c,623 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey324
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey324:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey181
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey181:
;Menu.c,624 :: 		}
L_checkKey180:
;Menu.c,625 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey285
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey285
	GOTO       L_checkKey184
L__checkKey285:
;Menu.c,627 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
;Menu.c,628 :: 		}
L_checkKey184:
;Menu.c,629 :: 		break;
	GOTO       L_checkKey170
;Menu.c,630 :: 		case VoltageLow:
L_checkKey185:
;Menu.c,631 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey186
;Menu.c,633 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,634 :: 		editValue =  ee_read(EEPADDR_VoltageHigh);
	MOVLW      2
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,635 :: 		}
L_checkKey186:
;Menu.c,636 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey187
;Menu.c,638 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,639 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey325
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey325:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey188
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey188:
;Menu.c,641 :: 		}
L_checkKey187:
;Menu.c,642 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey189
;Menu.c,644 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,645 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey326
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey326:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey190
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey190:
;Menu.c,646 :: 		}
L_checkKey189:
;Menu.c,647 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey284
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey284
	GOTO       L_checkKey193
L__checkKey284:
;Menu.c,649 :: 		loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
;Menu.c,650 :: 		}
L_checkKey193:
;Menu.c,651 :: 		break;
	GOTO       L_checkKey170
;Menu.c,653 :: 		}
L_checkKey169:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey171
	MOVF       _subMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey176
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey185
L_checkKey170:
;Menu.c,654 :: 		}
L_checkKey168:
;Menu.c,655 :: 		break;
	GOTO       L_checkKey102
;Menu.c,656 :: 		case Current:
L_checkKey194:
;Menu.c,657 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey195
;Menu.c,659 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,660 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
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
;Menu.c,661 :: 		editValue = ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,662 :: 		loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,663 :: 		}
	GOTO       L_checkKey196
L_checkKey195:
;Menu.c,666 :: 		switch(subMenu)
	GOTO       L_checkKey197
;Menu.c,668 :: 		case CurrentEnable:
L_checkKey199:
;Menu.c,669 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey200
;Menu.c,671 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,672 :: 		}
L_checkKey200:
;Menu.c,673 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey283
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey283
	GOTO       L_checkKey203
L__checkKey283:
;Menu.c,675 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,676 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,678 :: 		}
L_checkKey203:
;Menu.c,679 :: 		break;
	GOTO       L_checkKey198
;Menu.c,680 :: 		case CurrentHeigh:
L_checkKey204:
;Menu.c,681 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey205
;Menu.c,683 :: 		subMenu = CurrentLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,684 :: 		editValue =  ee_read(EEPADDR_CurrentLow);
	MOVLW      8
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,685 :: 		}
L_checkKey205:
;Menu.c,686 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey206
;Menu.c,688 :: 		editValue += 2;
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
;Menu.c,689 :: 		if (editValue > 201)   editValue = 11;
	MOVF       R1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey327
	MOVF       R1+0, 0
	SUBLW      201
L__checkKey327:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey207
	MOVLW      11
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey207:
;Menu.c,691 :: 		}
L_checkKey206:
;Menu.c,692 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey208
;Menu.c,694 :: 		editValue -= 2;
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
;Menu.c,695 :: 		if (editValue < 11) editValue = 201;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey328
	MOVLW      11
	SUBWF      R1+0, 0
L__checkKey328:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey209
	MOVLW      201
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey209:
;Menu.c,696 :: 		}
L_checkKey208:
;Menu.c,697 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey282
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey282
	GOTO       L_checkKey212
L__checkKey282:
;Menu.c,699 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
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
;Menu.c,700 :: 		}
L_checkKey212:
;Menu.c,701 :: 		break;
	GOTO       L_checkKey198
;Menu.c,702 :: 		case CurrentLow:
L_checkKey213:
;Menu.c,703 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey214
;Menu.c,705 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,706 :: 		editValue =  ee_read(EEPADDR_CurrentHeigh);
	MOVLW      6
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,707 :: 		}
L_checkKey214:
;Menu.c,708 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey215
;Menu.c,710 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,711 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey329
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey329:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey216
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey216:
;Menu.c,713 :: 		}
L_checkKey215:
;Menu.c,714 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey217
;Menu.c,716 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,717 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey330
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey330:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey218
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey218:
;Menu.c,718 :: 		}
L_checkKey217:
;Menu.c,719 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey281
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey281
	GOTO       L_checkKey221
L__checkKey281:
;Menu.c,721 :: 		loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
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
;Menu.c,722 :: 		}
L_checkKey221:
;Menu.c,723 :: 		break;
	GOTO       L_checkKey198
;Menu.c,725 :: 		}
L_checkKey197:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey199
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey204
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey213
L_checkKey198:
;Menu.c,726 :: 		}
L_checkKey196:
;Menu.c,727 :: 		break;
	GOTO       L_checkKey102
;Menu.c,728 :: 		case LDRVal:
L_checkKey222:
;Menu.c,729 :: 		if(cMENU == ON)
	BTFSS      _cashedPortD+0, 7
	GOTO       L_checkKey223
;Menu.c,731 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,732 :: 		editValue = ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,733 :: 		Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
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
;Menu.c,734 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,735 :: 		}
	GOTO       L_checkKey224
L_checkKey223:
;Menu.c,738 :: 		switch(subMenu)
	GOTO       L_checkKey225
;Menu.c,740 :: 		case LDRValEnable:
L_checkKey227:
;Menu.c,741 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey228
;Menu.c,743 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,744 :: 		}
L_checkKey228:
;Menu.c,745 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey280
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey280
	GOTO       L_checkKey231
L__checkKey280:
;Menu.c,747 :: 		isEnabled = !isEnabled;
	MOVLW
	XORWF      _isEnabled+0, 1
;Menu.c,748 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,749 :: 		}
L_checkKey231:
;Menu.c,750 :: 		break;
	GOTO       L_checkKey226
;Menu.c,751 :: 		case LDRValHeigh:
L_checkKey232:
;Menu.c,752 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey233
;Menu.c,754 :: 		subMenu = LDRValLow;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,755 :: 		editValue =  ee_read(EEPADDR_LDRValLow);
	MOVLW      12
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,756 :: 		}
L_checkKey233:
;Menu.c,757 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey234
;Menu.c,759 :: 		editValue += 2;
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
;Menu.c,760 :: 		if (editValue > 441)   editValue = 81;
	MOVF       R1+1, 0
	SUBLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey331
	MOVF       R1+0, 0
	SUBLW      185
L__checkKey331:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey235
	MOVLW      81
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey235:
;Menu.c,762 :: 		}
L_checkKey234:
;Menu.c,763 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey236
;Menu.c,765 :: 		editValue -= 2;
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
;Menu.c,766 :: 		if (editValue < 81) editValue = 441;
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey332
	MOVLW      81
	SUBWF      R1+0, 0
L__checkKey332:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey237
	MOVLW      185
	MOVWF      _editValue+0
	MOVLW      1
	MOVWF      _editValue+1
L_checkKey237:
;Menu.c,767 :: 		}
L_checkKey236:
;Menu.c,768 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey279
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey279
	GOTO       L_checkKey240
L__checkKey279:
;Menu.c,770 :: 		loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
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
;Menu.c,771 :: 		}
L_checkKey240:
;Menu.c,772 :: 		break;
	GOTO       L_checkKey226
;Menu.c,773 :: 		case LDRValLow:
L_checkKey241:
;Menu.c,774 :: 		if(cSELECT == ON )
	BTFSS      _cashedPortD+0, 6
	GOTO       L_checkKey242
;Menu.c,776 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,777 :: 		editValue =  ee_read(EEPADDR_LDRValHeigh);
	MOVLW      10
	MOVWF      FARG_ee_read_addr+0
	CALL       _ee_read+0
	MOVF       R0+0, 0
	MOVWF      _editValue+0
	MOVF       R0+1, 0
	MOVWF      _editValue+1
;Menu.c,778 :: 		}
L_checkKey242:
;Menu.c,779 :: 		if (cPLUS == ON)
	BTFSS      _cashedPortD+0, 5
	GOTO       L_checkKey243
;Menu.c,781 :: 		editValue += 1;
	INCF       _editValue+0, 1
	BTFSC      STATUS+0, 2
	INCF       _editValue+1, 1
;Menu.c,782 :: 		if (editValue > 220)   editValue = 80;
	MOVF       _editValue+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey333
	MOVF       _editValue+0, 0
	SUBLW      220
L__checkKey333:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey244
	MOVLW      80
	MOVWF      _editValue+0
	MOVLW      0
	MOVWF      _editValue+1
L_checkKey244:
;Menu.c,784 :: 		}
L_checkKey243:
;Menu.c,785 :: 		if (cMINUS == ON)
	BTFSS      _cashedPortD+0, 4
	GOTO       L_checkKey245
;Menu.c,787 :: 		editValue -= 1;
	MOVLW      1
	SUBWF      _editValue+0, 1
	BTFSS      STATUS+0, 0
	DECF       _editValue+1, 1
;Menu.c,788 :: 		if (editValue < 80) editValue = 220;
	MOVLW      0
	SUBWF      _editValue+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey334
	MOVLW      80
	SUBWF      _editValue+0, 0
L__checkKey334:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey246
	MOVLW      220
	MOVWF      _editValue+0
	CLRF       _editValue+1
L_checkKey246:
;Menu.c,789 :: 		}
L_checkKey245:
;Menu.c,790 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey278
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey278
	GOTO       L_checkKey249
L__checkKey278:
;Menu.c,792 :: 		loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
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
;Menu.c,793 :: 		}
L_checkKey249:
;Menu.c,794 :: 		break;
	GOTO       L_checkKey226
;Menu.c,796 :: 		}
L_checkKey225:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey227
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey232
	MOVF       _subMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey241
L_checkKey226:
;Menu.c,797 :: 		}
L_checkKey224:
;Menu.c,798 :: 		break;
	GOTO       L_checkKey102
;Menu.c,799 :: 		case OnOFFTimeDay1:
L_checkKey250:
;Menu.c,800 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay1;
	MOVLW      20
	MOVWF      _timeEEAddr+0
;Menu.c,801 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,802 :: 		break;
	GOTO       L_checkKey102
;Menu.c,803 :: 		case OnOFFTime1:
L_checkKey251:
;Menu.c,804 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay1;
	MOVLW      20
	MOVWF      _timeEEAddr+0
;Menu.c,805 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,806 :: 		break;
	GOTO       L_checkKey102
;Menu.c,807 :: 		case OnOFFTimeDay2:
L_checkKey252:
;Menu.c,808 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay2;
	MOVLW      25
	MOVWF      _timeEEAddr+0
;Menu.c,809 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,810 :: 		break;
	GOTO       L_checkKey102
;Menu.c,811 :: 		case OnOFFTime2:
L_checkKey253:
;Menu.c,812 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay2;
	MOVLW      25
	MOVWF      _timeEEAddr+0
;Menu.c,813 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,814 :: 		break;
	GOTO       L_checkKey102
;Menu.c,815 :: 		case OnOFFTimeDay3:
L_checkKey254:
;Menu.c,816 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay3;
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,817 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,818 :: 		break;
	GOTO       L_checkKey102
;Menu.c,819 :: 		case OnOFFTime3:
L_checkKey255:
;Menu.c,820 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay3;
	MOVLW      30
	MOVWF      _timeEEAddr+0
;Menu.c,821 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,822 :: 		break;
	GOTO       L_checkKey102
;Menu.c,823 :: 		case OnOFFTimeDay4:
L_checkKey256:
;Menu.c,824 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay4;
	MOVLW      35
	MOVWF      _timeEEAddr+0
;Menu.c,825 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,826 :: 		break;
	GOTO       L_checkKey102
;Menu.c,827 :: 		case OnOFFTime4:
L_checkKey257:
;Menu.c,828 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay4;
	MOVLW      35
	MOVWF      _timeEEAddr+0
;Menu.c,829 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,830 :: 		break;
	GOTO       L_checkKey102
;Menu.c,831 :: 		case OnOFFTimeDay5:
L_checkKey258:
;Menu.c,832 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay5;
	MOVLW      40
	MOVWF      _timeEEAddr+0
;Menu.c,833 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,834 :: 		break;
	GOTO       L_checkKey102
;Menu.c,835 :: 		case OnOFFTime5:
L_checkKey259:
;Menu.c,836 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay5;
	MOVLW      40
	MOVWF      _timeEEAddr+0
;Menu.c,837 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,838 :: 		break;
	GOTO       L_checkKey102
;Menu.c,839 :: 		case OnOFFTimeDay6:
L_checkKey260:
;Menu.c,840 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay6;
	MOVLW      45
	MOVWF      _timeEEAddr+0
;Menu.c,841 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,842 :: 		break;
	GOTO       L_checkKey102
;Menu.c,843 :: 		case OnOFFTime6:
L_checkKey261:
;Menu.c,844 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay6;
	MOVLW      45
	MOVWF      _timeEEAddr+0
;Menu.c,845 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,846 :: 		break;
	GOTO       L_checkKey102
;Menu.c,847 :: 		case OnOFFTimeDay7:
L_checkKey262:
;Menu.c,848 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay7;
	MOVLW      50
	MOVWF      _timeEEAddr+0
;Menu.c,849 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,850 :: 		break;
	GOTO       L_checkKey102
;Menu.c,851 :: 		case OnOFFTime7:
L_checkKey263:
;Menu.c,852 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay7;
	MOVLW      50
	MOVWF      _timeEEAddr+0
;Menu.c,853 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,854 :: 		break;
	GOTO       L_checkKey102
;Menu.c,855 :: 		case OnOFFTimeDay8:
L_checkKey264:
;Menu.c,856 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay8;
	MOVLW      55
	MOVWF      _timeEEAddr+0
;Menu.c,857 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,858 :: 		break;
	GOTO       L_checkKey102
;Menu.c,859 :: 		case OnOFFTime8:
L_checkKey265:
;Menu.c,860 :: 		timeEEAddr=EEPADDR_OnOFFTimeDay8;
	MOVLW      55
	MOVWF      _timeEEAddr+0
;Menu.c,861 :: 		OnOFFTimeDayDisplay();
	CALL       _OnOFFTimeDayDisplay+0
;Menu.c,862 :: 		break;
	GOTO       L_checkKey102
;Menu.c,864 :: 		default:
L_checkKey266:
;Menu.c,865 :: 		waitCount = 500;
	MOVLW      244
	MOVWF      _waitCount+0
	MOVLW      1
	MOVWF      _waitCount+1
;Menu.c,866 :: 		break;
	GOTO       L_checkKey102
;Menu.c,867 :: 		}
L_checkKey101:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey103
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey104
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey142
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey166
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey194
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey222
	MOVF       _crntMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey250
	MOVF       _crntMenu+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey251
	MOVF       _crntMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey252
	MOVF       _crntMenu+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey253
	MOVF       _crntMenu+0, 0
	XORLW      10
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey254
	MOVF       _crntMenu+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey255
	MOVF       _crntMenu+0, 0
	XORLW      12
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey256
	MOVF       _crntMenu+0, 0
	XORLW      13
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey257
	MOVF       _crntMenu+0, 0
	XORLW      14
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey258
	MOVF       _crntMenu+0, 0
	XORLW      15
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey259
	MOVF       _crntMenu+0, 0
	XORLW      16
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey260
	MOVF       _crntMenu+0, 0
	XORLW      17
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey261
	MOVF       _crntMenu+0, 0
	XORLW      18
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey262
	MOVF       _crntMenu+0, 0
	XORLW      19
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey263
	MOVF       _crntMenu+0, 0
	XORLW      20
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey264
	MOVF       _crntMenu+0, 0
	XORLW      21
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey265
	GOTO       L_checkKey266
L_checkKey102:
;Menu.c,868 :: 		if(cashedPortD > 0){
	MOVF       _cashedPortD+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey267
;Menu.c,869 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,870 :: 		}
L_checkKey267:
;Menu.c,871 :: 		if (cPLUS == ON || cMINUS == ON)
	BTFSC      _cashedPortD+0, 5
	GOTO       L__checkKey277
	BTFSC      _cashedPortD+0, 4
	GOTO       L__checkKey277
	GOTO       L_checkKey270
L__checkKey277:
;Menu.c,873 :: 		isEdited = 1;
	BSF        _isEdited+0, BitPos(_isEdited+0)
;Menu.c,874 :: 		}
L_checkKey270:
;Menu.c,876 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_checkKey271:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey271
	DECFSZ     R12+0, 1
	GOTO       L_checkKey271
	DECFSZ     R11+0, 1
	GOTO       L_checkKey271
	NOP
;Menu.c,877 :: 		waitCount++;
	INCF       _waitCount+0, 1
	BTFSC      STATUS+0, 2
	INCF       _waitCount+1, 1
;Menu.c,878 :: 		if(waitCount>200){
	MOVF       _waitCount+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey335
	MOVF       _waitCount+0, 0
	SUBLW      200
L__checkKey335:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey272
;Menu.c,879 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,880 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,881 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;Menu.c,882 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,883 :: 		}
L_checkKey272:
;Menu.c,886 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey91
;Menu.c,887 :: 		saveValue();
	CALL       _saveValue+0
;Menu.c,889 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
