

PSU_S_350 = ["S-350 PSU", 215, 115, 50, 2, 32.5/2, 50*0.25];

function psu_name(t) = t[0];
function psu_length(t) = t[1];
function psu_width(t) = t[2];
function psu_height(t) = t[3];
function psu_th(t) = t[4];
function psu_end_d(t) = t[5];
function psu_end_h(t) = t[6];
function psu_end_w(t) = psu_width(t) - psu_th(t)*2;

module psu(t) {
  color(psu_color) {
    render() difference() {
      rcc([psu_length(t), psu_width(t), psu_height(t)]);
      txz(psu_end_d(t)/2-eta-psu_length(t)/2, psu_end_h(t)) {
        rcc([psu_end_d(t)+eta, psu_end_w(t), eta+psu_height(t)-psu_end_h(t)]);
      }
      for (i = [-1, 1]) {
        for (j = [-1, 1]) {
          tz(-eta) {
            txy(i*150/2, j*50/2) {
              cylinder(d = screw_clearance_d(M4_allen_cap_screw), h = 8);
            }
            txy(i*(177.5/2)+8.75, j*(95/2)) {
              cylinder(d = screw_clearance_d(M3_allen_cap_screw), h = 8);
            }
          }
          mxz(psu_width(t)/2+eta) {
            txz(i*150/2, psu_height(t)/2-j*25/2) {
              rx(90) cylinder(d = screw_clearance_d(M4_allen_cap_screw), h = 8);
            }
          }
        }
      }
    }
  }
}
