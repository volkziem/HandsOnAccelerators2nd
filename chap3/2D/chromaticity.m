% chromaticity.m, V. Ziemann, 240827
clear; close all
ndim=2;  % 2 for 2x2 matrices
F=2.1;   % focal length of the quadrupoles
fodo=[ 1,  5,  0.2,  0;    % 5* D(L/10)
	     2,  1,  0.0, -F;    % QD
	     1, 10,  0.2,  0;    % 10* D(L/10)  
	     2,  1,  0.0,  F;    % QF/2
       1,  5,  0.2,  0];   % 5* D(L/10)  
beamline=repmat(fodo,20,1);    % name must be 'beamline' 

[Racc,spos,nmat,nlines]=calcmat(beamline);
Rturn=Racc(:,:,end);

[Q,alpha0,beta0,gamma0]=R2beta(Rturn);
eps0=1; sigma0=eps0*[beta0, -alpha0; -alpha0,gamma0];
beta=zeros(1,nmat);
for k=1:nmat   % calculate beta functions
   sigma=Racc(:,:,k)*sigma0*Racc(:,:,k)';
   beta(k)=sigma(1,1);
end
xi=0;  % initialize chromaticity
ic=1;                          
for line=1:nlines               
  for seg=1:beamline(line,2)
    ic=ic+1;
    if beamline(line,1)==2
      xi=xi-beta(ic)/(4*pi*beamline(line,4));
    end
  end
end
disp(['Chromaticity = ' num2str(xi,4)])