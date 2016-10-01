
_menuPortPinInt:

;Menu.c,7 :: 		void menuPortPinInt(){
;Menu.c,8 :: 		TRISD.F7 = 1;
	BSF        TRISD+0, 7
;Menu.c,9 :: 		TRISD.F6 = 1;
	BSF        TRISD+0, 6
;Menu.c,10 :: 		TRISD.F5 = 1;
	BSF        TRISD+0, 5
;Menu.c,11 :: 		TRISD.F4 = 1;
	BSF        TRISD+0, 4
;Menu.c,12 :: 		}
L_end_menuPortPinInt:
	RETURN
; end of _menuPortPinInt

_checkKey:

;Menu.c,14 :: 		void checkKey(){
;Menu.c,15 :: 		}
L_end_checkKey:
	RETURN
; end of _checkKey
