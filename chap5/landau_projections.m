% landau_projections.m, initial and final projections, V. Ziemann, 240828
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas; % synchrotron frequency
dt=100*Ts;     % time step
N=1000;      % number of particles
x0=[0.0,0.4]; dx=[0.3,0.1];  % center and spread of distribution
xx=zeros(N,2); xx1=xx;
for k=1:N   % loop over particles
  xx(k,:)=x0+(rand(1,2)-0.5).*dx; 
  xx1(k,:)=pendulumtracker(xx(k,:),Omegas,dt);
end
subplot(2,1,1)
histogram(xx(:,1),-pi:pi/40:pi); hold on; histogram(xx1(:,1),-pi:pi/40:pi);
xlim([-pi,pi])
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
  'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('\phi')
subplot(2,1,2)
histogram(xx(:,2),-0.5:0.02:0.5); hold on; histogram(xx1(:,2),-0.5:0.01:0.5);
xlabel('$\dot\phi$','interpreter','latex')
set(gca,'fontsize',14) 