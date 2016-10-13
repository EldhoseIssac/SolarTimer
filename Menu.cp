#line 1 "E:/PROGAMS/hussian/SolarTimer/Menu.c"
#line 1 "e:/progams/hussian/solartimer/enums.h"


enum menus {
 None,
 Date,
 Time,
 Voltage,
 Current,
 LDRVal,

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
 VoltageHigh = 7,
 VoltageLow = 13,

 CurrentEnable = 0,
 CurrentHeigh = 8,
 CurrentLow = 13,

 LDRValEnable = 0,
 LDRValHeigh = 8,
 LDRValLow = 13,


 OnOFFTimeEditEnable = 0,
 OnOFFTimeEditOnOff = 4,
 OnOFFTimeEditWeekDay = 6,
 OnOFFTimeEditHour = 11,
 OnOFFTimeEditMint = 14

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
#line 33 "E:/PROGAMS/hussian/SolarTimer/Menu.c"
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
void loadEnDayHrMin();









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
 TRISC.F0 = 0;


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
 switch(submenu){
 case VoltageLow:
 ee_write(EEPADDR_VoltageLow,editValue);
 break;
 case VoltageHigh:
 ee_write(EEPADDR_VoltageHigh,editValue);
 break;
 }
 break;
 case Current:
 switch(submenu){
 case CurrentHeigh:
 ee_write(EEPADDR_CurrentHeigh,editValue);
 break;
 case CurrentLow:
 ee_write(EEPADDR_CurrentLow,editValue);
 break;
 }
 break;
 case LDRVal:
 switch(submenu){
 case LDRValLow:
 ee_write(EEPADDR_LDRvalLow,editValue);
 break;
 case LDRValHeigh:
 ee_write(EEPADDR_LDRvalHeigh,editValue);
 break;
 }
 break;
 default:
 if(crntMenu<(OnOFFTime+8))
 {
 ee_write(timeEEAddr,editValue);
 }
 break;

 }
 }
unsigned short cashedPortD = 0;







sbit cMENU at cashedPortD.B7;
sbit cSELECT at cashedPortD.B6;
sbit cPLUS at cashedPortD.B5;
sbit cMINUS at cashedPortD.B4;
void loadEnDayHrMin();





void checkKey(){

 unsigned int timeEditTemp = 0;
 timeEEAddr = EEPADDR_OnOFFTimeEdit1-2;
do{
 cMENU =  PORTD.F7 ;
 cSELECT =  PORTD.F6 ;
 cPLUS =  PORTD.F5 ;
 cMINUS =  PORTD.F4 ;



 if(cashedPortD < 0xF0)


 {
 waitCount = 0;
 delay_ms(100);
 }
 if(cMENU ==  0 ){
 Lcd_Cmd(_LCD_CLEAR);
 if(crntMenu == None){
 Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
 }else{
 saveValue();
 }
 crntMenu ++;
 if(crntMenu>(OnOFFTime+8))
 {
 waitCount = 500;
 }
 }
 if(cSELECT ==  0 )
 {
 saveValue();
 }
 switch(crntMenu)
 {
 case None:
 break;
 case Date:
 if (cMENU ==  0 )
 {
 subMenu = DateDay;
 loadDateEdit();
 editValue = day;
 }
 else
 {
 if(cPLUS ==  0 )
 {
 editValue++;
 if((editValue & 0x0F )>9) editValue += 6;
 }
 if (cMINUS ==  0 )
 {
 editValue--;
 if((editValue & 0x0F )>9) editValue -= 6;
 }
 switch(subMenu)
 {

 case DateDay:
 if(cSELECT ==  0 )
 {
 subMenu = DateMonth;
 editValue = month;
 }
 if(cPLUS ==  0 ){
 if(editValue>0x31) editValue = 1;
 }
 if(cMINUS ==  0 )
 {
 if(editValue == 0) editValue = 0x31;
 }
 break;
 case DateMonth:
 if(cSELECT ==  0 )
 {
 subMenu = DateYear;
 editValue = year;
 }
 if(cPLUS ==  0 )
 {
 if(editValue>0x12) editValue = 1;
 }
 if(cMINUS ==  0 )
 {
 if(editValue == 0) editValue = 0x01;
 }

 break;
 case DateYear:
 if(cSELECT ==  0 )
 {
 subMenu = DateWeekDay;
 editValue = dday;
 }
 if(cPLUS ==  0 )
 {
 if(editValue>0x99) editValue = 1;
 }
 if(cMINUS ==  0 )
 {
 if(editValue == 0) editValue = 0x99;
 }

 break;
 case DateWeekDay:
 if(cSELECT ==  0 )
 {
 subMenu = DateDay;
 editValue = day;
 }
 if(cPLUS ==  0 )
 {
 if(editValue>0x07) editValue = 1;
 }
 if(cMINUS ==  0 )
 {
 if(editValue == 0) editValue = 0x07;
 }
 break;

 }
 if(cPLUS ==  0  || cMINUS ==  0 )
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
 if (cMENU ==  0 )
 {
 subMenu = TimeHour;
 loadTimeEdit();
 editValue = hour;
 }
 else
 {
 if(cPLUS ==  0 )
 {
 editValue++;
 if((editValue & 0x0F )>9) editValue += 6;
 }
 if (cMINUS ==  0 )
 {
 editValue--;
 if((editValue & 0x0F )>9) editValue -= 6;
 }
 switch(subMenu)
 {
 case TimeHour:
 if(cSELECT ==  0 )
 {
 subMenu = TimeMinute;
 editValue = minute;
 }
 if(cPLUS ==  0 )
 {
 if(editValue>0x23) editValue = 0;
 }
 if(cMINUS ==  0 )
 {
 if(editValue > 0x23) editValue = 0x23;
 }
 break;
 case TimeMinute:
 if(cSELECT ==  0 )
 {
 subMenu = TimeHour;
 editValue = hour;
 }
 if(cPLUS ==  0 )
 {
 if(editValue>0x59) editValue = 0;
 }
 if(cMINUS ==  0 )
 {
 if(editValue > 0x59) editValue = 0x59;
 }
 break;
 }
 if(cPLUS ==  0  || cMINUS ==  0 )
 {
 Lcd_Chr(2,subMenu+1,BCD2UpperCh(editValue));
 Lcd_Chr_CP(BCD2LowerCh(editValue));
 }
 }
 break;
 case Voltage:
 if(cMENU ==  0 )
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
 if(cSELECT ==  0  )
 {
 subMenu = VoltageHigh;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 isEnabled = !isEnabled;
 loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
 }
 break;
 case VoltageHigh:
 if(cSELECT ==  0  )
 {
 subMenu = VoltageLow;
 editValue = ee_read(EEPADDR_VoltageLow);
 }
 if (cPLUS ==  0 )
 {
 editValue += 2;
 if (editValue > 441) editValue = 81;

 }
 if (cMINUS ==  0 )
 {
 editValue -= 2;
 if (editValue < 81) editValue = 441;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 loadEnHeighLow(editValue,ee_read(EEPADDR_VoltageLow),0);
 }
 break;
 case VoltageLow:
 if(cSELECT ==  0  )
 {
 subMenu = VoltageEnable;
 editValue = ee_read(EEPADDR_VoltageHigh);
 }
 if (cPLUS ==  0 )
 {
 editValue += 1;
 if (editValue > 220) editValue = 80;

 }
 if (cMINUS ==  0 )
 {
 editValue -= 1;
 if (editValue < 80) editValue = 220;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 loadEnHeighLow(ee_read(EEPADDR_VoltageHigh),editValue,0);
 }
 break;

 }
 }
 break;
 case Current:
 if(cMENU ==  0 )
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
 if(cSELECT ==  0  )
 {
 subMenu = CurrentHeigh;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 isEnabled = !isEnabled;
 loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);

 }
 break;
 case CurrentHeigh:
 if(cSELECT ==  0  )
 {
 subMenu = CurrentLow;
 editValue = ee_read(EEPADDR_CurrentLow);
 }
 if (cPLUS ==  0 )
 {
 editValue += 2;
 if (editValue > 201) editValue = 11;

 }
 if (cMINUS ==  0 )
 {
 editValue -= 2;
 if (editValue < 11) editValue = 201;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 loadEnHeighLow(editValue,ee_read(EEPADDR_CurrentLow),1);
 }
 break;
 case CurrentLow:
 if(cSELECT ==  0  )
 {
 subMenu = CurrentEnable;
 editValue = ee_read(EEPADDR_CurrentHeigh);
 }
 if (cPLUS ==  0 )
 {
 editValue += 1;
 if (editValue > 220) editValue = 80;

 }
 if (cMINUS ==  0 )
 {
 editValue -= 1;
 if (editValue < 80) editValue = 220;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 loadEnHeighLow(ee_read(EEPADDR_CurrentHeigh),editValue,1);
 }
 break;

 }
 }
 break;
 case LDRVal:
 if(cMENU ==  0 )
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
 if(cSELECT ==  0  )
 {
 subMenu = LDRValHeigh;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 isEnabled = !isEnabled;
 loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
 }
 break;
 case LDRValHeigh:
 if(cSELECT ==  0  )
 {
 subMenu = LDRValLow;
 editValue = ee_read(EEPADDR_LDRValLow);
 }
 if (cPLUS ==  0 )
 {
 editValue += 2;
 if (editValue > 441) editValue = 81;

 }
 if (cMINUS ==  0 )
 {
 editValue -= 2;
 if (editValue < 81) editValue = 441;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 loadEnHeighLow(editValue,ee_read(EEPADDR_LDRValLow),0);
 }
 break;
 case LDRValLow:
 if(cSELECT ==  0  )
 {
 subMenu = LDRValEnable;
 editValue = ee_read(EEPADDR_LDRValHeigh);
 }
 if (cPLUS ==  0 )
 {
 editValue += 1;
 if (editValue > 220) editValue = 80;

 }
 if (cMINUS ==  0 )
 {
 editValue -= 1;
 if (editValue < 80) editValue = 220;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 loadEnHeighLow(ee_read(EEPADDR_LDRValHeigh),editValue,0);
 }
 break;

 }
 }
 break;
 default:
 if(crntMenu<(OnOFFTime+8))
 {
 if (cMENU ==  0 )
 {
 subMenu = OnOFFTimeEditEnable;
 timeEEAddr += 2;
 strcpy(lcdrow1,codetxt_to_ramtxt("Time1 Day  Hr:Mn"));
 lcdrow1[4]= crntMenu - OnOFFTime + '0' + 1;
 Lcd_Out(1,1,lcdrow1);
 editValue = ee_read(timeEEAddr);
 loadEnDayHrMin();
 }
 else
 {
 switch (subMenu) {
 case OnOFFTimeEditEnable:
 if(cSELECT ==  0  )
 {
 if (isEnabled)
 {
 subMenu = OnOFFTimeEditOnOff;
 }

 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 isEnabled = !isEnabled;
 loadEnDayHrMin();
 }
 break;
 case OnOFFTimeEditOnOff:
 if(cSELECT ==  0  )
 {
 subMenu = OnOFFTimeEditWeekDay;
 }
 if (cPLUS ==  0  || cMINUS ==  0 )
 {
 shouldON = !shouldON;
 loadEnDayHrMin();
 }
 break;
 case OnOFFTimeEditWeekDay:
 if(cSELECT ==  0  )
 {
 subMenu = OnOFFTimeEditHour;
 }

 timeEditTemp = editValue;
 if (cPLUS ==  0 )
 {
 timeEditTemp += 4;
 }
 if (cMINUS ==  0 )
 {
 timeEditTemp -= 4;
 }
 if (cPLUS ==  0  || cMINUS ==  0 ) {
 editValue = (editValue & 0xFFE3) | (timeEditTemp & 0x001C);
 loadEnDayHrMin();
 }
 break;
 case OnOFFTimeEditHour:
 if(cSELECT ==  0  )
 {
 subMenu = OnOFFTimeEditMint;
 }
 timeEditTemp = editValue & 0x03E0;
 if (cPLUS ==  0 )
 {
 timeEditTemp += 32;
 if (timeEditTemp > 736)
 {
 timeEditTemp = 0;
 }
 }
 if (cMINUS ==  0 )
 {
 if(timeEditTemp == 0)
 {
 timeEditTemp = 736;
 }
 else
 {
 timeEditTemp -= 32;
 }

 }
 if (cPLUS ==  0  || cMINUS ==  0 ) {
 editValue = (editValue & 0xFC1F) | timeEditTemp;
 loadEnDayHrMin();
 }

 break;
 case OnOFFTimeEditMint:
 if(cSELECT ==  0  )
 {
 subMenu = OnOFFTimeEditEnable;
 }
 timeEditTemp = editValue & 0xFC00;
 if (cPLUS ==  0 )
 {
 timeEditTemp += 1024;
 if (timeEditTemp > 60416)
 {
 timeEditTemp = 0;
 }
 }
 if (cMINUS ==  0 )
 {
 if(timeEditTemp == 0)
 {
 timeEditTemp = 60416;
 }
 else
 {
 timeEditTemp -= 1024;
 }

 }
 if (cPLUS ==  0  || cMINUS ==  0 ) {
 editValue = (editValue & 0x03FF) | timeEditTemp;
 loadEnDayHrMin();
 }

 break;
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
 if (cPLUS ==  0  || cMINUS ==  0 )
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
