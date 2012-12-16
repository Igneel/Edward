#line 1 "C:/Edward/MyProject.c"
#line 1 "c:/edward/a.h"
#line 1 "c:/edward/motor.h"





char motor_duty_= 127;
char motor_init_=0;

 void Motor_Init();
 void Change_Duty(char speed);
 void Motor_A_FWD();
 void Motor_B_FWD();
 void Motor_A_BWD();
 void Motor_B_BWD();

 void S_Right(char speed);
 void S_Left(char speed);
 void Motor_Stop();
#line 33 "c:/edward/motor.h"
void Motor_Init()
{
 if (motor_init_==0)
 {
 motor_init_=1;
 ANSELH.F0=0;
 ANSELH.F2=0;
 TRISB.F1=0;
 TRISB.F2=0;
 TRISD.F0=0;
 TRISD.F1=0;
 Pwm1_Init(5000);
 Pwm2_Init(5000);
 }
}





void Change_Duty(char speed)
 {
 if (speed != motor_duty_)
 {
 motor_duty_=speed;
 PWM1_Set_Duty(speed);
 PWM2_Set_Duty(speed);


 }
 }



void Motor_A_FWD()
{
 Pwm1_Start();
 PORTD.F0 =0;
 PORTD.F1 =1;
}



void Motor_B_FWD()
{
 Pwm2_Start();
 PORTB.F1 =0;
 PORTB.F2 =1;
}



void Motor_A_BWD()
{
 Pwm1_Start();
 PORTD.F0 =1;
 PORTD.F1 =0;
}



void Motor_B_BWD()
{
 Pwm2_Start();
 PORTB.F1 =1;
 PORTB.F2 =0;
}
#line 124 "c:/edward/motor.h"
void S_Right(char speed)
{
 Motor_Init();
 Change_Duty(speed);
 Motor_A_FWD();
 Motor_B_BWD();
}



void S_Left(char speed)
{
 Motor_Init();
 Change_Duty(speed);
 Motor_A_BWD();
 Motor_B_FWD();
}


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
#line 1 "c:/edward/safedriving.h"
#line 1 "c:/edward/adc.h"
int Adc_Rd(char ch)
{
 int dat=0;
 if ((ch>=0) && (ch<=3))
 TRISA |= (1<<ch);
 else if (ch==4)
 TRISA |= 0x20;
 else if ((ch>=5) && (ch<=7))
 TRISE |= (1<<(ch-5));
 ANSEL |=(1<<ch);
 ADCON0 = (0xC1 + (ch*4));
 Delay_us(10);
 ADCON0.GO=1;
 while(ADCON0.GO);
 dat = (ADRESH*4)+(ADRESL/64);
 return dat;
}
#line 6 "c:/edward/safedriving.h"
short isSafe() ;


short isSafe()
{
 float Distance=100;
 int GP2=0;
 GP2=Adc_Rd(2);
 if (GP2>90)
 {
 Distance=(2914.0/(GP2+5))-1;
 }
 if(fabs(Distance-100)<1)
 return 1;
 else
 return 0;

}
#line 15 "c:/edward/a.h"
const short WorldSize=2;

short H[WorldSize][WorldSize]={0};
short h_evr[WorldSize][WorldSize]={0};
short result[WorldSize][WorldSize]={0};


const short NumberOfGoals=30;
short goal[NumberOfGoals][2]={0};


short findGoalCount=0;

short goalCount=0;



short cX=0;
short cY=0;

enum direction {UP=1,RUP=2,RIGHT=3,RDOWN=4,DOWN=5, LDOWN=6,LEFT=7,LUP=8};
enum direction cdirection=1;



void SRotare(enum direction d,enum direction nd);
 short SForward();
 short comp(short d1,short d2);
 short SMove(short nx,short ny);
 short Goal_Test(void);
 void Map_update();
 int Cost();
 void Brain();
 void A_search();
 void SetGoals();
 int mod(int x);


 short SForward()
 {
 if(isSafe())
 {
 Motor_Init();
 Change_Duty(255);
 Motor_A_FWD();
 Motor_B_FWD();
 delay_ms(1000);
 return 1;
 }
 else
 {
 Map_update();
 return 0;
 }
 }

short comp(short d1,short d2)
{
 if(d1==d2) return 0;
 if(d1>d2) return 1;
 else return -1;
}

short SMove(short nx,short ny)
{
 enum direction nd;
 short success;
 short ax;
 short ry;
 ax=comp(cX,nx);

 ry==comp(cY,ny);
 if(ax==-1)
 nd=3+ry;
 if(ax==0)
 switch(ry)
 {
 case -1:
 nd=1;
 break;
 case 0:
 nd=cdirection;

 break;
 case 1:
 nd=5;
 break;

 }
 if(ax==1)
 nd=7-ry;
 SRotare(cdirection,nd);


 if(isSafe())
 {
 Motor_Init();
 Change_Duty(255);
 Motor_A_FWD();
 Motor_B_FWD();
 delay_ms(1000);
 success=1;
 }
 else
 {
 Map_update();
 success=0;
 }

 return success;
}

short Goal_Test(void)
{

 if(findGoalCount==goalCount) return 1;
 else

 return 0;
}





void SRotare(enum direction d,enum direction nd)
{
 short r;
 r=(d-nd);
 if(r>4) r=8-r;
 if(r>=0)
 S_Right(r*45);
 else
 S_Left(-r*45);
}



void Map_update()
{
 if(!isSafe())
 {
 switch(cdirection)
 {
 case UP:
 result[cX][cY+1]=100;
 break;
 case RUP:
 result[cX+1][cY+1]=100;
 break;
 case RIGHT:
 result[cX+1][cY]=100;
 break;
 case RDOWN:
 result[cX+1][cY-1]=100;
 break;
 case DOWN:
 result[cX-1][cY]=100;
 break;
 case LDOWN:
 result[cX-1][cY-1]=100;
 break;
 case LEFT:
 result[cX-1][cY]=100;
 break;
 case LUP:
 result[cX-1][cY+1]=100;
 break;

 }
 }
}

int Cost(int cX,int cY)
{
asm {
 BSF IRP,9
}
 return h_evr[cX][cY]+H[cX][cY]+result[cX][cY];
 asm {
 BCF IRP,9
}
}

 int mod(int x)
 {
 if(x>=0) return x;
 else return -x;
 }






void Brain()
{

 short N=0;
 int i,j,k;
 int m,s,r;
 int temp=0;
 for(i=0;i<WorldSize;i++)
 for(k=0;k<WorldSize;k++)
 h_evr[i][k]=2*WorldSize+1;

 for(i=0;i<NumberOfGoals;i++)
 {
 for(j=0;j<WorldSize;j++)
 for(k=0;k<WorldSize;k++)
 {
 r=mod(goal[i][0]-j)+mod(goal[i][1]-k);
 if(r<h_evr[j][k]) h_evr[j][k]=r;
 }
 }









 asm { BSF IRP,9}
 for(i=0;i<N;i++)
 for(k=0;k<m;k++)
 for(j=0;j<s;j++)
 {
 temp=goal[i][0]-k+goal[i][1]-j;
 if(temp<h_evr[i][j])
 h_evr[i][j]=temp;
 }
 asm {
 BCF IRP,9
}
}

void A_search()
{
 int i,j;
 short cxx,cyy;
 int min,temp;
 if(Goal_test()) return;
 if(H[cX][cY]==0)
 {
 H[cX][cY]+=h[cX][cY];
 }


 result[cX][cY]=1;



 min=Cost(cX,cY+1);
 for(i=-1;i<=1;i++)
 for(j=-1;j<=1;j++)
 {
 if(i==0 && j==0) continue;
 temp=Cost(cX+i,cY+j);
 if(temp<min)
 {
 min=temp;
 cxx=i;
 cyy=j;
 }
 }
 if(SMove(cX+cxx,cY+cyy))
 {
 cX+=cxx;
 cY+=cyy;
 }

}

 void SetGoals()
 {


 }
#line 4 "C:/Edward/MyProject.c"
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;

 void printing(char * text)
{
 Lcd_Init();
 Lcd_cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_out(1,1,text);

}

 char error=0, byteread=0;

void startup()
{
#line 156 "C:/Edward/MyProject.c"
}
#line 189 "C:/Edward/MyProject.c"
void main()
{
char error;




 char output[50]="If You see this text robot is Okey:)";
 char delimiter[5]=" ";
char some_byte = 0x0A;
char i=0;
ANSEL = 0;
 ANSELH = 0;

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

 while (1)
 {


 while (UART1_Data_Ready())
 {
 i='0';

 i = UART1_Read();
#line 238 "C:/Edward/MyProject.c"
 if(UART1_Tx_Idle())
 {
 UART1_Write(i);
 }
 else
 printing("Error!");
 }
 Delay_ms(500);
 Motor_Stop();
 }
 }
