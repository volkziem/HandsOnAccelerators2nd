% chisq_tunes.m, find focal length to set Qx and Qy of cell
function chisq=chisq_tunes_fodo(x)
global beamline      % need info about the beamline
beamline(3,4)=x(1); 
beamline(7,4)=x(2);
[Racc,spos]=calcmat(beamline);
Rturn=Racc(:,:,end); 
[Qx,alpha0x,beta0x,gamma0x]=R2beta(Rturn(1:2,1:2));
[Qy,alpha0y,beta0y,gamma0y]=R2beta(Rturn(3:4,3:4));
chisq=(Qx-0.273333)^2+(Qy-0.276666)^2; % desired tunes


