% transient_beamloading_ss_pfb.m, V. Ziemann, 240617
clear; %close all;
degree=pi/180;
Vhat=1e6;       % cavity voltage
R=1e6;          % shunt impedance
Ib0=0.1;        % beam current
phisdeg=-15;    % beam phase
[Ig0,beta,tanpsi]=blcomp(Vhat,R,phisdeg,Ib0(1)); % beam loading compensation
dt=10e-6;       % 10 us sampling time
omega12=10000;  % cavity bandwidth = 1/tauf
A=[1-omega12*dt, omega12*dt*tanpsi ; -omega12*dt*tanpsi, 1-omega12*dt];
B=omega12*dt*R/(1+beta);

Kp=10/R; Ki=0*1/R;
Vd1=Vhat*[cos(phisdeg*degree); sin(phisdeg*degree)]; 
Vd=[0;0];
W=[0;0];

Vs=[0;0];    % initial voltage, real and imaginary
%II=[0;0];   % total cavity driving current
%Ig=[0;0];   % generator current
Ib=[0;0];   % beam current

Niter=450;
data=zeros(Niter,9);
for iter=1:Niter
  if iter==100, Vd=Vd1;  end                   % set desired voltage
  if iter==400, Vd=[0;0]; end
  if iter==135, Ib=[Ib0;0]; end               % beam on
  if iter==350, Ib=[0;0]; end                 % beam off
  W=W+(Vd-Vs);             % integral
  Ig=Kp*(Vd-Vs)+Ki*W;      % PI-controller
  Vs=A*Vs+B*(Ig-2*Ib);     % update cavity voltage
  Vref=Vs-0.5*R*Ig/beta;   % reflected voltage
  data(iter,1)=Ig(1);      % generator current
  data(iter,2)=Ig(2); 
  data(iter,3)=Vs(1);      % cavity voltage
  data(iter,4)=Vs(2); 
  data(iter,5)=Ib(1);      % beam current
  data(iter,6)=Ib(2); 
  data(iter,7)=(180/pi)*atan2(Vs(2),Vs(1));  % cavity phase
  data(iter,8)=Vref(1);    % reflected voltage
  data(iter,9)=Vref(2);
end

% only display stuff below
mm=1:Niter; ms=0.01*mm;  % for horizontal axis

subplot(3,1,1);
plot(ms,data(:,1),'k',ms,data(:,2),'r--','Linewidth',2);
ylabel('I_g [A]'); set(gca,'Fontsize',16);
ylim([-0.8, 2.7]); %xlim([0.5,max(ms)]);
legend('real','imag','Location','Northwest')

subplot(3,1,2);
%plot(ms,data(:,3)/1e6,'k',ms,data(:,4)/1e6,'r--','Linewidth',2);
plot(ms,hypot(data(:,3),data(:,4))/1e6,'k',ms,ones(1,length(ms)),'k:','Linewidth',2);
ylabel('|V_s| [MV]'); set(gca,'Fontsize',16);
ylim([-0.4, 1.2]); legend('|V_s|','|V_d|','Location','Northwest')

subplot(3,1,3);
data(1:100,7)=NaN; data(400:end,7)=NaN;
plot(ms,data(:,7),'k',ms,phisdeg*ones(1,length(ms)),'k:','Linewidth',2);
xlim([min(ms),max(ms)]); ylim([-15.65,-14.65]);
ylabel('\phi_s [deg]'); set(gca,'Fontsize',16);
legend('phase','reference','Location','Northwest')

return

subplot(5,1,1);
plot(ms,data(:,1),'k',ms,data(:,2),'r--','Linewidth',2);
ylabel('I_g [A]'); set(gca,'Fontsize',16);
ylim([-0.8, 2.7]); %xlim([0.5,max(ms)]);
legend('real','imag','Location','Northwest')

subplot(5,1,2);
plot(ms,data(:,5),'k',ms,data(:,6),'r--','Linewidth',2);
ylabel('I_b [A]'); set(gca,'Fontsize',16);
ylim([-0.04, 0.12]); legend('real','imag','Location','Northwest') 

subplot(5,1,3);
plot(ms,data(:,3)/1e6,'k',ms,data(:,4)/1e6,'r--','Linewidth',2);
ylabel('V_s [MV]'); set(gca,'Fontsize',16);
ylim([-0.4, 1.2]); legend('real','imag','Location','Northwest')

subplot(5,1,4);
data(1:100,7)=NaN; data(400:end,7)=NaN;
plot(ms,data(:,7),'k',ms,phisdeg*ones(1,length(ms)),'k:','Linewidth',2);
xlim([min(ms),max(ms)]); ylim([-20,-10]);
ylabel('\phi_s [deg]'); set(gca,'Fontsize',16);
legend('phase','reference','Location','Northwest')

subplot(5,1,5);
plot(ms,data(:,8)/1e6,'k',ms,data(:,9)/1e6,'r--','Linewidth',2);
ylabel('V_{ref} [MV]'); set(gca,'Fontsize',16);
xlabel('Time [ms]')
ylim([-1.2, 1.2]); legend('real','imag','Location','Northwest')
