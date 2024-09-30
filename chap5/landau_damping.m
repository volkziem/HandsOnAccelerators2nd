% landau_damping.m, V. Ziemann, 240828
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas; % synchrotron frequency
dt=0.05*Ts;     % time step
N=20;           % number of particles
x0=[0.0,0.4]; dx=[0.3,0.1];  % center and spread of distribution
phi=-pi:0.01:pi; separatrix=2*Omegas*cos(0.5*phi);
hold off; plot(phi,separatrix,'k',phi,-separatrix,'k')
axis([-pi,pi,-0.67,0.67]); hold on; pause(0.001)
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
  'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
text(-2.8,-0.57,['After ',num2str(dt/Ts),' T_s'],'fontsize',16)
xx=zeros(N,2); xx1=xx;
for k=1:N   % loop over particles
  xx(k,:)=x0+(rand(1,2)-0.5).*dx;  plot(xx(k,1),xx(k,2),'g.');
  xx1(k,:)=pendulumtracker(xx(k,:),Omegas,dt);
end

M=500; % number of time steps
phase=zeros(1,M); eta=phase;
phase(1)=mean(xx(:,1)); eta(1)=mean(xx(:,2));
for steps=2:M
  for k=1:N 
    xx1(k,:)=pendulumtracker(xx(k,:),Omegas,dt);
  end
  xx=xx1;
  phase(steps)=mean(xx1(:,1)); eta(steps)=mean(xx1(:,2));
  disp([num2str(steps),' : ' num2str(phase(steps))])
end
hold off
plot((1:M)*dt/Ts,phase,'k',(1:M)*dt/Ts,eta,'k-.');
xlabel('t/T_s'); 
ylabel('\langle\phi\rangle and \langle\eta\rangle')
set(gca,'ytick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
  'yticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})

figure(2)
subplot(2,1,1); plot((1:M)*dt/Ts,phase,'k','LineWidth',2);
xlabel('t/T_s'); ylabel('\langle\phi\rangle')
set(gca,'fontsize',14) 
subplot(2,1,2); plot((1:M)*dt/Ts,eta,'k','LineWidth',2);
xlabel('t/T_s'); ylabel('$\langle\dot\phi\rangle$','interpreter','latex')
set(gca,'fontsize',14) 