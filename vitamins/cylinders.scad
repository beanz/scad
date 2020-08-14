module rod(d , l, center = true) {
  vitamin(str("Smooth rod ", d, "mm x ", round(l), "mm"));
  color(rod_color) cylinder(d = d, h = l, center = center);
}

module lead_screw(d , l, center = true) {
  vitamin(str("Lead Screw ", d, "mm x ", round(l), "mm"));
  color(lead_screw_color) cylinder(d = d, h = l, center = center);
}
