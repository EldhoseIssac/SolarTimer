char row1[] = "00:00:00 000 TUE";
char row2[] = "00/00/00 00.0A  ";



extern unsigned short second;
extern unsigned short minute;
extern unsigned short hour;
extern unsigned short day;
extern unsigned short dday;
extern unsigned short month;
extern unsigned short year;

extern int voltage,current;
//https://electrosome.com/digital-clock-pic-microcontroller-ds1307/
void initLCD(){
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
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
  t3 +=  t1 | t2;
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
void displayTimeDate(){

    row1[0] = BCD2UpperCh(hour);
    row1[1] = BCD2LowerCh(hour);
    row1[3] = BCD2UpperCh(minute);
    row1[4] = BCD2LowerCh(minute);
    row1[6] = BCD2UpperCh(second);
    row1[7] = BCD2LowerCh(second);

    row2[0] = BCD2UpperCh(day);
    row2[1] = BCD2LowerCh(day);
    row2[3] = BCD2UpperCh(month);
    row2[4] = BCD2LowerCh(month);
    row2[6] = BCD2UpperCh(year);
    row2[7] = BCD2LowerCh(year);
   switch(dday){
     case 1: row1[13]='S';row1[14]='u'; row1[15]='n';break;
     case 2: row1[13]='M';row1[14]='o'; row1[15]='n';break;
     case 3: row1[13]='T';row1[14]='u'; row1[15]='e';break;
     case 4: row1[13]='W';row1[14]='e'; row1[15]='d';break;
     case 5: row1[13]='T';row1[14]='h'; row1[15]='u';break;
     case 6: row1[13]='F';row1[14]='r'; row1[15]='i';break;
     case 7: row1[13]='S';row1[14]='a'; row1[15]='t';break;
    }
}
void displayVoltageCurrent(){
 unsigned int disVolt;
 unsigned int discrr;
 disVolt = Binary2BCD(voltage);
 discrr = Binary2BCD(current);
  row1[9] = BCD2HignerCh(disVolt);
  row1[10] = BCD2UpperCh(disVolt);
  row1[11] = BCD2LowerCh(disVolt);

  row2[9] = BCD2HignerCh(discrr);
  row2[10] = BCD2UpperCh(discrr);
  row2[12] = BCD2LowerCh(discrr);

}
 void loadRamToDisp(){
      Lcd_out(1, 1, row1);
      Lcd_out(2, 1, row2);
 }