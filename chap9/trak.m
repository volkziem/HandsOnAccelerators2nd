% trak.m, V. Ziemann, 240829
function y=trak(y,xbump,ybump)
global Re Rp kapsig Ne Np egamma pgamma Relec
xsep=y(1)-y(5)+xbump;     % separation between bunch centers
ysep=y(3)-y(7)+ybump;
q=F0(xsep,ysep,kapsig);   % the beam beam kick
xk=imag(q); yk=real(q);  
exdef=-2e12*Relec*Np*xk/egamma;    % electron deflection angle
eydef=-2e12*Relec*Np*yk/egamma;    
pxdef=2e12*Relec*Ne*xk/pgamma;     % positron deflection angles
pydef=2e12*Relec*Ne*yk/pgamma;

y(2)=y(2)+exdef; y(4)=y(4)+eydef;  % electron deflection angle
y(6)=y(6)+pxdef; y(8)=y(8)+pydef;  % Positron deflection angle

y(1:4)=Re*y(1:4);  % electron transport through the ring
y(5:8)=Rp*y(5:8);  % positron transport through the ring


