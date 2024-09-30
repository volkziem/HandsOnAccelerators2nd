% match3.m, match the tunes for a doublet
clear all; close all
global beamline

if 0
bendangle=15;
field=bendangle*pi*1.0/(180*0.299792458*2.0);
fodo=[ 4  4  0.5  field     0  1.0;  
       3  3  0.5  0         0  1.0; 
       5  4  0.25 0.632     0  1.0; 
       3  3  0.5  0         0  1.0; 
       4  4  0.5  field     0  1.0; 
       3  3  0.5  0         0  1.0; 
       5  4  0.25 -0.855     0  1.0; 
       3  3  0.5  0         0  1.0;];
%beamline=repmat(fodo,12,1);
beamline=fodo;
end
fodo=dlmread('fodo90_lhc_tunes.bl');
beamline=repmat(fodo,12,1);

[Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end)
sigma0=periodic_beammatrix(Rend,1,1);
plot_betas(beamline,sigma0); drawmag(beamline,1,1)
Q=tunes(Rend)

if 0
    figure
    beamline=fodo;
    f0=[0.6,-0.8];  % starting guess
    [f,fval]=fminsearch(@chisq_tunes_fodo90,f0)
    [Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end)
    sigma0=periodic_beammatrix(Rend,1,1);
    plot_betas(beamline,sigma0); drawmag(beamline,1,1)
    Q=tunes(Rend)
    dlmwrite('matched.bl',beamline,'\t')
end



