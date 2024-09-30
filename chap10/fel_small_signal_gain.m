% fel_small_signal_gain.m, FEL gain curve, V. Ziemann, 240829
clear; close all
addpath /home/ziemann/matlab/elliptic
Omegas=0.25; Ts=2*pi/Omegas;
dt=0.1*Ts;
phi=-pi:2*pi/201:pi;
separatrix=2*Omegas*cos(0.5*phi);
eta0=-5.002:0.2:5;
gain=zeros(1,length(eta0));
for m=1:length(eta0)
  hold off; plot(phi,separatrix,'k',phi,-separatrix,'k')
  axis([-pi,pi,-0.8,0.8]); hold on; pause(0.001)
  hold on
  for k=1:length(phi)
    plot(phi(k),eta0(m),'r*') 
    x=pendulumtracker([phi(k),eta0(m)],Omegas,dt);
    gain(m)=gain(m)+x(2);
    plot(x(1),x(2),'b+') 
  end
  xlabel('\psi'); ylabel('\eta')
  gain(m)=eta0(m)-gain(m)/length(phi);
  disp([num2str(m),':  gain=',num2str(gain(m))])
  pause(0.1);
end
figure('Name','FEL small-signal gain curve');
hold off
plot(eta0,gain,'k*');
xlabel('\eta_0 = (\gamma_0-\gamma_r)/\gamma_r'); ylabel('<\eta_f> - \eta_0')
xlim([-5,5])
save('gaincurve.mat')