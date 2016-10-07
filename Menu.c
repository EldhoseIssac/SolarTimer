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

void menuPortPinInt(){
    
#if !DEBUG
    TRISD.F7 = 1;
    TRISD.F6 = 1;
    TRISD.F5 = 1;
    TRISD.F4 = 1;
#endif
    
}

void checkKey(){
//    int val1;
//    int val2;
    if (MENU == 0) {
        Lcd_Cmd(_LCD_CLEAR);
        switch (crntMenu) {
            case None:
                Lcd_Cmd(_LCD_UNDERLINE_ON);
                crntMenu = Date;
                subMenu = DateDay;
                strcpy(lcdrow1, "Date");
                loadDateEdit();
                break;
            case Date:
                crntMenu = Time;
                subMenu = TimeHour;
                strcpy(lcdrow1, "Time");
                loadTimeEdit();
                break;
            case Voltage:
                crntMenu = Voltage;
                subMenu = VoltageEnable;
                strcpy(lcdrow1, "Volt Heigh Low");
                loadEnHeighLow(voltHeigh(),voltLow());
                break;
            case Current:
                crntMenu = Current;
                subMenu = CurrentEnable;
                strcpy(lcdrow1, "Amp Heigh Low");
                loadEnHeighLow(currHeigh(),currLow());
                break;
            case LDRVal:
                crntMenu = Current;
                subMenu = CurrentEnable;
                strcpy(lcdrow1, "LDR Heigh Low");
                loadEnHeighLow(currHeigh(),currLow());
                break;
            default:
                crntMenu = Date;
                subMenu = DateDay;
                Lcd_Cmd(_LCD_CURSOR_OFF);
                break;
        }
        setCursorPosition(subMenu);
    }else if (SELECT == 0){
        
    }else if (PLUS == 0){
        
    }else if (MINUS == 0){
        
    }
}
