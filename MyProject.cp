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
 void Backward(char speed);
 void S_Right(char speed);
 void S_Left(char speed);
 void Motor_Stop();
#line 32 "c:/edward/motor.h"
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
#line 5 "c:/edward/safedriving.h"
const unsigned char channelY=2;
const unsigned char channelX=3;



int isSafeY();
int isSafeX();


int isSafeY()
{
 int Distance=100;
 int GP2=0;
 GP2=Adc_Rd(channelY);
 if (GP2>90)
 {
 Distance=(2914.0/(GP2+5))-1;
 }
 return Distance;

}

int isSafeX()
{
 int Distance=100;
 int GP2=0;
 GP2=Adc_Rd(channelX);
 if (GP2>90)
 {
 Distance=(2914.0/(GP2+5))-1;
 }
 return Distance;

}
#line 11 "c:/edward/a.h"
const short DELAY_TIME_VR_10=64;
const short DELAY_TIME_1sm=71;
const short SPEED=255;
const double Pi=3.14159;

const short WorldSize=30;
int maxX=0;
int maxY=0;

const int dX=2;
const int dY=4;
const double dfi=1.108;
const double Radius=4.472;



int cX=0;
int cY=0;

enum direction {UP=1,RUP=2,RIGHT=3,RDOWN=4,DOWN=5, LDOWN=6,LEFT=7,LUP=8,ZEROD=9};
enum direction cdirection=1;


short cxx=0,cyy=0;
char string[29];
char delimiter[16];

char strint[5]={0};



 void SRotare(enum direction d,enum direction nd);
 short isMetall();
 short comp(short d1,short d2);
 short SMove(short nx,short ny);
 int Cost();
 void A_search();
 void Brain();
 void Correct(void);



 int getParam(const char * p,int x,int y);
 void setParam(const char * p,int x,int y,int value);
 void strConstCpy (const char *source, char *dest);



void strConstCpy (const char *source, char *dest) {
 while (*source) *dest++ = *source++;
 *dest = 0;
}
void stradd(char *source, char *dest){
while (*dest++);
*dest--;
while (*source) *dest++ = *source++;
 *dest = 0;
}

int getParam(const char * p,int x,int y)
{
 char temp=0;
 strConstCpy(p,string);
 IntToStr (x,strint);
 stradd(" g ",string);
 stradd(strint,string);
 IntToStr (y,strint);
 stradd(strint,string);
 stradd(" ",string);
 stradd("    0 ",string);
 UART1_Write_Text(string);
 while(1) if(UART1_Data_Ready())
 {
 temp=UART1_Read();
 return temp;
 }
}

 void setParam(const char * p,int x,int y,int value)
 {
 char temp=0;
 strConstCpy(p,string);

 IntToStr (x,strint);
 stradd(" s ",string);
 stradd(strint,string);
 IntToStr (y,strint);
 stradd(strint,string);
 IntToStr (value,strint);
 stradd(strint,string);
 stradd(" ",string);
 UART1_Write_Text(string);
 while(1) if(UART1_Data_Ready())
 {
 temp=UART1_Read();
 return;
 }
 }



short isMetall()
{
short m;
m=Adc_Rd(1);
if(m>0 && m<50)
return 1;
else
return 0;
}

short comp(int d1,int d2)
{
 if(d1==d2) return 0;
 if(d1>d2) return 1;
 else return -1;
}


short SMove(int nx,int ny)
{

 enum direction nd=1;
 short ax=1;
 short ry=1;
 int temp=0;
 int temp1=0;
 short isMove=0;
 ax=comp(cX,nx);
 ry=comp(cY,ny);

 if(ax==-1)
 nd=RIGHT+ry;
 if(ax==0)
 switch(ry)
 {
 case -1:
 nd=UP;
 break;
 case 0:
 nd=ZEROD;

 break;
 case 1:
 nd=DOWN;
 break;

 }
 if(ax==1)
 nd=LEFT-ry;

 temp1=isSafeY();
 temp=isSafeX();
 getParam("isSafe",temp,temp1);
 switch (nd)
 {
 case 1:
 case UP:
 if(isSafeY()>2)
 {

 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_FWD();
 Motor_B_FWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 Correct();
 isMove=1;
 }
 break;
 case 2:
 case RUP:
 if(isSafeY()>2 && isSafeX()>2)
 {
 S_Right(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_FWD();
 Motor_B_FWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 S_Left(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Correct();
 isMove=1;
 }
 break;
 case 3:
 case RIGHT:
 if(isSafeX()>2)
 {
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_BWD();
 Motor_B_BWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 S_Right(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_FWD();
 Motor_B_FWD();
 delay_ms(3*DELAY_TIME_1sm);
 Motor_Stop();
 S_Left(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Correct();
 isMove=1;
 }
 break;
 case 4:
 case RDOWN:
 if(isSafeX()>2)
 {
 S_Left(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_BWD();
 Motor_B_BWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 S_Right(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Correct();
 isMove=1;
 }
 break;
 case 5:
 case DOWN:
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_BWD();
 Motor_B_BWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 Motor_Init();
 Correct();
 isMove=1;
 break;
 case 6:
 case LDOWN:
 S_Right(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_BWD();
 Motor_B_BWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 S_Left(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Correct();
 isMove=1;
 break;
 case 7:
 case LEFT:
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_BWD();
 Motor_B_BWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 S_Left(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_FWD();
 Motor_B_FWD();
 delay_ms(3*DELAY_TIME_1sm);
 Motor_Stop();
 S_Right(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Correct();
 isMove=1;
 break;
 case 8:
 case LUP:
 if(isSafeY()>2)
 {
 S_Left(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Motor_Init();
 Change_Duty(SPEED);
 Motor_A_FWD();
 Motor_B_FWD();
 delay_ms(2*DELAY_TIME_1sm);
 Motor_Stop();
 S_Right(255);
 delay_ms(DELAY_TIME_VR_10*15/10);
 Correct();
 isMove=1;
 }
 break;
 case 9:
 case ZEROD:
 getParam("zerod ",1,1);
 break;
 }


 if(isMetall())
 {

 if(isMove)
 setParam("Metall",nx,ny,1);
 }
 return isMove;

}



void SRotare(enum direction d,enum direction nd)
{
int xa=0;
int ya=0;
int temp=0;
short r=0;


 r=(d-nd);
 if(r>4) r=8-r;
 if(r>=0)
 { ;
 S_Right(255);
 for(;r>0;r--)
 {
 Delay_ms(DELAY_TIME_VR_10*45/10);
 if(r%2==1) continue;
 switch(cdirection)
 {
 case UP:
 xa=cX+Radius*cos(dfi-Pi/2);
 ya=cY+Radius*sin(dfi-Pi/2);
 break;
 case DOWN:
 xa=cX+Radius*cos(dfi+Pi-Pi/2);
 ya=cY+Radius*sin(dfi+Pi-Pi/2);
 break;
 case RIGHT:
 xa=cX+Radius*cos(dfi-Pi/2-Pi/2);
 ya=cY+Radius*sin(dfi-Pi/2-Pi/2);
 break;
 case LEFT:
 xa=cX+Radius*cos(dfi+Pi/2-Pi/2);
 ya=cY+Radius*sin(dfi+Pi/2-Pi/2);
 break;
 }
 }
 }
 else
 {
 S_Left(255);
 for(;r<0;r++)
 {
 Delay_ms(DELAY_TIME_VR_10*45/10);
 if((-r)%2==1) continue;
 switch(cdirection)
 {
 case UP:
 xa=cX+Radius*cos(dfi+Pi/2);
 ya=cY+Radius*sin(dfi+Pi/2);
 break;
 case DOWN:
 xa=cX+Radius*cos(dfi+Pi+Pi/2);
 ya=cY+Radius*sin(dfi+Pi+Pi/2);
 break;
 case RIGHT:
 xa=cX+Radius*cos(dfi-Pi/2+Pi/2);
 ya=cY+Radius*sin(dfi-Pi/2+Pi/2);
 break;
 case LEFT:
 xa=cX+Radius*cos(dfi+Pi/2+Pi/2);
 ya=cY+Radius*sin(dfi+Pi/2+Pi/2);
 break;
 }
 }
 }
 Motor_Stop();
cdirection=nd;
cX=xa;
cY=ya;
}


void Correct(void)
{
short r,nr;
r=isSafeY();
S_Left(DELAY_TIME_VR_10);
nr=isSafeY();
if(r==nr)
S_Right(DELAY_TIME_VR_10);
if(r>nr)
return;
if(r<nr)
S_Right(2*DELAY_TIME_VR_10);
Motor_Stop();
}




void A_search()
{
 int temp=0;
 temp=getParam("Hint  ",cX,cY);
 setParam("Hint  ",cX,cY,++temp);

 cxx=getParam("Calc  ",cX,cY);
 cyy=getParam("Calc2 ",cX,cY);
 if(cdirection==UP) ;
 if(cdirection==DOWN) cyy*=-1 ;
 if(cdirection==LEFT)
 {
 temp=cxx;
 cxx=cyy;
 cyy=-temp;
 }
 if(cdirection==RIGHT)
 {
 temp=cxx;
 cxx=cyy;
 cyy=-temp;
 }
 if(SMove(cX+cxx,cY+cyy))
 {
 cX+=cxx;
 cY+=cyy;
 }



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

void main()
{
int temp=0;
 int temp1=0;
 UART1_Init(9600);
 while(getParam("start ",1,1)!=13)
 Delay_ms(100);

 cdirection=DOWN;
 cX=isSafeX()/2;
 cY=isSafeY()/2;
 getParam("Hint  ",cX,cY);
 SRotare(cdirection,UP);
 maxX=cX+isSafeX()/2;
 maxY=cY+isSafeY()/2;

 temp1=isSafeY();
 temp=isSafeX();
 getParam("isSafe",temp,temp1);
 setParam("max   ",maxX,maxY,1);
 getParam("Hint  ",cX,cY);

while(getParam("jbsdne",1,1)!=13)
{

 enum direction nd;
#line 71 "C:/Edward/MyProject.c"
A_search();
}
}
