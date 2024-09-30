% CTM.m, collision transfer matrix, V. Ziemann, 240829
function R=CTM(dz,fxinv,fyinv)
D=eye(4); D(1,2)=0.5*dz; D(3,4)=0.5*dz;
Q=eye(4); Q(2,1)=-fxinv; Q(4,3)=-fyinv;
R=D*Q*D;