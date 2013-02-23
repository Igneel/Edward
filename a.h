#ifndef A_H_
#define A_H_ 

// ����� �* � �������� ������� � ���������
// � - ������� ��������� ������ ��������� ���������� ����
// �� ������� ���������, ������� ��� ���� �������� 

#include "motor.h" // ����� ���������� ������� �������� ������.
#include "SafeDriving.h" // ����� ���������� ������� ��������� ���������� � �����������.

/*
�� ��:
1. ������� ������ ��������������� � ���������� � ������ ����������, ��� ����������� ���������� ����� ������ ����.
    �) �������� � ������ �������
    ��� ������������ ��������� �� 4 ��������, 
    ���� ��������������� ������ ��������� �� ����� � ������ - �� ����� ����� ������������, ����� � ��������� �����
    �) ��� �������� �� 180 �������� - �������� ����� ����������� ����� 2*dY
    �) ��� �������� �� 90 �������� - �������� ����� �������� ����� dY+ dX
    ��� ����� ������� ��������� ��������, �������� �� �������� - ����� �������� �������� ����-����.
    ���� ������� ��������������, ������ ���� �� ��������� ��� ��������� ���� ����� ����� ������������ �� �����.
    ��� �����:
        �) ����� ��������� ������� ����������� ������
        shitch(d)
        {
        case UP:
        break;
        case DOWN:
        break;
        case LEFT:
        break;
        case RIGHT:
        break;
        }
        �) ������������ ������������� ���������� �� ������� ���� ������ �� �����.
        ������ ���� ������, ���
        shitch(d)
        {
        case UP:
        r=cY-2dY;
        break;
        case DOWN:
        r=cY+2dY;
        break;
        case LEFT:
        r=cX+2dY;
        break;
        case RIGHT:
        r=cX-2dY;
        break;
        } 
        if(r<2) 
        {
        SRotare(cd,nd);
        SForward(255);
        delay_ms()
        }


2. �������������� ����� ������� �������� ������.
3. ����� ������ �������� ������� � ������, � �� � �������� (���� ������ \n ����� ��������� ������������ - �� ��� ��.)
    ����� ����������� ����� ������ ������ � �������� ��������������, � ��� ����� �������� ������� ����� - ��� �� ������������ � ��������.
4. ��������� ���������� ������������ ������������.
    �������� ����� �������� ��� ������� �� �����, � � ���������.
    ������� ������� ���� ������� ��� ���� ����������� ���������.
5. ������ ��� ���������� ��������� ������������� ��������.
    � ������� ���� �������� ���� �����, ������� �������������� ���������.
    ����� ��������� ���� �������� ��� ��������.
    ���� �� �������������� �������� �� ��� ������� ������.
    ��������� - � ����� ����������� ����� ������� ��������� � ����������, ���� �������� �� ���������� � ����������...
6. �������� ������� ������������� ������.
    +�) �������� �� ����� ������ ���������������� �����������, �������� ������.
7. ������ �������� ����� ���������� � ��������� ���.
8. ������� ��� ������������ �������, �� ��������� � ���������.
9. ����� �����, ��������������� ������ ������.
10. �������� ���������� �������, � ������� ����� ��� �� ������ �������.
+11. ������ ���� ����������� �������� � ������������ �����.
    ����� ����� ���������� ������� ����� �����, ��������� ������ ������� ��������������� ���������.
    ����� ����� ����� �������� �� ���.
    ��� ����� ����� ���������.
    � ����� ���� ����� �����, �.�. ��������� ������������� ������ ����� ����� ���������� �� ������ ���������.
+12. ������ �������� ���������� ������������� ������, �������� ���������� ����������. (������������ ����������.)
*/
// ��������� ��������, ��� ����������� ����� ����������� � ��� �������� ���������.
const short DELAY_TIME_VR_10=64; // ����� �������� �� 10 ��������
const short DELAY_TIME_1sm=71;  // �������� �� 1 ��, �.�. ����� �� ������� ����� �������� 1��
const short SPEED=255; // �������� ������, 255 - ��������.
const double Pi=3.14159; // ����� ��, ���������
const int dX=2; // �������� ������ �������� ������ ������������ ����������
const int dY=4; // ������� ��������� - ������, 1 ������ = 2 ��
const double dfi=1.108;// // ����, ����� ���������������� � ������������ � ��������, � �������� ��� 63.48
const double Radius=4.472; // ���������� �� ������ ��������, �� ��������������� � �������

int maxX=0; // ������������ ������� ����
int maxY=0; // ������������ �� ����� ������ ������ ������
// ������� ��������� ������ ���������� ������������� ���������� � ������ �����������
// cX cY direction
int cX=0; // ������������ �� ����� ������ ������.
int cY=0;
// ��������� ����������� ������.
enum direction {UP=1,RUP=2,RIGHT=3,RDOWN=4,DOWN=5, LDOWN=6,LEFT=7,LUP=8,ZEROD=9};

enum direction cdirection=1;  // ��������� ����������� - �����
short cxx=0,cyy=0; // ���� ����� ������������ �������� � ������� �����������
char string[29]; // ����� ��� �������� ������������ ������.
char strint[6]={0};// ����� ��� �������� �����, ���������������� � ������, ��� �������� �� �������.
// ������������ �� ������������� �������� ��� ������.

//------------------------------------------------------------------------------
//---------------��������� �������----------------------------------------------

 void SRotare(enum direction d,enum direction nd); // �������
 short isMetall();               // ���������� 1 ���� ������� �������������
 short comp(int d1,int d2); // ��������� ���� �����
 short SMove(int nx,int ny); // �����������
 void A_search();         // �������� ������ A*
 void Correct(void);     // ��������� ��������
 
 
 // ��� ������ � ��������:
 int getParam(const char * p,int x,int y); // ��������� ��������
 void setParam(const char * p,int x,int y,int value); // ��������� ��������
 void strConstCpy (const char *source, char *dest); // ����������� ������ �� ROM � RAM
 void stradd(char *source, char *dest); // ��������� ���� ������ � ����� � ������
//------------------------------------------------------------------------------

// ��������� ����������� ������ �� ROM � RAM
void strConstCpy (const char *source, char *dest) {
 while (*source) *dest++ = *source++;
 *dest = 0;
}

// ���������� �����
void stradd(char *source, char *dest){
while (*dest++);
*dest--;
while (*source) *dest++ = *source++;
 *dest = 0;
}
// "Hint  " ��� H � "hevr  " ��� ���������
// ����� ������� - 6 ��������
// ����� ��� ������ - ����������� �������
// ��������� ��� - ������� �� ����� �� �������� ������� �����.
// ���� ����������� ������� � ��������������.
int getParam(const char * p,int x,int y)
{
    /*
    ��� ������� - 6 ��������
    start 
    �������� get ��� �������
    start  g 
    ���������� ���� �� 6 �������� � ��� ���-�� ����� �� ��������� - ������� �������������� ��� ��������.
start  g      1     1      0
���� ������� �� ���� ��������� �� ������ �������� �� ����� ������.
����� 28 �������� + �� ���� ������ ���� ��� \n

    */
 char temp=0;
 strConstCpy(p,string); // �������� ��� �������
 IntToStr (x,strint);   
 stradd(" g ",string);  // �������� get
 stradd(strint,string); // ���������� ������ ����������
 IntToStr (y,strint);
 stradd(strint,string); // �������� ������ ����������
 stradd(" ",string);
 stradd("     0\n",string); // ��������� ������ ��������� ��������
 UART1_Write_Text(string);
 while(1) if(UART1_Data_Ready()) // ���� �����
 {
 temp=UART1_Read();
 return temp;
 }
}
// ��������� ���������
 void setParam(const char * p,int x,int y,int value)
 {

     char temp=0;
     strConstCpy(p,string); // �������� ��� �������
     IntToStr (x,strint);
     stradd(" s ",string);
     stradd(strint,string); // �������� ������ ����������
     IntToStr (y,strint);
     stradd(strint,string); // �������� ������ ����������
     IntToStr (value,strint);
     stradd(strint,string);  // �������� ��������
     stradd("\n",string);    // ���������� ������ ����� ������
     UART1_Write_Text(string); // ���������� ������
     while(1) if(UART1_Data_Ready()) // ���� �����
     {
         temp=UART1_Read();
         return;
     }
 }

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

// ��������������� ��� �����
void A_search()
{
    int temp=0;
    temp=getParam("Hint  ",cX,cY); // �������� �������� ��������� ��� �������� ���������
    setParam("Hint  ",cX,cY,++temp); // ����������� ���, �.�. �� ��� �����
    // ��������� ��������������� ��������� ���������
    cxx=getParam("Calc  ",cX,cY);
    cyy=getParam("Calc2 ",cX,cY);
    // �������� �������� �������� �������� �����������.
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
    if(SMove(cX+cxx,cY+cyy)) // ������������ � ��������� ���������
    {
        cX+=cxx; // ���������� ������� ���������
        cY+=cyy;
    }
    else
    { // ���� ����������� �� ��������� - ��������� ��������� ��������� ����.
        temp=getParam("Hint  ",cX+cxx,cY+cyy);
        setParam("Hint  ",cX+cxx,cY+cyy,++temp);
    }
}

// ��������, ���������� ������� ����������� � �����

void SRotare(enum direction d,enum direction nd)
{
/*
����� ��������� ������ ������������ ������, ��������������� � ��� ����� �������� �� ����������
� �������� Radius, ���������� ��������������� ���������� �������� ��������� ������������������
����������.
*/
    int temp=0;
    short r=0;
    r=(d-nd);
    if(r>4) r=8-r; // ���� ���� �������� ������ 180 - ����� �������������� � ������ �������
    if(r>=0)
    {        
        S_Right(SPEED); // �������������� �� ����������� ����
        for(;r>0;r--)
        {
            Delay_ms(DELAY_TIME_VR_10*45/10);
            if(r%2==1) continue;
            switch(cdirection)
            {
            case UP:
                cX=cX+Radius*cos(dfi-Pi/2);
                cY=cY+Radius*sin(dfi-Pi/2);
                break;
            case DOWN:
                cX=cX+Radius*cos(dfi+Pi-Pi/2);
                cY=cY+Radius*sin(dfi+Pi-Pi/2);
                break;
            case RIGHT:
                cX=cX+Radius*cos(dfi-Pi/2-Pi/2);
                cY=cY+Radius*sin(dfi-Pi/2-Pi/2);
                break;
            case LEFT:
                cX=cX+Radius*cos(dfi+Pi/2-Pi/2);
                cY=cY+Radius*sin(dfi+Pi/2-Pi/2);
                break;
            }
        }
    }
    else
    {
        S_Left(SPEED);
        for(;r<0;r++)
        {
            Delay_ms(DELAY_TIME_VR_10*45/10);
            if((-r)%2==1) continue;
            switch(cdirection)
            {
            case UP:
                cX=cX+Radius*cos(dfi+Pi/2);
                cY=cY+Radius*sin(dfi+Pi/2);
                break;
            case DOWN:
                cX=cX+Radius*cos(dfi+Pi+Pi/2);
                cY=cY+Radius*sin(dfi+Pi+Pi/2);
                break;
            case RIGHT:
                cX=cX+Radius*cos(dfi-Pi/2+Pi/2);
                cY=cY+Radius*sin(dfi-Pi/2+Pi/2);
                break;
            case LEFT:
                cX=cX+Radius*cos(dfi+Pi/2+Pi/2);
                cY=cY+Radius*sin(dfi+Pi/2+Pi/2);
                break;
            }
        }
    }
    Motor_Stop();
    cdirection=nd;
}

// ���� �������� ������ �����, ���� ������ ��������)
void Correct(void) // ������������ ����������� ������
{
    short r=0,nr=0;
    r=isSafeY();                // ��������� ����������
    S_Left(DELAY_TIME_VR_10);  // �����������
    nr=isSafeY();               // ��������� ����������
    if(r==nr)                   // �������� ��, ���� �������� ���������� �����������
        S_Right(DELAY_TIME_VR_10);  // �� �� ��������� � ���������� ���������
    if(r>nr)
        return;
    if(r<nr)
        S_Right(2*DELAY_TIME_VR_10);
    Motor_Stop();
}
// ����������� ���� ������� ����������� � ����� ����������
// ����������� - ���������� ����������
short SMove(int nx,int ny)
{
    /*
��� ������� ���� ����������� �� ������������ �������� ������� � ���� �������,
�.�. ��� �� ���� ������ ����������� ����������, � ���������� ����������� ������
����������� ������ ��� ������������� ���������.
�������� - ��������� ��������� � ��� � ���, �.�. ����� ���� ����������� (���� �� ��� ���, ������ ����� �������� �����).
    */
    enum direction nd=1; // ������������� ����������� ��������
    int SafeX=0; // ���� �������� ���������� �� ������.
    int SafeY=0;
    short ax=0; // ��������� �� ��� �
    short ry=0; // ��������� �� ��� �
    int temp=0;
    int temp1=0;
    short isMove=0; // ��������� - ���� �� ��������
    ax=comp(cX,nx);  // ���������� ������� ���������� � ���������
    ry=comp(cY,ny);
    // � ����������� �� ����������� - ���������� ������ �����������
    if(ax==-1)  // ���� ��� ����� �������
            nd=RIGHT+ry;
    if(ax==0)    // ��������� �� ��� � �� �����
            switch(ry)
            {
                case -1: //
                    nd=UP;
                    break;
                case 0:
                    nd=ZEROD;
                    // �� ��� ��������� � ������ �����
                    break;
                case 1:
                   nd=DOWN;
                    break;
            }
    if(ax==1)   // ���� ��� ����� ������
            nd=LEFT-ry;
    // �� ���������� ����� �����������, ������ ����� �������������.
    // �������� ��������� � ����������� ���� ���, � ����� ���������� ��� ����������.
    SafeY=isSafeY();
    SafeX=isSafeX();
    getParam("isSafe",SafeX,SafeY);
    switch (nd)
    {
    case 1:
    case UP:
        if(SafeY>2)
        {
            Motor_Init();  // ����������� ������
            Change_Duty(SPEED); // ������ ��������
            Motor_A_FWD(); // ��������� ������
            Motor_B_FWD();
            delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
            Motor_Stop();
            Correct();
            isMove=1;
        }
        break;
    case 2:
    case RUP:
        if(SafeY>2 && SafeX>2)
        {
            S_Right(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Motor_Init();  // ����������� ������
            Change_Duty(SPEED); // ������ ��������
            Motor_A_FWD(); // ��������� ������
            Motor_B_FWD();
            delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
            Motor_Stop();
            S_Left(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Correct();
            isMove=1;
        }
        break;
    case 3:
    case RIGHT:
        if(SafeX>2)
        {
            Motor_Init();  // ����������� ������
            Change_Duty(SPEED); // ������ ��������
            Motor_A_BWD(); // ��������� ������
            Motor_B_BWD();
            delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
            Motor_Stop();
            S_Right(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Motor_Init();  // ����������� ������
            Change_Duty(SPEED); // ������ ��������
            Motor_A_FWD(); // ��������� ������
            Motor_B_FWD();
            delay_ms(3*DELAY_TIME_1sm); // ���� ���� �������  -------------------------------------------------------------------------------------------------
            Motor_Stop();
            S_Left(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Correct();
            isMove=1;
        }
        break;
    case 4:
    case RDOWN:
        if(SafeX>2)
        {
            S_Left(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Motor_Init();  // ����������� ������
            Change_Duty(SPEED); // ������ ��������
            Motor_A_BWD(); // ��������� ������
            Motor_B_BWD();
            delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
            Motor_Stop();
            S_Right(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Correct();
            isMove=1;
        }
        break;
    case 5:
    case DOWN:
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_BWD(); // ��������� ������
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
        Motor_Stop();
        Motor_Init();
        Correct();
        isMove=1;
        break;
    case 6:
    case LDOWN:
        S_Right(SPEED);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_BWD(); // ��������� ������
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
        Motor_Stop();
        S_Left(SPEED);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Correct();
        isMove=1;
        break;
    case 7:
    case LEFT:
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_BWD(); // ��������� ������
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
        Motor_Stop();
        S_Left(SPEED);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_FWD(); // ��������� ������
        Motor_B_FWD();
        delay_ms(3*DELAY_TIME_1sm); // ���� ���� ������� ----------------------------------------------------------------------------------------------
        Motor_Stop();
        S_Right(SPEED);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Correct();
        isMove=1;
        break;
    case 8:
    case LUP:
        if(SafeY>2)
        {
            S_Left(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Motor_Init();  // ����������� ������
            Change_Duty(SPEED); // ������ ��������
            Motor_A_FWD(); // ��������� ������
            Motor_B_FWD();
            delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
            Motor_Stop();
            S_Right(SPEED);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Correct();
            isMove=1;
        }
        break;
    case 9:
    case ZEROD: // ��� ��������� �������� - �������� � ��� ����.
        getParam("zerod ",1,1);
        break;
    }
    
    
     if(isMetall()) // ��������� ���� �� ��� �������
     {
         // �������� ������ � ��� ��� ��� �������
         if(isMove)
            setParam("Metall",nx,ny,1);
     }
     return isMove;    // �������� ���� �� ��������

}

short isMetall()
{
    short m=0;
    m=Adc_Rd(1);
    if(m>0 && m<50)
        return 1;    // ���� ������ ������������� ���������� �������
    else
        return 0;
}
// ������� ��� ���������, ���������� ��� ��������� �������� +1,0,-1
short comp(int d1,int d2)
{
    if(d1==d2) return 0; // �������� �����
    if(d1>d2) return 1; // ������ ������ �������
    else return -1; // ������ ������ �������
}
#endif