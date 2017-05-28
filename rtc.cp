#line 1 "F:/PROGAMS/hussian/SolarTimer/rtc.c"
#line 27 "F:/PROGAMS/hussian/SolarTimer/rtc.c"
extern unsigned short second;
extern unsigned short minute;
extern unsigned short hour;
extern unsigned short day;
extern unsigned short dday;
extern unsigned short month;
extern unsigned short year;


extern unsigned short set_count;
extern short set;

void InitRTC(){
 I2C1_Init(100000);
}

unsigned short read_ds1307(unsigned short address)
{
 unsigned short r_data;
 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(address);
 I2C1_Repeated_Start();
 I2C1_Wr(0xD1);
 r_data=I2C1_Rd(0);
 I2C1_Stop();
 return(r_data);
}

void write_ds1307(unsigned short address,unsigned short w_data)
{
 I2C1_Start();

 I2C1_Wr(0xD0);
 I2C1_Wr(address);
 I2C1_Wr(w_data);
 I2C1_Stop();
}
void reIntRtc(){
 write_ds1307(0x07,0x10);
 write_ds1307(0x00,0X00);
}
void loadTimeAndDate(){

 I2C1_Start();
 I2C1_Wr(0xD0);
 I2C1_Wr(0);
 I2C1_Repeated_Start();
 I2C1_Wr(0xD1);
 second =I2C1_Rd(1);



 if (second.B7){


 reIntRtc();
 second = 0;
 }
 minute =I2C1_Rd(1);
 hour =I2C1_Rd(1);
 dday =I2C1_Rd(1);
 day =I2C1_Rd(1);
 month =I2C1_Rd(1);
 year =I2C1_Rd(0);
 I2C1_Stop();
#line 109 "F:/PROGAMS/hussian/SolarTimer/rtc.c"
}
