% hirata_radamp.m, V. Ziemann, 240829
function [X2,sigma2]=hirata_radamp(xi,sig0,X,sigma)
X2=[X(1);xi*X(2)];
sigma2=sigma;
sigma2(1,2)=xi*sigma(1,2); 
sigma2(2,1)=sigma2(1,2);
sigma2(2,2)=xi^2*sigma(2,2)+(1-xi^2)*sig0^2;
