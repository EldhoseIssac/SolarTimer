#if DEBUG

void EEPROM_write(unsigned short addr,unsigned short value){
    
}

unsigned short EEprom_read(unsigned short addr){
    return addr;
}
#define Lo(param) ((char *)&param)[0]
#define Hi(param) ((char *)&param)[1]

#else
#include <built_in.h>
#endif

 void ee_write(unsigned short addr,unsigned int value)
 {
    EEPROM_write(addr,Hi(value));
    EEPROM_write(addr+1,Lo(value));
 }
 unsigned ee_read(unsigned short addr)
 {
     unsigned int retVal;
     Hi(retVal) = EEprom_read(addr);
     Lo(retVal) = EEprom_read(addr+1);
    return retVal;
 }
 
