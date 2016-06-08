#ifndef ADC_H_
#define ADC_H_ 

int Adc_Rd(char ch)                // читаются нижние 8 каналов АЦП
{
     int dat=0;                    // сюда будут сохранятся данные
     if ((ch>=0) && (ch<=3))       // CH0-CH3
           TRISA |= (1<<ch);
     else if (ch==4)               // CH4
           TRISA |= 0x20;
     else if ((ch>=5) && (ch<=7))  // CH5-CH7
           TRISE |= (1<<(ch-5));
     ANSEL |=(1<<ch);              // устанавливаем канал на аналоговый ввод
     ADCON0 = (0xC1 + (ch*4));     // выбираем канал АЦП
     Delay_us(10);                 // ожидание устойчивого режима
     ADCON0.GO=1;                  // запуск преобразования
     while(ADCON0.GO);             // преобразование закончено?
     dat = (ADRESH*4)+(ADRESL/64); // суммируются две части слова
     return dat;                   // возврат значения
}

#endif