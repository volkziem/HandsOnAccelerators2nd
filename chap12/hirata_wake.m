% hirata_wake.m, V. Ziemann, 240829
function [X2,sigma2]=hirata_wake(f0,X,sigma)
X2=[X(1);X(2)-0.5*f0];
sigma2=sigma;
sigma2(1,2)=sigma(1,2)-0.5*f0*sqrt(sigma(1,1))/sqrt(pi);
sigma2(2,1)=sigma2(1,2);
sigma2(2,2)=sigma(2,2)-f0*sigma(1,2)/sqrt(pi*sigma(1,1))+f0^2/12;

