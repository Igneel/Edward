
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
L__Adc_Rd166:
;adc.h,5 :: 		TRISA |= (1<<ch);
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd187:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd188
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd187
L__Adc_Rd188:
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
L__Adc_Rd165:
;adc.h,9 :: 		TRISE |= (1<<(ch-5));
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd189:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd190
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd189
L__Adc_Rd190:
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
L__Adc_Rd191:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd192
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd191
L__Adc_Rd192:
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
L__Adc_Rd193:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd194
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd193
L__Adc_Rd194:
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
	GOTO       L__isSafeY196
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeY196:
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
	GOTO       L__isSafeX198
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeX198:
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
;a.h,88 :: 		return temp;
	MOVLW      0
	MOVWF      R0+1
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
L__isMetall167:
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

;a.h,116 :: 		short comp(int d1,int d2)
;a.h,118 :: 		if(d1==d2) return 0; // операнды равны
	MOVF       FARG_comp_d1+1, 0
	XORWF      FARG_comp_d2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp205
	MOVF       FARG_comp_d2+0, 0
	XORWF      FARG_comp_d1+0, 0
L__comp205:
	BTFSS      STATUS+0, 2
	GOTO       L_comp29
	CLRF       R0+0
	GOTO       L_end_comp
L_comp29:
;a.h,119 :: 		if(d1>d2) return 1; // первый больше второго
	MOVLW      128
	XORWF      FARG_comp_d2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp206
	MOVF       FARG_comp_d1+0, 0
	SUBWF      FARG_comp_d2+0, 0
L__comp206:
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

;a.h,124 :: 		short SMove(int nx,int ny)
;a.h,127 :: 		enum direction nd=1; // относительное направление движения
	MOVLW      1
	MOVWF      SMove_nd_L0+0
	MOVLW      1
	MOVWF      SMove_ax_L0+0
	MOVLW      1
	MOVWF      SMove_ry_L0+0
	CLRF       SMove_isMove_L0+0
;a.h,131 :: 		ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
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
;a.h,133 :: 		ry==comp(cY,ny);
	MOVF       _cY+0, 0
	MOVWF      FARG_comp_d1+0
	MOVF       _cY+1, 0
	MOVWF      FARG_comp_d1+1
	MOVF       FARG_SMove_ny+0, 0
	MOVWF      FARG_comp_d2+0
	MOVF       FARG_SMove_ny+1, 0
	MOVWF      FARG_comp_d2+1
	CALL       _comp+0
;a.h,135 :: 		if(ax==-1)  // если нам нужно направо
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove32
;a.h,136 :: 		nd=RIGHT+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove32:
;a.h,137 :: 		if(ax==0)    // смещаться по оси х не нужно
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove33
;a.h,138 :: 		switch(ry)
	GOTO       L_SMove34
;a.h,140 :: 		case -1: //
L_SMove36:
;a.h,141 :: 		nd=UP;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,142 :: 		break;
	GOTO       L_SMove35
;a.h,143 :: 		case 0:
L_SMove37:
;a.h,144 :: 		nd=ZEROD;
	MOVLW      9
	MOVWF      SMove_nd_L0+0
;a.h,146 :: 		break;
	GOTO       L_SMove35
;a.h,147 :: 		case 1:
L_SMove38:
;a.h,148 :: 		nd=DOWN;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,149 :: 		break;
	GOTO       L_SMove35
;a.h,151 :: 		}
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
;a.h,152 :: 		if(ax==1)   // если нам нужно налево
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove39
;a.h,153 :: 		nd=LEFT-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove39:
;a.h,156 :: 		switch (nd)
	GOTO       L_SMove40
;a.h,158 :: 		case 1:
L_SMove42:
;a.h,159 :: 		case UP:
L_SMove43:
;a.h,160 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove44
;a.h,162 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,163 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,164 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,165 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,166 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove45:
	DECFSZ     R13+0, 1
	GOTO       L_SMove45
	DECFSZ     R12+0, 1
	GOTO       L_SMove45
	DECFSZ     R11+0, 1
	GOTO       L_SMove45
;a.h,167 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,168 :: 		Correct();
	CALL       _Correct+0
;a.h,169 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,170 :: 		}
L_SMove44:
;a.h,171 :: 		break;
	GOTO       L_SMove41
;a.h,172 :: 		case 2:
L_SMove46:
;a.h,173 :: 		case RUP:
L_SMove47:
;a.h,174 :: 		if(isSafeY()>2 && isSafeX()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove50
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove50
L__SMove168:
;a.h,176 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,177 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,178 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,179 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,180 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,181 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,182 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove52:
	DECFSZ     R13+0, 1
	GOTO       L_SMove52
	DECFSZ     R12+0, 1
	GOTO       L_SMove52
	DECFSZ     R11+0, 1
	GOTO       L_SMove52
;a.h,183 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,184 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,185 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove53:
	DECFSZ     R13+0, 1
	GOTO       L_SMove53
	DECFSZ     R12+0, 1
	GOTO       L_SMove53
	DECFSZ     R11+0, 1
	GOTO       L_SMove53
	NOP
;a.h,186 :: 		Correct();
	CALL       _Correct+0
;a.h,187 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,188 :: 		}
L_SMove50:
;a.h,189 :: 		break;
	GOTO       L_SMove41
;a.h,190 :: 		case 3:
L_SMove54:
;a.h,191 :: 		case RIGHT:
L_SMove55:
;a.h,192 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove56
;a.h,194 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,195 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,196 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,197 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,198 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove57:
	DECFSZ     R13+0, 1
	GOTO       L_SMove57
	DECFSZ     R12+0, 1
	GOTO       L_SMove57
	DECFSZ     R11+0, 1
	GOTO       L_SMove57
;a.h,199 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,200 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,201 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove58:
	DECFSZ     R13+0, 1
	GOTO       L_SMove58
	DECFSZ     R12+0, 1
	GOTO       L_SMove58
	DECFSZ     R11+0, 1
	GOTO       L_SMove58
	NOP
;a.h,202 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,203 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,204 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,205 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,206 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove59:
	DECFSZ     R13+0, 1
	GOTO       L_SMove59
	DECFSZ     R12+0, 1
	GOTO       L_SMove59
	DECFSZ     R11+0, 1
	GOTO       L_SMove59
;a.h,207 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,208 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,209 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,210 :: 		Correct();
	CALL       _Correct+0
;a.h,211 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,212 :: 		}
L_SMove56:
;a.h,213 :: 		break;
	GOTO       L_SMove41
;a.h,214 :: 		case 4:
L_SMove61:
;a.h,215 :: 		case RDOWN:
L_SMove62:
;a.h,216 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove63
;a.h,218 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,219 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove64:
	DECFSZ     R13+0, 1
	GOTO       L_SMove64
	DECFSZ     R12+0, 1
	GOTO       L_SMove64
	DECFSZ     R11+0, 1
	GOTO       L_SMove64
	NOP
;a.h,220 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,221 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,222 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,223 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,224 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove65:
	DECFSZ     R13+0, 1
	GOTO       L_SMove65
	DECFSZ     R12+0, 1
	GOTO       L_SMove65
	DECFSZ     R11+0, 1
	GOTO       L_SMove65
;a.h,225 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,226 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,227 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,228 :: 		Correct();
	CALL       _Correct+0
;a.h,229 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,230 :: 		}
L_SMove63:
;a.h,231 :: 		break;
	GOTO       L_SMove41
;a.h,232 :: 		case 5:
L_SMove67:
;a.h,233 :: 		case DOWN:
L_SMove68:
;a.h,234 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,235 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,236 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,237 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,238 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove69:
	DECFSZ     R13+0, 1
	GOTO       L_SMove69
	DECFSZ     R12+0, 1
	GOTO       L_SMove69
	DECFSZ     R11+0, 1
	GOTO       L_SMove69
;a.h,239 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,240 :: 		Motor_Init();
	CALL       _Motor_Init+0
;a.h,241 :: 		Correct();
	CALL       _Correct+0
;a.h,242 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,243 :: 		break;
	GOTO       L_SMove41
;a.h,244 :: 		case 6:
L_SMove70:
;a.h,245 :: 		case LDOWN:
L_SMove71:
;a.h,246 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,247 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove72:
	DECFSZ     R13+0, 1
	GOTO       L_SMove72
	DECFSZ     R12+0, 1
	GOTO       L_SMove72
	DECFSZ     R11+0, 1
	GOTO       L_SMove72
	NOP
;a.h,248 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,249 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,250 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,251 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,252 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove73:
	DECFSZ     R13+0, 1
	GOTO       L_SMove73
	DECFSZ     R12+0, 1
	GOTO       L_SMove73
	DECFSZ     R11+0, 1
	GOTO       L_SMove73
;a.h,253 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,254 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,255 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove74:
	DECFSZ     R13+0, 1
	GOTO       L_SMove74
	DECFSZ     R12+0, 1
	GOTO       L_SMove74
	DECFSZ     R11+0, 1
	GOTO       L_SMove74
	NOP
;a.h,256 :: 		Correct();
	CALL       _Correct+0
;a.h,257 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,258 :: 		break;
	GOTO       L_SMove41
;a.h,259 :: 		case 7:
L_SMove75:
;a.h,260 :: 		case LEFT:
L_SMove76:
;a.h,261 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,262 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,263 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,264 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,265 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,266 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,267 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,268 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,269 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,270 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,271 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,272 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,273 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove79:
	DECFSZ     R13+0, 1
	GOTO       L_SMove79
	DECFSZ     R12+0, 1
	GOTO       L_SMove79
	DECFSZ     R11+0, 1
	GOTO       L_SMove79
;a.h,274 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,275 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,276 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove80:
	DECFSZ     R13+0, 1
	GOTO       L_SMove80
	DECFSZ     R12+0, 1
	GOTO       L_SMove80
	DECFSZ     R11+0, 1
	GOTO       L_SMove80
	NOP
;a.h,277 :: 		Correct();
	CALL       _Correct+0
;a.h,278 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,279 :: 		break;
	GOTO       L_SMove41
;a.h,280 :: 		case 8:
L_SMove81:
;a.h,281 :: 		case LUP:
L_SMove82:
;a.h,282 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	XORLW      2
	MOVWF      R1+0
	MOVLW      128
	XORWF      R0+0, 0
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SMove83
;a.h,284 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,285 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove84:
	DECFSZ     R13+0, 1
	GOTO       L_SMove84
	DECFSZ     R12+0, 1
	GOTO       L_SMove84
	DECFSZ     R11+0, 1
	GOTO       L_SMove84
	NOP
;a.h,286 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,287 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,288 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,289 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,290 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      4
	MOVWF      R11+0
	MOVLW      155
	MOVWF      R12+0
	MOVLW      15
	MOVWF      R13+0
L_SMove85:
	DECFSZ     R13+0, 1
	GOTO       L_SMove85
	DECFSZ     R12+0, 1
	GOTO       L_SMove85
	DECFSZ     R11+0, 1
	GOTO       L_SMove85
;a.h,291 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,292 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,293 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      112
	MOVWF      R12+0
	MOVLW      92
	MOVWF      R13+0
L_SMove86:
	DECFSZ     R13+0, 1
	GOTO       L_SMove86
	DECFSZ     R12+0, 1
	GOTO       L_SMove86
	DECFSZ     R11+0, 1
	GOTO       L_SMove86
	NOP
;a.h,294 :: 		Correct();
	CALL       _Correct+0
;a.h,295 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,296 :: 		}
L_SMove83:
;a.h,297 :: 		break;
	GOTO       L_SMove41
;a.h,298 :: 		case 9:
L_SMove87:
;a.h,299 :: 		case ZEROD:
L_SMove88:
;a.h,300 :: 		getParam("zerod",1,1);
	MOVLW      ?lstr_1_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_1_MyProject+0)
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
;a.h,301 :: 		break;
	GOTO       L_SMove41
;a.h,302 :: 		}
L_SMove40:
	MOVF       SMove_nd_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove42
	MOVF       SMove_nd_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove43
	MOVF       SMove_nd_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_SMove46
	MOVF       SMove_nd_L0+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_SMove47
	MOVF       SMove_nd_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SMove54
	MOVF       SMove_nd_L0+0, 0
	XORLW      3
	BTFSC      STATUS+0, 2
	GOTO       L_SMove55
	MOVF       SMove_nd_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_SMove61
	MOVF       SMove_nd_L0+0, 0
	XORLW      4
	BTFSC      STATUS+0, 2
	GOTO       L_SMove62
	MOVF       SMove_nd_L0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SMove67
	MOVF       SMove_nd_L0+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L_SMove68
	MOVF       SMove_nd_L0+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_SMove70
	MOVF       SMove_nd_L0+0, 0
	XORLW      6
	BTFSC      STATUS+0, 2
	GOTO       L_SMove71
	MOVF       SMove_nd_L0+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SMove75
	MOVF       SMove_nd_L0+0, 0
	XORLW      7
	BTFSC      STATUS+0, 2
	GOTO       L_SMove76
	MOVF       SMove_nd_L0+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_SMove81
	MOVF       SMove_nd_L0+0, 0
	XORLW      8
	BTFSC      STATUS+0, 2
	GOTO       L_SMove82
	MOVF       SMove_nd_L0+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_SMove87
	MOVF       SMove_nd_L0+0, 0
	XORLW      9
	BTFSC      STATUS+0, 2
	GOTO       L_SMove88
L_SMove41:
;a.h,305 :: 		if(isMetall()) // проверяем есть ли тут монетка
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove89
;a.h,308 :: 		if(isMove)
	MOVF       SMove_isMove_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove90
;a.h,309 :: 		setParam("Metall",nx,ny,1);
	MOVLW      ?lstr_2_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_2_MyProject+0)
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
L_SMove90:
;a.h,310 :: 		}
L_SMove89:
;a.h,311 :: 		return isMove;    // сообщаем было ли движение
	MOVF       SMove_isMove_L0+0, 0
	MOVWF      R0+0
;a.h,313 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_SRotare:

;a.h,317 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,320 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,321 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare91
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare91:
;a.h,322 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare92
;a.h,324 :: 		S_Right(255); // поворачиваемся по наименьшему пути
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,325 :: 		for(;r>0;r--)
L_SRotare93:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare94
;a.h,326 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare96:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare96
	DECFSZ     R12+0, 1
	GOTO       L_SRotare96
	DECFSZ     R11+0, 1
	GOTO       L_SRotare96
	NOP
	NOP
;a.h,325 :: 		for(;r>0;r--)
	DECF       SRotare_r_L0+0, 1
;a.h,326 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	GOTO       L_SRotare93
L_SRotare94:
;a.h,327 :: 		}
	GOTO       L_SRotare97
L_SRotare92:
;a.h,330 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,331 :: 		for(;r<0;r++)
L_SRotare98:
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare99
;a.h,332 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	MOVLW      8
	MOVWF      R11+0
	MOVLW      79
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_SRotare101:
	DECFSZ     R13+0, 1
	GOTO       L_SRotare101
	DECFSZ     R12+0, 1
	GOTO       L_SRotare101
	DECFSZ     R11+0, 1
	GOTO       L_SRotare101
	NOP
	NOP
;a.h,331 :: 		for(;r<0;r++)
	INCF       SRotare_r_L0+0, 1
;a.h,332 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
	GOTO       L_SRotare98
L_SRotare99:
;a.h,333 :: 		}
L_SRotare97:
;a.h,334 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,335 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_Correct:

;a.h,338 :: 		void Correct(void) // корректирует направление робота
;a.h,341 :: 		r=isSafeY();                // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_r_L0+0
;a.h,342 :: 		S_Left(DELAY_TIME_VR_10);  // повернуться
	MOVLW      64
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,343 :: 		nr=isSafeY();               // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_nr_L0+0
;a.h,344 :: 		if(r==nr)                   // сравнить их, если получаем правильное соотношение
	MOVF       Correct_r_L0+0, 0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Correct102
;a.h,345 :: 		S_Right(DELAY_TIME_VR_10);  // то мы находимся в правильном положении
	MOVLW      64
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct102:
;a.h,346 :: 		if(r>nr)
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct103
;a.h,347 :: 		return;
	GOTO       L_end_Correct
L_Correct103:
;a.h,348 :: 		if(r<nr)
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct104
;a.h,349 :: 		S_Right(2*DELAY_TIME_VR_10);
	MOVLW      128
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct104:
;a.h,350 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,351 :: 		}
L_end_Correct:
	RETURN
; end of _Correct

_A_search:

;a.h,356 :: 		void A_search()
;a.h,361 :: 		if(getParam("jobisdone?",1,1)==13) return; // если база говорит что работа окончена - завершаем работу.
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
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search211
	MOVLW      13
	XORWF      R0+0, 0
L__A_search211:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search105
	GOTO       L_end_A_search
L_A_search105:
;a.h,363 :: 		temp=getParam("Hint",cX,cY); // получаем значение для текущего состояния
	MOVLW      ?lstr_4_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_4_MyProject+0)
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
;a.h,365 :: 		setParam("Hint",cX,cY,temp++); // увеличиваем его, т.к. мы уже здесь
	MOVLW      ?lstr_5_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_5_MyProject+0)
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
;a.h,367 :: 		min=getParam("H+hevr",cX,cY+1);//+getParam("hevr",cX,cY+1);
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
	MOVWF      A_search_min_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,368 :: 		cxx=0;
	CLRF       _cxx+0
;a.h,369 :: 		cyy=1;
	MOVLW      1
	MOVWF      _cyy+0
;a.h,370 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	MOVLW      255
	MOVWF      A_search_i_L0+0
	MOVLW      255
	MOVWF      A_search_i_L0+1
L_A_search106:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search212
	MOVF       A_search_i_L0+0, 0
	SUBLW      1
L__A_search212:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search107
;a.h,372 :: 		for(j=-1;j<=1;j++)//----------------------------------------------------------------------------------------------------------------------!!!!!
	MOVLW      255
	MOVWF      A_search_j_L0+0
	MOVLW      255
	MOVWF      A_search_j_L0+1
L_A_search109:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_j_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search213
	MOVF       A_search_j_L0+0, 0
	SUBLW      1
L__A_search213:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search110
;a.h,374 :: 		if(i==0 && j==0) continue;
	MOVLW      0
	XORWF      A_search_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search214
	MOVLW      0
	XORWF      A_search_i_L0+0, 0
L__A_search214:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search114
	MOVLW      0
	XORWF      A_search_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search215
	MOVLW      0
	XORWF      A_search_j_L0+0, 0
L__A_search215:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search114
L__A_search169:
	GOTO       L_A_search111
L_A_search114:
;a.h,375 :: 		temp=getParam("H+hevr",cX+i,cY+j);//+getParam("hevr",cX+i,cY+j);
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
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
;a.h,376 :: 		if(temp<min) // имеющее минимальную стоимость
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      A_search_min_L0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search216
	MOVF       A_search_min_L0+0, 0
	SUBWF      R0+0, 0
L__A_search216:
	BTFSC      STATUS+0, 0
	GOTO       L_A_search115
;a.h,378 :: 		min=temp;
	MOVF       A_search_temp_L0+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       A_search_temp_L0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,379 :: 		cxx=i;
	MOVF       A_search_i_L0+0, 0
	MOVWF      _cxx+0
;a.h,380 :: 		cyy=j;
	MOVF       A_search_j_L0+0, 0
	MOVWF      _cyy+0
;a.h,381 :: 		}
L_A_search115:
;a.h,382 :: 		}
L_A_search111:
;a.h,372 :: 		for(j=-1;j<=1;j++)//----------------------------------------------------------------------------------------------------------------------!!!!!
	INCF       A_search_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_j_L0+1, 1
;a.h,382 :: 		}
	GOTO       L_A_search109
L_A_search110:
;a.h,370 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	INCF       A_search_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_i_L0+1, 1
;a.h,383 :: 		}
	GOTO       L_A_search106
L_A_search107:
;a.h,385 :: 		if(cdirection==UP) ;
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_A_search116
L_A_search116:
;a.h,386 :: 		if(cdirection==DOWN) cyy*=-1 ;
	MOVF       _cdirection+0, 0
	XORLW      5
	BTFSS      STATUS+0, 2
	GOTO       L_A_search117
	MOVF       _cyy+0, 0
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _cyy+0
L_A_search117:
;a.h,387 :: 		if(cdirection==LEFT)
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_A_search118
;a.h,389 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,390 :: 		cxx=cyy;
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;a.h,391 :: 		cyy=-temp;
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;a.h,392 :: 		}
L_A_search118:
;a.h,393 :: 		if(cdirection==RIGHT)
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_A_search119
;a.h,395 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,396 :: 		cxx=cyy;
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;a.h,397 :: 		cyy=-temp;
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;a.h,398 :: 		}
L_A_search119:
;a.h,400 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
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
	GOTO       L_A_search120
;a.h,403 :: 		cX+=cxx; // обновление текущих координат
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cX+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      _cX+1, 1
;a.h,404 :: 		cY+=cyy;
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cY+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      _cY+1, 1
;a.h,405 :: 		}
L_A_search120:
;a.h,409 :: 		}
L_end_A_search:
	RETURN
; end of _A_search

_mod:

;a.h,412 :: 		short mod(short x)
;a.h,414 :: 		if(x>=0) return x;
	MOVLW      128
	XORWF      FARG_mod_x+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mod121
	MOVF       FARG_mod_x+0, 0
	MOVWF      R0+0
	GOTO       L_end_mod
L_mod121:
;a.h,415 :: 		else return -x;
	MOVF       FARG_mod_x+0, 0
	SUBLW      0
	MOVWF      R0+0
;a.h,416 :: 		}
L_end_mod:
	RETURN
; end of _mod

_Brain:

;a.h,418 :: 		void Brain()
;a.h,423 :: 		for(x=0;x<WorldSize;x++)
	CLRF       Brain_x_L0+0
L_Brain123:
	MOVLW      128
	XORWF      Brain_x_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain124
;a.h,425 :: 		for(y=0;y<WorldSize;y++)
	CLRF       Brain_y_L0+0
L_Brain126:
	MOVLW      128
	XORWF      Brain_y_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain127
;a.h,427 :: 		if(getParam("Hint",x,y)/*H[x][y]*/!=0) continue; // если значение не нулевое- значит мы там были и всё нашли.
	MOVLW      ?lstr_8_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_8_MyProject+0)
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
	GOTO       L__Brain219
	MOVLW      0
	XORWF      R0+0, 0
L__Brain219:
	BTFSC      STATUS+0, 2
	GOTO       L_Brain129
	GOTO       L_Brain128
L_Brain129:
;a.h,428 :: 		for(j=0;j<WorldSize;j++) // x
	CLRF       Brain_j_L0+0
L_Brain130:
	MOVLW      128
	XORWF      Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain131
;a.h,429 :: 		for(k=0;k<WorldSize;k++) // y
	CLRF       Brain_k_L0+0
L_Brain133:
	MOVLW      128
	XORWF      Brain_k_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      30
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain134
;a.h,431 :: 		r=mod(x-j)+mod(y-k);  // манхетенское расстояние
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
;a.h,432 :: 		if(r<getParam("hevr",j,k)) setParam("hevr",j,k,r); //h_evr[j][k])  // h_evr[j][k]=r; // если есть цель ближе - запишем расстояние до неё
	MOVLW      ?lstr_9_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_9_MyProject+0)
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
	GOTO       L__Brain220
	MOVF       R0+0, 0
	SUBWF      Brain_r_L0+0, 0
L__Brain220:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain136
	MOVLW      ?lstr_10_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_10_MyProject+0)
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
L_Brain136:
;a.h,429 :: 		for(k=0;k<WorldSize;k++) // y
	INCF       Brain_k_L0+0, 1
;a.h,433 :: 		}
	GOTO       L_Brain133
L_Brain134:
;a.h,428 :: 		for(j=0;j<WorldSize;j++) // x
	INCF       Brain_j_L0+0, 1
;a.h,433 :: 		}
	GOTO       L_Brain130
L_Brain131:
;a.h,434 :: 		}
L_Brain128:
;a.h,425 :: 		for(y=0;y<WorldSize;y++)
	INCF       Brain_y_L0+0, 1
;a.h,434 :: 		}
	GOTO       L_Brain126
L_Brain127:
;a.h,423 :: 		for(x=0;x<WorldSize;x++)
	INCF       Brain_x_L0+0, 1
;a.h,435 :: 		}
	GOTO       L_Brain123
L_Brain124:
;a.h,436 :: 		}
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
L_main137:
	MOVLW      ?lstr_11_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_11_MyProject+0)
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
	GOTO       L__main223
	MOVLW      13
	XORWF      R0+0, 0
L__main223:
	BTFSC      STATUS+0, 2
	GOTO       L_main138
;MyProject.c,32 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main139:
	DECFSZ     R13+0, 1
	GOTO       L_main139
	DECFSZ     R12+0, 1
	GOTO       L_main139
	DECFSZ     R11+0, 1
	GOTO       L_main139
	NOP
	NOP
	GOTO       L_main137
L_main138:
;MyProject.c,34 :: 		cdirection=UP; // начальное направление - вверх
	MOVLW      1
	MOVWF      _cdirection+0
;MyProject.c,36 :: 		cX=WorldSize-isSafeX()/2-1;  // получаем текущие координаты
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
;MyProject.c,37 :: 		cY=WorldSize-isSafeY()/2-1;
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
;MyProject.c,38 :: 		if(cX<0) cX=0;
	MOVLW      128
	XORWF      _cX+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main224
	MOVLW      0
	SUBWF      _cX+0, 0
L__main224:
	BTFSC      STATUS+0, 0
	GOTO       L_main140
	CLRF       _cX+0
	CLRF       _cX+1
L_main140:
;MyProject.c,39 :: 		if(cY<0) cY=0;
	MOVLW      128
	XORWF      _cY+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main225
	MOVLW      0
	SUBWF      _cY+0, 0
L__main225:
	BTFSC      STATUS+0, 0
	GOTO       L_main141
	CLRF       _cY+0
	CLRF       _cY+1
L_main141:
;MyProject.c,42 :: 		while(getParam("jobisdone?",1,1)!=13)
L_main142:
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
	GOTO       L__main226
	MOVLW      13
	XORWF      R0+0, 0
L__main226:
	BTFSC      STATUS+0, 2
	GOTO       L_main143
;MyProject.c,46 :: 		x=isSafeX();
	CALL       _isSafeX+0
	MOVF       R0+0, 0
	MOVWF      main_x_L0+0
	MOVLW      0
	BTFSC      main_x_L0+0, 7
	MOVLW      255
	MOVWF      main_x_L0+1
;MyProject.c,47 :: 		y=isSafeY();
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      main_y_L0+0
	MOVLW      0
	BTFSC      main_y_L0+0, 7
	MOVLW      255
	MOVWF      main_y_L0+1
;MyProject.c,49 :: 		if(x==100 || y==100)
	MOVLW      0
	XORWF      main_x_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main227
	MOVLW      100
	XORWF      main_x_L0+0, 0
L__main227:
	BTFSC      STATUS+0, 2
	GOTO       L__main176
	MOVLW      0
	XORWF      main_y_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main228
	MOVLW      100
	XORWF      main_y_L0+0, 0
L__main228:
	BTFSC      STATUS+0, 2
	GOTO       L__main176
	GOTO       L_main146
L__main176:
;MyProject.c,51 :: 		if(cX<=20 && cY<=10)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main229
	MOVF       _cX+0, 0
	SUBLW      20
L__main229:
	BTFSS      STATUS+0, 0
	GOTO       L_main149
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main230
	MOVF       _cY+0, 0
	SUBLW      10
L__main230:
	BTFSS      STATUS+0, 0
	GOTO       L_main149
L__main175:
;MyProject.c,52 :: 		nd=DOWN;
	MOVLW      5
	MOVWF      main_nd_L1+0
L_main149:
;MyProject.c,53 :: 		if(cX>20 && cY<=10)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main231
	MOVF       _cX+0, 0
	SUBLW      20
L__main231:
	BTFSC      STATUS+0, 0
	GOTO       L_main152
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main232
	MOVF       _cY+0, 0
	SUBLW      10
L__main232:
	BTFSS      STATUS+0, 0
	GOTO       L_main152
L__main174:
;MyProject.c,54 :: 		nd=RIGHT;
	MOVLW      3
	MOVWF      main_nd_L1+0
L_main152:
;MyProject.c,55 :: 		if(cY<=20 && cY>10 && cX<=20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main233
	MOVF       _cY+0, 0
	SUBLW      20
L__main233:
	BTFSS      STATUS+0, 0
	GOTO       L_main155
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main234
	MOVF       _cY+0, 0
	SUBLW      10
L__main234:
	BTFSC      STATUS+0, 0
	GOTO       L_main155
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main235
	MOVF       _cX+0, 0
	SUBLW      20
L__main235:
	BTFSS      STATUS+0, 0
	GOTO       L_main155
L__main173:
;MyProject.c,56 :: 		nd=LEFT;
	MOVLW      7
	MOVWF      main_nd_L1+0
L_main155:
;MyProject.c,57 :: 		if(cY<=20 && cY>10 && cX>20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main236
	MOVF       _cY+0, 0
	SUBLW      20
L__main236:
	BTFSS      STATUS+0, 0
	GOTO       L_main158
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main237
	MOVF       _cY+0, 0
	SUBLW      10
L__main237:
	BTFSC      STATUS+0, 0
	GOTO       L_main158
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main238
	MOVF       _cX+0, 0
	SUBLW      20
L__main238:
	BTFSC      STATUS+0, 0
	GOTO       L_main158
L__main172:
;MyProject.c,58 :: 		nd=RIGHT;
	MOVLW      3
	MOVWF      main_nd_L1+0
L_main158:
;MyProject.c,59 :: 		if(cY>20 && cX<=20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main239
	MOVF       _cY+0, 0
	SUBLW      20
L__main239:
	BTFSC      STATUS+0, 0
	GOTO       L_main161
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main240
	MOVF       _cX+0, 0
	SUBLW      20
L__main240:
	BTFSS      STATUS+0, 0
	GOTO       L_main161
L__main171:
;MyProject.c,60 :: 		nd=LEFT;
	MOVLW      7
	MOVWF      main_nd_L1+0
L_main161:
;MyProject.c,61 :: 		if(cY>20 && cX>20)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cY+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main241
	MOVF       _cY+0, 0
	SUBLW      20
L__main241:
	BTFSC      STATUS+0, 0
	GOTO       L_main164
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _cX+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main242
	MOVF       _cX+0, 0
	SUBLW      20
L__main242:
	BTFSC      STATUS+0, 0
	GOTO       L_main164
L__main170:
;MyProject.c,62 :: 		nd=UP;
	MOVLW      1
	MOVWF      main_nd_L1+0
L_main164:
;MyProject.c,63 :: 		SRotare(cdirection,nd);
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVF       main_nd_L1+0, 0
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;MyProject.c,64 :: 		cdirection=nd;
	MOVF       main_nd_L1+0, 0
	MOVWF      _cdirection+0
;MyProject.c,66 :: 		cX=WorldSize-isSafeX()/2-1;  // получаем текущие координаты
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
;MyProject.c,67 :: 		cY=WorldSize-isSafeY()/2-1;
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
;MyProject.c,68 :: 		}
L_main146:
;MyProject.c,69 :: 		A_search();
	CALL       _A_search+0
;MyProject.c,70 :: 		}
	GOTO       L_main142
L_main143:
;MyProject.c,71 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
