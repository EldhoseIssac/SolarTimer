#include "Deff.h"
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
  while(1){
       readVoltage();
       readCurrent();


       if(shouldLoadDisp)
       {
         displayVoltageCurrent();
         loadTimeAndDate();
         displayTimeDate();
         loadRamToDisp();
         shouldLoadDisp = 0;
       }
       delay_ms(500);
  }
}