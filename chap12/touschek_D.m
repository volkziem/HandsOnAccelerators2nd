% touschek_D.m, plot D(xi), V. Ziemann, 240829
clear; close all
xi=logspace(-7,1);
D=zeros(length(xi),1);
for k=1:length(xi)
  f=@(u)exp(-xi(k)./u).*(1./u-1-0.5.*log(1./u));
  D(k)=integral(f,0,1)*sqrt(xi(k));
end
loglog(xi,D,'k','LineWidth',2);
xlim([3e-7,8]); ylim([3e-6,0.5])
xlabel('\xi'); ylabel('D(\xi)')
set(gca,'FontSize',16)
