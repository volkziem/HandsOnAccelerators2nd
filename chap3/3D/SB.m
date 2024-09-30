% SB.m, sector bend, V. Ziemann, 240828
function out=SB(L,rho)
phi=L/rho;
out=eye(3);
if abs(phi)<1e-8
  out(1,2)=L;
else
  out(1:2,1:3)=[cos(phi),rho*sin(phi),rho*(1-cos(phi)); ...
                -sin(phi)/rho,cos(phi),sin(phi)];
end