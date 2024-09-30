% fit_resonance_gamma.m, V. Ziemann, 240829
clear; close all
d=importdata('f1b.csv');
f=d.data(:,1)/1e9; amp=d.data(:,2); phase=d.data(:,3);

g=@(p,x)20*log10(abs((p(3)-1-1i*p(2)*(x./p(1)-p(1)./x))./ ...
    (p(3)+1+1i*p(2)*(x./p(1)-p(1)./x))));
chisq_g=@(p)sum((amp-g(p,f)).^2);

[pfit,fval]=fminsearch(chisq_g,[1.15,200,1.1])
figure('Name','S11 versus frequency')
plot(f,amp,'k*',f,g(pfit,f),'k');
xlabel('f [GHz]'); ylabel('S_{11} [dB]'); xlim([1.148,1.158])
legend('Measurements','f_0=1.153 GHz, Q=100, \beta=1')
set(gca,'FontSize',16)

