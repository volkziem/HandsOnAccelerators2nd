% QQ.m, quadrupole, V. Ziemann, 240827
function out=QQ(L,k)
ksq=sqrt(abs(k));
if abs(k) < 1e-6
    out=[1,L;0,1];
elseif k>0
    out=[cos(ksq*L),sin(ksq*L)/ksq;-ksq*sin(ksq*L),cos(ksq*L)];    
else
    out=[cosh(ksq*L),sinh(ksq*L)/ksq;ksq*sinh(ksq*L),cosh(ksq*L)];
end