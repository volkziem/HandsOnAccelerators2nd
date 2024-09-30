// undulator10mm.scad, v. Ziemann, 240829
// run with "openscad undulator10mm.scad"
// Halbach undulator with 10mm gap, uncompensated field integrals
difference() {
union() {
    cube([94,40,4]);
    color("blue") {
      translate([0,23,4]){cube([94,10,6]);}
      translate([0,7,4]){cube([94,10,6]);}
    }
}
for (i=[0:14]) {translate([4.95+i*6,27.5,8]) {
    rotate([0,0,-90*i-90]) {
        cube([5.4,5.4,6],center=true);
        translate([2.75,0,6]) {cube([0.5,0.5,10],center=true);}
     }}}
for (i=[0:14]) {translate([4.95+i*6,12.5,8]) {
    rotate([0,0,90*i-90]) {
        cube([5.4,5.4,6],center=true);
        translate([2.75,0,6]) {cube([0.5,0.5,10],center=true);}
     }}}
}