% chisq_R12.m, fit for matrix element, V. Ziemann, 240828
function chisq=chisq_R12(f)
global beamline
beamline(2,4)=f;
[Racc,spos,nmat,nlines]=calcmat(beamline);
chisq=Racc(1,2,end)^2;