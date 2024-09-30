% braggpeak.m, depth-dose of proton in water, V. Ziemann, 240829
clear; close all
me=0.511;           % electron mass in MeV
mp=938.3;           % proton mass in MeV
Z=1;                % proton charge
Zt=10;              % H2O has 8+2=10 electrons 
At=18;              % Atomic mass of Oxygen and two hydrogen atoms
rho=1;              % density of water
II=16e-6*Zt^0.9;    % ionization energy in MeV approximately
dx=0.1;             % step size =0.01 cm
x=0;                % starting position
T=200;              % Initial kinetic energy of protons
loss=zeros(200,1); xx=loss; TT=loss;
ic=1;
while T>0
  ic=ic+1;
  gamma=1+T/mp;
  beta=sqrt(1-1./gamma.^2); 
  Wmax=2*me*beta.^2.*gamma.^2;
  dEdx=0.307.*Z.^2*(Zt./At).*(1./beta.^2).*(log(Wmax./II)-beta.^2)*rho;
  loss(ic)=dEdx*dx;
  T=T-loss(ic);
  xx(ic)=xx(ic-1)+dx;  
  TT(ic)=T;
  % [ic,xx(ic),loss(ic)];
end
ic=ic+1;  xx(ic)=xx(ic-1)+dx; loss(ic)=0; TT(ic)=0;
loss(1)=loss(2); TT(1)=TT(2);
plot(xx,loss,'k',xx,TT/20,'k--','LineWidth',2)
xlabel('z [cm]'); ylabel('dE/dz [MeV/mm]')
legend('dE/dz [MeV/mm]','kin. Energy T/20 [MeV]')
ylim([0,9.2]); set(gca,'FontSize',20)
