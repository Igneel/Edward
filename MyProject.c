
#include "a.h"
//  настройка выводов Lcd
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
// настройка направлений
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
int x,y;
     UART1_Init(9600);
     while(getParam("start",1,1)!=13) // ждем сигнала старта
     Delay_ms(100);
     
     cdirection=UP; // начальное направление - вверх
     cX=WorldSize-isSafeX()/2-1;  // получаем текущие координаты
     cY=WorldSize-isSafeY()/2-1;
     
     
while(getParam("jobisdone?",1,1)!=13)
{

  enum direction nd;
x=isSafeX();
y=isSafeY();

if(x==100 || y==100)
{
if(cX<=20 && cY<=10)
 nd=DOWN;
if(cX>20 && cY<=10)
 nd=RIGHT;
if(cY<=20 && cY>10 && cX<=20)
 nd=LEFT;
if(cY<=20 && cY>10 && cX>20)
 nd=RIGHT;
if(cY>20 && cX<=20)
 nd=LEFT;
if(cY>20 && cX>20)
 nd=UP;
 SRotare(cdirection,nd);
 cdirection=nd;
}
A_search();
}
}