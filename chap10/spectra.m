% spectra.m, S(y) and H2(y) for y=omega/omegac, V. Ziemann, 240829
clear; close all
bk53=@(x)besselk(5/3,x);
S=@(y)(9*sqrt(3)/(8*pi))*y.*integral(bk53,y,Inf);
H2=@(y)y.^2.*besselk(2/3,0.5*y).^2;

y=logspace(-3,1);
SS=zeros(length(y),1);

for k=1:length(y) 
  SS(k)=S(y(k));
end
loglog(y,SS,'k',y,H2(y),'k--',[1,1],[1e-6,100],'k:','Linewidth',2)
legend('Power spectrum: S(\omega/\omega_c)','Number spectrum: H_2(\omega/\omega_c)')
xlabel('y=\omega/\omega_c=\epsilon/\epsilon_c'); ylabel('S(y),H_2(y)')
ylim([2e-3,3])
set(gca,'FontSize',16)
