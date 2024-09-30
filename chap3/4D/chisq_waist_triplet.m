% chisq_waist_triplet.m, fit waist, V. Ziemann, 240828
function chisq=chisq_waist_triplet(x)
global beamline sigma0      % need info about the beamline
beamline(9,4)=x(1); beamline(11,4)=x(2); beamline(13,4)=x(1);
beamline(16,4)=x(3); beamline(18,4)=x(4); beamline(20,4)=x(3);        
[Racc,spos,nmat]=calcmat(beamline); Rend=Racc(:,:,end); 
sigma=Rend*sigma0*Rend';
chisq=(sigma(1,1)-0.5)^2+(sigma(3,3)-0.5)^2+sigma(1,2)^2+sigma(3,4)^2;