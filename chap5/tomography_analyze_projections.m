% tomography_analyze_projections.m, V. Ziemann, 240828
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas; dt=0.05*Ts;  % must match values in
xbins=-pi:pi/128:pi; nbin=length(xbins);  % the above function
projections=dlmread('projections.dat');
nstep=size(projections,2); 
%.................reconstruct from projections
dp=-1:0.01:1; dpbin=length(dp);  % the vertical "spread"
im=zeros(nbin,dpbin);  % reconstructed initial phase space image
for m=1:nstep
  for kbin=1:nbin
    if projections(kbin,m)==0, continue; end % abort, if empty
    x1=[xbins(kbin)*ones(dpbin,1),dp'];
    parfor n=1:dpbin  % spread out "vertically"
      x1(n,:)=pendulumtracker(x1(n,:),Omegas,-(m-1)*dt); % back-propagate
    end
    N=histcounts2(x1(:,1),x1(:,2),centers2edges(xbins),centers2edges(dp));
    im=im+N*projections(kbin,m);
  end
  contourf(xbins,dp,im')
  set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
     'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
  title(['Projection ',num2str(m),' of ',num2str(nstep)]);
  pause(0.2)
end
figure(2); % display the projections
subplot(2,1,1); plot(xbins,sum(im,2),'k'); xlim([-pi,pi]);
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',14, ...
     'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
subplot(2,1,2); plot(dp,sum(im,1),'k')