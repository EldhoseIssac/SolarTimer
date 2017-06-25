#line 1 "F:/PROGAMS/hussian/SolarTimer/Menu.c"
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
#line 1 "c:/program files (x86)/mikroc pro for pic/include/built_in.h"
#line 38 "F:/PROGAMS/hussian/SolarTimer/Menu.c"
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

extern unsigned int editValue;
void loadOnOffTime();
void loadEnabledDay();










extern sbit isEnabled;
extern sbit shouldON;
extern sbit isEdited;



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
 TRISC.F1 = 0;


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
 case VoltageEnable:
 ee_write(EEPADDR_VoltageHigh,editValue);
 break;
 }
 break;
 case Current:
 switch(subMenu){
 case CurrentHeigh:
 case CurrentEnable:
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
 case LDRValEnable:
 ee_write(EEPADDR_LDRValHeigh,editValue);
 break;
 }
 break;
 default:
 if ((crntMenu - OnOFFTimeDay1) % 2 == 0 ) {
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
unsigned short tmp=0;







sbit cMENU at cashedPortD.B7;
sbit cSELECT at cashedPortD.B6;
sbit cPLUS at cashedPortD.B5;
sbit cMINUS at cashedPortD.B4;
void loadOnOffTime();
void loadEnabledDay();



void OnOFFTimeDayDisplay(){
 if (cMENU ==  1 )
 {

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
 if ((crntMenu - OnOFFTimeDay1) % 2 == 1 )
 {
 subMenu = OnOFFTimeOnHr;
 editValue = ee_read(timeEEAddr+1);
 tmp =  ((char *)&editValue)[1] ;
 }

 }
 else
 {
 if ((crntMenu - OnOFFTimeDay1) % 2 == 0 ) {

 if (cSELECT ==  1 )
 {
 subMenu +=2;
 tmp++;
 if (subMenu>OnOFFTimeDaySat) {
 subMenu = OnOFFTimeDaySun;
 tmp = 0;
 }
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 editValue = editValue ^ (1<<tmp);
 loadEnabledDay();
 }

 }
 else
 {
 if(cPLUS ==  1 )
 {
 tmp++;
 if((tmp & 0x0F )>9) tmp += 6;
 }
 if (cMINUS ==  1 )
 {
 tmp--;
 if((tmp & 0x0F )>9) tmp -= 6;
 }
 switch (subMenu) {

 case OnOFFTimeOnHr:
 if(cSELECT ==  1  )
 {
 subMenu = OnOFFTimeOnMin;
 tmp =  ((char *)&editValue)[1] ;
 }

 if (cPLUS ==  1  )
 {
 if (tmp > 0x23) {
 tmp = 0;
 }
  ((char *)&editValue)[0]  = tmp;

 }
 if (cMINUS ==  1 )
 {
 if (!tmp) {
 tmp = 0x23;
 }
  ((char *)&editValue)[0]  = tmp;
 }
 break;
 case OnOFFTimeOnMin:
 if(cSELECT ==  1  )
 {
 subMenu = OnOFFTimeOffHr;
 editValue = ee_read(timeEEAddr+3);
 tmp =  ((char *)&editValue)[0] ;
 }
 if (cPLUS ==  1  )
 {

 if (tmp > 0x59)
 {
 tmp = 0;
 }
  ((char *)&editValue)[1]  = tmp;

 }
 if (cMINUS ==  1 )
 {
 if (!tmp)
 {
 tmp = 0x59;
 }
  ((char *)&editValue)[1]  = tmp;
 }
 break;
 case OnOFFTimeOffHr:
 if(cSELECT ==  1  )
 {
 subMenu = OnOFFTimeOffMin;
 tmp =  ((char *)&editValue)[1] ;
 }
 if (cPLUS ==  1  )
 {
 if (tmp > 0x23) {
 tmp = 0;
 }
  ((char *)&editValue)[0]  = tmp;

 }
 if (cMINUS ==  1 )
 {
 if (!tmp) {
 tmp = 0x23;
 }
  ((char *)&editValue)[0]  = tmp;
 }
 break;
 case OnOFFTimeOffMin:
 if(cSELECT ==  1  )
 {
 subMenu = OnOFFTimeOnHr;
 editValue = ee_read(timeEEAddr+1);
 tmp =  ((char *)&editValue)[0] ;

 }
 if (cPLUS ==  1  )
 {

 if (tmp > 0x59)
 {
 tmp = 0;
 }
  ((char *)&editValue)[1]  = tmp;

 }
 if (cMINUS ==  1 )
 {
 if (!tmp)
 {
 tmp = 0x59;
 }
  ((char *)&editValue)[1]  = tmp;
 }

 break;
 }
 if(cPLUS ==  1  || cMINUS ==  1 )
 {
 loadOnOffTime();
 }
 }


 }

}

void checkKey(){


 timeEEAddr =30 ;
do{
 cMENU =  PORTD.F7 ;
 cSELECT =  PORTD.F6 ;
 cPLUS =  PORTD.F5 ;
 cMINUS =  PORTD.F4 ;

 if(cashedPortD > 0)
#line 399 "F:/PROGAMS/hussian/SolarTimer/Menu.c"
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
 if(crntMenu > OnOFFTime8)
 {
 waitCount = 500;
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
 if(editValue == 0x0) editValue = 0x31;
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
 loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
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
 if (editValue > 441) editValue = 81;

 }
 if (cMINUS ==  1 )
 {
 editValue -= 2;
 if (editValue < 81) editValue = 441;
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
 editValue += 1;
 if (editValue > 220) editValue = 80;

 }
 if (cMINUS ==  1 )
 {
 editValue -= 1;
 if (editValue < 80) editValue = 220;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
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
 switch(subMenu)
 {
 case CurrentEnable:
 if(cSELECT ==  1  )
 {
 subMenu = CurrentHeigh;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 isEnabled = !isEnabled;
 loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);

 }
 break;
 case CurrentHeigh:
 if(cSELECT ==  1  )
 {
 subMenu = CurrentLow;
 editValue = ee_read(EEPADDR_CurrentLow);
 }
 if (cPLUS ==  1 )
 {
 editValue += 2;
 if (editValue > 201) editValue = 11;

 }
 if (cMINUS ==  1 )
 {
 editValue -= 2;
 if (editValue < 11) editValue = 201;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
 }
 break;
 case CurrentLow:
 if(cSELECT ==  1  )
 {
 subMenu = CurrentEnable;
 editValue = ee_read(EEPADDR_CurrentHeigh);
 }
 if (cPLUS ==  1 )
 {
 editValue += 1;
 if (editValue > 220) editValue = 80;

 }
 if (cMINUS ==  1 )
 {
 editValue -= 1;
 if (editValue < 80) editValue = 220;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
 }
 break;

 }
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
 switch(subMenu)
 {
 case LDRValEnable:
 if(cSELECT ==  1  )
 {
 subMenu = LDRValHeigh;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 isEnabled = !isEnabled;
 loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
 }
 break;
 case LDRValHeigh:
 if(cSELECT ==  1  )
 {
 subMenu = LDRValLow;
 editValue = ee_read(EEPADDR_LDRValLow);
 }
 if (cPLUS ==  1 )
 {
 editValue += 2;
 if (editValue > 441) editValue = 81;

 }
 if (cMINUS ==  1 )
 {
 editValue -= 2;
 if (editValue < 81) editValue = 441;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
 }
 break;
 case LDRValLow:
 if(cSELECT ==  1  )
 {
 subMenu = LDRValEnable;
 editValue = ee_read(EEPADDR_LDRValHeigh);
 }
 if (cPLUS ==  1 )
 {
 editValue += 1;
 if (editValue > 220) editValue = 80;

 }
 if (cMINUS ==  1 )
 {
 editValue -= 1;
 if (editValue < 80) editValue = 220;
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
 {
 loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
 }
 break;

 }
 }
 break;
 case OnOFFTimeDay1:
 timeEEAddr=EEPADDR_OnOFFTimeDay1;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime1:
 timeEEAddr=EEPADDR_OnOFFTimeDay1;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTimeDay2:
 timeEEAddr=EEPADDR_OnOFFTimeDay2;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime2:
 timeEEAddr=EEPADDR_OnOFFTimeDay2;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTimeDay3:
 timeEEAddr=EEPADDR_OnOFFTimeDay3;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime3:
 timeEEAddr=EEPADDR_OnOFFTimeDay3;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTimeDay4:
 timeEEAddr=EEPADDR_OnOFFTimeDay4;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime4:
 timeEEAddr=EEPADDR_OnOFFTimeDay4;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTimeDay5:
 timeEEAddr=EEPADDR_OnOFFTimeDay5;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime5:
 timeEEAddr=EEPADDR_OnOFFTimeDay5;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTimeDay6:
 timeEEAddr=EEPADDR_OnOFFTimeDay6;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime6:
 timeEEAddr=EEPADDR_OnOFFTimeDay6;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTimeDay7:
 timeEEAddr=EEPADDR_OnOFFTimeDay7;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime7:
 timeEEAddr=EEPADDR_OnOFFTimeDay7;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTimeDay8:
 timeEEAddr=EEPADDR_OnOFFTimeDay8;
 OnOFFTimeDayDisplay();
 break;
 case OnOFFTime8:
 timeEEAddr=EEPADDR_OnOFFTimeDay8;
 OnOFFTimeDayDisplay();
 break;

 default:
 waitCount = 500;
 break;
 }
 if(cashedPortD > 0){
 setCursorPosition(subMenu);
 }
 if (cPLUS ==  1  || cMINUS ==  1 )
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
