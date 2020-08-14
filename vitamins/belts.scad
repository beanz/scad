GT2 = [2.0,  6,  1.38];

function belt_pitch(type) = type[0];
function belt_width(type) = type[1];
function belt_thickness(type) = type[2];

module belt_loop(type, x1, y1, d1, x2, y2, d2, gap = 0) {
  width = belt_width(type);
  pitch = belt_pitch(type);
  thickness = belt_thickness(type);

  pi = 3.14159265;
  dx = x2 - x1;
  dy = y2 - y1;

  length = (pi * (d1/2 + d2/2 + thickness) + 2 * sqrt(dx * dx + dy * dy) - gap) / pitch * pitch;
  vitamin(str("Belt T", belt_pitch(type)," x ", width, "mm x ", length, "mm"));

  color(belt_color)
    linear_extrude(height = width, center = true, convexity = 6) {
    difference() {
      hull() {
        // outside of belt
        txy(x1, y1) circle(d = d1 + thickness*2);
        txy(x2, y2) circle(d = d2 + thickness*2);
      }
      hull() {
        // inside of belt
        txy(x1, y1) circle(d = d1);
        txy(x2, y2) circle(d = d2);
      }
    }
  }
}

module belt(type, path, bcolor = belt_color) {
  th = belt_thickness(type);
  h = belt_width(type);
  color(bcolor) {
    for (i = [0:len(path)-2]) {
      vitamin(str("BELT: GT2 ", dist(path[i], path[i+1])));
      hull() {
        txy(path[i][0], path[i][1]) cylinder(d = th, h = h, center = true);
        txy(path[i+1][0], path[i+1][1]) cylinder(d = th, h = h, center = true);
      }
    }
  }
}
