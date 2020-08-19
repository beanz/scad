//           id   od  h    name             toothed
M2_5_washer = [2.7, 6,  0.5, "M2.5 washer", 0];
M3_washer = [3.2, 7,  0.5, "M3 washer", 0];
M4_washer = [4.3, 9,  0.8, "M4 washer", 0];
M5_washer = [5.3, 10, 1.0, "M5 washer", 0];
M6_washer = [6.4, 12, 1.6, "M6 washer", 0];
M8_washer = [8.4, 16, 1.6, "M8 washer", 0];

M12_toothed_washer = [13, 21.5, 1, "M12 toothed washer", 3];

function washer_id(type) = type[0];
function washer_od(type) = type[1];
function washer_h(type) = type[2];
function washer_name(type) = type[3];
function washer_is_toothed(type) = type[4] != 0;
function washer_tooth_h(type) = type[4];

module washer(type) {
  vitamin(washer_name(type));
  color(washer_color) {
    h = washer_h(type);
    d = washer_is_toothed(type) ?
      (washer_id(type)+washer_od(type))/2 : washer_id(type);
    difference() {
      cylinder(d = washer_od(type), h = h, $fn = 12);
      tz(-eta) cylinder(d = d, h = h+eta*2, $fn = 12);
    }
    if (washer_is_toothed(type)) {
      l = (d-washer_id(type))/2;
      tz(h/2) {
        for (n = [0:12]) {
          rz(n*360/13) {
            ty(d/2-l/2) {
              ry(20) {
                cc([3, l*1.2, h]);
              }
            }
          }
        }
      }
    }
  }
}
