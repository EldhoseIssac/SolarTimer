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

void strCpyLimit(unsigned char *source,unsigned char *dest,short from,short count){
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
 unsigned char editStr[10];
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
                  editStr[0] = lcdrow2[0];
                  editStr[1] = lcdrow2[1];
                  editStr[2] = '\0';
                  break;
              case Date:
                  crntMenu = Time;
                  subMenu = TimeHour;
                  loadTimeEdit();
                  editStr[0] = lcdrow2[0];
                  editStr[1] = lcdrow2[1];
                  editStr[2] = '\0';
                  break;
              case Time:
                  crntMenu = Voltage;
                  subMenu = VoltageEnable;
                  Lcd_Out(1,1, "Volt Heigh Low");
                  loadEnHeighLow(voltHeigh(),voltLow());
                  editStr[0] = lcdrow2[0];
                  editStr[1] = lcdrow2[1];
                  editStr[2] = lcdrow2[2];
                  editStr[3] = '\0';
                  break;
              case Voltage:
                  crntMenu = Current;
                  subMenu = CurrentEnable;
                  Lcd_Out(1,1, "Amp Heigh Low");
                  loadEnHeighLow(currHeigh(),currLow());
                  editStr[0] = lcdrow2[0];
                  editStr[1] = lcdrow2[1];
                  editStr[2] = lcdrow2[2];
                  editStr[3] = '\0';
                  break;
              case Current:
                  crntMenu = LDRVal;
                  subMenu = LDRValEnable;
                  Lcd_Out(1,1, "LDR Heigh Low");
                  loadEnHeighLow(currHeigh(),currLow());
                  editStr[0] = lcdrow2[0];
                  editStr[1] = lcdrow2[1];
                  editStr[2] = lcdrow2[2];
                  editStr[3] = '\0';
                  break;
              default:
                  crntMenu = None;
                  subMenu = NoEdit;
                   strcpy(lcdrow1,"00:00:00 000 TUE");
                   strcpy(lcdrow2,"00/00/00 00.0A  ");
                  //Lcd_Cmd(_LCD_CURSOR_OFF);
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
                                 break;
                            case DateMonth:
                                 subMenu = DateYear;
                                 break;
                            case DateYear:
                                 subMenu = DateWeekDay;
                                 break;
                            default:
                                 subMenu = DateDay;
                   }
                  break;
              case Time:
                   switch(subMenu){
                            case TimeHour:
                                 subMenu = TimeMinute;
                                 break;
                            default:
                                 subMenu = TimeHour;
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