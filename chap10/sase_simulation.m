% sase_simulation.m, FEL simulation, V. Ziemann, 240829
clear; close all
addpath /home/ziemann/matlab/elliptic    % needed for elliptic12
a0=1e-8; phi=0; a=a0*exp(1i*phi);    % initial amplitude and phase of laser
jcurr=200;                         % scaled current from Equation 10.32
x0=[pi/2,0]; dx=[2*pi,0.1];      % center and spread of distribution
N=1000;                          % number of particles
Omegas=sqrt(a0);                 % synchrotron frequency
axis_scale=[-pi/2,3*pi/2,-17,17];
ypos=0.95*axis_scale(3)+0.05*axis_scale(4); % where to place text
zeta=-pi/2:0.01:3*pi/2; separatrix=2*Omegas*cos(0.5*(zeta-pi/2+phi));
figure('Name','FEL phase space')
hold off; plot(zeta,separatrix,'k',zeta,-separatrix,'k')
axis(axis_scale); xlabel('\zeta'); ylabel('\nu')
set(gca,'xtick',[-pi/2,0,pi/2,pi,3*pi/2],'fontsize',14, ...
  'xticklabels',{'-\pi/2','0','\pi/2','\pi','3\pi/2'})
hold on;
x1(:,1)=x0(1)+(rand(N,1)-0.5)*dx(1); % initial distribution
x1(:,2)=x0(2)+(rand(N,1)-0.5)*dx(2); 
plot(x1(:,1),x1(:,2),'g.')
title('Initial Distribution')
pause(1); 
nstep=100; dt=1/nstep; tau=(1:nstep)/nstep; % steps along the undulator
tic; data=zeros(nstep,4);  % storage for plot data
for m=1:nstep
  hold off; % draw new image
  Omegas=sqrt(abs(a)); phi=angle(a);  % needed for electron dynamics
  separatrix=2*Omegas*cos(0.5*(zeta-pi/2+phi));
  plot(zeta,separatrix,'k',zeta,-separatrix,'k'); 
  set(gca,'xtick',[-pi/2,0,pi/2,pi,3*pi/2],'fontsize',14, ...
    'xticklabels',{'-\pi/2','0','\pi/2','\pi','3\pi/2'}) 
  axis(axis_scale); xlabel('\zeta'); ylabel('\nu')
  hold on
  parfor k=1:N   % update electron phase space, use "for" or "parfor"
    x1(k,:)=pendulumtracker2_phase(x1(k,:),Omegas,phi,dt);
  end
  plot(x1(:,1),x1(:,2),'r.'); 
  bf=sum(exp(-1i*x1(:,1)))/size(x1,1);  % bunching factor <exp(-i*zeta)>
  a=a-jcurr*bf*dt;                     % update laser field, Eq. 10.32
  text(-1.4,ypos,['bf = ',num2str(bf,'%6.3f'),' '],'fontsize',16) 
  text(pi,ypos,['\tau = ',num2str(tau(m),4),' '],'fontsize',16) 
  data(m,1)=abs(a);
  data(m,2)=angle(a)*180/pi;
  data(m,3)=abs(bf);
  data(m,4)=(abs(a)-a0)/a0;
  title([' abs(a) = ',num2str(abs(a),3),'  gain = ' num2str(data(m,4),3)])
  pause(0.01)
end
toc; growth_theo=0.5*sqrt(3)*(jcurr/2)^(1/3);
mm=0.3*nstep:nstep; p=polyfit(tau(mm)',log(data(mm,1)),1);
growth_rate=p(1);
figure('Name','Parameters along undulator')
% second figure with evolution along the undulator tau=s/L
subplot(4,1,1); plot(tau,data(:,1),'k'); ylabel('abs(a)');
title(['Growth rate [theo/exp] = ',num2str(growth_theo,3),' / ', ...
  num2str(growth_rate,3)])
subplot(4,1,2); plot(tau,data(:,2),'k'); ylabel('phase(a) [deg]');
subplot(4,1,3); plot(tau,data(:,3),'k'); ylabel('<exp(-i\zeta)>');
subplot(4,1,4); plot(tau,data(:,4),'k'); ylabel('Gain');
xlabel('\tau = s/L_u')