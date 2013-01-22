
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
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;motor.h,44 :: 		Pwm2_Init(5000);             // Инициализация мощности 2E
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
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
L__Adc_Rd155:
;adc.h,5 :: 		TRISA |= (1<<ch);
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd168:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd169
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd168
L__Adc_Rd169:
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
L__Adc_Rd154:
;adc.h,9 :: 		TRISE |= (1<<(ch-5));
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd170:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd171
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd170
L__Adc_Rd171:
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
L__Adc_Rd172:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd173
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd172
L__Adc_Rd173:
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
	MOVLW      16
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
L__Adc_Rd174:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd175
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd174
L__Adc_Rd175:
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

_isSafeY:

;safedriving.h,14 :: 		short isSafeY()   // функция возвращает расстояние до объекта в сантиметрах по оси Y.
;safedriving.h,16 :: 		float Distance=100; // в эту переменную будем сохранять
	MOVLW      0
	MOVWF      isSafeY_Distance_L0+0
	MOVLW      0
	MOVWF      isSafeY_Distance_L0+1
	MOVLW      72
	MOVWF      isSafeY_Distance_L0+2
	MOVLW      133
	MOVWF      isSafeY_Distance_L0+3
	CLRF       isSafeY_GP2_L0+0
	CLRF       isSafeY_GP2_L0+1
;safedriving.h,18 :: 		GP2=Adc_Rd(channelY);          // получаем данные от ацп со второго канала
	MOVLW      2
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isSafeY_GP2_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeY_GP2_L0+1
;safedriving.h,19 :: 		if (GP2>90)             // проверяем допустимое ли значение хранится в gp2
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isSafeY177
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeY177:
	BTFSC      STATUS+0, 0
	GOTO       L_isSafeY14
;safedriving.h,21 :: 		Distance=(2914.0/(GP2+5))-1;  // переводим в сантиметры
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
	MOVF       R0+0, 0
	MOVWF      isSafeY_Distance_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeY_Distance_L0+1
	MOVF       R0+2, 0
	MOVWF      isSafeY_Distance_L0+2
	MOVF       R0+3, 0
	MOVWF      isSafeY_Distance_L0+3
;safedriving.h,22 :: 		}
L_isSafeY14:
;safedriving.h,23 :: 		return Distance;
	MOVF       isSafeY_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeY_Distance_L0+1, 0
	MOVWF      R0+1
	MOVF       isSafeY_Distance_L0+2, 0
	MOVWF      R0+2
	MOVF       isSafeY_Distance_L0+3, 0
	MOVWF      R0+3
	CALL       _Double2Int+0
;safedriving.h,25 :: 		}
L_end_isSafeY:
	RETURN
; end of _isSafeY

_isSafeX:

;safedriving.h,27 :: 		short isSafeX()   // функция возвращает расстояние до объекта в сантиметрах по оси Y.
;safedriving.h,29 :: 		float Distance=100; // в эту переменную будем сохранять
	MOVLW      0
	MOVWF      isSafeX_Distance_L0+0
	MOVLW      0
	MOVWF      isSafeX_Distance_L0+1
	MOVLW      72
	MOVWF      isSafeX_Distance_L0+2
	MOVLW      133
	MOVWF      isSafeX_Distance_L0+3
	CLRF       isSafeX_GP2_L0+0
	CLRF       isSafeX_GP2_L0+1
;safedriving.h,31 :: 		GP2=Adc_Rd(channelX);          // получаем данные от ацп со второго канала
	MOVLW      3
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isSafeX_GP2_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeX_GP2_L0+1
;safedriving.h,32 :: 		if (GP2>90)             // проверяем допустимое ли значение хранится в gp2
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isSafeX179
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeX179:
	BTFSC      STATUS+0, 0
	GOTO       L_isSafeX15
;safedriving.h,34 :: 		Distance=(2914.0/(GP2+5))-1;  // переводим в сантиметры
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
	MOVF       R0+0, 0
	MOVWF      isSafeX_Distance_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeX_Distance_L0+1
	MOVF       R0+2, 0
	MOVWF      isSafeX_Distance_L0+2
	MOVF       R0+3, 0
	MOVWF      isSafeX_Distance_L0+3
;safedriving.h,35 :: 		}
L_isSafeX15:
;safedriving.h,36 :: 		return Distance;
	MOVF       isSafeX_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeX_Distance_L0+1, 0
	MOVWF      R0+1
	MOVF       isSafeX_Distance_L0+2, 0
	MOVWF      R0+2
	MOVF       isSafeX_Distance_L0+3, 0
	MOVWF      R0+3
	CALL       _Double2Int+0
;safedriving.h,38 :: 		}
L_end_isSafeX:
	RETURN
; end of _isSafeX

_strConstCpy:

;a.h,56 :: 		void strConstCpy (const char *source, char *dest) {
;a.h,57 :: 		while (*source) *dest++ = *source++;
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
;a.h,58 :: 		*dest = 0;
	MOVF       FARG_strConstCpy_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,59 :: 		}
L_end_strConstCpy:
	RETURN
; end of _strConstCpy

_stradd:

;a.h,60 :: 		void stradd(char *source, char *dest){
;a.h,61 :: 		while (*dest++);
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
;a.h,62 :: 		*dest--;
	DECF       FARG_stradd_dest+0, 1
;a.h,63 :: 		while (*source) *dest++ = *source++;
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
;a.h,64 :: 		*dest = 0;
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,65 :: 		}
L_end_stradd:
	RETURN
; end of _stradd

_getParam:

;a.h,67 :: 		int getParam(const char * p,int x,int y)
;a.h,69 :: 		char temp=0;
;a.h,70 :: 		strConstCpy(p,string); // копируем код команды
	MOVF       FARG_getParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_getParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;a.h,71 :: 		IntToStr (x,strint);
	MOVF       FARG_getParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,72 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,73 :: 		IntToStr (y,strint);
	MOVF       FARG_getParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,74 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,75 :: 		stradd("   ",string);
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,76 :: 		UART1_Write_Text(string);
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;a.h,77 :: 		while(1) if(UART1_Data_Ready()) // ждем ответ
L_getParam22:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_getParam24
;a.h,79 :: 		temp=UART1_Read();
	CALL       _UART1_Read+0
;a.h,80 :: 		return temp;
	MOVLW      0
	MOVWF      R0+1
	GOTO       L_end_getParam
;a.h,81 :: 		}
L_getParam24:
	GOTO       L_getParam22
;a.h,82 :: 		}
L_end_getParam:
	RETURN
; end of _getParam

_setParam:

;a.h,84 :: 		void setParam(const char * p,int x,int y,int value)
;a.h,86 :: 		char temp=0;
;a.h,87 :: 		strConstCpy(p,string); // копируем код команды
	MOVF       FARG_setParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_setParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;a.h,88 :: 		IntToStr (x,strint);
	MOVF       FARG_setParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,89 :: 		stradd(strint,string); // копируем первую координату
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,90 :: 		IntToStr (y,strint);
	MOVF       FARG_setParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,91 :: 		stradd(strint,string); // копируем вторую координату
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,92 :: 		IntToStr (value,strint);
	MOVF       FARG_setParam_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,93 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,94 :: 		stradd("   ",string);    // дописываем символ пробела в конец строки
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,95 :: 		UART1_Write_Text(string); // отправляем данные
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;a.h,96 :: 		while(1) if(UART1_Data_Ready()) // ждем ответ
L_setParam25:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_setParam27
;a.h,98 :: 		temp=UART1_Read();
	CALL       _UART1_Read+0
;a.h,99 :: 		return;
	GOTO       L_end_setParam
;a.h,100 :: 		}
L_setParam27:
	GOTO       L_setParam25
;a.h,101 :: 		}
L_end_setParam:
	RETURN
; end of _setParam

_isMetall:

;a.h,105 :: 		short isMetall()
;a.h,108 :: 		m=Adc_Rd(1);
	MOVLW      1
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isMetall_m_L0+0
;a.h,109 :: 		if(m>0 && m<50)
	MOVLW      128
	XORLW      0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall30
	MOVLW      128
	XORWF      isMetall_m_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      50
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall30
L__isMetall156:
;a.h,110 :: 		return 1;    // если объект металлический возвращаем единицу
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isMetall
L_isMetall30:
;a.h,112 :: 		return 0;
	CLRF       R0+0
;a.h,113 :: 		}
L_end_isMetall:
	RETURN
; end of _isMetall

_comp:

;a.h,115 :: 		short comp(int d1,int d2)
;a.h,117 :: 		if(d1==d2) return 0; // операнды равны
	MOVF       FARG_comp_d1+1, 0
	XORWF      FARG_comp_d2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp186
	MOVF       FARG_comp_d2+0, 0
	XORWF      FARG_comp_d1+0, 0
L__comp186:
	BTFSS      STATUS+0, 2
	GOTO       L_comp32
	CLRF       R0+0
	GOTO       L_end_comp
L_comp32:
;a.h,118 :: 		if(d1>d2) return 1; // первый больше второго
	MOVLW      128
	XORWF      FARG_comp_d2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp187
	MOVF       FARG_comp_d1+0, 0
	SUBWF      FARG_comp_d2+0, 0
L__comp187:
	BTFSC      STATUS+0, 0
	GOTO       L_comp33
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_comp
L_comp33:
;a.h,119 :: 		else return -1; // первый меньше второго
	MOVLW      255
	MOVWF      R0+0
;a.h,120 :: 		}
L_end_comp:
	RETURN
; end of _comp

_SMove:

;a.h,123 :: 		short SMove(int nx,int ny)
;a.h,126 :: 		enum direction nd=1; // относительное направление движения
	MOVLW      1
	MOVWF      SMove_nd_L0+0
	MOVLW      1
	MOVWF      SMove_ax_L0+0
	MOVLW      1
	MOVWF      SMove_ry_L0+0
	CLRF       SMove_isMove_L0+0
;a.h,130 :: 		ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
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
;a.h,131 :: 		ry==comp(cY,ny);
	MOVF       _cY+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       _cY+1, 0
	MOVWF      FARG_comp_d1+1
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_comp_d2+0
	MOVF       FARG_SMove_ny+1, 0
	MOVWF      FARG_comp_d2+1
	CALL       _comp+0
;a.h,133 :: 		if(ax==-1)  // если нам нужно направо
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove35
;a.h,134 :: 		nd=RIGHT+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove35:
;a.h,135 :: 		if(ax==0)    // смещаться по оси х не нужно
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove36
;a.h,136 :: 		switch(ry)
	GOTO       L_SMove37
;a.h,138 :: 		case -1: //
L_SMove39:
;a.h,139 :: 		nd=UP;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,140 :: 		break;
	GOTO       L_SMove38
;a.h,141 :: 		case 0:
L_SMove40:
;a.h,142 :: 		nd=ZEROD;
	MOVLW      9
	MOVWF      SMove_nd_L0+0
;a.h,144 :: 		break;
	GOTO       L_SMove38
;a.h,145 :: 		case 1:
L_SMove41:
;a.h,146 :: 		nd=DOWN;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,147 :: 		break;
	GOTO       L_SMove38
;a.h,149 :: 		}
L_SMove37:
	MOVF       SMove_ry_L0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_SMove39
	MOVF       SMove_ry_L0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove40
	MOVF       SMove_ry_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove41
L_SMove38:
L_SMove36:
;a.h,150 :: 		if(ax==1)   // если нам нужно налево
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove42
;a.h,151 :: 		nd=LEFT-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove42:
;a.h,154 :: 		switch (nd)
	GOTO       L_SMove43
;a.h,156 :: 		case 1:
L_SMove45:
;a.h,157 :: 		case UP:
L_SMove46:
;a.h,158 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove47
;a.h,160 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,161 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,162 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,163 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,164 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove48:
	DECFSZ     R13+0, 1
	GOTO       L_SMove48
	DECFSZ     R12+0, 1
	GOTO       L_SMove48
	DECFSZ     R11+0, 1
	GOTO       L_SMove48
;a.h,165 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,166 :: 		Correct();
	CALL       _Correct+0
;a.h,167 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,168 :: 		}
L_SMove47:
;a.h,169 :: 		break;
	GOTO       L_SMove44
;a.h,170 :: 		case 2:
L_SMove49:
;a.h,171 :: 		case RUP:
L_SMove50:
;a.h,172 :: 		if(isSafeY()>2 && isSafeX()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove53
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove53
L__SMove157:
;a.h,174 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,175 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove54:
	DECFSZ     R13+0, 1
	GOTO       L_SMove54
	DECFSZ     R12+0, 1
	GOTO       L_SMove54
	DECFSZ     R11+0, 1
	GOTO       L_SMove54
	NOP
;a.h,176 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,177 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,178 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,179 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,180 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove55:
	DECFSZ     R13+0, 1
	GOTO       L_SMove55
	DECFSZ     R12+0, 1
	GOTO       L_SMove55
	DECFSZ     R11+0, 1
	GOTO       L_SMove55
;a.h,181 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,182 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,183 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove56:
	DECFSZ     R13+0, 1
	GOTO       L_SMove56
	DECFSZ     R12+0, 1
	GOTO       L_SMove56
	DECFSZ     R11+0, 1
	GOTO       L_SMove56
	NOP
;a.h,184 :: 		Correct();
	CALL       _Correct+0
;a.h,185 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,186 :: 		}
L_SMove53:
;a.h,187 :: 		break;
	GOTO       L_SMove44
;a.h,188 :: 		case 3:
L_SMove57:
;a.h,189 :: 		case RIGHT:
L_SMove58:
;a.h,190 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove59
;a.h,192 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,193 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,194 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,195 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,196 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove60:
	DECFSZ     R13+0, 1
	GOTO       L_SMove60
	DECFSZ     R12+0, 1
	GOTO       L_SMove60
	DECFSZ     R11+0, 1
	GOTO       L_SMove60
;a.h,197 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,198 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,199 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove61:
	DECFSZ     R13+0, 1
	GOTO       L_SMove61
	DECFSZ     R12+0, 1
	GOTO       L_SMove61
	DECFSZ     R11+0, 1
	GOTO       L_SMove61
	NOP
;a.h,200 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,201 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,202 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,203 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,204 :: 		delay_ms(3*DELAY_TIME_1sm); // ждем пока приедем  -------------------------------------------------------------------------------------------------
	MOVLW      6
	MOVWF      R11+0
	MOVLW      104
	MOVWF      R12+0
	MOVLW      23
	MOVWF      R13+0
L_SMove62:
	DECFSZ     R13+0, 1
	GOTO       L_SMove62
	DECFSZ     R12+0, 1
	GOTO       L_SMove62
	DECFSZ     R11+0, 1
	GOTO       L_SMove62
	NOP
	NOP
;a.h,205 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,206 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,207 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove63:
	DECFSZ     R13+0, 1
	GOTO       L_SMove63
	DECFSZ     R12+0, 1
	GOTO       L_SMove63
	DECFSZ     R11+0, 1
	GOTO       L_SMove63
	NOP
;a.h,208 :: 		Correct();
	CALL       _Correct+0
;a.h,209 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,210 :: 		}
L_SMove59:
;a.h,211 :: 		break;
	GOTO       L_SMove44
;a.h,212 :: 		case 4:
L_SMove64:
;a.h,213 :: 		case RDOWN:
L_SMove65:
;a.h,214 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove66
;a.h,216 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,217 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove67:
	DECFSZ     R13+0, 1
	GOTO       L_SMove67
	DECFSZ     R12+0, 1
	GOTO       L_SMove67
	DECFSZ     R11+0, 1
	GOTO       L_SMove67
	NOP
;a.h,218 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,219 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,220 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,221 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,222 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove68:
	DECFSZ     R13+0, 1
	GOTO       L_SMove68
	DECFSZ     R12+0, 1
	GOTO       L_SMove68
	DECFSZ     R11+0, 1
	GOTO       L_SMove68
;a.h,223 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,224 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,225 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove69:
	DECFSZ     R13+0, 1
	GOTO       L_SMove69
	DECFSZ     R12+0, 1
	GOTO       L_SMove69
	DECFSZ     R11+0, 1
	GOTO       L_SMove69
	NOP
;a.h,226 :: 		Correct();
	CALL       _Correct+0
;a.h,227 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,228 :: 		}
L_SMove66:
;a.h,229 :: 		break;
	GOTO       L_SMove44
;a.h,230 :: 		case 5:
L_SMove70:
;a.h,231 :: 		case DOWN:
L_SMove71:
;a.h,232 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,233 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,234 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,235 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,236 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove72:
	DECFSZ     R13+0, 1
	GOTO       L_SMove72
	DECFSZ     R12+0, 1
	GOTO       L_SMove72
	DECFSZ     R11+0, 1
	GOTO       L_SMove72
;a.h,237 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,238 :: 		Motor_Init();
	CALL       _Motor_Init+0
;a.h,239 :: 		Correct();
	CALL       _Correct+0
;a.h,240 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,241 :: 		break;
	GOTO       L_SMove44
;a.h,242 :: 		case 6:
L_SMove73:
;a.h,243 :: 		case LDOWN:
L_SMove74:
;a.h,244 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,245 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove75:
	DECFSZ     R13+0, 1
	GOTO       L_SMove75
	DECFSZ     R12+0, 1
	GOTO       L_SMove75
	DECFSZ     R11+0, 1
	GOTO       L_SMove75
	NOP
;a.h,246 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,247 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,248 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,249 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,250 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove76:
	DECFSZ     R13+0, 1
	GOTO       L_SMove76
	DECFSZ     R12+0, 1
	GOTO       L_SMove76
	DECFSZ     R11+0, 1
	GOTO       L_SMove76
;a.h,251 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,252 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,253 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove77:
	DECFSZ     R13+0, 1
	GOTO       L_SMove77
	DECFSZ     R12+0, 1
	GOTO       L_SMove77
	DECFSZ     R11+0, 1
	GOTO       L_SMove77
	NOP
;a.h,254 :: 		Correct();
	CALL       _Correct+0
;a.h,255 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,256 :: 		break;
	GOTO       L_SMove44
;a.h,257 :: 		case 7:
L_SMove78:
;a.h,258 :: 		case LEFT:
L_SMove79:
;a.h,259 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,260 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,261 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,262 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,263 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove80:
	DECFSZ     R13+0, 1
	GOTO       L_SMove80
	DECFSZ     R12+0, 1
	GOTO       L_SMove80
	DECFSZ     R11+0, 1
	GOTO       L_SMove80
;a.h,264 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,265 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,266 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,267 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,268 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,269 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,270 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,271 :: 		delay_ms(3*DELAY_TIME_1sm); // ждем пока приедем ----------------------------------------------------------------------------------------------
	MOVLW      6
	MOVWF      R11+0
	MOVLW      104
	MOVWF      R12+0
	MOVLW      23
	MOVWF      R13+0
L_SMove82:
	DECFSZ     R13+0, 1
	GOTO       L_SMove82
	DECFSZ     R12+0, 1
	GOTO       L_SMove82
	DECFSZ     R11+0, 1
	GOTO       L_SMove82
	NOP
	NOP
;a.h,272 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,273 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,274 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,275 :: 		Correct();
	CALL       _Correct+0
;a.h,276 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,277 :: 		break;
	GOTO       L_SMove44
;a.h,278 :: 		case 8:
L_SMove84:
;a.h,279 :: 		case LUP:
L_SMove85:
;a.h,280 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove86
;a.h,282 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,283 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove87:
	DECFSZ     R13+0, 1
	GOTO       L_SMove87
	DECFSZ     R12+0, 1
	GOTO       L_SMove87
	DECFSZ     R11+0, 1
	GOTO       L_SMove87
	NOP
;a.h,284 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,285 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,286 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,287 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,288 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove88:
	DECFSZ     R13+0, 1
	GOTO       L_SMove88
	DECFSZ     R12+0, 1
	GOTO       L_SMove88
	DECFSZ     R11+0, 1
	GOTO       L_SMove88
;a.h,289 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,290 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,291 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove89:
	DECFSZ     R13+0, 1
	GOTO       L_SMove89
	DECFSZ     R12+0, 1
	GOTO       L_SMove89
	DECFSZ     R11+0, 1
	GOTO       L_SMove89
	NOP
;a.h,292 :: 		Correct();
	CALL       _Correct+0
;a.h,293 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,294 :: 		}
L_SMove86:
;a.h,295 :: 		break;
	GOTO       L_SMove44
;a.h,296 :: 		case 9:
L_SMove90:
;a.h,297 :: 		case ZEROD:
L_SMove91:
;a.h,298 :: 		getParam("zerod",1,1);
	MOVLW      ?lstr_3_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_3_MyProject+0)
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
;a.h,299 :: 		break;
	GOTO       L_SMove44
;a.h,300 :: 		}
L_SMove43:
	MOVF       SMove_nd_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove45
	MOVF       SMove_nd_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove46
	MOVF       SMove_nd_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_SMove49
	MOVF       SMove_nd_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_SMove50
	MOVF       SMove_nd_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SMove57
	MOVF       SMove_nd_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SMove58
	MOVF       SMove_nd_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_SMove64
	MOVF       SMove_nd_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_SMove65
	MOVF       SMove_nd_L0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SMove70
	MOVF       SMove_nd_L0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SMove71
	MOVF       SMove_nd_L0+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_SMove73
	MOVF       SMove_nd_L0+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_SMove74
	MOVF       SMove_nd_L0+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SMove78
	MOVF       SMove_nd_L0+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SMove79
	MOVF       SMove_nd_L0+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_SMove84
	MOVF       SMove_nd_L0+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_SMove85
	MOVF       SMove_nd_L0+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_SMove90
	MOVF       SMove_nd_L0+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_SMove91
L_SMove44:
;a.h,303 :: 		if(isMetall()) // проверяем есть ли тут монетка
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove92
;a.h,306 :: 		if(isMove)
	MOVF       SMove_isMove_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove93
;a.h,307 :: 		setParam("Metall",nx,ny,1);
	MOVLW      ?lstr_4_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_4_MyProject+0)
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
L_SMove93:
;a.h,308 :: 		}
L_SMove92:
;a.h,309 :: 		return isMove;    // сообщаем было ли движение
	MOVF       SMove_isMove_L0+0, 0
	MOVWF      R0+0
;a.h,311 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_SRotare:

;a.h,315 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,317 :: 		int xa=0;
	CLRF       SRotare_xa_L0+0
	CLRF       SRotare_xa_L0+1
	CLRF       SRotare_ya_L0+0
	CLRF       SRotare_ya_L0+1
	CLRF       SRotare_r_L0+0
;a.h,321 :: 		xa=cX;
	MOVF       _cX+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cX+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,322 :: 		ya=cY;
	MOVF       _cY+0, 0
	MOVWF      SRotare_ya_L0+0
	MOVF       _cY+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,325 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,326 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare94
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare94:
;a.h,327 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare95
;a.h,329 :: 		S_Right(255); // поворачиваемся по наименьшему пути
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,330 :: 		for(;r>0;r--)
L_SRotare96:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare97
;a.h,332 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare99:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare99
	DECFSZ     R12+0, 1
	GOTO       L_SRotare99
	DECFSZ     R11+0, 1
	GOTO       L_SRotare99
	NOP
	NOP
;a.h,333 :: 		if(r%2==1) continue;
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
	GOTO       L_SRotare100
	GOTO       L_SRotare98
L_SRotare100:
;a.h,334 :: 		switch(cdirection)
	GOTO       L_SRotare101
;a.h,336 :: 		case UP:
L_SRotare103:
;a.h,337 :: 		xa=cY;
	MOVF       _cY+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cY+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,338 :: 		ya=-dX+cX;
	MOVF       _cX+0, 0
	ADDLW      254
	MOVWF      SRotare_ya_L0+0
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _cX+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,339 :: 		break;
	GOTO       L_SRotare102
;a.h,340 :: 		case DOWN:
L_SRotare104:
;a.h,341 :: 		xa=cY;
	MOVF       _cY+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cY+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,342 :: 		ya=cX+dY;
	MOVLW      4
	ADDWF      _cX+0, 0
	MOVWF      SRotare_ya_L0+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      SRotare_ya_L0+1
;a.h,343 :: 		break;
	GOTO       L_SRotare102
;a.h,344 :: 		case RIGHT:
L_SRotare105:
;a.h,345 :: 		xa=cY;
	MOVF       _cY+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cY+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,346 :: 		ya=-2*dX+cX;
	MOVF       _cX+0, 0
	ADDLW      252
	MOVWF      SRotare_ya_L0+0
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _cX+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,347 :: 		break;
	GOTO       L_SRotare102
;a.h,348 :: 		case LEFT:
L_SRotare106:
;a.h,349 :: 		xa=cY;
	MOVF       _cY+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cY+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,350 :: 		ya=cX+dX;
	MOVLW      2
	ADDWF      _cX+0, 0
	MOVWF      SRotare_ya_L0+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      SRotare_ya_L0+1
;a.h,351 :: 		break;
	GOTO       L_SRotare102
;a.h,352 :: 		}
L_SRotare101:
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare103
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare104
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare105
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare106
L_SRotare102:
;a.h,353 :: 		}
L_SRotare98:
;a.h,330 :: 		for(;r>0;r--)
	DECF       SRotare_r_L0+0, 1
;a.h,353 :: 		}
	GOTO       L_SRotare96
L_SRotare97:
;a.h,354 :: 		}
	GOTO       L_SRotare107
L_SRotare95:
;a.h,357 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,358 :: 		for(;r<0;r++)
L_SRotare108:
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare109
;a.h,360 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare111:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare111
	DECFSZ     R12+0, 1
	GOTO       L_SRotare111
	DECFSZ     R11+0, 1
	GOTO       L_SRotare111
	NOP
	NOP
;a.h,361 :: 		if((-r)%2==1) continue;
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
	GOTO       L__SRotare190
	MOVLW      1
	XORWF      R0+0, 0
L__SRotare190:
	BTFSS      STATUS+0, 2
	GOTO       L_SRotare112
	GOTO       L_SRotare110
L_SRotare112:
;a.h,362 :: 		switch(cdirection)
	GOTO       L_SRotare113
;a.h,364 :: 		case UP:
L_SRotare115:
;a.h,365 :: 		xa=cY-2*dY;
	MOVLW      8
	SUBWF      _cY+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _cY+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,366 :: 		ya=cX;
	MOVF       _cX+0, 0
	MOVWF      SRotare_ya_L0+0
	MOVF       _cX+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,367 :: 		break;
	GOTO       L_SRotare114
;a.h,368 :: 		case DOWN:
L_SRotare116:
;a.h,369 :: 		xa=cY;
	MOVF       _cY+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cY+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,370 :: 		ya=2*dX+cX;
	MOVF       _cX+0, 0
	ADDLW      4
	MOVWF      SRotare_ya_L0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _cX+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,371 :: 		break;
	GOTO       L_SRotare114
;a.h,372 :: 		case RIGHT:
L_SRotare117:
;a.h,373 :: 		xa=cY;
	MOVF       _cY+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cY+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,374 :: 		ya=cX+dY;
	MOVLW      4
	ADDWF      _cX+0, 0
	MOVWF      SRotare_ya_L0+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      SRotare_ya_L0+1
;a.h,375 :: 		break;
	GOTO       L_SRotare114
;a.h,376 :: 		case LEFT:
L_SRotare118:
;a.h,377 :: 		xa=cX+dX;
	MOVLW      2
	ADDWF      _cX+0, 0
	MOVWF      SRotare_xa_L0+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      0
	MOVWF      SRotare_xa_L0+1
;a.h,378 :: 		ya=cX;
	MOVF       _cX+0, 0
	MOVWF      SRotare_ya_L0+0
	MOVF       _cX+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,379 :: 		break;
	GOTO       L_SRotare114
;a.h,380 :: 		}
L_SRotare113:
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare115
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare116
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare117
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SRotare118
L_SRotare114:
;a.h,381 :: 		}
L_SRotare110:
;a.h,358 :: 		for(;r<0;r++)
	INCF       SRotare_r_L0+0, 1
;a.h,381 :: 		}
	GOTO       L_SRotare108
L_SRotare109:
;a.h,382 :: 		}
L_SRotare107:
;a.h,383 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,384 :: 		cdirection=nd;
	MOVF       FARG_SRotare_nd+0, 0
	MOVWF      _cdirection+0
;a.h,385 :: 		cX=xa;
	MOVF       SRotare_xa_L0+0, 0
	MOVWF      _cX+0
	MOVF       SRotare_xa_L0+1, 0
	MOVWF      _cX+1
;a.h,386 :: 		cY=ya;
	MOVF       SRotare_ya_L0+0, 0
	MOVWF      _cY+0
	MOVF       SRotare_ya_L0+1, 0
	MOVWF      _cY+1
;a.h,387 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_Correct:

;a.h,390 :: 		void Correct(void) // корректирует направление робота
;a.h,393 :: 		r=isSafeY();                // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_r_L0+0
;a.h,394 :: 		S_Left(DELAY_TIME_VR_10);  // повернуться
	MOVLW      64
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,395 :: 		nr=isSafeY();               // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_nr_L0+0
;a.h,396 :: 		if(r==nr)                   // сравнить их, если получаем правильное соотношение
	MOVF       Correct_r_L0+0, 0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Correct119
;a.h,397 :: 		S_Right(DELAY_TIME_VR_10);  // то мы находимся в правильном положении
	MOVLW      64
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct119:
;a.h,398 :: 		if(r>nr)
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct120
;a.h,399 :: 		return;
	GOTO       L_end_Correct
L_Correct120:
;a.h,400 :: 		if(r<nr)
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct121
;a.h,401 :: 		S_Right(2*DELAY_TIME_VR_10);
	MOVLW      128
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct121:
;a.h,402 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,403 :: 		}
L_end_Correct:
	RETURN
; end of _Correct

_A_search:

;a.h,408 :: 		void A_search()
;a.h,414 :: 		temp=getParam("Hint",cX,cY); // получаем значение стоимости для текущего состояния
	MOVLW      ?lstr_5_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_5_MyProject+0)
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
;a.h,416 :: 		setParam("Hint",cX,cY,++temp); // увеличиваем его, т.к. мы уже здесь
	MOVLW      ?lstr_6_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_6_MyProject+0)
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
;a.h,435 :: 		cxx=getParam("Calc",cX,cY);
	MOVLW      ?lstr_7_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_7_MyProject+0)
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
;a.h,436 :: 		cyy=getParam("Calc2",cX,cY);
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
	MOVWF      _cyy+0
;a.h,437 :: 		if(cdirection==UP) ;
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_A_search122
L_A_search122:
;a.h,438 :: 		if(cdirection==DOWN) cyy*=-1 ;
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_A_search123
	MOVF       _cyy+0, 0
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _cyy+0
L_A_search123:
;a.h,439 :: 		if(cdirection==LEFT)
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_A_search124
;a.h,441 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,442 :: 		cxx=cyy;
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;a.h,443 :: 		cyy=-temp;
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;a.h,444 :: 		}
L_A_search124:
;a.h,445 :: 		if(cdirection==RIGHT)
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_A_search125
;a.h,447 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,448 :: 		cxx=cyy;
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;a.h,449 :: 		cyy=-temp;
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;a.h,450 :: 		}
L_A_search125:
;a.h,451 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
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
	GOTO       L_A_search126
;a.h,454 :: 		cX+=cxx; // обновление текущих координат
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cX+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      _cX+1, 1
;a.h,455 :: 		cY+=cyy;
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cY+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      _cY+1, 1
;a.h,456 :: 		}
L_A_search126:
;a.h,460 :: 		}
L_end_A_search:
	RETURN
; end of _A_search

_mod:

;a.h,463 :: 		short mod(short x)
;a.h,465 :: 		if(x>=0) return x;
	MOVLW      128
	XORWF      FARG_mod_x+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mod127
	MOVF       FARG_mod_x+0, 0
	MOVWF      R0+0
	GOTO       L_end_mod
L_mod127:
;a.h,466 :: 		else return -x;
	MOVF       FARG_mod_x+0, 0
	SUBLW      0
	MOVWF      R0+0
;a.h,467 :: 		}
L_end_mod:
	RETURN
; end of _mod

_Brain:

;a.h,469 :: 		void Brain()
;a.h,474 :: 		for(x=0;x<WorldSize;x++)
	CLRF       Brain_x_L0+0
L_Brain129:
	MOVLW      128
	XORWF      Brain_x_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain130
;a.h,476 :: 		for(y=0;y<WorldSize;y++)
	CLRF       Brain_y_L0+0
L_Brain132:
	MOVLW      128
	XORWF      Brain_y_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain133
;a.h,478 :: 		if(getParam("Hint",x,y)/*H[x][y]*/!=0) continue; // если значение не нулевое- значит мы там были и всё нашли.
	MOVLW      ?lstr_9_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_9_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       Brain_x_L0+0, 0
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	BTFSC      FARG_getParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_x+1
	MOVF       Brain_y_L0+0, 0
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      FARG_getParam_y+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain195
	MOVLW      0
	XORWF      R0+0, 0
L__Brain195:
	BTFSC      STATUS+0, 2
	GOTO       L_Brain135
	GOTO       L_Brain134
L_Brain135:
;a.h,479 :: 		for(j=0;j<WorldSize;j++) // x
	CLRF       Brain_j_L0+0
L_Brain136:
	MOVLW      128
	XORWF      Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain137
;a.h,480 :: 		for(k=0;k<WorldSize;k++) // y
	CLRF       Brain_k_L0+0
L_Brain139:
	MOVLW      128
	XORWF      Brain_k_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain140
;a.h,482 :: 		r=mod(x-j)+mod(y-k);  // манхетенское расстояние
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
	MOVWF      Brain_r_L0+0
;a.h,483 :: 		if(r<getParam("hevr",j,k)) setParam("hevr",j,k,r); //h_evr[j][k])  // h_evr[j][k]=r; // если есть цель ближе - запишем расстояние до неё
	MOVLW      ?lstr_10_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_10_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       Brain_j_L0+0, 0
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	BTFSC      FARG_getParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_x+1
	MOVF       Brain_k_L0+0, 0
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      FARG_getParam_y+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVLW      128
	BTFSC      Brain_r_L0+0, 7
	MOVLW      127
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Brain196
	MOVF       R0+0, 0
	SUBWF      Brain_r_L0+0, 0
L__Brain196:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain142
	MOVLW      ?lstr_11_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_11_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       Brain_j_L0+0, 0
	MOVWF      FARG_setParam_x+0
	MOVLW      0
	BTFSC      FARG_setParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_x+1
	MOVF       Brain_k_L0+0, 0
	MOVWF      FARG_setParam_y+0
	MOVLW      0
	BTFSC      FARG_setParam_y+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_y+1
	MOVF       Brain_r_L0+0, 0
	MOVWF      FARG_setParam_value+0
	MOVLW      0
	BTFSC      FARG_setParam_value+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
L_Brain142:
;a.h,480 :: 		for(k=0;k<WorldSize;k++) // y
	INCF       Brain_k_L0+0, 1
;a.h,484 :: 		}
	GOTO       L_Brain139
L_Brain140:
;a.h,479 :: 		for(j=0;j<WorldSize;j++) // x
	INCF       Brain_j_L0+0, 1
;a.h,484 :: 		}
	GOTO       L_Brain136
L_Brain137:
;a.h,485 :: 		}
L_Brain134:
;a.h,476 :: 		for(y=0;y<WorldSize;y++)
	INCF       Brain_y_L0+0, 1
;a.h,485 :: 		}
	GOTO       L_Brain132
L_Brain133:
;a.h,474 :: 		for(x=0;x<WorldSize;x++)
	INCF       Brain_x_L0+0, 1
;a.h,486 :: 		}
	GOTO       L_Brain129
L_Brain130:
;a.h,487 :: 		}
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

;MyProject.c,27 :: 		void main()
;MyProject.c,29 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,30 :: 		while(getParam("start",1,1)!=13) // ждем сигнала старта
L_main143:
	MOVLW      ?lstr_12_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_12_MyProject+0)
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
	GOTO       L__main199
	MOVLW      13
	XORWF      R0+0, 0
L__main199:
	BTFSC      STATUS+0, 2
	GOTO       L_main144
;MyProject.c,31 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main145:
	DECFSZ     R13+0, 1
	GOTO       L_main145
	DECFSZ     R12+0, 1
	GOTO       L_main145
	DECFSZ     R11+0, 1
	GOTO       L_main145
	NOP
	NOP
	GOTO       L_main143
L_main144:
;MyProject.c,33 :: 		cdirection=DOWN; // начальное направление - вниз
	MOVLW      5
	MOVWF      _cdirection+0
;MyProject.c,34 :: 		cX=isSafeX()/2;  // получаем текущие координаты
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      _cX+0
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	MOVWF      _cX+1
	RRF        _cX+0, 1
	BCF        _cX+0, 7
	BTFSC      _cX+0, 6
	BSF        _cX+0, 7
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	MOVWF      _cX+1
;MyProject.c,35 :: 		cY=isSafeY()/2;
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      _cY+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	MOVWF      _cY+1
	RRF        _cY+0, 1
	BCF        _cY+0, 7
	BTFSC      _cY+0, 6
	BSF        _cY+0, 7
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	MOVWF      _cY+1
;MyProject.c,36 :: 		getParam("Hint",cX,cY);
	MOVLW      ?lstr_13_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_13_MyProject+0)
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
;MyProject.c,37 :: 		SRotare(cdirection,UP);
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVLW      1
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;MyProject.c,38 :: 		maxX=cX+isSafeX()/2;
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	BTFSC      R1+0, 6
	BSF        R1+0, 7
	MOVF       R1+0, 0
	ADDWF      _cX+0, 0
	MOVWF      _maxX+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      _maxX+1
	MOVLW      0
	BTFSC      R1+0, 7
	MOVLW      255
	ADDWF      _maxX+1, 1
;MyProject.c,39 :: 		maxY=cY+isSafeY()/2;
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	BTFSC      R1+0, 6
	BSF        R1+0, 7
	MOVF       R1+0, 0
	ADDWF      _cY+0, 0
	MOVWF      R0+0
	MOVF       _cY+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      0
	BTFSC      R1+0, 7
	MOVLW      255
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _maxY+0
	MOVF       R0+1, 0
	MOVWF      _maxY+1
;MyProject.c,40 :: 		setParam("max",maxX,maxY,1);
	MOVLW      ?lstr_14_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_14_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       _maxX+0, 0
	MOVWF      FARG_setParam_x+0
	MOVF       _maxX+1, 0
	MOVWF      FARG_setParam_x+1
	MOVF       R0+0, 0
	MOVWF      FARG_setParam_y+0
	MOVF       R0+1, 0
	MOVWF      FARG_setParam_y+1
	MOVLW      1
	MOVWF      FARG_setParam_value+0
	MOVLW      0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
;MyProject.c,41 :: 		getParam("Hint",cX,cY);
	MOVLW      ?lstr_15_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_15_MyProject+0)
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
;MyProject.c,42 :: 		getParam("Hinyt",cX,cY);
	MOVLW      ?lstr_16_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_16_MyProject+0)
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
;MyProject.c,44 :: 		while(getParam("jobisdone?",1,1)!=13)
L_main146:
	MOVLW      ?lstr_17_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_17_MyProject+0)
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
	GOTO       L__main200
	MOVLW      13
	XORWF      R0+0, 0
L__main200:
	BTFSC      STATUS+0, 2
	GOTO       L_main147
;MyProject.c,49 :: 		if(cX<=maxX/2)
	MOVF       _maxX+0, 0
	MOVWF      R1+0
	MOVF       _maxX+1, 0
	MOVWF      R1+1
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main201
	MOVF       _cX+0, 0
	SUBWF      R1+0, 0
L__main201:
	BTFSS      STATUS+0, 0
	GOTO       L_main148
;MyProject.c,51 :: 		if(cY<=maxY/2)
	MOVF       _maxY+0, 0
	MOVWF      R1+0
	MOVF       _maxY+1, 0
	MOVWF      R1+1
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main202
	MOVF       _cY+0, 0
	SUBWF      R1+0, 0
L__main202:
	BTFSS      STATUS+0, 0
	GOTO       L_main149
;MyProject.c,52 :: 		nd=DOWN;
	MOVLW      5
	MOVWF      main_nd_L1+0
	GOTO       L_main150
L_main149:
;MyProject.c,54 :: 		nd=LEFT;
	MOVLW      7
	MOVWF      main_nd_L1+0
L_main150:
;MyProject.c,55 :: 		}
	GOTO       L_main151
L_main148:
;MyProject.c,58 :: 		if(cY<=maxY/2)
	MOVF       _maxY+0, 0
	MOVWF      R1+0
	MOVF       _maxY+1, 0
	MOVWF      R1+1
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main203
	MOVF       _cY+0, 0
	SUBWF      R1+0, 0
L__main203:
	BTFSS      STATUS+0, 0
	GOTO       L_main152
;MyProject.c,59 :: 		nd=RIGHT;
	MOVLW      3
	MOVWF      main_nd_L1+0
	GOTO       L_main153
L_main152:
;MyProject.c,61 :: 		nd=UP;
	MOVLW      1
	MOVWF      main_nd_L1+0
L_main153:
;MyProject.c,62 :: 		}
L_main151:
;MyProject.c,64 :: 		SRotare(cdirection,nd);
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVF       main_nd_L1+0, 0
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;MyProject.c,66 :: 		A_search();
	CALL       _A_search+0
;MyProject.c,67 :: 		}
	GOTO       L_main146
L_main147:
;MyProject.c,68 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
