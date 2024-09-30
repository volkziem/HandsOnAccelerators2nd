% 60 degree fodo lattice with 10m cell length
clear all; close all;
global beamline
fodo=[	3  20   0.1     0       0	1;
        5	4	0.25   	0.7168 	0	1;
        3	8	0.5     0       0	1;
        5	4	0.25   -0.7168   0	1;
        3	4	0.5     0       0	1];
beamline=repmat(fodo,1,1); 
beamline=fodo;

[Racc,spos]=calcmat(beamline);
Rturn=Racc(:,:,end);  
nmat=length(spos);

[Qx,alpha0x,beta0x,gamma0x]=R2beta(Rturn(1:2,1:2));
[Qy,alpha0y,beta0y,gamma0y]=R2beta(Rturn(3:4,3:4));
eps0=1e-6;    % 1mm*mrad
sigma0x=eps0*[beta0x, -alpha0x; -alpha0x,gamma0x];
sigma0y=eps0*[beta0y, -alpha0y; -alpha0y,gamma0y];
sigma0=[sigma0x,zeros(2);zeros(2),sigma0y];
plot_sigmas(beamline,sigma0); drawmag(beamline,0.7e-3,1e-3)

if 0
    figure
    beamline=fodo;
    f0=[0.6,-0.8];  % starting guess
    [f,fval]=fminsearch(@chisq_tunes_space_charge,f0)
    [Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end);
    sigma0=periodic_beammatrix(Rend,1,1);
    plot_betas(beamline,sigma0); drawmag(beamline,1,1)
    Q=tunes(Rend)
    dlmwrite('matched_space_charge.bl',beamline,'\t')
end