#line 1 "E:/PROGAMS/hussian/SolarTimer/Menu.c"




enum menus{Date,Time,Voltage,Current,LDR};
short crntMenu = Date;
void menuPortPinInt(){
 TRISD.F7 = 1;
 TRISD.F6 = 1;
 TRISD.F5 = 1;
 TRISD.F4 = 1;
}

void checkKey(){
}
