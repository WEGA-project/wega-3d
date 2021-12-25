$fn = 250;
//Динамики
$l = 7;// Расстояние между краями динамиков
$dd = 8;// Диаметр динамика
//Крышка
$D = 60 - 4;// диаметр посадочного отверстия
$hk = 3;// Толщина крышки
$hu = 10;// Высота упора
$vk = 4;//Выступ крышки

module korpus(){

  module iz1(){

    module probka(){

      difference(){
        translate([0, 0, 0])cylinder($hk, $D / 2 + $vk, $D / 2 + $vk);// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка// Крышка
        translate([(-($l / 2) - $dd), 0, -10]){ cylinder(20, $dd, $dd); }// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик// левый динамик
        translate([(($l / 2) + $dd), 0, -10]){ cylinder(20, $dd, $dd); }// правый динамик
        //translate([28,13,-1]) linear_extrude(2)    mirror(0,0,0) text("WEGABOX",8);
      }

    }
    module usch(){
      translate([($D / 2 + 3), -10, -10]){ cube(20); }
      translate([(-$D / 2 - 23), -10, -10]){ cube(20); }
      difference(){
        translate([0, 0, 2])cylinder($hu + 10, ($D / 2 + 25) / 1.1, ($D / 2 + 25) / 1.1);
        translate([0, 0, 2])cylinder($hu + 10, ($D / 2 + 4) / 1.1, ($D / 2) / 1.1);
      }
    }

    difference(){

      cylinder(d = 64, h = 20);

      translate([0, 0, -2])cylinder(d = 60, h = 35);

    }
    probka();

    difference(){
      translate([0, 0, 10])cylinder(d = 70, h = 3);
      translate([0, 0, -2])cylinder(d = 60, h = 35);

    }

  }// iz1

  module trubka(){
    difference(){
      translate([0, -10, -4])rotate([70, 0, 0])cylinder(d = 12, h = 27);
      translate([0, -10, -4])rotate([70, 0, 0])cylinder(d = 9, h = 35);
    }
  }
  difference(){
    iz1();
    translate([0, -10, -3])rotate([70, 0, 0])cylinder(d = 10, h = 25);
    trubka();
  }

  module otse(){
    difference(){
      translate([0, 0, 11])cylinder(d = 90, h = 20);
      translate([0, 0, 10])cylinder(d = 64, h = 60);
    }
  }

  difference(){
    trubka();
    translate([0, 0, -30])cylinder(d = 70, h = 30);
    translate([0, 0, -21])otse();

  }
}

module krishka(){
  $fn = 250;

  difference(){
    translate([0, 0, -3])cylinder(d = 70, h = 20);
    cylinder(d = 64, h = 60);
    translate([-30, 0, 16])mirror([1, 0, 1])cylinder(d = 10, h = 40);
    translate([-30, 0, 16])mirror([1, 0, 1])cylinder(d = 7, h = 50);

    //difference(){

    //}

  }
  difference(){
    translate([-30, 0, 16])mirror([1, 0, 1])cylinder(d = 10, h = 10);
    translate([-29, 0, 16])mirror([1, 0, 1])cylinder(d = 7, h = 20);
    translate([0, 0, 17])cylinder(d = 120, h = 30);
    cylinder(d = 64, h = 60);
  }

}

korpus();
translate([0, 0, -60])rotate([0, 0, 90])krishka();