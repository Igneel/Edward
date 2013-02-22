#ifndef ADC_H_
#define ADC_H_ 

int Adc_Rd(char ch)                // �������� ������ 8 ������� ���
{
     int dat=0;                    // ���� ����� ���������� ������
     if ((ch>=0) && (ch<=3))       // CH0-CH3
           TRISA |= (1<<ch);
     else if (ch==4)               // CH4
           TRISA |= 0x20;
     else if ((ch>=5) && (ch<=7))  // CH5-CH7
           TRISE |= (1<<(ch-5));
     ANSEL |=(1<<ch);              // ������������� ����� �� ���������� ����
     ADCON0 = (0xC1 + (ch*4));     // �������� ����� ���
     Delay_us(10);                 // �������� ����������� ������
     ADCON0.GO=1;                  // ������ ��������������
     while(ADCON0.GO);             // �������������� ���������?
     dat = (ADRESH*4)+(ADRESL/64); // ����������� ��� ����� �����
     return dat;                   // ������� ��������
}

#endif