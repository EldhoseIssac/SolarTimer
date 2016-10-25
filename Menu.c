#include "Enums.h"
#if DEBUG
#include <string.h>
short MENU;
short SELECT;
short PLUS;
short MINUS;
extern short _LCD_CLEAR;
extern short _LCD_UNDERLINE_ON;
extern short _LCD_CURSOR_OFF;
void Lcd_Cmd(short command);
void delay_ms(unsigned int del){
    
}

void Lcd_Out(int row,int col,char  *sting);
short Lo(unsigned int val);
void Lcd_Chr(int row,int col,char  chr);
void Lcd_Chr_CP(char  chr);
unsigned short EEPROM_Read(unsigned short addr){
    return addr;
}
void EEPROM_write(unsigned short addr,unsigned int value);
#define Lo(param) ((char *)&param)[0]
#define Hi(param) ((char *)&param)[1]
#else
#define MENU PORTD.F7
#define SELECT PORTD.F6
#define PLUS PORTD.F5
#define MINUS PORTD.F4
#include <built_in.h>

#endif


#define ON  1
#define OFF 0
extern char lcdrow1[];
extern char lcdrow2[];

extern unsigned short crntMenu;
extern unsigned short subMenu;
extern unsigned short second;
extern unsigned short minute;
extern unsigned short hour;
extern unsigned short day;
extern unsigned short dday;
extern unsigned short month;
extern unsigned short year;
extern short _LCD_BLINK_CURSOR_ON;
//unsigned char  editStr[10];
extern unsigned int editValue;
void loadOnOffTime();
void loadEnabledDay();
#if DEBUG
short isEnabled;
short lowDay;
short MidleDay;
short HeighDay;

short shouldON;
short isEdited;

#else
extern sbit isEnabled;
extern sbit shouldON;
extern sbit isEdited;
#endif


void loadDateEdit();
void loadTimeEdit();
void setCursorPosition(unsigned short position);


void ee_write(unsigned short addr,unsigned int value);
unsigned ee_read(unsigned short addr);


void loadEnHeighLow(unsigned int heigh,unsigned int low,const unsigned short shouldUseDecimal);
void initLCDRaws();
void write_ds1307(unsigned short address,unsigned short w_data);
char * codetxt_to_ramtxt(const char* ctxt)
{
static char txt[20];
char i;
  for(i =0; ctxt[i] != '\0'; i++){
     txt[i] = ctxt[i];
  }
  txt[i] = '\0';
  return txt;
}



void menuPortPinInt(){
    
#if !DEBUG
    TRISD.F7 = 1;
    TRISD.F6 = 1;
    TRISD.F5 = 1;
    TRISD.F4 = 1;
    TRISC.F0 = 0;
#endif
    
}
unsigned short timeEEAddr;
 unsigned waitCount ;
 unsigned char BCD2UpperCh(unsigned char bcd);
 unsigned char BCD2LowerCh(unsigned char bcd);
 void loadDay(char *arr,unsigned short theIndx);
 void saveValue(){
      if (!isEdited){
         return;
      }
      isEdited = 0;
      switch(crntMenu){
                   case None:
                   break;
                   case Date:
                      switch(subMenu){
                            case DateDay:
                                 write_ds1307(0x04,editValue);
                                 break;
                            case DateMonth:
                                 write_ds1307(0x05,editValue);
                                 break;
                            case DateYear:
                                 write_ds1307(0x06,editValue);
                                 break;
                            case DateWeekDay:
                                 write_ds1307(0x03,editValue);
                                 break;
                   }
                   break;
                   case Time:
                      switch(subMenu){
                            case TimeHour:
                                 write_ds1307(0x02,editValue);
                                 break;
                            case TimeMinute:
                                 write_ds1307(0x01,editValue);
                                 break;
                   }
                   break;
                    case Voltage:
                      switch(subMenu){
                            case VoltageLow:
                                 ee_write(EEPADDR_VoltageLow,editValue);
                                 break;
                            case VoltageHigh:
                                 ee_write(EEPADDR_VoltageHigh,editValue);
                                 break;
                      }
                   break;
                   case Current:
                        switch(subMenu){
                              case CurrentHeigh:
                                   ee_write(EEPADDR_CurrentHeigh,editValue);
                                   break;
                              case CurrentLow:
                                   ee_write(EEPADDR_CurrentLow,editValue);
                                   break;
                        }
                   break;
                   case LDRVal:
                        switch(subMenu){
                              case LDRValLow:
                                   ee_write(EEPADDR_LDRValLow,editValue);
                                   break;
                              case LDRValHeigh:
                                   ee_write(EEPADDR_LDRValHeigh,editValue);
                                   break;
                        }
                   break;
                   default:
                      if ((crntMenu - OnOFFTimeDay) % 2 == 0 ) {
                          EEPROM_write(timeEEAddr,editValue);
                      }
                      else
                      {
                          if (subMenu == OnOFFTimeOnHr || subMenu == OnOFFTimeOnMin) {
                              ee_write(timeEEAddr+1,editValue);
                          }
                          else if (subMenu == OnOFFTimeOffHr || subMenu == OnOFFTimeOffMin)
                          {
                              ee_write(timeEEAddr+3,editValue);
                          }
                      }
                      break;
                   
      }
      delay_ms(100);
 }
unsigned short cashedPortD = 0;
#if DEBUG
short cMENU;
short cSELECT;
short cPLUS;
short cMINUS;

#else
sbit cMENU at cashedPortD.B7;
sbit cSELECT at cashedPortD.B6;
sbit cPLUS at cashedPortD.B5;
sbit cMINUS at cashedPortD.B4;
void loadOnOffTime();
void loadEnabledDay();

#endif



void checkKey(){

    unsigned short tmp=0;
    timeEEAddr = EEPADDR_OnOFFTimeDay1-5;
do{
    cMENU = MENU;
    cSELECT = SELECT;
    cPLUS = PLUS;
    cMINUS = MINUS;
    #if ON == 1
       if(cashedPortD > 0)
    #else
       if(cashedPortD < 0xF0)
    #endif

   {
      waitCount = 0;
      delay_ms(100);
   }
   if(cMENU == ON){
        Lcd_Cmd(_LCD_CLEAR);
        if(crntMenu == None){
          Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
        }else{
            saveValue();
        }
        crntMenu ++;
        if(crntMenu > (OnOFFTime + 16))
        {
           waitCount = 500;
        }
   }
   if(cSELECT == ON)
   {
      saveValue();
   }
   switch(crntMenu)
   {
      case None:
           break;
      case Date:
           if (cMENU == ON)
           {
              subMenu = DateDay;
              loadDateEdit();
              editValue = day;
           }
           else
           {
                 if(cPLUS == ON)
                 {
                    editValue++;
                    if((editValue & 0x0F )>9) editValue += 6;
                  }
                  if (cMINUS == ON)
                  {
                    editValue--;
                    if((editValue & 0x0F )>9) editValue -= 6;
                  }
                 switch(subMenu)
                 {

                    case DateDay:
                    if(cSELECT == ON)
                    {
                        subMenu = DateMonth;
                        editValue = month;
                    }
                    if(cPLUS == ON){
                       if(editValue>0x31)  editValue = 1;
                    }
                    if(cMINUS == ON)
                    {
                       if(editValue == 0x0) editValue = 0x31;
                    }
                    break;
                    case DateMonth:
                     if(cSELECT == ON)
                     {
                        subMenu = DateYear;
                        editValue = year;
                    }
                    if(cPLUS == ON)
                    {
                       if(editValue>0x12)  editValue = 1;
                    }
                    if(cMINUS == ON)
                    {
                       if(editValue == 0) editValue = 0x01;
                    }

                    break;
                    case DateYear:
                     if(cSELECT == ON)
                     {
                        subMenu = DateWeekDay;
                        editValue = dday;
                    }
                    if(cPLUS == ON)
                    {
                       if(editValue>0x99)  editValue = 1;
                    }
                    if(cMINUS == ON)
                    {
                       if(editValue == 0) editValue = 0x99;
                    }

                    break;
                    case DateWeekDay:
                     if(cSELECT == ON)
                     {
                        subMenu = DateDay;
                        editValue = day;
                    }
                    if(cPLUS == ON)
                    {
                       if(editValue>0x07)  editValue = 1;
                    }
                    if(cMINUS == ON)
                    {
                       if(editValue == 0) editValue = 0x07;
                    }
                    break;

                 }
                 if(cPLUS == ON || cMINUS == ON)
                 {
                     if (subMenu == DateWeekDay)
                     {
                         loadDay(lcdrow2,editValue);
                         lcdrow2[3] = '\0';
                         Lcd_Out(2,subMenu+1,lcdrow2);
                     }
                     else
                     {
                        Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
                        Lcd_Chr_CP(BCD2LowerCh(editValue));
                     }
                 }

           }
           break;
      case Time:
           if (cMENU == ON)
           {
              subMenu = TimeHour;
              loadTimeEdit();
              editValue = hour;
           }
           else
           {
              if(cPLUS == ON)
               {
                  editValue++;
                  if((editValue & 0x0F )>9) editValue += 6;
                }
                if (cMINUS == ON)
                {
                  editValue--;
                  if((editValue & 0x0F )>9) editValue -= 6;
                }
                switch(subMenu)
                {
                   case TimeHour:
                         if(cSELECT == ON)
                         {
                            subMenu = TimeMinute;
                            editValue = minute;
                        }
                        if(cPLUS == ON)
                        {
                           if(editValue>0x23)  editValue = 0;
                        }
                        if(cMINUS == ON)
                        {
                           if(editValue > 0x23) editValue = 0x23;
                        }
                        break;
                   case TimeMinute:
                        if(cSELECT == ON)
                         {
                            subMenu = TimeHour;
                            editValue = hour;
                        }
                        if(cPLUS == ON)
                        {
                           if(editValue>0x59)  editValue = 0;
                        }
                        if(cMINUS == ON)
                        {
                           if(editValue > 0x59) editValue = 0x59;
                        }
                        break;
                }
                if(cPLUS == ON || cMINUS == ON)
                 {
                      Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
                      Lcd_Chr_CP(BCD2LowerCh(editValue));
                 }
           }
           break;
      case   Voltage:
           if(cMENU == ON)
           {
                subMenu = VoltageEnable;
                Lcd_Out(1,1, codetxt_to_ramtxt("Volt Heigh  Low"));
                editValue = ee_read(EEPADDR_VoltageHigh);
                loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
           }
           else
           {
              switch(subMenu)
                {
                    case VoltageEnable:
                         if(cSELECT == ON )
                         {
                            subMenu = VoltageHigh;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                             isEnabled = !isEnabled;
                              loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
                         }
                    break;
                    case VoltageHigh:
                         if(cSELECT == ON )
                         {
                            subMenu = VoltageLow;
                            editValue =  ee_read(EEPADDR_VoltageLow);
                         }
                         if (cPLUS == ON)
                         {
                             editValue += 2;
                             if (editValue > 441)   editValue = 81;

                         }
                         if (cMINUS == ON)
                         {
                             editValue -= 2;
                             if (editValue < 81) editValue = 441;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                              loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
                         }
                    break;
                    case VoltageLow:
                         if(cSELECT == ON )
                         {
                            subMenu = VoltageEnable;
                            editValue =  ee_read(EEPADDR_VoltageHigh);
                         }
                         if (cPLUS == ON)
                         {
                             editValue += 1;
                             if (editValue > 220)   editValue = 80;

                         }
                         if (cMINUS == ON)
                         {
                             editValue -= 1;
                             if (editValue < 80) editValue = 220;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                              loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
                         }
                    break;
                    
                }
           }
           break;
      case Current:
            if(cMENU == ON)
           {
               subMenu = CurrentEnable;
               Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
               editValue = ee_read(EEPADDR_CurrentHeigh);
               loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
           }
           else
           {
                switch(subMenu)
                {
                    case CurrentEnable:
                         if(cSELECT == ON )
                         {
                            subMenu = CurrentHeigh;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                             isEnabled = !isEnabled;
                             loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
                             
                                                      }
                    break;
                    case CurrentHeigh:
                         if(cSELECT == ON )
                         {
                            subMenu = CurrentLow;
                            editValue =  ee_read(EEPADDR_CurrentLow);
                         }
                         if (cPLUS == ON)
                         {
                             editValue += 2;
                             if (editValue > 201)   editValue = 11;

                         }
                         if (cMINUS == ON)
                         {
                             editValue -= 2;
                             if (editValue < 11) editValue = 201;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                              loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
                         }
                    break;
                    case CurrentLow:
                         if(cSELECT == ON )
                         {
                            subMenu = CurrentEnable;
                            editValue =  ee_read(EEPADDR_CurrentHeigh);
                         }
                         if (cPLUS == ON)
                         {
                             editValue += 1;
                             if (editValue > 220)   editValue = 80;

                         }
                         if (cMINUS == ON)
                         {
                             editValue -= 1;
                             if (editValue < 80) editValue = 220;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                              loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
                         }
                    break;

                }
           }
          break;
     case LDRVal:
           if(cMENU == ON)
           {
                subMenu = LDRValEnable;
                editValue = ee_read(EEPADDR_LDRValHeigh);
                Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
                loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
           }
           else
           {
               switch(subMenu)
                {
                    case LDRValEnable:
                         if(cSELECT == ON )
                         {
                            subMenu = LDRValHeigh;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                             isEnabled = !isEnabled;
                              loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
                         }
                    break;
                    case LDRValHeigh:
                         if(cSELECT == ON )
                         {
                            subMenu = LDRValLow;
                            editValue =  ee_read(EEPADDR_LDRValLow);
                         }
                         if (cPLUS == ON)
                         {
                             editValue += 2;
                             if (editValue > 441)   editValue = 81;

                         }
                         if (cMINUS == ON)
                         {
                             editValue -= 2;
                             if (editValue < 81) editValue = 441;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                              loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
                         }
                    break;
                    case LDRValLow:
                         if(cSELECT == ON )
                         {
                            subMenu = LDRValEnable;
                            editValue =  ee_read(EEPADDR_LDRValHeigh);
                         }
                         if (cPLUS == ON)
                         {
                             editValue += 1;
                             if (editValue > 220)   editValue = 80;

                         }
                         if (cMINUS == ON)
                         {
                             editValue -= 1;
                             if (editValue < 80) editValue = 220;
                         }
                         if (cPLUS == ON || cMINUS == ON)
                         {
                              loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
                         }
                    break;

                }
           }
           break;
     default:
          if(crntMenu<(OnOFFTimeDay + 16))
          {
             if (cMENU == ON)
             {
                
                if ((crntMenu - OnOFFTimeDay) % 2 == 0 )
                {
                   timeEEAddr += 5;
                }
                subMenu = OnOFFTimeOnHr;
                editValue = ee_read(timeEEAddr+1);
                loadOnOffTime();
                subMenu = OnOFFTimeOffHr;
                editValue = ee_read(timeEEAddr+3);
                loadOnOffTime();
                subMenu = OnOFFTimeDaySun;
                editValue = EEPROM_Read(timeEEAddr);
                loadEnabledDay();
                 tmp = 0;
                 if ((crntMenu - OnOFFTimeDay) % 2 == 1 ) 
                 {
                     subMenu = OnOFFTimeOnHr;
                     editValue = ee_read(timeEEAddr+1);
                     tmp = Hi(editValue);
                 }
                 
             }
             else
             {
                 if ((crntMenu - OnOFFTimeDay) % 2 == 0 ) {
                    
                     if (cSELECT == ON)
                     {
                         subMenu +=2;
                         tmp++;
                         if (subMenu>OnOFFTimeDaySat) {
                             subMenu = OnOFFTimeDaySun;
                             tmp = 0;
                         }
                     }
                     if (cPLUS == ON || cMINUS == ON)
                     {
                         editValue = editValue ^ (1<<tmp);
                         loadEnabledDay();
                     }

                 }
                 else
                 {
                     if(cPLUS == ON)
                     {
                         tmp++;
                         if((tmp & 0x0F )>9) tmp += 6;
                     }
                     if (cMINUS == ON)
                     {
                         tmp--;
                         if((tmp & 0x0F )>9) tmp -= 6;
                     }
                     switch (subMenu) {
                             
                         case OnOFFTimeOnHr:
                             if(cSELECT == ON )
                             {
                                 subMenu = OnOFFTimeOnMin;
                                 tmp = Hi(editValue);
                             }

                             if (cPLUS == ON )
                             {
                                 if (tmp > 0x23) {
                                     tmp = 0;
                                 }
                                 Lo(editValue) = tmp;
                                 
                             }
                             if (cMINUS == ON)
                             {
                                 if (!tmp) {
                                     tmp = 0x23;
                                 }
                                 Lo(editValue) = tmp;
                             }
                             break;
                         case OnOFFTimeOnMin:
                             if(cSELECT == ON )
                             {
                                 subMenu = OnOFFTimeOffHr;
                                 editValue = ee_read(timeEEAddr+3);
                                 tmp = Lo(editValue);
                             }
                             if (cPLUS == ON )
                             {
                                 
                                 if (tmp > 0x59)
                                 {
                                     tmp = 0;
                                 }
                                 Hi(editValue) = tmp;
                                 
                             }
                             if (cMINUS == ON)
                             {
                                 if (!tmp)
                                 {
                                     tmp = 0x59;
                                 }
                                 Hi(editValue) = tmp;
                             }
                             break;
                         case OnOFFTimeOffHr:
                             if(cSELECT == ON )
                             {
                                 subMenu = OnOFFTimeOffMin;
                                 tmp = Hi(editValue);
                             }
                             if (cPLUS == ON )
                             {
                                 if (tmp > 0x23) {
                                     tmp = 0;
                                 }
                                 Lo(editValue) = tmp;
                                 
                             }
                             if (cMINUS == ON)
                             {
                                 if (!tmp) {
                                     tmp = 0x23;
                                 }
                                 Lo(editValue) = tmp;
                             }
                             break;
                         case OnOFFTimeOffMin:
                             if(cSELECT == ON )
                             {
                                 subMenu = OnOFFTimeOnHr;
                                 editValue = ee_read(timeEEAddr+1);
                                 tmp =  Lo(editValue);

                             }
                             if (cPLUS == ON )
                             {
                                 
                                 if (tmp > 0x59)
                                 {
                                     tmp = 0;
                                 }
                                 Hi(editValue) = tmp;
                                 
                             }
                             if (cMINUS == ON)
                             {
                                 if (!tmp)
                                 {
                                     tmp = 0x59;
                                 }
                                 Hi(editValue) = tmp;
                             }
                             
                             break;
                     }
                     if(cPLUS == ON || cMINUS == ON)
                     {
                         loadOnOffTime();
                     }
                 }
                 
                
             }
                 
              
             
          }
          else
          {
            waitCount = 500;
          }

          break;
   }
   if(cashedPortD > 0){
     setCursorPosition(subMenu);
   }
   if (cPLUS == ON || cMINUS == ON) 
   {
     isEdited = 1;
   }

     delay_ms(100);
     waitCount++;
     if(waitCount>200){
          crntMenu = None;
          subMenu = NoEdit;
          initLCDRaws();
          Lcd_Cmd(_LCD_CURSOR_OFF);
     }
     

 }while(crntMenu != None);
  saveValue();

}