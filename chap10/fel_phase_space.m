% fel_phase_space.m, V. Ziemann, 240829
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas;
dt=0.1*Ts;
phi=-pi:0.01:pi;
separatrix=2*Omegas*cos(0.5*phi);
hold off; plot(phi,separatrix,'k',phi,-separatrix,'k')
axis([-pi,pi,-0.7,0.7]); hold on; pause(0.001)
eta0=[0,0.4];
phi=-pi:0.1:pi;    % fewer points
hold on
for m=1:length(eta0)
  for k=1:length(phi)
    switch m
      case 1
        plot(phi(k),eta0(m),'k+') 
      case 2
        plot(phi(k),eta0(m),'k*')      
    end   
    x=pendulumtracker([phi(k),eta0(m)],Omegas,dt);
    switch m
      case 1
        plot(x(1),x(2),'k+')  
      case 2
        plot(x(1),x(2),'k*') 
    end
    pause(0.001)
  end
end
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
  'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel('\psi'); 
ylabel('$$\dot\psi$$','interpreter','latex')
set(gca,'FontSize',16)