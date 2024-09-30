% display_beta_beating.m, V. Ziemann, 240828
clear; close all
fodo=dlmread('fodo.bl');
fodor=dlmread('fodoroll.bl');
beamline=fodo;
[Racc,spos,nmat,nlines]=calcmat(beamline);
Rturn=Racc(:,:,end);
[Qx,alpha0x,beta0x,gamma0x]=R2beta(Rturn(1:2,1:2));
[Qy,alpha0y,beta0y,gamma0y]=R2beta(Rturn(3:4,3:4));
eps0=1; %e-6;    % 1 mm*mrad
sigma0x=eps0*[beta0x, -alpha0x; -alpha0x,gamma0x];
sigma0y=eps0*[beta0y, -alpha0y; -alpha0y,gamma0y];
sigma0=[sigma0x,zeros(2);zeros(2),sigma0y]
beamline=[fodo;fodor;repmat(fodo,6,1)];  % perturbed beam line
plot_betas(beamline,sigma0)
