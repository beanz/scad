include <config.scad>
include <bom.scad>
include <lazy.scad>
include <shapes.scad>
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

function iec_socket_cut_out_h() = 27.5;
function iec_socket_cut_out_w() = 47;
function iec_socket_screw_gap() = 39.8;
function iec_socket_back_clearance_d() = 25;

module iec_socket_screw_positions() {
  tz(2.5) mxz(39.8/2) children();
}

module iec_socket() {
  vitamin("IEC fused socket with switch");
  color([0.1,0.1,0.1]) {
    difference() {
      union() {
        // outer front
        hull() {
          mxz(39.8/2) cylinder(d = 9.2, h = 2.5);
          rrcf([59.5, 28.5, 2.5]);
        }
        // inner front
        rrcf([55, 28.5, 2.5+0.8]);
        // back
        tz(-22.7+eta) hull() {
          mxz(27.5/2-1/2) {
            tx(47/2-1/2) cylinder(d = 1, h = 22.7);
            tx(-((41-47/2)-1/2)) cylinder(d = 1, h = 22.7);
            txy(-47/2+1/2, -5.25) cylinder(d = 1, h = 22.7);
          }
        }
      }
      iec_socket_screw_positions() {
        cylinder(d = 7.3/2, h = 100, center = true);
      }
      txz(-6.3, -19.3+2.5+0.8) hull() {
        mxz(24.5/2-1/2) {
          cylinder(d = 1, h = 19.3+eta);
          tx(-16.4+1/2+4) cylinder(d = 1, h = 19.3+eta);
          txy(-16.4+1/2, -4) cylinder(d = 1, h = 19.3+eta);
        }
      }
    }
  }
  color([0.7,0,0,0.7]) {
    txz(14.15, 2.5+0.8) {
      hull() {
        mxz(23/2-1/2) ry(90) cylinder(d = 1, h = 16, center = true);
        tyz(-6.8, 5.4) ry(90) cylinder(d = 1, h = 16, center = true);
      }
    }
  }
  color("gold") {
    tz(-22.7) {
      myz(19) {
        cc([4.3, 0.8, 10]);
      }
      tx(10) {
        cc([4.3, 0.8, 10]);
      }
    }
  }
}
