% chisq_tunes_doubletb.m, fit douplet cell, V. Ziemann, 240828
function chisq=chisq_tunes_doubletb(x)
global beamline      % need info about the beamline
beamline(2,4)=x(1); 
beamline(4,4)=x(2);
beamline(7,4)=x(2);
beamline(9,4)=x(1); 
[Racc,spos,nmat]=calcmat(beamline);
Rturn=Racc(:,:,end); 
[Qx,alpha0x,beta0x,gamma0x]=R2beta(Rturn(1:2,1:2));
[Qy,alpha0y,beta0y,gamma0y]=R2beta(Rturn(3:4,3:4));
chisq=(Qx-0.4)^2+(Qy-0.4)^2; % desired tunes


