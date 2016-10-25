#line 1 "E:/PROGAMS/hussian/SolarTimer/eeprom.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 17 "E:/PROGAMS/hussian/SolarTimer/eeprom.c"
 void ee_write(unsigned short addr,unsigned int value)
 {
 EEPROM_write(addr, ((char *)&value)[1] );
 EEPROM_write(addr+1, ((char *)&value)[0] );
 }
 unsigned ee_read(unsigned short addr)
 {
 unsigned int retVal;
  ((char *)&retVal)[1]  = EEprom_read(addr);
  ((char *)&retVal)[0]  = EEprom_read(addr+1);
 return retVal;
 }
