#line 1 "E:/PROGAMS/hussian/SolarTimer/Menu.c"
#line 1 "e:/progams/hussian/solartimer/enums.h"


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

 DateDay = 0,
 DateMonth = 3,
 DateYear = 6,
 DateWeekDay = 13,

 TimeHour = 0,
 TimeMinute = 3,

 VoltageEnable = 0,
 VoltageHigh = 8,
 VoltageLow = 13,

 CurrentEnable = 0,
 CurrentHeigh = 8,
 CurrentLow = 13,

 LDRValEnable = 0,
 LDRValHeigh = 8,
 LDRValLow = 13,

 OnOFFTimerCntEdit,
 OnOFFTimeEdit


};
#line 22 "E:/PROGAMS/hussian/SolarTimer/Menu.c"
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


 TRISD.F7 = 1;
 TRISD.F6 = 1;
 TRISD.F5 = 1;
 TRISD.F4 = 1;


}

void checkKey(){

do{
 if ( PORTD.F7  ==  1 ) {

 Lcd_Cmd(_LCD_CLEAR);
 switch (crntMenu) {
 case None:
 Lcd_Cmd(_LCD_UNDERLINE_ON);
 crntMenu = Date;
 subMenu = DateDay;
 loadDateEdit();
 break;
 case Date:
 crntMenu = Time;
 subMenu = TimeHour;
 loadTimeEdit();
 break;
 case Time:
 crntMenu = Voltage;
 subMenu = VoltageEnable;
 Lcd_Out(1,1, "Volt Heigh Low");
 loadEnHeighLow(voltHeigh(),voltLow());
 break;
 case Voltage:
 crntMenu = Current;
 subMenu = CurrentEnable;
 Lcd_Out(1,1, "Amp Heigh Low");
 loadEnHeighLow(currHeigh(),currLow());
 break;
 case Current:
 crntMenu = LDRVal;
 subMenu = LDRValEnable;
 Lcd_Out(1,1, "LDR Heigh Low");
 loadEnHeighLow(currHeigh(),currLow());
 break;
 default:
 crntMenu = None;
 subMenu = NoEdit;
 strcpy(lcdrow1,"00:00:00 000 TUE");
 strcpy(lcdrow2,"00/00/00 00.0A  ");

 break;
 }
 setCursorPosition(subMenu);
 }else if ( PORTD.F6  ==  1 ){
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
 }else if ( PORTD.F5  ==  1 ){
 delay_ms(30);

 }else if ( PORTD.F5  ==  1 ){
 delay_ms(30);

 }
 delay_ms(100);
 }while(crntMenu != None);


}
