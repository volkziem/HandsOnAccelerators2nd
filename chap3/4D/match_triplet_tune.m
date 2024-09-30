% match_triplet_tune.m, match triplet cell, V. Ziemann, 240828 
clear; close all
global beamline sigma0
beamline=dlmread('triplet.bl');
f0=[3.6,-1.8];    % starting guess
[f,fval]=fminsearch(@chisq_tune_triplet,f0)
[Racc,spos]=calcmat(beamline); Rturn=Racc(:,:,end);
sigma0=periodic_beammatrix(Rturn,1,1);   
plot_betas(beamline,sigma0); 
drawmag(beamline,1,1);
set(gca,'FontSize',16)
dlmwrite('triplet_25.bl',beamline,'\t')