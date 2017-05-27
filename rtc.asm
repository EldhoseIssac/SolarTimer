
_InitRTC:

	MOVLW      50
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
L_end_InitRTC:
	RETURN
; end of _InitRTC

_read_ds1307:

	CALL       _I2C1_Start+0
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	MOVF       FARG_read_ds1307_address+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	CALL       _I2C1_Repeated_Start+0
	MOVLW      209
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      read_ds1307_r_data_L0+0
	CALL       _I2C1_Stop+0
	MOVF       read_ds1307_r_data_L0+0, 0
	MOVWF      R0+0
L_end_read_ds1307:
	RETURN
; end of _read_ds1307

_write_ds1307:

	CALL       _I2C1_Start+0
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	MOVF       FARG_write_ds1307_address+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	MOVF       FARG_write_ds1307_w_data+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	CALL       _I2C1_Stop+0
L_end_write_ds1307:
	RETURN
; end of _write_ds1307

_reIntRtc:

	MOVLW      7
	MOVWF      FARG_write_ds1307_address+0
	MOVLW      16
	MOVWF      FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
	CLRF       FARG_write_ds1307_address+0
	CLRF       FARG_write_ds1307_w_data+0
	CALL       _write_ds1307+0
L_end_reIntRtc:
	RETURN
; end of _reIntRtc

_loadTimeAndDate:

	CALL       _I2C1_Start+0
	MOVLW      208
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	CLRF       FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	CALL       _I2C1_Repeated_Start+0
	MOVLW      209
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _second+0
	BTFSS      _second+0, 7
	GOTO       L_loadTimeAndDate0
	CALL       _reIntRtc+0
	CLRF       _second+0
L_loadTimeAndDate0:
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _minute+0
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _hour+0
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _dday+0
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _day+0
	MOVLW      1
	MOVWF      FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _month+0
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      _year+0
	CALL       _I2C1_Stop+0
L_end_loadTimeAndDate:
	RETURN
; end of _loadTimeAndDate
