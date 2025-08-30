include <config.scad>
use <shapes.scad>

module embedded_sign(d, border = 3, embed_height = 0.2, r = 2, fn = 32, part_a = undef) {
  l = d[0];
  w = d[1];
  h = d[2];
  eh = embed_height;
  if (is_undef(part_a) || part_a) {
    render() color("black") difference() {
      rrcf(d, r = r, $fn = fn);
      linear_extrude(eh+eta) mirror([1,0]) children();
    }
  }
  if (is_undef(part_a) || !part_a) {
    render() color("red") {
      linear_extrude(eh) mirror([1,0]) children();
    }
  }
}

module raised_sign(d, border = 3, height_ratio = 0.5, r = 2, fn = 32) {
  l = d[0];
  w = d[1];
  h = d[2];
  hh = h*height_ratio;
  render() color("black") rrcf([l, w, hh-eta], r = r, $fn = fn);
  tz(hh-eta) render() color("red") {
    difference() {
      rrcf([l, w, h-hh-eta], r = r, $fn = fn);
      rrcf([l-border*2, w-border*2, h], r = r, $fn = fn);
    }
    linear_extrude(h-hh) children();
  }
}
