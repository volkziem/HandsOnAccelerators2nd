% match_doublet_antisymmetric.m, V. Ziemann
clear all; close all
global beamline
d1=dlmread('doublet_antisymmetric.bl');
beamline=d1; % repmat(dd,4,1);
%beamline=repmat(beamline,2,1);
% [Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end)
% sigma0=periodic_beammatrix(Rend,1,1);
% plot_betas(beamline,sigma0); drawmag(beamline,1,1)
% Q=tunes(Rend)

if 1
    figure
    beamline=dlmread('doublet_antisymmetric.bl');
    f0=[3.44,-3.44];  % starting guess
    [f,fval]=fminsearch(@chisq_tunes_doubletb,f0)
    [Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end)
    sigma0=periodic_beammatrix(Rend,1,1);
    plot_betas(beamline,sigma0); drawmag(beamline,1,1)
    Q=tunes(Rend)
    dlmwrite('matched.bl',beamline,'\t')
end
set(gca,'FontSize',16)