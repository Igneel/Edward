#ifndef MOTOR_H_
#define MOTOR_H_

char motor_duty_= 127;            // �������� �� ��������� 50%
char motor_init_=0;               // ������ �������������
// ��������� �������:

  void Motor_Init();
  void Change_Duty(char speed);
  void Motor_A_FWD();
  void Motor_B_FWD();
  void Motor_A_BWD();
  void Motor_B_BWD();
  void Backward(char speed);
  void S_Right(char speed);
  void S_Left(char speed);
  void Motor_Stop();

//  *** ����� A *****
//   PD0 ====>  1A
//   PD1 ====>  1B
//   PC2 ====>  1E (PWM1)

//  *** ����� B *****
//   PB1 ====>  2A
//   PB2 ====>  2B
//   PC1 ====>  2E (PWM2)

//****************************************************
//********** ������������� ������ ******************
//****************************************************
void Motor_Init()
{
  if (motor_init_==0)            // ������ ���?
  {
    motor_init_=1;               // ������
    ANSELH.F0=0;                 // RB1 ==> �������� ����/�����
    ANSELH.F2=0;                 // RB2 ==> �������� ����/�����
    TRISB.F1=0;                  // ����� B 2A
    TRISB.F2=0;                  // ����� B 2B
    TRISD.F0=0;                  // ����� A 1A
    TRISD.F1=0;                  // ����� A 1B
    Pwm1_Init(5000);             // ������������� �������� 1E
    Pwm2_Init(5000);             // ������������� �������� 2E
  }
}
//****************************************************

//****************************************************
//********** ���������� ���������  *********************
//****************************************************
void Change_Duty(char speed)
 {
  if (speed != motor_duty_)      // �������� �� ����������?
  {
   motor_duty_=speed;            // ��������� ������ ��������
     PWM1_Set_Duty(speed);      // ����� A
     PWM2_Set_Duty(speed);      // ����� B
   }
 }
//****************************************************

/********** ����� A ������  ********/
void Motor_A_FWD()
{
  Pwm1_Start();
  PORTD.F0 =0;
  PORTD.F1 =1;
}
/************************************/

/********** ����� B ������  ********/
void Motor_B_FWD()
{
  Pwm2_Start();
  PORTB.F1 =0;
  PORTB.F2 =1;
}
/************************************/

/********* *����� A �����  *******/
void Motor_A_BWD()
{
  Pwm1_Start();
  PORTD.F0 =1;
  PORTD.F1 =0;
}
/************************************/

/********** ����� B ����� *******/
void Motor_B_BWD()
{
  Pwm2_Start();
  PORTB.F1 =1;
  PORTB.F2 =0;
}
/************************************/

/********** ������� ������   *************/
void S_Right(char speed)
{
    Motor_Init();
    Change_Duty(speed);
    Motor_A_FWD();
    Motor_B_BWD();
}
/************************************/

/********** ������� �������   ************/
void S_Left(char speed)
{
    Motor_Init();
    Change_Duty(speed);
    Motor_A_BWD();
    Motor_B_FWD();
}

/********** ��������� ������   ************/
void Motor_Stop()
{
   Change_Duty(0);
   Pwm1_Stop();
  PORTD.F0 =0;
  PORTD.F1 =0;
  Pwm2_Stop();
  PORTB.F1 =0;
  PORTB.F2 =0;
  motor_init_=0;
    
}
/************************************/
#endif
