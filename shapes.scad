use <lazy.scad>

// centered cube
module cc(d) cube(d, center = true);

// raised centered cube (bottom at z=0)
module rcc(d) tz(d[2]/2) cc(d);

// rounded cube (ft = flat top & fb = flat bottom)
module rc(d, r = 1.5, ft = false, fb = false) {
  hull() {
    for (ix = [-1, 1]) {
      tx(ix*(d[0]/2-r)) {
        for (iy = [-1, 1]) {
          ty(iy*(d[1]/2-r)) {
            for (iz = [-1, 1]) {
              if ( (ft && iz == 1) || (fb && iz == -1) ) {
                tz(iz*(d[2]/2-eta/2)) {
                  cylinder(r = r, h = eta, center = true);
                }
              } else {
                tz(iz*(d[2]/2-r)) {
                  sphere(r = r);
                }
              }
            }
          }
        }
      }
    }
  }
}

module rcf(d, r = 1.5) {
  rc(d, r = r, ft = true, fb = true);
}

module rcft(d, r = 1.5) {
  rc(d, r = r, ft = true);
}

module rcfb(d, r = 1.5) {
  rc(d, r = r, fb = true);
}

// raised rounded cube (bottom at z=0, ft = flat top & fb = flat bottom)
module rrc(d, r = 1.5, ft = false, fb = false) {
  tz(d[2]/2) rc(d, r, ft, fb);
}

module rrcf(d, r = 1.5) {
  rrc(d, r = r, ft = true, fb = true);
}

module rrcft(d, r = 1.5) {
  rrc(d, r = r, ft = true);
}

module rrcfb(d, r = 1.5) {
  rrc(d, r = r, fb = true);
}

module tube(od, id, h, center = true) {
  difference() {
    cylinder(d = od, h = h, center = center);
    tz(-eta/2) cylinder(d = id, h = h+eta*2, center = center);
  }
}

