% sachfun.m, the right hand side of the derivatives, V. Ziemann, 240829
% x(1)=sigx, x(2)=sigx', x(3)=sigy, x(4)=sigy'
function dxds=sachfun(s,x)
global epsx epsy Kperv
dxds=zeros(4,1);
dxds(1)=x(2);
dxds(2)=-k1(s).*x(1)+epsx^2./x(1).^3+Kperv./(x(1)+x(3));
dxds(3)=x(4);
dxds(4)=k1(s).*x(3)+epsy^2./x(3).^3+Kperv./(x(1)+x(3));