function out=chisq_tune_tme(x)

F=x(1);
D=x(2);
L=1;
phi=10*pi/180;
rho=2/phi;
BB=[cos(phi),rho*sin(phi);-sin(phi)/rho,cos(phi)];
%BB=[1,2;0,1];

DD=@(L)[1,L;0,1];
QQ=@(F)[1,0;-1/F,1];

% full cell
n=2;
TME_X=DD(n*L)*QQ(-D)*DD(L)*QQ(F)*DD(L)*BB*DD(L)*QQ(F)*DD(L)*QQ(-D)*DD(n*L);
TME_Y=DD(n*L)*QQ(D)*DD(L)*QQ(-F)*DD(4*L)*QQ(-F)*DD(L)*QQ(D)*DD(n*L);

mux=acos(0.5*(TME_X(1,1)+TME_X(2,2)));
muy=acos(0.5*(TME_Y(1,1)+TME_Y(2,2)));

mux=mux*180/pi;  
if TME_X(1,2)< 0  mux=360-mux; end
muy=muy*180/pi;

out=(mux-240).^2+(muy-120).^2; 


