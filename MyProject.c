
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

 char error=0, byteread=0;
 
void startup()
{
/*int i=1;
char wr='H';
char byteread=0;
char w[30]="Hellow, I'm RoboPICa!";

 char uart_rd;
ANSEL  = 0;                             // Configure AN pins as digital I/O
  ANSELH = 0;
  TRISA=0x00;
  //TRISB = 0x00;                           // Set PORTB as output (error signalization)
  //PORTB = 0;                              // No error
//TRISB.F3=0;
printing("Prepairing");

if(!Soft_UART_Init(&PORTC, 7, 6, 9600, 0))
{
printing("Good Init!");
}  */
///else
//{
 //printing("Bad Init!");
//return;
//}
//delay_ms(5000);
//------------------------------------------------------------------------------
//while(1)
//{

//printing("Hellow, I'm RoboPICa!");
//delay_ms(1000);
//printing(wr);
//Soft_UART_Write('o');
/*Soft_UART_Write('e');
Soft_UART_Write('L');
Soft_UART_Write('L');
for(i=0;i<20;i++)
Soft_UART_Write('o');
Soft_UART_Write('W');*/
  //Soft_UART_Write('r');
   // Soft_UART_Write('n');
//delay_ms(1000);
//for(i=0;i<9;i++)
//byteread[i]=Soft_UART_Read(&error);
//byteread[9]='\n';
//printing(error);
//printing(byteread);

/*byteread=Soft_UART_Read(&error);
switch(byteread)
{
case 'S':
S_Left(255);
break;
default:
break;
}     */
//w[2]=byteread;
//w[3]='\0';
//printing(w);
//}


//------------------------------------------------------------------------------*/

 /*//char uart_rd;
 //int i=0;
 ANSEL  = 0;                     // Configure AN pins as digital
  ANSELH = 0;
  //TRISC.F7=0; // output
  //TRISC.F6=1; // input

  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);

  while (1) 
  {

  delay_ms(1000);                   // Endless loop
    if (UART1_Data_Ready()) 
    {     // If data is received,
    printing ("data is");
    delay_ms(1000);

      PORTB.F3=1;
      uart_rd = UART1_Read();     // read the received data,
      printing (uart_rd);
      UART1_Write(uart_rd);       // and send data via UART
      PORTB.F3=0;
      delay_ms(1000);
    }
    if (UART1_Tx_Idle() == 1) {
    printing ("Data Idle");
    UART1_Write_Text("Connectons!");
    UART1_Write(10);
    UART1_Write(13);
                    }
    UART1_Write(50);       // and send data via UART
  }
  */


/*switch(byteread)
{
 case 15:
 SForward();

 break;
 case 16:
 S_Right(255);
 Delay_ms(1000);
 break;
 case 17:
 S_Left(255);
 Delay_ms(1000);
 default:
 break;
} */


//Motor_Stop();
//Delay_ms(1000);
}

/*void Async ()
{
char data1='d';
TXSTA=0x24;
RCSTA=0xB0;
SPBRG=9600;
while(1) // передача
{
TXREG=data1;
TXREG=13;
delay_ms(100);
}
while(1)
{
if(RCIF)
data1=RCREG;
printing(data1);
}
}


void SyncV()
{
char data1='d';
TXSTA=0xB4;
RCSTA=0xB0;
SPBRG=9600;

}  */


void main() 
{
char error;
//char x;



 char output[50]="If You see this text robot is Okey:)";
 char delimiter[5]=" ";
char some_byte = 0x0A;
char i=0;
ANSEL  = 0;                     // Configure AN pins as digital
  ANSELH = 0;

  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);

  while (1) 
  {     

                  // Endless loop
    while (UART1_Data_Ready())
    {
    i='0';

      i = UART1_Read();     // read the received data,
      //output[0]=i;
      //output[1]='\0';
      // printing(output);
      /*if(i>=128 && i<=248)
      S_Left(255);
      if(i>248 && i<=255)
      S_Right(255);*/
      /*
      switch (i)
      {
      case 0: case 249:
      S_Left(255);
      break;
      case 1: case 248:
      S_Right(255);
      break;
      default:
      break;
      } */
      if(UART1_Tx_Idle())
      {
      UART1_Write(i);       // and send data via UART
      }
      else
      printing("Error!");
    }
   Delay_ms(500);
   Motor_Stop();
  }
  }
  

   /*if(i!=0)
   {
   IntToStr(i,&error);
   printing(&error);
   Soft_UART_Write(error);
   } */


  //startup();