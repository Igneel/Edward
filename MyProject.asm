
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

_strConstCpy:

;a.h,63 :: 		void strConstCpy (const char *source, char *dest) {
;a.h,64 :: 		while (*source) *dest++ = *source++;
L_strConstCpy15:
	MOVF       FARG_strConstCpy_source+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       FARG_strConstCpy_source+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_strConstCpy16
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
	GOTO       L_strConstCpy15
L_strConstCpy16:
;a.h,65 :: 		*dest = 0;
	MOVF       FARG_strConstCpy_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,66 :: 		}
L_end_strConstCpy:
	RETURN
; end of _strConstCpy

_stradd:

;a.h,67 :: 		void stradd(char *source, char *dest){
;a.h,68 :: 		while (*dest++);
L_stradd17:
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      R0+0
	INCF       FARG_stradd_dest+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_stradd18
	GOTO       L_stradd17
L_stradd18:
;a.h,69 :: 		*dest--;
	DECF       FARG_stradd_dest+0, 1
;a.h,70 :: 		while (*source) *dest++ = *source++;
L_stradd19:
	MOVF       FARG_stradd_source+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_stradd20
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
	GOTO       L_stradd19
L_stradd20:
;a.h,71 :: 		*dest = 0;
	MOVF       FARG_stradd_dest+0, 0
	MOVWF      FSR
	CLRF       INDF+0
;a.h,72 :: 		}
L_end_stradd:
	RETURN
; end of _stradd

_getParam:

;a.h,74 :: 		int getParam(const char * p,int x,int y)
;a.h,77 :: 		strConstCpy(p,string);
	MOVF       FARG_getParam_p+0, 0
	MOVWF      FARG_strConstCpy_source+0
	MOVF       FARG_getParam_p+1, 0
	MOVWF      FARG_strConstCpy_source+1
	MOVLW      _string+0
	MOVWF      FARG_strConstCpy_dest+0
	CALL       _strConstCpy+0
;a.h,78 :: 		IntToStr (x,strint);
	MOVF       FARG_getParam_x+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_x+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,79 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,80 :: 		IntToStr (y,strint);
	MOVF       FARG_getParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_getParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,81 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,82 :: 		UART1_Write_Text(string);
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;a.h,83 :: 		while(1) if(UART1_Data_Ready())
L_getParam21:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_getParam23
;a.h,85 :: 		temp=UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      getParam_temp_L0+0
;a.h,86 :: 		UART1_Write(temp);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;a.h,87 :: 		return temp;
	MOVF       getParam_temp_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	GOTO       L_end_getParam
;a.h,88 :: 		}
L_getParam23:
	GOTO       L_getParam21
;a.h,89 :: 		}
L_end_getParam:
	RETURN
; end of _getParam

_setParam:

;a.h,91 :: 		int setParam(const char * p,int x,int y,int value)
;a.h,93 :: 		strConstCpy(p,string);
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
;a.h,95 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,96 :: 		IntToStr (y,strint);
	MOVF       FARG_setParam_y+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_y+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,97 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,98 :: 		IntToStr (value,strint);
	MOVF       FARG_setParam_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_setParam_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _strint+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;a.h,99 :: 		stradd(strint,string);
	MOVLW      _strint+0
	MOVWF      FARG_stradd_source+0
	MOVLW      _string+0
	MOVWF      FARG_stradd_dest+0
	CALL       _stradd+0
;a.h,100 :: 		UART1_Write_Text(string);
	MOVLW      _string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
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
	GOTO       L_isMetall26
	MOVLW      128
	XORWF      isMetall_m_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      50
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_isMetall26
L__isMetall87:
;a.h,110 :: 		return 1;    // если объект металлический возвращаем единицу
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_isMetall
L_isMetall26:
;a.h,112 :: 		return 0;
	CLRF       R0+0
;a.h,113 :: 		}
L_end_isMetall:
	RETURN
; end of _isMetall

_comp:

;a.h,115 :: 		short comp(short d1,short d2)
;a.h,117 :: 		if(d1==d2) return 0; // операнды равны
	MOVF       FARG_comp_d1+0, 0
	XORWF      FARG_comp_d2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_comp28
	CLRF       R0+0
	GOTO       L_end_comp
L_comp28:
;a.h,118 :: 		if(d1>d2) return 1; // первый больше второго
	MOVLW      128
	XORWF      FARG_comp_d2+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_comp_d1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_comp29
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_comp
L_comp29:
;a.h,119 :: 		else return -1; // первый меньше второго
	MOVLW      255
	MOVWF      R0+0
;a.h,120 :: 		}
L_end_comp:
	RETURN
; end of _comp

_SMove:

;a.h,123 :: 		short SMove(short nx,short ny)
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
;a.h,133 :: 		if(ax==-1)      // в зависимости от результатов - определяем нужное направление
	MOVF       SMove_ax_L0+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L_SMove31
;a.h,134 :: 		nd=3+ry;
	MOVF       SMove_ry_L0+0, 0
	ADDLW      3
	MOVWF      SMove_nd_L0+0
L_SMove31:
;a.h,135 :: 		if(ax==0)
	MOVF       SMove_ax_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove32
;a.h,136 :: 		switch(ry)
	GOTO       L_SMove33
;a.h,138 :: 		case -1:
L_SMove35:
;a.h,139 :: 		nd=1;
	MOVLW      1
	MOVWF      SMove_nd_L0+0
;a.h,140 :: 		break;
	GOTO       L_SMove34
;a.h,141 :: 		case 0:
L_SMove36:
;a.h,142 :: 		nd=cdirection;
	MOVF       _cdirection+0, 0
	MOVWF      SMove_nd_L0+0
;a.h,144 :: 		break;
	GOTO       L_SMove34
;a.h,145 :: 		case 1:
L_SMove37:
;a.h,146 :: 		nd=5;
	MOVLW      5
	MOVWF      SMove_nd_L0+0
;a.h,147 :: 		break;
	GOTO       L_SMove34
;a.h,149 :: 		}
L_SMove33:
	MOVF       SMove_ry_L0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_SMove35
	MOVF       SMove_ry_L0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove36
	MOVF       SMove_ry_L0+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L_SMove37
L_SMove34:
L_SMove32:
;a.h,150 :: 		if(ax==1)
	MOVF       SMove_ax_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SMove38
;a.h,151 :: 		nd=7-ry;
	MOVF       SMove_ry_L0+0, 0
	SUBLW      7
	MOVWF      SMove_nd_L0+0
L_SMove38:
;a.h,152 :: 		SRotare(cdirection,nd); // поворачиваемся
	MOVF       _cdirection+0, 0
	MOVWF      FARG_SRotare_d+0
	MOVF       SMove_nd_L0+0, 0
	MOVWF      FARG_SRotare_nd+0
	CALL       _SRotare+0
;a.h,155 :: 		if(isSafe()==100) // проверяем наличие препятсвий
	CALL       _isSafe+0
	MOVF       R0+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_SMove39
;a.h,157 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,158 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,159 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,160 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,161 :: 		if(cdirection%2==0)
	MOVLW      1
	ANDWF      _cdirection+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_SMove40
;a.h,162 :: 		delay_ms(DELAY_TIME_20*1414/1000); // ждем пока приедем
	MOVLW      36
	MOVWF      R11+0
	MOVLW      222
	MOVWF      R12+0
	MOVLW      183
	MOVWF      R13+0
L_SMove41:
	DECFSZ     R13+0, 1
	GOTO       L_SMove41
	DECFSZ     R12+0, 1
	GOTO       L_SMove41
	DECFSZ     R11+0, 1
	GOTO       L_SMove41
	NOP
	NOP
	GOTO       L_SMove42
L_SMove40:
;a.h,164 :: 		delay_ms(DELAY_TIME_20); // ждем пока приедем
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_SMove43:
	DECFSZ     R13+0, 1
	GOTO       L_SMove43
	DECFSZ     R12+0, 1
	GOTO       L_SMove43
	DECFSZ     R11+0, 1
	GOTO       L_SMove43
	NOP
L_SMove42:
;a.h,165 :: 		findGoalCount++;
	INCF       _findGoalCount+0, 1
;a.h,166 :: 		return 1;      // движение выполнено.
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_SMove
;a.h,167 :: 		}
L_SMove39:
;a.h,170 :: 		d=isSafe();
	CALL       _isSafe+0
	MOVF       R0+0, 0
	MOVWF      SMove_d_L0+0
;a.h,171 :: 		Motor_Init();  // настраиваем моторы
	CALL       _Motor_Init+0
;a.h,172 :: 		Change_Duty(SPEED); // задаем скорость
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,173 :: 		Motor_A_FWD(); // запускаем моторы
	CALL       _Motor_A_FWD+0
;a.h,174 :: 		Motor_B_FWD();
	CALL       _Motor_B_FWD+0
;a.h,175 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	CLRF       SMove_i_L0+0
L_SMove45:
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
	GOTO       L__SMove116
	MOVF       R1+0, 0
	SUBWF      SMove_i_L0+0, 0
L__SMove116:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove46
;a.h,176 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_SMove48:
	DECFSZ     R13+0, 1
	GOTO       L_SMove48
	DECFSZ     R12+0, 1
	GOTO       L_SMove48
	DECFSZ     R11+0, 1
	GOTO       L_SMove48
	NOP
;a.h,175 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	INCF       SMove_i_L0+0, 1
;a.h,176 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	GOTO       L_SMove45
L_SMove46:
;a.h,177 :: 		Motor_Stop();
	CALL       _Motor_Stop+0
;a.h,178 :: 		temp=getParam("Hint",cX+cxx,cY+cyy);
	MOVLW      ?lstr_1_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_1_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_x+1
	BTFSC      STATUS+0, 0
	INCF       FARG_getParam_x+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      FARG_getParam_x+1, 1
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_y+1
	BTFSC      STATUS+0, 0
	INCF       FARG_getParam_y+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      FARG_getParam_y+1, 1
	CALL       _getParam+0
;a.h,179 :: 		setParam("Hint",cX+cxx,cY+cyy,temp++); //H[cX+cxx][cY+cyy]++;   // обновляем состояние, раз там что-то есть, туда ехать не надо
	MOVLW      ?lstr_2_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_2_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_setParam_x+0
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_x+1
	BTFSC      STATUS+0, 0
	INCF       FARG_setParam_x+1, 1
	MOVLW      0
	BTFSC      _cxx+0, 7
	MOVLW      255
	ADDWF      FARG_setParam_x+1, 1
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_setParam_y+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_y+1
	BTFSC      STATUS+0, 0
	INCF       FARG_setParam_y+1, 1
	MOVLW      0
	BTFSC      _cyy+0, 7
	MOVLW      255
	ADDWF      FARG_setParam_y+1, 1
	MOVF       R0+0, 0
	MOVWF      FARG_setParam_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
;a.h,180 :: 		findGoalCount++;
	INCF       _findGoalCount+0, 1
;a.h,181 :: 		if(isMetall()) // проверяем металл ли это
	CALL       _isMetall+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SMove49
;a.h,183 :: 		Metals[MetallObjects][0]=cX+cxx; // записываем координаты
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
;a.h,184 :: 		Metals[MetallObjects][1]=cY+cyy;
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
;a.h,185 :: 		MetallObjects++;
	INCF       _MetallObjects+0, 1
;a.h,186 :: 		}
L_SMove49:
;a.h,188 :: 		Motor_Init();
	CALL       _Motor_Init+0
;a.h,189 :: 		Change_Duty(SPEED);
	MOVLW      255
	MOVWF      FARG_Change_Duty_speed+0
	CALL       _Change_Duty+0
;a.h,190 :: 		Motor_A_BWD();
	CALL       _Motor_A_BWD+0
;a.h,191 :: 		Motor_B_BWD();
	CALL       _Motor_B_BWD+0
;a.h,192 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	CLRF       SMove_i_L0+0
L_SMove50:
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
	GOTO       L__SMove117
	MOVF       R1+0, 0
	SUBWF      SMove_i_L0+0, 0
L__SMove117:
	BTFSC      STATUS+0, 0
	GOTO       L_SMove51
;a.h,193 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_SMove53:
	DECFSZ     R13+0, 1
	GOTO       L_SMove53
	DECFSZ     R12+0, 1
	GOTO       L_SMove53
	DECFSZ     R11+0, 1
	GOTO       L_SMove53
	NOP
;a.h,192 :: 		for(i=0;i<d-DISTANCE_METALL;i++)
	INCF       SMove_i_L0+0, 1
;a.h,193 :: 		delay_ms(DELAY_TIME_1sm); // ждем пока приедем
	GOTO       L_SMove50
L_SMove51:
;a.h,195 :: 		return 0;    // движения не было
	CLRF       R0+0
;a.h,197 :: 		}
L_end_SMove:
	RETURN
; end of _SMove

_SRotare:

;a.h,202 :: 		void SRotare(enum direction d,enum direction nd)
;a.h,205 :: 		r=(d-nd);
	MOVF       FARG_SRotare_nd+0, 0
	SUBWF      FARG_SRotare_d+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      SRotare_r_L0+0
;a.h,206 :: 		if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
	MOVLW      128
	XORLW      4
	MOVWF      R0+0
	MOVLW      128
	XORWF      R1+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SRotare54
	MOVF       SRotare_r_L0+0, 0
	SUBLW      8
	MOVWF      SRotare_r_L0+0
L_SRotare54:
;a.h,207 :: 		if(r>=0)
	MOVLW      128
	XORWF      SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_SRotare55
;a.h,208 :: 		S_Right(r*45); // поворачиваемся по наименьшему пути
	MOVF       SRotare_r_L0+0, 0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Right_speed+0
	CALL       _S_Right+0
	GOTO       L_SRotare56
L_SRotare55:
;a.h,210 :: 		S_Left(-r*45);
	MOVF       SRotare_r_L0+0, 0
	SUBLW      0
	MOVWF      R0+0
	MOVLW      45
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_S_Left_speed+0
	CALL       _S_Left+0
L_SRotare56:
;a.h,211 :: 		}
L_end_SRotare:
	RETURN
; end of _SRotare

_A_search:

;a.h,215 :: 		void A_search()
;a.h,219 :: 		if(findGoalCount==NumberOfGoals) return;// проверили все состояния - достигли цели - закончили работу.
	MOVF       _findGoalCount+0, 0
	XORLW      63
	BTFSS      STATUS+0, 2
	GOTO       L_A_search57
	GOTO       L_end_A_search
L_A_search57:
;a.h,220 :: 		temp=getParam("Hint",cX,cY);
	MOVLW      ?lstr_3_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_3_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	BTFSC      FARG_getParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      FARG_getParam_y+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_y+1
	CALL       _getParam+0
	MOVF       R0+0, 0
	MOVWF      A_search_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      A_search_temp_L0+1
;a.h,223 :: 		setParam("Hint",cX,cY,temp++);
	MOVLW      ?lstr_4_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_4_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_setParam_x+0
	MOVLW      0
	BTFSC      FARG_setParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_x+1
	MOVF       _cY+0, 0
	MOVWF      FARG_setParam_y+0
	MOVLW      0
	BTFSC      FARG_setParam_y+0, 7
	MOVLW      255
	MOVWF      FARG_setParam_y+1
	MOVF       R0+0, 0
	MOVWF      FARG_setParam_value+0
	MOVF       R0+1, 0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
	INCF       A_search_temp_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_temp_L0+1, 1
;a.h,227 :: 		min=getParam("Hint",cX,cY+1)+getParam("hevr",cX,cY+1);//H[cX][cY+1]+h_evr[cX][cY+1];
	MOVLW      ?lstr_5_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_5_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	BTFSC      FARG_getParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      FARG_getParam_y+0
	CLRF       FARG_getParam_y+1
	BTFSC      STATUS+0, 0
	INCF       FARG_getParam_y+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      FARG_getParam_y+1, 1
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
	MOVLW      0
	BTFSC      FARG_getParam_x+0, 7
	MOVLW      255
	MOVWF      FARG_getParam_x+1
	MOVF       _cY+0, 0
	ADDLW      1
	MOVWF      FARG_getParam_y+0
	CLRF       FARG_getParam_y+1
	BTFSC      STATUS+0, 0
	INCF       FARG_getParam_y+1, 1
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
	ADDWF      FARG_getParam_y+1, 1
	CALL       _getParam+0
	MOVF       R0+0, 0
	ADDWF      FLOC__A_search+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       FLOC__A_search+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,228 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	MOVLW      255
	MOVWF      A_search_i_L0+0
	MOVLW      255
	MOVWF      A_search_i_L0+1
L_A_search58:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search120
	MOVF       A_search_i_L0+0, 0
	SUBLW      1
L__A_search120:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search59
;a.h,229 :: 		for(j=-1;j<=1;j++)//----------------------------------------------------------------------------------------------------------------------!!!!!
	MOVLW      255
	MOVWF      A_search_j_L0+0
	MOVLW      255
	MOVWF      A_search_j_L0+1
L_A_search61:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_j_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search121
	MOVF       A_search_j_L0+0, 0
	SUBLW      1
L__A_search121:
	BTFSS      STATUS+0, 0
	GOTO       L_A_search62
;a.h,231 :: 		if(i==0 && j==0) continue;
	MOVLW      0
	XORWF      A_search_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search122
	MOVLW      0
	XORWF      A_search_i_L0+0, 0
L__A_search122:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search66
	MOVLW      0
	XORWF      A_search_j_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search123
	MOVLW      0
	XORWF      A_search_j_L0+0, 0
L__A_search123:
	BTFSS      STATUS+0, 2
	GOTO       L_A_search66
L__A_search88:
	GOTO       L_A_search63
L_A_search66:
;a.h,232 :: 		temp=getParam("Hint",cX+i,cY+j)+getParam("hevr",cX+i,cY+j); //H[cX+i][cY+j]+h_evr[cX+i][cY+j];
	MOVLW      ?lstr_7_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_7_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVF       A_search_i_L0+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_i_L0+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       A_search_j_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
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
	MOVLW      0
	BTFSC      _cX+0, 7
	MOVLW      255
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      A_search_i_L0+1, 0
	MOVWF      FARG_getParam_x+1
	MOVF       A_search_j_L0+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_getParam_y+0
	MOVLW      0
	BTFSC      _cY+0, 7
	MOVLW      255
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
;a.h,233 :: 		if(temp<min) // имеющее минимальную стоимость
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      A_search_min_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__A_search124
	MOVF       A_search_min_L0+0, 0
	SUBWF      R2+0, 0
L__A_search124:
	BTFSC      STATUS+0, 0
	GOTO       L_A_search67
;a.h,235 :: 		min=temp;
	MOVF       A_search_temp_L0+0, 0
	MOVWF      A_search_min_L0+0
	MOVF       A_search_temp_L0+1, 0
	MOVWF      A_search_min_L0+1
;a.h,236 :: 		cxx=i;
	MOVF       A_search_i_L0+0, 0
	MOVWF      _cxx+0
;a.h,237 :: 		cyy=j;
	MOVF       A_search_j_L0+0, 0
	MOVWF      _cyy+0
;a.h,238 :: 		}
L_A_search67:
;a.h,239 :: 		}
L_A_search63:
;a.h,229 :: 		for(j=-1;j<=1;j++)//----------------------------------------------------------------------------------------------------------------------!!!!!
	INCF       A_search_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_j_L0+1, 1
;a.h,239 :: 		}
	GOTO       L_A_search61
L_A_search62:
;a.h,228 :: 		for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
	INCF       A_search_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       A_search_i_L0+1, 1
;a.h,239 :: 		}
	GOTO       L_A_search58
L_A_search59:
;a.h,240 :: 		if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 0
	MOVWF      FARG_SMove_nx+0
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 0
	MOVWF      FARG_SMove_ny+0
	CALL       _SMove+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_A_search68
;a.h,242 :: 		cX+=cxx; // обновление текущих координат
	MOVF       _cxx+0, 0
	ADDWF      _cX+0, 1
;a.h,243 :: 		cY+=cyy;
	MOVF       _cyy+0, 0
	ADDWF      _cY+0, 1
;a.h,244 :: 		} // если перемещения не произошло, то робот вряд ли выберет тот же путь
L_A_search68:
;a.h,247 :: 		}
L_end_A_search:
	RETURN
; end of _A_search

_mod:

;a.h,250 :: 		short mod(short x)
;a.h,252 :: 		if(x>=0) return x;
	MOVLW      128
	XORWF      FARG_mod_x+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_mod69
	MOVF       FARG_mod_x+0, 0
	MOVWF      R0+0
	GOTO       L_end_mod
L_mod69:
;a.h,253 :: 		else return -x;
	MOVF       FARG_mod_x+0, 0
	SUBLW      0
	MOVWF      R0+0
;a.h,254 :: 		}
L_end_mod:
	RETURN
; end of _mod

_Brain:

;a.h,256 :: 		void Brain()
;a.h,261 :: 		for(x=0;x<WorldSize;x++)
	CLRF       Brain_x_L0+0
L_Brain71:
	MOVLW      128
	XORWF      Brain_x_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain72
;a.h,263 :: 		for(y=0;y<WorldSize;y++)
	CLRF       Brain_y_L0+0
L_Brain74:
	MOVLW      128
	XORWF      Brain_y_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain75
;a.h,265 :: 		if(getParam("Hint",x,y)/*H[x][y]*/!=0) continue; // если значение не нулевое- значит мы там были и всё нашли.
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
	GOTO       L__Brain127
	MOVLW      0
	XORWF      R0+0, 0
L__Brain127:
	BTFSC      STATUS+0, 2
	GOTO       L_Brain77
	GOTO       L_Brain76
L_Brain77:
;a.h,266 :: 		for(j=0;j<WorldSize;j++) // x
	CLRF       Brain_j_L0+0
L_Brain78:
	MOVLW      128
	XORWF      Brain_j_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain79
;a.h,267 :: 		for(k=0;k<WorldSize;k++) // y
	CLRF       Brain_k_L0+0
L_Brain81:
	MOVLW      128
	XORWF      Brain_k_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      8
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_Brain82
;a.h,269 :: 		r=mod(x-j)+mod(y-k);  // манхетенское расстояние
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
;a.h,270 :: 		if(r<getParam("hevr",j,k)) setParam("hevr",j,k,r); //h_evr[j][k])  // h_evr[j][k]=r; // если есть цель ближе - запишем расстояние до неё
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
	GOTO       L__Brain128
	MOVF       R0+0, 0
	SUBWF      Brain_r_L0+0, 0
L__Brain128:
	BTFSC      STATUS+0, 0
	GOTO       L_Brain84
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
L_Brain84:
;a.h,267 :: 		for(k=0;k<WorldSize;k++) // y
	INCF       Brain_k_L0+0, 1
;a.h,271 :: 		}
	GOTO       L_Brain81
L_Brain82:
;a.h,266 :: 		for(j=0;j<WorldSize;j++) // x
	INCF       Brain_j_L0+0, 1
;a.h,271 :: 		}
	GOTO       L_Brain78
L_Brain79:
;a.h,272 :: 		}
L_Brain76:
;a.h,263 :: 		for(y=0;y<WorldSize;y++)
	INCF       Brain_y_L0+0, 1
;a.h,272 :: 		}
	GOTO       L_Brain74
L_Brain75:
;a.h,261 :: 		for(x=0;x<WorldSize;x++)
	INCF       Brain_x_L0+0, 1
;a.h,273 :: 		}
	GOTO       L_Brain71
L_Brain72:
;a.h,274 :: 		}
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
;MyProject.c,34 :: 		UART1_Init(9600);
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,35 :: 		getParam("Hint",5,250);
	MOVLW      ?lstr_12_MyProject+0
	MOVWF      FARG_getParam_p+0
	MOVLW      hi_addr(?lstr_12_MyProject+0)
	MOVWF      FARG_getParam_p+1
	MOVLW      5
	MOVWF      FARG_getParam_x+0
	MOVLW      0
	MOVWF      FARG_getParam_x+1
	MOVLW      250
	MOVWF      FARG_getParam_y+0
	CLRF       FARG_getParam_y+1
	CALL       _getParam+0
;MyProject.c,36 :: 		setParam("hevr",899,623,3);
	MOVLW      ?lstr_13_MyProject+0
	MOVWF      FARG_setParam_p+0
	MOVLW      hi_addr(?lstr_13_MyProject+0)
	MOVWF      FARG_setParam_p+1
	MOVLW      131
	MOVWF      FARG_setParam_x+0
	MOVLW      3
	MOVWF      FARG_setParam_x+1
	MOVLW      111
	MOVWF      FARG_setParam_y+0
	MOVLW      2
	MOVWF      FARG_setParam_y+1
	MOVLW      3
	MOVWF      FARG_setParam_value+0
	MOVLW      0
	MOVWF      FARG_setParam_value+1
	CALL       _setParam+0
;MyProject.c,49 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
