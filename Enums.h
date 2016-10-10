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
    DateWeekDay = 9,
    
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

enum EEPADDR
{
    EEPADDR_VoltageHigh = 0x02,
    EEPADDR_VoltageLow = 0x04,

    EEPADDR_CurrentHeigh = 0x06,
    EEPADDR_CurrentLow = 0x08,

    EEPADDR_LDRValHeigh = 10,
    EEPADDR_LDRValLow = 12,
    
    EEPADDR_OnOFFTimerCntEdit = 14,
    EEPADDR_OnOFFTimeEdit1 = 16,
    EEPADDR_OnOFFTimeEdit2 = 18,
    EEPADDR_OnOFFTimeEdit3 = 20,
    EEPADDR_OnOFFTimeEdit4 = 22,
    EEPADDR_OnOFFTimeEdit5 = 24,
    EEPADDR_OnOFFTimeEdit6 = 26,
    EEPADDR_OnOFFTimeEdit7 = 28,
    EEPADDR_OnOFFTimeEdit8 = 30,
    EEPADDR_OnOFFTimeEdit9 = 32,
    EEPADDR_OnOFFTimeEdit10 = 34,
    EEPADDR_OnOFFTimeEdit11 = 36,
    EEPADDR_OnOFFTimeEdit12 = 38


};