#ifndef SAFEDRIVING_H_
#define SAFEDRIVING_H_
#include "adc.h"
//#include "motor.h"

short isSafe() ;


short isSafe()   // функция возвращает 1 если препятствий нет.
{
 float Distance=100; // в эту переменную будем сохранять
 int GP2=0;
 GP2=Adc_Rd(2);          // получаем данные от ацп со второго канала
 if (GP2>90)             // проверяем допустимое ли значение хранится в gp2
 {
  Distance=(2914.0/(GP2+5))-1;  // переводим в сантиметры
 }
 if(fabs(Distance-100)<1)
 return 1;
 else
 return 0;

}

#endif