                             //--10/08/16  -- last Updated Equal 15Time//1171/  1187
      //(1376 >1316 sub dily>270)

//use "BOTTOM   PORTC.F1" as button .. when this pin  is low motr will start and
//will run still. maximum time. (if no other problems. like low current,voltage..etc).
//project and tick
//_WDT_ON
//  3sec Motor starting relay    160if(!subpindelay1292)//151
//ADCON0 REGISTER (ADDRESS: 1Fh) 113page            (vol + -667826 902 148 680)
//starting time brick editing 198 line  9sec edited
//voltage adjest and motor 5sec restart corretion
//amps 14..747 ,, amps flactuation adjust1124
//for voltage range 140 to 240  // HV-986,1168,1186,1203, 1208.1265 1118,746
//Startdelay,7default1168,1186 // 189,188,1080,986mpm 574,859.999,1279,1295
 //3 second dealy,1290                 //1167,949  849 1349 mpm  953.1153/1165
                                 //chek eporom925  //1413volt=volt/130;
#include <built_in.h>
int volt,current,preCurrent,prevolt; //unsigned
//////////////////default values
#define     AmpMin   43     //required value*10    4.4Aneed 44=====
#define     AmpMax   97     //61// 6.6 amp maximum need 66 ======
#define     RunVL    165    //160//
#define     StartVL  190  //188//


//////////////////

signed int i;
#define  MOTOR    PORTD.F3  //
#define  MOTORTr  TRISD.F3  //22 TRISD.F4 pin20,,(for motor run relay)
#define  BOTTOM   PORTC.F1
#define  BOTTOMTr TRISC.F1 //16/TRISC.F1// pin7 ,,(top tank botom )
#define  SUB      PORTD.F1
#define  SUBTr    TRISD.F1//20 TRISC.F2 Pin9 ,,(sub tank )
#define  TOP      PORTC.F0
#define  TOPTr    TRISC.F0 //16..TRISC.F0 pin8,,,,(top tank top )
#define  MENU     PORTC.F2
#define  MENUTr   TRISC.F2 //17/TRISC.F3 menu pin6,,(menu push button switch)
#define  PLUS     PORTD.F0
#define  PLUSTr   TRISD.F0//19TRISC.F4 + pin4 ,,(plus(+) push button switch)
#define  MINUS    PORTC.F3 //....TRISA.F3 un impliment digital.. 10000100
#define  MINUSTr  TRISC.F3 //18 TRISC.F5  - pin15 ,,(minus(-) pushbutton switch)
#define  MOTORst  mstat.f7
#define  BUSSER   PORTC.f4
#define  BUSSERTr TRISC.f4  //23,,(buzzer for signal alaram)
#define  DryRUNIN PORTD.f2
#define  DryRunINTr Trisd.f2 //21 Trisd.f1 pin17  ,,(dry run read switch)
#define  BackLight  PORTC.f6
#define  BackLightTr TrisC.f6//25 TrisC.f6 Ol/pin23
#define  SubPin      PORTC.F5
#define  SubPinTr    TRISC.F5 //24 TRISD.F0 //pin22,,(3sec Motor starting relay)
#define  ALT         PORTE.F2
#define   ALTTR       TRISE.F2//27 ..TRISD.F3// MOTORTr this is extra on(LED)


#define  HIGH         0x01
#define  LOW          0x00

#define  ON          0x01
#define  OFF         0x00

#define  IN          0x01
#define  OUT         0x00

#define   NORMAL        0x00
#define   OverVolt      0x01
#define   OverCurrent   0x02
#define   UnderVolt     0x03
#define   UnderCurrent  0x04
#define   DryOut        0x05
#define   maxTime       0x06
#define   SubTank_UnderWater 0x07

#define   Currentmini      0x00   //0.5 to 50    default  6A
#define   Currentmax       0x02   // 5 to 50   default   12A
#define   Startdelay       0x04   //1sec - 30sec  default  7sec
#define   dryruntime       0x05   //1sec-  120sec default  10sec
#define   Subtank          0x06   //default 0
#define   dryrun1          0x07   //default 0
#define   MaxRunTime       0x08   //5 minits   240  default 45minits
#define   RunVoltLow       0x09   // 140V to 170V   default 160V
#define   StartVoltLow     0x0B   // 170V to 200V   default 190V
#define   ResetTimeDelay   0x0D  // default 10 seconds



#define   isSubtank        mstat.f6
#define   isdryrun         mstat.f5
#define   islastsubtankover        mstat.f4
#define   isminuspress             mstat.f3

//#define   Currentfactor    300L//960L//500L
//#define   VoltFactor       3650L//3500L 195v180vDi// 3800L 190v198vDi.

unsigned int Currentfactor;
unsigned int VoltFactor;

unsigned int dry_out_time,VoltReal,CurrentReal,CurrentHlimit,CurrentLlimit,stcnt,stemp;
unsigned int tempcc,RunVoltL,StartVoltL,C2;
unsigned short j,stat,mstat,VoltHlimit,VoltLlimit,stDelay,DryrunT,MaxT,sec,minute;
unsigned short msec,menulist,MaxTt,resetTime,drytemp,motor_wait_del;
unsigned int cnt;
unsigned char t[8];
long temp;  //unsigned
unsigned int backlighttimedelay,subpindelay;
unsigned int currTemp;

unsigned int Fvolt,Svolt,Fadc,Sadc;
unsigned int Fcurr,Scurr;

void CheckVolt();
void CheckCurrent();
void longdelay();
void loadvalues();
void loaddefault();
void lcddisp(unsigned const char *str);
void lcddisp2(unsigned const char *str);
void meu();
void pls();
void minw();
void disperror();
int dispval(unsigned int teval,unsigned short dot);
void chkKey();
void dispvc();
void dispcnt(unsigned short start,unsigned short leng);
void backlightcheck(int delms);
 void startmotor();
 void offmotor();
 void waitforV();
 void waitforsubfill();
 void busse(unsigned short dell);
 void ee_write(unsigned short addr,unsigned int value);
void getVolt();
void getCurrent();
unsigned short ProcessPoint(unsigned int * point,unsigned short dot);
void calcFactor(unsigned int * factor,unsigned short ee_add);

void dela(int at)
{
 for(;at>0;at=at-10)
 {
    Delay_ms(10);
    asm clrwdt
  }
}

void interrupt()
{
 if(PIR1.TMR1IF)
 {
   PIR1.TMR1IF=0;
   if(backlighttimedelay)
   {backlighttimedelay--;
   if(!backlighttimedelay)
   {
       if(MOTORst==OFF)
       BackLight=OFF;
   }
   }
   if(subpindelay)
   {
    subpindelay--;
    if(!subpindelay)
    {
       SubPin=OFF;
    }
   }
   if(subpindelay==0 && backlighttimedelay==0)
   {
        T1CON.TMR1ON=0;
   }

 }
}
void main()
{
 unsigned short tt;
 OSCCON = 0x71;
    ANSEL =3;
    ANSELH = 0;
   ALTTR=OUT;
   ALT=OFF;
   MOTORTr=OUT;
   MOTOR=OFF;
 MENU=0;
 ADCON1 = 0x84;  //  80//
 TRISA  = 0xFF;
 TRISB  = 0x00;
 TRISD  = 0;
 stat=NORMAL;
 menulist=0;
 Currentfactor=800;//500
 VoltFactor=450;//365 =====
 dela(2000); ////////////========+++++++++

// Lcd_Config(&PORTB, 2, 3, 0, 4, 5, 6, 7);
 Lcd_Config(&PORTB, 4, 5, 6, 3, 2, 1, 0);

 BOTTOMTr=IN;
 SUBTr=IN;
 TOPTr=IN;
 BackLightTr=OUT;
 MENUTr=IN;
 PLUSTr=IN;
 MINUSTr=IN;
 BUSSERTr=OUT;
 DryRunINTr=IN;
 SubPinTr=OUT;

 BUSSER=OFF;
 SubPin=OFF;
 MOTORst=OFF;
 BackLight=OFF;
 T1CON=0x30;
 INTCON.GIE=1;
 INTCON.PEIE=1;

 // wdt configuration

 OPTION_REG=0x0F;

   loadvalues();
 Lcd_Out(1,1,"COOL FILL.  2xx6");   //"..COOL FILL..."
 Lcddisp2("DWL Control"); //(" Controller");
 asm clrwdt
 dela(1200);
 asm clrwdt
 drytemp=DryrunT;
 motor_wait_del=5;
 menulist=0;
 lcddisp2("            ");    //*****************
 Lcd_Cmd(0xC0);
 backlighttimedelay=344;
         BackLight=1;
         subpindelay=0;
       T1CON.TMR1ON=0;
       TMR1H=0;
       TMR1L=0;                 //delay=(60*t)/(0.524288)  ;t in minute
       PIR1.TMR1IF=0;
       PIE1.TMR1IE=1;
       T1CON.TMR1ON=1;

 for(cnt=0;cnt<20;cnt++)//16//brick for editing secondes=====
 {
    Lcd_Chr_CP('.');
     for(stcnt=0;stcnt<200;stcnt++)
     {
      asm clrwdt
      chkKey();
      delay_ms(4);
     }
 }
 mstat=0;


 loadvalues();



 do {
     dispvc();
      backlightcheck(1000);
     if(BOTTOM==1 || MOTORst==ON)     //0/ probe/  low level adjest =========
     {
      CheckVolt();
       loadvalues();
       if(isSubtank==1 && stat==NORMAL)
         {
               if(SUB==1)
                       {


                   for(tt=2;tt>0;tt--) //2//sub tank display time delay.MPM
                      {dispvc();
                      backlightcheck(900);
                      }
                        if(stemp>=2)
                     stemp=stemp-2;
                     else
                     stemp=0;
                               if(SUB==1)
                               {
                                       stat= SubTank_UnderWater;
                  offmotor();
                     waitforsubfill();
                               }
                }

          }

      if(stat==NORMAL)
      {
         if(MOTORst==OFF)
         {startmotor();

        dispvc();

        lcddisp2("Motor ON    ");
                         // starting current block delay
        for(i=stDelay;i>0;i--)
        {

          dispvc();
          backlightcheck(900);
          tempcc=i;
          dispcnt(13,3);

        }



         }
        while(TOP!=0)  //porob/0 maximum level adjest====
        {
        backlightcheck(960);

               dispvc();
               CheckVolt();

               CheckCurrent();

                //if(TOP==1) break; ////if on off enable if(TOP==1 prob///TOPTr TRISC.F1 //16 edit
               if(stemp)
               stemp--;
               if(stemp%8==0)  //Buzzer DElay
               {
               loadvalues();
                 busse(100);
               }
               if(stemp==0)
               {
                       break;
               }
               else
               {
                       tempcc=stemp;
                       dispcnt(11,5);
               }
               if(stat!=NORMAL)
               {
                       break;
               }
               if(isdryrun)
               {
                       if(drytemp==0)
                       {       if(DryRUNIN==1)
                               {
                      lcddisp2("D R wait    ");
                      for(tt=3;tt>0;tt--)
                      {dispvc();
                      backlightcheck(900);
                      }
                        if(stemp>=3)
                     stemp=stemp-3;
                     else
                     stemp=0;

                      if(DryRUNIN==1)
                                       {stat= DryOut;
                   offmotor();
                                       disperror();
                                       }

                                       lcddisp2("Motor Run  ");
                       }
                       }
                       else
                               {drytemp--;
                            tempcc=drytemp;
                            lcddisp2("Dry R:");
                                dispcnt(6,3);
                             Lcd_Out_CP("  ");
                         if(drytemp==0)
                         lcddisp2("Motor Run  ");
                               }
               }
               // if(TOP==1) break;  //Probe /TOPTr    TRISC.F1 //16 edit
               if(isSubtank==1)
               {
                       if(SUB==1)
                       {         // sub tank delay

               for(tt=2;tt>0;tt--)
                      {dispvc();
                      backlightcheck(900);
                      }
                        if(stemp>=2)
                     stemp=stemp-3;
                     else
                     stemp=0;
                               if(SUB==1)
                               {
                                       stat= SubTank_UnderWater;
                 offmotor();
                    waitforsubfill();
                               }
                       }
               }

       }
       if(stat==NORMAL)
       {
               if(stemp==0)
               {
         offmotor();
                       lcddisp2("Maximum Run Time");
                       while(1)
                       {
                               dispvc();
          backlightcheck(1000);
                       }
               }
               else
               {
                lcddisp2("Tank Full");
                if(MaxT<20)
                 tempcc=MaxT*60;
                else
                 tempcc=(MaxT-20)*300+20*60;
                tempcc=tempcc-stemp+5;
           dispcnt(11,5);
         offmotor();
               }
     }
     else
     {
       stat=NORMAL;
       lcddisp2("             ");
       offmotor();
     }

       }
      else
      {
        offmotor();
        disperror();
        longdelay();
      stat=NORMAL;
      }
     }

 } while(1);
}

void disperror()
{

 switch(stat)
 {
 case NORMAL:
            lcddisp2("NORMAL    ");
      break;
 case OverVolt:
      lcddisp2("OVER VOLT       ");
      break;
 case OverCurrent:
      lcddisp2("OVER Amps    ");
      while(1)
      {
      dispvc();
      backlightcheck(2000);
       busse(70);
      }
      break;
 case UnderVolt:
      lcddisp2(" Under VOLT     ");
      break;
 case UnderCurrent:
      lcddisp2(" Under Amps     ");
      while(1)
      {
      dispvc();
      backlightcheck(2000);
       busse(70);
      }
      break;
 case   DryOut:
        lcddisp2("  DRY RUN");
        while(1)
      {
      dispvc();
      backlightcheck(1000);
      }
        break;
 case   SubTank_UnderWater:
        lcddisp2("Low Sub Tank    ");
        break;
  default:
      lcddisp2("Un Err ");
      break;

 }
}
void meu()
{
 unsigned short key;
     //Lcd_Config(&PORTB, 2, 3, 0, 4, 5, 6, 7);
        Lcd_Config(&PORTB, 4, 5, 6, 3, 2, 1, 0);
switch(menulist)
      {
         case 0:
              menulist=1;
              lcddisp("Set mini Amps");
              Lcd_Chr(2,2,' ');

              dispval(CurrentLlimit,1);
              Lcd_Chr_CP('A');
              break;
         case 1:
              menulist=2;
              lcddisp("Set Max Amps");
              Lcd_Chr(2,2,' ');

              dispval(CurrentHlimit,1);
              Lcd_Chr_CP('A');
              break;
           case 2:
              if(isdryrun)
                menulist=3;
              else
                  menulist=4;
              lcddisp("Normal Run Time");

              tempcc=stDelay;
              dispcnt(4,2);
              Lcd_out_CP(" Sec");
              break;
           case 3:
                menulist=4;

              lcddisp("Dry Run Time");
              tempcc=DryrunT;
              dispcnt(4,3);
              Lcd_out_CP(" Sec");
              break;
         case 4:
              menulist=5;

              lcddisp("Sub tank ");
              if(isSubtank)
                 lcddisp2(" Enabled ");
               else
                lcddisp2(" Disabled");
              break;
         case 5:
              menulist=6;

              lcddisp("Dry Run ");
              if(isdryrun)
                 Lcddisp2(" Enabled ");
               else
                Lcddisp2(" Disabled");
              break;
        case 6:
              menulist=7;

              lcddisp("Max Run Time");
              if(MaxT<20)
               tempcc=MaxT;
              else
              tempcc=(MaxT-20)*5+20;
              dispcnt(4,3);
              Lcd_out_CP(" Min");
              break;
        case 7:
              menulist=8;

              lcddisp("Load Default");
               isminuspress=0;
              break;
        case 8:
              menulist=9;

              lcddisp("Set Run Volt    ");
              Lcd_Chr(2,2,' ');

              dispval(RunVoltL,0);
                 Lcd_Chr_CP('V');
                  break;
         case 9:
              menulist=10;

              lcddisp(" Set Start Volt ");
              Lcd_Chr(2,2,' ');

             dispval(StartVoltL,0);
                 Lcd_Chr_CP('V');
              break;
         case 10:
              menulist=0;

              lcddisp("Reset Time Delay");
              tempcc=resetTime*5;
              dispcnt(4,3);
              Lcd_out_CP(" Sec");
              break;

      }
}
void minw()
{

      switch(menulist)
      {
         case 1:
              if(CurrentLlimit>5)  // 20
              {
               CurrentLlimit-=1;
                ee_write(Currentmini,CurrentLlimit);
              }
              Lcd_Chr(2,2,' ');

              dispval(CurrentLlimit,1);
              Lcd_Chr_CP('A');
             break;
         case 2:
              if(CurrentHLimit>CurrentLlimit+3)
             { CurrentHlimit-=1;
               ee_write(Currentmax,CurrentHlimit);

              }
               Lcd_Chr(2,2,' ');
                   dispval(CurrentHlimit,1);
                 Lcd_Chr_CP('A');
                break;
           case 3:
              if(stDelay>1)
              {
               stDelay--;
               EEprom_write(Startdelay,stDelay);
              }
               tempcc=stDelay;
              dispcnt(4,2);
              Lcd_out_CP(" Sec");
               break;
           case 4:
            if(!isdryrun)
              {
               if(stDelay>1)
              {
               stDelay--;
               EEprom_write(Startdelay,stDelay);
              }
              tempcc=stDelay;
              Lcd_Chr(2,3,' ');
              dispcnt(4,2);

              }
              else
              {
              if(DryrunT>2)
              {
               DryrunT--;
               EEprom_write(dryruntime,DryrunT);
              }
              tempcc=DryrunT;
              dispcnt(4,3);
              }
              Lcd_out_CP(" Sec");
              break;
         case 5:
              if(!isSubtank)
              {   lcddisp2(" Enabled ");
                  isSubtank=1;
                  EEprom_write(Subtank,255);
              }
               else
               { lcddisp2(" Disabled");
                 isSubtank=0;
                  EEprom_write(Subtank,0);
               }
               break;
         case 6:
              if(!isdryrun)
              {
                 lcddisp2(" Enabled ");
                 isdryrun=1;
                  EEprom_write(dryrun1,255);
               }
               else
                {
                 isdryrun=0;
                 lcddisp2(" Disabled ");
                 EEprom_write(dryrun1,0);
               }

               break;
        case 7:
             if(MaxT>2)
              { MaxT-=1;
                EEprom_write(MaxRunTime,MaxT);
              }
              if(MaxT<20)
               tempcc=MaxT;
              else
              tempcc=(MaxT-20)*5+20;

              dispcnt(4,3);
              Lcd_out_CP(" Min");
              break;
        case 8:
             if (isminuspress==1)
             {loaddefault();
             lcddisp2(" Loaded.....    ");

             dela(3000);
             isminuspress=0;
             }
             break;
        case 9:                 //============================
              if(RunVoltL>90) //370 to low adjest Volt==minimum
              {                //=============================
               RunVoltL-=1;
               ee_write(RunVoltLow,RunVoltL);

              }
              Lcd_Chr(2,2,' ');
              dispval(RunVoltL,0);
              Lcd_Chr_CP('V');
             break;
         case 10:                 //=============================
                       if(StartVoltL>RunVoltL+5)//500//if(StartVoltL>430)
             {
              StartVoltL-=1;   //===============================
              ee_write(StartVoltLow,StartVoltL);
               }
               Lcd_Chr(2,2,' ');
                  dispval(StartVoltL,0);
                 Lcd_Chr_CP('V');
                break;
         case 0:
              if(resetTime>2)
              {
               resetTime--;
               EEprom_write(ResetTimeDelay,resetTime);
              }
              tempcc=resetTime*5;
              dispcnt(4,3);
              Lcd_out_CP(" Sec");
              break;
      }

}
void pls()
{
 asm clrwdt
switch(menulist)
      {
         case 1:
              if(CurrentLlimit<CurrentHLimit-3) // maximum current limit currentLLimit/100
              {
                    CurrentLlimit+=1;
                    ee_write(Currentmini,CurrentLlimit);
              }
              Lcd_Chr(2,2,' ');

              dispval(CurrentLlimit,1);
              Lcd_Chr_CP('A');
             break;
         case 2:
              if(CurrentHLimit<200) //295,410 // amps maximum reduce to 14amps from20amps
              {
               CurrentHlimit+=1;
               ee_write(Currentmax,CurrentHlimit);

              }
              Lcd_Chr(2,2,' ');

              dispval(CurrentHlimit,1);
              Lcd_Chr_CP('A');
              break;
           case 3:
              if(stDelay<20)
              {
               stDelay++;
                EEprom_write(Startdelay,stDelay);
             }

             tempcc=stDelay;
              dispcnt(4,2);
              Lcd_out_CP(" Sec");
               break;
           case 4:
            if(!isdryrun)
              {
                if(stDelay<20)
              {
               stDelay++;
                EEprom_write(Startdelay,stDelay);
             }
              tempcc=stDelay;
              Lcd_Chr(2,3,' ');
              dispcnt(4,2);

              }
              else
              {
              if(DryrunT<60)            //199
              {
               DryrunT++;
               EEprom_write(dryruntime,DryrunT);
              }
              tempcc=DryrunT;
              dispcnt(4,3);
              }
              Lcd_out_CP(" Sec");
             break;
         case 5:
              if(!isSubtank)
              {   lcddisp2(" Enabled ");
                  isSubtank=1;
                   EEprom_write(Subtank,255);
              }
               else
               { lcddisp2(" Disabled");
                 isSubtank=0;
                 EEprom_write(Subtank,0);
               }


               break;
         case 6:
              if(!isdryrun)
              {
                 lcddisp2(" Enabled ");
                 isdryrun=1;
                 EEprom_write(dryrun1,255);
               }
               else
                {
                 isdryrun=0;
                 lcddisp2(" Disabled");
                  EEprom_write(dryrun1,0);
               }

               break;
        case 7:
             if(MaxT<210) // 225
             {
                        MaxT+=1;
                        EEprom_write(MaxRunTime,MaxT);
              }

              if(MaxT<20)
               tempcc=MaxT;
              else
              tempcc=(MaxT-20)*5+20;
              dispcnt(4,3);
              Lcd_out_CP(" Min");
              break;
        case 8:
             asm clrwdt
             if(isminuspress==0)
             {lcddisp2("Yes(-)     No(+)");
             isminuspress=1;
             }
             else
                 meu();
             break;
         case 9:
              if(RunVoltL<StartVoltL)//if(RunVoltL<260)
              {
                    RunVoltL+=1;
                    ee_write(RunVoltLow,RunVoltL);

              }
              Lcd_Chr(2,2,' ');
             // temp=(long)RunVoltL*VoltFactor;
              dispval(RunVoltL,0);
              Lcd_Chr_CP('V');
             break;
         case 10:
              if(StartVoltL<220)
              {
               StartVoltL+=1;
               ee_write(StartVoltLow,StartVoltL);

              }
              Lcd_Chr(2,2,' ');

              dispval(StartVoltL,0);
              Lcd_Chr_CP('V');
              break;
         case 0:
              if(resetTime<199)
              {
               resetTime++;
               EEprom_write(ResetTimeDelay,resetTime);
              }
              tempcc=resetTime*5;
              dispcnt(4,3);
              Lcd_out_CP(" Sec");
              break;


      }
}

void loadvalues()
{

 CurrentLlimit=EEprom_read(Currentmini);
 CurrentLlimit=CurrentLlimit<<8;
 CurrentLlimit=CurrentLlimit+ EEprom_read(Currentmini+1);

 CurrentHlimit=EEprom_read(Currentmax);
 CurrentHlimit=CurrentHlimit<<8;
 CurrentHlimit+=EEprom_read(Currentmax+1);

 startVoltL=EEprom_read(StartVoltLow);
 startVoltL=StartVoltL<<8;
 startVoltL+=EEprom_read(StartVoltLow+1);

 RunVoltL=EEprom_read(RunVoltLow);
 RunVoltL=RunVoltL<<8;
 RunVoltL+=EEprom_read(RunVoltLow+1);
if (startVoltL>(RunVoltL+150)) {
    startVoltL=RunVoltL+20;
    ee_write(StartVoltLow,StartVoltL);
    }


 resetTime=EEprom_read(ResetTimeDelay);

 stDelay=EEprom_read(Startdelay);
 DryrunT=EEprom_read(dryruntime);
 isSubtank=0;
 if(EEprom_read(Subtank))
  isSubtank=1;
 asm clrwdt
 isdryrun=0;
 if(EEprom_read(dryrun1))
 isdryrun=1;

 MaxT=EEprom_read(MaxRunTime);
 if(CurrentHlimit>1023)
  loaddefault();
 asm clrwdt
 //if(CurrentLlimit>CurrentHlimit+30) //==
// {
//  lcddisp2("IL reloaded");
//  ee_write(Currentmini,AmpMin);
//     CurrentLlimit=AmpMin;
//   backlightcheck(2000);
// }
// if(StartVoltL<(StartVL-50) || StartVoltL >(StartVL+50))//StartVoltL<495+++++++++++
// {
//  lcddisp2("Vs reloaded");
//  EE_write(StartVoltLow,StartVL);//0x22B);  ==
//
//   StartVoltL=StartVL;//0x22B;==
//  backlightcheck(2000);
// }
// if(RunVoltL<(RunVL-50) || (RunVoltL>RunVL+50) ) //+++++++++++
// {
//  lcddisp2("Vr reloaded");
//  ee_write(RunVoltLow,RunVL);//0x1d4);  ==
//
//   RunVoltL=RunVL;//0x1D4;  ==
//   backlightcheck(2000);
// }                    //==
}





 void lcddisp(unsigned const char *str)
 {
  unsigned short i;
  Lcd_Chr(1,1,str[0]);
  for(i=1;str[i]!=0;i++)
  {

    Lcd_Chr_CP(str[i]);
   delay_ms(4);
  }

 }
 void lcddisp2(unsigned const char *str)
 {
  unsigned short i;
  Lcd_Chr(2,1,str[0]);
  for(i=1;str[i]!=0;i++)
  {

    Lcd_Chr_CP(str[i]);
    delay_ms(4);
  }

 }
 void CheckVolt()
{
 unsigned short tt;
 if(stat==NORMAL)
 {

          dispvc();
          if(volt<0)
          {
        Lcd_Cmd(0x01);
        }
       //if(volt<0)

       if(volt>270) //270  //718(715if volt OK) 730 upper limit  740/270MPM
       {
           stat=OverVolt;
           offmotor();
           disperror();
           longdelay();
           lcddisp2("HIGH VOLT");
               do
                               {
                         backlightcheck(900);
                         getVolt();
                         dispvc();

                 }while(volt>265); //==

       }
      if(MOTORst==1)
      {
               if(volt<(RunVoltL))   // lower limit is 140
               {

          for(tt=5;tt>0;tt--) //voltage wait delay change 'tt=5' for changing delay
        {
               backlightcheck(900);
               dispvc();
               tempcc=tt;
              dispcnt(11,5);
       }


       if(stemp>=5)
       stemp=stemp-5;
       else
       stemp=0;

                       getVolt();
     if(volt<(RunVoltL))
                       {
         offmotor();   //=
         waitforV();
                       }
                       else
                       { stat=NORMAL;
                       }
               }
       }
      else if(volt<250)
      {   getVolt();
               if(volt<(StartVoltL))         // lower limit is 190
               {


                for(tt=5;tt>0;tt--) //voltage wait delay change 'tt=5' for changing delay
        {
               backlightcheck(900);
               dispvc();
               tempcc=tt;
              dispcnt(11,5);
       }
        if(stemp>=5)
       stemp=stemp-5;
       else
       stemp=0;

         getVolt();
                       if(volt<(StartVoltL))
                           {
              waitforV();

                           }
                       else
         stat=NORMAL;
               }
      }
   }
}

void CheckCurrent()
{
  unsigned short tt;
    if(stat==NORMAL)
    {
       getCurrent(); //current = Adc_Read(1);
       if(current>(CurrentHlimit))
       {

           for(tt=3;tt>0;tt--)
        {
               backlightcheck(900);
               dispvc();
               tempcc=tt;
              dispcnt(11,5);
        }
        if(stemp>=3)
       stemp=stemp-3;
       else
       stemp=0;

          getCurrent();
           if(current>(CurrentHlimit))
           {stat=OverCurrent;
          offmotor();

            disperror();

           }

       }
       else if(current<(CurrentLlimit))
      {

            for(tt=3;tt>0;tt--)
        {
               backlightcheck(900);
               dispvc();
               tempcc=tt;
              dispcnt(11,5);
        }
        if(stemp>=3)
       stemp=stemp-3;
       else
       stemp=0;
           getCurrent();
            if(current<(CurrentLlimit))
            {
           stat=UnderCurrent;
           offmotor();

           disperror();
          }
      }
    }
}

int dispval(unsigned int teval,unsigned short dot)
{

               int vv;
              t[0]=teval%10;
              teval=teval/10;
              t[1]=teval%10;
              teval=teval/10;
              t[2]=teval%10;
              //teval=teval/10;
              //t[3]=teval%10;

              vv=(t[2])*100+(t[1])*10+(t[0]);
              //Lcd_Chr_CP(t[3]+'0');
              //delay_ms(3);
             Lcd_Chr_CP(t[2]+'0');
               Delay_ms(3);
               Lcd_Chr_CP(t[1]+'0');
               Delay_ms(3);
               if(dot)
               {
               Lcd_Chr_CP('.');
                Delay_ms(3);
                }
                Lcd_Chr_CP(t[0]+'0');
                 Delay_ms(3);
                 return(teval);
}

void loaddefault()
{
 asm clrwdt
 ee_write(Currentmini,AmpMin);
 ee_write(Currentmax,AmpMax);
 EEprom_write(Startdelay,7);  //===5===========
 EEprom_write(dryruntime,10);
 asm clrwdt
 EEprom_write(Subtank,0);
 EEprom_write(dryrun1,0);

 EEprom_write(MaxRunTime,20);
 EEprom_write(RunVoltLow,RunVL);//*1023)/(VoltFactor/10))>>8);
 asm clrwdt
 ee_write(RunVoltLow,RunVL);
 ee_write(StartVoltLow,StartVL);
 EEprom_Write(ResetTimeDelay,12);//2===
 asm clrwdt

 RunVoltL=RunVL;
 StartVoltL=StartVL;
 CurrentLlimit=AmpMin;
 CurrentHlimit=AmpMax;
 stDelay=7;   //====5========
 DryrunT=10;
isSubtank=0;
 isdryrun=0;
 MaxT=20;
 resetTime=12; //2====

}
void chkKey()
{
  unsigned int waittime;

   if(MENU==0)
     {
      meu();
      backlightcheck(100);
       for(waittime=0;waittime<600;waittime++) //==300  if ching speed ingrment
       {
          if(MENU==0)
          {
           meu();
           asm clrwdt
           dela(300);//300
           waittime=0;
           }
           if(PLUS==0)
           {
            pls();
            asm clrwdt
            dela(200);  // 300  increment speed
            waittime=0;
            }
            if(MINUS==0)
            {
             minw();
              asm clrwdt
             dela(100);  //300 decrement speed
             waittime=0;
             }
             dela(10);//delay_ms(10);
       }
            lcddisp2("                ");
             Lcd_Cmd(0xC0);
             cnt=0;

     }
}
void longdelay()
{
   unsigned int cnt;

     resetTime=EEprom_read(ResetTimeDelay);

 Lcd_Out(2,10,"    ");
  for(cnt=resetTime*5;cnt>0;cnt--)
  {            backlightcheck(900);
               dispvc();
               tempcc=cnt;
              dispcnt(13,3);


   }
   Lcd_Out(2,13,"   ");

}
void dispvc()
{
     unsigned int cc;
     lcddisp("V=");
     getVolt();
      dispval(volt,0);
      //tempcc=Adc_Read(0);
      //dispcnt(1,4);
      Lcd_Out_CP(" Amps=");
      getCurrent();
      dispval(current,1);
      Lcd_Out_CP("   ");
     // IntToStr(volt,t);
      //Lcd_Out(1,1,t);

}
void dispcnt(unsigned short start,unsigned short leng)
{
         unsigned short y;
         asm clrwdt
         for(y=0;y<leng;y++)
          {
              t[y]=tempcc%10+'0';
              tempcc=tempcc/10;
          }

          Lcd_Cmd((0xC0+start));
          for(y=leng;y>0;y--)
          {
              delay_ms(3);
              Lcd_Chr_CP(t[y-1]);
          }
}
void backlightcheck(int delms)
{
   delms=delms/10;
   for(;delms>0;delms--)
  {

      if(MENU==0 )
      {
       BackLight=1;
       T1CON.TMR1ON=0;
       backlighttimedelay= 344;  // backlight time delay 3 minute
       TMR1H=0;
       TMR1L=0;      //delay=(60*t)/(0.524288) ;t in minute
       PIR1.TMR1IF=0;
       PIE1.TMR1IE=1;
       T1CON.TMR1ON=1;
      Dela(90);
       delms-=9;
      }
     Delay_ms(10);
  }
 asm clrwdt
}
 void startmotor()
 {
     MOTOR=ON;
     MOTORst=ON;
     ALT=ON;
     BackLight=1;
     T1CON.TMR1ON=0;
     backlighttimedelay= 344;  // backlight time delay 3 minute
     subpindelay=5; //3 sec now/20add 10 for one second add.
     SubPin=ON;
     TMR1H=0;
     TMR1L=0;                 //delay=(60*t)/(0.524288)  ;t in minute
     PIR1.TMR1IF=0;
     PIE1.TMR1IE=1;
     T1CON.TMR1ON=1;
     drytemp=DryrunT;
     if(MaxT<20)
          stemp=MaxT*60;
     else
          stemp=(MaxT-20)*5*60+20*60;



 }
void waitforV()
{

    stat=UnderVolt;
               offmotor();
              disperror();
           longdelay();

 lcddisp2("Waiting for VOLT");
               do
          {
          if (MOTORst==ON) {
                  offmotor();
              }
                         backlightcheck(900);
                         dispvc();
                        getVolt(); //volt=Adc_Read(0);
                 }while(volt<(StartVoltL));
            stat=NORMAL;
                 startmotor();

                 lcddisp2("Motor Run       ");

                                   // starting current block delay
        for(i=stDelay;i>0;i--)
        {

          dispvc();
          backlightcheck(900);
          tempcc=i;
          dispcnt(13,3);
        }

}
 void waitforsubfill()
 {
      lcddisp2("Wait for sub fil");
      while(SUB==1)
      {
      dispvc();
      backlightcheck(900);
      }

     lcddisp2("Sub Fill Del");
                  for(cnt=600;cnt>0;cnt--) //20//180sub tank filling delay.MPM
                  {            backlightcheck(900);
                               dispvc();
                               tempcc=cnt;
                                dispcnt(13,3);
                 }
                 lcddisp2("Waiting for VOLT");
                  do
                               {
                         backlightcheck(900);
                         dispvc();
                         getVolt();
                 }while(volt<(StartVoltL));

                 stat=NORMAL;
                 startmotor();

                 lcddisp2("Motor ON        ");

                                   // starting current block delay
        for(i=stDelay;i>0;i--)
        {
          dispvc();
          backlightcheck(900);
          tempcc=i;
          dispcnt(13,3);
        }
 }

void offmotor()
{
   MOTOR=OFF;
   MOTORst=OFF;
   ALT=OFF;
   if(!backlighttimedelay)
        BackLight=OFF;

}
   void busse(unsigned short dell)
  {
   BUSSER=1;
                       dela(dell);
                       BUSSER=0;
                       dela(dell);
                       BUSSER=1;
                       dela(dell);
                       BUSSER=0;
  }
   void ee_write(unsigned short addr,unsigned int value)
   {
              EEprom_write(addr,Hi(value));
              EEprom_write(addr+1,lo(value));
   }

   void getVolt()
   {
    volt=Adc_Read(0);

    if(volt<20)
      {
            volt=0;
      }
      else
      {
         volt=(volt)*3+270;
         volt=volt/10;  //volt=volt/100;
       //if(volt<0)
//       {
//         volt=volt%1000;
//         volt=-volt;
//       }
      }
// temp=(long)Adc_read(0)*(long) VoltFactor;
//             temp=temp/1023L;
//             volt=temp;//====
//             //error correction
//
//             //change 185 and 25926 for adjestment
//             temp=temp*185-25926;
//             volt-=temp/1000;  //===

         }
   void getCurrent()
   {

   signed float calce,cal2;

   calce=(Adc_Read(1)>>2);
   if(calce<20)
   {
    current=0;
   }
   else
   {
   cal2=-calce*0.0313;
   calce=calce*calce*0.0011;
       current=(calce+cal2+1.2607)*10;
    }
   //cal2=-cal2;//-40.413;    //current leaner program

  //calce=(((float)tempcc*(float)tempcc)*(0.0011));//-(float)tempcc*0.0313+1.2607);
  // current=calce;



   }
