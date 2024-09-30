% draw3Dpipe.m, V. Ziemann, 240827
function draw3Dpipe(f,v0,w0,radius,len)
fprintf(f,'multmatrix([ [ %f , %f , %f , %f ],\n',w0(1,1),w0(1,2),w0(1,3),v0(1));
fprintf(f,'   [ %f , %f , %f , %f ],\n',w0(2,1),w0(2,2),w0(2,3),v0(2));
fprintf(f,'   [ %f , %f , %f , %f ],\n',w0(3,1),w0(3,2),w0(3,3),v0(3));
fprintf(f,'   [ %f , %f , %f , %f ] ])\n',0,0,0,1);
fprintf(f,'translate([%f,%f,%f])\n',0,0,len/2);
fprintf(f,'color([0.7,0.7,0.7])\n');
fprintf(f,'cylinder($fn=30, h=%f,r=%f,center=true);\n',len,radius);
