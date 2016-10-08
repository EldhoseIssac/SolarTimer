
_voltHeigh:

;eeprom.c,7 :: 		int voltHeigh(){
;eeprom.c,8 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;eeprom.c,9 :: 		}
L_end_voltHeigh:
	RETURN
; end of _voltHeigh

_voltLow:

;eeprom.c,10 :: 		int voltLow(){
;eeprom.c,11 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;eeprom.c,12 :: 		}
L_end_voltLow:
	RETURN
; end of _voltLow

_currHeigh:

;eeprom.c,13 :: 		int currHeigh(){
;eeprom.c,14 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;eeprom.c,15 :: 		}
L_end_currHeigh:
	RETURN
; end of _currHeigh

_currLow:

;eeprom.c,16 :: 		int currLow(){
;eeprom.c,17 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;eeprom.c,18 :: 		}
L_end_currLow:
	RETURN
; end of _currLow

_LDRHeigh:

;eeprom.c,19 :: 		int LDRHeigh(){
;eeprom.c,20 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;eeprom.c,21 :: 		}
L_end_LDRHeigh:
	RETURN
; end of _LDRHeigh

_LDRLow:

;eeprom.c,22 :: 		int LDRLow(){
;eeprom.c,23 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;eeprom.c,24 :: 		}
L_end_LDRLow:
	RETURN
; end of _LDRLow

_onOffTimeAt:

;eeprom.c,25 :: 		int onOffTimeAt(short inx){
;eeprom.c,26 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;eeprom.c,27 :: 		}
L_end_onOffTimeAt:
	RETURN
; end of _onOffTimeAt

_saveVoltHeigh:

;eeprom.c,28 :: 		void saveVoltHeigh(int val){
;eeprom.c,30 :: 		}
L_end_saveVoltHeigh:
	RETURN
; end of _saveVoltHeigh

_saveVoltLow:

;eeprom.c,31 :: 		void saveVoltLow(int val){
;eeprom.c,33 :: 		}
L_end_saveVoltLow:
	RETURN
; end of _saveVoltLow

_saveCurrHeigh:

;eeprom.c,34 :: 		void saveCurrHeigh(int val){
;eeprom.c,36 :: 		}
L_end_saveCurrHeigh:
	RETURN
; end of _saveCurrHeigh

_saveCurrLow:

;eeprom.c,37 :: 		void saveCurrLow(int val){
;eeprom.c,39 :: 		}
L_end_saveCurrLow:
	RETURN
; end of _saveCurrLow

_saveLDRHeigh:

;eeprom.c,40 :: 		void saveLDRHeigh(int val){
;eeprom.c,42 :: 		}
L_end_saveLDRHeigh:
	RETURN
; end of _saveLDRHeigh

_saveLDRLow:

;eeprom.c,43 :: 		void saveLDRLow(int val){
;eeprom.c,45 :: 		}
L_end_saveLDRLow:
	RETURN
; end of _saveLDRLow

_saveOnOffTimeAt:

;eeprom.c,46 :: 		void saveOnOffTimeAt(short inx,int val){
;eeprom.c,48 :: 		}
L_end_saveOnOffTimeAt:
	RETURN
; end of _saveOnOffTimeAt
