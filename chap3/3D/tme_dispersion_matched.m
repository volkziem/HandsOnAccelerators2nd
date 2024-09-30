% runme2.m
clear all; close 'all'

beamline=dlmread('tme.bl')
[Racc,spos,nmat,nlines]=calcmat(beamline);
Rturn=Racc(:,:,end)   % alias for full-turn matrix 

[Q,alpha0,beta0,gamma0]=R2beta(Rturn(1:2,1:2));
eps0=1; 
%sigma0=eps0*[beta0, -alpha0,0; -alpha0,gamma0,0;0,0,1]
sigma0=eps0*[beta0, -alpha0,0; -alpha0,gamma0,0;0,0,0]

for k=1:nmat
   sigma=Racc(:,:,k)*sigma0*Racc(:,:,k)';
   beta(k)=sigma(1,1);
end
plot(spos,beta,'k','LineWidth',2); %,spos,fliplr(beta),'k-.'); 
xlabel(' s[m]'); ylabel('\beta_x [m], D [cm]')
drawmag(beamline,0.5,1)
axis([0, max(spos), 0, 1.25*max(beta)])

hold on
D=(eye(2)-Rturn(1:2,1:2))\Rturn(1:2,3);
dd0=[D;1];  % initial periodic dispersion
for k=1:nmat
   eta(k)=100*Racc(1,:,k)*dd0;
end
plot(spos,eta,'k-.','LineWidth',2);
set(gca,'FontSize',16)