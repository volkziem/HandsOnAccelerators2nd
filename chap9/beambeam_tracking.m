% beambeam_tracking.m, V. Ziemann, 240829
% requires fitco.m, trak.m, F0.m
% requires the Faddeeva package from matlab central
% https://www.mathworks.com/matlabcentral/fileexchange/  ...
%  38787-faddeeva-package-complex-error-functions
clear; close all;
addpath /home/ziemann/matlab/Faddeeva/
global Re Rp kapsig Ne Np egamma pgamma Relec
degree=pi/180;
Nfft=1024; tune=(0:Nfft/2-1)/Nfft; % axis for fft plots
Relec=2.8179e-15;        % classical electron radius

% electron ring parameters, betas at IP
egamma=9e9/511e3;   % 9 GeV
Ne=3.883e10;  % particles per bunch
emitx=4e-8; betax=1; Qx=0.64; 
emity=2e-9; betay=0.05; Qy=0.57;
%etiltxy=0*degree;

% positron ring parameters, betas at IP
pgamma=3.1e9/511e3;   % 3.1 GeV
Np=5.632e10;  % particles per bunch
pmitx=4e-8; pbetax=1; pQx=0.64; 
pmity=2e-9; pbetay=0.05; pQy=0.57;
%ptiltxy=0*degree;

% electron transfer matrices 
Rx=[cos(2*pi*Qx),betax*sin(2*pi*Qx);-sin(2*pi*Qx)/betax,cos(2*pi*Qx)];  
Ry=[cos(2*pi*Qy),betay*sin(2*pi*Qy);-sin(2*pi*Qy)/betay,cos(2*pi*Qy)]; 
Re=[Rx,zeros(2,2);zeros(2,2),Ry];
esigxy=[emitx*betax, 0; 0, emity*betay]; % electron sigma_xy at IP

% positron transfer matrices
Rx=[cos(2*pi*pQx),pbetax*sin(2*pi*pQx);-sin(2*pi*pQx)/pbetax,cos(2*pi*pQx)];  
Ry=[cos(2*pi*pQy),pbetay*sin(2*pi*pQy);-sin(2*pi*pQy)/pbetay,cos(2*pi*pQy)]; 
Rp=[Rx,zeros(2,2);zeros(2,2),Ry];
psigxy=[pmitx*pbetax, 0; 0, pmity*pbetay]; % positron sigma_xy at IP

kapsig=1e12*(esigxy+psigxy);  % KapSigma_xy at IP, converted to micron

%..............................horizontal van der Meer scan
figure('Name','Horizontal scan');
pos=zeros(Nfft,1);  % array for positions for FFT
y=zeros(8,1);
bump=-1000:50:1000; 
data=zeros(length(bump),6);
for k=1:length(bump)
  y=fitco(y,bump(k),0);   % finds closed orbit with beambeam kick
  data(k,1:4)=[y(1),y(2),y(5),y(6)];  % store orbits for later display
  y(1)=y(1)+10;  % excite a betatron oscillation with 10 micron amplitude
  for m=1:Nfft   % iterate to get tunes from FFT
    y=trak(y,bump(k),0); pos(m)=y(1);
  end
  dd=2*abs(fft(pos))/Nfft; 
  mm=1:Nfft/2;  % consider only Q < 0.5
  locs=islocalmax(dd(mm),'MaxNumExtrema',2);
  data(k,5:6)=(mm(locs)-1)/Nfft;
end
subplot(2,1,1); plot(bump,data(:,2),'k',bump,data(:,4),'k--');
xlabel('Horizontal bump amplitude [\mum]')
ylabel('Deflection angle [\murad]')
legend('Electrons','Positrons')
subplot(2,1,2); plot(bump,data(:,5),'k+',bump,data(:,6),'k+'); 
xlabel('Horizontal bump amplitude [\mum]'); ylabel('Tune Q_x')
ylim([0.3,0.4]); 

%..............................vertical van der Meer scan
figure('Name','Vertical scan');
y=zeros(8,1);
bump=-100:5:100;
data=zeros(length(bump),4);
for k=1:length(bump)
  y=fitco(y,0,bump(k));   % finds closed orbit with beambeam kick
  data(k,1:4)=[y(3),y(4),y(7),y(8)];   % store vertical orbits
  y(3)=y(3)+10;  % excite a vertical betatron oscillation
  for m=1:Nfft   % iterate to get tunes from FFT
    y=trak(y,0,bump(k)); pos(m)=y(3);
  end
  dd=2*abs(fft(pos))/Nfft; 
  mm=1:Nfft/2;  % consider only Q < 0.5
  locs=islocalmax(dd(mm),'MaxNumExtrema',2);
  data(k,5:6)=(mm(locs)-1)/Nfft; 
end
subplot(2,1,1); plot(bump,data(:,2),'k',bump,data(:,4),'k--');
xlabel('Vertical bump amplitude [\mum]')
ylabel('Deflection angle [\murad]')
legend('Electrons','Positrons')
subplot(2,1,2); plot(bump,data(:,5),'k+',bump,data(:,6),'k+'); 
xlabel('Verical bump amplitude [\mum]'); ylabel('Tune Q_y')
ylim([0.37,0.45]); 