$fn = 90;

// Плата контроллера

xp = 70;// Длинна платы
yp = 50;// Ширина платы
zp = 2;// Толщина платы
Zr = 12;// Высота от дна корпуса
// Посадочные отверстия в плате
do = 2.032;// Диаметр отверстий
sx = 3;// Отступ от края x
sy = -3;// Отступ от края y
dx = 94.86;// Расстояние между центрами отверстий по x
dy =64.64;// Расстояние между центрами отверстий по y

// Корпус
// коробка
Xk = 105;// Длинна
Yk = 70;// Ширина
Zk = 24;// Высота
Bk = 2.4;// Толщина стенки

Rmink = 4;// Радиус скругления корпуса
Hbr = 5;// Высота бороздки для крышки

Bkk = Bk / 2;//Толщина стенки крышки
Zkr = 10;// Высота крышки


// Зажимы и крепления платы
// Положение креплений платы
Xr = 5;// по длинне
Yr = 5;// по ширине
Dr = 4;// Диаметр крепления под болт
Drr = 1.5;// Диаметр отверстия для болта
Hv = 4.5;// Выступ зажима платы
Vzh = 0.3;// Выступ захвата

j35d = 5;// Диаметр для посадки джеков 3.5
j35s = 14;// Расстояние между джеками 3.5
j35h = 1;// Высота подъема отверстий 3.5 от средней линии корпуса
j35f = 5;// Размер шрифта подписей
j35font = "Liberation Arial:style=Bold";// Шрифт надписей
Fg = 0.8;// Глубина выдавливания на крышке
pvd=0.4; // Выдавливание подписей разъемов

// Высота остальных отверстий
Hph = 14 - 3;// pH
Honf = 12 - 3;// 12V
H12v = 15 - 3;//On/Off





module board(){
color("red")
translate([-755.5+sx, 1097.5+sy,4])
scale(0.2551)
rotate([-180,0,-90])
import("wegabox44.stl");
}

// Содаю болванку закругленной нижней части корпуса
module case1(Xk, Yk, Zk, Rmink){
// Сперва плоские стенки со скруглением углов// Сперва плоские стенки со скруглением углов
  hull(){

    translate([0, 0, 0])cylinder(r = Rmink, h = Zk, center = true);
    translate([Xk, 0, 0])cylinder(r = Rmink, h = Zk, center = true);
    translate([0, Yk, 0])cylinder(r = Rmink, h = Zk, center = true);
    translate([Xk, Yk, 0])cylinder(r = Rmink, h = Zk, center = true);
  }

// Сдвигаю вниз корпуса// Сдвигаю вниз корпуса
  translate([0, 0, Zk / 2]){

// Нижняя часть корпуса рисую шариками// Нижняя часть корпуса рисую шариками
    hull(){

      translate([0, 0, 0])sphere(r = Rmink);
      translate([Xk, 0, 0])sphere(r = Rmink);
      translate([0, Yk, 0])sphere(r = Rmink);
      translate([Xk, Yk, 0])sphere(r = Rmink);
    }

  }
}

module korpus(){
// Вырезаю из болванки корпуса отверстие получая коробочку с закругленным дном// Вырезаю из болванки корпуса отверстие получая коробочку с закругленным дном
  difference(){
// Соеднияю нижнюю часть корпуса с соединительной часть для крышки// Соеднияю нижнюю часть корпуса с соединительной часть для крышки
    union(){
      case1(Xk, Yk, Zk, Rmink);
      translate([0, 0, -Zk / 2 - 1])

// Рисую соединительную кромку для крышки// Рисую соединительную кромку для крышки
        hull(){

          translate([0, 0, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
          translate([Xk, 0, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
          translate([0, Yk, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
          translate([Xk, Yk, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
        }
// Добавляю ушки для крепления к стене// Добавляю ушки для крепления к стене
      krepezh();
      translate([Xk, 0, 0])krepezh();
    }

// Нижняя часть корпуса сдвинутая вверх и уменьшеная на толщину стенки для выреза// Нижняя часть корпуса сдвинутая вверх и уменьшеная на толщину стенки для выреза
    translate([Bk / 4, Bk / 4, -Bk])case1(Xk - Bk / 4, Yk - Bk / 4, Zk + Hbr + 1, Rmink - Bk);

// Вырезаю отверстия для гнезд и разъемов// Вырезаю отверстия для гнезд и разъемов

// Гнезда для Jack 3.5// Гнезда для Jack 3.5
    translate([j35s+83, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);
    translate([j35s+83-16, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);
     translate([j35s+83-16*2, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);
     translate([j35s+83-16*3, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);  
     translate([j35s+83-16*4, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);  
     translate([j35s+83-16*5-5, -Rmink + Bk + 1, -j35h-8])rotate([90, 0, 0])cube([9,11,11]);  
//    translate([j35s * 2, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);
//    translate([j35s * 3, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);
//    translate([j35s * 4, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);
//    translate([j35s * 5, -Rmink + Bk + 1, -j35h])rotate([90, 0, 0])cylinder(d = j35d, h = Rmink);

 translate([106,53.7,-5.2])rotate([90, 0, 90])cylinder(d = 13, h = 10);
  translate([106,9,-8])rotate([90, 0, 90])cube([35,5,13]);   
// Остальные отверстия с подписями// Остальные отверстия с подписями
//    translate([Rmink, Yk + Rmink + Bk + 1, -Hph])rotate([90, 0, 0])cylinder(d = 11, h = Rmink);
//    translate([Rmink - 11 / 2, Yk + Rmink - Fg, 0 + 11 + 3 - Hph])rotate([90, 180, 180])linear_extrude(Fg + 1)text("pH", font = j35font, size = j35f);
//    translate([35 + Rmink, Yk + Rmink + Bk + 1, -Honf])rotate([90, 0, 0])cylinder(d = 15.8, h = Rmink);
//    translate([35 + Rmink - 11, Yk + Rmink - Fg, 0 + 11 + 3 - Honf])rotate([90, 180, 180])linear_extrude(Fg + 1)text("ON/OFF", font = j35font, size = j35f);
//    translate([60 + Rmink, Yk + Rmink + Bk + 1, -H12v])rotate([90, 0, 0])cylinder(d = 8.5, h = Rmink);
//    translate([60 + Rmink - 8.5 / 2, Yk + Rmink - Fg, 0 + 8.5 + 3 - H12v])rotate([90, 180, 180])linear_extrude(Fg + 1)text("12V", font = j35font, size = j35f);
  }

  
 // Подписи для jack 3.5 гнезд// Подписи для jack 3.5 гнезд
//    translate([1 * j35s + j35d / 2, -Rmink + Fg+1-pvd, -j35h + j35d + 3])rotate([270, 0, 180])linear_extrude(Fg + 1)text("I2C", font = j35font, size = j35f);
//    translate([2 * j35s + j35d / 2, -Rmink + Fg+1-pvd, -j35h + j35d + 3])rotate([270, 0, 180])linear_extrude(Fg + 1)text("1w", font = j35font, size = j35f);
//    translate([3 * j35s + j35d / 2, -Rmink + Fg+1-pvd, -j35h + j35d + 3])rotate([270, 0, 180])linear_extrude(Fg + 1)text("PR", font = j35font, size = j35f);
//    translate([4 * j35s + j35d / 2, -Rmink + Fg+1-pvd, -j35h + j35d + 3])rotate([270, 0, 180])linear_extrude(Fg + 1)text("US", font = j35font, size = j35f);
//    translate([5 * j35s + j35d / 2, -Rmink + Fg+1-pvd, -j35h + j35d + 3])rotate([270, 0, 180])linear_extrude(Fg + 1)text("EC", font = j35font, size = j35f);

  difference(){
    translate([sx + Xr, sy + Yr, -(Zr - Zk) - Zk / 2 + Rmink])cylinder(h = Zr, r = Dr);
// Отверстие 1 для крепления платы  // Отверстие 1 для крепления платы
    translate([sx + Xr, sy + Yr, -(Zr - Zk) - Zk / 2 + Rmink - 1])cylinder(Zr, r = Drr, $fn = 5);
  }

  difference(){
    translate([sx + dx + Xr, sy + Yr, -(Zr - Zk) - Zk / 2 + Rmink])cylinder(h = Zr, r = Dr);
// Отверстие 2 для крепления платы  // Отверстие 2 для крепления платы
    translate([sx + dx + Xr, sy + Yr, -(Zr - Zk) - Zk / 2 + Rmink - 1])cylinder(Zr, r = Drr, $fn = 5);
  }
  difference(){
    translate([sx + dx + Xr, sy + dy + Yr, -(Zr - Zk) - Zk / 2 + Rmink])cylinder(h = Zr, r = Dr);
// Отверстие 3 для крепления платы  // Отверстие 3 для крепления платы
    translate([sx + dx + Xr, sy + dy + Yr, -(Zr - Zk) - Zk / 2 + Rmink - 1])cylinder(Zr, r = Drr, $fn = 5);
  }

  difference(){
    translate([sx + Xr, sy + dy + Yr, -(Zr - Zk) - Zk / 2 + Rmink])cylinder(h = Zr, r = Dr);
// Отверстие 4 для крепления платы  // Отверстие 4 для крепления платы
    translate([sx + Xr, sy + dy + Yr, -(Zr - Zk) - Zk / 2 + Rmink - 1])cylinder(Zr, r = Drr, $fn = 5);
  }


}

module krishka(){
  mirror([0, 0, 1]){
    translate([0, 0, 100]){

// Вырезаю из болванки корпуса отверстие получая коробочку с закругленным дном// Вырезаю из болванки корпуса отверстие получая коробочку с закругленным дном
      difference(){
// Соеднияю нижнюю часть корпуса с соединительной часть для крышки// Соеднияю нижнюю часть корпуса с соединительной часть для крышки

        case1(Xk, Yk, Zkr + 5, Rmink);
        translate([0, 0, -Zkr / 2 - 1])

// Рисую соединительную кромку для корпуса// Рисую соединительную кромку для корпуса
          hull(){

            translate([0, 0, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
            translate([Xk, 0, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
            translate([0, Yk, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
            translate([Xk, Yk, 0])cylinder(r = Rmink - Bkk, h = Hbr, center = true);
          }

// Нижняя часть корпуса сдвинутая вверх и уменьшеная на толщину стенки для выреза// Нижняя часть корпуса сдвинутая вверх и уменьшеная на толщину стенки для выреза
        translate([Bk / 4, Bk / 4, -Bk])case1(Xk - Bk / 4, Yk - Bk / 4, Zkr + Hbr + 1, Rmink - Bk);
translate([Xk - 5, Yk / 2 - 4, Rmink + Zkr - Bk + Fg])rotate([0, 180, 0])linear_extrude(Fg + 2)text("WEGABOX 4.4", font = j35font, size = 10);
      }
      
    }
  }

}

// Ушки для крепления к стене
Hu = 5;// Толщина ушек
// Выступ ушек за корпус
Zu = Zk / 2 + Rmink - Hu;// Положение ушек вверх/вниз

module krepezh(){
  difference(){
    hull(){
      translate([0, 0 - 20, Zk / 2 + Rmink - Hu])cylinder(h = Hu, d = 20);
      translate([0, Yk + 20, Zk / 2 + Rmink - Hu])cylinder(h = Hu, d = 20);
    }
    translate([0, 0 - 20, -1 + Zk / 2 + Rmink - Hu])cylinder(h = Hu + 2, d = 7);
    translate([0, Yk + 20, -1 + Zk / 2 + Rmink - Hu])cylinder(h = Hu + 2, d = 7);
  }
}

korpus();

translate([0, 0, 33])krishka();
board();