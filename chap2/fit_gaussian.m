% fit_gaussian.m, V. Ziemann, 240827
clear; close all
mu=1.5; sigma=2;
data=sigma*randn(1,3000)+mu;
[y,x]=hist(data,30);

gauss=@(p,x)p(1).*exp(-((x-p(2)).^2)./(2*p(3).^2))+p(4);
chisq_gaussian=@(p)sum((y-gauss(p,x)).^2);

[pfit,fval]=fminsearch(chisq_gaussian,[max(y),0.1,1,0])
plot(x,y,'k*',x,gauss(pfit,x),'k');



