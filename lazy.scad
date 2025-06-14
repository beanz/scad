
module tx(x) translate([x, 0, 0]) children();
module ty(y) translate([0, y, 0]) children();
module tz(z) translate([0, 0, z]) children();

module fx(xs) for (x = xs) tx(x) children();
module fy(ys) for (y = ys) ty(y) children();
module fz(zs) for (z = zs) tz(z) children();

module txy(x, y) translate([x, y, 0]) children();
module txz(x, z) translate([x, 0, z]) children();
module tyz(y, z) translate([0, y, z]) children();

module txyz(x, y, z) translate([x, y, z]) children();

module rx(a) rotate([a, 0, 0]) children();
module ry(a) rotate([0, a, 0]) children();
module rz(a) rotate([0, 0, a]) children();

// mirror on yz plane with optional x offset
module myz(o = 0) {
  for (m = [0, 1]) {
    mirror([m, 0, 0]) {
      tx(o) {
        children();
      }
    }
  }
}

// mirror on xz plane with optional y offset
module mxz(o = 0) {
  for (m = [0, 1]) {
    mirror([0, m, 0]) {
      ty(o) {
        children();
      }
    }
  }
}

// mirror on xy plane with optional z offset
module mxy(o = 0) {
  for (m = [0, 1]) {
    mirror([0, 0, m]) {
      tz(o) {
        children();
      }
    }
  }
}
