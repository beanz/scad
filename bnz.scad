include <config.scad>
include <bom.scad>
include <lazy.scad>
include <shapes.scad>
include <vitamins.scad>
include <sign.scad>

function dist(p1, p2) = sqrt((p1[0]-p2[0])*(p1[0]-p2[0])+
                             (p1[1]-p2[1])*(p1[1]-p2[1]));

