% halbach_M8_simple.m, V. Ziemann, 240829
clear;
M=8;       % number of permanent magnet cubes
k=3;       % tumble factor: k=2 -> dipole, k=3 -> quadrupole
h=5;       % size of cube
h2=h+0.4;  % little extra space for tolerances
fp=fopen('test.scad','w');
fprintf(fp,'difference(){\n');
fprintf(fp,'  cylinder(h=%6.2f,r=14,$fn=120);\n',h+1.5);
fprintf(fp,'  translate([0,0,-0.5]) {cylinder(h=%6.2f,r=4.5,$fn=120);}\n',10*h);
for j=0:M-1     % loop over segments
  phi=j*360/M;
  psi=k*phi-phi;
  fprintf(fp,'  rotate([0,0,%8.3f]) {translate([9.5,0,1.5]) {\n',phi);
  fprintf(fp,'    rotate([0,0,%8.3f]) {translate([-2.7,-2.7,0.2]) {cube([5.4,5.4,5.4]);}\n',psi); 
  fprintf(fp,'      translate([-0.25,%6.2f,%6.2f]) {cube([0.5,0.5,10]);}  }}}\n',h2/2-0.02,h2-1);
end
fprintf(fp,'}\n'); fclose(fp);
system('openscad test.scad &');

