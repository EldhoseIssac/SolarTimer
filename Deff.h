//Global Variables

#include "Enums.h"

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



#if !DEBUG
sbit shouldLoadDisp at pgmStatus.B0;
sbit isEdited at  pgmStatus.B1;
sbit isEnabled at editValue.B0;
sbit shouldON at editValue.B1;

sbit shouldAlamSunday at editValue.B0;
sbit shouldAlamMonday at editValue.B1;
sbit shouldAlamTuesday at editValue.B2;
sbit shouldAlamWednesday at editValue.B3;
sbit shouldAlamThursday at editValue.B4;
sbit shouldAlamFriday at editValue.B5;
sbit shouldAlamSaturday at editValue.B6;

// LCD
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
#else
short shouldAlamSunday;
short shouldAlamMonday;
short shouldAlamTuesday;
short shouldAlamWednesday;
short shouldAlamThursday;
short shouldAlamFriday;
short shouldAlamSaturday;

#endif
void initLCD();
void displayTimeDate();
void displayVoltageCurrent();
void loadRamToDisp();
 void showWelome();

// ADC
void adcInit();
void readVoltage();
void readCurrent();

// RTC
void InitRTC();
void loadTimeAndDate();

//Timer
 void initTmr1();
 
void menuPortPinInt();
void checkKey();