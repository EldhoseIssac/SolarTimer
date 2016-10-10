#line 1 "E:/PROGAMS/hussian/SolarTimer/lcd.c"

extern char lcdrow1[];
extern char lcdrow2[];



extern unsigned short second;
extern unsigned short minute;
extern unsigned short hour;
extern unsigned short day;
extern unsigned short dday;
extern unsigned short month;
extern unsigned short year;

extern unsigned lastReadVoltage,lastReadCurrent;
char * codetxt_to_ramtxt(const char* ctxt);
void strCpyLimit(unsigned char *source,unsigned char *dest,short from,short count);
#line 42 "E:/PROGAMS/hussian/SolarTimer/lcd.c"
void initLCDRaws()
{
 strcpy(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"));
 strcpy(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "));



}
void initLCD(){
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 initLCDRaws();
}
unsigned char BCD2HignerCh(unsigned int bcd)
{
 return (((bcd >> 8) & 0x0F)+ '0');
}
unsigned char BCD2UpperCh(unsigned char bcd)
{
 return (((bcd >> 4) & 0x0F) + '0');
}

unsigned char BCD2LowerCh(unsigned char bcd)
{
 return ((bcd & 0x0F) + '0');
}

unsigned int Binary2BCD(int a)
{
 unsigned short t1, t2;
 int t3;
 t1 = a%10;
 t1 = t1 & 0x0F;
 a = a/10;
 t2 = a%10;
 t2 = t2 & 0x0F;
 t2 = t2 << 4;
 t2 = 0xF0 & t2;
 a = a/10;
 t3 = a%10;
 t3 = t3 & 0x0F;
 t3 = t3 << 8;
 t3 += t1 | t2;
 return t3;
}

int BCD2Binary(int a)
{
 int r,t;
 t = a & 0x0F;
 r = t;
 a = 0xF0 & a;
 t = a >> 4;
 t = 0x0F & t;
 r = t*10 + r;
 return r;
}
void loadDay(unsigned char *arr,unsigned short theIndx){
 switch(theIndx){
 case 1: arr[0]='S';arr[1]='u'; arr[2]='n';break;
 case 2: arr[0]='M';arr[1]='o'; arr[2]='n';break;
 case 3: arr[0]='T';arr[1]='u'; arr[2]='e';break;
 case 4: arr[0]='W';arr[1]='e'; arr[2]='d';break;
 case 5: arr[0]='T';arr[1]='h'; arr[2]='u';break;
 case 6: arr[0]='F';arr[1]='r'; arr[2]='i';break;
 case 7: arr[0]='S';arr[1]='a'; arr[2]='t';break;
 }
}
void displayTimeDate(){

 lcdrow1[0] = BCD2UpperCh(hour);
 lcdrow1[1] = BCD2LowerCh(hour);
 lcdrow1[3] = BCD2UpperCh(minute);
 lcdrow1[4] = BCD2LowerCh(minute);
 lcdrow1[6] = BCD2UpperCh(second);
 lcdrow1[7] = BCD2LowerCh(second);

 lcdrow2[0] = BCD2UpperCh(day);
 lcdrow2[1] = BCD2LowerCh(day);
 lcdrow2[3] = BCD2UpperCh(month);
 lcdrow2[4] = BCD2LowerCh(month);
 lcdrow2[6] = BCD2UpperCh(year);
 lcdrow2[7] = BCD2LowerCh(year);
 loadDay(&lcdrow1[13],dday);

}

void loadTimeEdit(){
 Lcd_Out(1,1,codetxt_to_ramtxt("Set Time"));
 lcdrow2[0] = BCD2UpperCh(hour);
 lcdrow2[1] = BCD2LowerCh(hour);
 lcdrow2[2] = ':';
 lcdrow2[3] = BCD2UpperCh(minute);
 lcdrow2[4] = BCD2LowerCh(minute);
 lcdrow2[5] = '\0';
 Lcd_Out(2,1,lcdrow2);
}
void loadDateEdit(){
 Lcd_Out(1,1,codetxt_to_ramtxt("Set Date"));
 lcdrow2[0] = BCD2UpperCh(day);
 lcdrow2[1] = BCD2LowerCh(day);
 lcdrow2[2] = '/';
 lcdrow2[3] = BCD2UpperCh(month);
 lcdrow2[4] = BCD2LowerCh(month);
 lcdrow2[5] = '/';
 lcdrow2[6] = BCD2UpperCh(year);
 lcdrow2[7] = BCD2LowerCh(year);
 loadDay(&lcdrow2[9],dday);
 lcdrow2[12] = '\0';
 Lcd_Out(2,1,lcdrow2);
}
void setCursorPosition(unsigned short position){
 unsigned short indx;
 Lcd_Cmd(_LCD_SECOND_ROW);
 for (indx=0; indx<position; indx++) {
 Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
 }
}

void loadEnHeighLow(unsigned int heigh,unsigned int low,const unsigned short shouldUseDecimal)
{
 unsigned int disVolt;
 unsigned int discrr= Binary2BCD(low);
 unsigned short indx = 0;
 if (heigh>0) {
 lcdrow2[indx++] = 'O';
 lcdrow2[indx++] = 'N';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 heigh = heigh>>1;
 disVolt = Binary2BCD(heigh);
 lcdrow2[indx++] = BCD2HignerCh(disVolt);
 lcdrow2[indx++] = BCD2UpperCh(disVolt);
 if(shouldUseDecimal)
 {
 lcdrow2[indx++] = '.';
 }
 lcdrow2[indx++] = BCD2LowerCh(disVolt);
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = BCD2HignerCh(discrr);
 lcdrow2[indx++] = BCD2UpperCh(discrr);
 if(shouldUseDecimal)
 {
 lcdrow2[indx++] = '.';
 }
 lcdrow2[indx++] = BCD2LowerCh(discrr);
 lcdrow2[indx] = '\0';
 Lcd_Out(2,1, lcdrow2);
 }else{
 Lcd_Out(2,1, codetxt_to_ramtxt("OFF   0.0  0.0"));
 }

}
void displayVoltageCurrent(){
 unsigned int disVolt;
 unsigned int discrr;
 disVolt = Binary2BCD(lastReadVoltage);
 discrr = Binary2BCD(lastReadCurrent);
 lcdrow1[9] = BCD2HignerCh(disVolt);
 lcdrow1[10] = BCD2UpperCh(disVolt);
 lcdrow1[11] = BCD2LowerCh(disVolt);

 lcdrow2[9] = BCD2HignerCh(discrr);
 lcdrow2[10] = BCD2UpperCh(discrr);
 lcdrow2[12] = BCD2LowerCh(discrr);

}
 void loadRamToDisp(){
 Lcd_out(1, 1, lcdrow1);
 Lcd_out(2, 1, lcdrow2);
 }
