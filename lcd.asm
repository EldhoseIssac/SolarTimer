
_initLCDRaws:

;lcd.c,42 :: 		void initLCDRaws()
;lcd.c,44 :: 		strCpyLimit(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"),0,16);
	MOVLW      ?lstr_1_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_1_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strCpyLimit_dest+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strCpyLimit_source+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      16
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;lcd.c,45 :: 		strCpyLimit(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "),0,16);
	MOVLW      ?lstr_2_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_2_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strCpyLimit_dest+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strCpyLimit_source+0
	CLRF       FARG_strCpyLimit_from+0
	MOVLW      16
	MOVWF      FARG_strCpyLimit_count+0
	CALL       _strCpyLimit+0
;lcd.c,47 :: 		}
L_end_initLCDRaws:
	RETURN
; end of _initLCDRaws

_initLCD:

;lcd.c,48 :: 		void initLCD(){
;lcd.c,49 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;lcd.c,50 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,51 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,52 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;lcd.c,53 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD

_BCD2HignerCh:

;lcd.c,54 :: 		unsigned char BCD2HignerCh(unsigned int bcd)
;lcd.c,56 :: 		return (((bcd >> 8) & 0x0F)+ '0');
	MOVF       FARG_BCD2HignerCh_bcd+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,57 :: 		}
L_end_BCD2HignerCh:
	RETURN
; end of _BCD2HignerCh

_BCD2UpperCh:

;lcd.c,58 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;lcd.c,60 :: 		return (((bcd >> 4) & 0x0F) + '0');
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
;lcd.c,61 :: 		}
L_end_BCD2UpperCh:
	RETURN
; end of _BCD2UpperCh

_BCD2LowerCh:

;lcd.c,63 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;lcd.c,65 :: 		return ((bcd & 0x0F) + '0');
	MOVLW      15
	ANDWF      FARG_BCD2LowerCh_bcd+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,66 :: 		}
L_end_BCD2LowerCh:
	RETURN
; end of _BCD2LowerCh

_Binary2BCD:

;lcd.c,68 :: 		unsigned int Binary2BCD(int a)
;lcd.c,72 :: 		t1 = a%10;
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
;lcd.c,73 :: 		t1 = t1 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+3
;lcd.c,74 :: 		a = a/10;
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
;lcd.c,75 :: 		t2 = a%10;
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
;lcd.c,76 :: 		t2 = t2 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R2+0
;lcd.c,77 :: 		t2 = t2 << 4;
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
;lcd.c,78 :: 		t2 = 0xF0 & t2;
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+0
;lcd.c,79 :: 		a = a/10;
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
;lcd.c,80 :: 		t3 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;lcd.c,81 :: 		t3 = t3 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVLW      0
	ANDWF      R4+1, 1
;lcd.c,82 :: 		t3 = t3 << 8;
	MOVF       R4+0, 0
	MOVWF      R2+1
	CLRF       R2+0
;lcd.c,83 :: 		t3 +=  t1 | t2;
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
;lcd.c,84 :: 		return t3;
;lcd.c,85 :: 		}
L_end_Binary2BCD:
	RETURN
; end of _Binary2BCD

_BCD2Binary:

;lcd.c,87 :: 		int BCD2Binary(int a)
;lcd.c,90 :: 		t = a & 0x0F;
	MOVLW      15
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      FLOC__BCD2Binary+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      FLOC__BCD2Binary+1
	MOVLW      0
	ANDWF      FLOC__BCD2Binary+1, 1
;lcd.c,92 :: 		a = 0xF0 & a;
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
;lcd.c,93 :: 		t = a >> 4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__BCD2Binary30:
	BTFSC      STATUS+0, 2
	GOTO       L__BCD2Binary31
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__BCD2Binary30
L__BCD2Binary31:
;lcd.c,94 :: 		t = 0x0F & t;
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
;lcd.c,95 :: 		r = t*10 + r;
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
;lcd.c,96 :: 		return r;
;lcd.c,97 :: 		}
L_end_BCD2Binary:
	RETURN
; end of _BCD2Binary

_displayTimeDate:

;lcd.c,98 :: 		void displayTimeDate(){
;lcd.c,100 :: 		lcdrow1[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+0
;lcd.c,101 :: 		lcdrow1[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+1
;lcd.c,102 :: 		lcdrow1[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+3
;lcd.c,103 :: 		lcdrow1[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+4
;lcd.c,104 :: 		lcdrow1[6] = BCD2UpperCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+6
;lcd.c,105 :: 		lcdrow1[7] = BCD2LowerCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+7
;lcd.c,107 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,108 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,109 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,110 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,111 :: 		lcdrow2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,112 :: 		lcdrow2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,113 :: 		switch(dday){
	GOTO       L_displayTimeDate0
;lcd.c,114 :: 		case 1: lcdrow1[13]='S';lcdrow1[14]='u'; lcdrow1[15]='n';break;
L_displayTimeDate2:
	MOVLW      83
	MOVWF      _lcdrow1+13
	MOVLW      117
	MOVWF      _lcdrow1+14
	MOVLW      110
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,115 :: 		case 2: lcdrow1[13]='M';lcdrow1[14]='o'; lcdrow1[15]='n';break;
L_displayTimeDate3:
	MOVLW      77
	MOVWF      _lcdrow1+13
	MOVLW      111
	MOVWF      _lcdrow1+14
	MOVLW      110
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,116 :: 		case 3: lcdrow1[13]='T';lcdrow1[14]='u'; lcdrow1[15]='e';break;
L_displayTimeDate4:
	MOVLW      84
	MOVWF      _lcdrow1+13
	MOVLW      117
	MOVWF      _lcdrow1+14
	MOVLW      101
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,117 :: 		case 4: lcdrow1[13]='W';lcdrow1[14]='e'; lcdrow1[15]='d';break;
L_displayTimeDate5:
	MOVLW      87
	MOVWF      _lcdrow1+13
	MOVLW      101
	MOVWF      _lcdrow1+14
	MOVLW      100
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,118 :: 		case 5: lcdrow1[13]='T';lcdrow1[14]='h'; lcdrow1[15]='u';break;
L_displayTimeDate6:
	MOVLW      84
	MOVWF      _lcdrow1+13
	MOVLW      104
	MOVWF      _lcdrow1+14
	MOVLW      117
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,119 :: 		case 6: lcdrow1[13]='F';lcdrow1[14]='r'; lcdrow1[15]='i';break;
L_displayTimeDate7:
	MOVLW      70
	MOVWF      _lcdrow1+13
	MOVLW      114
	MOVWF      _lcdrow1+14
	MOVLW      105
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,120 :: 		case 7: lcdrow1[13]='S';lcdrow1[14]='a'; lcdrow1[15]='t';break;
L_displayTimeDate8:
	MOVLW      83
	MOVWF      _lcdrow1+13
	MOVLW      97
	MOVWF      _lcdrow1+14
	MOVLW      116
	MOVWF      _lcdrow1+15
	GOTO       L_displayTimeDate1
;lcd.c,121 :: 		}
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
;lcd.c,122 :: 		}
L_end_displayTimeDate:
	RETURN
; end of _displayTimeDate

_loadTimeEdit:

;lcd.c,123 :: 		void loadTimeEdit(){
;lcd.c,124 :: 		Lcd_Out(1,1,codetxt_to_ramtxt("Set Time"));
	MOVLW      ?lstr_3_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_3_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;lcd.c,125 :: 		lcdrow2[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,126 :: 		lcdrow2[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,127 :: 		lcdrow2[2] = ':';
	MOVLW      58
	MOVWF      _lcdrow2+2
;lcd.c,128 :: 		lcdrow2[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,129 :: 		lcdrow2[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,130 :: 		lcdrow2[5] = '\0';
	CLRF       _lcdrow2+5
;lcd.c,131 :: 		Lcd_Out(2,1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,132 :: 		}
L_end_loadTimeEdit:
	RETURN
; end of _loadTimeEdit

_loadDateEdit:

;lcd.c,133 :: 		void loadDateEdit(){
;lcd.c,134 :: 		Lcd_Out(1,1,codetxt_to_ramtxt("Set Date"));
	MOVLW      ?lstr_4_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_4_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;lcd.c,135 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,136 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,137 :: 		lcdrow2[2] = '/';
	MOVLW      47
	MOVWF      _lcdrow2+2
;lcd.c,138 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,139 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,140 :: 		lcdrow2[5] = '/';
	MOVLW      47
	MOVWF      _lcdrow2+5
;lcd.c,141 :: 		lcdrow2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,142 :: 		lcdrow2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,143 :: 		switch(dday){
	GOTO       L_loadDateEdit9
;lcd.c,144 :: 		case 1: lcdrow2[9]='S';lcdrow2[10]='u'; lcdrow2[11]='n';break;
L_loadDateEdit11:
	MOVLW      83
	MOVWF      _lcdrow2+9
	MOVLW      117
	MOVWF      _lcdrow2+10
	MOVLW      110
	MOVWF      _lcdrow2+11
	GOTO       L_loadDateEdit10
;lcd.c,145 :: 		case 2: lcdrow2[9]='M';lcdrow2[10]='o'; lcdrow2[11]='n';break;
L_loadDateEdit12:
	MOVLW      77
	MOVWF      _lcdrow2+9
	MOVLW      111
	MOVWF      _lcdrow2+10
	MOVLW      110
	MOVWF      _lcdrow2+11
	GOTO       L_loadDateEdit10
;lcd.c,146 :: 		case 3: lcdrow2[9]='T';lcdrow2[10]='u'; lcdrow2[11]='e';break;
L_loadDateEdit13:
	MOVLW      84
	MOVWF      _lcdrow2+9
	MOVLW      117
	MOVWF      _lcdrow2+10
	MOVLW      101
	MOVWF      _lcdrow2+11
	GOTO       L_loadDateEdit10
;lcd.c,147 :: 		case 4: lcdrow2[9]='W';lcdrow2[10]='e'; lcdrow2[11]='d';break;
L_loadDateEdit14:
	MOVLW      87
	MOVWF      _lcdrow2+9
	MOVLW      101
	MOVWF      _lcdrow2+10
	MOVLW      100
	MOVWF      _lcdrow2+11
	GOTO       L_loadDateEdit10
;lcd.c,148 :: 		case 5: lcdrow2[9]='T';lcdrow2[10]='h'; lcdrow2[11]='u';break;
L_loadDateEdit15:
	MOVLW      84
	MOVWF      _lcdrow2+9
	MOVLW      104
	MOVWF      _lcdrow2+10
	MOVLW      117
	MOVWF      _lcdrow2+11
	GOTO       L_loadDateEdit10
;lcd.c,149 :: 		case 6: lcdrow2[9]='F';lcdrow2[10]='r'; lcdrow2[11]='i';break;
L_loadDateEdit16:
	MOVLW      70
	MOVWF      _lcdrow2+9
	MOVLW      114
	MOVWF      _lcdrow2+10
	MOVLW      105
	MOVWF      _lcdrow2+11
	GOTO       L_loadDateEdit10
;lcd.c,150 :: 		case 7: lcdrow2[9]='S';lcdrow2[10]='a'; lcdrow2[11]='t';break;
L_loadDateEdit17:
	MOVLW      83
	MOVWF      _lcdrow2+9
	MOVLW      97
	MOVWF      _lcdrow2+10
	MOVLW      116
	MOVWF      _lcdrow2+11
	GOTO       L_loadDateEdit10
;lcd.c,151 :: 		}
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
;lcd.c,152 :: 		lcdrow2[12] = '\0';
	CLRF       _lcdrow2+12
;lcd.c,153 :: 		Lcd_Out(2,1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,154 :: 		}
L_end_loadDateEdit:
	RETURN
; end of _loadDateEdit

_setCursorPosition:

;lcd.c,155 :: 		void setCursorPosition(unsigned short position){
;lcd.c,157 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW      192
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,158 :: 		for (indx=0; indx<position; indx++) {
	CLRF       setCursorPosition_indx_L0+0
L_setCursorPosition18:
	MOVF       FARG_setCursorPosition_position+0, 0
	SUBWF      setCursorPosition_indx_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setCursorPosition19
;lcd.c,159 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,158 :: 		for (indx=0; indx<position; indx++) {
	INCF       setCursorPosition_indx_L0+0, 1
;lcd.c,160 :: 		}
	GOTO       L_setCursorPosition18
L_setCursorPosition19:
;lcd.c,161 :: 		}
L_end_setCursorPosition:
	RETURN
; end of _setCursorPosition

_loadEnHeighLow:

;lcd.c,163 :: 		void loadEnHeighLow(unsigned int heigh,unsigned int low){
;lcd.c,164 :: 		unsigned int disVolt = Binary2BCD(heigh);
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_disVolt_L0+1
;lcd.c,165 :: 		unsigned int discrr= Binary2BCD(low);
	MOVF       FARG_loadEnHeighLow_low+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FARG_loadEnHeighLow_low+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_discrr_L0+1
;lcd.c,167 :: 		if (heigh>0) {
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnHeighLow37
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	SUBLW      0
L__loadEnHeighLow37:
	BTFSC      STATUS+0, 0
	GOTO       L_loadEnHeighLow21
;lcd.c,168 :: 		lcdrow1[0] = 'O';
	MOVLW      79
	MOVWF      _lcdrow1+0
;lcd.c,169 :: 		lcdrow1[1] = 'N';
	MOVLW      78
	MOVWF      _lcdrow1+1
;lcd.c,170 :: 		heigh = heigh>>1;
	RRF        FARG_loadEnHeighLow_heigh+1, 1
	RRF        FARG_loadEnHeighLow_heigh+0, 1
	BCF        FARG_loadEnHeighLow_heigh+1, 7
;lcd.c,171 :: 		lcdrow2[6] = BCD2HignerCh(disVolt);
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       loadEnHeighLow_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,172 :: 		lcdrow2[7] = BCD2UpperCh(disVolt);
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,173 :: 		lcdrow2[8] = BCD2LowerCh(disVolt);
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+8
;lcd.c,175 :: 		lcdrow2[10] = BCD2HignerCh(discrr);
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       loadEnHeighLow_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+10
;lcd.c,176 :: 		lcdrow2[11] = BCD2UpperCh(discrr);
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+11
;lcd.c,177 :: 		lcdrow2[12] = BCD2LowerCh(discrr);
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+12
;lcd.c,178 :: 		lcdrow2[13] = '\0';
	CLRF       _lcdrow2+13
;lcd.c,179 :: 		Lcd_Out(2,1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,180 :: 		}else{
	GOTO       L_loadEnHeighLow22
L_loadEnHeighLow21:
;lcd.c,181 :: 		Lcd_Out(2,1, codetxt_to_ramtxt("OFF   0.0  0.0"));
	MOVLW      ?lstr_5_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_5_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;lcd.c,182 :: 		}
L_loadEnHeighLow22:
;lcd.c,184 :: 		}
L_end_loadEnHeighLow:
	RETURN
; end of _loadEnHeighLow

_displayVoltageCurrent:

;lcd.c,185 :: 		void displayVoltageCurrent(){
;lcd.c,188 :: 		disVolt = Binary2BCD(lastReadVoltage);
	MOVF       _lastReadVoltage+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadVoltage+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+1
;lcd.c,189 :: 		discrr = Binary2BCD(lastReadCurrent);
	MOVF       _lastReadCurrent+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadCurrent+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_discrr_L0+1
;lcd.c,190 :: 		lcdrow1[9] = BCD2HignerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+9
;lcd.c,191 :: 		lcdrow1[10] = BCD2UpperCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+10
;lcd.c,192 :: 		lcdrow1[11] = BCD2LowerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+11
;lcd.c,194 :: 		lcdrow2[9] = BCD2HignerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+9
;lcd.c,195 :: 		lcdrow2[10] = BCD2UpperCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+10
;lcd.c,196 :: 		lcdrow2[12] = BCD2LowerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+12
;lcd.c,198 :: 		}
L_end_displayVoltageCurrent:
	RETURN
; end of _displayVoltageCurrent

_loadRamToDisp:

;lcd.c,199 :: 		void loadRamToDisp(){
;lcd.c,200 :: 		Lcd_out(1, 1, lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,201 :: 		Lcd_out(2, 1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,202 :: 		}
L_end_loadRamToDisp:
	RETURN
; end of _loadRamToDisp
