
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

_Backward:

;motor.h,114 :: 		void Backward(char speed)
;motor.h,116 :: 		Motor_Init();
	CALL       _Motor_Init+0
;motor.h,117 :: 		Change_Duty(speed);
	MOVF       FARG_Backward_speed+0, 0
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;motor.h,118 :: 		Motor_A_BWD();
	CALL       _Motor_A_BWD+0
;motor.h,119 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;motor.h,120 :: 		}
L_end_Backward:
	RETURN
; end of _Backward

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
L__Adc_Rd60:
;adc.h,5 :: 		TRISA |= (1<<ch);
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd74:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd75
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd74
L__Adc_Rd75:
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
L__Adc_Rd59:
;adc.h,9 :: 		TRISE |= (1<<(ch-5));
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd76:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd77
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd76
L__Adc_Rd77:
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
L__Adc_Rd78:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd79
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd78
L__Adc_Rd79:
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
L__Adc_Rd80:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd81
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd80
L__Adc_Rd81:
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

;safedriving.h,9 :: 		short isSafe()   // функция возвращает расстояние до объекта в сантиметрах.
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
	GOTO       L__isSafe83
	MOVF       R0+0, 0
	SUBLW      90
L__isSafe83:
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
;safedriving.h,18 :: 		return Distance;
	MOVF       isSafe_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafe_Distance_L0+1, 0
	MOVWF      R0+1
	MOVF       isSafe_Distance_L0+2, 0
	MOVWF      R0+2
	MOVF       isSafe_Distance_L0+3, 0
	MOVWF      R0+3
	CALL       _Double2Int+0
;safedriving.h,20 :: 		}
L_end_isSafe:
	RETURN
; end of _isSafe

_isMetall:

;a.h,51 :: 		short isMetall()
;a.h,54 :: 		m=Adc_Rd(1);
	MOVLW      1
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isMetall_m_L0+0
;a.h,55 :: 		if(m>0 && m<50)
	MOVLW      128
	XORLW      0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall17
	MOVLW      128
	XORWF      isMetall_m_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      50
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall17
L__isMetall61:
;a.h,56 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isMetall
L_isMetall17:
;a.h,58 :: 		return 0;
	CLRF       R0+0
;a.h,59 :: 		}
L_end_isMetall:
	RETURN
; end of _isMetall

_comp:

;a.h,61 :: 		short comp(short d1,short d2)
;a.h,63 :: 		if(d1==d2) return 0; // операнды равны
	MOVF       FARG_comp_d1+0, 0
	XORWF      FARG_comp_d2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_comp19
	CLRF       R0+0
	GOTO       L_end_comp
L_comp19:
;a.h,64 :: 		if(d1>d2) return 1; // первый больше второго
	MOVLW      128
	XORWF      FARG_comp_d2+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_comp20
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_comp
L_comp20:
;a.h,65 :: 		else return -1; // первый меньше второго
	MOVLW      255
	MOVWF      R0+0
;a.h,66 :: 		}
L_end_comp:
	RETURN
; end of _comp

_SMove:

;a.h,69 :: 		short SMove(short nx,short ny)
;a.h,75 :: 		ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
	MOVF       _cX+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_nx+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
	MOVF       R0+0, 0
	MOVWF      SMove_ax_L0+0
;a.h,77 :: 		ry==comp(cY,ny);
	MOVF       _cY+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
;a.h,78 :: 		if(ax==-1)      // в зависимости от результатов - определяем нужное направление
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove22
;a.h,79 :: 		nd=3+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove22:
;a.h,80 :: 		if(ax==0)
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove23
;a.h,81 :: 		switch(ry)
	GOTO       L_SMove24
;a.h,83 :: 		case -1:
L_SMove26:
;a.h,84 :: 		nd=1;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,85 :: 		break;
	GOTO       L_SMove25
;a.h,86 :: 		case 0:
L_SMove27:
;a.h,87 :: 		nd=cdirection;
	MOVF       _cdirection+0, 0
	MOVWF      SMove_nd_L0+0
;a.h,89 :: 		break;
	GOTO       L_SMove25
;a.h,90 :: 		case 1:
L_SMove28:
;a.h,91 :: 		nd=5;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,92 :: 		break;
	GOTO       L_SMove25
;a.h,94 :: 		}
L_SMove24:
	MOVF       SMove_ry_L0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_SMove26
	MOVF       SMove_ry_L0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove27
	MOVF       SMove_ry_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove28
L_SMove25:
L_SMove23:
;a.h,95 :: 		if(ax==1)
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove29
;a.h,96 :: 		nd=7-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove29:
;a.h,97 :: 		SRotare(cdirection,nd); // поворачиваемся
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVF       SMove_nd_L0+0, 0
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;a.h,100 :: 		if(isSafe()==100) // проверяем наличие препятсвий
	CALL       _isSafe+0
	MOVF       R0+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_SMove30
;a.h,102 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,103 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,104 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,105 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,106 :: 		delay_ms(DELAY_TIME_20); // ждем пока приедем
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_SMove31:
	DECFSZ     R13+0, 1
	GOTO       L_SMove31
	DECFSZ     R12+0, 1
	GOTO       L_SMove31
	DECFSZ     R11+0, 1
	GOTO       L_SMove31
	NOP
	NOP
;a.h,107 :: 		return 1;      // движение выполнено.
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_SMove
;a.h,108 :: 		}
L_SMove30:
;a.h,111 :: 		d=isSafe();
	CALL       _isSafe+0
	MOVF       R0+0, 0
	MOVWF      SMove_d_L0+0
;a.h,112 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,113 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,114 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,115 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,116 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	CLRF       SMove_i_L0+0
L_SMove33:
	MOVLW      5
	SUBWF      SMove_d_L0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      0
	BTFSC      SMove_d_L0+0, 7
	MOVLW      255
	ADDWF      R1+1, 1
	MOVLW      128
	BTFSC      SMove_i_L0+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove87
	MOVF       R1+0, 0
	SUBWF      SMove_i_L0+0, 0
L__SMove87:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove34
;a.h,117 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_SMove36:
	DECFSZ     R13+0, 1
	GOTO       L_SMove36
	DECFSZ     R12+0, 1
	GOTO       L_SMove36
	DECFSZ     R11+0, 1
	GOTO       L_SMove36
	NOP
	NOP
;a.h,116 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	INCF       SMove_i_L0+0, 1
;a.h,117 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	GOTO       L_SMove33
L_SMove34:
;a.h,118 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,120 :: 		if(isMetall()) // проверяем металл ли это
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove37
;a.h,123 :: 		}
	GOTO       L_SMove38
L_SMove37:
;a.h,124 :: 		else{;}
L_SMove38:
;a.h,126 :: 		Motor_Init();
	CALL       _Motor_Init+0
;a.h,127 :: 		Change_Duty(SPEED);
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,128 :: 		Motor_A_BWD();
	CALL       _Motor_A_BWD+0
;a.h,129 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,130 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	CLRF       SMove_i_L0+0
L_SMove39:
	MOVLW      5
	SUBWF      SMove_d_L0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVLW      0
	BTFSC      SMove_d_L0+0, 7
	MOVLW      255
	ADDWF      R1+1, 1
	MOVLW      128
	BTFSC      SMove_i_L0+0, 7
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove88
	MOVF       R1+0, 0
	SUBWF      SMove_i_L0+0, 0
L__SMove88:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove40
;a.h,131 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_SMove42:
	DECFSZ     R13+0, 1
	GOTO       L_SMove42
	DECFSZ     R12+0, 1
	GOTO       L_SMove42
	DECFSZ     R11+0, 1
	GOTO       L_SMove42
	NOP
	NOP
;a.h,130 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	INCF       SMove_i_L0+0, 1
;a.h,131 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	GOTO       L_SMove39
L_SMove40:
;a.h,134 :: 		return 0;    // движения не было
	CLRF       R0+0
;a.h,136 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_SRotare:

;a.h,141 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,144 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,145 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare43
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare43:
;a.h,146 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare44
;a.h,147 :: 		S_Right(r*45); // поворачиваемся по наименьшему пути
	MOVF       SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
	GOTO       L_SRotare45
L_SRotare44:
;a.h,149 :: 		S_Left(-r*45);
	MOVF       SRotare_r_L0+0, 0
	SUBLW      0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
L_SRotare45:
;a.h,150 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_Cost:

;a.h,154 :: 		int Cost(int cX,int cY)
;a.h,157 :: 		return 1+H[cX][cY];//+result[cX][cY];
	MOVLW      3
	MOVWF      R2+0
	MOVF       FARG_Cost_cX+0, 0
	MOVWF      R0+0
	MOVF       FARG_Cost_cX+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__Cost91:
	BTFSC      STATUS+0, 2
	GOTO       L__Cost92
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Cost91
L__Cost92:
	MOVLW      _H+0
	ADDWF      R0+0, 1
	MOVF       FARG_Cost_cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      0
	BTFSC      INDF+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
;a.h,159 :: 		}
L_end_Cost:
	RETURN
; end of _Cost

_A_search:

;a.h,161 :: 		void A_search()
;a.h,166 :: 		if(findGoalCount==goalCount) return;// проверили все состояние - достигли цели - закончили работу.
	MOVF       _findGoalCount+0, 0
	XORWF      _goalCount+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_A_search46
	GOTO       L_end_A_search
L_A_search46:
;a.h,167 :: 		if(H[cX][cY]==0)     // если это новое состояние
	MOVLW      3
	MOVWF      R1+0
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__A_search94:
	BTFSC      STATUS+0, 2
	GOTO       L__A_search95
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__A_search94
L__A_search95:
	MOVLW      _H+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_A_search47
;a.h,169 :: 		H[cX][cY]+=1;
	MOVLW      3
	MOVWF      R1+0
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__A_search96:
	BTFSC      STATUS+0, 2
	GOTO       L__A_search97
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__A_search96
L__A_search97:
	MOVLW      _H+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	INCF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;a.h,170 :: 		}
L_A_search47:
;a.h,172 :: 		min=Cost(cX,cY+1);
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
;a.h,173 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	MOVLW      255
	MOVWF      A_search_i_L0+0
	MOVLW      255
	MOVWF      A_search_i_L0+1
L_A_search48:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search98
	MOVF       A_search_i_L0+0, 0
	SUBLW      1
L__A_search98:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search49
;a.h,174 :: 		for(j=-1;j<=1;j++)
	MOVLW      255
	MOVWF      A_search_j_L0+0
	MOVLW      255
	MOVWF      A_search_j_L0+1
L_A_search51:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_j_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search99
	MOVF       A_search_j_L0+0, 0
	SUBLW      1
L__A_search99:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search52
;a.h,176 :: 		if(i==0 && j==0) continue;
	MOVLW      0
	XORWF      A_search_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search100
	MOVLW      0
	XORWF      A_search_i_L0+0, 0
L__A_search100:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search56
	MOVLW      0
	XORWF      A_search_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search101
	MOVLW      0
	XORWF      A_search_j_L0+0, 0
L__A_search101:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search56
L__A_search62:
	GOTO       L_A_search53
L_A_search56:
;a.h,177 :: 		temp=Cost(cX+i,cY+j);
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
;a.h,178 :: 		if(temp<min) // имеющее минимальную стоимость
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      A_search_min_L0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search102
	MOVF       A_search_min_L0+0, 0
	SUBWF      R0+0, 0
L__A_search102:
	BTFSC      STATUS+0, 0
	GOTO       L_A_search57
;a.h,180 :: 		min=temp;
	MOVF       A_search_temp_L0+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       A_search_temp_L0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,181 :: 		cxx=i;
	MOVF       A_search_i_L0+0, 0
	MOVWF      A_search_cxx_L0+0
;a.h,182 :: 		cyy=j;
	MOVF       A_search_j_L0+0, 0
	MOVWF      A_search_cyy_L0+0
;a.h,183 :: 		}
L_A_search57:
;a.h,184 :: 		}
L_A_search53:
;a.h,174 :: 		for(j=-1;j<=1;j++)
	INCF       A_search_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_j_L0+1, 1
;a.h,184 :: 		}
	GOTO       L_A_search51
L_A_search52:
;a.h,173 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	INCF       A_search_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_i_L0+1, 1
;a.h,184 :: 		}
	GOTO       L_A_search48
L_A_search49:
;a.h,185 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
	MOVF       A_search_cxx_L0+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_SMove_nx+0
	MOVF       A_search_cyy_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_SMove_ny+0
	CALL       _SMove+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_A_search58
;a.h,187 :: 		cX+=cxx; // обновление текущих координат
	MOVF       A_search_cxx_L0+0, 0
	ADDWF      _cX+0, 1
;a.h,188 :: 		cY+=cyy;
	MOVF       A_search_cyy_L0+0, 0
	ADDWF      _cY+0, 1
;a.h,189 :: 		} // если перемещения не произошло, то робот вряд ли выберет тот же путь
L_A_search58:
;a.h,192 :: 		}
L_end_A_search:
	RETURN
; end of _A_search

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

_main:

;MyProject.c,28 :: 		void main()
;MyProject.c,31 :: 		A_search();
	CALL       _A_search+0
;MyProject.c,32 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
