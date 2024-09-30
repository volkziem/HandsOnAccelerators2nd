% dispersion_suppressor.m
clear all; close all;
global beamline
fodo=dlmread('fodo90.bl');
fodods=dlmread('fodo90ds.bl');
beamline=fodods;
%beamline=repmat(fodo,4,1);

[Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end);
%plot(spos,reshape(Racc(1,1,:),1,nmat))
sigma0=periodic_beammatrix(Rend,1,1);
plot_betas(beamline,sigma0); drawmag(beamline,1,1)
Q=tunes(Rend)


if 0    % match the tunes
    beamline=fodo;
    f0=[10,-5]; % starting guess
    [f,fval]=fminsearch(@chisq_tunes_fodo90,f0)
    figure
    [Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end);
    %plot(spos,reshape(Racc(1,1,:),1,nmat))
    sigma0=periodic_beammatrix(Rend,1,1);   
    plot_betas(beamline,sigma0); drawmag(beamline,1,1)
    Q=tunes(Rend)
    dlmwrite('matched.bl',beamline,'\t')
end