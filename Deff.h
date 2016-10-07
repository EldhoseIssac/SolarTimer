//Global Variables

#include "Enums.h"
char lcdrow1[] = "00:00:00 000 TUE";
char lcdrow2[] = "00/00/00 00.0A  ";
int voltage,current;

unsigned short second;
unsigned short minute;
unsigned short hour;
unsigned short day;
unsigned short dday;
unsigned short month;
unsigned short year;

unsigned short crntMenu = None;
unsigned short subMenu = NoEdit;


unsigned short set_count = 0;
short set;
unsigned int dispUpdateCount =0;
unsigned short pgmStatus = 0;
#if !DEBUG
sbit shouldLoadDisp at pgmStatus.B0;

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

#endif
void initLCD();
void displayTimeDate();
void displayVoltageCurrent();
void loadRamToDisp();

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
