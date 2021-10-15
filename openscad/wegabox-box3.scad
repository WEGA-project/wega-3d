 $fn=90;
// Плата контроллера

xp=70; // Длинна платы
yp=50; // Ширина платы
zp=2; // Толщина платы
Zr=15;  // Высота от дна корпуса
// Посадочные отверстия в плате
do=2.032; // Диаметр отверстий
sx=1.651; // Отступ от края x
sy=1.651; // Отступ от края y
dx=66.675; // Расстояние между центрами отверстий по x
dy=46.609; // Расстояние между центрами отверстий по y


// Корпус
// коробка
Xk=85; // Длинна
Yk=65; // Ширина
Zk=40; // Высота
Bk=2.4; // Толщина стенки

Rmink=10; // Радиус скругления корпуса
Hbr=5; // Высота бороздки для крышки

Bkk=Bk/2; //Толщина стенки крышки
Zkr=10; // Высота крышки

// Зажимы и крепления платы
// Положение креплений платы
Xr=5;  // по длинне
Yr=5;  // по ширине
Dr=4;    // Диаметр крепления под болт
Drr=1.5;    // Диаметр отверстия для болта
Hv=4.5; // Выступ зажима платы
Vzh=0.3; // Выступ захвата

j35d=8.5; // Диаметр для посадки джеков 3.5
j35s=14; // Расстояние между джеками 3.5
j35h=10; // Высота подъема отверстий 3.5 от средней линии корпуса
j35f=4; // Размер шрифта подписей
j35font="Liberation Arial:style=Bold"; // Шрифт надписей
Fg=0.8;// Глубина выдавливания

// Высота остальных отверстий 
Hph=14-3;// pH
Honf=12-3; // 12V
H12v=15-3;//On/Off

module board(){
 difference() {
cube ([xp,yp,zp]);
translate([sx,sy,-1]) cylinder(h=zp+2,d=do);
translate([sx+dx,sy,-1]) cylinder(h=zp+2,d=do);
translate([sx+dx,sy+dy,-1]) cylinder(h=zp+2,d=do);
translate([sx,sy+dy,-1]) cylinder(h=zp+2,d=do);
    }
 }



// Содаю болванку закругленной нижней части корпуса
module case1(Xk,Yk,Zk,Rmink){
// Сперва плоские стенки со скруглением углов
hull() {
    
     translate([0,0,0])    cylinder(r=Rmink, h=Zk, center=true); 
     translate([Xk,0,0])  cylinder(r=Rmink, h=Zk, center=true);
     translate([0,Yk,0])  cylinder(r=Rmink, h=Zk, center=true);
     translate([Xk,Yk,0])cylinder(r=Rmink, h=Zk, center=true);
}

// Сдвигаю вниз корпуса
translate([0, 0, Zk/2]) {
    
// Нижняя часть корпуса рисую шариками
hull() {
    
     translate([0,0,0])sphere(r=Rmink);
     translate([Xk,0,0]) sphere(r=Rmink);
     translate([0,Yk,0]) sphere(r=Rmink);
     translate([Xk,Yk,0]) sphere(r=Rmink);
}


}
}



module korpus(){
// Вырезаю из болванки корпуса отверстие получая коробочку с закругленным дном
difference(){
    // Соеднияю нижнюю часть корпуса с соединительной часть для крышки
    union(){
case1(Xk,Yk,Zk,Rmink);
translate([0,0,-Zk/2-1])

// Рисую соединительную кромку для крышки
hull() {
   
     translate([0,0,0])    cylinder(r=Rmink-Bkk, h=Hbr, center=true); 
     translate([Xk,0,0])  cylinder(r=Rmink-Bkk, h=Hbr, center=true);
     translate([0,Yk,0])  cylinder(r=Rmink-Bkk, h=Hbr, center=true);
     translate([Xk,Yk,0])cylinder(r=Rmink-Bkk, h=Hbr, center=true);
}
// Добавляю ушки для крепления к стене
krepezh();
translate([Xk,0,0]) krepezh();
    }

// Нижняя часть корпуса сдвинутая вверх и уменьшеная на толщину стенки для выреза
translate([Bk/4,Bk/4,-Bk]) case1(Xk-Bk/4,Yk-Bk/4,Zk+Hbr+1,Rmink-Bk);

// Вырезаю отверстия для гнезд и разъемов

// Гнезда для Jack 3.5
translate ([j35s*1,-Rmink+Bk+1,-j35h]) rotate([90,0,0]) cylinder(d=j35d,h=Rmink);
translate ([j35s*2,-Rmink+Bk+1,-j35h]) rotate([90,0,0]) cylinder(d=j35d,h=Rmink);
translate ([j35s*3,-Rmink+Bk+1,-j35h]) rotate([90,0,0]) cylinder(d=j35d,h=Rmink); 
translate ([j35s*4,-Rmink+Bk+1,-j35h]) rotate([90,0,0]) cylinder(d=j35d,h=Rmink); 
translate ([j35s*5,-Rmink+Bk+1,-j35h]) rotate([90,0,0]) cylinder(d=j35d,h=Rmink);         


// Подписи для jack 3.5 гнезд
translate ([1*j35s+j35d/2,-Rmink+Fg,-j35h+j35d+3])rotate([270,0,180])linear_extrude(Fg+1)text("I2C", font=j35font, size = j35f);
translate ([2*j35s+j35d/2,-Rmink+Fg,-j35h+j35d+3])rotate([270,0,180])linear_extrude(Fg+1)text("1w", font=j35font,size = j35f);
translate ([3*j35s+j35d/2,-Rmink+Fg,-j35h+j35d+3])rotate([270,0,180])linear_extrude(Fg+1)text("PR", font=j35font,size = j35f);
translate ([4*j35s+j35d/2,-Rmink+Fg,-j35h+j35d+3])rotate([270,0,180])linear_extrude(Fg+1)text("US", font=j35font,size = j35f);
translate ([5*j35s+j35d/2,-Rmink+Fg,-j35h+j35d+3])rotate([270,0,180])linear_extrude(Fg+1)text("EC", font=j35font,size = j35f);


// Остальные отверстия с подписями
translate ([Rmink,Yk+Rmink+Bk+1,-Hph]) rotate([90,0,0]) cylinder(d=11,h=Rmink);
     translate ([Rmink-11/2,Yk+Rmink-Fg,0+11+3-Hph])rotate([90,180,180])linear_extrude(Fg+1)text("pH", font=j35font, size = j35f);
translate ([35+Rmink,Yk+Rmink+Bk+1,-Honf]) rotate([90,0,0]) cylinder(d=15.8,h=Rmink);
     translate ([35+Rmink-11,Yk+Rmink-Fg,0+11+3-Honf])rotate([90,180,180])linear_extrude(Fg+1)text("ON/OFF", font=j35font, size = j35f);
translate ([60+Rmink,Yk+Rmink+Bk+1,-H12v]) rotate([90,0,0]) cylinder(d=8.5,h=Rmink);
     translate ([60+Rmink-8.5/2,Yk+Rmink-Fg,0+8.5+3-H12v])rotate([90,180,180])linear_extrude(Fg+1)text("12V", font=j35font, size = j35f);
}




difference(){
translate([sx+Xr,sy+Yr,-(Zr-Zk)-Zk/2+Rmink]) cylinder(h=Zr,r=Dr); 
// Отверстие 1 для крепления платы  
     translate([sx+Xr,sy+Yr,-(Zr-Zk)-Zk/2+Rmink-1])cylinder(Zr,r=Drr,$fn=3); 
}

difference(){
translate([sx+dx+Xr,sy+Yr,-(Zr-Zk)-Zk/2+Rmink]) cylinder(h=Zr,r=Dr);
// Отверстие 2 для крепления платы  
     translate([sx+dx+Xr,sy+Yr,-(Zr-Zk)-Zk/2+Rmink-1])cylinder(Zr,r=Drr,$fn=3);
}
difference(){
translate([sx+dx+Xr,sy+dy+Yr,-(Zr-Zk)-Zk/2+Rmink]) cylinder(h=Zr,r=Dr);
// Отверстие 3 для крепления платы  
     translate([sx+dx+Xr,sy+dy+Yr,-(Zr-Zk)-Zk/2+Rmink-1])cylinder(Zr,r=Drr,$fn=3);
}

difference(){
translate([sx+Xr,sy+dy+Yr,-(Zr-Zk)-Zk/2+Rmink]) cylinder(h=Zr,r=Dr);
// Отверстие 4 для крепления платы  
     translate([sx+Xr,sy+dy+Yr,-(Zr-Zk)-Zk/2+Rmink-1])cylinder(Zr,r=Drr,$fn=3);
}

translate([sx+Xr+15,sy+dy+Yr+2,-(Zr-Zk)-Hv-Zk/2+Rmink]) cube([30,2,Zr+Hv]);
    translate([sx+Xr+15,sy+dy+Yr+(2-Vzh),-(Zr-Zk)-Hv-Zk/2+Rmink]) cube([30,2,2]);

translate([sx+Xr+15,sy+dy+Yr-50,-(Zr-Zk)-Hv-Zk/2+Rmink]) cube([30,2,Zr+Hv]);
translate([sx+Xr+15,sy+dy+Yr-50+Vzh,-(Zr-Zk)-Hv-Zk/2+Rmink]) cube([30,2,2]);


translate([sx+dx+Xr+2,sy+Yr-2,-(Zr-Zk)-Hv-Zk/2+Rmink]) cube([2,50,Zr+Hv]);
translate([sx+dx+Xr-70,sy+Yr-2,-(Zr-Zk)-Hv-Zk/2+Rmink]) cube([2,50,Zr+Hv]);
}



module krishka(){
mirror([0, 0, 1]) {
 translate([0,0,100]) {
        
     // Вырезаю из болванки корпуса отверстие получая коробочку с закругленным дном
difference(){
    // Соеднияю нижнюю часть корпуса с соединительной часть для крышки

case1(Xk,Yk,Zkr+5,Rmink);
translate([0,0,-Zkr/2-1])

// Рисую соединительную кромку для корпуса
hull() {
   
     translate([0,0,0])    cylinder(r=Rmink-Bkk, h=Hbr, center=true); 
     translate([Xk,0,0])  cylinder(r=Rmink-Bkk, h=Hbr, center=true);
     translate([0,Yk,0])  cylinder(r=Rmink-Bkk, h=Hbr, center=true);
     translate([Xk,Yk,0])cylinder(r=Rmink-Bkk, h=Hbr, center=true);
}
  

// Нижняя часть корпуса сдвинутая вверх и уменьшеная на толщину стенки для выреза
translate([Bk/4,Bk/4,-Bk]) case1(Xk-Bk/4,Yk-Bk/4,Zkr+Hbr+1,Rmink-Bk);
      
}
  translate([Xk-5,Yk/2-4,Rmink+Zkr-Bk+Fg])rotate([0,180,0])linear_extrude(Fg+2)text("WEGABOX", font=j35font, size = 10);   
     }  
}

}

// Ушки для крепления к стене
Hu=5;// Толщина ушек
// Выступ ушек за корпус
Zu=Zk/2+Rmink-Hu; // Положение ушек вверх/вниз

module krepezh(){
difference () {
hull() {
translate([0,0-20,Zk/2+Rmink-Hu]) cylinder(h=Hu,d=20);
translate([0,Yk+20,Zk/2+Rmink-Hu]) cylinder(h=Hu,d=20);
}
translate([0,0-20,-1+Zk/2+Rmink-Hu]) cylinder(h=Hu+2,d=7);
translate([0,Yk+20,-1+Zk/2+Rmink-Hu]) cylinder(h=Hu+2,d=7);
}
}



korpus();


translate([0,0,73])krishka();
//translate([Xr,Yr,Zk/2+Rmink-zp-Zr])board();