void initTmr1(){
  T1CON=0x30;
  INTCON.GIE=1;
  INTCON.PEIE=1;
  T1CON.TMR1ON=0;
  TMR1H=0;
  TMR1L=0;                 //delay=(60*t)/(0.524288)  ;t in minute
  PIR1.TMR1IF=0;
  PIE1.TMR1IE=1;
  T1CON.TMR1ON=1;
}
