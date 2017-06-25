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
unsigned char BCD2UpperCh(unsigned char bcd);
unsigned char BCD2LowerCh(unsigned char bcd);
unsigned int Binary2BCD(int a);
unsigned short mStatus;
unsigned short onIndex = 0; // an invalid Index
//#define Simulator 1
#define MOTOR PORTC.F1
#if DEBUG
void SOLARmain() {
#else
void main() 
{

#endif
      unsigned short index;
      unsigned short tmp;
      unsigned int onVal;
      unsigned int offVal;
      unsigned int minHrVal;
    osccon = 0x71;
    ansel  = 7;
    anselh  = 0;
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
#if !Simulator
      readVoltage();
      readCurrent();
      checkKey();
 #endif
       if(shouldLoadDisp)
       {
 #if Simulator

 #else
         displayVoltageCurrent();
         loadTimeAndDate();
         displayTimeDate();
         loadRamToDisp();
 #endif
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

   #if Simulator
     hour = 0x21;
     minute = 0x45;
            if(1)
             {
                 onVal = 0x4021;
                 offVal = 0x5021;
   #else
              if(tmp)
             {
                 onVal = ee_read(index+1);
                 offVal = ee_read(index+3);
  #endif
                 editValue = onVal;
                 Hi(onVal) = Lo(editValue);
                 Lo(onVal) = Hi(editValue);
                 
                 editValue = offVal;
                 Hi(offVal) = Lo(editValue);
                 Lo(offVal) = Hi(editValue);

                 Hi(minHrVal) = hour;
                 Lo(minHrVal) = minute;
                 
//                 lcdrow2[0] = BCD2UpperCh(Hi(onVal));
//                 lcdrow2[1] = BCD2LowerCh(Hi(onVal));
//                 lcdrow2[2] =  ":";
//                 lcdrow2[3] = BCD2UpperCh(Lo(onVal));
//                 lcdrow2[4] = BCD2LowerCh(Lo(onVal));
//                 lcdrow2[5] =  " " ;
//                 lcdrow2[6] = BCD2UpperCh(Hi(offVal));
//                 lcdrow2[7] = BCD2LowerCh(Hi(offVal));
//                 lcdrow2[8] =  ":" ;
//                 lcdrow2[9] = BCD2UpperCh(Lo(offVal));
//                 lcdrow2[10] = BCD2LowerCh(Lo(offVal));
//                 lcdrow2[11] =  " " ;

                 if (minHrVal >= onVal   && minHrVal < offVal )
                 {
//                      lcdrow2[12] =  "O" ;
//                      lcdrow2[13] =  "N" ;
//                       lcdrow2[14] = '\0' ;
                     MOTOR = 1;
                     mStatus = 1;
                     onIndex = index;
                 }else
                 {
//                      lcdrow2[12] =  "O" ;
//                      lcdrow2[13] =  "F" ;
//                       lcdrow2[14] =  "F" ;
//                       lcdrow2[15] = '\0' ;
                      MOTOR = 0;
                      mStatus = 0;
                      onIndex = 0;
                 }
//                 loadRamToDisp();

                 
                 
             }
            }
       }

     }
}