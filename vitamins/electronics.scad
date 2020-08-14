include <config.scad>
include <bom.scad>
include <lazy.scad>
include <vitamins.scad>

module duet_wifi() {
  vitamin("Duet Wifi");
  color(pcb_color) {
    rx(90) import("duet/duetwifi.stl");
  }
}

module duet_wifi_mount_holes() {
  myz(115/2) mxz(92/2) children();
}


