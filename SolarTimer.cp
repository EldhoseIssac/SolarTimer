#line 1 "E:/PROGAMS/hussian/SolarTimer/SolarTimer.c"
#line 1 "e:/progams/hussian/solartimer/deff.h"
#line 1 "e:/progams/hussian/solartimer/enums.h"


enum menus {
 None,
 Date,
 Time,
 Voltage,
 Current,
 LDRVal,

 OnOFFTime
};

enum subMenu{
 NoEdit,

 DateDay = 0,
 DateMonth = 3,
 DateYear = 6,
 DateWeekDay = 9,

 TimeHour = 0,
 TimeMinute = 3,

 VoltageEnable = 0,
 VoltageHigh = 7,
 VoltageLow = 13,

 CurrentEnable = 0,
 CurrentHeigh = 8,
 CurrentLow = 13,

 LDRValEnable = 0,
 LDRValHeigh = 8,
 LDRValLow = 13,


 OnOFFTimeEditEnable = 0,
 OnOFFTimeEditOnOff = 4,
 OnOFFTimeEditWeekDay = 6,
 OnOFFTimeEditHour = 11,
 OnOFFTimeEditMint = 14

};

enum EEPADDR
{
 EEPADDR_VoltageHigh = 0x02,
 EEPADDR_VoltageLow = 0x04,

 EEPADDR_CurrentHeigh = 0x06,
 EEPADDR_CurrentLow = 0x08,

 EEPADDR_LDRValHeigh = 10,
 EEPADDR_LDRValLow = 12,

 EEPADDR_OnOFFTimerCntEdit = 14,
 EEPADDR_OnOFFTimeEdit1 = 16,
 EEPADDR_OnOFFTimeEdit2 = 18,
 EEPADDR_OnOFFTimeEdit3 = 20,
 EEPADDR_OnOFFTimeEdit4 = 22,
 EEPADDR_OnOFFTimeEdit5 = 24,
 EEPADDR_OnOFFTimeEdit6 = 26,
 EEPADDR_OnOFFTimeEdit7 = 28,
 EEPADDR_OnOFFTimeEdit8 = 30,
 EEPADDR_OnOFFTimeEdit9 = 32,
 EEPADDR_OnOFFTimeEdit10 = 34,
 EEPADDR_OnOFFTimeEdit11 = 36,
 EEPADDR_OnOFFTimeEdit12 = 38


};
#line 5 "e:/progams/hussian/solartimer/deff.h"
unsigned lastReadVoltage;
unsigned lastReadCurrent;

unsigned short second;
unsigned short minute;
unsigned short hour;
unsigned short day;
unsigned short dday;
unsigned short month;
unsigned short year;

unsigned short crntMenu = None;
unsigned short subMenu = NoEdit;
char lcdrow1[17];
char lcdrow2[17];

unsigned short set_count = 0;
short set;
unsigned int dispUpdateCount =0;
unsigned short pgmStatus = 0;
unsigned int editValue;

sbit shouldLoadDisp at pgmStatus.B0;
sbit isEdited at pgmStatus.B1;
sbit isEnabled at editValue.B0;
sbit shouldON at editValue.B1;

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
#line 48 "e:/progams/hussian/solartimer/deff.h"
void initLCD();
void displayTimeDate();
void displayVoltageCurrent();
void loadRamToDisp();


void adcInit();
void readVoltage();
void readCurrent();


void InitRTC();
void loadTimeAndDate();


 void initTmr1();

void menuPortPinInt();
void checkKey();
#line 20 "E:/PROGAMS/hussian/SolarTimer/SolarTimer.c"
void interrupt()
{





 if(PIR1.TMR1IF)
 {
 PIR1.TMR1IF=0;


 dispUpdateCount++;
 if (dispUpdateCount > 2){
 shouldLoadDisp = 1;
 dispUpdateCount = 0;
 }
 }
}
unsigned ee_read(unsigned short addr);
unsigned int lastTimeCheckValue;




void main() {


 unsigned short index;
 unsigned short tmp;
 lastTimeCheckValue = 0;

 ansel = 7;
 anselh = 0;
 trisb = 0;
 trisd = 0;
 ADC_Init();
 initLCD();
 InitRTC();
 initTmr1();
 menuPortPinInt();

 shouldLoadDisp = 1;
 Lcd_Out(1,1,"Welcome");
 while(1);
 while(1){
 readVoltage();
 readCurrent();
 checkKey();

 if(shouldLoadDisp)
 {
 displayVoltageCurrent();
 loadTimeAndDate();
 displayTimeDate();
 loadRamToDisp();
 shouldLoadDisp = 0;
 for (index = EEPADDR_OnOFFTimeEdit1;index<EEPADDR_OnOFFTimeEdit9;index+=2)
 {
 editValue = ee_read(index);
 if(!isEnabled)
 {
 continue;
 }
 if (lastTimeCheckValue != editValue)
 {
 tmp = editValue;
 tmp = (tmp & 0x1C) >> 2;
 if (tmp != 0 || tmp != dday)
 {
 continue;
 }
 tmp = (editValue & 0x03E0) >> 5;
 if (tmp != hour)
 {
 continue;
 }
 tmp = (editValue & 0xFC00) >> 10;
 if (tmp != minute)
 {
 continue;
 }
  PORTC.F0  = shouldON;

 }
 }
 }
 }
}
