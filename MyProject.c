
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
    int temp=0;
    int temp1=0;
    UART1_Init(9600);
    while(getParam("start ",1,1)!=13) // ждем сигнала старта
    Delay_ms(100);
     
    cdirection=DOWN; // начальное направление - вниз
    cX=isSafeX()/2;  // получаем текущие координаты
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
    
    shitch(cdirection)
    {
      case UP:
        r=cY-2dY;
        nd=DOWN;
        break;
      case DOWN:
        r=cY+2dY;
        nd=UP;
        break;
      case LEFT:
        r=cX+2dY;
        nd=RIGHT;
        break;
      case RIGHT:
        r=cX-2dY;
        nd=LEFT;
        break;
    } 
    if(r<2) 
    {
      SRotare(cdirection,nd);
      Backward(SPEED);
      delay_ms(DELAY_TIME_1sm*2*2*dY);
    }

  A_search();
  }
}