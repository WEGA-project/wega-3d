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

Dk = 14;//Внешний диаметр корпуса
Lk = 20;// Длинна корпуса
tk = 1.5;// Толщина стенок корпуса.
Li = 8;// Расстояние между иглами
Dzi = 0.8 * 7;// Диаметр внутренней направляющей иглы
Hzi = 8;// Высота внутренней защиты игл
Di = 0.8;// Диаметр игл
hi = 40;//Длинна игл
zi = 7;// Длинна площадки для пайки игл
Lz = 30;// Длинна защиты электродов
Do = 8;// Диаметр пропускного отверстия в защите электродов
hche=10; // Длинна чехла
nche=9; // Носик чехла
dpr=5; // Диаметр провода

$fn = 190; // Качество поверхностей

// Корпус
module korpus(){
  difference(){
    union(){
         
      difference(){
        union(){
          translate([0, 0, 5])cylinder(d1 = Dk, d2 = Dk + 3, h = 2);
          translate([0, 0, Lk / 3])cylinder(d1 = Dk + 3, d2 = Dk + 2, h = Lk - Lk / 3);
            
          cylinder(d1 = Dk, d2 = Dk + 2, h = Lk);
        }
        union(){
        translate([0, 0, tk])cylinder(d = Dk - tk-1, h = Lk);
        translate([0, 0, tk])cylinder(d = Dk - tk+1, h = Lk);
        }
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
        cylinder(d1 = Dk+2, d2 = Dk + 5, Lz);
          
        translate([0, 0, -1])cylinder(d = Dk, h = Lz + 2);
      }
      translate([0, 0, Lk+2])korpus();;
    }
    
    hull(){
    translate([0, Dk, 14])rotate([90, 0, 0])cylinder(d = Do, h = Dk * 2);
    translate([0, Dk, 20])rotate([90, 0, 0])cylinder(d = Do, h = Dk * 2);
    }
    
    hull(){
    translate([-Dk, 0, 14])rotate([90, 0, 90])cylinder(d = Do, h = Dk * 2);
    translate([-Dk, 0, 20])rotate([90, 0, 90])cylinder(d = Do, h = Dk * 2);    
    }
  }
    
}

//translate([0,0,-20])korpus();
//translate([0,0,-40])zachita();

// Чехол для проводов

module chechol(){
  difference(){
    union(){
      translate([0, 0, -10])cylinder(d = Dk+5, hche+2);
      translate([0, 0, hche-8])sphere(d = Dk + 5);
      //translate([0, 0, hche-6])cylinder(d1 = Dk+0,d2 = 7, h = nche);
      
    }
    translate([0, 0, -10-2])cylinder(d = Dk+5-2, hche+2);
    translate([0, 0, hche-8-2])sphere(d = Dk + 5-2);
    //translate([0, 0, 10])sphere(d = Dk + 3);
    translate([0, 0, 1])cylinder(d = dpr, h = hche+nche);
    translate([0, 0, -16.7])korpus();
  }
  
}
color(alpha=0.7)translate([0, 0, -2])chechol();
translate([0, 0, -19]) korpus();
color(alpha=0.5) translate([0, 0, -42])zachita();