% oscillator.m, low-gain FEL oscillator, V. Ziemann, 240829 
clear; close all; tic
addpath /home/ziemann/matlab/elliptic    % needed for elliptic12
mirror_losses=0.01;              % 0.01=1% extracted
a0=1e-8; phi=0; a=a0*exp(1i*phi);% initial amplitude and phase of laser
jcurr=1;                         % scaled current from Equation 10.32
x0=[pi/2,2.6]; dx=[2*pi,0.1];    % center and spread of distribution
N=1000;                          % number of particles
Omegas=sqrt(a0);                 % synchrotron frequency
axis_scale=[-pi/2,3*pi/2,-17,17];
figure('Name','FEL phase space')
ypos=0.95*axis_scale(3)+0.05*axis_scale(4); % where to place text
zeta=-pi/2:0.01:3*pi/2; separatrix=2*Omegas*cos(0.5*(zeta-pi/2+phi));
nstep=5; dt=1/nstep; tau=(1:nstep)/nstep; % steps along the undulator
Nrep=100;
data=zeros(Nrep,4);
for rep=1:Nrep
  hold off
  a00=abs(a);
  x1(:,1)=x0(1)+(rand(N,1)-0.5)*dx(1); % initial distribution
  x1(:,2)=x0(2)+(rand(N,1)-0.5)*dx(2); 
  plot(x1(:,1),x1(:,2),'g.')
  if (rep==1), dx0=dx(2); rms0=std(x1(:,2)); end
  hold on; % draw new image 
  for m=1:nstep      % one pass through the undulator
    Omegas=sqrt(abs(a)); phi=angle(a);   % needed for electron dynamics
    parfor k=1:N                         % update electron phase space
      x1(k,:)=pendulumtracker2_phase(x1(k,:),Omegas,phi,dt);
    end
    bf=sum(exp(-1i*x1(:,1)))/size(x1,1); % bunching factor <exp(-i*zeta)>
    a=a-jcurr*bf*dt;                     % update laser field, Eq. 10.32   
  end
  plot(x1(:,1),x1(:,2),'r.'); rms1=std(x1(:,2)); 
  a=a*(1-mirror_losses);
  title(['Iteration   ',num2str(rep),' of ',num2str(Nrep)])
  separatrix=2*Omegas*cos(0.5*(zeta-pi/2+phi));
  plot(zeta,separatrix,'k',zeta,-separatrix,'k'); 
  set(gca,'xtick',[-pi/2,0,pi/2,pi,3*pi/2],'fontsize',14, ...
      'xticklabels',{'-\pi/2','0','\pi/2','\pi','3\pi/2'}) 
  axis(axis_scale); xlabel('\zeta'); ylabel('\nu') 
  text(-pi/4,ypos,['abs(a) = ',num2str(abs(a),3),' '],'fontsize',16) 
  data(rep,1)=abs(a);
  data(rep,2)=angle(a)*180/pi;
  data(rep,3)=(abs(a)-a00)/a00;
  data(rep,4)=rms1/rms0; 
  pause(0.001);
  if (mod(rep,100)==0), toc; end
end
figure('Name','Evolution with time')
rep=1:Nrep;
subplot(4,1,1); plot(rep,data(:,1),'k','LineWidth',2); ylabel('abs(a)');
subplot(4,1,2); plot(rep,data(:,2),'k','LineWidth',2); ylabel('\phi [deg]');
subplot(4,1,3); plot(rep,data(:,3),'k','LineWidth',2); ylabel('Gain');
ylim([0,2]);
subplot(4,1,4); plot(rep,data(:,4),'k','LineWidth',2); ylabel('\sigma/\sigma_0');
xlabel('Iterations'); 