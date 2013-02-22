
_Motor_Init:

;g,32 :: 		
;g,34 :: 		
	MOVF       _motor_init_+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Motor_Init0
;g,36 :: 		
	MOVLW      1
	MOVWF      _motor_init_+0
;g,37 :: 		
	BCF        ANSELH+0, 0
;g,38 :: 		
	BCF        ANSELH+0, 2
;g,39 :: 		
	BCF        TRISB+0, 1
;g,40 :: 		
	BCF        TRISB+0, 2
;g,41 :: 		
	BCF        TRISD+0, 0
;g,42 :: 		
	BCF        TRISD+0, 1
;g,43 :: 		
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;g,44 :: 		
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;g,45 :: 		
L_Motor_Init0:
;g,46 :: 		
L_end_Motor_Init:
	RETURN
; end of _Motor_Init

_Change_Duty:

;g,52 :: 		
;g,54 :: 		
	MOVF       FARG_Change_Duty_speed+0, 0
	XORWF      _motor_duty_+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Change_Duty1
;g,56 :: 		
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      _motor_duty_+0
;g,57 :: 		
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;g,58 :: 		
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;g,59 :: 		
L_Change_Duty1:
;g,60 :: 		
L_end_Change_Duty:
	RETURN
; end of _Change_Duty

_Motor_A_FWD:

;g,64 :: 		
;g,66 :: 		
	CALL       _PWM1_Start+0
;g,67 :: 		
	BCF        PORTD+0, 0
;g,68 :: 		
	BSF        PORTD+0, 1
;g,69 :: 		
L_end_Motor_A_FWD:
	RETURN
; end of _Motor_A_FWD

_Motor_B_FWD:

;g,73 :: 		
;g,75 :: 		
	CALL       _PWM2_Start+0
;g,76 :: 		
	BCF        PORTB+0, 1
;g,77 :: 		
	BSF        PORTB+0, 2
;g,78 :: 		
L_end_Motor_B_FWD:
	RETURN
; end of _Motor_B_FWD

_Motor_A_BWD:

;g,82 :: 		
;g,84 :: 		
	CALL       _PWM1_Start+0
;g,85 :: 		
	BSF        PORTD+0, 0
;g,86 :: 		
	BCF        PORTD+0, 1
;g,87 :: 		
L_end_Motor_A_BWD:
	RETURN
; end of _Motor_A_BWD

_Motor_B_BWD:

;g,91 :: 		
;g,93 :: 		
	CALL       _PWM2_Start+0
;g,94 :: 		
	BSF        PORTB+0, 1
;g,95 :: 		
	BCF        PORTB+0, 2
;g,96 :: 		
L_end_Motor_B_BWD:
	RETURN
; end of _Motor_B_BWD

_S_Right:

;g,100 :: 		
;g,102 :: 		
	CALL       _Motor_Init+0
;g,103 :: 		
	MOVF       FARG_S_Right_speed+0, 0
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,104 :: 		
	CALL       _Motor_A_FWD+0
;g,105 :: 		
	CALL       _Motor_B_BWD+0
;g,106 :: 		
L_end_S_Right:
	RETURN
; end of _S_Right

_S_Left:

;g,110 :: 		
;g,112 :: 		
	CALL       _Motor_Init+0
;g,113 :: 		
	MOVF       FARG_S_Left_speed+0, 0
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,114 :: 		
	CALL       _Motor_A_BWD+0
;g,115 :: 		
	CALL       _Motor_B_FWD+0
;g,116 :: 		
L_end_S_Left:
	RETURN
; end of _S_Left

_Motor_Stop:

;g,119 :: 		
;g,121 :: 		
	CLRF       FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,122 :: 		
	CALL       _PWM1_Stop+0
;g,123 :: 		
	BCF        PORTD+0, 0
;g,124 :: 		
	BCF        PORTD+0, 1
;g,125 :: 		
	CALL       _PWM2_Stop+0
;g,126 :: 		
	BCF        PORTB+0, 1
;g,127 :: 		
	BCF        PORTB+0, 2
;g,128 :: 		
	CLRF       _motor_init_+0
;g,130 :: 		
L_end_Motor_Stop:
	RETURN
; end of _Motor_Stop

_Adc_Rd:

;g,4 :: 		
;g,6 :: 		
;g,7 :: 		
	MOVLW      0
	SUBWF      FARG_Adc_Rd_ch+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd4
	MOVF       FARG_Adc_Rd_ch+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd4
L__Adc_Rd134:
;g,8 :: 		
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd147:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd148
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd147
L__Adc_Rd148:
	MOVF       R0+0, 0
	IORWF      TRISA+0, 1
	GOTO       L_Adc_Rd5
L_Adc_Rd4:
;g,9 :: 		
	MOVF       FARG_Adc_Rd_ch+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_Adc_Rd6
;g,10 :: 		
	BSF        TRISA+0, 5
	GOTO       L_Adc_Rd7
L_Adc_Rd6:
;g,11 :: 		
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd10
	MOVF       FARG_Adc_Rd_ch+0, 0
	SUBLW      7
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd10
L__Adc_Rd133:
;g,12 :: 		
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd149:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd150
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd149
L__Adc_Rd150:
	MOVF       R0+0, 0
	IORWF      TRISE+0, 1
L_Adc_Rd10:
L_Adc_Rd7:
L_Adc_Rd5:
;g,13 :: 		
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd151:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd152
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd151
L__Adc_Rd152:
	MOVF       R0+0, 0
	IORWF      ANSEL+0, 1
;g,14 :: 		
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      193
	MOVWF      ADCON0+0
;g,15 :: 		
	MOVLW      16
	MOVWF      R13+0
L_Adc_Rd11:
	DECFSZ     R13+0, 1
	GOTO       L_Adc_Rd11
	NOP
;g,16 :: 		
	BSF        ADCON0+0, 1
;g,17 :: 		
L_Adc_Rd12:
	BTFSS      ADCON0+0, 1
	GOTO       L_Adc_Rd13
	GOTO       L_Adc_Rd12
L_Adc_Rd13:
;g,18 :: 		
	MOVF       ADRESH+0, 0
	MOVWF      R2+0
	CLRF       R2+1
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	RLF        R2+0, 1
	RLF        R2+1, 1
	BCF        R2+0, 0
	MOVLW      6
	MOVWF      R1+0
	MOVF       ADRESL+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd153:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd154
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd153
L__Adc_Rd154:
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;g,19 :: 		
;g,20 :: 		
L_end_Adc_Rd:
	RETURN
; end of _Adc_Rd

_isSafeY:

;g,14 :: 		
;g,16 :: 		
	MOVLW      100
	MOVWF      isSafeY_Distance_L0+0
	MOVLW      0
	MOVWF      isSafeY_Distance_L0+1
	CLRF       isSafeY_GP2_L0+0
	CLRF       isSafeY_GP2_L0+1
;g,18 :: 		
	MOVLW      2
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isSafeY_GP2_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeY_GP2_L0+1
;g,19 :: 		
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isSafeY156
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeY156:
	BTFSC      STATUS+0, 0
	GOTO       L_isSafeY14
;g,21 :: 		
	MOVLW      5
	ADDWF      isSafeY_GP2_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeY_GP2_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      32
	MOVWF      R0+1
	MOVLW      54
	MOVWF      R0+2
	MOVLW      138
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Sub_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      isSafeY_Distance_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeY_Distance_L0+1
;g,22 :: 		
L_isSafeY14:
;g,23 :: 		
	MOVF       isSafeY_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeY_Distance_L0+1, 0
	MOVWF      R0+1
;g,25 :: 		
L_end_isSafeY:
	RETURN
; end of _isSafeY

_isSafeX:

;g,27 :: 		
;g,29 :: 		
	MOVLW      100
	MOVWF      isSafeX_Distance_L0+0
	MOVLW      0
	MOVWF      isSafeX_Distance_L0+1
	CLRF       isSafeX_GP2_L0+0
	CLRF       isSafeX_GP2_L0+1
;g,31 :: 		
	MOVLW      3
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isSafeX_GP2_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeX_GP2_L0+1
;g,32 :: 		
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isSafeX158
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeX158:
	BTFSC      STATUS+0, 0
	GOTO       L_isSafeX15
;g,34 :: 		
	MOVLW      5
	ADDWF      isSafeX_GP2_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeX_GP2_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      32
	MOVWF      R0+1
	MOVLW      54
	MOVWF      R0+2
	MOVLW      138
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Sub_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      isSafeX_Distance_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeX_Distance_L0+1
;g,35 :: 		
L_isSafeX15:
;g,36 :: 		
	MOVF       isSafeX_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeX_Distance_L0+1, 0
	MOVWF      R0+1
;g,38 :: 		
L_end_isSafeX:
	RETURN
; end of _isSafeX

_strConstCpy:

;g,61 :: 		
;g,62 :: 		
L_strConstCpy16:
	MOVF       FARG_strConstCpy_source+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_strConstCpy_source+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_strConstCpy17
	MOVF       FARG_strConstCpy_source+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_strConstCpy_source+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       FARG_strConstCpy_dest+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       FARG_strConstCpy_dest+0, 1
	INCF       FARG_strConstCpy_source+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_strConstCpy_source+1, 1
	GOTO       L_strConstCpy16
L_strConstCpy17:
;g,63 :: 		
	MOVF       FARG_strConstCpy_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;g,64 :: 		
L_end_strConstCpy:
	RETURN
; end of _strConstCpy

_stradd:

;g,67 :: 		
;g,68 :: 		
L_stradd18:
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      R0+0
	INCF       FARG_stradd_dest+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_stradd19
	GOTO       L_stradd18
L_stradd19:
;g,69 :: 		
	DECF       FARG_stradd_dest+0, 1
;g,70 :: 		
L_stradd20:
	MOVF       FARG_stradd_source+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_stradd21
	MOVF       FARG_stradd_source+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	INCF       FARG_stradd_dest+0, 1
	INCF       FARG_stradd_source+0, 1
	GOTO       L_stradd20
L_stradd21:
;g,71 :: 		
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;g,72 :: 		
L_end_stradd:
	RETURN
; end of _stradd

_getParam:

;g,78 :: 		
;g,91 :: 		
;g,92 :: 		
	MOVF       FARG_getParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_getParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;g,93 :: 		
	MOVF       FARG_getParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;g,94 :: 		
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,95 :: 		
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,96 :: 		
	MOVF       FARG_getParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;g,97 :: 		
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,98 :: 		
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,99 :: 		
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,100 :: 		
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;g,101 :: 		
L_getParam22:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_getParam24
;g,103 :: 		
	CALL       _UART1_Read+0
;g,104 :: 		
	MOVLW      0
	MOVWF      R0+1
	GOTO       L_end_getParam
;g,105 :: 		
L_getParam24:
	GOTO       L_getParam22
;g,106 :: 		
L_end_getParam:
	RETURN
; end of _getParam

_setParam:

;g,108 :: 		
;g,111 :: 		
;g,112 :: 		
	MOVF       FARG_setParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_setParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;g,113 :: 		
	MOVF       FARG_setParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;g,114 :: 		
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,115 :: 		
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,116 :: 		
	MOVF       FARG_setParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;g,117 :: 		
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,118 :: 		
	MOVF       FARG_setParam_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;g,119 :: 		
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,120 :: 		
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;g,121 :: 		
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;g,122 :: 		
L_setParam25:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_setParam27
;g,124 :: 		
	CALL       _UART1_Read+0
;g,125 :: 		
	GOTO       L_end_setParam
;g,126 :: 		
L_setParam27:
	GOTO       L_setParam25
;g,127 :: 		
L_end_setParam:
	RETURN
; end of _setParam

_A_search:

;g,133 :: 		
;g,135 :: 		
	CLRF       A_search_temp_L0+0
	CLRF       A_search_temp_L0+1
;g,136 :: 		
	MOVLW      ?lstr_6_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_6_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       _cY+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
;g,137 :: 		
	MOVLW      ?lstr_7_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_7_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_setParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_setParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_setParam_y+0
	MOVF       _cY+1, 0
	MOVWF      FARG_setParam_y+1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
	MOVF       R0+0, 0
	MOVWF      FARG_setParam_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
;g,139 :: 		
	MOVLW      ?lstr_8_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_8_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       _cY+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	MOVWF      _cxx+0
;g,140 :: 		
	MOVLW      ?lstr_9_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_9_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       _cY+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	MOVWF      _cyy+0
;g,142 :: 		
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_A_search28
L_A_search28:
;g,143 :: 		
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_A_search29
	MOVF       _cyy+0, 0
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _cyy+0
L_A_search29:
;g,144 :: 		
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_A_search30
;g,146 :: 		
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;g,147 :: 		
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;g,148 :: 		
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;g,149 :: 		
L_A_search30:
;g,150 :: 		
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_A_search31
;g,152 :: 		
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;g,153 :: 		
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;g,154 :: 		
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;g,155 :: 		
L_A_search31:
;g,156 :: 		
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_SMove_nx+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_SMove_nx+1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      FARG_SMove_nx+1, 1
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_SMove_ny+0
	MOVF       _cY+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_SMove_ny+1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      FARG_SMove_ny+1, 1
	CALL       _SMove+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_A_search32
;g,158 :: 		
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cX+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      _cX+1, 1
;g,159 :: 		
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cY+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      _cY+1, 1
;g,160 :: 		
	GOTO       L_A_search33
L_A_search32:
;g,163 :: 		
	MOVLW      ?lstr_10_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_10_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_getParam_x+1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      FARG_getParam_x+1, 1
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       _cY+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_getParam_y+1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      FARG_getParam_y+1, 1
	CALL       _getParam+0
	MOVF       R0+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
;g,164 :: 		
	MOVLW      ?lstr_11_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_11_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_setParam_x+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_setParam_x+1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      FARG_setParam_x+1, 1
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_setParam_y+0
	MOVF       _cY+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      FARG_setParam_y+1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      FARG_setParam_y+1, 1
	INCF       R0+0, 1
	BTFSC      STATUS+0, 2
	INCF       R0+1, 1
	MOVF       R0+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
	MOVF       R0+0, 0
	MOVWF      FARG_setParam_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
;g,165 :: 		
L_A_search33:
;g,166 :: 		
L_end_A_search:
	RETURN
; end of _A_search

_SRotare:

;g,170 :: 		
;g,178 :: 		
;g,179 :: 		
	CLRF       SRotare_r_L0+0
;g,180 :: 		
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;g,181 :: 		
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare34
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare34:
;g,182 :: 		
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare35
;g,184 :: 		
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;g,185 :: 		
L_SRotare36:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare37
;g,187 :: 		
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare39:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare39
	DECFSZ     R12+0, 1
	GOTO       L_SRotare39
	DECFSZ     R11+0, 1
	GOTO       L_SRotare39
	NOP
	NOP
;g,188 :: 		
	MOVLW      2
	MOVWF      R4+0
	MOVF       SRotare_r_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SRotare40
	GOTO       L_SRotare38
L_SRotare40:
;g,189 :: 		
	GOTO       L_SRotare41
;g,191 :: 		
L_SRotare43:
;g,192 :: 		
	MOVLW      120
	MOVWF      FARG_cos_f+0
	MOVLW      243
	MOVWF      FARG_cos_f+1
	MOVLW      236
	MOVWF      FARG_cos_f+2
	MOVLW      125
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,193 :: 		
	MOVLW      120
	MOVWF      FARG_sin_f+0
	MOVLW      243
	MOVWF      FARG_sin_f+1
	MOVLW      236
	MOVWF      FARG_sin_f+2
	MOVLW      125
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,194 :: 		
	GOTO       L_SRotare42
;g,195 :: 		
L_SRotare44:
;g,196 :: 		
	MOVLW      96
	MOVWF      FARG_cos_f+0
	MOVLW      113
	MOVWF      FARG_cos_f+1
	MOVLW      43
	MOVWF      FARG_cos_f+2
	MOVLW      128
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,197 :: 		
	MOVLW      96
	MOVWF      FARG_sin_f+0
	MOVLW      113
	MOVWF      FARG_sin_f+1
	MOVLW      43
	MOVWF      FARG_sin_f+2
	MOVLW      128
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,198 :: 		
	GOTO       L_SRotare42
;g,199 :: 		
L_SRotare45:
;g,200 :: 		
	MOVLW      87
	MOVWF      FARG_cos_f+0
	MOVLW      38
	MOVWF      FARG_cos_f+1
	MOVLW      130
	MOVWF      FARG_cos_f+2
	MOVLW      128
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,201 :: 		
	MOVLW      87
	MOVWF      FARG_sin_f+0
	MOVLW      38
	MOVWF      FARG_sin_f+1
	MOVLW      130
	MOVWF      FARG_sin_f+2
	MOVLW      128
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,202 :: 		
	GOTO       L_SRotare42
;g,203 :: 		
L_SRotare46:
;g,204 :: 		
	MOVLW      242
	MOVWF      FARG_cos_f+0
	MOVLW      210
	MOVWF      FARG_cos_f+1
	MOVLW      13
	MOVWF      FARG_cos_f+2
	MOVLW      127
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,205 :: 		
	MOVLW      242
	MOVWF      FARG_sin_f+0
	MOVLW      210
	MOVWF      FARG_sin_f+1
	MOVLW      13
	MOVWF      FARG_sin_f+2
	MOVLW      127
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,206 :: 		
	GOTO       L_SRotare42
;g,207 :: 		
L_SRotare41:
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare43
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare44
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare45
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare46
L_SRotare42:
;g,208 :: 		
L_SRotare38:
;g,185 :: 		
	DECF       SRotare_r_L0+0, 1
;g,208 :: 		
	GOTO       L_SRotare36
L_SRotare37:
;g,209 :: 		
	GOTO       L_SRotare47
L_SRotare35:
;g,212 :: 		
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,213 :: 		
L_SRotare48:
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare49
;g,215 :: 		
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare51:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare51
	DECFSZ     R12+0, 1
	GOTO       L_SRotare51
	DECFSZ     R11+0, 1
	GOTO       L_SRotare51
	NOP
	NOP
;g,216 :: 		
	MOVF       SRotare_r_L0+0, 0
	SUBLW      0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      1
	BTFSS      SRotare_r_L0+0, 7
	MOVLW      0
	ADDWF      R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SRotare165
	MOVLW      1
	XORWF      R0+0, 0
L__SRotare165:
	BTFSS      STATUS+0, 2
	GOTO       L_SRotare52
	GOTO       L_SRotare50
L_SRotare52:
;g,217 :: 		
	GOTO       L_SRotare53
;g,219 :: 		
L_SRotare55:
;g,220 :: 		
	MOVLW      97
	MOVWF      FARG_cos_f+0
	MOVLW      113
	MOVWF      FARG_cos_f+1
	MOVLW      43
	MOVWF      FARG_cos_f+2
	MOVLW      128
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,221 :: 		
	MOVLW      97
	MOVWF      FARG_sin_f+0
	MOVLW      113
	MOVWF      FARG_sin_f+1
	MOVLW      43
	MOVWF      FARG_sin_f+2
	MOVLW      128
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,222 :: 		
	GOTO       L_SRotare54
;g,223 :: 		
L_SRotare56:
;g,224 :: 		
	MOVLW      152
	MOVWF      FARG_cos_f+0
	MOVLW      64
	MOVWF      FARG_cos_f+1
	MOVLW      58
	MOVWF      FARG_cos_f+2
	MOVLW      129
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,225 :: 		
	MOVLW      152
	MOVWF      FARG_sin_f+0
	MOVLW      64
	MOVWF      FARG_sin_f+1
	MOVLW      58
	MOVWF      FARG_sin_f+2
	MOVLW      129
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,226 :: 		
	GOTO       L_SRotare54
;g,227 :: 		
L_SRotare57:
;g,228 :: 		
	MOVLW      242
	MOVWF      FARG_cos_f+0
	MOVLW      210
	MOVWF      FARG_cos_f+1
	MOVLW      13
	MOVWF      FARG_cos_f+2
	MOVLW      127
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,229 :: 		
	MOVLW      242
	MOVWF      FARG_sin_f+0
	MOVLW      210
	MOVWF      FARG_sin_f+1
	MOVLW      13
	MOVWF      FARG_sin_f+2
	MOVLW      127
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,230 :: 		
	GOTO       L_SRotare54
;g,231 :: 		
L_SRotare58:
;g,232 :: 		
	MOVLW      164
	MOVWF      FARG_cos_f+0
	MOVLW      252
	MOVWF      FARG_cos_f+1
	MOVLW      7
	MOVWF      FARG_cos_f+2
	MOVLW      129
	MOVWF      FARG_cos_f+3
	CALL       _cos+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       _cX+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
;g,233 :: 		
	MOVLW      164
	MOVWF      FARG_sin_f+0
	MOVLW      252
	MOVWF      FARG_sin_f+1
	MOVLW      7
	MOVWF      FARG_sin_f+2
	MOVLW      129
	MOVWF      FARG_sin_f+3
	CALL       _sin+0
	MOVLW      160
	MOVWF      R4+0
	MOVLW      26
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__SRotare+0
	MOVF       R0+1, 0
	MOVWF      FLOC__SRotare+1
	MOVF       R0+2, 0
	MOVWF      FLOC__SRotare+2
	MOVF       R0+3, 0
	MOVWF      FLOC__SRotare+3
	MOVF       _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	MOVWF      R0+1
	CALL       _Int2Double+0
	MOVF       FLOC__SRotare+0, 0
	MOVWF      R4+0
	MOVF       FLOC__SRotare+1, 0
	MOVWF      R4+1
	MOVF       FLOC__SRotare+2, 0
	MOVWF      R4+2
	MOVF       FLOC__SRotare+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVF       R0+1, 0
	MOVWF      _cY+1
;g,234 :: 		
	GOTO       L_SRotare54
;g,235 :: 		
L_SRotare53:
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare55
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare56
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare57
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare58
L_SRotare54:
;g,236 :: 		
L_SRotare50:
;g,213 :: 		
	INCF       SRotare_r_L0+0, 1
;g,236 :: 		
	GOTO       L_SRotare48
L_SRotare49:
;g,237 :: 		
L_SRotare47:
;g,238 :: 		
	CALL       _Motor_Stop+0
;g,239 :: 		
	MOVF       FARG_SRotare_nd+0, 0
	MOVWF      _cdirection+0
;g,240 :: 		
L_end_SRotare:
	RETURN
; end of _SRotare

_Correct:

;g,243 :: 		
;g,245 :: 		
	CLRF       Correct_r_L0+0
	CLRF       Correct_nr_L0+0
;g,246 :: 		
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_r_L0+0
;g,247 :: 		
	MOVLW      64
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,248 :: 		
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_nr_L0+0
;g,249 :: 		
	MOVF       Correct_r_L0+0, 0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Correct59
;g,250 :: 		
	MOVLW      64
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct59:
;g,251 :: 		
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct60
;g,252 :: 		
	GOTO       L_end_Correct
L_Correct60:
;g,253 :: 		
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct61
;g,254 :: 		
	MOVLW      128
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct61:
;g,255 :: 		
	CALL       _Motor_Stop+0
;g,256 :: 		
L_end_Correct:
	RETURN
; end of _Correct

_SMove:

;g,259 :: 		
;g,267 :: 		
	MOVLW      1
	MOVWF      SMove_nd_L0+0
	CLRF       SMove_SafeX_L0+0
	CLRF       SMove_SafeX_L0+1
	CLRF       SMove_SafeY_L0+0
	CLRF       SMove_SafeY_L0+1
	CLRF       SMove_ax_L0+0
	CLRF       SMove_ry_L0+0
	CLRF       SMove_isMove_L0+0
;g,275 :: 		
	MOVF       _cX+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       _cX+1, 0
	MOVWF      FARG_comp_d1+1
	MOVF       FARG_SMove_nx+0, 0
	MOVWF      FARG_comp_d2+0
	MOVF       FARG_SMove_nx+1, 0
	MOVWF      FARG_comp_d2+1
	CALL       _comp+0
	MOVF       R0+0, 0
	MOVWF      SMove_ax_L0+0
;g,276 :: 		
	MOVF       _cY+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       _cY+1, 0
	MOVWF      FARG_comp_d1+1
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_comp_d2+0
	MOVF       FARG_SMove_ny+1, 0
	MOVWF      FARG_comp_d2+1
	CALL       _comp+0
	MOVF       R0+0, 0
	MOVWF      SMove_ry_L0+0
;g,278 :: 		
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove62
;g,279 :: 		
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove62:
;g,280 :: 		
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove63
;g,281 :: 		
	GOTO       L_SMove64
;g,283 :: 		
L_SMove66:
;g,284 :: 		
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;g,285 :: 		
	GOTO       L_SMove65
;g,286 :: 		
L_SMove67:
;g,287 :: 		
	MOVLW      9
	MOVWF      SMove_nd_L0+0
;g,289 :: 		
	GOTO       L_SMove65
;g,290 :: 		
L_SMove68:
;g,291 :: 		
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;g,292 :: 		
	GOTO       L_SMove65
;g,294 :: 		
L_SMove64:
	MOVF       SMove_ry_L0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_SMove66
	MOVF       SMove_ry_L0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove67
	MOVF       SMove_ry_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove68
L_SMove65:
L_SMove63:
;g,295 :: 		
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove69
;g,296 :: 		
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove69:
;g,299 :: 		
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      SMove_SafeY_L0+0
	MOVF       R0+1, 0
	MOVWF      SMove_SafeY_L0+1
;g,300 :: 		
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      SMove_SafeX_L0+0
	MOVF       R0+1, 0
	MOVWF      SMove_SafeX_L0+1
;g,301 :: 		
	MOVLW      ?lstr_12_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_12_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       R0+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       R0+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       SMove_SafeY_L0+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       SMove_SafeY_L0+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
;g,302 :: 		
	GOTO       L_SMove70
;g,304 :: 		
L_SMove72:
;g,305 :: 		
L_SMove73:
;g,306 :: 		
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      SMove_SafeY_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove168
	MOVF       SMove_SafeY_L0+0, 0
	SUBLW      2
L__SMove168:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove74
;g,308 :: 		
	CALL       _Motor_Init+0
;g,309 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,310 :: 		
	CALL       _Motor_A_FWD+0
;g,311 :: 		
	CALL       _Motor_B_FWD+0
;g,312 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove75:
	DECFSZ     R13+0, 1
	GOTO       L_SMove75
	DECFSZ     R12+0, 1
	GOTO       L_SMove75
	DECFSZ     R11+0, 1
	GOTO       L_SMove75
;g,313 :: 		
	CALL       _Motor_Stop+0
;g,314 :: 		
	CALL       _Correct+0
;g,315 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,316 :: 		
L_SMove74:
;g,317 :: 		
	GOTO       L_SMove71
;g,318 :: 		
L_SMove76:
;g,319 :: 		
L_SMove77:
;g,320 :: 		
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      SMove_SafeY_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove169
	MOVF       SMove_SafeY_L0+0, 0
	SUBLW      2
L__SMove169:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove80
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      SMove_SafeX_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove170
	MOVF       SMove_SafeX_L0+0, 0
	SUBLW      2
L__SMove170:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove80
L__SMove135:
;g,322 :: 		
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;g,323 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove81:
	DECFSZ     R13+0, 1
	GOTO       L_SMove81
	DECFSZ     R12+0, 1
	GOTO       L_SMove81
	DECFSZ     R11+0, 1
	GOTO       L_SMove81
	NOP
;g,324 :: 		
	CALL       _Motor_Init+0
;g,325 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,326 :: 		
	CALL       _Motor_A_FWD+0
;g,327 :: 		
	CALL       _Motor_B_FWD+0
;g,328 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove82:
	DECFSZ     R13+0, 1
	GOTO       L_SMove82
	DECFSZ     R12+0, 1
	GOTO       L_SMove82
	DECFSZ     R11+0, 1
	GOTO       L_SMove82
;g,329 :: 		
	CALL       _Motor_Stop+0
;g,330 :: 		
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,331 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove83:
	DECFSZ     R13+0, 1
	GOTO       L_SMove83
	DECFSZ     R12+0, 1
	GOTO       L_SMove83
	DECFSZ     R11+0, 1
	GOTO       L_SMove83
	NOP
;g,332 :: 		
	CALL       _Correct+0
;g,333 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,334 :: 		
L_SMove80:
;g,335 :: 		
	GOTO       L_SMove71
;g,336 :: 		
L_SMove84:
;g,337 :: 		
L_SMove85:
;g,338 :: 		
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      SMove_SafeX_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove171
	MOVF       SMove_SafeX_L0+0, 0
	SUBLW      2
L__SMove171:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove86
;g,340 :: 		
	CALL       _Motor_Init+0
;g,341 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,342 :: 		
	CALL       _Motor_A_BWD+0
;g,343 :: 		
	CALL       _Motor_B_BWD+0
;g,344 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove87:
	DECFSZ     R13+0, 1
	GOTO       L_SMove87
	DECFSZ     R12+0, 1
	GOTO       L_SMove87
	DECFSZ     R11+0, 1
	GOTO       L_SMove87
;g,345 :: 		
	CALL       _Motor_Stop+0
;g,346 :: 		
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;g,347 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove88:
	DECFSZ     R13+0, 1
	GOTO       L_SMove88
	DECFSZ     R12+0, 1
	GOTO       L_SMove88
	DECFSZ     R11+0, 1
	GOTO       L_SMove88
	NOP
;g,348 :: 		
	CALL       _Motor_Init+0
;g,349 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,350 :: 		
	CALL       _Motor_A_FWD+0
;g,351 :: 		
	CALL       _Motor_B_FWD+0
;g,352 :: 		
	MOVLW      6
	MOVWF      R11+0
	MOVLW      104
	MOVWF      R12+0
	MOVLW      23
	MOVWF      R13+0
L_SMove89:
	DECFSZ     R13+0, 1
	GOTO       L_SMove89
	DECFSZ     R12+0, 1
	GOTO       L_SMove89
	DECFSZ     R11+0, 1
	GOTO       L_SMove89
	NOP
	NOP
;g,353 :: 		
	CALL       _Motor_Stop+0
;g,354 :: 		
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,355 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove90:
	DECFSZ     R13+0, 1
	GOTO       L_SMove90
	DECFSZ     R12+0, 1
	GOTO       L_SMove90
	DECFSZ     R11+0, 1
	GOTO       L_SMove90
	NOP
;g,356 :: 		
	CALL       _Correct+0
;g,357 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,358 :: 		
L_SMove86:
;g,359 :: 		
	GOTO       L_SMove71
;g,360 :: 		
L_SMove91:
;g,361 :: 		
L_SMove92:
;g,362 :: 		
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      SMove_SafeX_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove172
	MOVF       SMove_SafeX_L0+0, 0
	SUBLW      2
L__SMove172:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove93
;g,364 :: 		
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,365 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove94:
	DECFSZ     R13+0, 1
	GOTO       L_SMove94
	DECFSZ     R12+0, 1
	GOTO       L_SMove94
	DECFSZ     R11+0, 1
	GOTO       L_SMove94
	NOP
;g,366 :: 		
	CALL       _Motor_Init+0
;g,367 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,368 :: 		
	CALL       _Motor_A_BWD+0
;g,369 :: 		
	CALL       _Motor_B_BWD+0
;g,370 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove95:
	DECFSZ     R13+0, 1
	GOTO       L_SMove95
	DECFSZ     R12+0, 1
	GOTO       L_SMove95
	DECFSZ     R11+0, 1
	GOTO       L_SMove95
;g,371 :: 		
	CALL       _Motor_Stop+0
;g,372 :: 		
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;g,373 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove96:
	DECFSZ     R13+0, 1
	GOTO       L_SMove96
	DECFSZ     R12+0, 1
	GOTO       L_SMove96
	DECFSZ     R11+0, 1
	GOTO       L_SMove96
	NOP
;g,374 :: 		
	CALL       _Correct+0
;g,375 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,376 :: 		
L_SMove93:
;g,377 :: 		
	GOTO       L_SMove71
;g,378 :: 		
L_SMove97:
;g,379 :: 		
L_SMove98:
;g,380 :: 		
	CALL       _Motor_Init+0
;g,381 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,382 :: 		
	CALL       _Motor_A_BWD+0
;g,383 :: 		
	CALL       _Motor_B_BWD+0
;g,384 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove99:
	DECFSZ     R13+0, 1
	GOTO       L_SMove99
	DECFSZ     R12+0, 1
	GOTO       L_SMove99
	DECFSZ     R11+0, 1
	GOTO       L_SMove99
;g,385 :: 		
	CALL       _Motor_Stop+0
;g,386 :: 		
	CALL       _Motor_Init+0
;g,387 :: 		
	CALL       _Correct+0
;g,388 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,389 :: 		
	GOTO       L_SMove71
;g,390 :: 		
L_SMove100:
;g,391 :: 		
L_SMove101:
;g,392 :: 		
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;g,393 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove102:
	DECFSZ     R13+0, 1
	GOTO       L_SMove102
	DECFSZ     R12+0, 1
	GOTO       L_SMove102
	DECFSZ     R11+0, 1
	GOTO       L_SMove102
	NOP
;g,394 :: 		
	CALL       _Motor_Init+0
;g,395 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,396 :: 		
	CALL       _Motor_A_BWD+0
;g,397 :: 		
	CALL       _Motor_B_BWD+0
;g,398 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove103:
	DECFSZ     R13+0, 1
	GOTO       L_SMove103
	DECFSZ     R12+0, 1
	GOTO       L_SMove103
	DECFSZ     R11+0, 1
	GOTO       L_SMove103
;g,399 :: 		
	CALL       _Motor_Stop+0
;g,400 :: 		
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,401 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove104:
	DECFSZ     R13+0, 1
	GOTO       L_SMove104
	DECFSZ     R12+0, 1
	GOTO       L_SMove104
	DECFSZ     R11+0, 1
	GOTO       L_SMove104
	NOP
;g,402 :: 		
	CALL       _Correct+0
;g,403 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,404 :: 		
	GOTO       L_SMove71
;g,405 :: 		
L_SMove105:
;g,406 :: 		
L_SMove106:
;g,407 :: 		
	CALL       _Motor_Init+0
;g,408 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,409 :: 		
	CALL       _Motor_A_BWD+0
;g,410 :: 		
	CALL       _Motor_B_BWD+0
;g,411 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove107:
	DECFSZ     R13+0, 1
	GOTO       L_SMove107
	DECFSZ     R12+0, 1
	GOTO       L_SMove107
	DECFSZ     R11+0, 1
	GOTO       L_SMove107
;g,412 :: 		
	CALL       _Motor_Stop+0
;g,413 :: 		
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,414 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove108:
	DECFSZ     R13+0, 1
	GOTO       L_SMove108
	DECFSZ     R12+0, 1
	GOTO       L_SMove108
	DECFSZ     R11+0, 1
	GOTO       L_SMove108
	NOP
;g,415 :: 		
	CALL       _Motor_Init+0
;g,416 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,417 :: 		
	CALL       _Motor_A_FWD+0
;g,418 :: 		
	CALL       _Motor_B_FWD+0
;g,419 :: 		
	MOVLW      6
	MOVWF      R11+0
	MOVLW      104
	MOVWF      R12+0
	MOVLW      23
	MOVWF      R13+0
L_SMove109:
	DECFSZ     R13+0, 1
	GOTO       L_SMove109
	DECFSZ     R12+0, 1
	GOTO       L_SMove109
	DECFSZ     R11+0, 1
	GOTO       L_SMove109
	NOP
	NOP
;g,420 :: 		
	CALL       _Motor_Stop+0
;g,421 :: 		
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;g,422 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove110:
	DECFSZ     R13+0, 1
	GOTO       L_SMove110
	DECFSZ     R12+0, 1
	GOTO       L_SMove110
	DECFSZ     R11+0, 1
	GOTO       L_SMove110
	NOP
;g,423 :: 		
	CALL       _Correct+0
;g,424 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,425 :: 		
	GOTO       L_SMove71
;g,426 :: 		
L_SMove111:
;g,427 :: 		
L_SMove112:
;g,428 :: 		
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      SMove_SafeY_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove173
	MOVF       SMove_SafeY_L0+0, 0
	SUBLW      2
L__SMove173:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove113
;g,430 :: 		
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;g,431 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove114:
	DECFSZ     R13+0, 1
	GOTO       L_SMove114
	DECFSZ     R12+0, 1
	GOTO       L_SMove114
	DECFSZ     R11+0, 1
	GOTO       L_SMove114
	NOP
;g,432 :: 		
	CALL       _Motor_Init+0
;g,433 :: 		
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;g,434 :: 		
	CALL       _Motor_A_FWD+0
;g,435 :: 		
	CALL       _Motor_B_FWD+0
;g,436 :: 		
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove115:
	DECFSZ     R13+0, 1
	GOTO       L_SMove115
	DECFSZ     R12+0, 1
	GOTO       L_SMove115
	DECFSZ     R11+0, 1
	GOTO       L_SMove115
;g,437 :: 		
	CALL       _Motor_Stop+0
;g,438 :: 		
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;g,439 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove116:
	DECFSZ     R13+0, 1
	GOTO       L_SMove116
	DECFSZ     R12+0, 1
	GOTO       L_SMove116
	DECFSZ     R11+0, 1
	GOTO       L_SMove116
	NOP
;g,440 :: 		
	CALL       _Correct+0
;g,441 :: 		
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;g,442 :: 		
L_SMove113:
;g,443 :: 		
	GOTO       L_SMove71
;g,444 :: 		
L_SMove117:
;g,445 :: 		
L_SMove118:
;g,446 :: 		
	MOVLW      ?lstr_13_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_13_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVLW      1
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	MOVWF      FARG_getParam_x+1
	MOVLW      1
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
;g,447 :: 		
	GOTO       L_SMove71
;g,448 :: 		
L_SMove70:
	MOVF       SMove_nd_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove72
	MOVF       SMove_nd_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove73
	MOVF       SMove_nd_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_SMove76
	MOVF       SMove_nd_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_SMove77
	MOVF       SMove_nd_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SMove84
	MOVF       SMove_nd_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SMove85
	MOVF       SMove_nd_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_SMove91
	MOVF       SMove_nd_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_SMove92
	MOVF       SMove_nd_L0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SMove97
	MOVF       SMove_nd_L0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SMove98
	MOVF       SMove_nd_L0+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_SMove100
	MOVF       SMove_nd_L0+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_SMove101
	MOVF       SMove_nd_L0+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SMove105
	MOVF       SMove_nd_L0+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SMove106
	MOVF       SMove_nd_L0+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_SMove111
	MOVF       SMove_nd_L0+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_SMove112
	MOVF       SMove_nd_L0+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_SMove117
	MOVF       SMove_nd_L0+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_SMove118
L_SMove71:
;g,451 :: 		
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove119
;g,454 :: 		
	MOVF       SMove_isMove_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove120
;g,455 :: 		
	MOVLW      ?lstr_14_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_14_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       FARG_SMove_nx+0, 0
	MOVWF      FARG_setParam_x+0
	MOVF       FARG_SMove_nx+1, 0
	MOVWF      FARG_setParam_x+1
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_setParam_y+0
	MOVF       FARG_SMove_ny+1, 0
	MOVWF      FARG_setParam_y+1
	MOVLW      1
	MOVWF      FARG_setParam_value+0
	MOVLW      0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
L_SMove120:
;g,456 :: 		
L_SMove119:
;g,457 :: 		
	MOVF       SMove_isMove_L0+0, 0
	MOVWF      R0+0
;g,459 :: 		
L_end_SMove:
	RETURN
; end of _SMove

_isMetall:

;g,461 :: 		
;g,463 :: 		
	CLRF       isMetall_m_L0+0
;g,464 :: 		
	MOVLW      1
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isMetall_m_L0+0
;g,465 :: 		
	MOVLW      128
	XORLW      0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall123
	MOVLW      128
	XORWF      isMetall_m_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      50
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall123
L__isMetall136:
;g,466 :: 		
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isMetall
L_isMetall123:
;g,468 :: 		
	CLRF       R0+0
;g,469 :: 		
L_end_isMetall:
	RETURN
; end of _isMetall

_comp:

;g,471 :: 		
;g,473 :: 		
	MOVF       FARG_comp_d1+1, 0
	XORWF      FARG_comp_d2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp176
	MOVF       FARG_comp_d2+0, 0
	XORWF      FARG_comp_d1+0, 0
L__comp176:
	BTFSS      STATUS+0, 2
	GOTO       L_comp125
	CLRF       R0+0
	GOTO       L_end_comp
L_comp125:
;g,474 :: 		
	MOVLW      128
	XORWF      FARG_comp_d2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp177
	MOVF       FARG_comp_d1+0, 0
	SUBWF      FARG_comp_d2+0, 0
L__comp177:
	BTFSC      STATUS+0, 0
	GOTO       L_comp126
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_comp
L_comp126:
;g,475 :: 		
	MOVLW      255
	MOVWF      R0+0
;g,476 :: 		
L_end_comp:
	RETURN
; end of _comp

_printing:

;g,18 :: 		
;g,20 :: 		
	CALL       _Lcd_Init+0
;g,21 :: 		
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;g,22 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;g,23 :: 		
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       FARG_printing_text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;g,24 :: 		
L_end_printing:
	RETURN
; end of _printing

_main:

;g,26 :: 		
;g,28 :: 		
;g,29 :: 		
	CLRF       main_temp1_L0+0
	CLRF       main_temp1_L0+1
;g,30 :: 		
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;g,31 :: 		
L_main128:
	MOVLW      ?lstr_15_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_15_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVLW      1
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	MOVWF      FARG_getParam_x+1
	MOVLW      1
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main180
	MOVLW      13
	XORWF      R0+0, 0
L__main180:
	BTFSC      STATUS+0, 2
	GOTO       L_main129
;g,32 :: 		
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main130:
	DECFSZ     R13+0, 1
	GOTO       L_main130
	DECFSZ     R12+0, 1
	GOTO       L_main130
	DECFSZ     R11+0, 1
	GOTO       L_main130
	NOP
	NOP
	GOTO       L_main128
L_main129:
;g,34 :: 		
	MOVLW      5
	MOVWF      _cdirection+0
;g,35 :: 		
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVF       R0+1, 0
	MOVWF      _cX+1
	RRF        _cX+1, 1
	RRF        _cX+0, 1
	BCF        _cX+1, 7
	BTFSC      _cX+1, 6
	BSF        _cX+1, 7
;g,36 :: 		
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	BTFSC      R2+1, 6
	BSF        R2+1, 7
	MOVF       R2+0, 0
	MOVWF      _cY+0
	MOVF       R2+1, 0
	MOVWF      _cY+1
;g,37 :: 		
	MOVLW      ?lstr_16_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_16_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       R2+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       R2+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
;g,38 :: 		
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVLW      1
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;g,39 :: 		
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	BTFSC      R2+1, 6
	BSF        R2+1, 7
	MOVF       R2+0, 0
	ADDWF      _cX+0, 0
	MOVWF      _maxX+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      _maxX+1
;g,40 :: 		
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	MOVWF      R2+1
	RRF        R2+1, 1
	RRF        R2+0, 1
	BCF        R2+1, 7
	BTFSC      R2+1, 6
	BSF        R2+1, 7
	MOVF       R2+0, 0
	ADDWF      _cY+0, 0
	MOVWF      _maxY+0
	MOVF       _cY+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      _maxY+1
;g,42 :: 		
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      main_temp1_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temp1_L0+1
;g,43 :: 		
	CALL       _isSafeX+0
;g,44 :: 		
	MOVLW      ?lstr_17_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_17_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       R0+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       R0+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       main_temp1_L0+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       main_temp1_L0+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
;g,45 :: 		
	MOVLW      ?lstr_18_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_18_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       _maxX+0, 0
	MOVWF      FARG_setParam_x+0
	MOVF       _maxX+1, 0
	MOVWF      FARG_setParam_x+1
	MOVF       _maxY+0, 0
	MOVWF      FARG_setParam_y+0
	MOVF       _maxY+1, 0
	MOVWF      FARG_setParam_y+1
	MOVLW      1
	MOVWF      FARG_setParam_value+0
	MOVLW      0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
;g,46 :: 		
	MOVLW      ?lstr_19_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_19_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       _cY+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
;g,48 :: 		
L_main131:
	MOVLW      ?lstr_20_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_20_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVLW      1
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	MOVWF      FARG_getParam_x+1
	MOVLW      1
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main181
	MOVLW      13
	XORWF      R0+0, 0
L__main181:
	BTFSC      STATUS+0, 2
	GOTO       L_main132
;g,70 :: 		
	CALL       _A_search+0
;g,71 :: 		
	GOTO       L_main131
L_main132:
;g,72 :: 		
L_end_main:
	GOTO       $+0
; end of _main
