// Derived from nop.head@gmail.com's NEMA stepper motor model - GNU GPL v2

//                       corner  body    boss    boss          shaft
//         side, length, radius, radius, radius, depth, shaft, length, holes
NEMA17  = [42.3, 47,     53.6/2, 25,     11,     2,     5,     24,     31 ];
NEMA14  = [35.2, 36,     46.4/2, 21,     11,     2,     5,     21,     26 ];
NEMA23  = [56.4, 51.2,   75.7/2, 28.2,   38.1/2, 1.6,   6.35,  24,     47.1 ];

function NEMA_width(motor)       = motor[0];
function NEMA_length(motor)      = motor[1];
function NEMA_radius(motor)      = motor[2];
function NEMA_big_hole(motor)    = motor[4] + 0.2;
function NEMA_boss_height(motor) = motor[5];
function NEMA_shaft_dia(motor)   = motor[6];
function NEMA_shaft_length(motor)= motor[7];
function NEMA_hole_pitch(motor)  = motor[8];
function NEMA_holes(motor)       = [-motor[8]/2, motor[8]/2];

module NEMA(motor, length = undef) {
  side = NEMA_width(motor);
  l = length == undef ? NEMA_length(motor) : length;
  body_rad = motor[3];
  boss_rad = motor[4];
  boss_height = motor[5];
  cap = 8;
  vitamin(str("NEMA", round(motor[0] / 2.54), " ", l, "mm stepper motor"));
  union() {
    color(stepper_body_color) render()
      // black laminations
      tz(-l/2)
      intersection() {
      cube([side, side, l - cap * 2], center = true);
      cylinder(r = body_rad, h = 2 * l, center = true);
    }
    color(stepper_cap_color) render() {
      // aluminium end caps
      difference() {
        union() {
          intersection() {
            union() {
              tz(-cap/2) cube([side,side,cap], center = true);
              tz(-l + cap/2) cube([side,side,cap], center = true);
            }
            cylinder(r = NEMA_radius(motor), h = 3 * l, center = true);
          }
          // raised boss
          difference() {
            cylinder(r = boss_rad, h = boss_height * 2, center = true);
            cylinder(d = NEMA_shaft_dia(motor) + 4,
                     h = boss_height * 2 + 1, center = true);
          }
          // shaft
          cylinder(d = NEMA_shaft_dia(motor),
                   h = NEMA_shaft_length(motor) * 2, center = true);
        }
        NEMA_hole_positions(motor) {
          cylinder(r = 3/2, h = 9, center = true, $fn = 12);
        }
      }
    }
    tyz(side/2, -l + cap/2) rx(90)
      for(i = [0:3])
        rz(225 + i * 90)
          color(["red", "blue","green","black"][i]) render()
          tx(1) cylinder(r = 1.5 / 2, h = 12, center = true);
  }
}

module NEMA_hole_positions(motor, i = [0,1,2,3]) {
  p = [ [1,1], [1,-1], [-1,-1],[-1,1] ];
  for (pi = i) {
    txy(p[pi][0]*NEMA_hole_pitch(motor)/2, p[pi][1]*NEMA_hole_pitch(motor)/2) {
      children();
    }
  }
}

module NEMA_screws(motor, screw_length = 8, screw_type = M3_allen_cap_screw) {
  NEMA_hole_positions(motor) screw(screw_type, screw_length);
}

module NEMA_screws_washers(motor,
                           screw_length = 8,
                           screw_type = M3_allen_cap_screw) {
  NEMA_hole_positions(motor) screw_washer(screw_type, screw_length);
}
