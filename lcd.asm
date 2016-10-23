
_initLCDRaws:

;lcd.c,60 :: 		void initLCDRaws()
;lcd.c,62 :: 		strcpy(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"));
	MOVLW      ?lstr_1_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_1_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strcpy_from+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_strcpy_to+0
	CALL       _strcpy+0
;lcd.c,63 :: 		strcpy(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "));
	MOVLW      ?lstr_2_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_2_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_strcpy_from+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_strcpy_to+0
	CALL       _strcpy+0
;lcd.c,65 :: 		}
L_end_initLCDRaws:
	RETURN
; end of _initLCDRaws

_initLCD:

;lcd.c,66 :: 		void initLCD(){
;lcd.c,67 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;lcd.c,68 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,69 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,70 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;lcd.c,71 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD

_BCD2HignerCh:

;lcd.c,72 :: 		unsigned char BCD2HignerCh(unsigned int bcd)
;lcd.c,74 :: 		return (((bcd >> 8) & 0x0F)+ '0');
	MOVF       FARG_BCD2HignerCh_bcd+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,75 :: 		}
L_end_BCD2HignerCh:
	RETURN
; end of _BCD2HignerCh

_BCD2UpperCh:

;lcd.c,76 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;lcd.c,78 :: 		return (((bcd >> 4) & 0x0F) + '0');
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
;lcd.c,79 :: 		}
L_end_BCD2UpperCh:
	RETURN
; end of _BCD2UpperCh

_BCD2LowerCh:

;lcd.c,81 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;lcd.c,83 :: 		return ((bcd & 0x0F) + '0');
	MOVLW      15
	ANDWF      FARG_BCD2LowerCh_bcd+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,84 :: 		}
L_end_BCD2LowerCh:
	RETURN
; end of _BCD2LowerCh

_Binary2BCD:

;lcd.c,86 :: 		unsigned int Binary2BCD(int a)
;lcd.c,90 :: 		t1 = a%10;
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
;lcd.c,91 :: 		t1 = t1 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+3
;lcd.c,92 :: 		a = a/10;
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
;lcd.c,93 :: 		t2 = a%10;
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
;lcd.c,94 :: 		t2 = t2 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R2+0
;lcd.c,95 :: 		t2 = t2 << 4;
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
;lcd.c,96 :: 		t2 = 0xF0 & t2;
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+0
;lcd.c,97 :: 		a = a/10;
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
;lcd.c,98 :: 		t3 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;lcd.c,99 :: 		t3 = t3 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVLW      0
	ANDWF      R4+1, 1
;lcd.c,100 :: 		t3 = t3 << 8;
	MOVF       R4+0, 0
	MOVWF      R2+1
	CLRF       R2+0
;lcd.c,101 :: 		t3 +=  t1 | t2;
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
;lcd.c,102 :: 		return t3;
;lcd.c,103 :: 		}
L_end_Binary2BCD:
	RETURN
; end of _Binary2BCD

_BCD2Binary:

;lcd.c,105 :: 		int BCD2Binary(int a)
;lcd.c,108 :: 		t = a & 0x0F;
	MOVLW      15
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      FLOC__BCD2Binary+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      FLOC__BCD2Binary+1
	MOVLW      0
	ANDWF      FLOC__BCD2Binary+1, 1
;lcd.c,110 :: 		a = 0xF0 & a;
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
;lcd.c,111 :: 		t = a >> 4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__BCD2Binary35:
	BTFSC      STATUS+0, 2
	GOTO       L__BCD2Binary36
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__BCD2Binary35
L__BCD2Binary36:
;lcd.c,112 :: 		t = 0x0F & t;
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
;lcd.c,113 :: 		r = t*10 + r;
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
;lcd.c,114 :: 		return r;
;lcd.c,115 :: 		}
L_end_BCD2Binary:
	RETURN
; end of _BCD2Binary

_loadDay:

;lcd.c,116 :: 		void loadDay(char *arr,unsigned short theIndx){
;lcd.c,117 :: 		switch(theIndx){
	GOTO       L_loadDay0
;lcd.c,118 :: 		case 0: arr[0]='-';arr[1]='-'; arr[2]='-';break;
L_loadDay2:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,119 :: 		case 1: arr[0]='S';arr[1]='u'; arr[2]='n';break;
L_loadDay3:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      83
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      117
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      110
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,120 :: 		case 2: arr[0]='M';arr[1]='o'; arr[2]='n';break;
L_loadDay4:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      77
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      111
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      110
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,121 :: 		case 3: arr[0]='T';arr[1]='u'; arr[2]='e';break;
L_loadDay5:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      84
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      117
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      101
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,122 :: 		case 4: arr[0]='W';arr[1]='e'; arr[2]='d';break;
L_loadDay6:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      87
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      101
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,123 :: 		case 5: arr[0]='T';arr[1]='h'; arr[2]='u';break;
L_loadDay7:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      84
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      104
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      117
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,124 :: 		case 6: arr[0]='F';arr[1]='r'; arr[2]='i';break;
L_loadDay8:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      70
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      114
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      105
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,125 :: 		case 7: arr[0]='S';arr[1]='a'; arr[2]='t';break;
L_loadDay9:
	MOVF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      83
	MOVWF      INDF+0
	INCF       FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      97
	MOVWF      INDF+0
	MOVLW      2
	ADDWF      FARG_loadDay_arr+0, 0
	MOVWF      FSR
	MOVLW      116
	MOVWF      INDF+0
	GOTO       L_loadDay1
;lcd.c,126 :: 		}
L_loadDay0:
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay2
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay3
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay4
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay5
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay6
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay7
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay8
	MOVF       FARG_loadDay_theIndx+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_loadDay9
L_loadDay1:
;lcd.c,127 :: 		}
L_end_loadDay:
	RETURN
; end of _loadDay

_displayTimeDate:

;lcd.c,128 :: 		void displayTimeDate(){
;lcd.c,130 :: 		lcdrow1[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+0
;lcd.c,131 :: 		lcdrow1[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+1
;lcd.c,132 :: 		lcdrow1[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+3
;lcd.c,133 :: 		lcdrow1[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+4
;lcd.c,134 :: 		lcdrow1[6] = BCD2UpperCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+6
;lcd.c,135 :: 		lcdrow1[7] = BCD2LowerCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+7
;lcd.c,137 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,138 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,139 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,140 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
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
;lcd.c,143 :: 		loadDay(&lcdrow1[13],dday);
	MOVLW      _lcdrow1+13
	MOVWF      FARG_loadDay_arr+0
	MOVF       _dday+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;lcd.c,145 :: 		}
L_end_displayTimeDate:
	RETURN
; end of _displayTimeDate

_loadTimeEdit:

;lcd.c,147 :: 		void loadTimeEdit(){
;lcd.c,148 :: 		Lcd_Out(1,1,codetxt_to_ramtxt("Set Time"));
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
;lcd.c,149 :: 		lcdrow2[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,150 :: 		lcdrow2[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,151 :: 		lcdrow2[2] = ':';
	MOVLW      58
	MOVWF      _lcdrow2+2
;lcd.c,152 :: 		lcdrow2[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,153 :: 		lcdrow2[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,154 :: 		lcdrow2[5] = '\0';
	CLRF       _lcdrow2+5
;lcd.c,155 :: 		Lcd_Out(2,1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,156 :: 		}
L_end_loadTimeEdit:
	RETURN
; end of _loadTimeEdit

_loadDateEdit:

;lcd.c,157 :: 		void loadDateEdit(){
;lcd.c,158 :: 		Lcd_Out(1,1,codetxt_to_ramtxt("Set Date"));
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
;lcd.c,159 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,160 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,161 :: 		lcdrow2[2] = '/';
	MOVLW      47
	MOVWF      _lcdrow2+2
;lcd.c,162 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,163 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,164 :: 		lcdrow2[5] = '/';
	MOVLW      47
	MOVWF      _lcdrow2+5
;lcd.c,165 :: 		lcdrow2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,166 :: 		lcdrow2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,167 :: 		loadDay(&lcdrow2[9],dday);
	MOVLW      _lcdrow2+9
	MOVWF      FARG_loadDay_arr+0
	MOVF       _dday+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;lcd.c,168 :: 		lcdrow2[12] = '\0';
	CLRF       _lcdrow2+12
;lcd.c,169 :: 		Lcd_Out(2,1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,170 :: 		}
L_end_loadDateEdit:
	RETURN
; end of _loadDateEdit

_setCursorPosition:

;lcd.c,171 :: 		void setCursorPosition(unsigned short position){
;lcd.c,173 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW      192
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,174 :: 		for (indx=0; indx<position; indx++) {
	CLRF       setCursorPosition_indx_L0+0
L_setCursorPosition10:
	MOVF       FARG_setCursorPosition_position+0, 0
	SUBWF      setCursorPosition_indx_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setCursorPosition11
;lcd.c,175 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,174 :: 		for (indx=0; indx<position; indx++) {
	INCF       setCursorPosition_indx_L0+0, 1
;lcd.c,176 :: 		}
	GOTO       L_setCursorPosition10
L_setCursorPosition11:
;lcd.c,177 :: 		}
L_end_setCursorPosition:
	RETURN
; end of _setCursorPosition

_loadEnabledDay:

;lcd.c,178 :: 		void loadEnabledDay()
;lcd.c,180 :: 		}
L_end_loadEnabledDay:
	RETURN
; end of _loadEnabledDay

_loadEnDayHrMin:

;lcd.c,181 :: 		void loadEnDayHrMin()
;lcd.c,183 :: 		unsigned short indx = 0;
	CLRF       loadEnDayHrMin_indx_L0+0
;lcd.c,184 :: 		unsigned val = editValue >> 2;
	MOVF       _editValue+0, 0
	MOVWF      loadEnDayHrMin_val_L0+0
	MOVF       _editValue+1, 0
	MOVWF      loadEnDayHrMin_val_L0+1
	RRF        loadEnDayHrMin_val_L0+1, 1
	RRF        loadEnDayHrMin_val_L0+0, 1
	BCF        loadEnDayHrMin_val_L0+1, 7
	RRF        loadEnDayHrMin_val_L0+1, 1
	RRF        loadEnDayHrMin_val_L0+0, 1
	BCF        loadEnDayHrMin_val_L0+1, 7
;lcd.c,187 :: 		switch(crntMenu-5)
	MOVLW      5
	SUBWF      _crntMenu+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	GOTO       L_loadEnDayHrMin13
;lcd.c,189 :: 		case 1:
L_loadEnDayHrMin15:
;lcd.c,190 :: 		lcdrow2[indx++]='1';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      49
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,191 :: 		break;
	GOTO       L_loadEnDayHrMin14
;lcd.c,192 :: 		case 2:
L_loadEnDayHrMin16:
;lcd.c,193 :: 		lcdrow2[indx++]='2';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      50
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,194 :: 		break;
	GOTO       L_loadEnDayHrMin14
;lcd.c,195 :: 		case 3:
L_loadEnDayHrMin17:
;lcd.c,196 :: 		lcdrow2[indx++]='3';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      51
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,197 :: 		break;
	GOTO       L_loadEnDayHrMin14
;lcd.c,198 :: 		case 4:
L_loadEnDayHrMin18:
;lcd.c,199 :: 		lcdrow2[indx++]='4';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      52
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,200 :: 		break;
	GOTO       L_loadEnDayHrMin14
;lcd.c,201 :: 		case 5:
L_loadEnDayHrMin19:
;lcd.c,202 :: 		lcdrow2[indx++]='5';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      53
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,203 :: 		break;
	GOTO       L_loadEnDayHrMin14
;lcd.c,204 :: 		case 6:
L_loadEnDayHrMin20:
;lcd.c,205 :: 		lcdrow2[indx++]='6';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      54
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,206 :: 		break;
	GOTO       L_loadEnDayHrMin14
;lcd.c,207 :: 		case 7:
L_loadEnDayHrMin21:
;lcd.c,208 :: 		lcdrow2[indx++]='7';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      55
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,209 :: 		break;
	GOTO       L_loadEnDayHrMin14
;lcd.c,210 :: 		}
L_loadEnDayHrMin13:
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnDayHrMin44
	MOVLW      1
	XORWF      R1+0, 0
L__loadEnDayHrMin44:
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnDayHrMin15
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnDayHrMin45
	MOVLW      2
	XORWF      R1+0, 0
L__loadEnDayHrMin45:
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnDayHrMin16
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnDayHrMin46
	MOVLW      3
	XORWF      R1+0, 0
L__loadEnDayHrMin46:
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnDayHrMin17
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnDayHrMin47
	MOVLW      4
	XORWF      R1+0, 0
L__loadEnDayHrMin47:
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnDayHrMin18
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnDayHrMin48
	MOVLW      5
	XORWF      R1+0, 0
L__loadEnDayHrMin48:
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnDayHrMin19
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnDayHrMin49
	MOVLW      6
	XORWF      R1+0, 0
L__loadEnDayHrMin49:
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnDayHrMin20
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnDayHrMin50
	MOVLW      7
	XORWF      R1+0, 0
L__loadEnDayHrMin50:
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnDayHrMin21
L_loadEnDayHrMin14:
;lcd.c,211 :: 		lcdrow2[indx++]=')';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      41
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,212 :: 		lcdrow2[indx++]=' ';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,213 :: 		if(isEnabled)
	BTFSS      _isEnabled+0, BitPos(_isEnabled+0)
	GOTO       L_loadEnDayHrMin22
;lcd.c,215 :: 		lcdrow2[indx++] = 'O';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      79
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,216 :: 		lcdrow2[indx++] = 'N';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      78
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,217 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,218 :: 		}
	GOTO       L_loadEnDayHrMin23
L_loadEnDayHrMin22:
;lcd.c,221 :: 		lcdrow2[indx++] = 'O';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      79
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,222 :: 		lcdrow2[indx++] = 'F';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      70
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,223 :: 		lcdrow2[indx++] = 'F';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      70
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,224 :: 		}
L_loadEnDayHrMin23:
;lcd.c,225 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,240 :: 		val = (val >> 3);
	MOVF       loadEnDayHrMin_val_L0+0, 0
	MOVWF      R0+0
	MOVF       loadEnDayHrMin_val_L0+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      loadEnDayHrMin_val_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnDayHrMin_val_L0+1
;lcd.c,241 :: 		dday =  val & 0x1F;
	MOVLW      31
	ANDWF      R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
;lcd.c,242 :: 		dis =   Binary2BCD(dday);
	MOVLW      0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnDayHrMin_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnDayHrMin_dis_L0+1
;lcd.c,243 :: 		lcdrow2[indx++] = BCD2UpperCh(dis);
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnDayHrMin+0
	MOVF       R0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       FLOC__loadEnDayHrMin+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,244 :: 		lcdrow2[indx++] = BCD2LowerCh(dis);
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnDayHrMin+0
	MOVF       loadEnDayHrMin_dis_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       FLOC__loadEnDayHrMin+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,245 :: 		lcdrow2[indx++] = ':';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      58
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,246 :: 		val = (val >> 5);
	MOVLW      5
	MOVWF      R2+0
	MOVF       loadEnDayHrMin_val_L0+0, 0
	MOVWF      R0+0
	MOVF       loadEnDayHrMin_val_L0+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__loadEnDayHrMin51:
	BTFSC      STATUS+0, 2
	GOTO       L__loadEnDayHrMin52
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	ADDLW      255
	GOTO       L__loadEnDayHrMin51
L__loadEnDayHrMin52:
	MOVF       R0+0, 0
	MOVWF      loadEnDayHrMin_val_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnDayHrMin_val_L0+1
;lcd.c,247 :: 		dday =  val & 0x3F;
	MOVLW      63
	ANDWF      R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
;lcd.c,248 :: 		dis =   Binary2BCD(dday);
	MOVLW      0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnDayHrMin_dis_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnDayHrMin_dis_L0+1
;lcd.c,249 :: 		lcdrow2[indx++] = BCD2UpperCh(dis);
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnDayHrMin+0
	MOVF       R0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       FLOC__loadEnDayHrMin+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,250 :: 		lcdrow2[indx++] = BCD2LowerCh(dis);
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnDayHrMin+0
	MOVF       loadEnDayHrMin_dis_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       FLOC__loadEnDayHrMin+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnDayHrMin_indx_L0+0, 1
;lcd.c,251 :: 		lcdrow2[indx] = '\0';
	MOVF       loadEnDayHrMin_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	CLRF       INDF+0
;lcd.c,252 :: 		Lcd_Out(2,1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,253 :: 		}
L_end_loadEnDayHrMin:
	RETURN
; end of _loadEnDayHrMin

_loadEnHeighLow:

;lcd.c,254 :: 		void loadEnHeighLow(unsigned int heigh,unsigned int low,const unsigned short shouldUseDecimal)
;lcd.c,257 :: 		unsigned int discrr= Binary2BCD(low);
	MOVF       FARG_loadEnHeighLow_low+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FARG_loadEnHeighLow_low+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_discrr_L0+1
;lcd.c,258 :: 		unsigned short indx = 0;
	CLRF       loadEnHeighLow_indx_L0+0
;lcd.c,259 :: 		if (heigh>0) {
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnHeighLow54
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	SUBLW      0
L__loadEnHeighLow54:
	BTFSC      STATUS+0, 0
	GOTO       L_loadEnHeighLow24
;lcd.c,260 :: 		lcdrow2[indx++] = 'O';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      79
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,261 :: 		lcdrow2[indx++] = 'N';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      78
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,262 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,263 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,264 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,265 :: 		heigh = heigh>>1;
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	MOVWF      R0+0
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      FARG_loadEnHeighLow_heigh+0
	MOVF       R0+1, 0
	MOVWF      FARG_loadEnHeighLow_heigh+1
;lcd.c,266 :: 		disVolt = Binary2BCD(heigh);
	MOVF       R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_disVolt_L0+1
;lcd.c,267 :: 		lcdrow2[indx++] = BCD2HignerCh(disVolt);
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       R0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       R0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,268 :: 		lcdrow2[indx++] = BCD2UpperCh(disVolt);
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,269 :: 		if(shouldUseDecimal)
	MOVF       FARG_loadEnHeighLow_shouldUseDecimal+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnHeighLow25
;lcd.c,271 :: 		lcdrow2[indx++] = '.';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      46
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,272 :: 		}
L_loadEnHeighLow25:
;lcd.c,273 :: 		lcdrow2[indx++] = BCD2LowerCh(disVolt);
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,274 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,275 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,276 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,277 :: 		lcdrow2[indx++] = BCD2HignerCh(discrr);
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       loadEnHeighLow_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,278 :: 		lcdrow2[indx++] = BCD2UpperCh(discrr);
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,279 :: 		if(shouldUseDecimal)
	MOVF       FARG_loadEnHeighLow_shouldUseDecimal+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnHeighLow26
;lcd.c,281 :: 		lcdrow2[indx++] = '.';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      46
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,282 :: 		}
L_loadEnHeighLow26:
;lcd.c,283 :: 		lcdrow2[indx++] = BCD2LowerCh(discrr);
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FLOC__loadEnHeighLow+0
	MOVF       loadEnHeighLow_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       FLOC__loadEnHeighLow+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,284 :: 		lcdrow2[indx] = '\0';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	CLRF       INDF+0
;lcd.c,285 :: 		Lcd_Out(2,1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,286 :: 		}else{
	GOTO       L_loadEnHeighLow27
L_loadEnHeighLow24:
;lcd.c,287 :: 		Lcd_Out(2,1, codetxt_to_ramtxt("OFF   0.0  0.0"));
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
;lcd.c,288 :: 		}
L_loadEnHeighLow27:
;lcd.c,290 :: 		}
L_end_loadEnHeighLow:
	RETURN
; end of _loadEnHeighLow

_displayVoltageCurrent:

;lcd.c,291 :: 		void displayVoltageCurrent(){
;lcd.c,294 :: 		disVolt = Binary2BCD(lastReadVoltage);
	MOVF       _lastReadVoltage+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadVoltage+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+1
;lcd.c,295 :: 		discrr = Binary2BCD(lastReadCurrent);
	MOVF       _lastReadCurrent+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadCurrent+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_discrr_L0+1
;lcd.c,296 :: 		lcdrow1[9] = BCD2HignerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+9
;lcd.c,297 :: 		lcdrow1[10] = BCD2UpperCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+10
;lcd.c,298 :: 		lcdrow1[11] = BCD2LowerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+11
;lcd.c,300 :: 		lcdrow2[9] = BCD2HignerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+9
;lcd.c,301 :: 		lcdrow2[10] = BCD2UpperCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+10
;lcd.c,302 :: 		lcdrow2[12] = BCD2LowerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+12
;lcd.c,304 :: 		}
L_end_displayVoltageCurrent:
	RETURN
; end of _displayVoltageCurrent

_loadRamToDisp:

;lcd.c,305 :: 		void loadRamToDisp(){
;lcd.c,306 :: 		Lcd_Out(1, 1, lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,307 :: 		Lcd_Out(2, 1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,308 :: 		}
L_end_loadRamToDisp:
	RETURN
; end of _loadRamToDisp
