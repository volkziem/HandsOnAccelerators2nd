% plot_gaincurve.m, V. Ziemann, 240829
clear; close all
load('gaincurve2.mat')
plot(eta0,gain,'k*');
xlabel('$$\dot\psi_{0}\propto(\gamma_0-\gamma_r)/\gamma_r$$','interpreter','latex')
ylabel('$$\langle\Delta\dot\psi\rangle$$','interpreter','latex')
%ylabel('$$\langle\Delta\dot\psi\rangle = \langle\dot\psi_{f}-\dot\psi_{0}\rangle$$','interpreter','latex')
%ylabel('$$\langle\dot\psi_{f}-\dot\psi_{0}\rangle$$','interpreter','latex')
%ylabel('$$\langle\dot\psi_{f}\rangle-\dot\psi_{0}$$','interpreter','latex')
% xlabel('\eta_0 = (\gamma_0-\gamma_r)/\gamma_r'); 
% ylabel('<\eta_f> - \eta_0')
xlim([-5,5])
set(gca,'FontSize',16)
hold on
x=0.2:0.01:2.1;
plot(x,-0e-3+3e-3*exp(-4*(x-1.1).^2),'k--')