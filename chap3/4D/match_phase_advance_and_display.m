% match_phase_advance_and_display.m, V. Ziemann, 240828
clear; close all
global beamline
beamline=dlmread('fodo.bl');
x0=[-3,3.];  % starting guesses
[x,fval]=fminsearch(@chisq_tunes,x0)   % matching
dlmwrite('fodo6090.bl',beamline,'\t'); % save to file
[Racc,spos,nmat,nlines]=calcmat(beamline); 
Rturn=Racc(:,:,end); 
sigma0=periodic_beammatrix(Rturn,1,1);
plot_betas(beamline,sigma0); set(gca,'FontSize',16)
