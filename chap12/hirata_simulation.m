% hirata_simulation.m, V. Ziemann, 240829
clear;  close all
nus=2*pi*0.0196; % synchrotron oscillations
U=[cos(nus),sin(nus);-sin(nus),cos(nus)]; 
Nd=1000;    % damping time in turns
xi=exp(-1/Nd);
sig0=1;
Nsim=10*Nd; % simulation time
f0=4;       % wake fields
data=zeros(Nsim,3);
X=[1;0]; sigma=[2,0;2,1];  % initial distribution
for k=1:Nsim
  [X2,sigma2]=hirata_synosc(U,X,sigma);
  [X3,sigma3]=hirata_radamp(xi,sig0,X2,sigma2);
  [X4,sigma4]=hirata_wake(f0,X3,sigma3);
  X=X4; sigma=sigma4;
  data(k,1)=X(1); data(k,2)=sqrt(sigma(1,1)); data(k,3)=sqrt(sigma(2,2));
end
figure('Name','Centroid synchrotron oscillations');
plot(1:Nsim,data(:,1),1:Nsim,data(:,2))
xlabel('Iterations'); ylabel('X_1, X_2');

figure('Name','Equilibrium parameters');
f0=0.0:0.01:3;
data=zeros(length(f0),3);
X=[0;0]; sigma=[1,0;0,1]; % initial values for f0=0
for k=1:length(f0)
  [X,sigma]=hirata_iterate(3*Nd,U,xi,sig0,f0(k),X,sigma);
  data(k,1)=sqrt(sigma(1,1));
  data(k,2)=sqrt(sigma(2,2));
  data(k,3)=sqrt(abs(sigma(1,2)));
end
plot(f0,data(:,1),'k',f0,data(:,2),'k--','LineWidth',2)
xlabel('f_0'); ylabel('\sigma_{11}^{1/2}, \sigma_{22}^{1/2}')
legend('Bunch length \sigma_{11}^{1/2}','Momentum spread \sigma_{22}^{1/2}')
ylim([0,3.8])
set(gca,'FontSize',16)
