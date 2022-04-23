difference(){
  
  union(){
      import("mods_for_display_case_front.stl");
      translate([5,80,-0.4])
      cube([100,14,5]);
  }
  /**/
  translate([82,84,-0.401])
  linear_extrude(0.7)
  rotate([0,180,0])
  text("skorpil.cz",9,font="Roboto:style=Black");
}