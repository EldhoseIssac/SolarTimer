#line 1 "D:/SolarTimer/lcd.c"
#line 1 "d:/solartimer/enums.h"


enum menus {
 None,
 Date,
 Time,
 Voltage,
 Current,
 LDRVal,

 OnOFFTimeDay,
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
#line 2 "D:/SolarTimer/lcd.c"
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

extern unsigned int editValue;



extern unsigned lastReadVoltage,lastReadCurrent;
char * codetxt_to_ramtxt(const char* ctxt);
#line 1 "c:/program files (x86)/mikroc pro for pic/include/built_in.h"
#line 74 "D:/SolarTimer/lcd.c"
extern sbit isEnabled;
extern sbit shouldON;

extern sbit shouldAlamSunday;
extern sbit shouldAlamMonday;
extern sbit shouldAlamTuesday;
extern sbit shouldAlamWednesday;
extern sbit shouldAlamThursday;
extern sbit shouldAlamFriday;
extern sbit shouldAlamSaturday;


void initLCDRaws()
{
 strcpy(lcdrow1,codetxt_to_ramtxt("00:00:00 000 TUE"));
 strcpy(lcdrow2,codetxt_to_ramtxt("00/00/00 00.0A  "));

}
void initLCD(){
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 initLCDRaws();
}
unsigned char BCD2HignerCh(unsigned int bcd)
{

 return (( ((char *)&bcd)[1]  & 0x0F)+ '0');
}
unsigned char BCD2UpperCh(unsigned char bcd)
{
 return ((swap(bcd) & 0x0F) + '0');
}

unsigned char BCD2LowerCh(unsigned char bcd)
{
 return ((bcd & 0x0F) + '0');
}

unsigned int Binary2BCD(int a)
{
 unsigned short t1, t2;
 int t3;
 t1 = a%10;
 t1 = t1 & 0x0F;
 a = a/10;
 t2 = a%10;
 t2 = t2 & 0x0F;
 t2 = t2 << 4;
 t2 = 0xF0 & t2;
 a = a/10;
 t3 = a%10;
 t3 = t3 & 0x0F;
 t3 = t3 << 8;
 t3 += t1 | t2;
 return t3;
}

int BCD2Binary(int a)
{
 int r,t;
 t = a & 0x0F;
 r = t;
 a = 0xF0 & a;
 t = a >> 4;
 t = 0x0F & t;
 r = t*10 + r;
 return r;
}
void loadDay(char *arr,unsigned short theIndx){
 switch(theIndx){
 case 0: arr[0]='-';arr[1]='-'; arr[2]='-';break;
 case 1: arr[0]='S';arr[1]='u'; arr[2]='n';break;
 case 2: arr[0]='M';arr[1]='o'; arr[2]='n';break;
 case 3: arr[0]='T';arr[1]='u'; arr[2]='e';break;
 case 4: arr[0]='W';arr[1]='e'; arr[2]='d';break;
 case 5: arr[0]='T';arr[1]='h'; arr[2]='u';break;
 case 6: arr[0]='F';arr[1]='r'; arr[2]='i';break;
 case 7: arr[0]='S';arr[1]='a'; arr[2]='t';break;
 }
}
void displayTimeDate(){

 lcdrow1[0] = BCD2UpperCh(hour);
 lcdrow1[1] = BCD2LowerCh(hour);
 lcdrow1[3] = BCD2UpperCh(minute);
 lcdrow1[4] = BCD2LowerCh(minute);
 lcdrow1[6] = BCD2UpperCh(second);
 lcdrow1[7] = BCD2LowerCh(second);

 lcdrow2[0] = BCD2UpperCh(day);
 lcdrow2[1] = BCD2LowerCh(day);
 lcdrow2[3] = BCD2UpperCh(month);
 lcdrow2[4] = BCD2LowerCh(month);
 lcdrow2[6] = BCD2UpperCh(year);
 lcdrow2[7] = BCD2LowerCh(year);
 loadDay(&lcdrow1[13],dday);

}

void loadTimeEdit(){
 Lcd_Out(1,1,codetxt_to_ramtxt("Set Time"));
 lcdrow2[0] = BCD2UpperCh(hour);
 lcdrow2[1] = BCD2LowerCh(hour);
 lcdrow2[2] = ':';
 lcdrow2[3] = BCD2UpperCh(minute);
 lcdrow2[4] = BCD2LowerCh(minute);
 lcdrow2[5] = '\0';
 Lcd_Out(2,1,lcdrow2);
}
void loadDateEdit(){
 Lcd_Out(1,1,codetxt_to_ramtxt("Set Date"));
 lcdrow2[0] = BCD2UpperCh(day);
 lcdrow2[1] = BCD2LowerCh(day);
 lcdrow2[2] = '/';
 lcdrow2[3] = BCD2UpperCh(month);
 lcdrow2[4] = BCD2LowerCh(month);
 lcdrow2[5] = '/';
 lcdrow2[6] = BCD2UpperCh(year);
 lcdrow2[7] = BCD2LowerCh(year);
 loadDay(&lcdrow2[9],dday);
 lcdrow2[12] = '\0';
 Lcd_Out(2,1,lcdrow2);
}
void setCursorPosition(unsigned short position){
 unsigned short indx;
 if ((crntMenu > LDRVal) && (crntMenu - OnOFFTimeDay) % 2 == 0 ) {
 Lcd_Cmd(_LCD_FIRST_ROW);
 }
 else{
 Lcd_Cmd(_LCD_SECOND_ROW);
 }

 for (indx=0; indx<position; indx++) {
 Lcd_Cmd(_LCD_MOVE_CURSOR_RIGHT);
 }
}
void loadEnabledDay()
{
 unsigned short tmp = editValue;
 unsigned short indx = 2;
 unsigned short i = 0;

 lcdrow1[0]= ((crntMenu - OnOFFTimeDay)>> 1) + '0' + 1;
 lcdrow1[1] = ')';
 for (i = 0 ; i < 8; i++)
 {
 if ((tmp & 1) != 0)
 {
 loadDay(&lcdrow1[indx],i+1);
 }else
 {
 loadDay(&lcdrow1[indx],0);
 }
 tmp = tmp >> 1;
 indx += 2;
 }
 lcdrow1[16] = '\0';
 Lcd_Out(1, 1, lcdrow1);
}

void loadOnOffTime()
{
 unsigned short mi =  ((char *)&editValue)[1] ;
 unsigned short hr =  ((char *)&editValue)[0] ;
 unsigned int tmp;
 if (subMenu == OnOFFTimeOnHr || subMenu == OnOFFTimeOnMin) {
 tmp = OnOFFTimeOnHr-2;
 lcdrow2[0] = 'N';
 }else
 {
 tmp = OnOFFTimeOffHr-2;
 lcdrow2[0] = 'F';
 }
 lcdrow2[1] = '>';
 lcdrow2[2] = BCD2UpperCh(hr);
 lcdrow2[3] = BCD2LowerCh(hr);
 lcdrow2[4] = ':';
 lcdrow2[5] = BCD2UpperCh(mi);
 lcdrow2[6] = BCD2LowerCh(mi);
 lcdrow2[7] = '\0';
 Lcd_Out(2, tmp, lcdrow2);

}

void loadEnHeighLow(unsigned int heigh,unsigned int low,const unsigned short shouldUseDecimal)
{
 unsigned int disVolt;
 unsigned int discrr = Binary2BCD(low);
 unsigned short indx = 0;
 if (heigh>0) {
 lcdrow2[indx++] = 'O';
 lcdrow2[indx++] = 'N';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 heigh = heigh>>1;
 disVolt = Binary2BCD(heigh);
 lcdrow2[indx++] = BCD2HignerCh(disVolt);
 lcdrow2[indx++] = BCD2UpperCh(disVolt);
 if(shouldUseDecimal)
 {
 lcdrow2[indx++] = '.';
 }
 lcdrow2[indx++] = BCD2LowerCh(disVolt);
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = ' ';
 lcdrow2[indx++] = BCD2HignerCh(discrr);
 lcdrow2[indx++] = BCD2UpperCh(discrr);
 if(shouldUseDecimal)
 {
 lcdrow2[indx++] = '.';
 }
 lcdrow2[indx++] = BCD2LowerCh(discrr);
 lcdrow2[indx] = '\0';
 Lcd_Out(2,1, lcdrow2);
 }else{
 Lcd_Out(2,1, codetxt_to_ramtxt("OFF   0.0  0.0"));
 }

}
void displayVoltageCurrent(){
 unsigned int disVolt;
 unsigned int discrr;
 disVolt = Binary2BCD(lastReadVoltage);
 discrr = Binary2BCD(lastReadCurrent);
 lcdrow1[9] = BCD2HignerCh(disVolt);
 lcdrow1[10] = BCD2UpperCh(disVolt);
 lcdrow1[11] = BCD2LowerCh(disVolt);

 lcdrow2[9] = BCD2HignerCh(discrr);
 lcdrow2[10] = BCD2UpperCh(discrr);
 lcdrow2[12] = BCD2LowerCh(discrr);

}
 void loadRamToDisp(){
 Lcd_Out(1, 1, lcdrow1);
 Lcd_Out(2, 1, lcdrow2);
 }
