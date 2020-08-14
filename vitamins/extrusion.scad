include <poly/ITM37003.scad>
include <poly/VSLOT2020.scad>
include <poly/VSLOT2040.scad>

extrusion_kjn_ITM37003 =
  ["KJN ITM37003 20x20 Extrusion",
   20, 20, 5, 6.25, 1.8, 4.3, 2, ITM37003_profile];
extrusion_vslot_2020 =
  ["V-Slot 20x20 Extrusion",
   20, 20, 6, 6.1, 1.8, 4.2, 0.5, VSLOT2020_profile];
extrusion_vslot_2040 =
  ["V-Slot 20x40 Extrusion",
   20, 40, 6, 6.1, 1.8, 4.2, 0.5, VSLOT2040_profile];

function extrusion_part(type) = type[0];
function extrusion_width(type) = type[1];
function extrusion_height(type) = type[2];
function extrusion_slot_width(type) = type[3];
function extrusion_slot_depth(type) = type[4];
function extrusion_slot_lip_width(type) = type[5];
function extrusion_center_diameter(type) = type[6];
function extrusion_center_radius(type) = type[6]/2;
function extrusion_roundness(type) = type[7];
function extrusion_profile(type) = type[8];
module extrusion(t, l = 100, center = true) {
  vitamin(str(extrusion_part(t), " x ", l, "mm"));
  profile = extrusion_profile(t);
  color(extrusion_color) render() {
    tz(center ? -l/2 : 0) {
      linear_extrude(height = l) {
        polygon(points=profile[0], paths = profile[1]);
      }
    }
  }
}
