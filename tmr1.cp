#line 1 "F:/PROGAMS/hussian/SolarTimer/tmr1.c"
#line 4 "F:/PROGAMS/hussian/SolarTimer/tmr1.c"
void initTmr1(){

 T1CON=0x30;
 INTCON.GIE=1;
 INTCON.PEIE=1;
 T1CON.TMR1ON=0;
 TMR1H=0;
 TMR1L=0;
 PIR1.TMR1IF=0;
 PIE1.TMR1IE=1;
 T1CON.TMR1ON=1;

}
