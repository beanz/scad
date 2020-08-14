
MGN12H_Carriage = ["MGN12H Carriage",
  27, 45.4, 10, 3, 32.4, 20, 20, M3_allen_cap_screw, 3.5];
MGN12C_Carriage = ["MGN12C Carriage",
  27, 32.4, 10, 3, 21.7, 15, 20, M3_allen_cap_screw, 3.5];

MGN15H_Carriage = ["MGN15H Carriage",
  32, 58.8, 12, 4, 43.4, 25, 25, M3_allen_cap_screw, 4];
MGN15C_Carriage = ["MGN15C Carriage",
  32, 42.1, 12, 4, 26.7, 20, 25, M3_allen_cap_screw, 4];

function carriage_part(type) = type[0];
function carriage_w(type) = type[1]; // W
function carriage_l(type) = type[2]; // L
function carriage_h(type) = type[3]; // H - H1
function carriage_h_offset(type) = type[4]; // H1
function carriage_total_h(type) = carriage_h(type)+carriage_h_offset(type);
function carriage_middle_l(type) = type[5]; // L1
function carriage_screw_gap_l(type) = type[6]; // C
function carriage_screw_gap_w(type) = type[7]; // B
function carriage_screw(type) = type[8]; // _M_ x l
function carriage_screw_d(type) = screw_d(carriage_screw(type));
function carriage_screw_l(type) = type[9]; // M x _l_

MGN12_Rail = ["MGN12 Rail",
  12, 8, 6, 4.5, 3.5, 25, 10, M3_allen_cap_screw, 8,
              MGN12H_Carriage, MGN12C_Carriage];

MGN15_Rail = ["MGN15 Rail",
  15, 10, 6, 4.5, 3.5, 40, 15, M3_allen_cap_screw, 8,
              MGN15H_Carriage, MGN15C_Carriage];

function rail_part(type) = type[0];
function rail_width(type) = type[1]; // W
function rail_height(type) = type[2]; // H
function rail_hole_od(type) = type[3]; // D
function rail_hole_depth(type) = type[4]; // h
function rail_hole_id(type) = type[5]; // d
function rail_hole_gap(type) = type[6]; // P
function rail_hole_offset(type) = type[7]; // E
function rail_mount_screw(type) = type[8];
function rail_mount_screw_l(type) = type[9];
function rail_carriage(type, long = true) = long ? type[10] : type[11];

module rail_hole_positions(t, l) {
  tz(rail_height(t)-rail_hole_depth(t)) {
    for (x = [rail_hole_offset(t) : rail_hole_gap(t) : l]) {
      tx(x) children();
    }
  }
}

module _rail_body(t, l = 100) {
  difference() {
    tx(l/2) rcc([l, rail_width(t), rail_height(t)]);
    tx(l/2) mxz(rail_width(t)/2) {
      tz(rail_height(t)*0.75) ry(90) cylinder(d = 2, h = l*2, center = true);
    }
  }
}

module rail(t, l = 100) {
  vitamin(str(rail_part(t), " x ", l, "mm"));
  color(rail_color) render() {
    difference() {
      _rail_body(t, l);
      rail_hole_positions(t, l) {
        cylinder(d = rail_hole_id(t), h = rail_height(t)*3, center = true);
        cylinder(d = rail_hole_od(t), h = rail_height(t));
      }
    }
  }
}

module carriage_hole_positions(t, long = true) {
  ct = rail_carriage(t, long);
  myz(carriage_screw_gap_l(ct)/2) {
    mxz(carriage_screw_gap_w(ct)/2) {
      tz(carriage_total_h(ct)) children();
    }
  }
}

module carriage(t, long = true) {
  ct = rail_carriage(t, long);
  color(carriage_inner_color) render() {
    difference() {
      tz(carriage_h_offset(ct)) {
        rcc([carriage_middle_l(ct), carriage_w(ct), carriage_h(ct)]);
      }
      carriage_hole_positions(t, long) {
        tz(-carriage_screw_l(ct)+eta) {
          cylinder(d = carriage_screw_d(ct), h = carriage_screw_l(ct));
        }
      }
      tx(-carriage_l(ct)) _rail_body(t, carriage_l(ct)*2);
    }
  }
  outer_l = (carriage_l(ct)-carriage_middle_l(ct)-0.5)/2;
  color(carriage_outer_color) render() {
    difference() {
      myz(carriage_l(ct)/2-outer_l/2-0.25) {
        tz(carriage_h_offset(ct)+0.5/2) {
          rcc([outer_l, carriage_w(ct)-0.5, carriage_h(ct)-0.5]);
        }
      }
      tx(-carriage_l(ct)) _rail_body(t, carriage_l(ct)*2);
    }
  }
  color(carriage_end_color) render() {
    difference() {
      tz(carriage_h_offset(ct)+0.5/2) {
        myz(carriage_l(ct)/2-0.125) {
          rcc([0.25, carriage_w(ct)-0.5, carriage_h(ct)-0.5]);
        }
      }
      tx(-carriage_l(ct)) _rail_body(t, carriage_l(ct)*2);
    }
  }
}
