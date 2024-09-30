% pendulumtracker2_phase.m, fixed point at pi/2, V. Ziemann, 240829
function xout=pendulumtracker2_phase(x,omega,phi,dt)
x(1)=x(1)-pi/2+phi;   % adjust to new phase
k2=(0.5*x(2)/omega)^2+sin(0.5*x(1))^2; k=sqrt(k2);
if (x(1)>pi), x(1)=x(1)-2*pi; end
if (x(1)<-pi), x(1)=x(1)+2*pi; end
s=1; if (x(1)<0), s=-s; x(1)=-x(1); end
s1=1; if (x(2)<0), s1=-s1; end
if (k>1)   % outside separatrix; check this part next
  % disp('outside')
  kelf=ellipke(1/k2);
  trev=2*kelf/(k*omega);
  t0=mod(dt,trev);
  tmp=s1*k*omega*t0+s*elliptic12(0.5*x(1),1/k2);
  [sn,cn,dn]=ellipj(tmp,1/k2);    
  if (abs(tmp) > kelf), sn=-sn; end
  xout(1)=2*asin(sn);
  xout(2)=2*s1*omega*k*dn;
else       % inside separatrix
  %disp('inside')
  trev=4*ellipke(k2)/omega;
  t0=mod(dt,trev);
  z0=asin(min(1,sin(0.5*x(1))/k));
  tmp=s1*omega*t0+s*elliptic12(z0,k2);
  [sn,cn,dn]=ellipj(tmp,k2);  
  xout(1)=2*asin(k*sn);
  xout(2)=2*s1*omega*k*cn;
end
x(1)=x(1)+pi/2-phi;    % adjust phase back
xout(1)=xout(1)+pi/2-phi;
if (xout(1)>3*pi/2), xout(1)=xout(1)-2*pi; end  % cast in range
if (xout(1)<-pi/2), xout(1)=xout(1)+2*pi; end
