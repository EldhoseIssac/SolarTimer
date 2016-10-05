
_menuPortPinInt:

;Menu.c,78 :: 		void menuPortPinInt(){
;Menu.c,81 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,82 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,83 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,84 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,87 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_checkKey:

;Menu.c,89 :: 		void checkKey(){
;Menu.c,92 :: 		if (MENU) {
	BTFSS      PORTD+0, 7
	GOTO       L_checkKey0
;Menu.c,93 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Menu.c,94 :: 		switch (crntMenu) {
	GOTO       L_checkKey1
;Menu.c,95 :: 		case None:
L_checkKey3:
;Menu.c,96 :: 		crntMenu = Date;
	MOVLW      1
	MOVWF      _crntMenu+0
;Menu.c,97 :: 		subMenu = DateDay;
	MOVLW      1
	MOVWF      _subMenu+0
;Menu.c,98 :: 		strcpy(lcdrow1, "Date");
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_Menu+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Menu.c,99 :: 		loadDateEdit();
	CALL       _loadDateEdit+0
;Menu.c,100 :: 		break;
	GOTO       L_checkKey2
;Menu.c,101 :: 		case Date:
L_checkKey4:
;Menu.c,102 :: 		crntMenu = Time;
	MOVLW      2
	MOVWF      _crntMenu+0
;Menu.c,103 :: 		subMenu = TimeHour;
	MOVLW      5
	MOVWF      _subMenu+0
;Menu.c,104 :: 		strcpy(lcdrow1, "Time");
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr2_Menu+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Menu.c,105 :: 		loadTimeEdit();
	CALL       _loadTimeEdit+0
;Menu.c,106 :: 		break;
	GOTO       L_checkKey2
;Menu.c,107 :: 		case Voltage:
L_checkKey5:
;Menu.c,108 :: 		crntMenu = Voltage;
	MOVLW      3
	MOVWF      _crntMenu+0
;Menu.c,109 :: 		subMenu = VoltageHigh;
	MOVLW      8
	MOVWF      _subMenu+0
;Menu.c,110 :: 		strcpy(lcdrow1, "Volt Heigh Low");
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr3_Menu+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Menu.c,111 :: 		val1 = voltHeigh();
	CALL       _voltHeigh+0
	MOVF       R0+0, 0
	MOVWF      checkKey_val1_L0+0
	MOVF       R0+1, 0
	MOVWF      checkKey_val1_L0+1
;Menu.c,112 :: 		val2 = voltLow();
	CALL       _voltLow+0
;Menu.c,113 :: 		if (val1>0) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      checkKey_val1_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey10
	MOVF       checkKey_val1_L0+0, 0
	SUBLW      0
L__checkKey10:
	BTFSC      STATUS+0, 0
	GOTO       L_checkKey6
;Menu.c,114 :: 		lcdrow1[0] = 'O';
	MOVLW      79
	MOVWF      _lcdrow1+0
;Menu.c,115 :: 		lcdrow1[1] = 'N';
	MOVLW      78
	MOVWF      _lcdrow1+1
;Menu.c,117 :: 		}else{
	GOTO       L_checkKey7
L_checkKey6:
;Menu.c,118 :: 		strcpy(lcdrow2, "OFF   0.0  0.0");
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr4_Menu+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Menu.c,119 :: 		}
L_checkKey7:
;Menu.c,120 :: 		break;
	GOTO       L_checkKey2
;Menu.c,123 :: 		}
L_checkKey1:
	MOVLW      0
	BTFSC      _crntMenu+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey11
	MOVLW      0
	XORWF      _crntMenu+0, 0
L__checkKey11:
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey3
	MOVLW      0
	BTFSC      _crntMenu+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey12
	MOVLW      1
	XORWF      _crntMenu+0, 0
L__checkKey12:
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey4
	MOVLW      0
	BTFSC      _crntMenu+0, 7
	MOVLW      255
	MOVWF      R0+0
	MOVLW      0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkKey13
	MOVLW      3
	XORWF      _crntMenu+0, 0
L__checkKey13:
	BTFSC      STATUS+0, 2
	GOTO       L_checkKey5
L_checkKey2:
;Menu.c,124 :: 		}
L_checkKey0:
;Menu.c,125 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
