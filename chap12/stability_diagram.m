% dispersion_relation.m, V. Ziemann, 240829
clear; close all
% dispersion integral for gaussians
ID=@(xi1)1+1i*sqrt(pi/2).*xi1.*Faddeeva_w(xi1/sqrt(2));

xi1=-3.3:0.1:3.3;      % range of 'frequencies'
z=ID(xi1); u=real(1i./z); v=imag(1i./z);

xi2=xi1-1i*0.03;        % add a little damping, Im(Omega)>0 --> Im(xi1<0
z=ID(xi2); u2=real(1i./z); v2=imag(1i./z);

phi=0:2*pi/100:2*pi;   % for Keil-Schnell circle

plot(u,v,'k',u2,v2,'k--',sin(phi),cos(phi),'k:','LineWidth',2)
xlabel('U'); ylabel('V');
legend('Real frequency \Omega','and with small Im(\Omega)>0','Keil-Schnell circle')
%ylim([-1.2,6.2])
ylim([-6.2,1.2])
set(gca,'FontSize',16)

