#line 1 "D:/SolarTimer/eeprom.c"
#line 1 "c:/program files (x86)/mikroc pro for pic/include/built_in.h"
#line 21 "D:/SolarTimer/eeprom.c"
 void ee_write(unsigned short addr,unsigned int value)
 {
 EEprom_write(addr, ((char *)&value)[1] );
 EEprom_write(addr+1, ((char *)&value)[0] );
 }
 unsigned ee_read(unsigned short addr)
 {
 unsigned int retVal = EEprom_read(addr);
 retVal=retVal<<8;
 retVal=retVal+ EEprom_read(addr+1);
 return retVal;
 }
