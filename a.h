// ����� �* � �������� ������� � ���������
// � - ������� ��������� ������ ��������� ���������� ����
// �� ������� ���������, ������� ��� ���� �������� 
// WorldSize - ������ ����, ���������.

#include "motor.h"
#include "SafeDriving.h"

// ��������� ��������, ��� ����������� ����� ����������� � ��� �������� ���������.
const short DELAY_TIME_20=1000;
const short DELAY_TIME_1sm=500;
const short DISTANCE_METALL=5; // ���������� � ��, ��� ������� �� �������� ������� ����������� ����������������
const short SPEED=255;

const short WorldSize=8;
// �������� ����� �������� 20�20 �� �� ����� ������.
short H[WorldSize][WorldSize]={0};
short h_evr[WorldSize][WorldSize]={0};
//short result[WorldSize][WorldSize]={0};

// ������ ���������� ���������� ���� �����
const short NumberOfGoals=WorldSize*WorldSize-1;
const short MaxMetall=30;
short Metals[MaxMetall][2]={0};
short MetallObjects=0; // ���-�� ������������� ��������
// ���������� ��������� �����
short findGoalCount=0;

// ������� ��������� ������ ���������� ������������� ���������� � ������ ����������� 
// cX cY direction
short cX=0;
short cY=0;
// ������ ����� ��� �������� - � ����������� �� ��������
enum direction {UP=1,RUP=2,RIGHT=3,RDOWN=4,DOWN=5, LDOWN=6,LEFT=7,LUP=8};
enum direction cdirection=1;


short cxx,cyy; // ���� ����� ������������ �������� � ������� �����������

//------------------------------------------------------------------------------
//---------------��������� �������----------------------------------------------

 void SRotare(enum direction d,enum direction nd); // �������
 short isMetall();               // ���������� 1 ���� ������� �������������
 short comp(short d1,short d2); // ��������� ���� �����
 short SMove(short nx,short ny); // �����������
 int Cost();              // ����������� ���������
 void A_search();         // �������� ������ A*
 void Brain();             // ���������

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
short comp(short d1,short d2)
{
        if(d1==d2) return 0; // �������� �����
        if(d1>d2) return 1; // ������ ������ �������
        else return -1; // ������ ������ �������
}
// ����������� ���� ������� ����������� � ����� ����������
// ����������� - ���������� ����������
short SMove(short nx,short ny)
{
        enum direction nd; // ����� �����������
        short ax;
        short ry;
        short i,d;
        ax=comp(cX,nx);  // ���������� ������� ���������� � ���������

        ry==comp(cY,ny);
        if(ax==-1)      // � ����������� �� ����������� - ���������� ������ �����������
                nd=3+ry;
        if(ax==0)
                switch(ry)
                {
                        case -1:
                                nd=1;
                        break;
                        case 0:
                        nd=cdirection;
                        // �� ��� ��������� � ������ �����������
                        break;
                        case 1:
                                nd=5;
                        break;

                }
        if(ax==1)
                nd=7-ry;
        SRotare(cdirection,nd); // ��������������
        // �������� - �������� �������� �������� ������� SForward � ���, ��� ���� ��������� ����� � �����.
        // ����������� ������
        if(isSafe()==100) // ��������� ������� ����������
        {
         Motor_Init();  // ����������� ������
         Change_Duty(SPEED); // ������ ��������
         Motor_A_FWD(); // ��������� ������
         Motor_B_FWD();
         if(cdirection%2==0)
         delay_ms(DELAY_TIME_20*1414/1000); // ���� ���� �������
         else
         delay_ms(DELAY_TIME_20); // ���� ���� �������
         findGoalCount++;
         return 1;      // �������� ���������.
         }
         else              // ���������� � �����������
         {
         d=isSafe();
              Motor_Init();  // ����������� ������
              Change_Duty(SPEED); // ������ ��������
              Motor_A_FWD(); // ��������� ������
              Motor_B_FWD();
              for(i=0;i<d-DISTANCE_METALL;i++)
                  delay_ms(DELAY_TIME_1sm); // ���� ���� �������
              Motor_Stop();
         H[cX+cxx][cY+cyy]++;   // ��������� ���������, ��� ��� ���-�� ����, ���� ����� �� ����
         findGoalCount++;
         if(isMetall()) // ��������� ������ �� ���
         {
         Metals[MetallObjects][0]=cX+cxx; // ���������� ����������
         Metals[MetallObjects][1]=cY+cyy;
         MetallObjects++;
         }
         // ���� �������
         Motor_Init();
         Change_Duty(SPEED);
         Motor_A_BWD();
         Motor_B_BWD();
         for(i=0;i<d-DISTANCE_METALL;i++)
              delay_ms(DELAY_TIME_1sm); // ���� ���� �������
         
         return 0;    // �������� �� ����
         }
}

// ��������, ���������� ������� ����������� � �����
// ��������� �������� ��������

void SRotare(enum direction d,enum direction nd)
{
        short r;
        r=(d-nd);
        if(r>4) r=8-r; // ���� ���� �������� ������ 180 - ����� �������������� � ������ �������
        if(r>=0)
                S_Right(r*45); // �������������� �� ����������� ����
        else
                S_Left(-r*45);
}


// ��������������� ��� �����
void A_search()
{
        int i,j;
        int min,temp;
        if(findGoalCount==NumberOfGoals) return;// ��������� ��� ��������� - �������� ���� - ��������� ������.
        if(H[cX][cY]==0)     // ���� ��� ����� ���������
        {                    // ���� ��� ���������, � �������� ��� ���������
        H[cX][cY]+=1;
        }
        // ��������� �
        min=H[cX][cY+1]+h_evr[cX][cY+1];
        for(i=-1;i<=1;i++) // � ��� � ����� ��������� 8 ��������� ��������
           for(j=-1;j<=1;j++)
              { // ����������� ��� ��������� ��������� � ������� ���������
                  if(i==0 && j==0) continue;
                  temp=H[cX+i][cY+j]+h_evr[cX+i][cY+j];
                  if(temp<min) // ������� ����������� ���������
                  {            // � ������ ��������� � ����
                     min=temp;
                     cxx=i;
                     cyy=j;
                  }
              }
        if(SMove(cX+cxx,cY+cyy)) // ������������ � ��������� ���������
        {
        cX+=cxx; // ���������� ������� ���������
        cY+=cyy;
        } // ���� ����������� �� ���������, �� ����� ���� �� ������� ��� �� ����
        // ��� ��� ��� ��������� ������ �����������

}

// ������� ������ ������ �� �����
 short mod(short x)
 {
 if(x>=0) return x;
 else return -x;
 }
// ������� ���������� ������������� ������ h
void Brain()
{
        short x,y,j,k;
        short r;
        // �� ������ ������ ������� ���� ������ ���� ����������
        for(x=0;x<WorldSize;x++)
        {
        for(y=0;y<WorldSize;y++)
        {
        if(H[x][y]!=0) continue; // ���� �������� �� �������- ������ �� ��� ���� � �� �����.
        for(j=0;j<WorldSize;j++) // x
         for(k=0;k<WorldSize;k++) // y
             {
             r=mod(x-j)+mod(y-k);  // ������������ ����������
             if(r<h_evr[j][k]) h_evr[j][k]=r; // ���� ���� ���� ����� - ������� ���������� �� ��
             }
        }
        }
}