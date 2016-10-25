//Global Variables

enum menus {
    None,
    Date,
    Time,
    Voltage,
    Current,
    LDRVal,
    //OnOFFTimerCnt,
    OnOFFTimeDay,
    OnOFFTime
};


enum subMenu{
    NoEdit,
    
    DateDay = 0,
    DateMonth = 3,
    DateYear = 6,
    DateWeekDay = 9,
    
    TimeHour = 0,
    TimeMinute = 3,
    
    VoltageEnable = 0,
    VoltageHigh = 7,
    VoltageLow = 13,
    
    CurrentEnable = 0,
    CurrentHeigh = 8,
    CurrentLow = 13,
    
    LDRValEnable = 0,
    LDRValHeigh = 8,
    LDRValLow = 13,
    
    //OnOFFTimerCntEdit,
    OnOFFTimeDaySun = 2,
    OnOFFTimeDayMon = 4,
    OnOFFTimeDayTue = 6,
    OnOFFTimeDayWed = 8,
    OnOFFTimeDayThu = 10,
    OnOFFTimeDayFri = 12,
    OnOFFTimeDaySat = 14,
    
    //N>10:10 F>10:10
    OnOFFTimeOnHr = 3,
    OnOFFTimeOnMin = 6,
    OnOFFTimeOffHr = 11,
    OnOFFTimeOffMin = 14


};

enum EEPADDR
{
    EEPADDR_VoltageHigh = 0x02,
    EEPADDR_VoltageLow = 0x04,

    EEPADDR_CurrentHeigh = 0x06,
    EEPADDR_CurrentLow = 0x08,

    EEPADDR_LDRValHeigh = 10,
    EEPADDR_LDRValLow = 12,
    
    EEPADDR_OnOFFTimerCntEdit = 14,
    
    EEPADDR_OnOFFTimeDay1 = 20,
    EEPADDR_OnOFFTimeDay2 = 25,
    EEPADDR_OnOFFTimeDay3 = 30,
    EEPADDR_OnOFFTimeDay4 = 35,
    EEPADDR_OnOFFTimeDay5 = 40,
    EEPADDR_OnOFFTimeDay6 = 45,
    EEPADDR_OnOFFTimeDay7 = 50,
    EEPADDR_OnOFFTimeDay8 = 55,
    EEPADDR_OnOFFTimeDay9 = 60,
    EEPADDR_OnOFFTimeDay10 = 65,
    EEPADDR_OnOFFTimeDay11 = 70,
    EEPADDR_OnOFFTimeDay12 = 75,
    EEPADDR_OnOFFTimeDay13 = 80,
    EEPADDR_OnOFFTimeDay14 = 85
};
enum TIMERMEM
{
     TIMERMEMDays = 0,
     TIMERMEMOnHour = 1,
     TIMERMEMOnMin = 2,
     TIMERMEMOffHour = 3,
     TIMERMEMOffMin  = 4
};