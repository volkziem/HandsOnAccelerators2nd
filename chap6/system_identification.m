% system_identification.m, V. Ziemann, 240625
clear; % close all
Niter=10000;    % number of iterations
Nforget=100;    % forgetting horizon
alpha=1-1/Nforget;
Rbeta=1;        % R/(1+beta) normalized
sigm=0.001;     % measurement noise level
dt=1e-7;        % sample time at 10 MHz
omegahat=2*pi*1e9;        % resonant frequency
QE=5e5;                   % external-Q
QL=QE;                    % loaded-Q, if sc approx same as QE
omega12=omegahat/(2*QL);  % bandwidth   
domega=-omega12/2;        % set detuning to half the bandwidth
q0=[omega12*dt,domega*dt];% bandwidth and detuning
amplitude=q0(1);          % needed for periodic perturbation
F=[-q0(1),-q0(2);q0(2),-q0(1)]; % eq. 4
Areal=eye(2)+F;                 % eq. 6
Breal=Rbeta*omega12*dt*eye(2);  % for generator current
BrealE=Breal*2*QL/QE;           % for the forward current
pt=1;                           % initial value of pT
qhat=zeros(2,1);                % initial parameter estimate
Vp=[0;0];                       % initialize cavity voltage
V=sigm*randn(2,1);              % measured voltage includes noise
data=zeros(Niter,7);            % storage for later plotting
Iset=[0;0];                     % generator is off at start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for iter=1:Niter                 % main iteration loop
  if iter==200, Iset=[1;0]; end  % first pulse
  if 1   % bandwidth change after half the iterations    
    if iter==Niter/2        % start half-way of Niter
      factor=2;             % magnitude of step in bandwidth
      q0(1)=factor*q0(1);   % increase bandwidth by factor
      omega12=omega12*factor;
      Areal=eye(2)+[-q0(1),-q0(2);q0(2),-q0(1)];
      Breal=Breal*factor;
      QL=QL/factor;   
    end
  end
  if 1 % periodic perturbation (1=1 kHz, 2=2 kHz)
    q0(2)=0.5*amplitude*sin(2*6.2832e-4*iter);  
    Areal=eye(2)+[-q0(1),-q0(2);q0(2),-q0(1)];
  end
  %.........................................cavity dynamics
  Itot=Iset;
  Vpnew=Areal*Vp+Breal*Itot;         % eq. 4, xp=V
  Vnew=Vpnew+sigm*randn(size(V)); % eq. 5, x=V', add measurement noise
  %...................................system identification  
  Iplus=Itot*QE/(2*QL);                   % eq.2, forward current I^+ 
  y=Vnew-V-BrealE*Iplus;               % eq.11, right
  vv2=V'*V; 
  tmp=alpha/(alpha+pt*vv2);         % bracket in eq.20
  qhat=tmp*(qhat+[-V(1)*y(1)-V(2)*y(2);-V(2)*y(1)+V(1)*y(2)]*pt/alpha); % eq.21
  pt=tmp*pt/alpha;                  % eq. 20
  Vp=Vpnew;       % update process voltage in the cavity
  V=Vnew;         % remember measured voltage
  %................................save for later plotting
  data(iter,1)=V(1);       % normalized voltages, measured
  data(iter,2)=V(2);
  data(iter,3)=Itot(1);       % generator currents
  data(iter,4)=Itot(2);
  data(iter,5)=qhat(1);    % bandwidth
  data(iter,6)=qhat(2);    % detuning
  data(iter,7)=pt;         % p_T
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mm=(1:Niter)*1e3*dt;         % xaxis for plots, Time in ms
if 1    % plot of voltages and currents
  figure(1)
  subplot(2,1,1);
  plot(mm,data(:,3),'k',mm,data(:,4),'r','LineWidth',2);
  xlabel('Time [ms]'); ylabel('i_r, i_i');
  legend('i_r','i_i')
  set(gca,'FontSize',16);
  subplot(2,1,2);
  plot(mm,data(:,1),'k',mm,data(:,2),'r','LineWidth',2);
  xlabel('Time [ms]'); ylabel('v_r, v_i');
  legend('v_r','v_i')
  set(gca,'FontSize',16); 
end

if 1   % evolution of fit parameters
  figure(2); clf
  fac=1/(2*pi*dt);   % convert q-units to Hz
  plot(mm,fac*data(:,5),'k',mm,fac*data(:,6),'r','LineWidth',2);
  xlabel('Time [ms]'); ylabel('f_{12},\Deltaf     [Hz]');
  legend('f_{12}','\Deltaf');
  ylim([-700,2300])
  %xlim([4950,5350])
  set(gca,'FontSize',16); 
end

if 1   % PT
  figure(3); clf %   plot PT
  semilogy(mm,data(:,7),'k','LineWidth',2);
  xlim([1,Niter]);  
  xlabel('Iterations'); ylabel('p_T')
  set(gca,'FontSize',16);
  asymp=1/(Nforget*vv2);
  hold on; semilogy([1,Niter],[asymp,asymp],'r--');
end

