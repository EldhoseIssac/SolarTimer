
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
//https://electrosome.com/digital-clock-pic-microcontroller-ds1307/

#if DEBUG
#include <string.h>
#include <stdio.h>
short _LCD_CLEAR;
short _LCD_CURSOR_OFF;
short _LCD_UNDERLINE_ON;
short _LCD_SECOND_ROW;
short _LCD_MOVE_CURSOR_RIGHT;
short _LCD_CURSOR_OFF;
void Lcd_Init(){
    
}
void Lcd_Cmd(short command){
    
}
void Lcd_out(int row,int col,char * sting){
    printf("at %d,%d : %s",row,col,sting);
}


#endif
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
   switch(dday){
     case 1: lcdrow1[13]='S';lcdrow1[14]='u'; lcdrow1[15]='n';break;
     case 2: lcdrow1[13]='M';lcdrow1[14]='o'; lcdrow1[15]='n';break;
     case 3: lcdrow1[13]='T';lcdrow1[14]='u'; lcdrow1[15]='e';break;
     case 4: lcdrow1[13]='W';lcdrow1[14]='e'; lcdrow1[15]='d';break;
     case 5: lcdrow1[13]='T';lcdrow1[14]='h'; lcdrow1[15]='u';break;
     case 6: lcdrow1[13]='F';lcdrow1[14]='r'; lcdrow1[15]='i';break;
     case 7: lcdrow1[13]='S';lcdrow1[14]='a'; lcdrow1[15]='t';break;
    }
}
void loadTimeEdit(){
    Lcd_Out(1,1,"Set Time");
    lcdrow2[0] = BCD2UpperCh(hour);
    lcdrow2[1] = BCD2LowerCh(hour);
    lcdrow2[2] = ':';
    lcdrow2[3] = BCD2UpperCh(minute);
    lcdrow2[4] = BCD2LowerCh(minute);
    lcdrow2[5] = '\0';
    Lcd_Out(2,1,lcdrow2);
}
void loadDateEdit(){
     Lcd_Out(1,1,"Set Date");
    lcdrow2[0] = BCD2UpperCh(day);
    lcdrow2[1] = BCD2LowerCh(day);
    lcdrow2[2] = '/';
    lcdrow2[3] = BCD2UpperCh(month);
    lcdrow2[4] = BCD2LowerCh(month);
    lcdrow2[5] = '/';
    lcdrow2[6] = BCD2UpperCh(year);
    lcdrow2[7] = BCD2LowerCh(year);
    switch(dday){
        case 1: lcdrow2[9]='S';lcdrow2[10]='u'; lcdrow2[11]='n';break;
        case 2: lcdrow2[9]='M';lcdrow2[10]='o'; lcdrow2[11]='n';break;
        case 3: lcdrow2[9]='T';lcdrow2[10]='u'; lcdrow2[11]='e';break;
        case 4: lcdrow2[9]='W';lcdrow2[10]='e'; lcdrow2[11]='d';break;
        case 5: lcdrow2[9]='T';lcdrow2[10]='h'; lcdrow2[11]='u';break;
        case 6: lcdrow2[9]='F';lcdrow2[10]='r'; lcdrow2[11]='i';break;
        case 7: lcdrow2[9]='S';lcdrow2[10]='a'; lcdrow2[11]='t';break;
    }
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

void loadEnHeighLow(unsigned int heigh,unsigned int low){
    unsigned int disVolt = Binary2BCD(heigh);
    unsigned int discrr= Binary2BCD(low);

    if (heigh>0) {
        lcdrow1[0] = 'O';
        lcdrow1[1] = 'N';
        heigh = heigh>>1;
        lcdrow2[6] = BCD2HignerCh(disVolt);
        lcdrow2[7] = BCD2UpperCh(disVolt);
        lcdrow2[8] = BCD2LowerCh(disVolt);
        
        lcdrow2[10] = BCD2HignerCh(discrr);
        lcdrow2[11] = BCD2UpperCh(discrr);
        lcdrow2[12] = BCD2LowerCh(discrr);
        lcdrow2[13] = '\0';
        Lcd_Out(2,1, lcdrow2);
    }else{
        Lcd_Out(2,1, "OFF   0.0  0.0");
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