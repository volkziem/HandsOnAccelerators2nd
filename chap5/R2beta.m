% R2beta.m, V. Ziemann, 240828
% Calculates the periodic betafunctions and phase advance 
% for a transfermatrix R
% Usage: [beta, alpha, phirad]=R2beta(R)
function [beta, alpha, phirad]=R2beta(R)
c=0.5*(R(1,1)+R(2,2));
phirad=acos(c);
beta=R(1,2)/sin(phirad);
alpha=0.5*(R(1,1)-R(2,2))/sin(phirad);
