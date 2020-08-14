include <config.scad>
include <bom.scad>
include <lazy.scad>
include <vitamins.scad>

module acme_anti_backlash_nut() {
  vitamin("VSLOT-H-A-AB-NUT-B Ooznest ACME anti-backlash nut");
  color(black_delrin_color) {
    import("ooznest/8mm-acme-anti-backlash-nut_VSLOT-H-A-AB-NUT-B.stl");
  }
}

module milled_corner_bracket() {
  vitamin("VSLOT-B-90AC Ooznest 90 Degree Angle Corner");
  color(black_aluminium_color) {
    txy(10,10) ry(90) import("ooznest/90-degree-corner_VSLOT-B-90AC.stl");
  }
}

module inside_hidden_corner_bracket() {
  vitamin("VSLOT-B-IHC Ooznest inside hidden corner");
  color(bracket_color) {
    import("ooznest/inside-hidden-corner-bracket_VSLOT-B-IHC.stl");
  }
}

module cast_corner_bracket() {
  vitamin("VSLOT-B-90CC Ooznest cast corner bracket");
  color(bracket_color) {
    import("ooznest/cast-corner-bracket_VSLOT-B-90CC.stl");
  }
}

module nema17_mount_plate() {
  vitamin("VSLOT-M-MP-MTR-N17 NEMA17 Motor Mounting Plate");
  color(black_aluminium_color) {
    import("ooznest/nema17-motor-plate-VSLOT-M-MP-MTR-N17.stl");
  }
}
