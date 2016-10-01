
_initLCD:

;lcd.c,16 :: 		void initLCD(){
;lcd.c,17 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;lcd.c,18 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,19 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,20 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD

_BCD2HignerCh:

;lcd.c,21 :: 		unsigned char BCD2HignerCh(unsigned int bcd)
;lcd.c,23 :: 		return (((bcd >> 8) & 0x0F)+ '0');
	MOVF       FARG_BCD2HignerCh_bcd+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,24 :: 		}
L_end_BCD2HignerCh:
	RETURN
; end of _BCD2HignerCh

_BCD2UpperCh:

;lcd.c,25 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;lcd.c,27 :: 		return (((bcd >> 4) & 0x0F) + '0');
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
;lcd.c,28 :: 		}
L_end_BCD2UpperCh:
	RETURN
; end of _BCD2UpperCh

_BCD2LowerCh:

;lcd.c,30 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;lcd.c,32 :: 		return ((bcd & 0x0F) + '0');
	MOVLW      15
	ANDWF      FARG_BCD2LowerCh_bcd+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,33 :: 		}
L_end_BCD2LowerCh:
	RETURN
; end of _BCD2LowerCh

_Binary2BCD:

;lcd.c,35 :: 		unsigned int Binary2BCD(int a)
;lcd.c,39 :: 		t1 = a%10;
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
	MOVF       R0+0, 0
	MOVWF      Binary2BCD_t1_L0+0
;lcd.c,40 :: 		t1 = t1 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      Binary2BCD_t1_L0+0
;lcd.c,41 :: 		a = a/10;
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
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
;lcd.c,42 :: 		t2 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      Binary2BCD_t2_L0+0
;lcd.c,43 :: 		t2 = t2 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      Binary2BCD_t2_L0+0
;lcd.c,44 :: 		t2 = t2 << 4;
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
	MOVF       R0+0, 0
	MOVWF      Binary2BCD_t2_L0+0
;lcd.c,45 :: 		t2 = 0xF0 & t2;
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      Binary2BCD_t2_L0+0
;lcd.c,46 :: 		a = a/10;
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
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
;lcd.c,47 :: 		t3 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;lcd.c,48 :: 		t3 = t3 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVLW      0
	ANDWF      R4+1, 1
;lcd.c,49 :: 		t3 = t3 << 8;
	MOVF       R4+0, 0
	MOVWF      R2+1
	CLRF       R2+0
;lcd.c,50 :: 		t3 +=  t1 | t2;
	MOVF       Binary2BCD_t2_L0+0, 0
	IORWF      Binary2BCD_t1_L0+0, 0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;lcd.c,51 :: 		return t3;
;lcd.c,52 :: 		}
L_end_Binary2BCD:
	RETURN
; end of _Binary2BCD

_BCD2Binary:

;lcd.c,54 :: 		int BCD2Binary(int a)
;lcd.c,57 :: 		t = a & 0x0F;
	MOVLW      15
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      BCD2Binary_r_L0+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      BCD2Binary_r_L0+1
	MOVLW      0
	ANDWF      BCD2Binary_r_L0+1, 1
;lcd.c,58 :: 		r = t;
;lcd.c,59 :: 		a = 0xF0 & a;
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
;lcd.c,60 :: 		t = a >> 4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__BCD2Binary15:
	BTFSC      STATUS+0, 2
	GOTO       L__BCD2Binary16
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__BCD2Binary15
L__BCD2Binary16:
;lcd.c,61 :: 		t = 0x0F & t;
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
;lcd.c,62 :: 		r = t*10 + r;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       BCD2Binary_r_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       BCD2Binary_r_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      BCD2Binary_r_L0+0
	MOVF       R0+1, 0
	MOVWF      BCD2Binary_r_L0+1
;lcd.c,63 :: 		return r;
;lcd.c,64 :: 		}
L_end_BCD2Binary:
	RETURN
; end of _BCD2Binary

_displayTimeDate:

;lcd.c,65 :: 		void displayTimeDate(){
;lcd.c,67 :: 		row1[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+0
;lcd.c,68 :: 		row1[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+1
;lcd.c,69 :: 		row1[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+3
;lcd.c,70 :: 		row1[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+4
;lcd.c,71 :: 		row1[6] = BCD2UpperCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+6
;lcd.c,72 :: 		row1[7] = BCD2LowerCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+7
;lcd.c,74 :: 		row2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+0
;lcd.c,75 :: 		row2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+1
;lcd.c,76 :: 		row2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+3
;lcd.c,77 :: 		row2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+4
;lcd.c,78 :: 		row2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+6
;lcd.c,79 :: 		row2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+7
;lcd.c,80 :: 		switch(dday){
	GOTO       L_displayTimeDate0
;lcd.c,81 :: 		case 1: row1[13]='S';row1[14]='u'; row1[15]='n';break;
L_displayTimeDate2:
	MOVLW      83
	MOVWF      _row1+13
	MOVLW      117
	MOVWF      _row1+14
	MOVLW      110
	MOVWF      _row1+15
	GOTO       L_displayTimeDate1
;lcd.c,82 :: 		case 2: row1[13]='M';row1[14]='o'; row1[15]='n';break;
L_displayTimeDate3:
	MOVLW      77
	MOVWF      _row1+13
	MOVLW      111
	MOVWF      _row1+14
	MOVLW      110
	MOVWF      _row1+15
	GOTO       L_displayTimeDate1
;lcd.c,83 :: 		case 3: row1[13]='T';row1[14]='u'; row1[15]='e';break;
L_displayTimeDate4:
	MOVLW      84
	MOVWF      _row1+13
	MOVLW      117
	MOVWF      _row1+14
	MOVLW      101
	MOVWF      _row1+15
	GOTO       L_displayTimeDate1
;lcd.c,84 :: 		case 4: row1[13]='W';row1[14]='e'; row1[15]='d';break;
L_displayTimeDate5:
	MOVLW      87
	MOVWF      _row1+13
	MOVLW      101
	MOVWF      _row1+14
	MOVLW      100
	MOVWF      _row1+15
	GOTO       L_displayTimeDate1
;lcd.c,85 :: 		case 5: row1[13]='T';row1[14]='h'; row1[15]='u';break;
L_displayTimeDate6:
	MOVLW      84
	MOVWF      _row1+13
	MOVLW      104
	MOVWF      _row1+14
	MOVLW      117
	MOVWF      _row1+15
	GOTO       L_displayTimeDate1
;lcd.c,86 :: 		case 6: row1[13]='F';row1[14]='r'; row1[15]='i';break;
L_displayTimeDate7:
	MOVLW      70
	MOVWF      _row1+13
	MOVLW      114
	MOVWF      _row1+14
	MOVLW      105
	MOVWF      _row1+15
	GOTO       L_displayTimeDate1
;lcd.c,87 :: 		case 7: row1[13]='S';row1[14]='a'; row1[15]='t';break;
L_displayTimeDate8:
	MOVLW      83
	MOVWF      _row1+13
	MOVLW      97
	MOVWF      _row1+14
	MOVLW      116
	MOVWF      _row1+15
	GOTO       L_displayTimeDate1
;lcd.c,88 :: 		}
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
;lcd.c,89 :: 		}
L_end_displayTimeDate:
	RETURN
; end of _displayTimeDate

_displayVoltageCurrent:

;lcd.c,90 :: 		void displayVoltageCurrent(){
;lcd.c,93 :: 		disVolt = Binary2BCD(voltage);
	MOVF       _voltage+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _voltage+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+1
;lcd.c,94 :: 		discrr = Binary2BCD(current);
	MOVF       _current+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _current+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_discrr_L0+1
;lcd.c,95 :: 		row1[9] = BCD2HignerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+9
;lcd.c,96 :: 		row1[10] = BCD2UpperCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+10
;lcd.c,97 :: 		row1[11] = BCD2LowerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row1+11
;lcd.c,99 :: 		row2[9] = BCD2HignerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+9
;lcd.c,100 :: 		row2[10] = BCD2UpperCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+10
;lcd.c,101 :: 		row2[12] = BCD2LowerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _row2+12
;lcd.c,103 :: 		}
L_end_displayVoltageCurrent:
	RETURN
; end of _displayVoltageCurrent

_loadRamToDisp:

;lcd.c,104 :: 		void loadRamToDisp(){
;lcd.c,105 :: 		Lcd_out(1, 1, row1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _row1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,106 :: 		Lcd_out(2, 1, row2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _row2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,107 :: 		}
L_end_loadRamToDisp:
	RETURN
; end of _loadRamToDisp
