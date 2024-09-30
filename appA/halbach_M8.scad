// halbach_M8.scad, V. Ziemann, 240829
M=8;           // number of cubes
hcube=5;       // size of cube
k=3;           // tumble factor: k=2 -> dipole, k=3 -> quadrupole
h2=hcube+0.4;  // slightly bigger hole for the cubes
difference() {
  cylinder(h=hcube+1.5,r=14,$fn=120);    // cylinder
  translate([0,0,-0.5]) {
    cylinder(h=10*hcube,r=4.5,$fn=120);  // hole in middle
    for (j=[0:M-1]) {  // loop over cubes
      rotate([0,0,j*360/M]) {translate([9.5,0,1.5]) {
        rotate([0,0,(k-1)*j*360/M]) {
          translate([-2.7,-2.7,0.2]) cube([5.4,5.4,5.4]);      // big holes
          translate([-0.25,h2/2-0.2,h2-1]) cube([0.5,0.5,10]); // notches
        }
      }}  // rotate+translate
    }  // for
  }  // translate
} // difference