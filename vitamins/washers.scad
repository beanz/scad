//           id   od  h    name
M2_5_washer = [2.7, 6,  0.5, "M2.5 washer"];
M3_washer = [3.2, 7,  0.5, "M3 washer"];
M4_washer = [4.3, 9,  0.8, "M4 washer"];
M5_washer = [5.3, 10, 1.0, "M5 washer"];
M6_washer = [6.4, 12, 1.6, "M6 washer"];
M8_washer = [8.4, 16, 1.6, "M8 washer"];

function washer_id(type) = type[0];
function washer_od(type) = type[1];
function washer_h(type) = type[2];
function washer_name(type) = type[3];

module washer(type) {
  vitamin(washer_name(type));
  color(washer_color) {
    h = washer_h(type);
    difference() {
      cylinder(d = washer_od(type), h = h, $fn = 12);
      tz(-eta) cylinder(d = washer_id(type), h = h+eta*2, $fn = 12);
    }
  }
}
