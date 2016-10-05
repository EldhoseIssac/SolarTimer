//ADC

#if DEBUG

short  ADCON1;
short  TRISA;

int ADC_Read(int chanel){
    return 1;
}
#endif
extern int voltage,current;
void adcInit()
{
  ADCON1 = 0x80;  //  80//
  TRISA  = 0xFF;
}
void readVoltage(){
    voltage = ADC_Read(0);
}
void readCurrent()
{
    current = ADC_Read(1);
}
