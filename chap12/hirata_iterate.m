% hirata_iterate.m, V. Ziemann, 240829
function [X,sigma]=hirata_iterate(N,U,xi,sig0,f0,X,sigma)
for k=1:N
  [X2,sigma2]=hirata_synosc(U,X,sigma);
  [X3,sigma3]=hirata_radamp(xi,sig0,X2,sigma2);
  [X4,sigma4]=hirata_wake(f0,X3,sigma3);
  X=X4; sigma=sigma4;
end
