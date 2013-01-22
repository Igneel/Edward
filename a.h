// ����� �* � �������� ������� � ���������
// � - ������� ��������� ������ ��������� ���������� ����
// �� ������� ���������, ������� ��� ���� �������� 
// WorldSize - ������ ����, ���������.

#include "motor.h"
#include "SafeDriving.h"


// ��������� ��������, ��� ����������� ����� ����������� � ��� �������� ���������.
const short DELAY_TIME_VR_10=64; // ����� �������� �� 10 ��������
const short DELAY_TIME_1sm=71;  // �������� �� 1 ��
const short SPEED=255;

const short WorldSize=30;
int maxX=0;
int maxY=0;

const int dX=2; // �������� ������ �������� ������ ������������ ����������
const int dY=4;

// ������� ��������� ������ ���������� ������������� ���������� � ������ �����������
// cX cY direction
int cX=0;
int cY=0;
// ������ ����� ��� �������� - � ����������� �� ��������
enum direction {UP=1,RUP=2,RIGHT=3,RDOWN=4,DOWN=5, LDOWN=6,LEFT=7,LUP=8,ZEROD=9};
enum direction cdirection=1;  // �������� ����������� - �����


short cxx=0,cyy=0; // ���� ����� ������������ �������� � ������� �����������
char string[16];
char delimiter[16];

char strint[5]={0};
//------------------------------------------------------------------------------
//---------------��������� �������----------------------------------------------

 void SRotare(enum direction d,enum direction nd); // �������
 short isMetall();               // ���������� 1 ���� ������� �������������
 short comp(short d1,short d2); // ��������� ���� �����
 short SMove(short nx,short ny); // �����������
 int Cost();              // ����������� ���������
 void A_search();         // �������� ������ A*
 void Brain();             // ���������
 void Correct(void);     // ��������� ��������
 
 
 // ��� ������ � ��������:
 int getParam(const char * p,int x,int y);
 void setParam(const char * p,int x,int y,int value);
 void strConstCpy (const char *source, char *dest);
//------------------------------------------------------------------------------

// ��������� ����������� ������ �� ROM � RAM
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
// "Hint" ��� H � "hevr" ��� ���������
int getParam(const char * p,int x,int y)
{
 char temp=0;
 strConstCpy(p,string); // �������� ��� �������
 IntToStr (x,strint);
 stradd(strint,string);
 IntToStr (y,strint);
 stradd(strint,string);
 stradd("   ",string);
 UART1_Write_Text(string);
 while(1) if(UART1_Data_Ready()) // ���� �����
 {
 temp=UART1_Read();
 return temp;
 }
}

 void setParam(const char * p,int x,int y,int value)
 {
 char temp=0;
 strConstCpy(p,string); // �������� ��� �������
 IntToStr (x,strint);
 stradd(strint,string); // �������� ������ ����������
 IntToStr (y,strint);
 stradd(strint,string); // �������� ������ ����������
 IntToStr (value,strint);
 stradd(strint,string);
 stradd("   ",string);    // ���������� ������ ������� � ����� ������
 UART1_Write_Text(string); // ���������� ������
 while(1) if(UART1_Data_Ready()) // ���� �����
 {
 temp=UART1_Read();
 return;
 }
 }

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
short isMetall()
{
short m;
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
// ����������� ���� ������� ����������� � ����� ����������
// ����������� - ���������� ����������
short SMove(int nx,int ny)
{

        enum direction nd=1; // ������������� ����������� ��������
        short ax=1;
        short ry=1;
        short isMove=0; // ��������� - ���� �� ��������
        ax=comp(cX,nx);  // ���������� ������� ���������� � ���������
        ry==comp(cY,ny);
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
        //getParam("swNd",nd,1);
        switch (nd)
        {
        case 1:
        case UP:
        if(isSafeY()>2)
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
        if(isSafeY()>2 && isSafeX()>2)
        {
        S_Right(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_FWD(); // ��������� ������
        Motor_B_FWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
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
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_BWD(); // ��������� ������
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
        Motor_Stop();
        S_Right(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_FWD(); // ��������� ������
        Motor_B_FWD();
        delay_ms(3*DELAY_TIME_1sm); // ���� ���� �������  -------------------------------------------------------------------------------------------------
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
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_BWD(); // ��������� ������
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
        Motor_Stop();
        S_Right(255);
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
        S_Right(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_BWD(); // ��������� ������
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
        Motor_Stop();
        S_Left(255);
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
        S_Left(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_FWD(); // ��������� ������
        Motor_B_FWD();
        delay_ms(3*DELAY_TIME_1sm); // ���� ���� ������� ----------------------------------------------------------------------------------------------
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
        Motor_Init();  // ����������� ������
        Change_Duty(SPEED); // ������ ��������
        Motor_A_FWD(); // ��������� ������
        Motor_B_FWD();
        delay_ms(2*DELAY_TIME_1sm); // ���� ���� �������
        Motor_Stop();
        S_Right(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Correct();
        isMove=1;
        }
        break;
        case 9:
        case ZEROD:
        getParam("zerod",1,1);
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

// ��������, ���������� ������� ����������� � �����

void SRotare(enum direction d,enum direction nd)
{
int xa=0;
int ya=0;
int temp=0;
short r=0;
xa=cX;
ya=cY;


        r=(d-nd);
        if(r>4) r=8-r; // ���� ���� �������� ������ 180 - ����� �������������� � ������ �������
        if(r>=0)
        {       ;
                S_Right(255); // �������������� �� ����������� ����
                for(;r>0;r--)
                {
                Delay_ms(DELAY_TIME_VR_10*45/10);
                if(r%2==1) continue;
                switch(cdirection)
                {
                case UP:
                  xa=cY;
                  ya=-dX+cX;
                break;
                case DOWN:
                  xa=cY;
                  ya=cX+dY;
                break;
                case RIGHT:
                  xa=cY;
                  ya=-2*dX+cX;
                break;
                case LEFT:
                  xa=cY;
                  ya=cX+dX;
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
                  xa=cY-2*dY;
                  ya=cX;
                break;
                case DOWN:
                  xa=cY;
                  ya=2*dX+cX;
                break;
                case RIGHT:
                  xa=cY;
                  ya=cX+dY;
                break;
                case LEFT:
                  xa=cX+dX;
                  ya=cX;
                break;
                }
                }
        }
        Motor_Stop();
cdirection=nd;
cX=xa;
cY=ya;
}


void Correct(void) // ������������ ����������� ������
{
short r,nr;
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



// ��������������� ��� �����
void A_search()
{
        //int i,j;
        int min,temp;
        //if(getParam("jobisdone?",1,1)==13) return; // ���� ���� ������� ��� ������ �������� - ��������� ������.
        
        temp=getParam("Hint",cX,cY); // �������� �������� ��������� ��� �������� ���������

        setParam("Hint",cX,cY,++temp); // ����������� ���, �.�. �� ��� �����
        // ��������� ��������������� ��������� ���������
        /*min=getParam("H+hevr",cX,cY+1);
        cxx=0;
        cyy=1;
        for(i=-1;i<=1;i++) // � ��� � ����� ��������� 8 ��������� ��������
        {
           for(j=-1;j<=1;j++)//----------------------------------------------------------------------------------------------------------------------!!!!!
              { // ����������� ��� ��������� ��������� � ������� ���������
                  if(i==0 && j==0) continue;
                  temp=getParam("H+hevr",cX+i,cY+j);
                  if(temp<min) // ������� ����������� ���������
                  {            // � ������ ��������� � ����
                     min=temp;
                     cxx=i;
                     cyy=j;
                  }
              }
        }   */
        cxx=getParam("Calc",cX,cY);
        cyy=getParam("Calc2",cX,cY);
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
        // ���� ����������� �� ���������, �� ����� ���� �� ������� ��� �� ����
        // ��� ��� ��� ��������� ������ �����������

}

// ������� ������ ������ �� �����
 short mod(short x)
 {
 if(x>=0) return x;
 else return -x;
 }
// ������� ���������� ������������� ������ h ���� ��������� �� ����
void Brain()
{
        short x,y,j,k;
        short r;
        // �� ������ ������ ������� ���� ������ ���� ����������
        for(x=0;x<WorldSize;x++)
        {
        for(y=0;y<WorldSize;y++)
        {
        if(getParam("Hint",x,y)/*H[x][y]*/!=0) continue; // ���� �������� �� �������- ������ �� ��� ���� � �� �����.
        for(j=0;j<WorldSize;j++) // x
         for(k=0;k<WorldSize;k++) // y
             {
             r=mod(x-j)+mod(y-k);  // ������������ ����������
             if(r<getParam("hevr",j,k)) setParam("hevr",j,k,r); //h_evr[j][k])  // h_evr[j][k]=r; // ���� ���� ���� ����� - ������� ���������� �� ��
             }
        }
        }
}