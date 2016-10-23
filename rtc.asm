
_InitRTC:

;rtc.c,39 :: 		void InitRTC(){
;rtc.c,40 :: 		I2C1_Init(100000); //DS1307 I2C is running at 100KHz
	MOVLW      50
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;rtc.c,41 :: 		}
L_end_InitRTC:
	RETURN
; end of _InitRTC

_read_ds1307:

;rtc.c,43 :: 		unsigned short read_ds1307(unsigned short address)
;rtc.c,46 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;rtc.c,47 :: 		I2C1_Wr(0xD0); //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,48 :: 		I2C1_Wr(address);
	MOVF       FARG_read_ds1307_address+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,49 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;rtc.c,50 :: 		I2C1_Wr(0xD1); //0x68 followed by 1 --> 0xD1
	MOVLW      209
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,51 :: 		r_data=I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      read_ds1307_r_data_L0+0
;rtc.c,52 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;rtc.c,53 :: 		return(r_data);
	MOVF       read_ds1307_r_data_L0+0, 0
	MOVWF      R0+0
;rtc.c,54 :: 		}
L_end_read_ds1307:
	RETURN
; end of _read_ds1307

_write_ds1307:

;rtc.c,56 :: 		void write_ds1307(unsigned short address,unsigned short w_data)
;rtc.c,58 :: 		I2C1_Start(); // issue I2C start signal
	CALL       _I2C1_Start+0
;rtc.c,60 :: 		I2C1_Wr(0xD0); // send byte via I2C (device address + W)
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,61 :: 		I2C1_Wr(address); // send byte (address of DS1307 location)
	MOVF       FARG_write_ds1307_address+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,62 :: 		I2C1_Wr(w_data); // send data (data to be written)
	MOVF       FARG_write_ds1307_w_data+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,63 :: 		I2C1_Stop(); // issue I2C stop signal
	CALL       _I2C1_Stop+0
;rtc.c,64 :: 		}
L_end_write_ds1307:
	RETURN
; end of _write_ds1307

_reIntRtc:

;rtc.c,65 :: 		void reIntRtc(){
;rtc.c,66 :: 		write_ds1307(0x07,0x10);
	MOVLW      7
	MOVWF      FARG_write_ds1307_address+0
	MOVLW      16
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;rtc.c,67 :: 		write_ds1307(0x00,0X00);
	CLRF       FARG_write_ds1307_address+0
	CLRF       FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
;rtc.c,68 :: 		}
L_end_reIntRtc:
	RETURN
; end of _reIntRtc

_loadTimeAndDate:

;rtc.c,69 :: 		void loadTimeAndDate(){
;rtc.c,71 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;rtc.c,72 :: 		I2C1_Wr(0xD0);
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,73 :: 		I2C1_Wr(0);
	CLRF       FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,74 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;rtc.c,75 :: 		I2C1_Wr(0xD1);
	MOVLW      209
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;rtc.c,76 :: 		second =I2C1_Rd(1);
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _second+0
;rtc.c,80 :: 		if (second.B7){
	BTFSS      _second+0, 7
	GOTO       L_loadTimeAndDate0
;rtc.c,83 :: 		reIntRtc();
	CALL       _reIntRtc+0
;rtc.c,84 :: 		second = 0;
	CLRF       _second+0
;rtc.c,85 :: 		}
L_loadTimeAndDate0:
;rtc.c,86 :: 		minute =I2C1_Rd(1);
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _minute+0
;rtc.c,87 :: 		hour =I2C1_Rd(1);
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _hour+0
;rtc.c,88 :: 		dday =I2C1_Rd(1);
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _dday+0
;rtc.c,89 :: 		day =I2C1_Rd(1);
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _day+0
;rtc.c,90 :: 		month =I2C1_Rd(1);
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _month+0
;rtc.c,91 :: 		year =I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _year+0
;rtc.c,92 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;rtc.c,109 :: 		}
L_end_loadTimeAndDate:
	RETURN
; end of _loadTimeAndDate
