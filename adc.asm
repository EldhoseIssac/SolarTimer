
_adcInit:

	MOVLW      128
	MOVWF      ADCON1+0
	MOVLW      255
	MOVWF      TRISA+0
L_end_adcInit:
	RETURN
; end of _adcInit

_readVoltage:

	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _lastReadVoltage+0
	MOVF       R0+1, 0
	MOVWF      _lastReadVoltage+1
L_end_readVoltage:
	RETURN
; end of _readVoltage

_readCurrent:

	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _lastReadCurrent+0
	MOVF       R0+1, 0
	MOVWF      _lastReadCurrent+1
L_end_readCurrent:
	RETURN
; end of _readCurrent
