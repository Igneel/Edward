
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
L__Adc_Rd158:
;adc.h,5 :: 		TRISA |= (1<<ch);
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd179:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd180
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd179
L__Adc_Rd180:
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
L__Adc_Rd157:
;adc.h,9 :: 		TRISE |= (1<<(ch-5));
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd181:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd182
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd181
L__Adc_Rd182:
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
L__Adc_Rd183:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd184
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd183
L__Adc_Rd184:
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
L__Adc_Rd185:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd186
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd185
L__Adc_Rd186:
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
	GOTO       L__isSafeY188
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeY188:
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
	GOTO       L__isSafeX190
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeX190:
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

;a.h,64 :: 		void strConstCpy (const char *source, char *dest) {
;a.h,65 :: 		while (*source) *dest++ = *source++;
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
;a.h,66 :: 		*dest = 0;
	MOVF       FARG_strConstCpy_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,67 :: 		}
L_end_strConstCpy:
	RETURN
; end of _strConstCpy

_stradd:

;a.h,68 :: 		void stradd(char *source, char *dest){
;a.h,69 :: 		while (*dest++);
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
;a.h,70 :: 		*dest--;
	DECF       FARG_stradd_dest+0, 1
;a.h,71 :: 		while (*source) *dest++ = *source++;
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
;a.h,72 :: 		*dest = 0;
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,73 :: 		}
L_end_stradd:
	RETURN
; end of _stradd

_getParam:

;a.h,75 :: 		int getParam(const char * p,int x,int y)
;a.h,78 :: 		strConstCpy(p,string);
	MOVF       FARG_getParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_getParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;a.h,79 :: 		IntToStr (x,strint);
	MOVF       FARG_getParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,80 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,81 :: 		IntToStr (y,strint);
	MOVF       FARG_getParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,82 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,83 :: 		UART1_Write_Text(string);
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;a.h,84 :: 		while(1) if(UART1_Data_Ready())
L_getParam22:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_getParam24
;a.h,86 :: 		temp=UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      getParam_temp_L0+0
;a.h,87 :: 		UART1_Write(temp);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;a.h,88 :: 		return temp;
	MOVF       getParam_temp_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	GOTO       L_end_getParam
;a.h,89 :: 		}
L_getParam24:
	GOTO       L_getParam22
;a.h,90 :: 		}
L_end_getParam:
	RETURN
; end of _getParam

_setParam:

;a.h,92 :: 		void setParam(const char * p,int x,int y,int value)
;a.h,94 :: 		strConstCpy(p,string);
	MOVF       FARG_setParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_setParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;a.h,95 :: 		IntToStr (x,strint);
	MOVF       FARG_setParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,96 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,97 :: 		IntToStr (y,strint);
	MOVF       FARG_setParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,98 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,99 :: 		IntToStr (value,strint);
	MOVF       FARG_setParam_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,100 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,101 :: 		UART1_Write_Text(string);
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;a.h,102 :: 		}
L_end_setParam:
	RETURN
; end of _setParam

_isMetall:

;a.h,106 :: 		short isMetall()
;a.h,109 :: 		m=Adc_Rd(1);
	MOVLW      1
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isMetall_m_L0+0
;a.h,110 :: 		if(m>0 && m<50)
	MOVLW      128
	XORLW      0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R2+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall27
	MOVLW      128
	XORWF      isMetall_m_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      50
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall27
L__isMetall159:
;a.h,111 :: 		return 1;    // если объект металлический возвращаем единицу
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isMetall
L_isMetall27:
;a.h,113 :: 		return 0;
	CLRF       R0+0
;a.h,114 :: 		}
L_end_isMetall:
	RETURN
; end of _isMetall

_comp:

;a.h,116 :: 		short comp(short d1,short d2)
;a.h,118 :: 		if(d1==d2) return 0; // операнды равны
	MOVF       FARG_comp_d1+0, 0
	XORWF      FARG_comp_d2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_comp29
	CLRF       R0+0
	GOTO       L_end_comp
L_comp29:
;a.h,119 :: 		if(d1>d2) return 1; // первый больше второго
	MOVLW      128
	XORWF      FARG_comp_d2+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_comp30
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_comp
L_comp30:
;a.h,120 :: 		else return -1; // первый меньше второго
	MOVLW      255
	MOVWF      R0+0
;a.h,121 :: 		}
L_end_comp:
	RETURN
; end of _comp

_SMove:

;a.h,124 :: 		short SMove(short nx,short ny)
;a.h,129 :: 		short isMove=0; // индикатор - было ли движение
	CLRF       SMove_isMove_L0+0
;a.h,130 :: 		ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
	MOVF       _cX+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_nx+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
	MOVF       R0+0, 0
	MOVWF      SMove_ax_L0+0
;a.h,132 :: 		ry==comp(cY,ny);
	MOVF       _cY+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_comp_d2+0
	CALL       _comp+0
;a.h,134 :: 		if(ax==-1)  // если нам нужно направо
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove32
;a.h,135 :: 		nd=RIGHT+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove32:
;a.h,136 :: 		if(ax==0)    // смещаться по оси х не нужно
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove33
;a.h,137 :: 		switch(ry)
	GOTO       L_SMove34
;a.h,139 :: 		case -1: //
L_SMove36:
;a.h,140 :: 		nd=UP;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,141 :: 		break;
	GOTO       L_SMove35
;a.h,142 :: 		case 0:
L_SMove37:
;a.h,143 :: 		nd=ZEROD;
	MOVLW      9
	MOVWF      SMove_nd_L0+0
;a.h,145 :: 		break;
	GOTO       L_SMove35
;a.h,146 :: 		case 1:
L_SMove38:
;a.h,147 :: 		nd=DOWN;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,148 :: 		break;
	GOTO       L_SMove35
;a.h,150 :: 		}
L_SMove34:
	MOVF       SMove_ry_L0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_SMove36
	MOVF       SMove_ry_L0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove37
	MOVF       SMove_ry_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove38
L_SMove35:
L_SMove33:
;a.h,151 :: 		if(ax==1)   // если нам нужно налево
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove39
;a.h,152 :: 		nd=LEFT-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove39:
;a.h,154 :: 		switch (nd)
	GOTO       L_SMove40
;a.h,156 :: 		case UP:
L_SMove42:
;a.h,157 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove43
;a.h,159 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,160 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,161 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,162 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,163 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove44:
	DECFSZ     R13+0, 1
	GOTO       L_SMove44
	DECFSZ     R12+0, 1
	GOTO       L_SMove44
	DECFSZ     R11+0, 1
	GOTO       L_SMove44
;a.h,164 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,165 :: 		Correct();
	CALL       _Correct+0
;a.h,166 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,167 :: 		}
L_SMove43:
;a.h,168 :: 		break;
	GOTO       L_SMove41
;a.h,169 :: 		case RUP:
L_SMove45:
;a.h,170 :: 		if(isSafeY()>2 && isSafeX()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove48
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove48
L__SMove160:
;a.h,172 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,173 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove49:
	DECFSZ     R13+0, 1
	GOTO       L_SMove49
	DECFSZ     R12+0, 1
	GOTO       L_SMove49
	DECFSZ     R11+0, 1
	GOTO       L_SMove49
	NOP
;a.h,174 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,175 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,176 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,177 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,178 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove50:
	DECFSZ     R13+0, 1
	GOTO       L_SMove50
	DECFSZ     R12+0, 1
	GOTO       L_SMove50
	DECFSZ     R11+0, 1
	GOTO       L_SMove50
;a.h,179 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,180 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,181 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove51:
	DECFSZ     R13+0, 1
	GOTO       L_SMove51
	DECFSZ     R12+0, 1
	GOTO       L_SMove51
	DECFSZ     R11+0, 1
	GOTO       L_SMove51
	NOP
;a.h,182 :: 		Correct();
	CALL       _Correct+0
;a.h,183 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,184 :: 		}
L_SMove48:
;a.h,185 :: 		break;
	GOTO       L_SMove41
;a.h,186 :: 		case RIGHT:
L_SMove52:
;a.h,187 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove53
;a.h,189 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,190 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,191 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,192 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,193 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove54:
	DECFSZ     R13+0, 1
	GOTO       L_SMove54
	DECFSZ     R12+0, 1
	GOTO       L_SMove54
	DECFSZ     R11+0, 1
	GOTO       L_SMove54
;a.h,194 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,195 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,196 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove55:
	DECFSZ     R13+0, 1
	GOTO       L_SMove55
	DECFSZ     R12+0, 1
	GOTO       L_SMove55
	DECFSZ     R11+0, 1
	GOTO       L_SMove55
	NOP
;a.h,197 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,198 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,199 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,200 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,201 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove56:
	DECFSZ     R13+0, 1
	GOTO       L_SMove56
	DECFSZ     R12+0, 1
	GOTO       L_SMove56
	DECFSZ     R11+0, 1
	GOTO       L_SMove56
;a.h,202 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,203 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,204 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove57:
	DECFSZ     R13+0, 1
	GOTO       L_SMove57
	DECFSZ     R12+0, 1
	GOTO       L_SMove57
	DECFSZ     R11+0, 1
	GOTO       L_SMove57
	NOP
;a.h,205 :: 		Correct();
	CALL       _Correct+0
;a.h,206 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,207 :: 		}
L_SMove53:
;a.h,208 :: 		break;
	GOTO       L_SMove41
;a.h,209 :: 		case RDOWN:
L_SMove58:
;a.h,210 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove59
;a.h,212 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,213 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove60:
	DECFSZ     R13+0, 1
	GOTO       L_SMove60
	DECFSZ     R12+0, 1
	GOTO       L_SMove60
	DECFSZ     R11+0, 1
	GOTO       L_SMove60
	NOP
;a.h,214 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,215 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,216 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,217 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,218 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove61:
	DECFSZ     R13+0, 1
	GOTO       L_SMove61
	DECFSZ     R12+0, 1
	GOTO       L_SMove61
	DECFSZ     R11+0, 1
	GOTO       L_SMove61
;a.h,219 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,220 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,221 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove62:
	DECFSZ     R13+0, 1
	GOTO       L_SMove62
	DECFSZ     R12+0, 1
	GOTO       L_SMove62
	DECFSZ     R11+0, 1
	GOTO       L_SMove62
	NOP
;a.h,222 :: 		Correct();
	CALL       _Correct+0
;a.h,223 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,224 :: 		}
L_SMove59:
;a.h,225 :: 		break;
	GOTO       L_SMove41
;a.h,226 :: 		case DOWN:
L_SMove63:
;a.h,227 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,228 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,229 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,230 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,231 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove64:
	DECFSZ     R13+0, 1
	GOTO       L_SMove64
	DECFSZ     R12+0, 1
	GOTO       L_SMove64
	DECFSZ     R11+0, 1
	GOTO       L_SMove64
;a.h,232 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,233 :: 		Correct();
	CALL       _Correct+0
;a.h,234 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,235 :: 		break;
	GOTO       L_SMove41
;a.h,236 :: 		case LDOWN:
L_SMove65:
;a.h,237 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,238 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove66:
	DECFSZ     R13+0, 1
	GOTO       L_SMove66
	DECFSZ     R12+0, 1
	GOTO       L_SMove66
	DECFSZ     R11+0, 1
	GOTO       L_SMove66
	NOP
;a.h,239 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,240 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,241 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,242 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,243 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove67:
	DECFSZ     R13+0, 1
	GOTO       L_SMove67
	DECFSZ     R12+0, 1
	GOTO       L_SMove67
	DECFSZ     R11+0, 1
	GOTO       L_SMove67
;a.h,244 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,245 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,246 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove68:
	DECFSZ     R13+0, 1
	GOTO       L_SMove68
	DECFSZ     R12+0, 1
	GOTO       L_SMove68
	DECFSZ     R11+0, 1
	GOTO       L_SMove68
	NOP
;a.h,247 :: 		Correct();
	CALL       _Correct+0
;a.h,248 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,249 :: 		break;
	GOTO       L_SMove41
;a.h,250 :: 		case LEFT:
L_SMove69:
;a.h,251 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,252 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,253 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,254 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,255 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove70:
	DECFSZ     R13+0, 1
	GOTO       L_SMove70
	DECFSZ     R12+0, 1
	GOTO       L_SMove70
	DECFSZ     R11+0, 1
	GOTO       L_SMove70
;a.h,256 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,257 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,258 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove71:
	DECFSZ     R13+0, 1
	GOTO       L_SMove71
	DECFSZ     R12+0, 1
	GOTO       L_SMove71
	DECFSZ     R11+0, 1
	GOTO       L_SMove71
	NOP
;a.h,259 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,260 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,261 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,262 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,263 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,264 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,265 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,266 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove73:
	DECFSZ     R13+0, 1
	GOTO       L_SMove73
	DECFSZ     R12+0, 1
	GOTO       L_SMove73
	DECFSZ     R11+0, 1
	GOTO       L_SMove73
	NOP
;a.h,267 :: 		Correct();
	CALL       _Correct+0
;a.h,268 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,269 :: 		break;
	GOTO       L_SMove41
;a.h,270 :: 		case LUP:
L_SMove74:
;a.h,271 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove75
;a.h,273 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,274 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove76:
	DECFSZ     R13+0, 1
	GOTO       L_SMove76
	DECFSZ     R12+0, 1
	GOTO       L_SMove76
	DECFSZ     R11+0, 1
	GOTO       L_SMove76
	NOP
;a.h,275 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,276 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,277 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,278 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,279 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove77:
	DECFSZ     R13+0, 1
	GOTO       L_SMove77
	DECFSZ     R12+0, 1
	GOTO       L_SMove77
	DECFSZ     R11+0, 1
	GOTO       L_SMove77
;a.h,280 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,281 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,282 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove78:
	DECFSZ     R13+0, 1
	GOTO       L_SMove78
	DECFSZ     R12+0, 1
	GOTO       L_SMove78
	DECFSZ     R11+0, 1
	GOTO       L_SMove78
	NOP
;a.h,283 :: 		Correct();
	CALL       _Correct+0
;a.h,284 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,285 :: 		}
L_SMove75:
;a.h,286 :: 		break;
	GOTO       L_SMove41
;a.h,287 :: 		case ZEROD:
L_SMove79:
;a.h,288 :: 		break;
	GOTO       L_SMove41
;a.h,289 :: 		}
L_SMove40:
	MOVF       SMove_nd_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove42
	MOVF       SMove_nd_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_SMove45
	MOVF       SMove_nd_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SMove52
	MOVF       SMove_nd_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_SMove58
	MOVF       SMove_nd_L0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SMove63
	MOVF       SMove_nd_L0+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_SMove65
	MOVF       SMove_nd_L0+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SMove69
	MOVF       SMove_nd_L0+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_SMove74
	MOVF       SMove_nd_L0+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_SMove79
L_SMove41:
;a.h,292 :: 		if(isMetall()) // проверяем есть ли тут монетка
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove80
;a.h,295 :: 		if(isMove)
	MOVF       SMove_isMove_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove81
;a.h,296 :: 		setParam("Metall",nx,ny,1);
	MOVLW      ?lstr_1_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_1_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       FARG_SMove_nx+0, 0
	MOVWF      FARG_setParam_x+0
	MOVLW      0
	BTFSC      FARG_setParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_x+1
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_setParam_y+0
	MOVLW      0
	BTFSC      FARG_setParam_y+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_y+1
	MOVLW      1
	MOVWF      FARG_setParam_value+0
	MOVLW      0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
L_SMove81:
;a.h,297 :: 		}
L_SMove80:
;a.h,298 :: 		return isMove;    // сообщаем было ли движение
	MOVF       SMove_isMove_L0+0, 0
	MOVWF      R0+0
;a.h,300 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_SRotare:

;a.h,305 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,308 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,309 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare82
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare82:
;a.h,310 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare83
;a.h,312 :: 		S_Right(255); // поворачиваемся по наименьшему пути
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,313 :: 		for(;r>0;r--)
L_SRotare84:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare85
;a.h,314 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare87:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare87
	DECFSZ     R12+0, 1
	GOTO       L_SRotare87
	DECFSZ     R11+0, 1
	GOTO       L_SRotare87
	NOP
	NOP
;a.h,313 :: 		for(;r>0;r--)
	DECF       SRotare_r_L0+0, 1
;a.h,314 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	GOTO       L_SRotare84
L_SRotare85:
;a.h,315 :: 		}
	GOTO       L_SRotare88
L_SRotare83:
;a.h,318 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,319 :: 		for(;r<0;r++)
L_SRotare89:
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare90
;a.h,320 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare92:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare92
	DECFSZ     R12+0, 1
	GOTO       L_SRotare92
	DECFSZ     R11+0, 1
	GOTO       L_SRotare92
	NOP
	NOP
;a.h,319 :: 		for(;r<0;r++)
	INCF       SRotare_r_L0+0, 1
;a.h,320 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	GOTO       L_SRotare89
L_SRotare90:
;a.h,321 :: 		}
L_SRotare88:
;a.h,322 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_Correct:

;a.h,325 :: 		void Correct(void) // корректирует направление робота
;a.h,328 :: 		r=isSafeY();                // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_r_L0+0
;a.h,329 :: 		S_Left(DELAY_TIME_VR_10);  // повернуться
	MOVLW      64
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,330 :: 		nr=isSafeY();               // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_nr_L0+0
;a.h,331 :: 		if(r==nr)                   // сравнить их, если получаем правильное соотношение
	MOVF       Correct_r_L0+0, 0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Correct93
;a.h,332 :: 		S_Right(DELAY_TIME_VR_10);  // то мы находимся в правильном положении
	MOVLW      64
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct93:
;a.h,333 :: 		if(r>nr)
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct94
;a.h,334 :: 		return;
	GOTO       L_end_Correct
L_Correct94:
;a.h,335 :: 		if(r<nr)
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct95
;a.h,336 :: 		S_Right(2*DELAY_TIME_VR_10);
	MOVLW      128
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct95:
;a.h,338 :: 		}
L_end_Correct:
	RETURN
; end of _Correct

_A_search:

;a.h,343 :: 		void A_search()
;a.h,347 :: 		if(findGoalCount==NumberOfGoals) return;// проверили все состояния - достигли цели - закончили работу.
	MOVF       _findGoalCount+0, 0
	XORLW      131
	BTFSS      STATUS+0, 2
	GOTO       L_A_search96
	GOTO       L_end_A_search
L_A_search96:
;a.h,348 :: 		if(getParam("jobisdone?",1,1)==13) return; // если база говорит что работа окончена - завершаем работу.
	MOVLW      ?lstr_2_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_2_MyProject+0)
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
	GOTO       L__A_search201
	MOVLW      13
	XORWF      R0+0, 0
L__A_search201:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search97
	GOTO       L_end_A_search
L_A_search97:
;a.h,350 :: 		temp=getParam("Hint",cX,cY); // получаем значение для текущего состояния
	MOVLW      ?lstr_3_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_3_MyProject+0)
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
;a.h,352 :: 		setParam("Hint",cX,cY,temp++); // увеличиваем его, т.к. мы уже здесь
	MOVLW      ?lstr_4_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_4_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_setParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_setParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_setParam_y+0
	MOVF       _cY+1, 0
	MOVWF      FARG_setParam_y+1
	MOVF       R0+0, 0
	MOVWF      FARG_setParam_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
	INCF       A_search_temp_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_temp_L0+1, 1
;a.h,354 :: 		min=getParam("Hint",cX,cY+1)+getParam("hevr",cX,cY+1);//H[cX][cY+1]+h_evr[cX][cY+1];
	MOVLW      ?lstr_5_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_5_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _cY+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	MOVWF      FLOC__A_search+0
	MOVF       R0+1, 0
	MOVWF      FLOC__A_search+1
	MOVLW      ?lstr_6_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_6_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _cY+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	ADDWF      FLOC__A_search+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       FLOC__A_search+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,355 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	MOVLW      255
	MOVWF      A_search_i_L0+0
	MOVLW      255
	MOVWF      A_search_i_L0+1
L_A_search98:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search202
	MOVF       A_search_i_L0+0, 0
	SUBLW      1
L__A_search202:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search99
;a.h,356 :: 		for(j=-1;j<=1;j++)//----------------------------------------------------------------------------------------------------------------------!!!!!
	MOVLW      255
	MOVWF      A_search_j_L0+0
	MOVLW      255
	MOVWF      A_search_j_L0+1
L_A_search101:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_j_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search203
	MOVF       A_search_j_L0+0, 0
	SUBLW      1
L__A_search203:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search102
;a.h,358 :: 		if(i==0 && j==0) continue;
	MOVLW      0
	XORWF      A_search_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search204
	MOVLW      0
	XORWF      A_search_i_L0+0, 0
L__A_search204:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search106
	MOVLW      0
	XORWF      A_search_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search205
	MOVLW      0
	XORWF      A_search_j_L0+0, 0
L__A_search205:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search106
L__A_search161:
	GOTO       L_A_search103
L_A_search106:
;a.h,359 :: 		temp=getParam("Hint",cX+i,cY+j)+getParam("hevr",cX+i,cY+j); //H[cX+i][cY+j]+h_evr[cX+i][cY+j];
	MOVLW      ?lstr_7_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_7_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       A_search_i_L0+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_i_L0+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       A_search_j_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       _cY+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_j_L0+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	MOVWF      FLOC__A_search+0
	MOVF       R0+1, 0
	MOVWF      FLOC__A_search+1
	MOVLW      ?lstr_8_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_8_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       A_search_i_L0+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       _cX+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_i_L0+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       A_search_j_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       _cY+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_j_L0+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	ADDWF      FLOC__A_search+0, 0
	MOVWF      R2+0
	MOVF       FLOC__A_search+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R2+1, 0
	MOVWF      A_search_temp_L0+1
;a.h,360 :: 		if(temp<min) // имеющее минимальную стоимость
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_min_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search206
	MOVF       A_search_min_L0+0, 0
	SUBWF      R2+0, 0
L__A_search206:
	BTFSC      STATUS+0, 0
	GOTO       L_A_search107
;a.h,362 :: 		min=temp;
	MOVF       A_search_temp_L0+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       A_search_temp_L0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,363 :: 		cxx=i;
	MOVF       A_search_i_L0+0, 0
	MOVWF      _cxx+0
;a.h,364 :: 		cyy=j;
	MOVF       A_search_j_L0+0, 0
	MOVWF      _cyy+0
;a.h,365 :: 		}
L_A_search107:
;a.h,366 :: 		}
L_A_search103:
;a.h,356 :: 		for(j=-1;j<=1;j++)//----------------------------------------------------------------------------------------------------------------------!!!!!
	INCF       A_search_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_j_L0+1, 1
;a.h,366 :: 		}
	GOTO       L_A_search101
L_A_search102:
;a.h,355 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	INCF       A_search_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_i_L0+1, 1
;a.h,366 :: 		}
	GOTO       L_A_search98
L_A_search99:
;a.h,367 :: 		switch(cdirection)
	GOTO       L_A_search108
;a.h,369 :: 		case UP:
L_A_search110:
;a.h,370 :: 		break;
	GOTO       L_A_search109
;a.h,371 :: 		case DOWN:
L_A_search111:
;a.h,372 :: 		cyy*=-1;
	MOVF       _cyy+0, 0
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _cyy+0
;a.h,373 :: 		break;
	GOTO       L_A_search109
;a.h,374 :: 		case LEFT:
L_A_search112:
;a.h,375 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,376 :: 		cxx=cyy;
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;a.h,377 :: 		cyy=-temp;
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;a.h,378 :: 		break;
	GOTO       L_A_search109
;a.h,379 :: 		case RIGHT:
L_A_search113:
;a.h,380 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,381 :: 		cxx=-cyy;
	MOVF       _cyy+0, 0
	SUBLW      0
	MOVWF      _cxx+0
;a.h,382 :: 		cyy=temp;
	MOVF       A_search_temp_L0+0, 0
	MOVWF      _cyy+0
;a.h,383 :: 		break;
	GOTO       L_A_search109
;a.h,384 :: 		}
L_A_search108:
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_A_search110
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_A_search111
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_A_search112
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_A_search113
L_A_search109:
;a.h,386 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_SMove_nx+0
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_SMove_ny+0
	CALL       _SMove+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_A_search114
;a.h,389 :: 		cX+=cxx; // обновление текущих координат
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cX+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      _cX+1, 1
;a.h,390 :: 		cY+=cyy;
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cY+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      _cY+1, 1
;a.h,391 :: 		}
L_A_search114:
;a.h,395 :: 		}
L_end_A_search:
	RETURN
; end of _A_search

_mod:

;a.h,398 :: 		short mod(short x)
;a.h,400 :: 		if(x>=0) return x;
	MOVLW      128
	XORWF      FARG_mod_x+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mod115
	MOVF       FARG_mod_x+0, 0
	MOVWF      R0+0
	GOTO       L_end_mod
L_mod115:
;a.h,401 :: 		else return -x;
	MOVF       FARG_mod_x+0, 0
	SUBLW      0
	MOVWF      R0+0
;a.h,402 :: 		}
L_end_mod:
	RETURN
; end of _mod

_Brain:

;a.h,404 :: 		void Brain()
;a.h,409 :: 		for(x=0;x<WorldSize;x++)
	CLRF       Brain_x_L0+0
L_Brain117:
	MOVLW      128
	XORWF      Brain_x_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain118
;a.h,411 :: 		for(y=0;y<WorldSize;y++)
	CLRF       Brain_y_L0+0
L_Brain120:
	MOVLW      128
	XORWF      Brain_y_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain121
;a.h,413 :: 		if(getParam("Hint",x,y)/*H[x][y]*/!=0) continue; // если значение не нулевое- значит мы там были и всё нашли.
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
	GOTO       L__Brain209
	MOVLW      0
	XORWF      R0+0, 0
L__Brain209:
	BTFSC      STATUS+0, 2
	GOTO       L_Brain123
	GOTO       L_Brain122
L_Brain123:
;a.h,414 :: 		for(j=0;j<WorldSize;j++) // x
	CLRF       Brain_j_L0+0
L_Brain124:
	MOVLW      128
	XORWF      Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain125
;a.h,415 :: 		for(k=0;k<WorldSize;k++) // y
	CLRF       Brain_k_L0+0
L_Brain127:
	MOVLW      128
	XORWF      Brain_k_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain128
;a.h,417 :: 		r=mod(x-j)+mod(y-k);  // манхетенское расстояние
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
;a.h,418 :: 		if(r<getParam("hevr",j,k)) setParam("hevr",j,k,r); //h_evr[j][k])  // h_evr[j][k]=r; // если есть цель ближе - запишем расстояние до неё
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
	GOTO       L__Brain210
	MOVF       R0+0, 0
	SUBWF      Brain_r_L0+0, 0
L__Brain210:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain130
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
L_Brain130:
;a.h,415 :: 		for(k=0;k<WorldSize;k++) // y
	INCF       Brain_k_L0+0, 1
;a.h,419 :: 		}
	GOTO       L_Brain127
L_Brain128:
;a.h,414 :: 		for(j=0;j<WorldSize;j++) // x
	INCF       Brain_j_L0+0, 1
;a.h,419 :: 		}
	GOTO       L_Brain124
L_Brain125:
;a.h,420 :: 		}
L_Brain122:
;a.h,411 :: 		for(y=0;y<WorldSize;y++)
	INCF       Brain_y_L0+0, 1
;a.h,420 :: 		}
	GOTO       L_Brain120
L_Brain121:
;a.h,409 :: 		for(x=0;x<WorldSize;x++)
	INCF       Brain_x_L0+0, 1
;a.h,421 :: 		}
	GOTO       L_Brain117
L_Brain118:
;a.h,422 :: 		}
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
;MyProject.c,30 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,31 :: 		while(getParam("start",1,1)!=13) // ждем сигнала старта
L_main131:
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
	GOTO       L__main213
	MOVLW      13
	XORWF      R0+0, 0
L__main213:
	BTFSC      STATUS+0, 2
	GOTO       L_main132
;MyProject.c,32 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main133:
	DECFSZ     R13+0, 1
	GOTO       L_main133
	DECFSZ     R12+0, 1
	GOTO       L_main133
	DECFSZ     R11+0, 1
	GOTO       L_main133
	NOP
	NOP
	GOTO       L_main131
L_main132:
;MyProject.c,34 :: 		cdirection=UP; // начальное направление - вверх
	MOVLW      1
	MOVWF      _cdirection+0
;MyProject.c,35 :: 		cX=WorldSize-isSafeX()/2-1;  // получаем текущие координаты
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	BTFSC      R1+0, 6
	BSF        R1+0, 7
	MOVF       R1+0, 0
	SUBLW      30
	MOVWF      _cX+0
	CLRF       _cX+1
	BTFSS      STATUS+0, 0
	DECF       _cX+1, 1
	MOVLW      1
	BTFSS      R1+0, 7
	MOVLW      0
	ADDWF      _cX+1, 1
	MOVLW      1
	SUBWF      _cX+0, 1
	BTFSS      STATUS+0, 0
	DECF       _cX+1, 1
;MyProject.c,36 :: 		cY=WorldSize-isSafeY()/2-1;
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RRF        R1+0, 1
	BCF        R1+0, 7
	BTFSC      R1+0, 6
	BSF        R1+0, 7
	MOVF       R1+0, 0
	SUBLW      30
	MOVWF      _cY+0
	CLRF       _cY+1
	BTFSS      STATUS+0, 0
	DECF       _cY+1, 1
	MOVLW      1
	BTFSS      R1+0, 7
	MOVLW      0
	ADDWF      _cY+1, 1
	MOVLW      1
	SUBWF      _cY+0, 1
	BTFSS      STATUS+0, 0
	DECF       _cY+1, 1
;MyProject.c,39 :: 		while(getParam("jobisdone?",1,1)!=13)
L_main134:
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
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main214
	MOVLW      13
	XORWF      R0+0, 0
L__main214:
	BTFSC      STATUS+0, 2
	GOTO       L_main135
;MyProject.c,43 :: 		x=isSafeX();
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      main_x_L0+0
	MOVLW      0
	BTFSC      main_x_L0+0, 7
	MOVLW      255
	MOVWF      main_x_L0+1
;MyProject.c,44 :: 		y=isSafeY();
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      main_y_L0+0
	MOVLW      0
	BTFSC      main_y_L0+0, 7
	MOVLW      255
	MOVWF      main_y_L0+1
;MyProject.c,46 :: 		if(x==100 || y==100)
	MOVLW      0
	XORWF      main_x_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main215
	MOVLW      100
	XORWF      main_x_L0+0, 0
L__main215:
	BTFSC      STATUS+0, 2
	GOTO       L__main168
	MOVLW      0
	XORWF      main_y_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main216
	MOVLW      100
	XORWF      main_y_L0+0, 0
L__main216:
	BTFSC      STATUS+0, 2
	GOTO       L__main168
	GOTO       L_main138
L__main168:
;MyProject.c,48 :: 		if(cX<=20 && cY<=10)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main217
	MOVF       _cX+0, 0
	SUBLW      20
L__main217:
	BTFSS      STATUS+0, 0
	GOTO       L_main141
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main218
	MOVF       _cY+0, 0
	SUBLW      10
L__main218:
	BTFSS      STATUS+0, 0
	GOTO       L_main141
L__main167:
;MyProject.c,49 :: 		nd=DOWN;
	MOVLW      5
	MOVWF      main_nd_L1+0
L_main141:
;MyProject.c,50 :: 		if(cX>20 && cY<=10)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main219
	MOVF       _cX+0, 0
	SUBLW      20
L__main219:
	BTFSC      STATUS+0, 0
	GOTO       L_main144
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main220
	MOVF       _cY+0, 0
	SUBLW      10
L__main220:
	BTFSS      STATUS+0, 0
	GOTO       L_main144
L__main166:
;MyProject.c,51 :: 		nd=RIGHT;
	MOVLW      3
	MOVWF      main_nd_L1+0
L_main144:
;MyProject.c,52 :: 		if(cY<=20 && cY>10 && cX<=20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main221
	MOVF       _cY+0, 0
	SUBLW      20
L__main221:
	BTFSS      STATUS+0, 0
	GOTO       L_main147
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main222
	MOVF       _cY+0, 0
	SUBLW      10
L__main222:
	BTFSC      STATUS+0, 0
	GOTO       L_main147
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main223
	MOVF       _cX+0, 0
	SUBLW      20
L__main223:
	BTFSS      STATUS+0, 0
	GOTO       L_main147
L__main165:
;MyProject.c,53 :: 		nd=LEFT;
	MOVLW      7
	MOVWF      main_nd_L1+0
L_main147:
;MyProject.c,54 :: 		if(cY<=20 && cY>10 && cX>20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main224
	MOVF       _cY+0, 0
	SUBLW      20
L__main224:
	BTFSS      STATUS+0, 0
	GOTO       L_main150
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main225
	MOVF       _cY+0, 0
	SUBLW      10
L__main225:
	BTFSC      STATUS+0, 0
	GOTO       L_main150
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main226
	MOVF       _cX+0, 0
	SUBLW      20
L__main226:
	BTFSC      STATUS+0, 0
	GOTO       L_main150
L__main164:
;MyProject.c,55 :: 		nd=RIGHT;
	MOVLW      3
	MOVWF      main_nd_L1+0
L_main150:
;MyProject.c,56 :: 		if(cY>20 && cX<=20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main227
	MOVF       _cY+0, 0
	SUBLW      20
L__main227:
	BTFSC      STATUS+0, 0
	GOTO       L_main153
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main228
	MOVF       _cX+0, 0
	SUBLW      20
L__main228:
	BTFSS      STATUS+0, 0
	GOTO       L_main153
L__main163:
;MyProject.c,57 :: 		nd=LEFT;
	MOVLW      7
	MOVWF      main_nd_L1+0
L_main153:
;MyProject.c,58 :: 		if(cY>20 && cX>20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main229
	MOVF       _cY+0, 0
	SUBLW      20
L__main229:
	BTFSC      STATUS+0, 0
	GOTO       L_main156
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main230
	MOVF       _cX+0, 0
	SUBLW      20
L__main230:
	BTFSC      STATUS+0, 0
	GOTO       L_main156
L__main162:
;MyProject.c,59 :: 		nd=UP;
	MOVLW      1
	MOVWF      main_nd_L1+0
L_main156:
;MyProject.c,60 :: 		SRotare(cdirection,nd);
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVF       main_nd_L1+0, 0
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;MyProject.c,61 :: 		cdirection=nd;
	MOVF       main_nd_L1+0, 0
	MOVWF      _cdirection+0
;MyProject.c,62 :: 		}
L_main138:
;MyProject.c,63 :: 		A_search();
	CALL       _A_search+0
;MyProject.c,64 :: 		}
	GOTO       L_main134
L_main135:
;MyProject.c,65 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
