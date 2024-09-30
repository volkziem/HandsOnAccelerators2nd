% dispersion_supppressor.m, V. Ziemann, 240828
clear; close all;
global beamline
fodo=dlmread('fodo90.bl');
fodods=dlmread('fodo90ds.bl');
beamline=fodo;
[Racc,spos,nmat]=calcmat(beamline); Rend=Racc(:,:,end);
D0=periodic_dispersion(Rend);
beamline=[fodo;repmat(fodods,2,1)];
[Racc,spos]=calcmat(beamline); Rend=Racc(:,:,end);
D=calculate_dispersion(beamline,D0);
plot(spos,D,'k','LineWidth',2); drawmag(beamline,0.2,0.2)
xlim([0,36.1]); xlabel(' s[m]'); ylabel('D_x [m]');
set(gca,'FontSize',16)