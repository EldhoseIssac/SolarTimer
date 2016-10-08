//ADC

#if DEBUG

short  ADCON1;
short  TRISA;

int ADC_Read(int chanel){
    return 1;
}
#endif
extern unsigned lastReadVoltage,lastReadCurrent;
void adcInit()
{
  ADCON1 = 0x80;  //  80//
  TRISA  = 0xFF;
}
void readVoltage(){
    lastReadVoltage = ADC_Read(0);
}
void readCurrent()
{
    lastReadCurrent = ADC_Read(1);
}