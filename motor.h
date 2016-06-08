#ifndef MOTOR_H_
#define MOTOR_H_

char motor_duty_= 127;            // мощность по умолчанию 50%
char motor_init_=0;               // статус инициализации
// прототипы функций:

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

//  *** Мотор A *****
//   PD0 ====>  1A
//   PD1 ====>  1B
//   PC2 ====>  1E (PWM1)

//  *** Мотор B *****
//   PB1 ====>  2A
//   PB2 ====>  2B
//   PC1 ====>  2E (PWM2)

//****************************************************
//********** Инициализация мотора ******************
//****************************************************
void Motor_Init()
{
  if (motor_init_==0)            // Первый раз?
  {
    motor_init_=1;               // статус
    ANSELH.F0=0;                 // RB1 ==> цифровой ввод/вывод
    ANSELH.F2=0;                 // RB2 ==> цифровой ввод/вывод
    TRISB.F1=0;                  // Мотор B 2A
    TRISB.F2=0;                  // Мотор B 2B
    TRISD.F0=0;                  // Мотор A 1A
    TRISD.F1=0;                  // Мотор A 1B
    Pwm1_Init(5000);             // Инициализация мощности 1E
    Pwm2_Init(5000);             // Инициализация мощности 2E
  }
}
//****************************************************

//****************************************************
//********** Управление скоростью  *********************
//****************************************************
void Change_Duty(char speed)
 {
  if (speed != motor_duty_)      // скорость не изменилась?
  {
   motor_duty_=speed;            // сохраняем старую скорость
     PWM1_Set_Duty(speed);      // Мотор A
     PWM2_Set_Duty(speed);      // Мотор B
   }
 }
//****************************************************

/********** Мотор A Вперед  ********/
void Motor_A_FWD()
{
  Pwm1_Start();
  PORTD.F0 =0;
  PORTD.F1 =1;
}
/************************************/

/********** Мотор B Вперед  ********/
void Motor_B_FWD()
{
  Pwm2_Start();
  PORTB.F1 =0;
  PORTB.F2 =1;
}
/************************************/

/********* *Мотор A Назад  *******/
void Motor_A_BWD()
{
  Pwm1_Start();
  PORTD.F0 =1;
  PORTD.F1 =0;
}
/************************************/

/********** Мотор B Назад *******/
void Motor_B_BWD()
{
  Pwm2_Start();
  PORTB.F1 =1;
  PORTB.F2 =0;
}
/************************************/

/********** Поворот налево   *************/
void S_Right(char speed)
{
    Motor_Init();
    Change_Duty(speed);
    Motor_A_FWD();
    Motor_B_BWD();
}
/************************************/

/********** Повотор направо   ************/
void S_Left(char speed)
{
    Motor_Init();
    Change_Duty(speed);
    Motor_A_BWD();
    Motor_B_FWD();
}

/********** Остановка мотора   ************/
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
