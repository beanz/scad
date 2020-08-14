         //                              hole  hole offset   hole
         // name        l     d    h     d     1    2        h
SS_5GL_F = ["SS-5GL-F", 19.8, 6.4, 10.2, 2.35, 5.1, 5.1+9.5, 2.5,
         // button              terminal
         // offset l    d    h  offsets
            7.5,   2.0, 3.6, 1, 1.6, 1.6+8.8, 1.6+8.8+7.3, 0.5, 3.2, 3.9];

function microswitch_name(t) = t[0];
function microswitch_l(t) = t[1];
function microswitch_d(t) = t[2];
function microswitch_h(t) = t[3];
function microswitch_hole_d(t) = t[4];
function microswitch_hole_offsets(t) = [-t[1]/2+t[5], -t[1]/2+t[6]];
function microswitch_hole_h(t) = t[7];
function microswitch_button_offset(t) = -t[1]/2+t[8];
function microswitch_button_l(t) = t[9];
function microswitch_button_d(t) = t[10];
function microswitch_button_h(t) = t[11];
function microswitch_terminal_offsets(t) =
         [ -t[1]/2+t[12]+t[15]/2,
           -t[1]/2+t[13]+t[15]/2,
           -t[1]/2+t[14]+t[15]/2 ];
function microswitch_terminal_l(t) = t[15];
function microswitch_terminal_d(t) = t[16];
function microswitch_terminal_h(t) = t[17];

module microswitch_hole_positions(t) {
  for (x = microswitch_hole_offsets(t)) {
    txz(x, microswitch_hole_h(t)) {
      children();
    }
  }
}

module microswitch_terminal_positions(t) {
  for (x = microswitch_terminal_offsets(t)) {
    txz(x, -microswitch_terminal_h(t)/2) {
      children();
    }
  }
}

module microswitch(type) {
  l = microswitch_l(type);
  d = microswitch_d(type);
  color(microswitch_body_color) render() {
    difference() {
      rcc([l, d, microswitch_h(type)]);
      microswitch_hole_positions(type) {
        rx(90) {
          cylinder(d = microswitch_hole_d(type),
                   h = microswitch_d(type)*3,
                   center = true);
        }
      }
    }
  }
  color(microswitch_button_color) render() {
    txz(microswitch_button_offset(type), microswitch_h(type)-eta) {
      rcc([microswitch_button_l(type),
           microswitch_button_d(type),
           microswitch_button_h(type)]);
    }
  }
  color(microswitch_terminal_color) render() {
    microswitch_terminal_positions(type) {
      tz(eta) {
        cc([microswitch_terminal_l(type),
            microswitch_terminal_d(type),
            microswitch_terminal_h(type)]);
      }
    }
  }
}

