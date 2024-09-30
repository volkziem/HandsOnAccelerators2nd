% dispersion_matched.m
clear; close 'all'
fodo=[ 1  5  0.5  0  ; 
       5  5  0.2 -0.1799; 
       1  3  0.5  0  ; 
       4  10 0.2  20/10 ; 
       1  3  0.5  0  ; 
       5  5  0.2  0.1799; 
       1  5  0.5  0  ];
beamline=repmat(fodo,1,1);
  
[Racc,spos,nmat,nlines]=calcmat(beamline);
Rturn=Racc(:,:,end)   % alias for full-turn matrix 

[Q,alpha0,beta0,gamma0]=R2beta(Rturn(1:2,1:2));
eps0=1; 
%sigma0=eps0*[beta0, -alpha0,0; -alpha0,gamma0,0;0,0,1]
sigma0=eps0*[beta0, -alpha0,0; -alpha0,gamma0,0;0,0,0]

beta=zeros(1,nmat); % allocate space for plotting
for k=1:nmat
   sigma=Racc(:,:,k)*sigma0*Racc(:,:,k)';
   beta(k)=sigma(1,1);
end
plot(spos,beta,'k','LineWidth',2); %,spos,fliplr(beta),'k-.'); 
xlabel(' s[m]'); ylabel('\beta_x, D [m]')
drawmag(beamline,0.5,1)
axis([0, max(spos), 0, 1.05*max(beta)])

hold on
D=(eye(2)-Rturn(1:2,1:2))\Rturn(1:2,3);
dd0=[D;1];  % initial periodic dispersion
eta=zeros(1,nmat); % allocate space for plotting
for k=1:nmat
   eta(k)=Racc(1,:,k)*dd0;
end
plot(spos,eta,'k-.','LineWidth',2);
set(gca,'FontSize',16)