% tme_cell.m
clear all
format short
% dipole is not part of the beam line, set as drift
L=1;   % define the length unit

% SBEND with length 2*L in the center
phi=10*pi/180;
rho=2/phi;
BB=[cos(phi),rho*sin(phi);-sin(phi)/rho,cos(phi)];
%BB=[1,2;0,1];

%values for 2*L at the ends
F=1.1052;
D=1.8119;
DD=@(L)[1,L;0,1];
QQ=@(F)[1,0;-1/F,1];

% full cell
TME_X=DD(2*L)*QQ(-D)*DD(L)*QQ(F)*DD(L)*BB*DD(L)*QQ(F)*DD(L)*QQ(-D)*DD(2*L);
%TME_X=DD(2*L)*QQ(-D)*DD(L)*QQ(F)*DD(4*L)*QQ(F)*DD(L)*QQ(-D)*DD(2*L);
TME_Y=DD(2*L)*QQ(D)*DD(L)*QQ(-F)*DD(4*L)*QQ(-F)*DD(L)*QQ(D)*DD(2*L);

n=2;
TME=@(F,D)[DD(n*L)*QQ(-D)*DD(L)*QQ(F)*DD(L)*BB*DD(L)*QQ(F)*DD(L)*QQ(-D)*DD(n*L), zeros(2,2);
    zeros(2,2),DD(n*L)*QQ(D)*DD(L)*QQ(-F)*DD(4*L)*QQ(-F)*DD(L)*QQ(D)*DD(n*L)];

x0=[1.105,1.815];  % initial guess for focal lengths
qqq=chisq_tune_tme(x0);

[x,fval]=fminsearch(@chisq_tune_tme,x0,optimset('TolFun',1e-9))

R4=TME(x(1),x(2))   % 4x4 transfer matrix at optimum
mux=acos(0.5*(R4(1,1)+R4(2,2)));   % phase advance
muy=acos(0.5*(R4(3,3)+R4(4,4)));
alfax=0.5*(R4(1,1)-R4(2,2));     % alphas
alfay=0.5*(R4(3,3)-R4(4,4));
betax=R4(1,2)/sin(mux);          % betas
betay=R4(3,4)/sin(muy);
if betax < 0                     % handle case if larger than 180 degrees
   mux=2*pi-mux;
   betax=-betax;
end

tunes=[mux, muy]*180/pi;
all=[tunes,alfax,betax,alfay,betay];

% beam matrix at start of cell with unit emittance 
sigx0=[betax,-alfax;-alfax,(1+alfax^2)/betax];
sigy0=[betay,-alfay;-alfay,(1+alfay^2)/betay];

% transfer matrix to first quadrupole
R=DD(2*L);
s=R*sigx0*R';
betax_qd=s(1,1);
%R=DD(2*L);   % same for other plane because drift
s=R*sigy0*R';
betay_qd=s(1,1);

% transfer matrix to second quadrupole
R=DD(L)*QQ(-D)*DD(2*L);
s=R*sigx0*R';
betax_qf=s(1,1);
R=DD(L)*QQ(D)*DD(2*L);
s=R*sigy0*R';
betay_qf=s(1,1);

chromax=-2*(-betax_qd/D+betax_qf/F)/(4*pi);
chromay=-2*(betay_qd/D-betay_qf/F)/(4*pi);

sig=[sigx0,zeros(2,2);zeros(2,2),sigy0];

%sigout=R4*sig*R4'

all

kk=1./(0.01*x)



