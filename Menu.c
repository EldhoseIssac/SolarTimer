#define UP PORTD.F7
#define DOWN PORTD.F6
#define PLUS PORTD.F5
#define MINUS PORTD.F5
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