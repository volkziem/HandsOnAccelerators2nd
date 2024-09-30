% wake_plot.m, display wake potentials,  V. Ziemann, 240829
clear; close all
omega0=2*pi;
Q0=1;
taud=2*Q0/omega0;
omegahat=omega0*sqrt(1-1/(4*Q0^2));

t=0:0.02:2;
W=@(t)exp(-t/taud).*(cos(omegahat*t)-sin(omegahat*t)./sqrt(4*Q0^2-1));
W1=W(t);

Q0=3;
taud=2*Q0/omega0;
omegahat=omega0*sqrt(1-1/(4*Q0^2));
W=@(t)exp(-t/taud).*(cos(omegahat*t)-sin(omegahat*t)./sqrt(4*Q0^2-1));
W3=W(t);
plot(t,W1,'k',t,W3,'k--','LineWidth',2)
xlabel('\omega_0t/2\pi'); ylabel('(Q_0/\omega_0R) W(t)')
legend('Q_0=1','Q_0=3')
set(gca,'FontSize',16);
