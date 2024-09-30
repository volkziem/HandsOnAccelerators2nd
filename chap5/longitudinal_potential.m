% longitudinal_potential.m, V. Ziemann, 240828
clear; close all
degree=pi/180;
phis=15*degree;   % set the synchronous phase
Veff=@(phi)-(cos(phi)+phi*sin(phis));
hold off
subplot(2,1,1)
phi=-4*pi:pi/20:4*pi;
plot(phi,Veff(phi),'k')
xlabel('\phi'); ylabel('V_{eff}/\Omega_s^2')
axis([-4*pi,4*pi,-4,4]);
set(gca,'xtick',[-4*pi,-2*pi,0,2*pi,4*pi],'fontsize',14, ...
  'xticklabels',{'-4\pi','-2\pi','0','2\pi','4\pi'})
hold on
plot(2,Veff(2)+0.15,'ko');
plot(2,Veff(2)+0.15,'k*')
plot([pi-phis,pi-phis],[-4,4],'k:')
plot([4.86,4.86],[-4,4],'k:')
subplot(2,1,2)
for n=-2:3
g=@(phi)cos(phis)-(2*n+1)*pi*sin(phis)+(phi+phis)*sin(phis)+cos(phi);
phim=fzero(g,-2);
phi=phim+1e-6:0.02:(2*n+1)*pi-phis;
separatrix=@(phi)sqrt(2*g(phi));
plot(phi,separatrix(phi),'k',phi,-separatrix(phi),'k');
axis([-4*pi,4*pi,-2,2]);
set(gca,'xtick',[-4*pi,-2*pi,0,2*pi,4*pi],'fontsize',14, ...
  'xticklabels',{'-4\pi','-2\pi','0','2\pi','4\pi'})
hold on
end
xlabel('\phi');
ylabel('(d\phi/dt)/\Omega_s')
plot([pi-phis,pi-phis],[-4,4],'k:')
plot([4.86,4.86],[-4,4],'k:')