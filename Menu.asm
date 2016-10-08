
_menuPortPinInt:

;Menu.c,48 :: 		void menuPortPinInt(){
;Menu.c,51 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,52 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,53 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,54 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,57 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_checkKey:

;Menu.c,59 :: 		void checkKey(){
;Menu.c,61 :: 		do{
L_checkKey0:
;Menu.c,62 :: 		if (MENU == ON) {
	BTFSS      PORTD+0, 7
	GOTO       L_checkKey3
;Menu.c,64 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,65 :: 		switch (crntMenu) {
	GOTO       L_checkKey4
;Menu.c,66 :: 		case None:
L_checkKey6:
;Menu.c,67 :: 		Lcd_Cmd(_LCD_UNDERLINE_ON);
	MOVLW      14
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,68 :: 		crntMenu = Date;
	MOVLW      1
	MOVWF      _crntMenu+0
;Menu.c,69 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,70 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,71 :: 		break;
	GOTO       L_checkKey5
;Menu.c,72 :: 		case Date:
L_checkKey7:
;Menu.c,73 :: 		crntMenu = Time;
	MOVLW      2
	MOVWF      _crntMenu+0
;Menu.c,74 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,75 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,76 :: 		break;
	GOTO       L_checkKey5
;Menu.c,77 :: 		case Time:
L_checkKey8:
;Menu.c,78 :: 		crntMenu = Voltage;
	MOVLW      3
	MOVWF      _crntMenu+0
;Menu.c,79 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,80 :: 		Lcd_Out(1,1, "Volt Heigh Low");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Menu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,81 :: 		loadEnHeighLow(voltHeigh(),voltLow());
	CALL       _voltLow+0
	MOVF       R0+0, 0
	MOVWF      FLOC__checkKey+0
	MOVF       R0+1, 0
	MOVWF      FLOC__checkKey+1
	CALL       _voltHeigh+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       FLOC__checkKey+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       FLOC__checkKey+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CALL       _loadEnHeighLow+0
;Menu.c,82 :: 		break;
	GOTO       L_checkKey5
;Menu.c,83 :: 		case Voltage:
L_checkKey9:
;Menu.c,84 :: 		crntMenu = Current;
	MOVLW      4
	MOVWF      _crntMenu+0
;Menu.c,85 :: 		subMenu = CurrentEnable;
	CLRF       _subMenu+0
;Menu.c,86 :: 		Lcd_Out(1,1, "Amp Heigh Low");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Menu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,87 :: 		loadEnHeighLow(currHeigh(),currLow());
	CALL       _currLow+0
	MOVF       R0+0, 0
	MOVWF      FLOC__checkKey+0
	MOVF       R0+1, 0
	MOVWF      FLOC__checkKey+1
	CALL       _currHeigh+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       FLOC__checkKey+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       FLOC__checkKey+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CALL       _loadEnHeighLow+0
;Menu.c,88 :: 		break;
	GOTO       L_checkKey5
;Menu.c,89 :: 		case Current:
L_checkKey10:
;Menu.c,90 :: 		crntMenu = LDRVal;
	MOVLW      5
	MOVWF      _crntMenu+0
;Menu.c,91 :: 		subMenu = LDRValEnable;
	CLRF       _subMenu+0
;Menu.c,92 :: 		Lcd_Out(1,1, "LDR Heigh Low");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Menu+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Menu.c,93 :: 		loadEnHeighLow(currHeigh(),currLow());
	CALL       _currLow+0
	MOVF       R0+0, 0
	MOVWF      FLOC__checkKey+0
	MOVF       R0+1, 0
	MOVWF      FLOC__checkKey+1
	CALL       _currHeigh+0
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
	MOVF       FLOC__checkKey+0, 0
	MOVWF      FARG_loadEnHeighLow_low+0
	MOVF       FLOC__checkKey+1, 0
	MOVWF      FARG_loadEnHeighLow_low+1
	CALL       _loadEnHeighLow+0
;Menu.c,94 :: 		break;
	GOTO       L_checkKey5
;Menu.c,95 :: 		default:
L_checkKey11:
;Menu.c,96 :: 		crntMenu = None;
	CLRF       _crntMenu+0
;Menu.c,97 :: 		subMenu = NoEdit;
	CLRF       _subMenu+0
;Menu.c,98 :: 		strcpy(lcdrow1,"00:00:00 000 TUE");
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr4_Menu+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Menu.c,99 :: 		strcpy(lcdrow2,"00/00/00 00.0A  ");
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr5_Menu+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Menu.c,101 :: 		break;
	GOTO       L_checkKey5
;Menu.c,102 :: 		}
L_checkKey4:
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey6
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey7
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey8
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey9
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey10
	GOTO       L_checkKey11
L_checkKey5:
;Menu.c,103 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,104 :: 		}else if (SELECT == ON){
	GOTO       L_checkKey12
L_checkKey3:
	BTFSS      PORTD+0, 6
	GOTO       L_checkKey13
;Menu.c,105 :: 		delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_checkKey14:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey14
	DECFSZ     R12+0, 1
	GOTO       L_checkKey14
;Menu.c,106 :: 		switch (crntMenu) {
	GOTO       L_checkKey15
;Menu.c,107 :: 		case Date:
L_checkKey17:
;Menu.c,108 :: 		switch(subMenu){
	GOTO       L_checkKey18
;Menu.c,109 :: 		case DateDay:
L_checkKey20:
;Menu.c,110 :: 		subMenu = DateMonth;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,111 :: 		break;
	GOTO       L_checkKey19
;Menu.c,112 :: 		case DateMonth:
L_checkKey21:
;Menu.c,113 :: 		subMenu = DateYear;
	MOVLW      6
	MOVWF      _subMenu+0
;Menu.c,114 :: 		break;
	GOTO       L_checkKey19
;Menu.c,115 :: 		case DateYear:
L_checkKey22:
;Menu.c,116 :: 		subMenu = DateWeekDay;
	MOVLW      13
	MOVWF      _subMenu+0
;Menu.c,117 :: 		break;
	GOTO       L_checkKey19
;Menu.c,118 :: 		default:
L_checkKey23:
;Menu.c,119 :: 		subMenu = DateDay;
	CLRF       _subMenu+0
;Menu.c,120 :: 		}
	GOTO       L_checkKey19
L_checkKey18:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey20
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey21
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey22
	GOTO       L_checkKey23
L_checkKey19:
;Menu.c,121 :: 		break;
	GOTO       L_checkKey16
;Menu.c,122 :: 		case Time:
L_checkKey24:
;Menu.c,123 :: 		switch(subMenu){
	GOTO       L_checkKey25
;Menu.c,124 :: 		case TimeHour:
L_checkKey27:
;Menu.c,125 :: 		subMenu = TimeMinute;
	MOVLW      3
	MOVWF      _subMenu+0
;Menu.c,126 :: 		break;
	GOTO       L_checkKey26
;Menu.c,127 :: 		default:
L_checkKey28:
;Menu.c,128 :: 		subMenu = TimeHour;
	CLRF       _subMenu+0
;Menu.c,129 :: 		}
	GOTO       L_checkKey26
L_checkKey25:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey27
	GOTO       L_checkKey28
L_checkKey26:
;Menu.c,131 :: 		break;
	GOTO       L_checkKey16
;Menu.c,132 :: 		case Voltage:
L_checkKey29:
;Menu.c,133 :: 		switch(subMenu){
	GOTO       L_checkKey30
;Menu.c,134 :: 		case VoltageEnable:
L_checkKey32:
;Menu.c,135 :: 		subMenu = VoltageHigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,136 :: 		break;
	GOTO       L_checkKey31
;Menu.c,137 :: 		case VoltageHigh:
L_checkKey33:
;Menu.c,138 :: 		subMenu = VoltageLow; break;
	MOVLW      13
	MOVWF      _subMenu+0
	GOTO       L_checkKey31
;Menu.c,139 :: 		default:
L_checkKey34:
;Menu.c,140 :: 		subMenu = VoltageEnable;
	CLRF       _subMenu+0
;Menu.c,141 :: 		}
	GOTO       L_checkKey31
L_checkKey30:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey32
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey33
	GOTO       L_checkKey34
L_checkKey31:
;Menu.c,142 :: 		break;
	GOTO       L_checkKey16
;Menu.c,143 :: 		case Current:
L_checkKey35:
;Menu.c,144 :: 		switch(subMenu){
	GOTO       L_checkKey36
;Menu.c,145 :: 		case CurrentEnable:
L_checkKey38:
;Menu.c,146 :: 		subMenu = CurrentHeigh; break;
	MOVLW      8
	MOVWF      _subMenu+0
	GOTO       L_checkKey37
;Menu.c,147 :: 		case CurrentHeigh:
L_checkKey39:
;Menu.c,148 :: 		subMenu = CurrentLow; break;
	MOVLW      13
	MOVWF      _subMenu+0
	GOTO       L_checkKey37
;Menu.c,149 :: 		default:
L_checkKey40:
;Menu.c,150 :: 		subMenu = CurrentHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,151 :: 		}
	GOTO       L_checkKey37
L_checkKey36:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey38
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey39
	GOTO       L_checkKey40
L_checkKey37:
;Menu.c,152 :: 		break;
	GOTO       L_checkKey16
;Menu.c,153 :: 		case LDRVal:
L_checkKey41:
;Menu.c,154 :: 		switch(subMenu){
	GOTO       L_checkKey42
;Menu.c,155 :: 		case LDRValEnable:
L_checkKey44:
;Menu.c,156 :: 		subMenu = LDRValHeigh; break;
	MOVLW      8
	MOVWF      _subMenu+0
	GOTO       L_checkKey43
;Menu.c,157 :: 		case LDRValHeigh:
L_checkKey45:
;Menu.c,158 :: 		subMenu = LDRValLow; break;
	MOVLW      13
	MOVWF      _subMenu+0
	GOTO       L_checkKey43
;Menu.c,159 :: 		default:
L_checkKey46:
;Menu.c,160 :: 		subMenu = LDRValHeigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,161 :: 		}
	GOTO       L_checkKey43
L_checkKey42:
	MOVF       _subMenu+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey44
	MOVF       _subMenu+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey45
	GOTO       L_checkKey46
L_checkKey43:
;Menu.c,162 :: 		break;
	GOTO       L_checkKey16
;Menu.c,163 :: 		default:
L_checkKey47:
;Menu.c,164 :: 		break;
	GOTO       L_checkKey16
;Menu.c,165 :: 		}
L_checkKey15:
	MOVF       _crntMenu+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey17
	MOVF       _crntMenu+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey24
	MOVF       _crntMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey29
	MOVF       _crntMenu+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey35
	MOVF       _crntMenu+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey41
	GOTO       L_checkKey47
L_checkKey16:
;Menu.c,166 :: 		setCursorPosition(subMenu);
	MOVF       _subMenu+0, 0
	MOVWF      FARG_setCursorPosition_position+0
	CALL       _setCursorPosition+0
;Menu.c,167 :: 		}else if (PLUS == ON){
	GOTO       L_checkKey48
L_checkKey13:
	BTFSS      PORTD+0, 5
	GOTO       L_checkKey49
;Menu.c,168 :: 		delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_checkKey50:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey50
	DECFSZ     R12+0, 1
	GOTO       L_checkKey50
;Menu.c,170 :: 		}else if (MINUS == ON){
	GOTO       L_checkKey51
L_checkKey49:
	BTFSS      PORTD+0, 5
	GOTO       L_checkKey52
;Menu.c,171 :: 		delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_checkKey53:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey53
	DECFSZ     R12+0, 1
	GOTO       L_checkKey53
;Menu.c,173 :: 		}
L_checkKey52:
L_checkKey51:
L_checkKey48:
L_checkKey12:
;Menu.c,174 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_checkKey54:
	DECFSZ     R13+0, 1
	GOTO       L_checkKey54
	DECFSZ     R12+0, 1
	GOTO       L_checkKey54
	DECFSZ     R11+0, 1
	GOTO       L_checkKey54
	NOP
	NOP
;Menu.c,175 :: 		}while(crntMenu != None);
	MOVF       _crntMenu+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_checkKey0
;Menu.c,178 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
