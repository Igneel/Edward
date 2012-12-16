//------------------------------------------------------------------------//
// Compiler: Hitech C 
// Library for LCD display
// Hardware:
//		PIC16F887	:	IC L293D(motor drive circuit)	
//		RD0			==>		1A
//		RD1			==>		2B
//		RC2/CCP1	==>		12EN
//		RB1			==>		4A
//		RB2			==>		3A
//		RC1/CCP2	==>		34EN
//------------------------------------------------------------------------//
#ifndef _MOTOR2_H_
#define _MOTOR2_H_
#include <pic.h>		// Include header file for MCU	
#include <stdlib.h>		// Library for abs function
#define FREQ_1KHZ 1		// Option for select frequency 1 kHz
#define FREQ_5KHZ 2		// Option for select frequency 5 kHz
#define FREQ_20KHZ 3	// Option for select frequency 20 kHz	
#define ALL 3	// Option for stop motor all channel(Motor M-1 and M-2)	
char motor_ini = 0;

void pwm1_init(unsigned char freq_sel)
{
	CCP1CON = 0x0C;	// CCP1 PWM mode
	PR2 = 0xFF;		// Set period of timer 2	
	TMR2IF =0;	// Clear flag timer 2
	if(freq_sel==FREQ_1KHZ)
	{
     T2CON |= 0x03;	// Prescaler 16
    }
    else if(freq_sel==FREQ_5KHZ)
	{
     T2CON |= 0x01;	// Prescaler 4
    }
    else if(freq_sel==FREQ_20KHZ)
	{
     T2CON &= ~0x03;	// Prescaler 1
    }
    T2CON |= 0x04;		// Start timer2
	CCP1CON |= 0x30;	// CCP1 PWM mode
}
void pwm2_init(unsigned char freq_sel)
{
	CCP2CON = 0x0C;	// CCP2 PWM mode
	PR2 = 0xFF;		// Set period of timer 2
	TMR2IF =0;		// Clear flag timer 2
	if(freq_sel==FREQ_1KHZ)
	{
     T2CON |= 0x03;	// Prescaler 16
    }
    else if(freq_sel==FREQ_5KHZ)
	{
     T2CON |= 0x01;	// Prescaler 4
    }
    else if(freq_sel==FREQ_20KHZ)
	{
     T2CON &= ~0x03;	// Prescaler 1
    }
    T2CON |= 0x04;		// Start timer2
	CCP2CON |= 0x30;	// CCP2 PWM mode
}
void pwm2_start()
{
 	TRISC1 = 0;	// Enable RC1 output 
}
void pwm2_stop()
{
    TRISC1 = 1;		// Disable RC1 output 
}
void pwm2_change_duty(unsigned char duty_ratio)
{
    CCPR2L = duty_ratio;	// Set duty cycle of PWM2
}
void pwm1_start()
{
    TRISC2 = 0;	// Enable RC2 output 
}
void pwm1_stop()
{
    TRISC2 = 1;	// Disable RC2 output 
}
void pwm1_change_duty(unsigned char duty_ratio)
{
    CCPR1L = duty_ratio;	// Set duty cycle of PWM1
}
void motor_init()
{
	pwm1_start();	// Enable PWM1 signal at RC2
	pwm2_start();  	// Enable PWM2 signal at RC1
	if(motor_ini==0)		// PWM working? 
 	{
  		motor_ini=1;	// Flag for initial PWM signal
  		ANS8 = 0;	// Ensure RB2 digital I/O
		ANS10 = 0;	// Ensure RB1 digital I/O
		TRISB1 = 0;	// Set RB1 output 
		TRISB2 = 0;	// Set RB2 output 
		TRISD0 = 0;	// Set RD0 output 
		TRISD1 = 0;	// Set RD1 output 
		pwm1_init(FREQ_1KHZ);   // Set frequency of PWM1 at 1 kHz     
  		pwm2_init(FREQ_1KHZ);	// Set frequency of PWM2 at 1 kHz 
	
 	}
}
void motor(char _channel,int _power)
{
	motor_init();	// Initial motor drive
	if(_power>0)	// Check power of drive positive value?
	{
		if(_channel==1)		// Select generate PWM1?   
		{
			pwm1_change_duty(_power);	// Set duty cycle for PWM1  
			// Motor M-1 forward
			RD0 = 0;	
			RD1 = 1;
		}
		else if(_channel==2)	// Select generate PWM2? 
		{
			pwm2_change_duty(_power);	// Set duty cycle for PWM2  
			// Motor M-2 forward
			RB1 = 0;
			RB2 = 1;
		}
	}
	else	// Case power of drive is nagative value
	{
		if(_channel==1)		// Select generate PWM1? 
		{
			pwm1_change_duty(abs(_power));	// Set duty cycle for PWM1 
			// Motor M-1 backward
			RD0 = 1;
			RD1 = 0;
		}
		else if(_channel==2)	// Select generate PWM1? 
		{
			pwm2_change_duty(abs(_power));	// Set duty cycle for PWM1
			// Motor M-2 backward
			RB1 = 1;
			RB2 = 0;
		}	
	}
}
void motor_stop(char _channel)
{
	if(_channel==1)	// Select stop PWM1? 
	{
		pwm1_stop();	// Disable PWM1 output
		// Motor M-1 off
		RD0 = 0;
		RD1 = 0;
		
	}
	else if(_channel==2)	// Select stop PWM1? 
	{
		pwm2_stop();	// Disable PWM2 output
		// Motor M-2 off
		RB1 = 0;
		RB2 = 0;
		
	}
	else if(_channel==ALL)	// Select stop PWM1 with PWM2? 
	{
		pwm1_stop();	// Disable PWM1 output
		pwm2_stop();	// Disable PWM2 output
		// Motor M-1 and M-2 off
		RD0 = 0;
		RD1 = 0;
		RB1 = 0;
		RB2 = 0;
	}
}
void forward(int p)
{
	motor(1,p);		// Motor M-1 forward
	motor(2,p);		// Motor M-2 forward
}
void backward(int p)
{
	motor(1,-p);	// Motor M-1 backward
	motor(2,-p);	// Motor M-2 backward
}
void turn_left(int p)
{
	motor(1,-p);	// Motor M-1 backward
	motor(2,p);		// Motor M-2 forward
}
void turn_right(int p)
{
	motor(1,p);		// Motor M-1 forward
	motor(2,-p);	// Motor M-2 backward
}
#endif
