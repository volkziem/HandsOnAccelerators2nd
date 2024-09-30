%smaller_buckets.m, V. Ziemann, 240828
clear; close all;
degree=pi/180;
k=0;
pp=zeros(1,90); phi1=pp; phi2=pp; bh=pp;
for phideg=1:90
  k=k+1;
  phis=phideg*degree;
  pp(k)=phideg;
  g=@(phi)cos(phis)-pi*sin(phis)+(phi+phis)*sin(phis)+cos(phi);
  phi1(k)=fzero(g,-2);
  phi2(k)=pi-phis; 
end
plot(pp,phi1/degree,'k',pp,phi2/degree,'k',pp,pp,'k:')
axis([0,90,-180,180])
xlabel('\phi_s [degree]'); ylabel('\phi_{min}, \phi_{max} [degree]')

figure
k=0;
for phideg=1:90
  k=k+1;
  phis=phideg*degree;
  pp(k)=phideg;
  g=@(phi)cos(phis)-pi*sin(phis)+(phi+phis)*sin(phis)+cos(phi);
  bh(k)=sqrt(2*g(phis));
end
plot(pp,bh,'k')
xlabel('\phi_s [degree]');
ylabel('(d\phi/dt)_{max}/\Omega_s')
