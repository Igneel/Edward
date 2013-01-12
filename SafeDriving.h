#ifndef SAFEDRIVING_H_
#define SAFEDRIVING_H_
#include "adc.h"

const unsigned char channelY=2;
const unsigned char channelX=3;



short isSafeY() ;
short isSafeX() ;


short isSafeY()   // функция возвращает расстояние до объекта в сантиметрах по оси Y.
{
 float Distance=100; // в эту переменную будем сохранять
 int GP2=0;
 GP2=Adc_Rd(channelY);          // получаем данные от ацп со второго канала
 if (GP2>90)             // проверяем допустимое ли значение хранится в gp2
 {
  Distance=(2914.0/(GP2+5))-1;  // переводим в сантиметры
 }
 return Distance;

}

short isSafeX()   // функция возвращает расстояние до объекта в сантиметрах по оси Y.
{
 float Distance=100; // в эту переменную будем сохранять
 int GP2=0;
 GP2=Adc_Rd(channelX);          // получаем данные от ацп со второго канала
 if (GP2>90)             // проверяем допустимое ли значение хранится в gp2
 {
  Distance=(2914.0/(GP2+5))-1;  // переводим в сантиметры
 }
 return Distance;

}

#endif