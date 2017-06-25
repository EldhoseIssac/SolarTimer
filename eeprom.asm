
_ee_write:

;eeprom.c,17 :: 		void ee_write(unsigned short addr,unsigned int value)
;eeprom.c,19 :: 		EEPROM_write(addr,Hi(value));
	MOVF       FARG_ee_write_addr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_ee_write_value+1, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;eeprom.c,20 :: 		EEPROM_write(addr+1,Lo(value));
	INCF       FARG_ee_write_addr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_ee_write_value+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;eeprom.c,21 :: 		}
L_end_ee_write:
	RETURN
; end of _ee_write

_ee_read:

;eeprom.c,22 :: 		unsigned ee_read(unsigned short addr)
;eeprom.c,25 :: 		Hi(retVal) = EEprom_read(addr);
	MOVF       FARG_ee_read_addr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ee_read_retVal_L0+1
;eeprom.c,26 :: 		Lo(retVal) = EEprom_read(addr+1);
	INCF       FARG_ee_read_addr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ee_read_retVal_L0+0
;eeprom.c,27 :: 		return retVal;
	MOVF       ee_read_retVal_L0+0, 0
	MOVWF      R0+0
	MOVF       ee_read_retVal_L0+1, 0
	MOVWF      R0+1
;eeprom.c,28 :: 		}
L_end_ee_read:
	RETURN
; end of _ee_read
