//Global Variables

enum menus {
    None,
    Date,
    Time,
    Voltage,
    Current,
    LDRVal,
    OnOFFTimerCnt,
    OnOFFTime
};

enum subMenu{
    NoEdit,
    
    DateDay = 0,
    DateMonth = 3,
    DateYear = 6,
    DateWeekDay = 7,
    
    TimeHour = 0,
    TimeMinute = 3,
    
    VoltageEnable = 0,
    VoltageHigh = 8,
    VoltageLow = 13,
    
    CurrentEnable = 0,
    CurrentHeigh = 8,
    CurrentLow = 13,
    
    LDRValEnable = 0,
    LDRValHeigh = 8,
    LDRValLow = 13,
    
    OnOFFTimerCntEdit,
    OnOFFTimeEdit
    
    
};