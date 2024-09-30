% chisq_tunes.m, find focal length to set Qx and Qy of cell, VZ, 240828
function chisq=chisq_tunes(x)
global beamline      % need info about the beamline
beamline(2,4)=x(1);  % change quadrupole excitations
beamline(4,4)=x(2);
[Racc]=calcmat(beamline);
Rturn=Racc(:,:,end); 
[Qx,alpha0x,beta0x,gamma0x]=R2beta(Rturn(1:2,1:2));
[Qy,alpha0y,beta0y,gamma0y]=R2beta(Rturn(3:4,3:4));
chisq=(Qx-0.166666)^2+(Qy-0.25)^2; % desired tunes


