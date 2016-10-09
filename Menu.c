#include "Enums.h"
#if DEBUG
#include <string.h>
short MENU;
short SELECT;
short PLUS;
short MINUS;
extern short _LCD_CLEAR;
extern short _LCD_UNDERLINE_ON;
extern short _LCD_CURSOR_OFF;
void Lcd_Cmd(short command);
#else
#define MENU PORTD.F7
#define SELECT PORTD.F6
#define PLUS PORTD.F5
#define MINUS PORTD.F5
#endif


#define ON  1
#define OFF 0
extern char lcdrow1[];
extern char lcdrow2[];

extern unsigned short crntMenu;
extern unsigned short subMenu;
unsigned char  editStr[10];
unsigned int editValue;

void loadDateEdit();
void loadTimeEdit();
void setCursorPosition(unsigned short position);

int voltHeigh();
int voltLow();
int currHeigh();
int currLow();
int LDRHeigh();
int LDRLow();
int onOffTimeAt(short inx);
void saveVoltHeigh(unsigned int val);
void saveVoltLow(unsigned int val);
void saveCurrHeigh(unsigned int val);
void saveCurrLow(unsigned int val);
void saveLDRHeigh(unsigned int val);
void saveLDRLow(unsigned int val);
void saveOnOffTimeAt(unsigned short inx,unsigned int val);
void loadEnHeighLow(unsigned int heigh,unsigned int low);

char * codetxt_to_ramtxt(const char* ctxt)
{
static char txt[20];
char i;
  for(i =0; i<20; i++){
     txt[i] = ctxt[i];
  }
  return txt;
}

void strCpyLimit(unsigned char *source,unsigned char *dest,short from,short count)
{
  unsigned short index = from;
  unsigned short to = from + count;
  for(index = from;index<to;index++){
            dest[index - from] = source[index];
  }
  dest[index - from] = '\0';
}
void menuPortPinInt(){
    
#if !DEBUG
    TRISD.F7 = 1;
    TRISD.F6 = 1;
    TRISD.F5 = 1;
    TRISD.F4 = 1;
#endif
    
}

void checkKey(){

do{
         if (MENU == ON) {
         editStr[0] = '\0';

          Lcd_Cmd(_LCD_CLEAR);
          switch (crntMenu) {
              case None:
                  Lcd_Cmd(_LCD_UNDERLINE_ON);
                  crntMenu = Date;
                  subMenu = DateDay;
                  loadDateEdit();
                  strCpyLimit(lcdrow2,editStr,0,2);
                  editValue = day;
                  break;
              case Date:
                  crntMenu = Time;
                  subMenu = TimeHour;
                  loadTimeEdit();
                  strCpyLimit(lcdrow2,editStr,0,2);
                  editValue = hour;
                  break;
              case Time:
                  crntMenu = Voltage;
                  subMenu = VoltageEnable;
                  Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh Low"));
                  editValue = voltHeigh();
                  loadEnHeighLow(editValue,voltLow());
                  strCpyLimit(lcdrow2,editStr,0,3);
                  break;
              case Voltage:
                  crntMenu = Current;
                  subMenu = CurrentEnable;
                  Lcd_Out(1,1, codetxt_to_ramtxt("Amp Heigh Low"));
                  editValue = currHeigh();
                  loadEnHeighLow(editValue,currLow());
                  strCpyLimit(lcdrow2,editStr,0,3);
                  break;
              case Current:
                  crntMenu = LDRVal;
                  subMenu = LDRValEnable;
                  editValue = LDRHeigh();
                  Lcd_Out(1,1, codetxt_to_ramtxt("LDR Heigh Low"));
                  loadEnHeighLow(editValue,LDRLow());
                  strCpyLimit(lcdrow2,editStr,0,3);
                  break;
              default:
                  crntMenu = None;
                  subMenu = NoEdit;
                  strCpyLimit(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"),0,16);
                  strCpyLimit(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "),0,16);
                  break;
          }
          setCursorPosition(subMenu);
        }else if (SELECT == ON){
              delay_ms(30);
              switch (crntMenu) {
              case Date:
                   switch(subMenu){
                            case DateDay:
                                 subMenu = DateMonth;
                                 editValue = month;
                                 break;
                            case DateMonth:
                                 subMenu = DateYear;
                                 editValue = year;
                                 break;
                            case DateYear:
                                 subMenu = DateWeekDay;
                                 editValue = dday;
                                 break;
                            default:
                                 subMenu = DateDay;
                                 editValue = day;
                   }
                  break;
              case Time:
                   switch(subMenu){
                            case TimeHour:
                                 subMenu = TimeMinute;
                                 editValue = minute;
                                 break;
                            default:
                                 subMenu = TimeHour;
                                 editValue = hour;
                   }

                  break;
              case Voltage:
                   switch(subMenu){
                            case VoltageEnable:
                                 subMenu = VoltageHigh;
                                 break;
                            case VoltageHigh:
                                 subMenu = VoltageLow; break;
                            default:
                                 subMenu = VoltageEnable;
                   }
                  break;
              case Current:
                   switch(subMenu){
                            case CurrentEnable:
                                 subMenu = CurrentHeigh; break;
                            case CurrentHeigh:
                                 subMenu = CurrentLow; break;
                            default:
                                 subMenu = CurrentHeigh;
                   }
                  break;
              case LDRVal:
                    switch(subMenu){
                            case LDRValEnable:
                                 subMenu = LDRValHeigh; break;
                            case LDRValHeigh:
                                 subMenu = LDRValLow; break;
                            default:
                                 subMenu = LDRValHeigh;
                   }
                  break;
              default:
                  break;
          }
         setCursorPosition(subMenu);
        }else if (PLUS == ON){
        
              delay_ms(30);

        }else if (MINUS == ON){
              delay_ms(30);

        }
         delay_ms(100);
 }while(crntMenu != None);


}