% SB.m, sector bend, V. Ziemann, 240828
function out=SB(L,rho)
phi=L/rho;
out=eye(4);
out(3,4)=L;
if abs(phi)<1e-8
  out(1,2)=L;
else
  out(1:2,1:2)=[cos(phi),rho*sin(phi); ...
                -sin(phi)/rho,cos(phi)];       
end