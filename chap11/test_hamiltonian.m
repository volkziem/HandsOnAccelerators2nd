% test_hamiltonian.m, V. Ziemann, 240829
clear all; close all;
global M0 MM CN
global Racc spos ipos nlines
%global BAS3 BAS3I BAS4 BAS4I

% N=2; N1=N; N2=N*(N+1)/2; N3=N2*(N+2)/3; N4=N3*(N+3)/4; % size of subspaces
% MM3=N1+N2+1:N1+N2+N3; MM4=N1+N2+N3+1:N1+N2+N3+N4;      % ranges of indices

[M0,MM,CN]=hamini;

henon=[
  201,1,10,0.31;
  1003, 1, 0, -6   % sextupole
];

onesext=[
  1003, 1, 0, -6;  % sextupole
     1, 1, 2,  0    % 2 m drift
];

twosext=[
  1003, 1, 0, -6;
     1, 1, 2,  0;  
  1003, 1, 0, -6;
     1, 1, 2,  0  
];

% beamline=henon;
% beamline=onesext;
beamline=twosext;

[Racc,spos,nmat,nlines,ipos]=calcmat(beamline);
H0=fulham3(beamline);
dispham(H0,'H0 = ')












  



