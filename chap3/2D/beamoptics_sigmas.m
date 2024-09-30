% beamoptics_sigmas.m, V. Ziemann, 240827
clear; close all
ndim=2;  % 2 for 2x2 matrices
F=2.1;   % focal length of the quadrupoles
fodo=[ 1,  5,  0.2,  0;    % 5* D(L/10)
	     2,  1,  0.0, -F;    % QD
	     1, 10,  0.2,  0;    % 10* D(L/10)  
	     2,  1,  0.0,  F;    % QF/2
       1,  5,  0.2,  0];   % 5* D(L/10)  
beamline=repmat(fodo,1,1); % name must be 'beamline' 
[Racc,spos,nmat]=calcmat(beamline);  % just to find periodic betas
Rturn=Racc(:,:,end);

[Q,alpha0,beta0,gamma0]=R2beta(Rturn);
eps0=1; sigma0=eps0*[beta0, -alpha0; -alpha0,gamma0];
%sigma0=[4,0;0,1];  % mess up the initial beam matrix

beamline=repmat(fodo,20,1);   % and now for the long beam line  
beta=zeros(1,nmat);
[Racc,spos,nmat]=calcmat(beamline);
for k=1:nmat
   sigma=Racc(:,:,k)*sigma0*Racc(:,:,k)';
   beta(k)=sqrt(sigma(1,1));
end

plot(spos,beta,'k','LineWidth',2);
xlabel(' s[m]'); ylabel('\sigma_x [mm]')
axis([0, spos(end), 0, 1.05*max(beta)])
set(gca,'FontSize',16)
