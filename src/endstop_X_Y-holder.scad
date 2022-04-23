//-----------------------------------------------------------------
//-  Endstop clamp, derived from the Prusa decorator clamps
//--  (c) Juan Gonzalez Gomez (Obijuan) juan@iearobotics.com, 
//--  April 2013
//-----------------------------------------------------------------

X = 0;
Y = 1;
Z = 2;

//-- Clamp parameters
rod_diam = 8;
clamp_diam = rod_diam + 5;
open_angle = 80;
width = 20;
base_lx = 20;
base_ly = 5;
base_lz = 12;

zip_tie_holes = [clamp_diam, 1.5, 3];

//-- Internal parameters
open_x = 2*(rod_diam/2)*sin(open_angle/2);

module Prusa_clamp() 
{
  union() {

    //-- Clamp
    difference() {
      union(){
        //-- outer cylinder
      cylinder(r=clamp_diam/2, h=width);

        //-- clamp Base
    translate([0,-clamp_diam/2+2,base_lz/2])
    cube([base_lx, base_ly, base_lz], center=true);
      }
      //-- Inner cylinder
      cylinder(r=rod_diam/2, h=width*3,center=true);

      //-- Break the ring substracting a cube
      translate([-open_x/2,0,-1])
      cube([open_x, clamp_diam+10, width+2]);
    }
  }
}

module endstop() {
    endstop_width = 6.5;
  difference(){
    union(){
      // Telo endstopu
      translate([0,0,0]) color("blue") cube([10,20,endstop_width], center=true);
      // Vyvody
	  translate([-9,7,0]) cube([8,3,4],center=true);
      translate([-9,-7,0]) cube([8,3,4],center=true);
      // Spinac
      translate([5,7,0]) cube([3,3,4],center=true);
    }
  // Otvory pro zip pasku
  translate([-2,5,0]) cylinder(r=1.5,h=10,$fn=16,center=true);
  translate([-2,-5,0]) cylinder(r=1.5,h=10,$fn=16,center=true);
  }
  
}


//---  Endstop holder

difference() {

  Prusa_clamp();
    #translate([-5,-16,7])
    rotate([90,0,0])
  cylinder(r=1.2,h=30,$fn=16,center=true);
  #translate([5,-16,7])
    rotate([90,0,0])
  cylinder(r=1.2,h=30,$fn=16,center=true);
}

%translate([0,-12,5]) rotate([180,90,90]) endstop();

