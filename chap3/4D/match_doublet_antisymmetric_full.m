% match_doublet_antisymmetric_full.m, V. Ziemann, 240828
clear; close all
global beamline
beamline=dlmread('doublet.bl');
beamline=repmat(beamline,2,1);
f0=[3.44,-3.44];  % starting guess
[f,fval]=fminsearch(@chisq_tunes_doubletb,f0)
[Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end)
sigma0=periodic_beammatrix(Rend,1,1);
drawmag(beamline,1,1); plot_betas(beamline,sigma0); 
set(gca,'FontSize',16)
Q=tunes(Rend)
