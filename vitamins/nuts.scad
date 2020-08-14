//        id  od   h    name
M3_nut = [3,  5.5, 2.4, M3_washer, "M3 nut"];
M4_nut = [4,  7.0, 3.2, M4_washer, "M4 nut"];
M5_nut = [5,  8.0, 4.0, M5_washer, "M5 nut"];

function nut_id(type) = type[0];
function nut_od(type) = type[1];
function nut_flats_d(type) = type[1]/sin(60);
function nut_h(type) = type[2];
function nut_washer(type) = type[3];
function nut_name(type) = type[4];

module nut(type) {
  vitamin(nut_name(type));
  color(nut_color) {
    h = nut_h(type);
    hs = 0.9*h;
    o = (h-hs)/2;
    difference() {
      hull() {
        cylinder(d = nut_od(type), h = h, $fn = 12);
        tz(o) cylinder(d = nut_flats_d(type), h = hs, $fn = 6);
      }
      tz(-eta) cylinder(d = nut_id(type), h = h+eta*2, $fn = 12);
    }
  }
}

module nut_up(type) ry(180) nut(type);

module nut_washer(type) {
  w = nut_washer(type);
  washer(w);
  tz(washer_h(w)) nut(type);
}

module nut_washer_up(type) ry(180) nut_washer(type);

M4_tnut = [4, 6, 12, 3, 1];
M5_tnut = [5, 6, 12, 3, 1];

function tnut_d(t) = t[0];
function tnut_slot_w(t) = t[1];
function tnut_w(t) = t[2];
function tnut_h(t) = t[3];
function tnut_top_h(t) = t[4];

module tnut(t) {
  vitamin(str("M", t[0], " T Nut"));

  color(nut_color) render() difference() {
    intersection() {
      union() {
        hull() {
          txy(0.5,0.5)
            cylinder(d = tnut_slot_w(t)-1, h = tnut_top_h(t), $fn = 24);
          txy(-tnut_slot_w(t)/2+0.5, tnut_slot_w(t)/2-0.5)
            rcc([1, 1, tnut_top_h(t)]);
          txy(-0.5,-0.5)
            cylinder(d = tnut_slot_w(t)-1, h = tnut_top_h(t), $fn = 24);
          txy(tnut_slot_w(t)/2-0.5, -tnut_slot_w(t)/2+0.5)
            rcc([1, 1, tnut_top_h(t)]);
        }
        tz(-tnut_h(t)) {
          cylinder(d1 = tnut_slot_w(t)+1, d2 = tnut_w(t), h = tnut_h(t)-1,
                   $fn = 24);
        }
        tz(-1) cylinder(d = tnut_w(t), h = 1, $fn = 24);
      }
      tz(-tnut_h(t)) rcc([tnut_slot_w(t), tnut_w(t), tnut_h(t) + tnut_top_h(t)]);
    }
    cylinder(d = tnut_d(t), h = tnut_h(t)*3, center = true, $fn = 12);
  }
}
