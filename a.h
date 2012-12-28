// поиск А* в реальном времени с обучением
// Н - текущая наилучшая оценка стоимости достижения цели
// из каждого состояния, которое уже было посещено 
// WorldSize - размер мира, константа.

#include "motor.h"
#include "SafeDriving.h"

// константы задержки, при перемещении между состояниями и при проверке состояния.
const short DELAY_TIME_20=1000;
const short DELAY_TIME_1sm=500;
const short DISTANCE_METALL=5; // расстояние в см, при котором мы касаемся объекта креплениями металлодеректора
const short SPEED=255;

const short WorldSize=8;
// клеточки будут размером 20х20 см по длине робота.
short H[WorldSize][WorldSize]={0};
short h_evr[WorldSize][WorldSize]={0};
//short result[WorldSize][WorldSize]={0};

// массив содержащий координаты всех целей
const short NumberOfGoals=WorldSize*WorldSize-1;
const short MaxMetall=30;
short Metals[MaxMetall][2]={0};
short MetallObjects=0; // кол-во металлических объектов
// количество найденных целей
short findGoalCount=0;

// текущее положение робота определяют относительные координаты и вектор направления 
// cX cY direction
short cX=0;
short cY=0;
// насчет энума ещё подумать - в зависимости от датчиков
enum direction {UP=1,RUP=2,RIGHT=3,RDOWN=4,DOWN=5, LDOWN=6,LEFT=7,LUP=8};
enum direction cdirection=1;


short cxx,cyy; // сюда будет записываться прибавка к текущим координатам

//------------------------------------------------------------------------------
//---------------Прототипы функций----------------------------------------------

 void SRotare(enum direction d,enum direction nd); // поворот
 short isMetall();               // возвращает 1 если предмет металлический
 short comp(short d1,short d2); // сравнение двух чисел
 short SMove(short nx,short ny); // перемещение
 int Cost();              // определение стоимости
 void A_search();         // алгоритм поиска A*
 void Brain();             // эвристика

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

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
short comp(short d1,short d2)
{
        if(d1==d2) return 0; // операнды равны
        if(d1>d2) return 1; // первый больше второго
        else return -1; // первый меньше второго
}
// перемещение надо указать направление и новые координаты
// направление - глобальная переменная
short SMove(short nx,short ny)
{
        enum direction nd; // новое направление
        short ax;
        short ry;
        short i,d;
        ax=comp(cX,nx);  // сравниваем текущие координаты с заданными

        ry==comp(cY,ny);
        if(ax==-1)      // в зависимости от результатов - определяем нужное направление
                nd=3+ry;
        if(ax==0)
                switch(ry)
                {
                        case -1:
                                nd=1;
                        break;
                        case 0:
                        nd=cdirection;
                        // мы уже находимся в нужном направлении
                        break;
                        case 1:
                                nd=5;
                        break;

                }
        if(ax==1)
                nd=7-ry;
        SRotare(cdirection,nd); // поворачиваемся
        // внимание - возможно придется встроить функций SForward в эту, ибо надо экономить место в стеке.
        // перемещение вперед
        if(isSafe()==100) // проверяем наличие препятсвий
        {
         Motor_Init();  // настраиваем моторы
         Change_Duty(SPEED); // задаем скорость
         Motor_A_FWD(); // запускаем моторы
         Motor_B_FWD();
         if(cdirection%2==0)
         delay_ms(DELAY_TIME_20*1414/1000); // ждем пока приедем
         else
         delay_ms(DELAY_TIME_20); // ждем пока приедем
         findGoalCount++;
         return 1;      // движение выполнено.
         }
         else              // подъезжаем к препятствию
         {
         d=isSafe();
              Motor_Init();  // настраиваем моторы
              Change_Duty(SPEED); // задаем скорость
              Motor_A_FWD(); // запускаем моторы
              Motor_B_FWD();
              for(i=0;i<d-DISTANCE_METALL;i++)
                  delay_ms(DELAY_TIME_1sm); // ждем пока приедем
              Motor_Stop();
         H[cX+cxx][cY+cyy]++;   // обновляем состояние, раз там что-то есть, туда ехать не надо
         findGoalCount++;
         if(isMetall()) // проверяем металл ли это
         {
         Metals[MetallObjects][0]=cX+cxx; // записываем координаты
         Metals[MetallObjects][1]=cY+cyy;
         MetallObjects++;
         }
         // едем обратно
         Motor_Init();
         Change_Duty(SPEED);
         Motor_A_BWD();
         Motor_B_BWD();
         for(i=0;i<d-DISTANCE_METALL;i++)
              delay_ms(DELAY_TIME_1sm); // ждем пока приедем
         
         return 0;    // движения не было
         }
}

// вращение, использует текущее направление и новое
// обновляет значение текущего

void SRotare(enum direction d,enum direction nd)
{
        short r;
        r=(d-nd);
        if(r>4) r=8-r; // если угол поворота больше 180 - будем поворачитьвася в другую сторону
        if(r>=0)
                S_Right(r*45); // поворачиваемся по наименьшему пути
        else
                S_Left(-r*45);
}


// непосредственно сам поиск
void A_search()
{
        int i,j;
        int min,temp;
        if(findGoalCount==NumberOfGoals) return;// проверили все состояния - достигли цели - закончили работу.
        if(H[cX][cY]==0)     // если это новое состояние
        {                    // надо его запомнить, и записать его стоимость
        H[cX][cY]+=1;
        }
        // обновляем Н
        min=H[cX][cY+1]+h_evr[cX][cY+1];
        for(i=-1;i<=1;i++) // у нас в любом состоянии 8 возможных действий
           for(j=-1;j<=1;j++)
              { // анализируем все возможные состояния и находим состояние
                  if(i==0 && j==0) continue;
                  temp=H[cX+i][cY+j]+h_evr[cX+i][cY+j];
                  if(temp<min) // имеющее минимальную стоимость
                  {            // а значит ближайшее к цели
                     min=temp;
                     cxx=i;
                     cyy=j;
                  }
              }
        if(SMove(cX+cxx,cY+cyy)) // перемещаемся в выбранное состояние
        {
        cX+=cxx; // обновление текущих координат
        cY+=cyy;
        } // если перемещения не произошло, то робот вряд ли выберет тот же путь
        // так как его стоимость теперь увеличилась

}

// функция взятия модуля от числа
 short mod(short x)
 {
 if(x>=0) return x;
 else return -x;
 }
// функция заполнения эвристической оценки h
void Brain()
{
        short x,y,j,k;
        short r;
        // на момент вызова функции цели должны быть определены
        for(x=0;x<WorldSize;x++)
        {
        for(y=0;y<WorldSize;y++)
        {
        if(H[x][y]!=0) continue; // если значение не нулевое- значит мы там были и всё нашли.
        for(j=0;j<WorldSize;j++) // x
         for(k=0;k<WorldSize;k++) // y
             {
             r=mod(x-j)+mod(y-k);  // манхетенское расстояние
             if(r<h_evr[j][k]) h_evr[j][k]=r; // если есть цель ближе - запишем расстояние до неё
             }
        }
        }
}