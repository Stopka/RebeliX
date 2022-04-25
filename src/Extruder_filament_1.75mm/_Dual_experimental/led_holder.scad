height = 15;
angle = 90-30;
led_length=52;
led_width=8;

mount_with=52;
mount_height=8;
mount_hole_d=2.95;
mount_head_d=6;
mount_hole_dist=52-9;
mount_depth = 2.5;

zip_w=3;
zip_h=2;
zip_d=6;

epsilon=0.01;


depth=led_width*sin(angle);
diff=(led_length-mount_with)/2;
height_addition=led_width*cos(angle);
bngle=atan((depth-mount_depth)/(height+height_addition));
cngle=atan(diff/(height-mount_height));

module led_base(){
  difference(){
    cube([led_length,height+height_addition,depth]);
    
    translate([0,height,0])
    rotate([angle,0,0])
    translate([-epsilon,-height*2,-depth*4])
    cube([led_length+2*epsilon,height*4,depth*4]);
    
    translate([0,0,mount_depth])
    rotate([bngle,0,0])
    translate([-epsilon,-height*2,0])
    cube([led_length+2*epsilon,height*4,depth*4]);
  }
}

module mount_hole(){
  translate([0,0,-epsilon])
  cylinder(r=mount_hole_d/2,h=mount_depth+2*epsilon,$fn=60);
  translate([0,0,mount_depth])
  cylinder(r=mount_head_d/2,h=mount_depth+epsilon,$fn=60);
}

module led_mount(){
  translate([mount_with/2-mount_hole_dist/2,mount_height/2,0]){
    mount_hole();
    translate([mount_hole_dist,0,0])
    mount_hole();
  }
}

module led_shaped() {
  difference(){
    led_base();
    
    translate([-epsilon,-epsilon,-epsilon])
    cube([diff+1*epsilon,mount_height+epsilon,depth+2*epsilon]);
    translate([led_length-diff,-epsilon,-epsilon])
    cube([diff+1*epsilon,mount_height+epsilon,depth+2*epsilon]);
    
    translate([diff,mount_height,0])
    rotate([0,0,cngle])
    translate([-diff-epsilon,0,-epsilon])
    cube([diff+epsilon,diff/sin(cngle)+epsilon,depth+2*epsilon]);
    
    translate([mount_with+diff,mount_height,0])
    rotate([0,0,-cngle])
    translate([0,0,-epsilon])
    cube([diff+epsilon,diff/sin(cngle)+epsilon,depth+2*epsilon]);
  }
}

module zip(){
  difference(){
    cylinder(r=(zip_h*2+zip_d)/2,h=zip_w,$fn=60);
    translate([0,0,-epsilon])
    cylinder(r=(zip_d)/2,h=zip_w+2*epsilon,$fn=60);
  }
}

module eledzips(){
  translate([(led_length-(2*zip_h+zip_d))/2,0,mount_depth+3])
  rotate([0,0,0])
  translate([0,mount_height+zip_w,0])
  rotate([90,0,0])
  translate([0,0,0]){
    zip();
    translate([zip_d+2*zip_h-epsilon,0,0])
    zip();
  }
}

module led_holder(){
  difference(){
    led_shaped();
    
    translate([diff,0,0])
    led_mount();
    
    eledzips();
    
    translate([0,0,mount_depth])
    rotate([0,0,0])
    translate([diff/2-2,mount_height+(zip_w+height-mount_height)/2,3])
    rotate([90,0,cngle])
    zip();
  }
}
led_holder();