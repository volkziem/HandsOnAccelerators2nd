% draw3D.m, V. Ziemann, 240827
function draw3D(f,v0,w0,box,color)
fprintf(f,'multmatrix([ [ %f , %f , %f , %f ],\n',w0(1,1),w0(1,2),w0(1,3),v0(1));
fprintf(f,'   [ %f , %f , %f , %f ],\n',w0(2,1),w0(2,2),w0(2,3),v0(2));
fprintf(f,'   [ %f , %f , %f , %f ],\n',w0(3,1),w0(3,2),w0(3,3),v0(3));
fprintf(f,'   [ %f , %f , %f , %f ] ])\n',0,0,0,1);
fprintf(f,'translate([%f,%f,%f])\n',-box(1)/2,-box(2)/2,0);
fprintf(f,'color([%f,%f,%f]){\n',color(1),color(2),color(3));
fprintf(f,'cube([%f,%f,%f]);\n',box(1),box(2),box(3));
fprintf(f,'translate([%f,%f,%f]) ',box(1)/2,-0.5,box(3)/2);
fprintf(f,'cube([%f,%f,%f],center=true);}\n',box(1)/3,1,box(3)/3);