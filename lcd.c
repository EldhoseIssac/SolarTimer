#include "Enums.h"
extern char lcdrow1[];
extern char lcdrow2[];


extern unsigned short crntMenu;
extern unsigned short subMenu;

extern unsigned short second;
extern unsigned short minute;
extern unsigned short hour;
extern unsigned short day;
extern unsigned short dday;
extern unsigned short month;
extern unsigned short year;

extern unsigned int editValue;



extern unsigned lastReadVoltage,lastReadCurrent;
char * codetxt_to_ramtxt(const char* ctxt);

//https://electrosome.com/digital-clock-pic-microcontroller-ds1307/

#if DEBUG
#include <string.h>
#include <stdio.h>
short _LCD_CLEAR;
short _LCD_CURSOR_OFF;
short _LCD_UNDERLINE_ON;
short _LCD_SECOND_ROW;
short _LCD_FIRST_ROW;
short _LCD_MOVE_CURSOR_RIGHT;
short _LCD_BLINK_CURSOR_ON;
void Lcd_Init(){
    
}
void Lcd_Cmd(short command){
    
}
void Lcd_Out(int row,int col,char  *sting){
    printf("at %d,%d : %s",row,col,sting);
}
short Lo(unsigned int val){
    return (short) val;
}
void Lcd_Chr(int row,int col,char  chr)
{
    
}
void Lcd_Chr_CP(char  chr)
{
    
}
extern short isEnabled;
extern short shouldAlamSunday;
extern short shouldAlamMonday;
extern short shouldAlamTuesday;
extern short shouldAlamWednesday;
extern short shouldAlamThursday;
extern short shouldAlamFriday;
extern short shouldAlamSaturday;
#define Lo(param) ((char *)&param)[0]
#define Hi(param) ((char *)&param)[1]


char swap(char input)
{
    return  'a';
}
 #else
#include <built_in.h>
extern sbit isEnabled;
extern sbit shouldON;

extern sbit shouldAlamSunday;
extern sbit shouldAlamMonday;
extern sbit shouldAlamTuesday;
extern sbit shouldAlamWednesday;
extern sbit shouldAlamThursday;
extern sbit shouldAlamFriday;
extern sbit shouldAlamSaturday;
#endif

void initLCDRaws()
{
 strcpy(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"));
 strcpy(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "));

}
void initLCD(){
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  initLCDRaws();
}
unsigned char BCD2HignerCh(unsigned int bcd)
{
    
  return ((Hi(bcd) & 0x0F)+ '0');
}
unsigned char BCD2UpperCh(unsigned char bcd)
{
  return ((swap(bcd) & 0x0F) + '0');
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
void loadDay(char *arr,unsigned short theIndx){
   switch(theIndx){
     case 0: arr[0]='-';arr[1]='-'; arr[2]='-';break;
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
    if ((crntMenu > LDRVal)   && (crntMenu - OnOFFTimeDay1) % 2 == 0 ) {
        Lcd_Cmd(_LCD_FIRST_ROW);
    }
    else{
        Lcd_Cmd(_LCD_SECOND_ROW);
    }
    
    for (indx=0; indx<position; indx++) {
         Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
    }
}
void loadEnabledDay()
{
    unsigned short tmp = editValue;
    unsigned short indx = 2;
    unsigned short i = 0;
    
    lcdrow1[0]= ((crntMenu - OnOFFTimeDay1)>> 1) + '0' + 1;
    lcdrow1[1] = ')';
    for (i = 0 ; i < 8; i++)
    {
        if ((tmp & 1) != 0)
        {
            loadDay(&lcdrow1[indx],i+1);
        }else
        {
            loadDay(&lcdrow1[indx],0);
        }
        tmp = tmp >> 1;
        indx += 2;
    }
    lcdrow1[16] = '\0';
    Lcd_Out(1, 1, lcdrow1);
}

void loadOnOffTime()
{
    unsigned short mi = Hi(editValue);
    unsigned short hr = Lo(editValue);
    unsigned int tmp;
    if (subMenu == OnOFFTimeOnHr || subMenu == OnOFFTimeOnMin) {
        tmp = OnOFFTimeOnHr-2;
        lcdrow2[0] = 'N';
    }else
    {
        tmp = OnOFFTimeOffHr-2;
        lcdrow2[0] = 'F';
    }
    lcdrow2[1] = '>';
    lcdrow2[2] = BCD2UpperCh(hr);
    lcdrow2[3] = BCD2LowerCh(hr);
    lcdrow2[4] = ':';
    lcdrow2[5] = BCD2UpperCh(mi);
    lcdrow2[6] = BCD2LowerCh(mi);
    lcdrow2[7] = '\0';
    Lcd_Out(2, tmp, lcdrow2);
    
}

void loadEnHeighLow(unsigned int heigh,unsigned int low,const unsigned short shouldUseDecimal)
{
    unsigned int disVolt;// = Binary2BCD(heigh);
    unsigned int discrr = Binary2BCD(low);
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
        if (shouldUseDecimal){
             Lcd_Out(2,1, codetxt_to_ramtxt("OFF  00.0   00.0"));
        }else{
              Lcd_Out(2,1, codetxt_to_ramtxt("OFF  000   000 "));

        }

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
      Lcd_Out(1, 1, lcdrow1);
      Lcd_Out(2, 1, lcdrow2);
 }
 void showWelome()
 {
   Lcd_Out(2,1, codetxt_to_ramtxt("Welcome"));
   Delay_ms(1000);
 }