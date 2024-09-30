% one_synchrotron_period.m, V. Ziemann, 240828
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas; dt=0.01*Ts;
phi=-pi:0.01:pi; separatrix=2*Omegas*cos(0.5*phi);
hold off; plot(phi,separatrix,'k',phi,-separatrix,'k')
axis([-pi,pi,-0.67,0.67]); hold on; pause(0.001)
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
  'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
for phidot=0.09:0.1:0.6
  x=[0.0,phidot];    %  initial value
  plot(x(1),x(2),'k.')
  for k=1:100
    x=pendulumtracker(x,Omegas,dt);
    plot(x(1),x(2),'k.'); pause(0.001)
  end
end
xlabel('\phi');  ylabel('$\dot\phi$','interpreter','latex')

