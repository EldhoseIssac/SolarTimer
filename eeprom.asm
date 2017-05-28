
_ee_write:

	MOVF       FARG_ee_write_addr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_ee_write_value+1, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	INCF       FARG_ee_write_addr+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       FARG_ee_write_value+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
L_end_ee_write:
	RETURN
; end of _ee_write

_ee_read:

	MOVF       FARG_ee_read_addr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ee_read_retVal_L0+1
	INCF       FARG_ee_read_addr+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ee_read_retVal_L0+0
	MOVF       ee_read_retVal_L0+0, 0
	MOVWF      R0+0
	MOVF       ee_read_retVal_L0+1, 0
	MOVWF      R0+1
L_end_ee_read:
	RETURN
; end of _ee_read
