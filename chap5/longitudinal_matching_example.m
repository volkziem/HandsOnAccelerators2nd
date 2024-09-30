% longitudinal_matching_example.m, track for many Ts, V. Ziemann, 240828
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas; % synchrotron frequency
dt=3*Ts;     % or 100*Ts   % <--- set time here
N=1000;      % number of particles
x0=[0.0,0.0]; dx=[2,0.1];  % center and spread of distribution
phi=-pi:0.01:pi; separatrix=2*Omegas*cos(0.5*phi);
hold off; plot(phi,separatrix,'k',phi,-separatrix,'k')
axis([-pi,pi,-0.67,0.67]); hold on; pause(0.001)
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
  'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
text(-2.8,-0.57,['After ',num2str(dt/Ts),' T_s'],'fontsize',16)
tic
for k=1:N   % loop over particles
  x=x0+(rand(1,2)-0.5).*dx;  plot(x(1),x(2),'g.');
  x1=pendulumtracker(x,Omegas,dt); plot(x1(1),x1(2),'k.');
  pause(0.001)
end
toc