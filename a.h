// поиск А* в реальном времени с обучением
// Н - текущая наилучшая оценка стоимости достижения цели
// из каждого состояния, которое уже было посещено 
// WorldSize - размер мира, константа.

#include "motor.h"
#include "SafeDriving.h"


// константы задержки, при перемещении между состояниями и при проверке состояния.
const short DELAY_TIME_VR_10=64; // время поворота на 10 градусов
const short DELAY_TIME_1sm=71;  // задержка на 1 см
const short SPEED=255; // скорость
const double Pi=3.14159; // число пи, константа

const short WorldSize=30; // размер мира
int maxX=0; // максимальные размеры мира
int maxY=0; // определяются во время начала работы робота

const int dX=2; // смещение центра вращения робота относительно дальномера
const int dY=4; // единицы измерения - клетки, 1 клетка = 2 см
const double dfi=1.108;//63.48; // угол, между металлоискателем и горизонталью.
const double Radius=4.472; // расстояние от центра поворота, до металлоискателя

// текущее положение робота определяют относительные координаты и вектор направления
// cX cY direction
int cX=0;
int cY=0;
// направления робота.
enum direction {UP=1,RUP=2,RIGHT=3,RDOWN=4,DOWN=5, LDOWN=6,LEFT=7,LUP=8,ZEROD=9};
enum direction cdirection=1;  // начально направление - вверх


short cxx=0,cyy=0; // сюда будет записываться прибавка к текущим координатам
char string[29];
char delimiter[16];

char strint[5]={0};
//------------------------------------------------------------------------------
//---------------Прототипы функций----------------------------------------------

 void SRotare(enum direction d,enum direction nd); // поворот
 short isMetall();               // возвращает 1 если предмет металлический
 short comp(short d1,short d2); // сравнение двух чисел
 short SMove(short nx,short ny); // перемещение
 int Cost();              // определение стоимости
 void A_search();         // алгоритм поиска A*
 void Brain();             // эвристика
 void Correct(void);     // коррекция движения
 
 
 // для работы с блютузом:
 int getParam(const char * p,int x,int y);
 void setParam(const char * p,int x,int y,int value);
 void strConstCpy (const char *source, char *dest);
 void stradd(char *source, char *dest);
//------------------------------------------------------------------------------

// Процедура копирования строки из ROM в RAM
void strConstCpy (const char *source, char *dest) {
 while (*source) *dest++ = *source++;
 *dest = 0;
}

// склеивание строк
void stradd(char *source, char *dest){
while (*dest++);
*dest--;
while (*source) *dest++ = *source++;
 *dest = 0;
}
// "Hint  " Для H и "hevr  " для эвристики
// длина команды - 6 символов
// ежели она короче - добавляются пробелы
int getParam(const char * p,int x,int y)
{
 char temp=0;
 strConstCpy(p,string); // копируем код команды
 IntToStr (x,strint);   
 stradd(" g ",string);  // параметр get
 stradd(strint,string); // добавление первой координаты
 IntToStr (y,strint);
 stradd(strint,string); // копируем вторую координату
 stradd(" ",string);
 stradd("    0 ",string); // добавляем третий фиктивный параметр
 UART1_Write_Text(string);
 while(1) if(UART1_Data_Ready()) // ждем ответ
 {
 temp=UART1_Read();
 return temp;
 }
}
// установка параметра
 void setParam(const char * p,int x,int y,int value)
 {
     char temp=0;
     strConstCpy(p,string); // копируем код команды
     IntToStr (x,strint);
     stradd(" s ",string);
     stradd(strint,string); // копируем первую координату
     IntToStr (y,strint);
     stradd(strint,string); // копируем вторую координату
     IntToStr (value,strint);
     stradd(strint,string);  // копируем значение
     stradd(" ",string);    // дописываем символ пробела в конец строки
     UART1_Write_Text(string); // отправляем данные
     while(1) if(UART1_Data_Ready()) // ждем ответ
     {
         temp=UART1_Read();
         return;
     }
 }

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

// непосредственно сам поиск
void A_search()
{
    int temp=0;
    temp=getParam("Hint  ",cX,cY); // получаем значение стоимости для текущего состояния
    setParam("Hint  ",cX,cY,++temp); // увеличиваем его, т.к. мы уже здесь
    // оцениваем перспективность доступных состояний
    cxx=getParam("Calc  ",cX,cY);
    cyy=getParam("Calc2 ",cX,cY);
    // изменяем смещения согласно текущего направления.
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
    if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
    {
        cX+=cxx; // обновление текущих координат
        cY+=cyy;
    }
    // если перемещения не произошло, то робот вряд ли выберет тот же путь
    // так как его стоимость теперь увеличилась

}

// вращение, использует текущее направление и новое

void SRotare(enum direction d,enum direction nd)
{
/*
Робот вращается вокруг собственного центра, металлоискатель в это время движетися по окружности
с радиусом Radius, координаты металлоискателя изменяются согласно известным тригонометрическим
выражениям.

*/
    int temp=0;
    short r=0;
    r=(d-nd);
    if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
    if(r>=0)
    {        
        S_Right(255); // поворачиваемся по наименьшему пути
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
        S_Left(255);
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

// пока работает весьма криво, если вообще работает)
void Correct(void) // корректирует направление робота
{
short r=0,nr=0;
r=isSafeY();                // проверить расстояние
S_Left(DELAY_TIME_VR_10);  // повернуться
nr=isSafeY();               // проверить расстояние
if(r==nr)                   // сравнить их, если получаем правильное соотношение
S_Right(DELAY_TIME_VR_10);  // то мы находимся в правильном положении
if(r>nr)
return;
if(r<nr)
S_Right(2*DELAY_TIME_VR_10);
Motor_Stop();
}
// перемещение надо указать направление и новые координаты
// направление - глобальная переменная
short SMove(int nx,int ny)
{
    enum direction nd=1; // относительное направление движения
    short ax=0; // сравнение по оси х
    short ry=0; // сравнение по оси у
    int temp=0;
    int temp1=0;
    short isMove=0; // индикатор - было ли движение
    ax=comp(cX,nx);  // сравниваем текущие координаты с заданными
    ry=comp(cY,ny);
    // в зависимости от результатов - определяем нужное направление
    if(ax==-1)  // если нам нужно направо
            nd=RIGHT+ry;
    if(ax==0)    // смещаться по оси х не нужно
            switch(ry)
            {
                case -1: //
                    nd=UP;
                    break;
                case 0:
                    nd=ZEROD;
                    // мы уже находимся в нужном месте
                    break;
                case 1:
                   nd=DOWN;
                    break;

            }
    if(ax==1)   // если нам нужно налево
            nd=LEFT-ry;
    // мы определили новое направление, теперь нужно переместиться.
    temp1=isSafeY();
    temp=isSafeX();
    getParam("isSafe",temp,temp1);
    switch (nd)
    {
    case 1:
    case UP:
        if(isSafeY()>2)
        {
            Motor_Init();  // настраиваем моторы
            Change_Duty(SPEED); // задаем скорость
            Motor_A_FWD(); // запускаем моторы
            Motor_B_FWD();
            delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
            Motor_Init();  // настраиваем моторы
            Change_Duty(SPEED); // задаем скорость
            Motor_A_FWD(); // запускаем моторы
            Motor_B_FWD();
            delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
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
            Motor_Init();  // настраиваем моторы
            Change_Duty(SPEED); // задаем скорость
            Motor_A_BWD(); // запускаем моторы
            Motor_B_BWD();
            delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
            Motor_Stop();
            S_Right(255);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Motor_Init();  // настраиваем моторы
            Change_Duty(SPEED); // задаем скорость
            Motor_A_FWD(); // запускаем моторы
            Motor_B_FWD();
            delay_ms(3*DELAY_TIME_1sm); // ждем пока приедем  -------------------------------------------------------------------------------------------------
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
            Motor_Init();  // настраиваем моторы
            Change_Duty(SPEED); // задаем скорость
            Motor_A_BWD(); // запускаем моторы
            Motor_B_BWD();
            delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
            Motor_Stop();
            S_Right(255);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Correct();
            isMove=1;
        }
        break;
    case 5:
    case DOWN:
        Motor_Init();  // настраиваем моторы
        Change_Duty(SPEED); // задаем скорость
        Motor_A_BWD(); // запускаем моторы
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
        Motor_Stop();
        Motor_Init();
        Correct();
        isMove=1;
        break;
    case 6:
    case LDOWN:
        S_Right(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // настраиваем моторы
        Change_Duty(SPEED); // задаем скорость
        Motor_A_BWD(); // запускаем моторы
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
        Motor_Stop();
        S_Left(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Correct();
        isMove=1;
        break;
    case 7:
    case LEFT:
        Motor_Init();  // настраиваем моторы
        Change_Duty(SPEED); // задаем скорость
        Motor_A_BWD(); // запускаем моторы
        Motor_B_BWD();
        delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
        Motor_Stop();
        S_Left(255);
        delay_ms(DELAY_TIME_VR_10*15/10);
        Motor_Init();  // настраиваем моторы
        Change_Duty(SPEED); // задаем скорость
        Motor_A_FWD(); // запускаем моторы
        Motor_B_FWD();
        delay_ms(3*DELAY_TIME_1sm); // ждем пока приедем ----------------------------------------------------------------------------------------------
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
            Motor_Init();  // настраиваем моторы
            Change_Duty(SPEED); // задаем скорость
            Motor_A_FWD(); // запускаем моторы
            Motor_B_FWD();
            delay_ms(2*DELAY_TIME_1sm); // ждем пока приедем
            Motor_Stop();
            S_Right(255);
            delay_ms(DELAY_TIME_VR_10*15/10);
            Correct();
            isMove=1;
        }
        break;
    case 9:
    case ZEROD:
        getParam("zerod ",1,1);
        break;
    }
    
    
     if(isMetall()) // проверяем есть ли тут монетка
     {
         // передаем сигнал о том что тут монетка
         if(isMove)
            setParam("Metall",nx,ny,1);
     }
     return isMove;    // сообщаем было ли движение

}

short isMetall()
{
    short m;
    m=Adc_Rd(1);
    if(m>0 && m<50)
        return 1;    // если объект металлический возвращаем единицу
    else
        return 0;
}
// функция для сравнения, возвращает три возможных значения +1,0,-1
short comp(int d1,int d2)
{
    if(d1==d2) return 0; // операнды равны
    if(d1>d2) return 1; // первый больше второго
    else return -1; // первый меньше второго
}