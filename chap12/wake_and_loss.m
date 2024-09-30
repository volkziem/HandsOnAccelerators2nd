% wake_and_loss.m, V. Ziemann, 240829
clear; close all
addpath /home/ziemann/matlab/Faddeeva
gauss=@(t)exp(-0.5*t.^2)/sqrt(2*pi);
Q0=1;
omega0=2*pi;
omegap=(omega0/2*Q0)*(1i+sqrt(4*Q0^2-1));
wake1=@(t)exp(-0.5*t.^2).* ...
  real(omegap.*Faddeeva_w(omegap/sqrt(2)-1i*t/sqrt(2)));

omega0=0.2*pi;
omegap=(omega0/2*Q0)*(1i+sqrt(4*Q0^2-1));
wake=@(t)exp(-0.5*t.^2).* ...
  real(omegap.*Faddeeva_w(omegap/sqrt(2)-1i*t/sqrt(2)));

figure('Name','Wake potentials')
t=-4:0.1:10;
plot(t,gauss(t),'k',t,wake(t),'k--',t,wake1(t),'k:','LineWidth',2)
xlim([-4,10]); ylim([-0.31,0.43])
xlabel(' t/\sigma_t');
legend('Bunch distribution','G(t) with \omega_r\sigma_t=0.2\pi','G(t) with \omega_r\sigma_t=2\pi')
set(gca,'FontSize',16)

figure('Name','Loss factor')
lossfactor=@(sigmat)real(omegap*Faddeeva_w(omegap*sigmat));
sigmat=0.01:0.03:5;
plot(omega0*sigmat,lossfactor(sigmat),'k','LineWidth',2)
xlim([0,3])
xlabel('\omega_r\sigma_t'); ylabel('k_{||} [arb. units]')
set(gca,'FontSize',16)