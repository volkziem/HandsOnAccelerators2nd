% match_to_waist.m, V. Ziemann, 240828
clear; close all
global beamline sigma0
beamline=dlmread('fodo6090.bl');
[Racc,spos,nmat,nlines]=calcmat(beamline); Rturn=Racc(:,:,end); 
sigma0=periodic_beammatrix(Rturn,1,1);
extra_drift=[1,5,0.2,0];
beamline=[repmat(beamline,3,1);extra_drift];
%...uncomment to change the positions
% beamline(11,2)=13;  % change quadrupole positions
% beamline(13,2)=2;
x0=[-1,2.,-2,2];
[x,fval]=fminsearch(@chisq_waist,x0)
drawmag(beamline,25,4)
plot_betas(beamline,sigma0); 
set(gca,'FontSize',16)