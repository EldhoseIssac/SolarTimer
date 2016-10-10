#if DEBUG


#else
#include <built_in.h>
#endif

 void ee_write(unsigned short addr,unsigned int value)
 {
    EEprom_write(addr,Hi(value));
    EEprom_write(addr+1,lo(value));
 }
 unsigned ee_read(unsigned short addr)
 {
    unsigned int retVal = EEprom_read(addr);
    retVal=retVal<<8;
    retVal=retVal+ EEprom_read(addr+1);
    return retVal;
 }
 