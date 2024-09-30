% chisq_waist.m, find focal length to set waist, V. Ziemann, 240828
function chisq=chisq_waist(x)
global beamline sigma0      % need info about the beamline
beamline(7,4)=x(1);         % set quadrupole focal lengths 
beamline(9,4)=x(2);
beamline(12,4)=x(3);        
beamline(14,4)=x(4);
[Racc,spos,nmat,nlines]=calcmat(beamline); Rend=Racc(:,:,end); 
sigma=Rend*sigma0*Rend';
chisq=(sigma(1,1)-1)^2+(sigma(3,3)-1)^2+sigma(1,2)^2+sigma(3,4)^2;