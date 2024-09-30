% match_doublet_symmetric.m
clear all; close all
global beamline
d1=dlmread('doublet.bl')
%beamline=d1; % repmat(dd,4,1);
%beamline=dlmread('test.bl');
beamline=repmat(d1,2,1)
[Racc,spos,nmat,nlines]=calcmat(beamline); Rend=Racc(:,:,end)
sigma0=periodic_beammatrix(Rend,1,1);
plot_betas(beamline,sigma0); drawmag(beamline,1,1)
Q=tunes(Rend)

if 0
    figure
    beamline=d1;
    f0=[3.44,-3.44];  % starting guess
    [f,fval]=fminsearch(@chisq_tunes_doublet,f0)
    [Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end)
    sigma0=periodic_beammatrix(Rend,1,1);
    plot_betas(beamline,sigma0); drawmag(beamline,1,1)
    Q=tunes(Rend)
    dlmwrite('matched.bl',beamline,'\t')
end
set(gca,'FontSize',16)


