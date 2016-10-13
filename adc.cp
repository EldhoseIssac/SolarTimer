#line 1 "D:/SolarTimer/adc.c"
#line 12 "D:/SolarTimer/adc.c"
extern unsigned lastReadVoltage,lastReadCurrent;
void adcInit()
{
 ADCON1 = 0x80;
 TRISA = 0xFF;
}
void readVoltage(){
 lastReadVoltage = ADC_Read(0);
}
void readCurrent()
{
 lastReadCurrent = ADC_Read(1);
}
