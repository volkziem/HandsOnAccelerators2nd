% fulham3.m, V. Ziemann, 240829
% calculate the Hamiltonian H0 for the beamline
% calcmat must be called beforehand for the transfer matrices
function H0=fulham3(beamline)
nlines=size(beamline,1);  H0=zeros(14,1);
for k=nlines:-1:1
  if (beamline(k,1)>1000)        % its a nonlinearity
    M=beamline(k,1)-1000;        % order of non-linearity
    Htmp=thamlie(beamline(k,4),M);
    R=TM(k,nlines);               % TM to the end
    Htmp=propham3(R,Htmp);        % propagate hamiltonian
    H0=CBH(Htmp,H0);              % concatenate with what is already there 
  end
end
