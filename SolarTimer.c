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
unsigned short EEPROM_Read(unsigned short addr);
unsigned ee_read(unsigned short addr);
void delay_ms(unsigned int del);
void Lcd_Out(int row,int col,char  *sting);
#define Lo(param) ((char *)&param)[0]
#define Hi(param) ((char *)&param)[1]
#else
#include <built_in.h>
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
 
#if DEBUG
void SOLARmain() {
    unsigned short PORTC0 = 0;
    #define MOTOR PORTC0
#else
    #define MOTOR PORTC.F0
void main() 
{

#endif
      unsigned short index;
      unsigned short tmp;
      lastTimeCheckValue = 0;
    osccon = 0x71;
    ansel  = 7;
    anselh  = 0;
    trisb = 0;
    trisd = 0;
    ADC_Init();
    initLCD();
    InitRTC();
    initTmr1();
    menuPortPinInt();

    shouldLoadDisp = 1;
    showWelome();
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
             editValue = EEPROM_Read(index);
             tmp = editValue & (1 << (dday-1));
             if(tmp)
             {
                 editValue = ee_read(index+1);
                 if(editValue != lastTimeCheckValue)
                 {
                     if(Hi(editValue) == hour)
                     {
                         if(Lo(editValue) == minute)
                         {
                             lastTimeCheckValue = editValue;
                              MOTOR = 1;
                         }
                     }
                 }else
                 {
                     editValue = ee_read(index+3);
                     if(editValue != lastTimeCheckValue)
                     {
                         if(Hi(editValue) == hour)
                         {
                              lastTimeCheckValue = editValue;
                              MOTOR = 0;
                         }
                     }

                 }
                 
                 
             }
            }
       }

     }
}
