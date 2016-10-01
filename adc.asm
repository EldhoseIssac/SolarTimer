
_adcInit:

;adc.c,3 :: 		void adcInit()
;adc.c,5 :: 		ADCON1 = 0x80;  //  80//
	MOVLW      128
	MOVWF      ADCON1+0
;adc.c,6 :: 		TRISA  = 0xFF;
	MOVLW      255
	MOVWF      TRISA+0
;adc.c,7 :: 		}
L_end_adcInit:
	RETURN
; end of _adcInit

_readVoltage:

;adc.c,8 :: 		void readVoltage(){
;adc.c,9 :: 		voltage = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _voltage+0
	MOVF       R0+1, 0
	MOVWF      _voltage+1
;adc.c,10 :: 		}
L_end_readVoltage:
	RETURN
; end of _readVoltage

_readCurrent:

;adc.c,11 :: 		void readCurrent()
;adc.c,13 :: 		current = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _current+0
	MOVF       R0+1, 0
	MOVWF      _current+1
;adc.c,14 :: 		}
L_end_readCurrent:
	RETURN
; end of _readCurrent
