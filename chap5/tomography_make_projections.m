% tomography_make_projections.m, V. Ziemann, 240828
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas; dt=0.05*Ts;  
N=1000;                      % number of particles
x0=[1.0,0.3]; dx=[0.3,0.1];  % center and spread of distribution
x1=zeros(N,2); 
for k=1:N  % initial distribution
  x1(k,:)=x0+(rand(1,2)-0.5).*dx; 
end
nstep=20; xbins=-pi:pi/128:pi;
projections=zeros(length(xbins),nstep); % allocate space
projections(:,1)=hist(x1(:,1),xbins);   % save initial projection
for m=1:nstep-1
  subplot(2,1,1); hold off; 
  phi=-pi:0.01:pi; separatrix=2*Omegas*cos(0.5*phi);
  plot(phi,separatrix,'k',phi,-separatrix,'k');
  hold on
  parfor k=1:N 
    x1(k,:)=pendulumtracker(x1(k,:),Omegas,dt);
  end
  plot(x1(:,1),x1(:,2),'r.')
  axis([-pi,pi,-0.67,0.67]);
  set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
     'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
  projections(:,m+1)=hist(x1(:,1),xbins);  
  subplot(2,1,2); bar(xbins,projections(:,m+1)); xlim([-pi,pi])
  set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
     'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
  pause(0.001)
end
dlmwrite('projections.dat',projections,'\t');
