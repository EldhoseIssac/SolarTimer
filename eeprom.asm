
_ee_write:

;eeprom.c,8 :: 		void ee_write(unsigned short addr,unsigned int value)
;eeprom.c,10 :: 		EEprom_write(addr,Hi(value));
	MOVF       FARG_ee_write_addr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_ee_write_value+1, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;eeprom.c,11 :: 		EEprom_write(addr+1,lo(value));
	INCF       FARG_ee_write_addr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_ee_write_value+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;eeprom.c,12 :: 		}
L_end_ee_write:
	RETURN
; end of _ee_write

_ee_read:

;eeprom.c,13 :: 		unsigned ee_read(unsigned short addr)
;eeprom.c,15 :: 		unsigned int retVal = EEprom_read(addr);
	MOVF       FARG_ee_read_addr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ee_read_retVal_L0+0
	CLRF       ee_read_retVal_L0+1
;eeprom.c,16 :: 		retVal=retVal<<8;
	MOVF       ee_read_retVal_L0+0, 0
	MOVWF      ee_read_retVal_L0+1
	CLRF       ee_read_retVal_L0+0
;eeprom.c,17 :: 		retVal=retVal+ EEprom_read(addr+1);
	INCF       FARG_ee_read_addr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       ee_read_retVal_L0+0, 0
	ADDWF      R0+0, 1
	MOVF       ee_read_retVal_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ee_read_retVal_L0+0
	MOVF       R0+1, 0
	MOVWF      ee_read_retVal_L0+1
;eeprom.c,18 :: 		return retVal;
;eeprom.c,19 :: 		}
L_end_ee_read:
	RETURN
; end of _ee_read
