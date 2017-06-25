
_initLCDRaws:

;lcd.c,86 :: 		void initLCDRaws()
;lcd.c,88 :: 		strcpy(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"));
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
;lcd.c,89 :: 		strcpy(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "));
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
;lcd.c,91 :: 		}
L_end_initLCDRaws:
	RETURN
; end of _initLCDRaws

_initLCD:

;lcd.c,92 :: 		void initLCD(){
;lcd.c,93 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;lcd.c,94 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,95 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,96 :: 		initLCDRaws();
	CALL       _initLCDRaws+0
;lcd.c,97 :: 		}
L_end_initLCD:
	RETURN
; end of _initLCD

_BCD2HignerCh:

;lcd.c,98 :: 		unsigned char BCD2HignerCh(unsigned int bcd)
;lcd.c,101 :: 		return ((Hi(bcd) & 0x0F)+ '0');
	MOVLW      15
	ANDWF      FARG_BCD2HignerCh_bcd+1, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,102 :: 		}
L_end_BCD2HignerCh:
	RETURN
; end of _BCD2HignerCh

_BCD2UpperCh:

;lcd.c,103 :: 		unsigned char BCD2UpperCh(unsigned char bcd)
;lcd.c,105 :: 		return ((swap(bcd) & 0x0F) + '0');
	MOVF       FARG_BCD2UpperCh_bcd+0, 0
	MOVWF      FARG_Swap_input+0
	CALL       _Swap+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,106 :: 		}
L_end_BCD2UpperCh:
	RETURN
; end of _BCD2UpperCh

_BCD2LowerCh:

;lcd.c,108 :: 		unsigned char BCD2LowerCh(unsigned char bcd)
;lcd.c,110 :: 		return ((bcd & 0x0F) + '0');
	MOVLW      15
	ANDWF      FARG_BCD2LowerCh_bcd+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
;lcd.c,111 :: 		}
L_end_BCD2LowerCh:
	RETURN
; end of _BCD2LowerCh

_Binary2BCD:

;lcd.c,113 :: 		unsigned int Binary2BCD(int a)
;lcd.c,117 :: 		t1 = a%10;
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
;lcd.c,118 :: 		t1 = t1 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+3
;lcd.c,119 :: 		a = a/10;
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
;lcd.c,120 :: 		t2 = a%10;
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
;lcd.c,121 :: 		t2 = t2 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R2+0
;lcd.c,122 :: 		t2 = t2 << 4;
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
;lcd.c,123 :: 		t2 = 0xF0 & t2;
	MOVLW      240
	ANDWF      R0+0, 0
	MOVWF      FLOC__Binary2BCD+0
;lcd.c,124 :: 		a = a/10;
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
;lcd.c,125 :: 		t3 = a%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
;lcd.c,126 :: 		t3 = t3 & 0x0F;
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVLW      0
	ANDWF      R4+1, 1
;lcd.c,127 :: 		t3 = t3 << 8;
	MOVF       R4+0, 0
	MOVWF      R2+1
	CLRF       R2+0
;lcd.c,128 :: 		t3 +=  t1 | t2;
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
;lcd.c,129 :: 		return t3;
;lcd.c,130 :: 		}
L_end_Binary2BCD:
	RETURN
; end of _Binary2BCD

_BCD2Binary:

;lcd.c,132 :: 		int BCD2Binary(int a)
;lcd.c,135 :: 		t = a & 0x0F;
	MOVLW      15
	ANDWF      FARG_BCD2Binary_a+0, 0
	MOVWF      FLOC__BCD2Binary+0
	MOVF       FARG_BCD2Binary_a+1, 0
	MOVWF      FLOC__BCD2Binary+1
	MOVLW      0
	ANDWF      FLOC__BCD2Binary+1, 1
;lcd.c,137 :: 		a = 0xF0 & a;
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
;lcd.c,138 :: 		t = a >> 4;
	MOVLW      4
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__BCD2Binary42:
	BTFSC      STATUS+0, 2
	GOTO       L__BCD2Binary43
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	ADDLW      255
	GOTO       L__BCD2Binary42
L__BCD2Binary43:
;lcd.c,139 :: 		t = 0x0F & t;
	MOVLW      15
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
;lcd.c,140 :: 		r = t*10 + r;
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
;lcd.c,141 :: 		return r;
;lcd.c,142 :: 		}
L_end_BCD2Binary:
	RETURN
; end of _BCD2Binary

_loadDay:

;lcd.c,143 :: 		void loadDay(char *arr,unsigned short theIndx){
;lcd.c,144 :: 		switch(theIndx){
	GOTO       L_loadDay0
;lcd.c,145 :: 		case 0: arr[0]='-';arr[1]='-'; arr[2]='-';break;
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
;lcd.c,146 :: 		case 1: arr[0]='S';arr[1]='u'; arr[2]='n';break;
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
;lcd.c,147 :: 		case 2: arr[0]='M';arr[1]='o'; arr[2]='n';break;
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
;lcd.c,148 :: 		case 3: arr[0]='T';arr[1]='u'; arr[2]='e';break;
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
;lcd.c,149 :: 		case 4: arr[0]='W';arr[1]='e'; arr[2]='d';break;
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
;lcd.c,150 :: 		case 5: arr[0]='T';arr[1]='h'; arr[2]='u';break;
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
;lcd.c,151 :: 		case 6: arr[0]='F';arr[1]='r'; arr[2]='i';break;
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
;lcd.c,152 :: 		case 7: arr[0]='S';arr[1]='a'; arr[2]='t';break;
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
;lcd.c,153 :: 		}
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
;lcd.c,154 :: 		}
L_end_loadDay:
	RETURN
; end of _loadDay

_displayTimeDate:

;lcd.c,155 :: 		void displayTimeDate(){
;lcd.c,157 :: 		lcdrow1[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+0
;lcd.c,158 :: 		lcdrow1[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+1
;lcd.c,159 :: 		lcdrow1[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+3
;lcd.c,160 :: 		lcdrow1[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+4
;lcd.c,161 :: 		lcdrow1[6] = BCD2UpperCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+6
;lcd.c,162 :: 		lcdrow1[7] = BCD2LowerCh(second);
	MOVF       _second+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+7
;lcd.c,164 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,165 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,166 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,167 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,168 :: 		lcdrow2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,169 :: 		lcdrow2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,170 :: 		loadDay(&lcdrow1[13],dday);
	MOVLW      _lcdrow1+13
	MOVWF      FARG_loadDay_arr+0
	MOVF       _dday+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;lcd.c,172 :: 		}
L_end_displayTimeDate:
	RETURN
; end of _displayTimeDate

_loadTimeEdit:

;lcd.c,174 :: 		void loadTimeEdit(){
;lcd.c,175 :: 		Lcd_Out(1,1,codetxt_to_ramtxt("Set Time"));
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
;lcd.c,176 :: 		lcdrow2[0] = BCD2UpperCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,177 :: 		lcdrow2[1] = BCD2LowerCh(hour);
	MOVF       _hour+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,178 :: 		lcdrow2[2] = ':';
	MOVLW      58
	MOVWF      _lcdrow2+2
;lcd.c,179 :: 		lcdrow2[3] = BCD2UpperCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,180 :: 		lcdrow2[4] = BCD2LowerCh(minute);
	MOVF       _minute+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,181 :: 		lcdrow2[5] = '\0';
	CLRF       _lcdrow2+5
;lcd.c,182 :: 		Lcd_Out(2,1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,183 :: 		}
L_end_loadTimeEdit:
	RETURN
; end of _loadTimeEdit

_loadDateEdit:

;lcd.c,184 :: 		void loadDateEdit(){
;lcd.c,185 :: 		Lcd_Out(1,1,codetxt_to_ramtxt("Set Date"));
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
;lcd.c,186 :: 		lcdrow2[0] = BCD2UpperCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+0
;lcd.c,187 :: 		lcdrow2[1] = BCD2LowerCh(day);
	MOVF       _day+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+1
;lcd.c,188 :: 		lcdrow2[2] = '/';
	MOVLW      47
	MOVWF      _lcdrow2+2
;lcd.c,189 :: 		lcdrow2[3] = BCD2UpperCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,190 :: 		lcdrow2[4] = BCD2LowerCh(month);
	MOVF       _month+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+4
;lcd.c,191 :: 		lcdrow2[5] = '/';
	MOVLW      47
	MOVWF      _lcdrow2+5
;lcd.c,192 :: 		lcdrow2[6] = BCD2UpperCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,193 :: 		lcdrow2[7] = BCD2LowerCh(year);
	MOVF       _year+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+7
;lcd.c,194 :: 		loadDay(&lcdrow2[9],dday);
	MOVLW      _lcdrow2+9
	MOVWF      FARG_loadDay_arr+0
	MOVF       _dday+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;lcd.c,195 :: 		lcdrow2[12] = '\0';
	CLRF       _lcdrow2+12
;lcd.c,196 :: 		Lcd_Out(2,1,lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,197 :: 		}
L_end_loadDateEdit:
	RETURN
; end of _loadDateEdit

_setCursorPosition:

;lcd.c,198 :: 		void setCursorPosition(unsigned short position){
;lcd.c,200 :: 		if ((crntMenu > LDRVal)   && (crntMenu - OnOFFTimeDay1) % 2 == 0 ) {
	MOVF       _crntMenu+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L_setCursorPosition12
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
	GOTO       L__setCursorPosition49
	MOVLW      0
	XORWF      R0+0, 0
L__setCursorPosition49:
	BTFSS      STATUS+0, 2
	GOTO       L_setCursorPosition12
L__setCursorPosition33:
;lcd.c,201 :: 		Lcd_Cmd(_LCD_FIRST_ROW);
	MOVLW      128
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,202 :: 		}
	GOTO       L_setCursorPosition13
L_setCursorPosition12:
;lcd.c,204 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW      192
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,205 :: 		}
L_setCursorPosition13:
;lcd.c,207 :: 		for (indx=0; indx<position; indx++) {
	CLRF       setCursorPosition_indx_L0+0
L_setCursorPosition14:
	MOVF       FARG_setCursorPosition_position+0, 0
	SUBWF      setCursorPosition_indx_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_setCursorPosition15
;lcd.c,208 :: 		Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
	MOVLW      20
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lcd.c,207 :: 		for (indx=0; indx<position; indx++) {
	INCF       setCursorPosition_indx_L0+0, 1
;lcd.c,209 :: 		}
	GOTO       L_setCursorPosition14
L_setCursorPosition15:
;lcd.c,210 :: 		}
L_end_setCursorPosition:
	RETURN
; end of _setCursorPosition

_loadEnabledDay:

;lcd.c,211 :: 		void loadEnabledDay()
;lcd.c,213 :: 		unsigned short tmp = editValue;
	MOVF       _editValue+0, 0
	MOVWF      loadEnabledDay_tmp_L0+0
;lcd.c,214 :: 		unsigned short indx = 2;
	MOVLW      2
	MOVWF      loadEnabledDay_indx_L0+0
	CLRF       loadEnabledDay_i_L0+0
;lcd.c,217 :: 		lcdrow1[0]= ((crntMenu - OnOFFTimeDay1)>> 1) + '0' + 1;
	MOVLW      6
	SUBWF      _crntMenu+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      _lcdrow1+0
	INCF       _lcdrow1+0, 1
;lcd.c,218 :: 		lcdrow1[1] = ')';
	MOVLW      41
	MOVWF      _lcdrow1+1
;lcd.c,219 :: 		for (i = 0 ; i < 8; i++)
	CLRF       loadEnabledDay_i_L0+0
L_loadEnabledDay17:
	MOVLW      8
	SUBWF      loadEnabledDay_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_loadEnabledDay18
;lcd.c,221 :: 		if ((tmp & 1) != 0)
	MOVLW      1
	ANDWF      loadEnabledDay_tmp_L0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnabledDay20
;lcd.c,223 :: 		loadDay(&lcdrow1[indx],i+1);
	MOVF       loadEnabledDay_indx_L0+0, 0
	ADDLW      _lcdrow1+0
	MOVWF      FARG_loadDay_arr+0
	INCF       loadEnabledDay_i_L0+0, 0
	MOVWF      FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;lcd.c,224 :: 		}else
	GOTO       L_loadEnabledDay21
L_loadEnabledDay20:
;lcd.c,226 :: 		loadDay(&lcdrow1[indx],0);
	MOVF       loadEnabledDay_indx_L0+0, 0
	ADDLW      _lcdrow1+0
	MOVWF      FARG_loadDay_arr+0
	CLRF       FARG_loadDay_theIndx+0
	CALL       _loadDay+0
;lcd.c,227 :: 		}
L_loadEnabledDay21:
;lcd.c,228 :: 		tmp = tmp >> 1;
	RRF        loadEnabledDay_tmp_L0+0, 1
	BCF        loadEnabledDay_tmp_L0+0, 7
;lcd.c,229 :: 		indx += 2;
	MOVLW      2
	ADDWF      loadEnabledDay_indx_L0+0, 1
;lcd.c,219 :: 		for (i = 0 ; i < 8; i++)
	INCF       loadEnabledDay_i_L0+0, 1
;lcd.c,230 :: 		}
	GOTO       L_loadEnabledDay17
L_loadEnabledDay18:
;lcd.c,231 :: 		lcdrow1[16] = '\0';
	CLRF       _lcdrow1+16
;lcd.c,232 :: 		Lcd_Out(1, 1, lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,233 :: 		}
L_end_loadEnabledDay:
	RETURN
; end of _loadEnabledDay

_loadOnOffTime:

;lcd.c,235 :: 		void loadOnOffTime()
;lcd.c,237 :: 		unsigned short mi = Hi(editValue);
	MOVF       _editValue+1, 0
	MOVWF      loadOnOffTime_mi_L0+0
;lcd.c,238 :: 		unsigned short hr = Lo(editValue);
	MOVF       _editValue+0, 0
	MOVWF      loadOnOffTime_hr_L0+0
;lcd.c,240 :: 		if (subMenu == OnOFFTimeOnHr || subMenu == OnOFFTimeOnMin) {
	MOVF       _subMenu+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L__loadOnOffTime34
	MOVF       _subMenu+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L__loadOnOffTime34
	GOTO       L_loadOnOffTime24
L__loadOnOffTime34:
;lcd.c,241 :: 		tmp = OnOFFTimeOnHr-2;
	MOVLW      1
	MOVWF      loadOnOffTime_tmp_L0+0
	MOVLW      0
	MOVWF      loadOnOffTime_tmp_L0+1
;lcd.c,242 :: 		lcdrow2[0] = 'N';
	MOVLW      78
	MOVWF      _lcdrow2+0
;lcd.c,243 :: 		}else
	GOTO       L_loadOnOffTime25
L_loadOnOffTime24:
;lcd.c,245 :: 		tmp = OnOFFTimeOffHr-2;
	MOVLW      9
	MOVWF      loadOnOffTime_tmp_L0+0
	MOVLW      0
	MOVWF      loadOnOffTime_tmp_L0+1
;lcd.c,246 :: 		lcdrow2[0] = 'F';
	MOVLW      70
	MOVWF      _lcdrow2+0
;lcd.c,247 :: 		}
L_loadOnOffTime25:
;lcd.c,248 :: 		lcdrow2[1] = '>';
	MOVLW      62
	MOVWF      _lcdrow2+1
;lcd.c,249 :: 		lcdrow2[2] = BCD2UpperCh(hr);
	MOVF       loadOnOffTime_hr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+2
;lcd.c,250 :: 		lcdrow2[3] = BCD2LowerCh(hr);
	MOVF       loadOnOffTime_hr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+3
;lcd.c,251 :: 		lcdrow2[4] = ':';
	MOVLW      58
	MOVWF      _lcdrow2+4
;lcd.c,252 :: 		lcdrow2[5] = BCD2UpperCh(mi);
	MOVF       loadOnOffTime_mi_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+5
;lcd.c,253 :: 		lcdrow2[6] = BCD2LowerCh(mi);
	MOVF       loadOnOffTime_mi_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+6
;lcd.c,254 :: 		lcdrow2[7] = '\0';
	CLRF       _lcdrow2+7
;lcd.c,255 :: 		Lcd_Out(2, tmp, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       loadOnOffTime_tmp_L0+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,257 :: 		}
L_end_loadOnOffTime:
	RETURN
; end of _loadOnOffTime

_loadEnHeighLow:

;lcd.c,259 :: 		void loadEnHeighLow(unsigned int heigh,unsigned int low,const unsigned short shouldUseDecimal)
;lcd.c,262 :: 		unsigned int discrr = Binary2BCD(low);
	MOVF       FARG_loadEnHeighLow_low+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       FARG_loadEnHeighLow_low+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_discrr_L0+1
;lcd.c,263 :: 		unsigned short indx = 0;
	CLRF       loadEnHeighLow_indx_L0+0
;lcd.c,264 :: 		if (heigh>0) {
	MOVF       FARG_loadEnHeighLow_heigh+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__loadEnHeighLow53
	MOVF       FARG_loadEnHeighLow_heigh+0, 0
	SUBLW      0
L__loadEnHeighLow53:
	BTFSC      STATUS+0, 0
	GOTO       L_loadEnHeighLow26
;lcd.c,265 :: 		lcdrow2[indx++] = 'O';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      79
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,266 :: 		lcdrow2[indx++] = 'N';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      78
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,267 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,268 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,269 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,270 :: 		heigh = heigh>>1;
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
;lcd.c,271 :: 		disVolt = Binary2BCD(heigh);
	MOVF       R0+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       R0+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      loadEnHeighLow_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      loadEnHeighLow_disVolt_L0+1
;lcd.c,272 :: 		lcdrow2[indx++] = BCD2HignerCh(disVolt);
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
;lcd.c,273 :: 		lcdrow2[indx++] = BCD2UpperCh(disVolt);
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
;lcd.c,274 :: 		if(shouldUseDecimal)
	MOVF       FARG_loadEnHeighLow_shouldUseDecimal+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnHeighLow27
;lcd.c,276 :: 		lcdrow2[indx++] = '.';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      46
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,277 :: 		}
L_loadEnHeighLow27:
;lcd.c,278 :: 		lcdrow2[indx++] = BCD2LowerCh(disVolt);
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
;lcd.c,279 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,280 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,281 :: 		lcdrow2[indx++] = ' ';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      32
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,282 :: 		lcdrow2[indx++] = BCD2HignerCh(discrr);
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
;lcd.c,283 :: 		lcdrow2[indx++] = BCD2UpperCh(discrr);
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
;lcd.c,284 :: 		if(shouldUseDecimal)
	MOVF       FARG_loadEnHeighLow_shouldUseDecimal+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnHeighLow28
;lcd.c,286 :: 		lcdrow2[indx++] = '.';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	MOVLW      46
	MOVWF      INDF+0
	INCF       loadEnHeighLow_indx_L0+0, 1
;lcd.c,287 :: 		}
L_loadEnHeighLow28:
;lcd.c,288 :: 		lcdrow2[indx++] = BCD2LowerCh(discrr);
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
;lcd.c,289 :: 		lcdrow2[indx] = '\0';
	MOVF       loadEnHeighLow_indx_L0+0, 0
	ADDLW      _lcdrow2+0
	MOVWF      FSR
	CLRF       INDF+0
;lcd.c,290 :: 		Lcd_Out(2,1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,291 :: 		}else{
	GOTO       L_loadEnHeighLow29
L_loadEnHeighLow26:
;lcd.c,292 :: 		if (shouldUseDecimal){
	MOVF       FARG_loadEnHeighLow_shouldUseDecimal+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_loadEnHeighLow30
;lcd.c,293 :: 		Lcd_Out(2,1, codetxt_to_ramtxt("OFF  00.0   00.0"));
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
;lcd.c,294 :: 		}else{
	GOTO       L_loadEnHeighLow31
L_loadEnHeighLow30:
;lcd.c,295 :: 		Lcd_Out(2,1, codetxt_to_ramtxt("OFF  000   000 "));
	MOVLW      ?lstr_6_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_6_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;lcd.c,297 :: 		}
L_loadEnHeighLow31:
;lcd.c,299 :: 		}
L_loadEnHeighLow29:
;lcd.c,301 :: 		}
L_end_loadEnHeighLow:
	RETURN
; end of _loadEnHeighLow

_displayVoltageCurrent:

;lcd.c,302 :: 		void displayVoltageCurrent(){
;lcd.c,305 :: 		disVolt = Binary2BCD(lastReadVoltage);
	MOVF       _lastReadVoltage+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadVoltage+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_disVolt_L0+1
;lcd.c,306 :: 		discrr = Binary2BCD(lastReadCurrent);
	MOVF       _lastReadCurrent+0, 0
	MOVWF      FARG_Binary2BCD_a+0
	MOVF       _lastReadCurrent+1, 0
	MOVWF      FARG_Binary2BCD_a+1
	CALL       _Binary2BCD+0
	MOVF       R0+0, 0
	MOVWF      displayVoltageCurrent_discrr_L0+0
	MOVF       R0+1, 0
	MOVWF      displayVoltageCurrent_discrr_L0+1
;lcd.c,307 :: 		lcdrow1[9] = BCD2HignerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_disVolt_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+9
;lcd.c,308 :: 		lcdrow1[10] = BCD2UpperCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+10
;lcd.c,309 :: 		lcdrow1[11] = BCD2LowerCh(disVolt);
	MOVF       displayVoltageCurrent_disVolt_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow1+11
;lcd.c,311 :: 		lcdrow2[9] = BCD2HignerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2HignerCh_bcd+0
	MOVF       displayVoltageCurrent_discrr_L0+1, 0
	MOVWF      FARG_BCD2HignerCh_bcd+1
	CALL       _BCD2HignerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+9
;lcd.c,312 :: 		lcdrow2[10] = BCD2UpperCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2UpperCh_bcd+0
	CALL       _BCD2UpperCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+10
;lcd.c,313 :: 		lcdrow2[12] = BCD2LowerCh(discrr);
	MOVF       displayVoltageCurrent_discrr_L0+0, 0
	MOVWF      FARG_BCD2LowerCh_bcd+0
	CALL       _BCD2LowerCh+0
	MOVF       R0+0, 0
	MOVWF      _lcdrow2+12
;lcd.c,315 :: 		}
L_end_displayVoltageCurrent:
	RETURN
; end of _displayVoltageCurrent

_loadRamToDisp:

;lcd.c,316 :: 		void loadRamToDisp(){
;lcd.c,317 :: 		Lcd_Out(1, 1, lcdrow1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,318 :: 		Lcd_Out(2, 1, lcdrow2);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _lcdrow2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lcd.c,319 :: 		}
L_end_loadRamToDisp:
	RETURN
; end of _loadRamToDisp

_showWelome:

;lcd.c,323 :: 		void showWelome()
;lcd.c,325 :: 		Lcd_Out(2,1, codetxt_to_ramtxt("Welcome"));
	MOVLW      ?lstr_7_lcd+0
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+0
	MOVLW      hi_addr(?lstr_7_lcd+0)
	MOVWF      FARG_codetxt_to_ramtxt_ctxt+1
	CALL       _codetxt_to_ramtxt+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;lcd.c,326 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_showWelome32:
	DECFSZ     R13+0, 1
	GOTO       L_showWelome32
	DECFSZ     R12+0, 1
	GOTO       L_showWelome32
	DECFSZ     R11+0, 1
	GOTO       L_showWelome32
	NOP
	NOP
;lcd.c,327 :: 		}
L_end_showWelome:
	RETURN
; end of _showWelome
