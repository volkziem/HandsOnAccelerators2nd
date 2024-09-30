% fitco.m, closed-orbit finder, V. Ziemann, 240829
function y=fitco(y,xbump,ybump)
global Re Rp kapsig Ne Np egamma pgamma Relec
RSe=inv(eye(4)-Re)*Re;
RSp=inv(eye(4)-Rp)*Rp;
ic=20;     % iteration counter
while ic>0   
  ic=ic-1;
  xsep=y(1)-y(5)+xbump;    % separation between bunch centers
  ysep=y(3)-y(7)+ybump;
  q=F0(xsep,ysep,kapsig);   % the beam beam kick
  xk=imag(q); yk=real(q);  
  exdef=-2e12*Relec*Np*xk/egamma;    % electron deflection angle
  eydef=-2e12*Relec*Np*yk/egamma;    
  pxdef=2e12*Relec*Ne*xk/pgamma;     % positron deflection angles
  pydef=2e12*Relec*Ne*yk/pgamma;
  y(1:4)=RSe*[0;exdef;0;eydef];
  y(5:8)=RSp*[0;pxdef;0;pydef];
end




