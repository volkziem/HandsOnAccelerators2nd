% filamentation.m, V. Ziemann
clear all; close all
Omegas=0.25; Ts=2*pi/Omegas; % synchrotron frequency
dt=0.2*Ts;     % adjust time step
N=100;      % number of particles
x0=[0.0,0.4]; dx=[0.3,0.1];  % center and spread of distribution
phi=-pi:0.01:pi; separatrix=2*Omegas*cos(0.5*phi);
hold off; plot(phi,separatrix,'k',phi,-separatrix,'k')
axis([-pi,pi,-0.67,0.67]); hold on; pause(0.001)
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
  'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
text(-2.8,-0.57,['After ',num2str(dt/Ts),' T_s'],'fontsize',16)
for k=1:N   % loop over particles
  x=x0+(rand(1,2)-0.5).*dx;  plot(x(1),x(2),'g.');
  x1=pendulumtracker(x,Omegas,dt); plot(x1(1),x1(2),'k.');
  pause(0.001)
end
