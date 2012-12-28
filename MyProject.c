
#include "a.h"
// Lcd pinout settings
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
// Pin direction
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
short j,k;
     for(j=0;j<WorldSize;j++) // x
         for(k=0;k<WorldSize;k++) // y
             {
             h_evr[j][k]=2*WorldSize; // задаем ненулевые значения эвристики.
             // чтобы дальше сравнивать их с реальными расстояниями.
             }
while(findGoalCount<NumberOfGoals)
{
Brain();
A_search();
}
}