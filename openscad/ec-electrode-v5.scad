// Комбинированный электрод ЕС состоит из игл от шприца
// из нержавеющей стали и термистора для измерения температуры
// Иглы вставлены в корпус и припаяны с помощью ортофосфорной кислоты.
// Иглы выдвигаюся за пределы корпуса. Расстояние между иглами,
// их диаметр и длинна влияют на кондуктометрическую постоянную.
// Иглы погружаются в раствор полностью. Не должно оставаться пузырей
// воздуха и между иглами не должно быть мусора. При этом поток
// раствора должен свободно циркулировать между ними для актуальности измерений.
// Внутри должен нахдится термистор который компенсирует температурные сдвиги ЕС.
// Все эти элементы вставляются в корпус и заливаются герметичным составом.
// Подвод провода закрывается чехлом, а электроды съемной защитой.

Dk = 15;//Внешний диаметр корпуса
Lk = 30;// Длинна корпуса
tk = 2.4;// Толщина стенок корпуса.
Li = 10;// Расстояние между иглами
Dzi = 0.8 * 6;// Диаметр внутренней направляющей иглы
Hzi = 15;// Высота внутренней защиты игл
Di = 0.8;// Диаметр игл
hi = 40;//Длинна игл
zi = 7;// Длинна площадки для пайки игл
Lz = 30;// Длинна защиты электродов
Do = 13;// Диаметр пропускного отверстия в защите электродов

$fn = 190;

// Корпус
module korpus(){
  difference(){
    union(){
      difference(){
        union(){
          translate([0, 0, Lk / 3])cylinder(d1 = Dk + 3, d2 = Dk + 2, h = Lk - Lk / 3);
          cylinder(d1 = Dk, d2 = Dk + 2, h = Lk);
        }
        translate([0, 0, tk])cylinder(d = Dk - tk, h = Lk);
      }

      translate([Li / 2, 0, 0])cylinder(d = Dzi, h = Hzi);
      translate([-Li / 2, 0, 0])cylinder(d = Dzi, h = Hzi);
    }
    igly();// Дырки для игл
  }
  //igly();// Сами иглы
}

module igly(){
  translate([Li / 2, 0, -hi + Hzi + zi])cylinder(d = Di, h = hi);
  translate([-Li / 2, 0, -hi + Hzi + zi])cylinder(d = Di, h = hi);
}

// Защита
module zachita(){
  difference(){
    difference(){
      difference(){
        cylinder(d1 = Dk + 3, d2 = Dk + 4, Lz);
        translate([0, 0, -1])cylinder(d = Dk, h = Lz + 2);
      }
      translate([0, 0, 19])korpus();
    }
    translate([0, Dk, 14])rotate([90, 0, 0])cylinder(d = Do, h = Dk * 2);
  }

}

//translate([0,0,-20])korpus();
//translate([0,0,-40])zachita();

// Чехол для проводов
module chechol(){
  difference(){
    union(){
      translate([0, 0, -10])cylinder(d1 = Dk + 5, d2 = Dk + 4, 22);
      translate([0, 0, 12])sphere(d = Dk + 4);
      translate([0, 0, 17])cylinder(d1 = 16,d2 = 7, h = 7);
      
    }
    translate([0, 0, -12])cylinder(d1 = Dk + 4, d2 = Dk + 2, 20);
    translate([0, 0, 10])sphere(d = Dk + 3);
    translate([0, 0, 1])cylinder(d = 5, h = 25);
    translate([0, 0, -19])korpus();
  }
  
}
chechol();
//translate([0, 0, -60])korpus();
//translate([0, 0, -120])zachita();