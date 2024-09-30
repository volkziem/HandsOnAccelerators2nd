% separatrix.m, V. Ziemann, 240828
clear; close all;
hold on
for phimax=pi/5:pi/5:pi
  phidot=@(phi)sqrt(2*(cos(phi)-cos(phimax)));
  phi=-phimax:phimax/500:phimax;
  om=phidot(phi);
  if phimax==pi
    plot(phi,om,'k',phi,-om,'k','LineWidth',2);
  else 
    plot(phi,om,'k-.',phi,-om,'k-.','LineWidth',2);
  end
end
xlim([-pi,pi]); ylim([-2.2,2.2]);
xlabel('\phi'); ylabel('(d\phi/dt)/\Omega_s')
text(1.35,1.7,'Separatrix','FontSize',16)
set(gca,'xtick',[-pi,-pi/2,0,pi/2,pi],'fontsize',16, ...
  'xticklabels',{'-\pi','-\pi/2','0','\pi/2','\pi'})
