#line 1 "E:/PROGAMS/hussian/SolarTimer/adc.c"

extern int voltage,current;
void adcInit()
{
 ADCON1 = 0x80;
 TRISA = 0xFF;
}
void readVoltage(){
 voltage = ADC_Read(0);
}
void readCurrent()
{
 current = ADC_Read(1);
}
