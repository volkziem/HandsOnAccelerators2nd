% bethebloch.m, V. Ziemann, 240829
clear; close all
me=0.511;                        % electron mass in MeV
gamma=logspace(0.02,3,300);      % range of energies
beta=sqrt(1-1./gamma.^2);        % speed beta=v/c
bg=beta.*gamma;                  
Wmax=2*me*beta.^2.*gamma.^2;     % max kinetic energy of electron
Z=1;                             % proton beam

%.....................Lithium
rho =0.534;       % g/cm^3
Zt=3;             % number of electrons
At=6.94;          % mass number of atom 
II=16e-6*Zt^0.9;  % ionization energy in MeV
dEdxLi=0.307.*Z.^2*(Zt./At).*(1./beta.^2).*(log(Wmax./II)-beta.^2);%.*rho;

%.....................frozen Hydrogen (Pellet target)
rho =0.0708;      % g/cm^3
Zt=1;             % number of electrons
At=1;             % mass number of atom 
II=16e-6*Zt^0.9;  % ionization energy in MeV
dEdxH=0.307.*Z.^2*(Zt./At).*(1./beta.^2).*(log(Wmax./II)-beta.^2);%.*rho;

%.....................Tungsten or Wolfram
rho =19.3;        % g/cm^3
Zt=74;            % number of electrons
At=183.84;        % mass number of atom 
II=16e-6*Zt^0.9;  % ionization energy in MeV
dEdxW=0.307.*Z.^2*(Zt./At).*(1./beta.^2).*(log(Wmax./II)-beta.^2);%.*rho;

%....................Water
Zt=10;    % H2O has 8+2=10 electrons 
At=18;    % Atomic mass of Oxygen and two hydrogen atoms
rho=1;    % density of water
%.........................

semilogx(bg,dEdxH,'k-.',bg,dEdxLi,'k',bg,dEdxW,'k--','LineWidth',2)
xlim([0.3,1000]); ylim([0,14]);
xlabel('\beta\gamma'); ylabel('dE/\rhodx [MeV/(g/cm^2)]')
legend('frozen Hydrogen (H)','Lithium (Li)','Tungsten (W)')
set(gca,'FontSize',20)
