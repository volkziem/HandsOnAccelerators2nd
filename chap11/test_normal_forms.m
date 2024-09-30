% test_normal_forms.m, V. Ziemann, 240829
clear; close all;
global M0 MM CN
global Racc spos ipos nlines
global BAS3 BAS3I BAS4 BAS4I
[M0,MM,CN]=hamini;
N=2; N1=N; N2=N*(N+1)/2; N3=N2*(N+2)/3; N4=N3*(N+3)/4; % size of subspaces
MM3=N1+N2+1:N1+N2+N3; MM4=N1+N2+N3+1:N1+N2+N3+N4;      % ranges of indices

henon=[
  201,1,10,0.31;
  1003, 1, 0, -6  
];

onesext=[
  1003, 1, 0, -6;
  1   , 1, 2, 0    % 2 m drift
];

twosext=[
  1003, 1, 0, -6;
     1, 1, 2,  0;   % 2 m drift
  1003, 1, 0, -6;
     1, 1, 2,  0    % 2 m drift
];
beamline=henon;
% beamline=onesext;
% beamline=twosext;

[Racc,spos,nmat,nlines,ipos]=calcmat(beamline);

H0=fulham3(beamline);
dispham(H0,'H0 = ')
%return
R=Racc(:,:,end);

[K,C]=nrnf(H0,R);      % non-resonant normal form code
dispham(K,'K = '); 
dispham(C,'C = ');

TS=BAS4(1,:)*C(MM4);
disp(['Tuneshift polynomial= ' num2str(4*TS) ' * Jx^2'])

% verification: exp(-H0)*exp(-SK)=exp(-K)*exp(-C)
SK=propham3(R,K);
LHS=CBH(-SK,-H0); 
RHS=CBH(-C,-K);
MAXDIFF=max(abs(LHS-RHS))
LHS_RHS=[LHS, RHS];











  



