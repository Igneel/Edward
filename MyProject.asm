
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
L__Adc_Rd133:
;adc.h,5 :: 		TRISA |= (1<<ch);
	MOVF       FARG_Adc_Rd_ch+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd146:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd147
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd146
L__Adc_Rd147:
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
L__Adc_Rd132:
;adc.h,9 :: 		TRISE |= (1<<(ch-5));
	MOVLW      5
	SUBWF      FARG_Adc_Rd_ch+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Adc_Rd148:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd149
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd148
L__Adc_Rd149:
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
L__Adc_Rd150:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd151
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Adc_Rd150
L__Adc_Rd151:
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
L__Adc_Rd152:
	BTFSC      STATUS+0, 2
	GOTO       L__Adc_Rd153
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__Adc_Rd152
L__Adc_Rd153:
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

;safedriving.h,14 :: 		int isSafeY()   // функция возвращает расстояние до объекта в сантиметрах по оси Y.
;safedriving.h,16 :: 		int Distance=100; // в эту переменную будем сохранять
	MOVLW      100
	MOVWF      isSafeY_Distance_L0+0
	MOVLW      0
	MOVWF      isSafeY_Distance_L0+1
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
	GOTO       L__isSafeY155
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeY155:
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
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      isSafeY_Distance_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeY_Distance_L0+1
;safedriving.h,22 :: 		}
L_isSafeY14:
;safedriving.h,23 :: 		return Distance;
	MOVF       isSafeY_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeY_Distance_L0+1, 0
	MOVWF      R0+1
;safedriving.h,25 :: 		}
L_end_isSafeY:
	RETURN
; end of _isSafeY

_isSafeX:

;safedriving.h,27 :: 		int isSafeX()   // функция возвращает расстояние до объекта в сантиметрах по оси Y.
;safedriving.h,29 :: 		int Distance=100; // в эту переменную будем сохранять
	MOVLW      100
	MOVWF      isSafeX_Distance_L0+0
	MOVLW      0
	MOVWF      isSafeX_Distance_L0+1
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
	GOTO       L__isSafeX157
	MOVF       R0+0, 0
	SUBLW      90
L__isSafeX157:
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
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      isSafeX_Distance_L0+0
	MOVF       R0+1, 0
	MOVWF      isSafeX_Distance_L0+1
;safedriving.h,35 :: 		}
L_isSafeX15:
;safedriving.h,36 :: 		return Distance;
	MOVF       isSafeX_Distance_L0+0, 0
	MOVWF      R0+0
	MOVF       isSafeX_Distance_L0+1, 0
	MOVWF      R0+1
;safedriving.h,38 :: 		}
L_end_isSafeX:
	RETURN
; end of _isSafeX

_strConstCpy:

;a.h,59 :: 		void strConstCpy (const char *source, char *dest) {
;a.h,60 :: 		while (*source) *dest++ = *source++;
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
;a.h,61 :: 		*dest = 0;
	MOVF       FARG_strConstCpy_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,62 :: 		}
L_end_strConstCpy:
	RETURN
; end of _strConstCpy

_stradd:

;a.h,63 :: 		void stradd(char *source, char *dest){
;a.h,64 :: 		while (*dest++);
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
;a.h,65 :: 		*dest--;
	DECF       FARG_stradd_dest+0, 1
;a.h,66 :: 		while (*source) *dest++ = *source++;
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
;a.h,67 :: 		*dest = 0;
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,68 :: 		}
L_end_stradd:
	RETURN
; end of _stradd

_getParam:

;a.h,70 :: 		int getParam(const char * p,int x,int y)
;a.h,72 :: 		char temp=0;
;a.h,73 :: 		strConstCpy(p,string); // копируем код команды
	MOVF       FARG_getParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_getParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;a.h,74 :: 		IntToStr (x,strint);
	MOVF       FARG_getParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,75 :: 		stradd(" g ",string);
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,76 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,77 :: 		IntToStr (y,strint);
	MOVF       FARG_getParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,78 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,79 :: 		stradd(" ",string);
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,80 :: 		stradd("    0 ",string);
	MOVLW      ?lstr3_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,81 :: 		UART1_Write_Text(string);
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;a.h,82 :: 		while(1) if(UART1_Data_Ready()) // ждем ответ
L_getParam22:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_getParam24
;a.h,84 :: 		temp=UART1_Read();
	CALL       _UART1_Read+0
;a.h,85 :: 		return temp;
	MOVLW      0
	MOVWF      R0+1
	GOTO       L_end_getParam
;a.h,86 :: 		}
L_getParam24:
	GOTO       L_getParam22
;a.h,87 :: 		}
L_end_getParam:
	RETURN
; end of _getParam

_setParam:

;a.h,89 :: 		void setParam(const char * p,int x,int y,int value)
;a.h,91 :: 		char temp=0;
;a.h,92 :: 		strConstCpy(p,string); // копируем код команды
	MOVF       FARG_setParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_setParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;a.h,94 :: 		IntToStr (x,strint);
	MOVF       FARG_setParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,95 :: 		stradd(" s ",string);
	MOVLW      ?lstr4_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,96 :: 		stradd(strint,string); // копируем первую координату
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
;a.h,98 :: 		stradd(strint,string); // копируем вторую координату
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
;a.h,100 :: 		stradd(strint,string);  // копируем значение
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,101 :: 		stradd(" ",string);    // дописываем символ пробела в конец строки
	MOVLW      ?lstr5_MyProject+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,102 :: 		UART1_Write_Text(string); // отправляем данные
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;a.h,103 :: 		while(1) if(UART1_Data_Ready()) // ждем ответ
L_setParam25:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_setParam27
;a.h,105 :: 		temp=UART1_Read();
	CALL       _UART1_Read+0
;a.h,106 :: 		return;
	GOTO       L_end_setParam
;a.h,107 :: 		}
L_setParam27:
	GOTO       L_setParam25
;a.h,108 :: 		}
L_end_setParam:
	RETURN
; end of _setParam

_isMetall:

;a.h,112 :: 		short isMetall()
;a.h,115 :: 		m=Adc_Rd(1);
	MOVLW      1
	MOVWF      FARG_Adc_Rd_ch+0
	CALL       _Adc_Rd+0
	MOVF       R0+0, 0
	MOVWF      isMetall_m_L0+0
;a.h,116 :: 		if(m>0 && m<50)
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
L__isMetall134:
;a.h,117 :: 		return 1;    // если объект металлический возвращаем единицу
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isMetall
L_isMetall30:
;a.h,119 :: 		return 0;
	CLRF       R0+0
;a.h,120 :: 		}
L_end_isMetall:
	RETURN
; end of _isMetall

_comp:

;a.h,122 :: 		short comp(int d1,int d2)
;a.h,124 :: 		if(d1==d2) return 0; // операнды равны
	MOVF       FARG_comp_d1+1, 0
	XORWF      FARG_comp_d2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp164
	MOVF       FARG_comp_d2+0, 0
	XORWF      FARG_comp_d1+0, 0
L__comp164:
	BTFSS      STATUS+0, 2
	GOTO       L_comp32
	CLRF       R0+0
	GOTO       L_end_comp
L_comp32:
;a.h,125 :: 		if(d1>d2) return 1; // первый больше второго
	MOVLW      128
	XORWF      FARG_comp_d2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__comp165
	MOVF       FARG_comp_d1+0, 0
	SUBWF      FARG_comp_d2+0, 0
L__comp165:
	BTFSC      STATUS+0, 0
	GOTO       L_comp33
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_comp
L_comp33:
;a.h,126 :: 		else return -1; // первый меньше второго
	MOVLW      255
	MOVWF      R0+0
;a.h,127 :: 		}
L_end_comp:
	RETURN
; end of _comp

_SMove:

;a.h,130 :: 		short SMove(int nx,int ny)
;a.h,133 :: 		enum direction nd=1; // относительное направление движения
	MOVLW      1
	MOVWF      SMove_nd_L0+0
	MOVLW      1
	MOVWF      SMove_ax_L0+0
	MOVLW      1
	MOVWF      SMove_ry_L0+0
	CLRF       SMove_temp1_L0+0
	CLRF       SMove_temp1_L0+1
	CLRF       SMove_isMove_L0+0
;a.h,139 :: 		ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
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
;a.h,140 :: 		ry=comp(cY,ny);
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
;a.h,142 :: 		if(ax==-1)  // если нам нужно направо
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove35
;a.h,143 :: 		nd=RIGHT+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove35:
;a.h,144 :: 		if(ax==0)    // смещаться по оси х не нужно
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove36
;a.h,145 :: 		switch(ry)
	GOTO       L_SMove37
;a.h,147 :: 		case -1: //
L_SMove39:
;a.h,148 :: 		nd=UP;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,149 :: 		break;
	GOTO       L_SMove38
;a.h,150 :: 		case 0:
L_SMove40:
;a.h,151 :: 		nd=ZEROD;
	MOVLW      9
	MOVWF      SMove_nd_L0+0
;a.h,153 :: 		break;
	GOTO       L_SMove38
;a.h,154 :: 		case 1:
L_SMove41:
;a.h,155 :: 		nd=DOWN;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,156 :: 		break;
	GOTO       L_SMove38
;a.h,158 :: 		}
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
;a.h,159 :: 		if(ax==1)   // если нам нужно налево
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove42
;a.h,160 :: 		nd=LEFT-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove42:
;a.h,162 :: 		temp1=isSafeY();
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      SMove_temp1_L0+0
	MOVF       R0+1, 0
	MOVWF      SMove_temp1_L0+1
;a.h,163 :: 		temp=isSafeX();
	CALL       _isSafeX+0
;a.h,164 :: 		getParam("isSafe",temp,temp1);
	MOVLW      ?lstr_6_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_6_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       R0+0, 0
	MOVWF      FARG_getParam_x+0
	MOVF       R0+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       SMove_temp1_L0+0, 0
	MOVWF      FARG_getParam_y+0
	MOVF       SMove_temp1_L0+1, 0
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
;a.h,165 :: 		switch (nd)
	GOTO       L_SMove43
;a.h,167 :: 		case 1:
L_SMove45:
;a.h,168 :: 		case UP:
L_SMove46:
;a.h,169 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove167
	MOVF       R0+0, 0
	SUBLW      2
L__SMove167:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove47
;a.h,172 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,173 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,174 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,175 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,176 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,177 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,178 :: 		Correct();
	CALL       _Correct+0
;a.h,179 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,180 :: 		}
L_SMove47:
;a.h,181 :: 		break;
	GOTO       L_SMove44
;a.h,182 :: 		case 2:
L_SMove49:
;a.h,183 :: 		case RUP:
L_SMove50:
;a.h,184 :: 		if(isSafeY()>2 && isSafeX()>2)
	CALL       _isSafeY+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove168
	MOVF       R0+0, 0
	SUBLW      2
L__SMove168:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove53
	CALL       _isSafeX+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove169
	MOVF       R0+0, 0
	SUBLW      2
L__SMove169:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove53
L__SMove135:
;a.h,186 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,187 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,188 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,189 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,190 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,191 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,192 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,193 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,194 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,195 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,196 :: 		Correct();
	CALL       _Correct+0
;a.h,197 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,198 :: 		}
L_SMove53:
;a.h,199 :: 		break;
	GOTO       L_SMove44
;a.h,200 :: 		case 3:
L_SMove57:
;a.h,201 :: 		case RIGHT:
L_SMove58:
;a.h,202 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove170
	MOVF       R0+0, 0
	SUBLW      2
L__SMove170:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove59
;a.h,204 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,205 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,206 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,207 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,208 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,209 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,210 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,211 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,212 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,213 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,214 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,215 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,216 :: 		delay_ms(3*DELAY_TIME_1sm); // ждем пока приедем  -------------------------------------------------------------------------------------------------
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
;a.h,217 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
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
L_SMove63:
	DECFSZ     R13+0, 1
	GOTO       L_SMove63
	DECFSZ     R12+0, 1
	GOTO       L_SMove63
	DECFSZ     R11+0, 1
	GOTO       L_SMove63
	NOP
;a.h,220 :: 		Correct();
	CALL       _Correct+0
;a.h,221 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,222 :: 		}
L_SMove59:
;a.h,223 :: 		break;
	GOTO       L_SMove44
;a.h,224 :: 		case 4:
L_SMove64:
;a.h,225 :: 		case RDOWN:
L_SMove65:
;a.h,226 :: 		if(isSafeX()>2)
	CALL       _isSafeX+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove171
	MOVF       R0+0, 0
	SUBLW      2
L__SMove171:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove66
;a.h,228 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,229 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,230 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,231 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,232 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,233 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,234 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,235 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,236 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,237 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,238 :: 		Correct();
	CALL       _Correct+0
;a.h,239 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,240 :: 		}
L_SMove66:
;a.h,241 :: 		break;
	GOTO       L_SMove44
;a.h,242 :: 		case 5:
L_SMove70:
;a.h,243 :: 		case DOWN:
L_SMove71:
;a.h,244 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,245 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,246 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,247 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,248 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,249 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,250 :: 		Motor_Init();
	CALL       _Motor_Init+0
;a.h,251 :: 		Correct();
	CALL       _Correct+0
;a.h,252 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,253 :: 		break;
	GOTO       L_SMove44
;a.h,254 :: 		case 6:
L_SMove73:
;a.h,255 :: 		case LDOWN:
L_SMove74:
;a.h,256 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,257 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,258 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,259 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,260 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,261 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,262 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,263 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,264 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,265 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,266 :: 		Correct();
	CALL       _Correct+0
;a.h,267 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,268 :: 		break;
	GOTO       L_SMove44
;a.h,269 :: 		case 7:
L_SMove78:
;a.h,270 :: 		case LEFT:
L_SMove79:
;a.h,271 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,272 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,273 :: 		Motor_A_BWD(); // запускаем моторы
	CALL       _Motor_A_BWD+0
;a.h,274 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,275 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,276 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,277 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,278 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,279 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,280 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,281 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,282 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,283 :: 		delay_ms(3*DELAY_TIME_1sm); // ждем пока приедем ----------------------------------------------------------------------------------------------
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
;a.h,284 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,285 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,286 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,287 :: 		Correct();
	CALL       _Correct+0
;a.h,288 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,289 :: 		break;
	GOTO       L_SMove44
;a.h,290 :: 		case 8:
L_SMove84:
;a.h,291 :: 		case LUP:
L_SMove85:
;a.h,292 :: 		if(isSafeY()>2)
	CALL       _isSafeY+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SMove172
	MOVF       R0+0, 0
	SUBLW      2
L__SMove172:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove86
;a.h,294 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,295 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,296 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,297 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,298 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,299 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,300 :: 		delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
;a.h,301 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,302 :: 		S_Right(255);
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,303 :: 		delay_ms(DELAY_TIME_VR_10*15/10);
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
;a.h,304 :: 		Correct();
	CALL       _Correct+0
;a.h,305 :: 		isMove=1;
	MOVLW      1
	MOVWF      SMove_isMove_L0+0
;a.h,306 :: 		}
L_SMove86:
;a.h,307 :: 		break;
	GOTO       L_SMove44
;a.h,308 :: 		case 9:
L_SMove90:
;a.h,309 :: 		case ZEROD:
L_SMove91:
;a.h,310 :: 		getParam("zerod ",1,1);
	MOVLW      ?lstr_7_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_7_MyProject+0)
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
;a.h,311 :: 		break;
	GOTO       L_SMove44
;a.h,312 :: 		}
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
;a.h,315 :: 		if(isMetall()) // проверяем есть ли тут монетка
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove92
;a.h,318 :: 		if(isMove)
	MOVF       SMove_isMove_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove93
;a.h,319 :: 		setParam("Metall",nx,ny,1);
	MOVLW      ?lstr_8_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_8_MyProject+0)
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
;a.h,320 :: 		}
L_SMove92:
;a.h,321 :: 		return isMove;    // сообщаем было ли движение
	MOVF       SMove_isMove_L0+0, 0
	MOVWF      R0+0
;a.h,323 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_SRotare:

;a.h,327 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,329 :: 		int xa=0;
	CLRF       SRotare_xa_L0+0
	CLRF       SRotare_xa_L0+1
	CLRF       SRotare_ya_L0+0
	CLRF       SRotare_ya_L0+1
	CLRF       SRotare_r_L0+0
;a.h,335 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,336 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
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
;a.h,337 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare95
;a.h,339 :: 		S_Right(255); // поворачиваемся по наименьшему пути
	MOVLW      255
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
;a.h,340 :: 		for(;r>0;r--)
L_SRotare96:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare97
;a.h,342 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
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
;a.h,343 :: 		if(r%2==1) continue;
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
;a.h,344 :: 		switch(cdirection)
	GOTO       L_SRotare101
;a.h,346 :: 		case UP:
L_SRotare103:
;a.h,347 :: 		xa=cX+Radius*cos(dfi-Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,348 :: 		ya=cY+Radius*sin(dfi-Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,349 :: 		break;
	GOTO       L_SRotare102
;a.h,350 :: 		case DOWN:
L_SRotare104:
;a.h,351 :: 		xa=cX+Radius*cos(dfi+Pi-Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,352 :: 		ya=cY+Radius*sin(dfi+Pi-Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,353 :: 		break;
	GOTO       L_SRotare102
;a.h,354 :: 		case RIGHT:
L_SRotare105:
;a.h,355 :: 		xa=cX+Radius*cos(dfi-Pi/2-Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,356 :: 		ya=cY+Radius*sin(dfi-Pi/2-Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,357 :: 		break;
	GOTO       L_SRotare102
;a.h,358 :: 		case LEFT:
L_SRotare106:
;a.h,359 :: 		xa=cX+Radius*cos(dfi+Pi/2-Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,360 :: 		ya=cY+Radius*sin(dfi+Pi/2-Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,361 :: 		break;
	GOTO       L_SRotare102
;a.h,362 :: 		}
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
;a.h,363 :: 		}
L_SRotare98:
;a.h,340 :: 		for(;r>0;r--)
	DECF       SRotare_r_L0+0, 1
;a.h,363 :: 		}
	GOTO       L_SRotare96
L_SRotare97:
;a.h,364 :: 		}
	GOTO       L_SRotare107
L_SRotare95:
;a.h,367 :: 		S_Left(255);
	MOVLW      255
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,368 :: 		for(;r<0;r++)
L_SRotare108:
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare109
;a.h,370 :: 		Delay_ms(DELAY_TIME_VR_10*45/10);
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
;a.h,371 :: 		if((-r)%2==1) continue;
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
	GOTO       L__SRotare174
	MOVLW      1
	XORWF      R0+0, 0
L__SRotare174:
	BTFSS      STATUS+0, 2
	GOTO       L_SRotare112
	GOTO       L_SRotare110
L_SRotare112:
;a.h,372 :: 		switch(cdirection)
	GOTO       L_SRotare113
;a.h,374 :: 		case UP:
L_SRotare115:
;a.h,375 :: 		xa=cX+Radius*cos(dfi+Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,376 :: 		ya=cY+Radius*sin(dfi+Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,377 :: 		break;
	GOTO       L_SRotare114
;a.h,378 :: 		case DOWN:
L_SRotare116:
;a.h,379 :: 		xa=cX+Radius*cos(dfi+Pi+Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,380 :: 		ya=cY+Radius*sin(dfi+Pi+Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,381 :: 		break;
	GOTO       L_SRotare114
;a.h,382 :: 		case RIGHT:
L_SRotare117:
;a.h,383 :: 		xa=cX+Radius*cos(dfi-Pi/2+Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,384 :: 		ya=cY+Radius*sin(dfi-Pi/2+Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,385 :: 		break;
	GOTO       L_SRotare114
;a.h,386 :: 		case LEFT:
L_SRotare118:
;a.h,387 :: 		xa=cX+Radius*cos(dfi+Pi/2+Pi/2);
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
	MOVWF      SRotare_xa_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_xa_L0+1
;a.h,388 :: 		ya=cY+Radius*sin(dfi+Pi/2+Pi/2);
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
	MOVWF      SRotare_ya_L0+0
	MOVF       R0+1, 0
	MOVWF      SRotare_ya_L0+1
;a.h,389 :: 		break;
	GOTO       L_SRotare114
;a.h,390 :: 		}
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
;a.h,391 :: 		}
L_SRotare110:
;a.h,368 :: 		for(;r<0;r++)
	INCF       SRotare_r_L0+0, 1
;a.h,391 :: 		}
	GOTO       L_SRotare108
L_SRotare109:
;a.h,392 :: 		}
L_SRotare107:
;a.h,393 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,394 :: 		cdirection=nd;
	MOVF       FARG_SRotare_nd+0, 0
	MOVWF      _cdirection+0
;a.h,395 :: 		cX=xa;
	MOVF       SRotare_xa_L0+0, 0
	MOVWF      _cX+0
	MOVF       SRotare_xa_L0+1, 0
	MOVWF      _cX+1
;a.h,396 :: 		cY=ya;
	MOVF       SRotare_ya_L0+0, 0
	MOVWF      _cY+0
	MOVF       SRotare_ya_L0+1, 0
	MOVWF      _cY+1
;a.h,397 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_Correct:

;a.h,400 :: 		void Correct(void) // корректирует направление робота
;a.h,403 :: 		r=isSafeY();                // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_r_L0+0
;a.h,404 :: 		S_Left(DELAY_TIME_VR_10);  // повернуться
	MOVLW      64
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
;a.h,405 :: 		nr=isSafeY();               // проверить расстояние
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      Correct_nr_L0+0
;a.h,406 :: 		if(r==nr)                   // сравнить их, если получаем правильное соотношение
	MOVF       Correct_r_L0+0, 0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_Correct119
;a.h,407 :: 		S_Right(DELAY_TIME_VR_10);  // то мы находимся в правильном положении
	MOVLW      64
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct119:
;a.h,408 :: 		if(r>nr)
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct120
;a.h,409 :: 		return;
	GOTO       L_end_Correct
L_Correct120:
;a.h,410 :: 		if(r<nr)
	MOVLW      128
	XORWF      Correct_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      Correct_nr_L0+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Correct121
;a.h,411 :: 		S_Right(2*DELAY_TIME_VR_10);
	MOVLW      128
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
L_Correct121:
;a.h,412 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,413 :: 		}
L_end_Correct:
	RETURN
; end of _Correct

_A_search:

;a.h,418 :: 		void A_search()
;a.h,420 :: 		int temp=0;
	CLRF       A_search_temp_L0+0
	CLRF       A_search_temp_L0+1
;a.h,421 :: 		temp=getParam("Hint  ",cX,cY); // получаем значение стоимости для текущего состояния
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
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
;a.h,422 :: 		setParam("Hint  ",cX,cY,++temp); // увеличиваем его, т.к. мы уже здесь
	MOVLW      ?lstr_10_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_10_MyProject+0)
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
;a.h,424 :: 		cxx=getParam("Calc  ",cX,cY);
	MOVLW      ?lstr_11_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_11_MyProject+0)
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
;a.h,425 :: 		cyy=getParam("Calc2 ",cX,cY);
	MOVLW      ?lstr_12_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_12_MyProject+0)
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
;a.h,426 :: 		if(cdirection==UP) ;
	MOVF       _cdirection+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_A_search122
L_A_search122:
;a.h,427 :: 		if(cdirection==DOWN) cyy*=-1 ;
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
;a.h,428 :: 		if(cdirection==LEFT)
	MOVF       _cdirection+0, 0
	XORLW      7
	BTFSS      STATUS+0, 2
	GOTO       L_A_search124
;a.h,430 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,431 :: 		cxx=cyy;
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;a.h,432 :: 		cyy=-temp;
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;a.h,433 :: 		}
L_A_search124:
;a.h,434 :: 		if(cdirection==RIGHT)
	MOVF       _cdirection+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_A_search125
;a.h,436 :: 		temp=cxx;
	MOVF       _cxx+0, 0
	MOVWF      A_search_temp_L0+0
	MOVLW      0
	BTFSC      A_search_temp_L0+0, 7
	MOVLW      255
	MOVWF      A_search_temp_L0+1
;a.h,437 :: 		cxx=cyy;
	MOVF       _cyy+0, 0
	MOVWF      _cxx+0
;a.h,438 :: 		cyy=-temp;
	MOVF       A_search_temp_L0+0, 0
	SUBLW      0
	MOVWF      _cyy+0
;a.h,439 :: 		}
L_A_search125:
;a.h,440 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
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
;a.h,442 :: 		cX+=cxx; // обновление текущих координат
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cX+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      _cX+1, 1
;a.h,443 :: 		cY+=cyy;
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 1
	BTFSC      STATUS+0, 0
	INCF       _cY+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      _cY+1, 1
;a.h,444 :: 		}
L_A_search126:
;a.h,448 :: 		}
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

;MyProject.c,27 :: 		void main()
;MyProject.c,29 :: 		int temp=0;
;MyProject.c,30 :: 		int temp1=0;
	CLRF       main_temp1_L0+0
	CLRF       main_temp1_L0+1
;MyProject.c,31 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,32 :: 		while(getParam("start ",1,1)!=13) // ждем сигнала старта
L_main127:
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
	GOTO       L__main179
	MOVLW      13
	XORWF      R0+0, 0
L__main179:
	BTFSC      STATUS+0, 2
	GOTO       L_main128
;MyProject.c,33 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main129:
	DECFSZ     R13+0, 1
	GOTO       L_main129
	DECFSZ     R12+0, 1
	GOTO       L_main129
	DECFSZ     R11+0, 1
	GOTO       L_main129
	NOP
	NOP
	GOTO       L_main127
L_main128:
;MyProject.c,35 :: 		cdirection=DOWN; // начальное направление - вниз
	MOVLW      5
	MOVWF      _cdirection+0
;MyProject.c,36 :: 		cX=isSafeX()/2;  // получаем текущие координаты
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
;MyProject.c,37 :: 		cY=isSafeY()/2;
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
;MyProject.c,38 :: 		getParam("Hint  ",cX,cY);
	MOVLW      ?lstr_14_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_14_MyProject+0)
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
;MyProject.c,39 :: 		SRotare(cdirection,UP);
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVLW      1
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;MyProject.c,40 :: 		maxX=cX+isSafeX()/2;
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
;MyProject.c,41 :: 		maxY=cY+isSafeY()/2;
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
;MyProject.c,43 :: 		temp1=isSafeY();
	CALL       _isSafeY+0
	MOVF       R0+0, 0
	MOVWF      main_temp1_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temp1_L0+1
;MyProject.c,44 :: 		temp=isSafeX();
	CALL       _isSafeX+0
;MyProject.c,45 :: 		getParam("isSafe",temp,temp1);
	MOVLW      ?lstr_15_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_15_MyProject+0)
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
;MyProject.c,46 :: 		setParam("max   ",maxX,maxY,1);
	MOVLW      ?lstr_16_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_16_MyProject+0)
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
;MyProject.c,47 :: 		getParam("Hint  ",cX,cY);
	MOVLW      ?lstr_17_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_17_MyProject+0)
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
;MyProject.c,49 :: 		while(getParam("jbsdne",1,1)!=13)
L_main130:
	MOVLW      ?lstr_18_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_18_MyProject+0)
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
	GOTO       L_main131
;MyProject.c,71 :: 		A_search();
	CALL       _A_search+0
;MyProject.c,72 :: 		}
	GOTO       L_main130
L_main131:
;MyProject.c,73 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
