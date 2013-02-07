#ifndef SAFEDRIVING_H_
#define SAFEDRIVING_H_
#include "adc.h"

const unsigned char channelY=2;
const unsigned char channelX=3;



int isSafeY();
int isSafeX();


int isSafeY()   // ������� ���������� ���������� �� ������� � ����������� �� ��� Y.
{
 int Distance=100; // � ��� ���������� ����� ���������
 int GP2=0;
 GP2=Adc_Rd(channelY);          // �������� ������ �� ��� �� ������� ������
 if (GP2>90)             // ��������� ���������� �� �������� �������� � gp2
 {
  Distance=(2914.0/(GP2+5))-1;  // ��������� � ����������
 }
 return Distance;

}

int isSafeX()   // ������� ���������� ���������� �� ������� � ����������� �� ��� Y.
{
 int Distance=100; // � ��� ���������� ����� ���������
 int GP2=0;
 GP2=Adc_Rd(channelX);          // �������� ������ �� ��� �� ������� ������
 if (GP2>90)             // ��������� ���������� �� �������� �������� � gp2
 {
  Distance=(2914.0/(GP2+5))-1;  // ��������� � ����������
 }
 return Distance;

}

#endif