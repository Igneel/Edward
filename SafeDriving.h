#ifndef SAFEDRIVING_H_
#define SAFEDRIVING_H_
#include "adc.h"
//#include "motor.h"

short isSafe() ;


short isSafe()   // ������� ���������� 1 ���� ����������� ���.
{
 float Distance=100; // � ��� ���������� ����� ���������
 int GP2=0;
 GP2=Adc_Rd(2);          // �������� ������ �� ��� �� ������� ������
 if (GP2>90)             // ��������� ���������� �� �������� �������� � gp2
 {
  Distance=(2914.0/(GP2+5))-1;  // ��������� � ����������
 }
 if(fabs(Distance-100)<1)
 return 1;
 else
 return 0;

}

#endif