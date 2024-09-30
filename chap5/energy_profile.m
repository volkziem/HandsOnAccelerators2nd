% energy_profile.m, V. Ziemann, 240828
clear; close all

degree=pi/180;        % convert degree to radian
c=3e8;                % speed of light in m/s
m_proton=938;         % proton mass in MeV
T=200;                % kinetic energy in MeV
ncell=30;             % number of cells
dgamma=50/m_proton;   % energy gain per section in units of rest mass
L=10;                 % section length in meter
f=2;                  % design quadrupole focal length
omega=2*pi*704e6;     % RF frequency
dpsi=75*degree;       % phase offset (for off-crest) for the cavities

%.......................................initial values
gstart=1+T/m_proton;  % gamma, energy       
phistart=0*degree;    % phase in radian

%.....................................set the gradients
g=dgamma*ones(1,ncell);   % cavity gradients in dV/mp 
psi=zeros(1,ncell);       % cavity phases
phi=zeros(1,ncell);       % phase just before accelerating structure
gamma=zeros(1,ncell);     % energy just after accelerating structure
trasta=zeros(1,ncell);    % trace of transfer matrix
emitgrowth=zeros(1,ncell);% emittance growth
z=L*(1:ncell);
%
% calculate the periodic beta functions for the double cell
%
R=celltm(4.5,1,f);
[beta0,alpha0,phirad]=R2beta(R);
% 
% first determine the optimum phases to get the maximum energy gain
% this means that all effective phases (the argument of the cosine) 
% are zero and this depends on the arrival time in the cavity which
% in turn depends on the energy accumulated up to just after the
% previous acceleration section.
%
% broken cavities
g(14:17)=0.1*g(14:17);
%
phi(1)=0; % set initial arrival phase to optimum, on-crest
psi(1)=-dpsi;
gamma(1)=gstart+g(1)*cos(phi(1)-psi(1));
for k=2:ncell
   phi(k)=phi(k-1)+(omega*L/c)/sqrt(1-1/gamma(k-1)^2); 
   phi(k)=rem(phi(k),2*pi);
   psi(k)=phi(k)-dpsi;
   gamma(k)=gamma(k-1)+g(k)*sin(phi(k)-psi(k));
end
kinetic_energy=m_proton*(gamma-1);
final_kinetic_energy=m_proton*(gamma(ncell)-1);
% save the nominal energy profile
ke0=kinetic_energy;
gamma0=gamma;
psi0=psi;

%....................display the nominal conditions
subplot(4,1,1)
plot(z,g*m_proton,'k','LineWidth',2); 
ylim([0, 55]); ylabel('Gain [MV]'); set(gca,'FontSize',16);
subplot(4,1,2)
plot(z,psi/degree,'k',z,phi/degree,'k:',z,(phi-psi)/degree,'k-.','LineWidth',2);
ylabel('\psi, \phi [degree]'); set(gca,'FontSize',16);
subplot(4,1,3)
plot(z,kinetic_energy,'k','LineWidth',2); 
ylabel('kinetic Energy [MeV]'); set(gca,'FontSize',16);
subplot(4,1,4)
plot(z,sqrt(gamma.^2-1),'k','LineWidth',2)
xlabel('z [m]'); 
ylabel('\beta\gamma'); set(gca,'FontSize',16);