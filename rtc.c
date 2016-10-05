#if DEBUG



void I2C1_Init(long freq){
    
}
void I2C1_Start(){
    
}
void I2C1_Wr(short arg) {
    
}
void I2C1_Repeated_Start(){
    
}
unsigned short I2C1_Rd(short adr){
    return 1;
    
}
void I2C1_Stop(){
    
}
short secondB7;
#endif

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
  I2C1_Init(100000); //DS1307 I2C is running at 100KHz
}

unsigned short read_ds1307(unsigned short address)
{
  unsigned short r_data;
  I2C1_Start();
  I2C1_Wr(0xD0); //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
  I2C1_Wr(address);
  I2C1_Repeated_Start();
  I2C1_Wr(0xD1); //0x68 followed by 1 --> 0xD1
  r_data=I2C1_Rd(0);
  I2C1_Stop();
  return(r_data);
}

void write_ds1307(unsigned short address,unsigned short w_data)
{
  I2C1_Start(); // issue I2C start signal
  //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
  I2C1_Wr(0xD0); // send byte via I2C (device address + W)
  I2C1_Wr(address); // send byte (address of DS1307 location)
  I2C1_Wr(w_data); // send data (data to be written)
  I2C1_Stop(); // issue I2C stop signal
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
#ifdef DEBUG
    if (secondB7){
#else
    if (second.B7){
#endif
  
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





//    second = read_ds1307(0);
//    if (second.B7){
//           reIntRtc();
//           second = 0;
//    }
//    minute = read_ds1307(1);
//    hour = read_ds1307(2);
//    dday = read_ds1307(3);
//    day = read_ds1307(4);
//    month = read_ds1307(5);
//    year = read_ds1307(6);
}
