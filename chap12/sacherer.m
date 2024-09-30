% sacherer.m, integrate sacherer equations, V. Ziemann, 240829
% x(1)=sigx, x(2)=sigx', x(3)=sigy, x(4)=sigy'
clear; close all
global epsx epsy Kperv             % needed in sachfun.m
epsx=1e-6; epsy=1e-6; Kperv=5e-8;  % parameters 
betax=10.19292; alphax=-1.238978;  % initial values
betay=10.19292; alphay=1.238978;
x0=zeros(4,1);                     % initial sigmas
x0(1)=sqrt(epsx*betax);            % sigmax
x0(2)=-alphax*sqrt(epsx/betax);    % sigmax'
x0(3)=sqrt(epsy*betay);            % sigmay
x0(4)=-alphay*sqrt(epsy/betay);    % sigmay'
[s,x]=ode45(@sachfun,[0,100],x0,odeset('MaxStep',1e-2));
plot(s,1e3*x(:,1),'k',s,1e3*x(:,3),'k--','LineWidth',2)
ylim([2.3,4.7])
xlabel('s [m]'); ylabel('\sigma_x,\sigma_y [mm]')
legend('\sigma_x','\sigma_y')
set(gca,'FontSize',16)