#line 1 "F:/PROGAMS/hussian/SolarTimer/SolarTimer.c"
#line 1 "c:/program files (x86)/mikroc pro for pic/include/built_in.h"
#line 1 "f:/progams/hussian/solartimer/deff.h"
#line 1 "f:/progams/hussian/solartimer/enums.h"


enum menus {
 None,
 Date,
 Time,
 Voltage,
 Current,
 LDRVal,

 OnOFFTimeDay1,
 OnOFFTime1,
 OnOFFTimeDay2,
 OnOFFTime2,
 OnOFFTimeDay3,
 OnOFFTime3,
 OnOFFTimeDay4,
 OnOFFTime4,
 OnOFFTimeDay5,
 OnOFFTime5,
 OnOFFTimeDay6,
 OnOFFTime6,
 OnOFFTimeDay7,
 OnOFFTime7,
 OnOFFTimeDay8,
 OnOFFTime8

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


 OnOFFTimeDaySun = 2,
 OnOFFTimeDayMon = 4,
 OnOFFTimeDayTue = 6,
 OnOFFTimeDayWed = 8,
 OnOFFTimeDayThu = 10,
 OnOFFTimeDayFri = 12,
 OnOFFTimeDaySat = 14,


 OnOFFTimeOnHr = 3,
 OnOFFTimeOnMin = 6,
 OnOFFTimeOffHr = 11,
 OnOFFTimeOffMin = 14


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

 EEPADDR_OnOFFTimeDay1 = 20,
 EEPADDR_OnOFFTimeDay2 = 25,
 EEPADDR_OnOFFTimeDay3 = 30,
 EEPADDR_OnOFFTimeDay4 = 35,
 EEPADDR_OnOFFTimeDay5 = 40,
 EEPADDR_OnOFFTimeDay6 = 45,
 EEPADDR_OnOFFTimeDay7 = 50,
 EEPADDR_OnOFFTimeDay8 = 55,
 EEPADDR_OnOFFTimeDay9 = 60,
 EEPADDR_OnOFFTimeDay10 = 65,
 EEPADDR_OnOFFTimeDay11 = 70,
 EEPADDR_OnOFFTimeDay12 = 75,
 EEPADDR_OnOFFTimeDay13 = 80,
 EEPADDR_OnOFFTimeDay14 = 85
};
enum TIMERMEM
{
 TIMERMEMDays = 0,
 TIMERMEMOnHour = 1,
 TIMERMEMOnMin = 2,
 TIMERMEMOffHour = 3,
 TIMERMEMOffMin = 4
};
#line 5 "f:/progams/hussian/solartimer/deff.h"
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

sbit shouldAlamSunday at editValue.B0;
sbit shouldAlamMonday at editValue.B1;
sbit shouldAlamTuesday at editValue.B2;
sbit shouldAlamWednesday at editValue.B3;
sbit shouldAlamThursday at editValue.B4;
sbit shouldAlamFriday at editValue.B5;
sbit shouldAlamSaturday at editValue.B6;


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
#line 67 "f:/progams/hussian/solartimer/deff.h"
void initLCD();
void displayTimeDate();
void displayVoltageCurrent();
void loadRamToDisp();
 void showWelome();


void adcInit();
void readVoltage();
void readCurrent();


void InitRTC();
void loadTimeAndDate();


 void initTmr1();

void menuPortPinInt();
void checkKey();
#line 25 "F:/PROGAMS/hussian/SolarTimer/SolarTimer.c"
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
unsigned char BCD2UpperCh(unsigned char bcd);
unsigned char BCD2LowerCh(unsigned char bcd);
unsigned int Binary2BCD(int a);
unsigned short mStatus;
unsigned short onIndex = 0;





void main()
{


 unsigned short index;
 unsigned short tmp;
 unsigned int onVal;
 unsigned int offVal;
 unsigned int minHrVal;
 osccon = 0x71;
 ansel = 7;
 anselh = 0;
 trisb = 0;
 trisd = 0;
 trisc = 0;
 ADC_Init();
 initLCD();
 InitRTC();
 initTmr1();
 menuPortPinInt();

 shouldLoadDisp = 1;
 showWelome();
 mStatus = 0;

 while(1)
 {

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
 for (index = EEPADDR_OnOFFTimeDay1;index<EEPADDR_OnOFFTimeDay9; index+=5)
 {
 if (mStatus)
 {
 if (index != onIndex)
 {
 continue;
 }
 }
 editValue = EEPROM_Read(index);
 tmp = editValue & (1 << (dday-1));









 if(tmp)
 {
 onVal = ee_read(index+1);
 offVal = ee_read(index+3);

 editValue = onVal;
  ((char *)&onVal)[1]  =  ((char *)&editValue)[0] ;
  ((char *)&onVal)[0]  =  ((char *)&editValue)[1] ;

 editValue = offVal;
  ((char *)&offVal)[1]  =  ((char *)&editValue)[0] ;
  ((char *)&offVal)[0]  =  ((char *)&editValue)[1] ;

  ((char *)&minHrVal)[1]  = hour;
  ((char *)&minHrVal)[0]  = minute;
#line 147 "F:/PROGAMS/hussian/SolarTimer/SolarTimer.c"
 if (minHrVal >= onVal && minHrVal < offVal )
 {



  PORTC.F1  = 1;
 mStatus = 1;
 onIndex = index;
 }else
 {




  PORTC.F1  = 0;
 mStatus = 0;
 onIndex = 0;
 }




 }
 }
 }

 }
}
