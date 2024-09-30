% lithium_target.m, V. Ziemann, 240829
clear; close all
me=0.511;           % electron mass in MeV
Z=1;
mp=938.3;     % proton mass
T=100;        % proton beam kinetic energy
gamma=1+T/mp;
beta=sqrt(1-1./gamma.^2);
Wmax= 2*me*beta.^2.*gamma.^2;  

Zt=3;         % lithium charge
At=6.94;      % lithium mass
rho=0.534;    % lithium density in g/cm^3
dx=0.2;       % thickness in cm
II=16e-6*Zt^0.9; % in MeV
dEdx=0.307.*Z.^2*(Zt./At).*(1./beta.^2).*(log(Wmax./II)-beta.^2).*rho
dE=dEdx*dx % in MeV

xi=0.1534*(Z^2/beta^2)*(Zt/At)*rho*dx; % in MeV

Ef=zeros(50,1); lam=Ef; Psi=Ef;
ic=0;
for Eloss=-1:0.01:2
  lambda=(Eloss-dE)/xi-1+0.577215-beta^2-log(xi/Wmax);
  if lambda>-3
    ic=ic+1;
    Ef(ic)=T-Eloss;
    lam(ic)=lambda;
    pint=@(t)exp(-t.*log(t)-lambda.*t).*sin(pi*t)/pi;
    landau=integral(pint,0,Inf);
    Psi(ic)=landau/xi;
  end
end
plot(Ef,Psi,'k','LineWidth',2);
xlabel('Energy [MeV]'); ylabel('\Psi(E,\Deltax)') 
hold on
plot([T-dE,T-dE],[0 5],'k--',[T,T],[0,5],'k-.','LineWidth',2)
xlim([98.5,100.1]);
quiver(T,2,-dE,0,1,'k','LineWidth',2,'MaxHeadSize',0.3); 
text(99.6,2.3,'\DeltaE_{BB}','FontSize',16)
set(gca,'FontSize',16)
