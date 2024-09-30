clear all, close all
tme=[1, 20, 0.1, 0;
     2,  1,   0, -1.8118831636;
     1, 10, 0.1, 0;
     2,  1,   0,  1.1052411846;
     1, 10, 0.1, 0;
     4, 10, 0.2, 0.29109;
     1, 10, 0.1, 0;
     2,  1,   0,  1.1052411846;
     1, 10, 0.1, 0;
     2,  1,   0, -1.8118831636; 
     1, 20, 0.1, 0];
beamline=tme; 
 
[Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end);
sigma0=periodic_beammatrix(Rend,1,1);
plot_betas(beamline,sigma0); drawmag(beamline,1,1)
Q=tunes(Rend)
set(gca,'FontSize',16)
 
dlmwrite('tme.bl',tme,'\t')