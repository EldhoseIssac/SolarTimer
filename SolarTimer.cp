#line 1 "E:/PROGAMS/hussian/SolarTimer/SolarTimer.c"
#line 1 "e:/progams/hussian/solartimer/deff.h"


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
unsigned short appStatus;



unsigned short set_count = 0;
short set;
unsigned int dispUpdateCount =0;
unsigned short pgmStatus = 0;

sbit shouldLoadDisp at pgmStatus.B0;


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
#line 42 "e:/progams/hussian/solartimer/deff.h"
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
#line 2 "E:/PROGAMS/hussian/SolarTimer/SolarTimer.c"
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
void main() {

 osccon = 0x70;
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
 while(1){
 readVoltage();
 readCurrent();
 checkKey();

 if(shouldLoadDisp)
 {
 if(appStatus.F0 == 0 ){
 displayVoltageCurrent();
 loadTimeAndDate();
 displayTimeDate();
 }

 loadRamToDisp();
 shouldLoadDisp = 0;
 }
 }
}
