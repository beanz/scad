//                     clearance        head        wrench
//                    shaft    d  tap   d    h      size depth
M3_allen_cap_screw = [3,     3.3, 2.5,  5.5, 3.0,   2.5, 1.3,
                      M3_nut, M3_washer, "allen cap", "M3 allen cap screw"];

M4_allen_cap_screw = [4,     4.4, 3.3,  7.0, 4.0,   3.0, 2.0,
                      M4_nut, M4_washer, "allen cap", "M4 allen cap screw"];
M4_button_head_screw=[4,     4.4, 3.3,  7.5, 2.2,   2.5, 1.4,
                      M4_nut, M4_washer, "button", "M4 button head screw"];
M4_flanged_allen_cap_screw =
                     [4,     4.4, 3.3,  9.4, 2.2,   2.5, 1.4,
                      M4_nut, M4_washer, "flanged",
                      "M4 flanged allen cap screw"];

M5_allen_cap_screw = [5,     5.3, 4.2,  8.5, 5.0,   4.0, 2.5,
                      M5_nut, M5_washer, "allen cap", "M5 allen cap screw"];
M5_button_head_screw=[5,     5.3, 4.2,  9.5, 2.75,  3.0, 1.6,
                      M5_nut, M5_washer, "button", "M5 button head screw"];
M5_flanged_allen_cap_screw=
                     [5,     5.3, 4.2,  11.8, 2.75,  3.0, 1.6,
                      M5_nut, M5_washer, "flanged",
                      "M5 flanged allen cap screw"];

M5_low_profile_screw =[5,    5.3, 4.2,  9.0, 1.5,   3.0, 1.0,
   M5_nut, M5_washer, "low profile", "M5 low profile screw"];

M3_grub_screw =      [3,     3.3, 2.5,  0, 0,       2.5, 1.3,
                      M3_nut, M3_washer, "grub", "M3 grub screw"];
M4_grub_screw =      [4,     4.4, 3.3,  0, 0,       2.5, 2.0,
                      M4_nut, M4_washer, "grub", "M4 grub screw"];

function screw_d(t) = t[0];
function screw_clearance_d(t) = t[1]*1.1;
function screw_tap_d(t) = t[2];
function screw_head_d(t) = t[3];
function screw_head_h(t) = t[4];
function screw_wrench(t) = t[5];
function screw_wrench_h(t) = t[6]; // depth of wrench hole
function screw_wrench_flats_d(t) = screw_wrench(t)/sin(60);
function screw_nut(t) = t[7];
function screw_washer(t) = t[8];
function screw_head_type(t) = t[9];
function screw_name(t) = t[10];

module screw(type, l) {
  vitamin(str(screw_name(type), " x ", l, "mm"));
  color(screw_head_type(type) == "low profile"
        ? black_screw_color : screw_color) {
    tz(-l) cylinder(d = screw_d(type), h = l, $fn = 12);
    if (screw_head_type(type) == "allen cap") {
      h = screw_head_h(type);
      difference() {
        cylinder(d = screw_head_d(type), h = h, $fn = 12);
        tz(h-screw_wrench_h(type)) {
          cylinder(d = screw_wrench_flats_d(type),
                   h = screw_wrench_h(type)+eta,
                   $fn = 6);
        }
      }
    } else if (screw_head_type(type) == "button") {
      h = screw_head_h(type);
      d = screw_head_d(type);
      render() intersection() {
        rcc([d*2, d*2, h]);
        difference() {
          // scale should be h*2/d but we want a bit more to keep height
          // even after socket cut
          scale([1, 1, h*2.2/d]) sphere(d = d, $fn = 12);
          tz(h-screw_wrench_h(type)) {
            cylinder(d = screw_wrench_flats_d(type),
                     h = screw_wrench_h(type)+eta,
                     $fn = 6);
          }
        }
      }
    } else if (screw_head_type(type) == "flanged") {
      h = screw_head_h(type);
      flange_h = h*0.3;
      flange_d = screw_head_d(type);
      cylinder(d = flange_d, h = flange_h);
      d = flange_d - 2;
      render() intersection() {
        rcc([d*2, d*2, h]);
        difference() {
          // scale should be h*2/d but we want a bit more to keep height
          // even after socket cut
          scale([1, 1, h*2.2/d]) sphere(d = d, $fn = 12);
          tz(h-screw_wrench_h(type)) {
            cylinder(d = screw_wrench_flats_d(type),
                     h = screw_wrench_h(type)+eta,
                     $fn = 6);
          }
        }
      }
    } else if (screw_head_type(type) == "low profile") {
      h = screw_head_h(type);
      difference() {
        union() {
          cylinder(d1 = screw_head_d(type)-0.5, d2 = screw_head_d(type),
                   h = h/2, $fn = 12);
          tz(h/2) {
            cylinder(d2 = screw_head_d(type)-0.5, d1 = screw_head_d(type),
                     h = h/2, $fn = 12);
          }
        }
        tz(h-screw_wrench_h(type)) {
          cylinder(d = screw_wrench_flats_d(type),
                   h = screw_wrench_h(type)+eta,
                   $fn = 6);
        }
      }
    }
  }
}

module screw_washer(type, l) {
  w = screw_washer(type);
  tz(washer_h(w)) screw(type, l);
  washer(w);
}

module screw_up(type, l) ry(180) screw(type, l);
module screw_washer_up(type, l) ry(180) screw_washer(type, l);

function screw_for(l) = (l <= 8 ? 8 :
                         (l <= 10 ? 10:
                          (l <= 12 ? 12 :
                           (l <= 14 ? 14 :
                            (l <= 16 ? 16 :
                             ceil(l / 5) * 5)))));

module screw_washer_nut(type, l) {
  n = screw_nut(type);
  w = screw_washer(type);
  tl = l + washer_h(w) * 2 + nut_h(n);
  sl = screw_for(tl);
  screw_washer(type, sl);
  tz(-l) nut_washer_up(n);
}

module screw_washer_nut_up(type, l) ry(180) screw_washer_nut(type, l);
