#if DEBUG

short PIR1_TMR1IF;
short shouldLoadDisp;
short osccon;
short ansel;
short anselh;
short trisb;
short trisd;

void ADC_Init(){
    
}

void delay_ms(unsigned int del);

#endif

#include "Deff.h"
void interrupt()
{
#if DEBUG
    if(PIR1_TMR1IF)
    {
        PIR1_TMR1IF=0;
#else
    if(PIR1.TMR1IF)
    {
        PIR1.TMR1IF=0;
#endif
 
   dispUpdateCount++;
   if (dispUpdateCount > 2){
      shouldLoadDisp = 1;
      dispUpdateCount = 0;
   }
 }
}
unsigned ee_read(unsigned short addr);
unsigned int lastTimeCheckValue;
 #define MOTOR PORTC.F0
#if DEBUG
void SOLARmain() {
#else
void main() 
{

#endif
//      unsigned short index;
//      unsigned short tmp;
      lastTimeCheckValue = 0;
    //osccon = 0x70;
    //ansel  = 7;
    //anselh  = 0;
    trisb = 0;
    trisd = 0;
    ADC_Init();
    initLCD();
    InitRTC();
    initTmr1();
    menuPortPinInt();

    shouldLoadDisp = 1;
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
       }

     }
}