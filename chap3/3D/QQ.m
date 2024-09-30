% QQ.m, long quadrupole, V. Ziemann, 240828
function out=QQ(L,k)
ksq=sqrt(abs(k));
out=eye(3);
if abs(k) < 1e-6
    out(1,2)=L;
elseif k>0
    out(1:2,1:2)=[cos(ksq*L),sin(ksq*L)/ksq;-ksq*sin(ksq*L),cos(ksq*L)];    
else
    out(1:2,1:2)=[cosh(ksq*L),sinh(ksq*L)/ksq;ksq*sinh(ksq*L),cosh(ksq*L)];
end