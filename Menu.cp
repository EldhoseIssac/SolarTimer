#line 1 "E:/PROGAMS/hussian/SolarTimer/Menu.c"
#line 1 "e:/progams/hussian/solartimer/enums.h"


enum menus {
 None,
 Date,
 Time,
 Voltage,
 Current,
 LDRVal,
 OnOFFTimerCnt,
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
 VoltageHigh = 8,
 VoltageLow = 13,

 CurrentEnable = 0,
 CurrentHeigh = 8,
 CurrentLow = 13,

 LDRValEnable = 0,
 LDRValHeigh = 8,
 LDRValLow = 13,

 OnOFFTimerCntEdit,
 OnOFFTimeEdit

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
#line 22 "E:/PROGAMS/hussian/SolarTimer/Menu.c"
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

unsigned int editValue;
sbit isEnabled at editValue.B0;

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


 TRISD.F7 = 1;
 TRISD.F6 = 1;
 TRISD.F5 = 1;
 TRISD.F4 = 1;


}
 unsigned waitCount ;
 unsigned char BCD2UpperCh(unsigned char bcd);
 unsigned char BCD2LowerCh(unsigned char bcd);
 void loadDay(unsigned char *arr,unsigned short theIndx);
 void saveValue(){
 switch(crntMenu){
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
 }
 }
unsigned short cashedPortD = 0;
sbit cMENU at cashedPortD.B7;
sbit cSELECT at cashedPortD.B6;
sbit cPLUS at cashedPortD.B5;
sbit cMINUS at cashedPortD.B4;

void checkKey(){



do{
 cMENU =  PORTD.F7 ;
 cSELECT =  PORTD.F6 ;
 cPLUS =  PORTD.F5 ;
 cMINUS =  PORTD.F4 ;
 if(cashedPortD > 0)
 {
 waitCount = 0;
 delay_ms(100);
 }
 if(cMENU ==  1 ){
 Lcd_Cmd(_LCD_CLEAR);
 if(crntMenu == None){
 Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
 }else{
 saveValue();
 }
 crntMenu ++;
 if(crntMenu>OnOFFTime)
 {
 waitCount = 100;
 }
 }
 if(cSELECT ==  1 )
 {
 saveValue();
 }
 switch(crntMenu)
 {
 case None:
 break;
 case Date:
 if (cMENU ==  1 )
 {
 subMenu = DateDay;
 loadDateEdit();
 editValue = day;
 }
 else
 {
 if(cPLUS ==  1 )
 {
 editValue++;
 if((editValue & 0x0F )>9) editValue += 6;
 }
 if (cMINUS ==  1 )
 {
 editValue--;
 if((editValue & 0x0F )>9) editValue -= 6;
 }
 switch(subMenu)
 {

 case DateDay:
 if(cSELECT ==  1 )
 {
 subMenu = DateMonth;
 editValue = month;
 }
 if(cPLUS ==  1 ){
 if(editValue>0x31) editValue = 1;
 }
 if(cMINUS ==  1 )
 {
 if(editValue == 0) editValue = 0x31;
 }
 break;
 case DateMonth:
 if(cSELECT ==  1 )
 {
 subMenu = DateYear;
 editValue = year;
 }
 if(cPLUS ==  1 )
 {
 if(editValue>0x12) editValue = 1;
 }
 if(cMINUS ==  1 )
 {
 if(editValue == 0) editValue = 0x01;
 }

 break;
 case DateYear:
 if(cSELECT ==  1 )
 {
 subMenu = DateWeekDay;
 editValue = dday;
 }
 if(cPLUS ==  1 )
 {
 if(editValue>0x99) editValue = 1;
 }
 if(cMINUS ==  1 )
 {
 if(editValue == 0) editValue = 0x99;
 }

 break;
 case DateWeekDay:
 if(cSELECT ==  1 )
 {
 subMenu = DateDay;
 editValue = day;
 }
 if(cPLUS ==  1 )
 {
 if(editValue>0x07) editValue = 1;
 }
 if(cMINUS ==  1 )
 {
 if(editValue == 0) editValue = 0x07;
 }
 break;

 }
 if(cPLUS ==  1  || cMINUS ==  1 )
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
 if (cMENU ==  1 )
 {
 subMenu = TimeHour;
 loadTimeEdit();
 editValue = hour;
 }
 else
 {
 if(cPLUS ==  1 )
 {
 editValue++;
 if((editValue & 0x0F )>9) editValue += 6;
 }
 if (cMINUS ==  1 )
 {
 editValue--;
 if((editValue & 0x0F )>9) editValue -= 6;
 }
 switch(subMenu)
 {
 case TimeHour:
 if(cSELECT ==  1 )
 {
 subMenu = TimeMinute;
 editValue = minute;
 }
 if(cPLUS ==  1 )
 {
 if(editValue>0x23) editValue = 0;
 }
 if(cMINUS ==  1 )
 {
 if(editValue > 0x23) editValue = 0x23;
 }
 break;
 case TimeMinute:
 if(cSELECT ==  1 )
 {
 subMenu = TimeHour;
 editValue = hour;
 }
 if(cPLUS ==  1 )
 {
 if(editValue>0x59) editValue = 0;
 }
 if(cMINUS ==  1 )
 {
 if(editValue > 0x59) editValue = 0x59;
 }
 break;
 }
 if(cPLUS ==  1  || cMINUS ==  1 )
 {
 Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
 Lcd_Chr_CP(BCD2LowerCh(editValue));
 }
 }
 break;
 case Voltage:
 if(cMENU ==  1 )
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
 if(cSELECT ==  1  )
 {
 subMenu = VoltageHigh;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 isEnabled = !isEnabled;
 if (isEnabled)
 {
 loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
 }
 }
 break;
 case VoltageHigh:
 if(cSELECT ==  1  )
 {
 subMenu = VoltageLow;
 editValue = ee_read(EEPADDR_VoltageLow);
 }
 if (cPLUS ==  1 )
 {
 editValue += 2;
 if (editValue > 221) editValue = 81;

 }
 if (cMINUS ==  1 )
 {
 editValue += 2;
 if (editValue < 81) editValue = 221;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
 }
 break;
 case VoltageLow:
 if(cSELECT ==  1  )
 {
 subMenu = VoltageEnable;
 editValue = ee_read(EEPADDR_VoltageHigh);
 }
 if (cPLUS ==  1 )
 {
 editValue += 2;
 if (editValue > 221) editValue = 81;

 }
 if (cMINUS ==  1 )
 {
 editValue += 2;
 if (editValue < 81) editValue = 221;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 loadEnHeighLow(ee_read(EEPADDR_VoltageLow),editValue,0);
 }
 break;

 }
 }
 break;
 case Current:
 if(cMENU ==  1 )
 {
 subMenu = CurrentEnable;
 Lcd_Out(1,1, codetxt_to_ramtxt("Amp  Heigh  Low"));
 editValue = ee_read(EEPADDR_CurrentHeigh);
 loadEnHeighLow(editValue, ee_read(EEPADDR_CurrentLow),1);
 }
 else
 {
 }
 break;
 case LDRVal:
 if(cMENU ==  1 )
 {
 subMenu = LDRValEnable;
 editValue = ee_read(EEPADDR_LDRValHeigh);
 Lcd_Out(1,1, codetxt_to_ramtxt("LDR  Heigh  Low"));
 loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
 }
 else
 {
 }
 break;
 default:
 waitCount = 100;
 break;
 }
 if(cashedPortD > 0){
 setCursorPosition(subMenu);
 }

 delay_ms(100);
 waitCount++;
 if(waitCount>20){
 crntMenu = None;
 subMenu = NoEdit;
 initLCDRaws();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 }


 }while(crntMenu != None);
 saveValue();

}
