// RebeliX
//
// spool-holder
// GNU GPL v3
// Martin Neruda <neruda@reprap4u.cz>
// http://www.reprap4u.cz

include <../configuration.scad>
$fn=50;
frame_width = 30;
frame_trail = 8;
frame_depth = 1.5;

axe_diameter = 15;
spool_diameter = 200;
base_width = 25;
base_height = 10;
base_extra = 10;

screw_head = 13;
screw_body = 6.5;
screw_depth = 5;

printer_back = 110;
epsilon = 0.01;
width = 5;

/*
[hidden]
*/
shift_back = printer_back - spool_diameter/2;
shift_up = sqrt(pow(spool_diameter/2,2)-pow(shift_back-frame_width/2,2));

module screw(){
  rotate([-90,0,0]){
    translate([0,0,shift_up/2])
    cylinder(r=screw_head/2,h=shift_up+epsilon,center=true);
    translate([0,0,-shift_up/2])
    cylinder(r=screw_body/2,h=shift_up,center=true);
  }
}


module base(){
    cube([frame_width,base_height,base_width]);
    translate([frame_width/2-frame_trail/2,-frame_depth,0])
    cube([frame_trail,frame_depth+epsilon,base_width]);
}

module extra(){
  r=(base_width-width);
  difference(){
    hull(){
      cube([frame_width,epsilon,base_width-width]);
      translate([shift_back,shift_up,0])
      cube([frame_width,epsilon,base_width-width]);
    }
    hull(){
      resize([0,base_extra*2,0])
      translate([frame_width/2,r+epsilon,r])
      rotate([0,90,0])
      cylinder(r=r+epsilon,h=frame_width*2,center=true);
      translate([shift_back,shift_up+3*epsilon,0])
      cube([frame_width,epsilon,base_width-width]);
    }
  }
}
module spool(){
  spool_w = 65;
  color("blue")
   translate([
      frame_width/2+shift_back,
      base_height+shift_up+axe_diameter/2,
      -spool_w/2-2*width/3
    ]){
      cylinder(r=spool_diameter/2,h=spool_w,center = true);
      cylinder(r=axe_diameter/2,h=spool_w+4*width,center = true);
   }
}
%spool();

module stand(){
  difference(){
    hull(){
      cube([frame_width,epsilon,width]);
      translate([shift_back,shift_up,0])
      cube([frame_width,epsilon,width]);
    }
    hull(){
       translate([frame_width/2+2,base_extra+axe_diameter/2,-epsilon])
       cylinder(r=axe_diameter/2,h=width+2*epsilon);
        translate([shift_back+axe_diameter/2+7,shift_up-axe_diameter/2-(frame_width-axe_diameter/2)/2+5,-epsilon])
       cylinder(r=axe_diameter/2,h=width+2*epsilon);
    }
  }
}

module top(){
  difference(){
    cube([frame_width,axe_diameter,width]);
    hull(){
      translate([frame_width/2,axe_diameter/2+epsilon,width/2])
      cylinder(r=axe_diameter/2,h=width+2*epsilon, center = true);
      translate([frame_width/2,axe_diameter+epsilon,width/2])
      cylinder(r=axe_diameter/2,h=width+2*epsilon, center = true);
    }
  }
}

module body(){
  difference(){
    union(){
      base();
      translate([0,base_height-epsilon,0]){
        stand();
        translate([0,0,width])
        extra();
      }
      translate([shift_back,base_height+shift_up-epsilon,0])
      top();
    }
    translate([frame_width/2,screw_depth,base_width/2])
    screw();
  }
  
}

translate([5,0,0]);
body();

mirror([1,0,0])
translate([5,0,0])
body();