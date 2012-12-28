
_Motor_Init:

;motor.h,32 :: 		void Motor_Init()
;motor.h,34 :: 		if (motor_init_==0)            // Первый раз?
	MOVF       _motor_init_+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Motor_Init0
;motor.h,36 :: 		motor_init_=1;               // статус
	MOVLW      1
	MOVWF      _motor_init_+0
;motor.h,37 :: 		ANSELH.F0=0;                 // RB1 ==> цифровой ввод/вывод
	BCF        ANSELH+0, 0
;motor.h,38 :: 		ANSELH.F2=0;                 // RB2 ==> цифровой ввод/вывод
	BCF        ANSELH+0, 2
;motor.h,39 :: 		TRISB.F1=0;                  // Мотор B 2A
	BCF        TRISB+0, 1
;motor.h,40 :: 		TRISB.F2=0;                  // Мотор B 2B
	BCF        TRISB+0, 2
;motor.h,41 :: 		TRISD.F0=0;                  // Мотор A 1A
	BCF        TRISD+0, 0
;motor.h,42 :: 		TRISD.F1=0;                  // Мотор A 1B
	BCF        TRISD+0, 1
;motor.h,43 :: 		Pwm1_Init(5000);             // Инициализация мощности 1E
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;motor.h,44 :: 		Pwm2_Init(5000);             // Инициализация мощности 2E
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;motor.h,45 :: 		}
L_Motor_Init0:
;motor.h,46 :: 		}
L_end_Motor_Init:
	RETURN
; end of _Motor_Init

_Change_Duty:

;motor.h,52 :: 		void Change_Duty(char speed)
;motor.h,54 :: 		if (speed != motor_duty_)      // скорость не изменилась?
	MOVF       FARG_Change_Duty_speed+0, 0
	XORWF      _motor_duty_+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Change_Duty1
;motor.h,56 :: 		motor_duty_=speed;            // сохраняем старую скорость
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      _motor_duty_+0
;motor.h,57 :: 		PWM1_Set_Duty(speed);      // Мотор A
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;motor.h,58 :: 		PWM2_Set_Duty(speed);      // Мотор B
	MOVF       FARG_Change_Duty_speed+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;motor.h,59 :: 		}
L_Change_Duty1:
;motor.h,60 :: 		}
L_end_Change_Duty:
	RETURN
; end of _Change_Duty

_Motor_A_FWD:

;motor.h,64 :: 		void Motor_A_FWD()
;motor.h,66 :: 		Pwm1_Start();
	CALL       _PWM1_Start+0
;motor.h,67 :: 		PORTD.F0 =0;
	BCF        PORTD+0, 0
;motor.h,68 :: 		PORTD.F1 =1;
	BSF        PORTD+0, 1
;motor.h,69 :: 		}
L_end_Motor_A_FWD:
	RETURN
; end of _Motor_A_FWD

_Motor_B_FWD:

;motor.h,73 :: 		void Motor_B_FWD()
;motor.h,75 :: 		Pwm2_Start();
	CALL       _PWM2_Start+0
;motor.h,76 :: 		PORTB.F1 =0;
	BCF        PORTB+0, 1
;motor.h,77 :: 		PORTB.F2 =1;
	BSF        PORTB+0, 2
;motor.h,78 :: 		}
L_end_Motor_B_FWD:
	RETURN
; end of _Motor_B_FWD

_Motor_A_BWD:

;motor.h,82 :: 		void Motor_A_BWD()
;motor.h,84 :: 		Pwm1_Start();
	CALL       _PWM1_Start+0
;motor.h,85 :: 		PORTD.F0 =1;
	BSF        PORTD+0, 0
;motor.h,86 :: 		PORTD.F1 =0;
	BCF        PORTD+0, 1
;motor.h,87 :: 		}
L_end_Motor_A_BWD:
	RETURN
; end of _Motor_A_BWD

_Motor_B_BWD:

;motor.h,91 :: 		void Motor_B_BWD()
;motor.h,93 :: 		Pwm2_Start();
	CALL       _PWM2_Start+0
;motor.h,94 :: 		PORTB.F1 =1;
	BSF        PORTB+0, 1
;motor.h,95 :: 		PORTB.F2 =0;
	BCF        PORTB+0, 2
;motor.h,96 :: 		}
L_end_Motor_B_BWD:
	RETURN
; end of _Motor_B_BWD

_S_Right:

;motor.h,100 :: 		void S_Right(char speed)
;motor.h,102 :: 		Motor_Init();
	CALL       _Motor_Init+0
;motor.h,103 :: 		Change_Duty(speed);
	MOVF       FARG_S_Right_speed+0, 0
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;motor.h,104 :: 		Motor_A_FWD();
	CALL       _Motor_A_FWD+0
;motor.h,105 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;motor.h,106 :: 		}
L_end_S_Right:
	RETURN
; end of _S_Right

_S_Left:

;motor.h,110 :: 		void S_Left(char speed)
;motor.h,112 :: 		Motor_Init();
	CALL       _Motor_Init+0
;motor.h,113 :: 		Change_Duty(speed);
	MOVF       FARG_S_Left_speed+0, 0
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;motor.h,114 :: 		Motor_A_BWD();
	CALL       _Motor_A_BWD+0
;motor.h,115 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;motor.h,116 :: 		}
L_end_S_Left:
	RETURN
; end of _S_Left

_Motor_Stop:

;motor.h,119 :: 		void Motor_Stop()
;motor.h,121 :: 		Change_Duty(0);
	CLRF       FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;motor.h,122 :: 		Pwm1_Stop();
	CALL       _PWM1_Stop+0
;motor.h,123 :: 		PORTD.F0 =0;
	BCF        PORTD+0, 0
;motor.h,124 :: 		PORTD.F1 =0;
	BCF        PORTD+0, 1
;motor.h,125 :: 		Pwm2_Stop();
	CALL       _PWM2_Stop+0
;motor.h,126 :: 		PORTB.F1 =0;
	BCF        PORTB+0, 1
;motor.h,127 :: 		PORTB.F2 =0;
	BCF        PORTB+0, 2
;motor.h,128 :: 		motor_init_=0;
	CLRF       _motor_init_+0
;motor.h,130 :: 		}
L_end_Motor_Stop:
	RETURN
; end of _Motor_Stop

_Adc_Rd:

;adc.h,1 :: 		int Adc_Rd(char ch)                // читаются нижние 8 каналов АЦП
;adc.h,3 :: 		int dat=0;                    // сюда будут сохранятся данные
;adc.h,4 :: 		if ((ch>=0) && (ch<=3))       // CH0-CH3
	MOVLW      0
	SUBWF      FARG_Adc_Rd_ch+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd4
	MOVF       FARG_Adc_Rd_ch+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_Adc_Rd4
L__Adc_Rd86:
;adc.h,5 :: 		TRISA |= (1<<ch);
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd99:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd100
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd99
L__Adc_Rd100:
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
L__Adc_Rd85:
;adc.h,9 :: 		TRISE |= (1<<(ch-5));
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd101:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd102
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd101
L__Adc_Rd102:
	MOVF       R0+0, 0
	IORWF      TRISE+0, 1
L_Adc_Rd10:
L_Adc_Rd7:
L_Adc_Rd5:
;adc.h,10 :: 		ANSEL |=(1<<ch);              // устанавливаем канал на аналоговый ввод
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd103:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd104
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd103
L__Adc_Rd104:
	MOVF       R0+0, 0
	IORWF      ANSEL+0, 1
;adc.h,11 :: 		ADCON0 = (0xC1 + (ch*4));     // выбираем канал АЦП
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      193
	MOVWF      ADCON0+0
;adc.h,12 :: 		Delay_us(10);                 // ожидание устойчивого режима
	MOVLW      6
	MOVWF      R13+0
L_Adc_Rd11:
	DECFSZ     R13+0, 1
	GOTO       L_Adc_Rd11
	NOP
;adc.h,13 :: 		ADCON0.GO=1;                  // запуск преобразования
	BSF        ADCON0+0, 1
;adc.h,14 :: 		while(ADCON0.GO);             // преобразование закончено?
L_Adc_Rd12:
	BTFSS      ADCON0+0, 1
	GOTO       L_Adc_Rd13
	GOTO       L_Adc_Rd12
L_Adc_Rd13:
;adc.h,15 :: 		dat = (ADRESH*4)+(ADRESL/64); // суммируются две части слова
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
L__Adc_Rd105:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd106
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd105
L__Adc_Rd106:
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;adc.h,16 :: 		return dat;                   // возврат значения
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
	GOTO       L__isSafe108
	MOVF       R0+0, 0
	SUBLW      90
L__isSafe108:
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

;a.h,54 :: 		short isMetall()
;a.h,57 :: 		m=Adc_Rd(1);
	MOVLW      1
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isMetall_m_L0+0
;a.h,58 :: 		if(m>0 && m<50)
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
L__isMetall87:
;a.h,59 :: 		return 1;    // если объект металлический возвращаем единицу
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isMetall
L_isMetall17:
;a.h,61 :: 		return 0;
	CLRF       R0+0
;a.h,62 :: 		}
L_end_isMetall:
	RETURN
; end of _isMetall

_comp:

;a.h,64 :: 		short comp(short d1,short d2)
;a.h,66 :: 		if(d1==d2) return 0; // операнды равны
	MOVF       FARG_comp_d1+0, 0
	XORWF      FARG_comp_d2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_comp19
	CLRF       R0+0
	GOTO       L_end_comp
L_comp19:
;a.h,67 :: 		if(d1>d2) return 1; // первый больше второго
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
;a.h,68 :: 		else return -1; // первый меньше второго
	MOVLW      255
	MOVWF      R0+0
;a.h,69 :: 		}
L_end_comp:
	RETURN
; end of _comp

_SMove:

;a.h,72 :: 		short SMove(short nx,short ny)
;a.h,78 :: 		ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
	MOVF       _cX+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_nx+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
	MOVF       R0+0, 0
	MOVWF      SMove_ax_L0+0
;a.h,80 :: 		ry==comp(cY,ny);
	MOVF       _cY+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
;a.h,81 :: 		if(ax==-1)      // в зависимости от результатов - определяем нужное направление
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove22
;a.h,82 :: 		nd=3+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove22:
;a.h,83 :: 		if(ax==0)
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove23
;a.h,84 :: 		switch(ry)
	GOTO       L_SMove24
;a.h,86 :: 		case -1:
L_SMove26:
;a.h,87 :: 		nd=1;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,88 :: 		break;
	GOTO       L_SMove25
;a.h,89 :: 		case 0:
L_SMove27:
;a.h,90 :: 		nd=cdirection;
	MOVF       _cdirection+0, 0
	MOVWF      SMove_nd_L0+0
;a.h,92 :: 		break;
	GOTO       L_SMove25
;a.h,93 :: 		case 1:
L_SMove28:
;a.h,94 :: 		nd=5;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,95 :: 		break;
	GOTO       L_SMove25
;a.h,97 :: 		}
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
;a.h,98 :: 		if(ax==1)
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove29
;a.h,99 :: 		nd=7-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove29:
;a.h,100 :: 		SRotare(cdirection,nd); // поворачиваемся
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVF       SMove_nd_L0+0, 0
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;a.h,103 :: 		if(isSafe()==100) // проверяем наличие препятсвий
	CALL       _isSafe+0
	MOVF       R0+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_SMove30
;a.h,105 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,106 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,107 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,108 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,109 :: 		if(cdirection%2==0)
	MOVLW      1
	ANDWF      _cdirection+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove31
;a.h,110 :: 		delay_ms(DELAY_TIME_20*1414/1000); // ждем пока приедем
	MOVLW      15
	MOVWF      R11+0
	MOVLW      89
	MOVWF      R12+0
	MOVLW      174
	MOVWF      R13+0
L_SMove32:
	DECFSZ     R13+0, 1
	GOTO       L_SMove32
	DECFSZ     R12+0, 1
	GOTO       L_SMove32
	DECFSZ     R11+0, 1
	GOTO       L_SMove32
	NOP
	GOTO       L_SMove33
L_SMove31:
;a.h,112 :: 		delay_ms(DELAY_TIME_20); // ждем пока приедем
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_SMove34:
	DECFSZ     R13+0, 1
	GOTO       L_SMove34
	DECFSZ     R12+0, 1
	GOTO       L_SMove34
	DECFSZ     R11+0, 1
	GOTO       L_SMove34
	NOP
	NOP
L_SMove33:
;a.h,113 :: 		findGoalCount++;
	INCF       _findGoalCount+0, 1
;a.h,114 :: 		return 1;      // движение выполнено.
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_SMove
;a.h,115 :: 		}
L_SMove30:
;a.h,118 :: 		d=isSafe();
	CALL       _isSafe+0
	MOVF       R0+0, 0
	MOVWF      SMove_d_L0+0
;a.h,119 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,120 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,121 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,122 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,123 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	CLRF       SMove_i_L0+0
L_SMove36:
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
	GOTO       L__SMove112
	MOVF       R1+0, 0
	SUBWF      SMove_i_L0+0, 0
L__SMove112:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove37
;a.h,124 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_SMove39:
	DECFSZ     R13+0, 1
	GOTO       L_SMove39
	DECFSZ     R12+0, 1
	GOTO       L_SMove39
	DECFSZ     R11+0, 1
	GOTO       L_SMove39
	NOP
	NOP
;a.h,123 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	INCF       SMove_i_L0+0, 1
;a.h,124 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	GOTO       L_SMove36
L_SMove37:
;a.h,125 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,126 :: 		H[cX+cxx][cY+cyy]++;   // обновляем состояние, раз там что-то есть, туда ехать не надо
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      R3+0
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	MOVWF      R3+1
	BTFSC      STATUS+0, 0
	INCF       R3+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      R3+1, 1
	MOVLW      3
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__SMove113:
	BTFSC      STATUS+0, 2
	GOTO       L__SMove114
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__SMove113
L__SMove114:
	MOVF       R0+0, 0
	ADDLW      _H+0
	MOVWF      R2+0
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	MOVWF      R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       R0+0, 1
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;a.h,127 :: 		findGoalCount++;
	INCF       _findGoalCount+0, 1
;a.h,128 :: 		if(isMetall()) // проверяем металл ли это
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove40
;a.h,130 :: 		Metals[MetallObjects][0]=cX+cxx; // записываем координаты
	MOVF       _MetallObjects+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _Metals+0
	MOVWF      FSR
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      INDF+0
;a.h,131 :: 		Metals[MetallObjects][1]=cY+cyy;
	MOVF       _MetallObjects+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _Metals+0
	ADDWF      R0+0, 1
	INCF       R0+0, 0
	MOVWF      FSR
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      INDF+0
;a.h,132 :: 		MetallObjects++;
	INCF       _MetallObjects+0, 1
;a.h,133 :: 		}
L_SMove40:
;a.h,135 :: 		Motor_Init();
	CALL       _Motor_Init+0
;a.h,136 :: 		Change_Duty(SPEED);
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,137 :: 		Motor_A_BWD();
	CALL       _Motor_A_BWD+0
;a.h,138 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,139 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	CLRF       SMove_i_L0+0
L_SMove41:
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
	GOTO       L__SMove115
	MOVF       R1+0, 0
	SUBWF      SMove_i_L0+0, 0
L__SMove115:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove42
;a.h,140 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_SMove44:
	DECFSZ     R13+0, 1
	GOTO       L_SMove44
	DECFSZ     R12+0, 1
	GOTO       L_SMove44
	DECFSZ     R11+0, 1
	GOTO       L_SMove44
	NOP
	NOP
;a.h,139 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	INCF       SMove_i_L0+0, 1
;a.h,140 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	GOTO       L_SMove41
L_SMove42:
;a.h,142 :: 		return 0;    // движения не было
	CLRF       R0+0
;a.h,144 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_SRotare:

;a.h,149 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,152 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,153 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare45
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare45:
;a.h,154 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare46
;a.h,155 :: 		S_Right(r*45); // поворачиваемся по наименьшему пути
	MOVF       SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
	GOTO       L_SRotare47
L_SRotare46:
;a.h,157 :: 		S_Left(-r*45);
	MOVF       SRotare_r_L0+0, 0
	SUBLW      0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
L_SRotare47:
;a.h,158 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_A_search:

;a.h,162 :: 		void A_search()
;a.h,166 :: 		if(findGoalCount==NumberOfGoals) return;// проверили все состояния - достигли цели - закончили работу.
	MOVF       _findGoalCount+0, 0
	XORLW      63
	BTFSS      STATUS+0, 2
	GOTO       L_A_search48
	GOTO       L_end_A_search
L_A_search48:
;a.h,167 :: 		if(H[cX][cY]==0)     // если это новое состояние
	MOVLW      3
	MOVWF      R1+0
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__A_search118:
	BTFSC      STATUS+0, 2
	GOTO       L__A_search119
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__A_search118
L__A_search119:
	MOVLW      _H+0
	ADDWF      R0+0, 1
	MOVF       _cY+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_A_search49
;a.h,169 :: 		H[cX][cY]+=1;
	MOVLW      3
	MOVWF      R1+0
	MOVF       _cX+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__A_search120:
	BTFSC      STATUS+0, 2
	GOTO       L__A_search121
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__A_search120
L__A_search121:
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
L_A_search49:
;a.h,172 :: 		min=H[cX][cY+1]+h_evr[cX][cY+1];
	MOVLW      3
	MOVWF      R0+0
	MOVF       _cX+0, 0
	MOVWF      R4+0
	MOVF       R0+0, 0
L__A_search122:
	BTFSC      STATUS+0, 2
	GOTO       L__A_search123
	RLF        R4+0, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__A_search122
L__A_search123:
	MOVF       R4+0, 0
	ADDLW      _H+0
	MOVWF      R0+0
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      R2+0
	CLRF       R2+1
	BTFSC      STATUS+0, 0
	INCF       R2+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      R2+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R4+0, 0
	ADDLW      _h_evr+0
	MOVWF      R0+0
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R1+0, 0
	MOVWF      A_search_min_L0+0
	MOVLW      0
	BTFSC      R1+0, 7
	MOVLW      255
	MOVWF      A_search_min_L0+1
	BTFSC      STATUS+0, 0
	INCF       A_search_min_L0+1, 1
	MOVLW      0
	BTFSC      INDF+0, 7
	MOVLW      255
	ADDWF      A_search_min_L0+1, 1
;a.h,173 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	MOVLW      255
	MOVWF      A_search_i_L0+0
	MOVLW      255
	MOVWF      A_search_i_L0+1
L_A_search50:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search124
	MOVF       A_search_i_L0+0, 0
	SUBLW      1
L__A_search124:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search51
;a.h,174 :: 		for(j=-1;j<=1;j++)
	MOVLW      255
	MOVWF      A_search_j_L0+0
	MOVLW      255
	MOVWF      A_search_j_L0+1
L_A_search53:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_j_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search125
	MOVF       A_search_j_L0+0, 0
	SUBLW      1
L__A_search125:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search54
;a.h,176 :: 		if(i==0 && j==0) continue;
	MOVLW      0
	XORWF      A_search_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search126
	MOVLW      0
	XORWF      A_search_i_L0+0, 0
L__A_search126:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search58
	MOVLW      0
	XORWF      A_search_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search127
	MOVLW      0
	XORWF      A_search_j_L0+0, 0
L__A_search127:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search58
L__A_search88:
	GOTO       L_A_search55
L_A_search58:
;a.h,177 :: 		temp=H[cX+i][cY+j]+h_evr[cX+i][cY+j];
	MOVF       A_search_i_L0+0, 0
	ADDWF      _cX+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_i_L0+1, 0
	MOVWF      R1+1
	MOVLW      3
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      R4+0
	MOVF       R1+1, 0
	MOVWF      R4+1
	MOVF       R0+0, 0
L__A_search128:
	BTFSC      STATUS+0, 2
	GOTO       L__A_search129
	RLF        R4+0, 1
	RLF        R4+1, 1
	BCF        R4+0, 0
	ADDLW      255
	GOTO       L__A_search128
L__A_search129:
	MOVF       R4+0, 0
	ADDLW      _H+0
	MOVWF      R0+0
	MOVF       A_search_j_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_j_L0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R4+0, 0
	ADDLW      _h_evr+0
	MOVWF      R0+0
	MOVF       R2+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      R1+0, 1
	MOVLW      0
	BTFSC      R1+0, 7
	MOVLW      255
	MOVWF      R1+1
	BTFSC      STATUS+0, 0
	INCF       R1+1, 1
	MOVLW      0
	BTFSC      INDF+0, 7
	MOVLW      255
	ADDWF      R1+1, 1
	MOVF       R1+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R1+1, 0
	MOVWF      A_search_temp_L0+1
;a.h,178 :: 		if(temp<min) // имеющее минимальную стоимость
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_min_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search130
	MOVF       A_search_min_L0+0, 0
	SUBWF      R1+0, 0
L__A_search130:
	BTFSC      STATUS+0, 0
	GOTO       L_A_search59
;a.h,180 :: 		min=temp;
	MOVF       A_search_temp_L0+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       A_search_temp_L0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,181 :: 		cxx=i;
	MOVF       A_search_i_L0+0, 0
	MOVWF      _cxx+0
;a.h,182 :: 		cyy=j;
	MOVF       A_search_j_L0+0, 0
	MOVWF      _cyy+0
;a.h,183 :: 		}
L_A_search59:
;a.h,184 :: 		}
L_A_search55:
;a.h,174 :: 		for(j=-1;j<=1;j++)
	INCF       A_search_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_j_L0+1, 1
;a.h,184 :: 		}
	GOTO       L_A_search53
L_A_search54:
;a.h,173 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	INCF       A_search_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_i_L0+1, 1
;a.h,184 :: 		}
	GOTO       L_A_search50
L_A_search51:
;a.h,185 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_SMove_nx+0
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_SMove_ny+0
	CALL       _SMove+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_A_search60
;a.h,187 :: 		cX+=cxx; // обновление текущих координат
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 1
;a.h,188 :: 		cY+=cyy;
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 1
;a.h,189 :: 		} // если перемещения не произошло, то робот вряд ли выберет тот же путь
L_A_search60:
;a.h,192 :: 		}
L_end_A_search:
	RETURN
; end of _A_search

_mod:

;a.h,195 :: 		short mod(short x)
;a.h,197 :: 		if(x>=0) return x;
	MOVLW      128
	XORWF      FARG_mod_x+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mod61
	MOVF       FARG_mod_x+0, 0
	MOVWF      R0+0
	GOTO       L_end_mod
L_mod61:
;a.h,198 :: 		else return -x;
	MOVF       FARG_mod_x+0, 0
	SUBLW      0
	MOVWF      R0+0
;a.h,199 :: 		}
L_end_mod:
	RETURN
; end of _mod

_Brain:

;a.h,201 :: 		void Brain()
;a.h,206 :: 		for(x=0;x<WorldSize;x++)
	CLRF       Brain_x_L0+0
L_Brain63:
	MOVLW      128
	XORWF      Brain_x_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain64
;a.h,208 :: 		for(y=0;y<WorldSize;y++)
	CLRF       Brain_y_L0+0
L_Brain66:
	MOVLW      128
	XORWF      Brain_y_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain67
;a.h,210 :: 		if(H[x][y]!=0) continue; // если значение не нулевое- значит мы там были и всё нашли.
	MOVLW      3
	MOVWF      R1+0
	MOVF       Brain_x_L0+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Brain133:
	BTFSC      STATUS+0, 2
	GOTO       L__Brain134
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Brain133
L__Brain134:
	MOVLW      _H+0
	ADDWF      R0+0, 1
	MOVF       Brain_y_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_Brain69
	GOTO       L_Brain68
L_Brain69:
;a.h,211 :: 		for(j=0;j<WorldSize;j++) // x
	CLRF       Brain_j_L0+0
L_Brain70:
	MOVLW      128
	XORWF      Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain71
;a.h,212 :: 		for(k=0;k<WorldSize;k++) // y
	CLRF       Brain_k_L0+0
L_Brain73:
	MOVLW      128
	XORWF      Brain_k_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain74
;a.h,214 :: 		r=mod(x-j)+mod(y-k);  // манхетенское расстояние
	MOVF       Brain_j_L0+0, 0
	SUBWF      Brain_x_L0+0, 0
	MOVWF      FARG_mod_x+0
	CALL       _mod+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Brain+0
	MOVF       Brain_k_L0+0, 0
	SUBWF      Brain_y_L0+0, 0
	MOVWF      FARG_mod_x+0
	CALL       _mod+0
	MOVF       R0+0, 0
	ADDWF      FLOC__Brain+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      Brain_r_L0+0
;a.h,215 :: 		if(r<h_evr[j][k]) h_evr[j][k]=r; // если есть цель ближе - запишем расстояние до неё
	MOVLW      3
	MOVWF      R1+0
	MOVF       Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Brain135:
	BTFSC      STATUS+0, 2
	GOTO       L__Brain136
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Brain135
L__Brain136:
	MOVLW      _h_evr+0
	ADDWF      R0+0, 1
	MOVF       Brain_k_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      128
	XORWF      R2+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      INDF+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain76
	MOVLW      3
	MOVWF      R1+0
	MOVF       Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Brain137:
	BTFSC      STATUS+0, 2
	GOTO       L__Brain138
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Brain137
L__Brain138:
	MOVLW      _h_evr+0
	ADDWF      R0+0, 1
	MOVF       Brain_k_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       Brain_r_L0+0, 0
	MOVWF      INDF+0
L_Brain76:
;a.h,212 :: 		for(k=0;k<WorldSize;k++) // y
	INCF       Brain_k_L0+0, 1
;a.h,216 :: 		}
	GOTO       L_Brain73
L_Brain74:
;a.h,211 :: 		for(j=0;j<WorldSize;j++) // x
	INCF       Brain_j_L0+0, 1
;a.h,216 :: 		}
	GOTO       L_Brain70
L_Brain71:
;a.h,217 :: 		}
L_Brain68:
;a.h,208 :: 		for(y=0;y<WorldSize;y++)
	INCF       Brain_y_L0+0, 1
;a.h,217 :: 		}
	GOTO       L_Brain66
L_Brain67:
;a.h,206 :: 		for(x=0;x<WorldSize;x++)
	INCF       Brain_x_L0+0, 1
;a.h,218 :: 		}
	GOTO       L_Brain63
L_Brain64:
;a.h,219 :: 		}
L_end_Brain:
	RETURN
; end of _Brain

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
;MyProject.c,31 :: 		for(j=0;j<WorldSize;j++) // x
	CLRF       main_j_L0+0
L_main77:
	MOVLW      128
	XORWF      main_j_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main78
;MyProject.c,32 :: 		for(k=0;k<WorldSize;k++) // y
	CLRF       main_k_L0+0
L_main80:
	MOVLW      128
	XORWF      main_k_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main81
;MyProject.c,34 :: 		h_evr[j][k]=2*WorldSize; // задаем ненулевые значения эвристики.
	MOVLW      3
	MOVWF      R1+0
	MOVF       main_j_L0+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__main141:
	BTFSC      STATUS+0, 2
	GOTO       L__main142
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__main141
L__main142:
	MOVLW      _h_evr+0
	ADDWF      R0+0, 1
	MOVF       main_k_L0+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVLW      16
	MOVWF      INDF+0
;MyProject.c,32 :: 		for(k=0;k<WorldSize;k++) // y
	INCF       main_k_L0+0, 1
;MyProject.c,36 :: 		}
	GOTO       L_main80
L_main81:
;MyProject.c,31 :: 		for(j=0;j<WorldSize;j++) // x
	INCF       main_j_L0+0, 1
;MyProject.c,36 :: 		}
	GOTO       L_main77
L_main78:
;MyProject.c,37 :: 		while(findGoalCount<NumberOfGoals)
L_main83:
	MOVLW      128
	XORWF      _findGoalCount+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      63
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main84
;MyProject.c,39 :: 		Brain();
	CALL       _Brain+0
;MyProject.c,40 :: 		A_search();
	CALL       _A_search+0
;MyProject.c,41 :: 		}
	GOTO       L_main83
L_main84:
;MyProject.c,42 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
