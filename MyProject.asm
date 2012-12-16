
_Motor_Init:

;motor.h,33 :: 		void Motor_Init()
;motor.h,35 :: 		if (motor_init_==0)            // First time ?
	MOVF       _motor_init_+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Motor_Init0
;motor.h,37 :: 		motor_init_=1;               // Status
	MOVLW      1
	MOVWF      _motor_init_+0
;motor.h,38 :: 		ANSELH.F0=0;                 // RB1 ==> Digital IO
	BCF        ANSELH+0, 0
;motor.h,39 :: 		ANSELH.F2=0;                 // RB2 ==> Digital IO
	BCF        ANSELH+0, 2
;motor.h,40 :: 		TRISB.F1=0;                  // Motor B 2A
	BCF        TRISB+0, 1
;motor.h,41 :: 		TRISB.F2=0;                  // Motor B 2B
	BCF        TRISB+0, 2
;motor.h,42 :: 		TRISD.F0=0;                  // Motor A 1A
	BCF        TRISD+0, 0
;motor.h,43 :: 		TRISD.F1=0;                  // MOtor A 1B
	BCF        TRISD+0, 1
;motor.h,44 :: 		Pwm1_Init(5000);             // Initail PWM 1E
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;motor.h,45 :: 		Pwm2_Init(5000);             // Initail PWM 2E
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;motor.h,46 :: 		}
L_Motor_Init0:
;motor.h,47 :: 		}
L_end_Motor_Init:
	RETURN
; end of _Motor_Init

_Change_Duty:

;motor.h,53 :: 		void Change_Duty(char speed)
;motor.h,55 :: 		if (speed != motor_duty_)      // Check Same old speed
	MOVF       FARG_Change_Duty_speed+0, 0
	XORWF      _motor_duty_+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Change_Duty1
;motor.h,57 :: 		motor_duty_=speed;            // Save for old speed
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      _motor_duty_+0
;motor.h,58 :: 		PWM1_Set_Duty(speed);      // Motor A
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motor.h,59 :: 		PWM2_Set_Duty(speed);      // Motor B
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motor.h,62 :: 		}
L_Change_Duty1:
;motor.h,63 :: 		}
L_end_Change_Duty:
	RETURN
; end of _Change_Duty

_Motor_A_FWD:

;motor.h,67 :: 		void Motor_A_FWD()
;motor.h,69 :: 		Pwm1_Start();
	CALL       _PWM1_Start+0
;motor.h,70 :: 		PORTD.F0 =0;
	BCF        PORTD+0, 0
;motor.h,71 :: 		PORTD.F1 =1;
	BSF        PORTD+0, 1
;motor.h,72 :: 		}
L_end_Motor_A_FWD:
	RETURN
; end of _Motor_A_FWD

_Motor_B_FWD:

;motor.h,76 :: 		void Motor_B_FWD()
;motor.h,78 :: 		Pwm2_Start();
	CALL       _PWM2_Start+0
;motor.h,79 :: 		PORTB.F1 =0;
	BCF        PORTB+0, 1
;motor.h,80 :: 		PORTB.F2 =1;
	BSF        PORTB+0, 2
;motor.h,81 :: 		}
L_end_Motor_B_FWD:
	RETURN
; end of _Motor_B_FWD

_Motor_A_BWD:

;motor.h,85 :: 		void Motor_A_BWD()
;motor.h,87 :: 		Pwm1_Start();
	CALL       _PWM1_Start+0
;motor.h,88 :: 		PORTD.F0 =1;
	BSF        PORTD+0, 0
;motor.h,89 :: 		PORTD.F1 =0;
	BCF        PORTD+0, 1
;motor.h,90 :: 		}
L_end_Motor_A_BWD:
	RETURN
; end of _Motor_A_BWD

_Motor_B_BWD:

;motor.h,94 :: 		void Motor_B_BWD()
;motor.h,96 :: 		Pwm2_Start();
	CALL       _PWM2_Start+0
;motor.h,97 :: 		PORTB.F1 =1;
	BSF        PORTB+0, 1
;motor.h,98 :: 		PORTB.F2 =0;
	BCF        PORTB+0, 2
;motor.h,99 :: 		}
L_end_Motor_B_BWD:
	RETURN
; end of _Motor_B_BWD

_S_Right:

;motor.h,124 :: 		void S_Right(char speed)
;motor.h,126 :: 		Motor_Init();
	CALL       _Motor_Init+0
;motor.h,127 :: 		Change_Duty(speed);
	MOVF       FARG_S_Right_speed+0, 0
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;motor.h,128 :: 		Motor_A_FWD();
	CALL       _Motor_A_FWD+0
;motor.h,129 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;motor.h,130 :: 		}
L_end_S_Right:
	RETURN
; end of _S_Right

_S_Left:

;motor.h,134 :: 		void S_Left(char speed)
;motor.h,136 :: 		Motor_Init();
	CALL       _Motor_Init+0
;motor.h,137 :: 		Change_Duty(speed);
	MOVF       FARG_S_Left_speed+0, 0
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;motor.h,138 :: 		Motor_A_BWD();
	CALL       _Motor_A_BWD+0
;motor.h,139 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;motor.h,140 :: 		}
L_end_S_Left:
	RETURN
; end of _S_Left

_Motor_Stop:

;motor.h,143 :: 		void Motor_Stop()
;motor.h,145 :: 		Change_Duty(0);
	CLRF       FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;motor.h,146 :: 		Pwm1_Stop();
	CALL       _PWM1_Stop+0
;motor.h,147 :: 		PORTD.F0 =0;
	BCF        PORTD+0, 0
;motor.h,148 :: 		PORTD.F1 =0;
	BCF        PORTD+0, 1
;motor.h,149 :: 		Pwm2_Stop();
	CALL       _PWM2_Stop+0
;motor.h,150 :: 		PORTB.F1 =0;
	BCF        PORTB+0, 1
;motor.h,151 :: 		PORTB.F2 =0;
	BCF        PORTB+0, 2
;motor.h,154 :: 		motor_init_=0;
	CLRF       _motor_init_+0
;motor.h,156 :: 		}
L_end_Motor_Stop:
	RETURN
; end of _Motor_Stop

_Adc_Rd:

;adc.h,1 :: 		int Adc_Rd(char ch)                // Low 8 Channel ADC Read
;adc.h,3 :: 		int dat=0;                    // Save Adc
;adc.h,4 :: 		if ((ch>=0) && (ch<=3))       // CH0-CH3
	MOVLW      0
	SUBWF      FARG_Adc_Rd_ch+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd4
	MOVF       FARG_Adc_Rd_ch+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd4
L__Adc_Rd100:
;adc.h,5 :: 		TRISA |= (1<<ch);
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd112:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd113
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd112
L__Adc_Rd113:
	MOVF       R0+0, 0
	IORWF      TRISA+0, 1
	GOTO       L_Adc_Rd5
L_Adc_Rd4:
;adc.h,6 :: 		else if (ch==4)               // CH4
	MOVF       FARG_Adc_Rd_ch+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_Adc_Rd6
;adc.h,7 :: 		TRISA |= 0x20;
	BSF        TRISA+0, 5
	GOTO       L_Adc_Rd7
L_Adc_Rd6:
;adc.h,8 :: 		else if ((ch>=5) && (ch<=7))  // CH5-CH7
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd10
	MOVF       FARG_Adc_Rd_ch+0, 0
	SUBLW      7
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd10
L__Adc_Rd99:
;adc.h,9 :: 		TRISE |= (1<<(ch-5));
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd114:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd115
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd114
L__Adc_Rd115:
	MOVF       R0+0, 0
	IORWF      TRISE+0, 1
L_Adc_Rd10:
L_Adc_Rd7:
L_Adc_Rd5:
;adc.h,10 :: 		ANSEL |=(1<<ch);              // set Channel to Analog
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd116:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd117
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd116
L__Adc_Rd117:
	MOVF       R0+0, 0
	IORWF      ANSEL+0, 1
;adc.h,11 :: 		ADCON0 = (0xC1 + (ch*4));     // Select ADC Channel
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      193
	MOVWF      ADCON0+0
;adc.h,12 :: 		Delay_us(10);                 // Acquisiton delay
	MOVLW      6
	MOVWF      R13+0
L_Adc_Rd11:
	DECFSZ     R13+0, 1
	GOTO       L_Adc_Rd11
	NOP
;adc.h,13 :: 		ADCON0.GO=1;                  // Start conversion
	BSF        ADCON0+0, 1
;adc.h,14 :: 		while(ADCON0.GO);             // conversion done?
L_Adc_Rd12:
	BTFSS      ADCON0+0, 1
	GOTO       L_Adc_Rd13
	GOTO       L_Adc_Rd12
L_Adc_Rd13:
;adc.h,15 :: 		dat = (ADRESH*4)+(ADRESL/64); // Sum highbyte and lowbyte
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
L__Adc_Rd118:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd119
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd118
L__Adc_Rd119:
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;adc.h,16 :: 		return dat;                   // Return Value
;adc.h,17 :: 		}
L_end_Adc_Rd:
	RETURN
; end of _Adc_Rd

_isSafe:

;safedriving.h,9 :: 		short isSafe()   // функция возвращает 1 если препятствий нет.
;safedriving.h,11 :: 		float Distance=100; // в эту переменную будем сохранять
	MOVLW      0
	MOVWF      isSafe_Distance_L0+0
	MOVLW      0
	MOVWF      isSafe_Distance_L0+1
	MOVLW      72
	MOVWF      isSafe_Distance_L0+2
	MOVLW      133
	MOVWF      isSafe_Distance_L0+3
	CLRF       isSafe_GP2_L0+0
	CLRF       isSafe_GP2_L0+1
;safedriving.h,13 :: 		GP2=Adc_Rd(2);          // получаем данные от ацп со второго канала
	MOVLW      2
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isSafe_GP2_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafe_GP2_L0+1
;safedriving.h,14 :: 		if (GP2>90)             // проверяем допустимое ли значение хранится в gp2
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isSafe121
	MOVF       R0+0, 0
	SUBLW      90
L__isSafe121:
	BTFSC      STATUS+0, 0
	GOTO       L_isSafe14
;safedriving.h,16 :: 		Distance=(2914.0/(GP2+5))-1;  // переводим в сантиметры
	MOVLW      5
	ADDWF      isSafe_GP2_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafe_GP2_L0+1, 0
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
	MOVF       R0+0, 0
	MOVWF      isSafe_Distance_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafe_Distance_L0+1
	MOVF       R0+2, 0
	MOVWF      isSafe_Distance_L0+2
	MOVF       R0+3, 0
	MOVWF      isSafe_Distance_L0+3
;safedriving.h,17 :: 		}
L_isSafe14:
;safedriving.h,18 :: 		if(fabs(Distance-100)<1)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	MOVF       isSafe_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafe_Distance_L0+1, 0
	MOVWF      R0+1
	MOVF       isSafe_Distance_L0+2, 0
	MOVWF      R0+2
	MOVF       isSafe_Distance_L0+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FARG_fabs_d+0
	MOVF       R0+1, 0
	MOVWF      FARG_fabs_d+1
	MOVF       R0+2, 0
	MOVWF      FARG_fabs_d+2
	MOVF       R0+3, 0
	MOVWF      FARG_fabs_d+3
	CALL       _fabs+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_isSafe15
;safedriving.h,19 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isSafe
L_isSafe15:
;safedriving.h,21 :: 		return 0;
	CLRF       R0+0
;safedriving.h,23 :: 		}
L_end_isSafe:
	RETURN
; end of _isSafe

_SForward:

;a.h,53 :: 		short SForward()
;a.h,55 :: 		if(isSafe())
	CALL       _isSafe+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SForward17
;a.h,57 :: 		Motor_Init();
	CALL       _Motor_Init+0
;a.h,58 :: 		Change_Duty(255);
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,59 :: 		Motor_A_FWD();
	CALL       _Motor_A_FWD+0
;a.h,60 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,61 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_SForward18:
	DECFSZ     R13+0, 1
	GOTO       L_SForward18
	DECFSZ     R12+0, 1
	GOTO       L_SForward18
	DECFSZ     R11+0, 1
	GOTO       L_SForward18
	NOP
	NOP
;a.h,62 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_SForward
;a.h,63 :: 		}
L_SForward17:
;a.h,66 :: 		Map_update();
	CALL       _Map_update+0
;a.h,67 :: 		return 0;
	CLRF       R0+0
;a.h,69 :: 		}
L_end_SForward:
	RETURN
; end of _SForward

_comp:

;a.h,71 :: 		short comp(short d1,short d2)
;a.h,73 :: 		if(d1==d2) return 0;
	MOVF       FARG_comp_d1+0, 0
	XORWF      FARG_comp_d2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_comp20
	CLRF       R0+0
	GOTO       L_end_comp
L_comp20:
;a.h,74 :: 		if(d1>d2) return 1;
	MOVLW      128
	XORWF      FARG_comp_d2+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_comp21
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_comp
L_comp21:
;a.h,75 :: 		else return -1;
	MOVLW      255
	MOVWF      R0+0
;a.h,76 :: 		}
L_end_comp:
	RETURN
; end of _comp

_SMove:

;a.h,78 :: 		short SMove(short nx,short ny)
;a.h,84 :: 		ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
	MOVF       _cX+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_nx+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
	MOVF       R0+0, 0
	MOVWF      SMove_ax_L0+0
;a.h,86 :: 		ry==comp(cY,ny);
	MOVF       _cY+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
;a.h,87 :: 		if(ax==-1)      // в зависимости от результатов - определяем нужное направление
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove23
;a.h,88 :: 		nd=3+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove23:
;a.h,89 :: 		if(ax==0)
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove24
;a.h,90 :: 		switch(ry)
	GOTO       L_SMove25
;a.h,92 :: 		case -1:
L_SMove27:
;a.h,93 :: 		nd=1;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,94 :: 		break;
	GOTO       L_SMove26
;a.h,95 :: 		case 0:
L_SMove28:
;a.h,96 :: 		nd=cdirection;
	MOVF       _cdirection+0, 0
	MOVWF      SMove_nd_L0+0
;a.h,98 :: 		break;
	GOTO       L_SMove26
;a.h,99 :: 		case 1:
L_SMove29:
;a.h,100 :: 		nd=5;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,101 :: 		break;
	GOTO       L_SMove26
;a.h,103 :: 		}
L_SMove25:
	MOVF       SMove_ry_L0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_SMove27
	MOVF       SMove_ry_L0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove28
	MOVF       SMove_ry_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove29
L_SMove26:
L_SMove24:
;a.h,104 :: 		if(ax==1)
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove30
;a.h,105 :: 		nd=7-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove30:
;a.h,106 :: 		SRotare(cdirection,nd); // поворачиваемся
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVF       SMove_nd_L0+0, 0
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;a.h,109 :: 		if(isSafe()) // проверяем наличие препятсвий
	CALL       _isSafe+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove31
;a.h,111 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,112 :: 		Change_Duty(255); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,113 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,114 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,115 :: 		delay_ms(1000); // ждем пока приедем ---------------------------------------------------------------------
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_SMove32:
	DECFSZ     R13+0, 1
	GOTO       L_SMove32
	DECFSZ     R12+0, 1
	GOTO       L_SMove32
	DECFSZ     R11+0, 1
	GOTO       L_SMove32
	NOP
	NOP
;a.h,116 :: 		success=1;      // движение выполнено.
	MOVLW      1
	MOVWF      SMove_success_L0+0
;a.h,117 :: 		}
	GOTO       L_SMove33
L_SMove31:
;a.h,120 :: 		Map_update(); // обновляем карту (ставим туда стену)
	CALL       _Map_update+0
;a.h,121 :: 		success=0;    // движения не было
	CLRF       SMove_success_L0+0
;a.h,122 :: 		}
L_SMove33:
;a.h,124 :: 		return success; // сообщаем об успехе/неудаче
	MOVF       SMove_success_L0+0, 0
	MOVWF      R0+0
;a.h,125 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_Goal_Test:

;a.h,127 :: 		short Goal_Test(void) // проверка достижения цели
;a.h,130 :: 		if(findGoalCount==goalCount) return 1;
	MOVF       _findGoalCount+0, 0
	XORWF      _goalCount+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Goal_Test34
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_Goal_Test
L_Goal_Test34:
;a.h,133 :: 		return 0;// заглушка пока что
	CLRF       R0+0
;a.h,134 :: 		}
L_end_Goal_Test:
	RETURN
; end of _Goal_Test

_SRotare:

;a.h,140 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,143 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,144 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare36
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare36:
;a.h,145 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare37
;a.h,146 :: 		S_Right(r*45); // поворачиваемся по наименьшему пути
	MOVF       SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
	GOTO       L_SRotare38
L_SRotare37:
;a.h,148 :: 		S_Left(-r*45);
	MOVF       SRotare_r_L0+0, 0
	SUBLW      0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
L_SRotare38:
;a.h,149 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_Map_update:

;a.h,153 :: 		void Map_update()
;a.h,155 :: 		if(!isSafe()) // ставим стену в нужном направлении
	CALL       _isSafe+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Map_update39
;a.h,157 :: 		switch(cdirection)
	GOTO       L_Map_update40
;a.h,159 :: 		case UP:
L_Map_update42:
;a.h,160 :: 		result[cX][cY+1]=100;
	MOVF       _cX+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _result+0
	MOVWF      R2+0
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,161 :: 		break;
	GOTO       L_Map_update41
;a.h,162 :: 		case RUP:
L_Map_update43:
;a.h,163 :: 		result[cX+1][cY+1]=100;
	MOVF       _cX+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _result+0
	MOVWF      R2+0
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,164 :: 		break;
	GOTO       L_Map_update41
;a.h,165 :: 		case RIGHT:
L_Map_update44:
;a.h,166 :: 		result[cX+1][cY]=100;
	MOVF       _cX+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _result+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,167 :: 		break;
	GOTO       L_Map_update41
;a.h,168 :: 		case RDOWN:
L_Map_update45:
;a.h,169 :: 		result[cX+1][cY-1]=100;
	MOVF       _cX+0, 0
	ADDLW      1
	MOVWF      R3+0
	CLRF       R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _result+0
	MOVWF      R2+0
	MOVLW      1
	SUBWF      _cY+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,170 :: 		break;
	GOTO       L_Map_update41
;a.h,171 :: 		case DOWN:
L_Map_update46:
;a.h,172 :: 		result[cX-1][cY]=100;
	MOVLW      1
	SUBWF      _cX+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _result+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,173 :: 		break;
	GOTO       L_Map_update41
;a.h,174 :: 		case LDOWN:
L_Map_update47:
;a.h,175 :: 		result[cX-1][cY-1]=100;
	MOVLW      1
	SUBWF      _cX+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _result+0
	MOVWF      R2+0
	MOVLW      1
	SUBWF      _cY+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,176 :: 		break;
	GOTO       L_Map_update41
;a.h,177 :: 		case LEFT:
L_Map_update48:
;a.h,178 :: 		result[cX-1][cY]=100;
	MOVLW      1
	SUBWF      _cX+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _result+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,179 :: 		break;
	GOTO       L_Map_update41
;a.h,180 :: 		case LUP:
L_Map_update49:
;a.h,181 :: 		result[cX-1][cY+1]=100;
	MOVLW      1
	SUBWF      _cX+0, 0
	MOVWF      R3+0
	CLRF       R3+1
	BTFSS      STATUS+0, 0
	DECF       R3+1, 1
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _result+0
	MOVWF      R2+0
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FSR
	MOVLW      100
	MOVWF      INDF+0
;a.h,182 :: 		break;
	GOTO       L_Map_update41
;a.h,184 :: 		}
L_Map_update40:
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update42
	MOVF       _cdirection+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update43
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update44
	MOVF       _cdirection+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update45
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update46
	MOVF       _cdirection+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update47
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update48
	MOVF       _cdirection+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_Map_update49
L_Map_update41:
;a.h,185 :: 		}
L_Map_update39:
;a.h,186 :: 		}
L_end_Map_update:
	RETURN
; end of _Map_update

_Cost:

;a.h,188 :: 		int Cost(int cX,int cY)
;a.h,191 :: 		BSF IRP,9
	BSF        7, 9
;a.h,193 :: 		return h_evr[cX][cY]+H[cX][cY]+result[cX][cY];
	MOVF       FARG_Cost_cX+0, 0
	MOVWF      R4+0
	MOVF       FARG_Cost_cX+1, 0
	MOVWF      R4+1
	RLF        R4+0, 1
	RLF        R4+1, 1
	BCF        R4+0, 0
	MOVF       R4+0, 0
	ADDLW      _h_evr+0
	MOVWF      R0+0
	MOVF       FARG_Cost_cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R4+0, 0
	ADDLW      _H+0
	MOVWF      R0+0
	MOVF       FARG_Cost_cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R1+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSC      R1+0, 7
	MOVLW      255
	MOVWF      R2+1
	BTFSC      STATUS+0, 0
	INCF       R2+1, 1
	MOVLW      0
	BTFSC      INDF+0, 7
	MOVLW      255
	ADDWF      R2+1, 1
	MOVF       R4+0, 0
	ADDLW      _result+0
	MOVWF      R0+0
	MOVF       FARG_Cost_cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;a.h,197 :: 		}
L_end_Cost:
	RETURN
; end of _Cost

_mod:

;a.h,199 :: 		int mod(int x)
;a.h,201 :: 		if(x>=0) return x;
	MOVLW      128
	XORWF      FARG_mod_x+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__mod130
	MOVLW      0
	SUBWF      FARG_mod_x+0, 0
L__mod130:
	BTFSS      STATUS+0, 0
	GOTO       L_mod50
	MOVF       FARG_mod_x+0, 0
	MOVWF      R0+0
	MOVF       FARG_mod_x+1, 0
	MOVWF      R0+1
	GOTO       L_end_mod
L_mod50:
;a.h,202 :: 		else return -x;
	MOVF       FARG_mod_x+0, 0
	SUBLW      0
	MOVWF      R0+0
	MOVF       FARG_mod_x+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
;a.h,203 :: 		}
L_end_mod:
	RETURN
; end of _mod

_Brain:

;a.h,210 :: 		void Brain()
;a.h,213 :: 		short N=0; // кол-во найденных целей
	CLRF       Brain_N_L0+0
	CLRF       Brain_temp_L0+0
	CLRF       Brain_temp_L0+1
;a.h,217 :: 		for(i=0;i<WorldSize;i++)
	CLRF       Brain_i_L0+0
	CLRF       Brain_i_L0+1
L_Brain52:
	MOVLW      128
	XORWF      Brain_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain132
	MOVLW      2
	SUBWF      Brain_i_L0+0, 0
L__Brain132:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain53
;a.h,218 :: 		for(k=0;k<WorldSize;k++)
	CLRF       Brain_k_L0+0
	CLRF       Brain_k_L0+1
L_Brain55:
	MOVLW      128
	XORWF      Brain_k_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain133
	MOVLW      2
	SUBWF      Brain_k_L0+0, 0
L__Brain133:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain56
;a.h,219 :: 		h_evr[i][k]=2*WorldSize+1;
	MOVF       Brain_i_L0+0, 0
	MOVWF      R0+0
	MOVF       Brain_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _h_evr+0
	ADDWF      R0+0, 1
	MOVF       Brain_k_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      5
	MOVWF      INDF+0
;a.h,218 :: 		for(k=0;k<WorldSize;k++)
	INCF       Brain_k_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_k_L0+1, 1
;a.h,219 :: 		h_evr[i][k]=2*WorldSize+1;
	GOTO       L_Brain55
L_Brain56:
;a.h,217 :: 		for(i=0;i<WorldSize;i++)
	INCF       Brain_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_i_L0+1, 1
;a.h,219 :: 		h_evr[i][k]=2*WorldSize+1;
	GOTO       L_Brain52
L_Brain53:
;a.h,221 :: 		for(i=0;i<NumberOfGoals;i++)
	CLRF       Brain_i_L0+0
	CLRF       Brain_i_L0+1
L_Brain58:
	MOVLW      128
	XORWF      Brain_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain134
	MOVLW      30
	SUBWF      Brain_i_L0+0, 0
L__Brain134:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain59
;a.h,223 :: 		for(j=0;j<WorldSize;j++) // x
	CLRF       Brain_j_L0+0
	CLRF       Brain_j_L0+1
L_Brain61:
	MOVLW      128
	XORWF      Brain_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain135
	MOVLW      2
	SUBWF      Brain_j_L0+0, 0
L__Brain135:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain62
;a.h,224 :: 		for(k=0;k<WorldSize;k++) // y
	CLRF       Brain_k_L0+0
	CLRF       Brain_k_L0+1
L_Brain64:
	MOVLW      128
	XORWF      Brain_k_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain136
	MOVLW      2
	SUBWF      Brain_k_L0+0, 0
L__Brain136:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain65
;a.h,226 :: 		r=mod(goal[i][0]-j)+mod(goal[i][1]-k);
	MOVF       Brain_i_L0+0, 0
	MOVWF      R0+0
	MOVF       Brain_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _goal+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       Brain_j_L0+0, 0
	SUBWF      R0+0, 0
	MOVWF      FARG_mod_x+0
	MOVF       Brain_j_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_mod_x+1
	SUBWF      FARG_mod_x+1, 1
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	ADDWF      FARG_mod_x+1, 1
	CALL       _mod+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Brain+0
	MOVF       R0+1, 0
	MOVWF      FLOC__Brain+1
	MOVF       Brain_i_L0+0, 0
	MOVWF      R0+0
	MOVF       Brain_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _goal+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       Brain_k_L0+0, 0
	SUBWF      R0+0, 0
	MOVWF      FARG_mod_x+0
	MOVF       Brain_k_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_mod_x+1
	SUBWF      FARG_mod_x+1, 1
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	ADDWF      FARG_mod_x+1, 1
	CALL       _mod+0
	MOVF       R0+0, 0
	ADDWF      FLOC__Brain+0, 0
	MOVWF      R3+0
	MOVF       FLOC__Brain+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      Brain_r_L0+0
	MOVF       R3+1, 0
	MOVWF      Brain_r_L0+1
;a.h,227 :: 		if(r<h_evr[j][k]) h_evr[j][k]=r;
	MOVF       Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVF       Brain_j_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _h_evr+0
	ADDWF      R0+0, 1
	MOVF       Brain_k_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	BTFSC      R1+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain137
	MOVF       R1+0, 0
	SUBWF      R3+0, 0
L__Brain137:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain67
	MOVF       Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVF       Brain_j_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _h_evr+0
	ADDWF      R0+0, 1
	MOVF       Brain_k_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       Brain_r_L0+0, 0
	MOVWF      INDF+0
L_Brain67:
;a.h,224 :: 		for(k=0;k<WorldSize;k++) // y
	INCF       Brain_k_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_k_L0+1, 1
;a.h,228 :: 		}
	GOTO       L_Brain64
L_Brain65:
;a.h,223 :: 		for(j=0;j<WorldSize;j++) // x
	INCF       Brain_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_j_L0+1, 1
;a.h,228 :: 		}
	GOTO       L_Brain61
L_Brain62:
;a.h,221 :: 		for(i=0;i<NumberOfGoals;i++)
	INCF       Brain_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_i_L0+1, 1
;a.h,229 :: 		}
	GOTO       L_Brain58
L_Brain59:
;a.h,239 :: 		asm { BSF IRP,9}
	BSF        7, 9
;a.h,240 :: 		for(i=0;i<N;i++)
	CLRF       Brain_i_L0+0
	CLRF       Brain_i_L0+1
L_Brain68:
	MOVLW      128
	XORWF      Brain_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	BTFSC      Brain_N_L0+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain138
	MOVF       Brain_N_L0+0, 0
	SUBWF      Brain_i_L0+0, 0
L__Brain138:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain69
;a.h,241 :: 		for(k=0;k<m;k++)
	CLRF       Brain_k_L0+0
	CLRF       Brain_k_L0+1
L_Brain71:
	MOVLW      128
	XORWF      Brain_k_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Brain_m_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain139
	MOVF       Brain_m_L0+0, 0
	SUBWF      Brain_k_L0+0, 0
L__Brain139:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain72
;a.h,242 :: 		for(j=0;j<s;j++)
	CLRF       Brain_j_L0+0
	CLRF       Brain_j_L0+1
L_Brain74:
	MOVLW      128
	XORWF      Brain_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Brain_s_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain140
	MOVF       Brain_s_L0+0, 0
	SUBWF      Brain_j_L0+0, 0
L__Brain140:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain75
;a.h,244 :: 		temp=goal[i][0]-k+goal[i][1]-j;
	MOVF       Brain_i_L0+0, 0
	MOVWF      R4+0
	MOVF       Brain_i_L0+1, 0
	MOVWF      R4+1
	RLF        R4+0, 1
	RLF        R4+1, 1
	BCF        R4+0, 0
	MOVF       R4+0, 0
	ADDLW      _goal+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       Brain_k_L0+0, 0
	SUBWF      R0+0, 0
	MOVWF      R2+0
	MOVF       Brain_k_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R2+1
	SUBWF      R2+1, 1
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	ADDWF      R2+1, 1
	INCF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      R0+0, 7
	MOVLW      255
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       Brain_j_L0+0, 0
	SUBWF      R0+0, 0
	MOVWF      R2+0
	MOVF       Brain_j_L0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      Brain_temp_L0+0
	MOVF       R2+1, 0
	MOVWF      Brain_temp_L0+1
;a.h,245 :: 		if(temp<h_evr[i][j])
	MOVF       R4+0, 0
	ADDLW      _h_evr+0
	MOVWF      R0+0
	MOVF       Brain_j_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	BTFSC      R1+0, 7
	MOVLW      127
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain141
	MOVF       R1+0, 0
	SUBWF      R2+0, 0
L__Brain141:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain77
;a.h,246 :: 		h_evr[i][j]=temp; // упс надо придумать как и что , ибо это просто так работать не будет.
	MOVF       Brain_i_L0+0, 0
	MOVWF      R0+0
	MOVF       Brain_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVLW      _h_evr+0
	ADDWF      R0+0, 1
	MOVF       Brain_j_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       Brain_temp_L0+0, 0
	MOVWF      INDF+0
L_Brain77:
;a.h,242 :: 		for(j=0;j<s;j++)
	INCF       Brain_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_j_L0+1, 1
;a.h,247 :: 		}
	GOTO       L_Brain74
L_Brain75:
;a.h,241 :: 		for(k=0;k<m;k++)
	INCF       Brain_k_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_k_L0+1, 1
;a.h,247 :: 		}
	GOTO       L_Brain71
L_Brain72:
;a.h,240 :: 		for(i=0;i<N;i++)
	INCF       Brain_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Brain_i_L0+1, 1
;a.h,247 :: 		}
	GOTO       L_Brain68
L_Brain69:
;a.h,249 :: 		BCF IRP,9
	BCF        7, 9
;a.h,251 :: 		}
L_end_Brain:
	RETURN
; end of _Brain

_A_search:

;a.h,253 :: 		void A_search()
;a.h,258 :: 		if(Goal_test()) return;// достигли цели - закончили работу.
	CALL       _Goal_Test+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_A_search78
	GOTO       L_end_A_search
L_A_search78:
;a.h,259 :: 		if(H[cX][cY]==0)     // если это новое состояние
	MOVF       _cX+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _H+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_A_search79
;a.h,261 :: 		H[cX][cY]+=h[cX][cY];
	MOVF       _cX+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _H+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	ADDWF      R0+0, 1
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;a.h,262 :: 		}
L_A_search79:
;a.h,265 :: 		result[cX][cY]=1;// обновили карту
	MOVF       _cX+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _result+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      1
	MOVWF      INDF+0
;a.h,269 :: 		min=Cost(cX,cY+1);
	MOVF       _cX+0, 0
	MOVWF      FARG_Cost_cX+0
	MOVLW      0
	BTFSC      FARG_Cost_cX+0, 7
	MOVLW      255
	MOVWF      FARG_Cost_cX+1
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      FARG_Cost_cY+0
	CLRF       FARG_Cost_cY+1
	BTFSC      STATUS+0, 0
	INCF       FARG_Cost_cY+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      FARG_Cost_cY+1, 1
	CALL       _Cost+0
	MOVF       R0+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,270 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	MOVLW      255
	MOVWF      A_search_i_L0+0
	MOVLW      255
	MOVWF      A_search_i_L0+1
L_A_search80:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search143
	MOVF       A_search_i_L0+0, 0
	SUBLW      1
L__A_search143:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search81
;a.h,271 :: 		for(j=-1;j<=1;j++)
	MOVLW      255
	MOVWF      A_search_j_L0+0
	MOVLW      255
	MOVWF      A_search_j_L0+1
L_A_search83:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_j_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search144
	MOVF       A_search_j_L0+0, 0
	SUBLW      1
L__A_search144:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search84
;a.h,273 :: 		if(i==0 && j==0) continue;
	MOVLW      0
	XORWF      A_search_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search145
	MOVLW      0
	XORWF      A_search_i_L0+0, 0
L__A_search145:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search88
	MOVLW      0
	XORWF      A_search_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search146
	MOVLW      0
	XORWF      A_search_j_L0+0, 0
L__A_search146:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search88
L__A_search101:
	GOTO       L_A_search85
L_A_search88:
;a.h,274 :: 		temp=Cost(cX+i,cY+j);
	MOVF       A_search_i_L0+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_Cost_cX+0
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_i_L0+1, 0
	MOVWF      FARG_Cost_cX+1
	MOVF       A_search_j_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_Cost_cY+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_j_L0+1, 0
	MOVWF      FARG_Cost_cY+1
	CALL       _Cost+0
	MOVF       R0+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
;a.h,275 :: 		if(temp<min)
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      A_search_min_L0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search147
	MOVF       A_search_min_L0+0, 0
	SUBWF      R0+0, 0
L__A_search147:
	BTFSC      STATUS+0, 0
	GOTO       L_A_search89
;a.h,277 :: 		min=temp;
	MOVF       A_search_temp_L0+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       A_search_temp_L0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,278 :: 		cxx=i;
	MOVF       A_search_i_L0+0, 0
	MOVWF      A_search_cxx_L0+0
;a.h,279 :: 		cyy=j;
	MOVF       A_search_j_L0+0, 0
	MOVWF      A_search_cyy_L0+0
;a.h,280 :: 		}
L_A_search89:
;a.h,281 :: 		}
L_A_search85:
;a.h,271 :: 		for(j=-1;j<=1;j++)
	INCF       A_search_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_j_L0+1, 1
;a.h,281 :: 		}
	GOTO       L_A_search83
L_A_search84:
;a.h,270 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	INCF       A_search_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_i_L0+1, 1
;a.h,281 :: 		}
	GOTO       L_A_search80
L_A_search81:
;a.h,282 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
	MOVF       A_search_cxx_L0+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_SMove_nx+0
	MOVF       A_search_cyy_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_SMove_ny+0
	CALL       _SMove+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_A_search90
;a.h,284 :: 		cX+=cxx; // обновление текущих координат
	MOVF       A_search_cxx_L0+0, 0
	ADDWF      _cX+0, 1
;a.h,285 :: 		cY+=cyy;
	MOVF       A_search_cyy_L0+0, 0
	ADDWF      _cY+0, 1
;a.h,286 :: 		}
L_A_search90:
;a.h,288 :: 		}
L_end_A_search:
	RETURN
; end of _A_search

_SetGoals:

;a.h,290 :: 		void SetGoals()
;a.h,294 :: 		}
L_end_SetGoals:
	RETURN
; end of _SetGoals

_printing:

;MyProject.c,18 :: 		void printing(char * text)
;MyProject.c,20 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MyProject.c,21 :: 		Lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,22 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MyProject.c,23 :: 		Lcd_out(1,1,text);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       FARG_printing_text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,25 :: 		}
L_end_printing:
	RETURN
; end of _printing

_startup:

;MyProject.c,29 :: 		void startup()
;MyProject.c,156 :: 		}
L_end_startup:
	RETURN
; end of _startup

_main:

;MyProject.c,189 :: 		void main()
;MyProject.c,196 :: 		char output[50]="If You see this text robot is Okey:)";
;MyProject.c,197 :: 		char delimiter[5]=" ";
;MyProject.c,198 :: 		char some_byte = 0x0A;
;MyProject.c,199 :: 		char i=0;
	CLRF       main_i_L0+0
;MyProject.c,200 :: 		ANSEL  = 0;                     // Configure AN pins as digital
	CLRF       ANSEL+0
;MyProject.c,201 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;MyProject.c,203 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,204 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main91:
	DECFSZ     R13+0, 1
	GOTO       L_main91
	DECFSZ     R12+0, 1
	GOTO       L_main91
	DECFSZ     R11+0, 1
	GOTO       L_main91
	NOP
;MyProject.c,206 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,207 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,208 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,210 :: 		while (1)
L_main92:
;MyProject.c,214 :: 		while (UART1_Data_Ready())
L_main94:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main95
;MyProject.c,216 :: 		i='0';
	MOVLW      48
	MOVWF      main_i_L0+0
;MyProject.c,218 :: 		i = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      main_i_L0+0
;MyProject.c,238 :: 		if(UART1_Tx_Idle())
	CALL       _UART1_Tx_Idle+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main96
;MyProject.c,240 :: 		UART1_Write(i);       // and send data via UART
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,241 :: 		}
	GOTO       L_main97
L_main96:
;MyProject.c,243 :: 		printing("Error!");
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_printing_text+0
	CALL       _printing+0
L_main97:
;MyProject.c,244 :: 		}
	GOTO       L_main94
L_main95:
;MyProject.c,245 :: 		Delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main98:
	DECFSZ     R13+0, 1
	GOTO       L_main98
	DECFSZ     R12+0, 1
	GOTO       L_main98
	DECFSZ     R11+0, 1
	GOTO       L_main98
	NOP
	NOP
;MyProject.c,246 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;MyProject.c,247 :: 		}
	GOTO       L_main92
;MyProject.c,248 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
