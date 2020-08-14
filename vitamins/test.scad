%translate([0,0,-8]) rotate([0,90,0]) {
  import("/home/beanz/things/ooznest/low-profile-screw.stl");
}

module low_profile_screw(l = 8) {
  translate([0, 0, -l]) {
    translate([0, 0, 0.5]) {
      cylinder(d = 5, h = 8-0.5+0.01);
    }
    cylinder(d1 = 5-1, d2 = 5, h = 0.5);
    translate([0, 0, l]) {
      difference() {
        union() {
          cylinder(d1 = 8.5, d2 = 9, h = 0.75);
          translate([0, 0, 0.75]) cylinder(d1 = 9, d2 = 8.5, h = 0.75);
        }
        translate([0, 0, 0.5]) {
       #   rotate([0,0,30]) cylinder(d = 3/sin(60), $fn = 6, h = 1+0.01);
        }
      }
    }
  }
}
low_profile_screw();
