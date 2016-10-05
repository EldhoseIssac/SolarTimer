#if DEBUG
#include <string.h>
short MENU;
short SELECT;
short PLUS;
short MINUS;
extern short _LCD_CLEAR;
void Lcd_Cmd(short command);
#else
#define MENU PORTD.F7
#define SELECT PORTD.F6
#define PLUS PORTD.F5
#define MINUS PORTD.F5
#endif

extern char lcdrow1[];
extern char lcdrow2[];

enum menus {
    None,
    Date,
    Time,
    Voltage,
    Current,
    LDRVal,
    OnOFFTimerCnt,
    OnOFFTime
};
enum subMenu{
    NoEdit,
    DateDay,
    DateMonth,
    DateYear,
    DateWeekDay,
    
    TimeHour,
    TimeMinute,
    
    VoltageEnable,
    VoltageHigh,
    VoltageLow,
    
    CurrentEnable,
    CurrentHeigh,
    CurrentLow,
    
    LDRValEnable,
    LDRValHeigh,
    LDRValLow,
    
    OnOFFTimerCntEdit,
    OnOFFTimeEdit
    

};
short crntMenu = None;
short subMenu = NoEdit;
void loadDateEdit();
void loadTimeEdit();


int voltHeigh();
int voltLow();
int currHeigh();
int currLow();
int LDRHeigh();
int LDRLow();
int onOffTimeAt(short inx);
void saveVoltHeigh(int val);
void saveVoltLow(int val);
void saveCurrHeigh(int val);
void saveCurrLow(int val);
void saveLDRHeigh(int val);
void saveLDRLow(int val);
void saveOnOffTimeAt(short inx,int val);


void menuPortPinInt(){
    
#if !DEBUG
    TRISD.F7 = 1;
    TRISD.F6 = 1;
    TRISD.F5 = 1;
    TRISD.F4 = 1;
#endif
    
}

void checkKey(){
    int val1;
    int val2;
    if (MENU) {
        Lcd_Cmd(_LCD_CLEAR);
        switch (crntMenu) {
            case None:
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
                subMenu = VoltageHigh;
                strcpy(lcdrow1, "Volt Heigh Low");
                val1 = voltHeigh();
                val2 = voltLow();
                if (val1>0) {
                    lcdrow1[0] = 'O';
                    lcdrow1[1] = 'N';
                    
                }else{
                    strcpy(lcdrow2, "OFF   0.0  0.0");
                }
                break;
                
                
        }
    }
}
