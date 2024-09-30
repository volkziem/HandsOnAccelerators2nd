% large_oscillation_period.m, V. Ziemann, 240828
clear; close all
hold off
phihat=0:0.02:pi;   
m=sin(phihat/2).^2;
Tp=(2/pi)*ellipke(m);
plot(phihat,Tp,'k','LineWidth',2)
xlim([0,pi]); ylim([0,5.7])
xlabel({'$\hat{\phi}$'},'Interpreter','latex')
ylabel('T_p/T_s')
set(gca,'xtick',[0,pi/2,pi],'fontsize',16, ...
  'xticklabels',{'0','\pi/2','\pi'})