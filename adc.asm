
_adcInit:

;adc.c,13 :: 		void adcInit()
;adc.c,15 :: 		ADCON1 = 0x80;  //  80//
	MOVLW      128
	MOVWF      ADCON1+0
;adc.c,16 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;adc.c,17 :: 		}
L_end_adcInit:
	RETURN
; end of _adcInit

_readVoltage:

;adc.c,18 :: 		void readVoltage(){
;adc.c,19 :: 		lastReadVoltage = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _lastReadVoltage+0
	MOVF       R0+1, 0
	MOVWF      _lastReadVoltage+1
;adc.c,20 :: 		}
L_end_readVoltage:
	RETURN
; end of _readVoltage

_readCurrent:

;adc.c,21 :: 		void readCurrent()
;adc.c,23 :: 		lastReadCurrent = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _lastReadCurrent+0
	MOVF       R0+1, 0
	MOVWF      _lastReadCurrent+1
;adc.c,24 :: 		}
L_end_readCurrent:
	RETURN
; end of _readCurrent
