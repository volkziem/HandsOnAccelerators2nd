% QQ.m, long quadrupole, V. Ziemann, 240828
function out=QQ(L,k)
ksq=sqrt(abs(k));
out=eye(4);
if abs(k) < 1e-6
    out(1,2)=L;
    out(3,4)=L;
else
    A=[cos(ksq*L),sin(ksq*L)/ksq;-ksq*sin(ksq*L),cos(ksq*L)];    
    B=[cosh(ksq*L),sinh(ksq*L)/ksq;ksq*sinh(ksq*L),cosh(ksq*L)];
    if k>0
      out(1:2,1:2)=A;
      out(3:4,3:4)=B;
    else
      out(1:2,1:2)=B;
      out(3:4,3:4)=A;  
    end
end