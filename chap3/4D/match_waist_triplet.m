% match_waist_triplet.m, V. Ziemann
clear; close all
global beamline sigma0
t1=dlmread('triplet_25.bl');
beamline=repmat(t1,1,1);
[Racc,spos,nmat,nlines]=calcmat(beamline); Rturn=Racc(:,:,end);
sigma0=periodic_beammatrix(Rturn,1,1);
negdrift=[1,4,-0.5,0];
beamline=[repmat(t1,3,1);negdrift];
f0=[3.6,-1.8,3.6,-1.8]; % starting guess
[f,fval]=fminsearch(@chisq_waist_triplet,f0)
drawmag(beamline,2,3)
plot_betas(beamline,sigma0); 
set(gca,'FontSize',16)
