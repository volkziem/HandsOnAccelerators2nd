% hirata_synosc.m, V. Ziemann, 240829
function [X2,sigma2]=hirata_synosc(U,X,sigma)
X2=U*X;
sigma2=U*sigma*U';
