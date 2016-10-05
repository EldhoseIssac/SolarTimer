
_initLCD:

;lcd.c,35 :: 		void initLCD(){
;lcd.c,36 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;lcd.c,37 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,38 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,39 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD

_BCD2HignerCh:

;lcd.c,40 :: 		unsigned char BCD2HignerCh(unsigned int bcd)
;lcd.c,42 :: 		return (((bcd >> 8) & 0x0F)+ '0');
	MOVF       FARG_BCD2HignerCh_bcd+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,43 :: 		}
L_end_BCD2HignerCh:
	RETURN
; end of _BCD2HignerCh

_BCD2UpperCh:

;lcd.c,44 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;lcd.c,46 :: 		return (((bcd >> 4) & 0x0F) + '0');
	MOVF       FARG_BCD2UpperCh_bcd+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,47 :: 		}
L_end_BCD2UpperCh:
	RETURN
; end of _BCD2UpperCh

_BCD2LowerCh:

;lcd.c,49 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;lcd.c,51 :: 		return ((bcd & 0x0F) + '0');
	MOVLW      15
	ANDWF      FARG_BCD2LowerCh_bcd+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,52 :: 		}
L_end_BCD2LowerCh:
	RETURN
; end of _BCD2LowerCh

_Binary2BCD:

;lcd.c,54 :: 		unsigned int Binary2BCD(int a)
;lcd.c,58 :: 		t1 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Binary2BCD_a+0, 0
	MOVWF      R0+0
	MOVF       FARG_Binary2BCD_a+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;lcd.c,59 :: 		t1 = t1 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+3
;lcd.c,60 :: 		a = a/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_Binary2BCD_a+0, 0
	MOVWF      R0+0
	MOVF       FARG_Binary2BCD_a+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Binary2BCD+1
	MOVF       R0+1, 0
	MOVWF      FLOC__Binary2BCD+2
	MOVF       FLOC__Binary2BCD+1, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FLOC__Binary2BCD+2, 0
	MOVWF      FARG_Binary2BCD_a+1
;lcd.c,61 :: 		t2 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Binary2BCD+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Binary2BCD+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;lcd.c,62 :: 		t2 = t2 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R2+0
;lcd.c,63 :: 		t2 = t2 << 4;
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
;lcd.c,64 :: 		t2 = 0xF0 & t2;
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+0
;lcd.c,65 :: 		a = a/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Binary2BCD+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Binary2BCD+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
;lcd.c,66 :: 		t3 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;lcd.c,67 :: 		t3 = t3 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVLW      0
	ANDWF      R4+1, 1
;lcd.c,68 :: 		t3 = t3 << 8;
	MOVF       R4+0, 0
	MOVWF      R2+1
	CLRF       R2+0
;lcd.c,69 :: 		t3 +=  t1 | t2;
	MOVF       FLOC__Binary2BCD+0, 0
	IORWF      FLOC__Binary2BCD+3, 0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;lcd.c,70 :: 		return t3;
;lcd.c,71 :: 		}
L_end_Binary2BCD:
	RETURN
; end of _Binary2BCD

_BCD2Binary:

;lcd.c,73 :: 		int BCD2Binary(int a)
;lcd.c,76 :: 		t = a & 0x0F;
	MOVLW      15
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      FLOC__BCD2Binary+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      FLOC__BCD2Binary+1
	MOVLW      0
	ANDWF      FLOC__BCD2Binary+1, 1
;lcd.c,78 :: 		a = 0xF0 & a;
	MOVLW      240
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      R3+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      R3+1
	MOVLW      0
	ANDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      FARG_BCD2Binary_a+0
	MOVF       R3+1, 0
	MOVWF      FARG_BCD2Binary_a+1
;lcd.c,79 :: 		t = a >> 4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__BCD2Binary26:
	BTFSC      STATUS+0, 2
	GOTO       L__BCD2Binary27
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__BCD2Binary26
L__BCD2Binary27:
;lcd.c,80 :: 		t = 0x0F & t;
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
;lcd.c,81 :: 		r = t*10 + r;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       FLOC__BCD2Binary+0, 0
	ADDWF      R0+0, 1
	MOVF       FLOC__BCD2Binary+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;lcd.c,82 :: 		return r;
;lcd.c,83 :: 		}
L_end_BCD2Binary:
	RETURN
; end of _BCD2Binary

_displayTimeDate:

;lcd.c,84 :: 		void displayTimeDate(){
;lcd.c,86 :: 		lcdrow1[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+0
;lcd.c,87 :: 		lcdrow1[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+1
;lcd.c,88 :: 		lcdrow1[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+3
;lcd.c,89 :: 		lcdrow1[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+4
;lcd.c,90 :: 		lcdrow1[6] = BCD2UpperCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+6
;lcd.c,91 :: 		lcdrow1[7] = BCD2LowerCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+7
;lcd.c,93 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,94 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,95 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,96 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,97 :: 		lcdrow2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,98 :: 		lcdrow2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,99 :: 		switch(dday){
	GOTO       L_displayTimeDate0
;lcd.c,100 :: 		case 1: lcdrow1[13]='S';lcdrow1[14]='u'; lcdrow1[15]='n';break;
L_displayTimeDate2:
	MOVLW      83
	MOVWF      _lcdrow1+13
	MOVLW      117
	MOVWF      _lcdrow1+14
	MOVLW      110
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,101 :: 		case 2: lcdrow1[13]='M';lcdrow1[14]='o'; lcdrow1[15]='n';break;
L_displayTimeDate3:
	MOVLW      77
	MOVWF      _lcdrow1+13
	MOVLW      111
	MOVWF      _lcdrow1+14
	MOVLW      110
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,102 :: 		case 3: lcdrow1[13]='T';lcdrow1[14]='u'; lcdrow1[15]='e';break;
L_displayTimeDate4:
	MOVLW      84
	MOVWF      _lcdrow1+13
	MOVLW      117
	MOVWF      _lcdrow1+14
	MOVLW      101
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,103 :: 		case 4: lcdrow1[13]='W';lcdrow1[14]='e'; lcdrow1[15]='d';break;
L_displayTimeDate5:
	MOVLW      87
	MOVWF      _lcdrow1+13
	MOVLW      101
	MOVWF      _lcdrow1+14
	MOVLW      100
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,104 :: 		case 5: lcdrow1[13]='T';lcdrow1[14]='h'; lcdrow1[15]='u';break;
L_displayTimeDate6:
	MOVLW      84
	MOVWF      _lcdrow1+13
	MOVLW      104
	MOVWF      _lcdrow1+14
	MOVLW      117
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,105 :: 		case 6: lcdrow1[13]='F';lcdrow1[14]='r'; lcdrow1[15]='i';break;
L_displayTimeDate7:
	MOVLW      70
	MOVWF      _lcdrow1+13
	MOVLW      114
	MOVWF      _lcdrow1+14
	MOVLW      105
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,106 :: 		case 7: lcdrow1[13]='S';lcdrow1[14]='a'; lcdrow1[15]='t';break;
L_displayTimeDate8:
	MOVLW      83
	MOVWF      _lcdrow1+13
	MOVLW      97
	MOVWF      _lcdrow1+14
	MOVLW      116
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,107 :: 		}
L_displayTimeDate0:
	MOVF       _dday+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_displayTimeDate2
	MOVF       _dday+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_displayTimeDate3
	MOVF       _dday+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_displayTimeDate4
	MOVF       _dday+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_displayTimeDate5
	MOVF       _dday+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_displayTimeDate6
	MOVF       _dday+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_displayTimeDate7
	MOVF       _dday+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_displayTimeDate8
L_displayTimeDate1:
;lcd.c,108 :: 		}
L_end_displayTimeDate:
	RETURN
; end of _displayTimeDate

_loadTimeEdit:

;lcd.c,109 :: 		void loadTimeEdit(){
;lcd.c,110 :: 		lcdrow2[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,111 :: 		lcdrow2[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,112 :: 		lcdrow2[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,113 :: 		lcdrow2[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,114 :: 		lcdrow2[6] = BCD2UpperCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,115 :: 		lcdrow2[7] = BCD2LowerCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,116 :: 		}
L_end_loadTimeEdit:
	RETURN
; end of _loadTimeEdit

_loadDateEdit:

;lcd.c,117 :: 		void loadDateEdit(){
;lcd.c,118 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,119 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,120 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,121 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,122 :: 		lcdrow2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,123 :: 		lcdrow2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,124 :: 		switch(dday){
	GOTO       L_loadDateEdit9
;lcd.c,125 :: 		case 1: lcdrow2[13]='S';lcdrow2[14]='u'; lcdrow2[15]='n';break;
L_loadDateEdit11:
	MOVLW      83
	MOVWF      _lcdrow2+13
	MOVLW      117
	MOVWF      _lcdrow2+14
	MOVLW      110
	MOVWF      _lcdrow2+15
	GOTO       L_loadDateEdit10
;lcd.c,126 :: 		case 2: lcdrow2[13]='M';lcdrow2[14]='o'; lcdrow2[15]='n';break;
L_loadDateEdit12:
	MOVLW      77
	MOVWF      _lcdrow2+13
	MOVLW      111
	MOVWF      _lcdrow2+14
	MOVLW      110
	MOVWF      _lcdrow2+15
	GOTO       L_loadDateEdit10
;lcd.c,127 :: 		case 3: lcdrow2[13]='T';lcdrow2[14]='u'; lcdrow2[15]='e';break;
L_loadDateEdit13:
	MOVLW      84
	MOVWF      _lcdrow2+13
	MOVLW      117
	MOVWF      _lcdrow2+14
	MOVLW      101
	MOVWF      _lcdrow2+15
	GOTO       L_loadDateEdit10
;lcd.c,128 :: 		case 4: lcdrow2[13]='W';lcdrow2[14]='e'; lcdrow2[15]='d';break;
L_loadDateEdit14:
	MOVLW      87
	MOVWF      _lcdrow2+13
	MOVLW      101
	MOVWF      _lcdrow2+14
	MOVLW      100
	MOVWF      _lcdrow2+15
	GOTO       L_loadDateEdit10
;lcd.c,129 :: 		case 5: lcdrow2[13]='T';lcdrow2[14]='h'; lcdrow2[15]='u';break;
L_loadDateEdit15:
	MOVLW      84
	MOVWF      _lcdrow2+13
	MOVLW      104
	MOVWF      _lcdrow2+14
	MOVLW      117
	MOVWF      _lcdrow2+15
	GOTO       L_loadDateEdit10
;lcd.c,130 :: 		case 6: lcdrow2[13]='F';lcdrow2[14]='r'; lcdrow2[15]='i';break;
L_loadDateEdit16:
	MOVLW      70
	MOVWF      _lcdrow2+13
	MOVLW      114
	MOVWF      _lcdrow2+14
	MOVLW      105
	MOVWF      _lcdrow2+15
	GOTO       L_loadDateEdit10
;lcd.c,131 :: 		case 7: lcdrow2[13]='S';lcdrow2[14]='a'; lcdrow2[15]='t';break;
L_loadDateEdit17:
	MOVLW      83
	MOVWF      _lcdrow2+13
	MOVLW      97
	MOVWF      _lcdrow2+14
	MOVLW      116
	MOVWF      _lcdrow2+15
	GOTO       L_loadDateEdit10
;lcd.c,132 :: 		}
L_loadDateEdit9:
	MOVF       _dday+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_loadDateEdit11
	MOVF       _dday+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_loadDateEdit12
	MOVF       _dday+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_loadDateEdit13
	MOVF       _dday+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_loadDateEdit14
	MOVF       _dday+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_loadDateEdit15
	MOVF       _dday+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_loadDateEdit16
	MOVF       _dday+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_loadDateEdit17
L_loadDateEdit10:
;lcd.c,133 :: 		}
L_end_loadDateEdit:
	RETURN
; end of _loadDateEdit

_loadEnHeighLow:

;lcd.c,135 :: 		void loadEnHeighLow(int heigh,int low){
;lcd.c,136 :: 		unsigned int disVolt = Binary2BCD(heigh);
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_disVolt_L0+1
;lcd.c,137 :: 		unsigned int discrr= Binary2BCD(low);
	MOVF       FARG_loadEnHeighLow_low+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FARG_loadEnHeighLow_low+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_discrr_L0+1
;lcd.c,139 :: 		if (heigh>0) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_loadEnHeighLow_heigh+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnHeighLow32
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	SUBLW      0
L__loadEnHeighLow32:
	BTFSC      STATUS+0, 0
	GOTO       L_loadEnHeighLow18
;lcd.c,140 :: 		lcdrow1[0] = 'O';
	MOVLW      79
	MOVWF      _lcdrow1+0
;lcd.c,141 :: 		lcdrow1[1] = 'N';
	MOVLW      78
	MOVWF      _lcdrow1+1
;lcd.c,142 :: 		heigh = heigh>>1;
	RRF        FARG_loadEnHeighLow_heigh+1, 1
	RRF        FARG_loadEnHeighLow_heigh+0, 1
	BCF        FARG_loadEnHeighLow_heigh+1, 7
	BTFSC      FARG_loadEnHeighLow_heigh+1, 6
	BSF        FARG_loadEnHeighLow_heigh+1, 7
;lcd.c,143 :: 		lcdrow2[6] = BCD2HignerCh(disVolt);
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       loadEnHeighLow_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,144 :: 		lcdrow2[7] = BCD2UpperCh(disVolt);
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,145 :: 		lcdrow2[8] = BCD2LowerCh(disVolt);
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+8
;lcd.c,147 :: 		lcdrow2[10] = BCD2HignerCh(discrr);
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       loadEnHeighLow_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+10
;lcd.c,148 :: 		lcdrow2[11] = BCD2UpperCh(discrr);
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+11
;lcd.c,149 :: 		lcdrow2[12] = BCD2LowerCh(discrr);
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+12
;lcd.c,150 :: 		}else{
	GOTO       L_loadEnHeighLow19
L_loadEnHeighLow18:
;lcd.c,151 :: 		strcpy(lcdrow2, "OFF   0.0  0.0");
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr1_lcd+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;lcd.c,152 :: 		}
L_loadEnHeighLow19:
;lcd.c,154 :: 		}
L_end_loadEnHeighLow:
	RETURN
; end of _loadEnHeighLow

_displayVoltageCurrent:

;lcd.c,155 :: 		void displayVoltageCurrent(){
;lcd.c,158 :: 		disVolt = Binary2BCD(voltage);
	MOVF       _voltage+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _voltage+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+1
;lcd.c,159 :: 		discrr = Binary2BCD(current);
	MOVF       _current+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _current+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_discrr_L0+1
;lcd.c,160 :: 		lcdrow1[9] = BCD2HignerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+9
;lcd.c,161 :: 		lcdrow1[10] = BCD2UpperCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+10
;lcd.c,162 :: 		lcdrow1[11] = BCD2LowerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+11
;lcd.c,164 :: 		lcdrow2[9] = BCD2HignerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+9
;lcd.c,165 :: 		lcdrow2[10] = BCD2UpperCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+10
;lcd.c,166 :: 		lcdrow2[12] = BCD2LowerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+12
;lcd.c,168 :: 		}
L_end_displayVoltageCurrent:
	RETURN
; end of _displayVoltageCurrent

_loadRamToDisp:

;lcd.c,169 :: 		void loadRamToDisp(){
;lcd.c,170 :: 		Lcd_out(1, 1, lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,171 :: 		Lcd_out(2, 1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,172 :: 		}
L_end_loadRamToDisp:
	RETURN
; end of _loadRamToDisp
