% disruption.m, V. Ziemann, 240829
% requires collide_slices.m, CTM.m
clear; close all;
Relec=2.8179e-15;        % classical electron radius
Energy=1500e9; gamma=Energy/511e3;
Nbunch=3.72e9; sigz=44e-6;
epsx=2.286e-13; betax=7e-3;     % sigx=40 nm
epsy=1.471e-14; betay=68e-6;    % sigy=1 nm
sigx=sqrt(epsx*betax); sigy=sqrt(epsy*betay);

Nslices=100;     % over plus-minus 3 sigmaz
z=-3*sigz:6*sigz/(Nslices-1):3*sigz;
dz=z(2)-z(1);    % length of longitudinal slice
Na=exp(-0.5*(z./sigz).^2); Na=Nbunch*Na/sum(Na); Nb=1*Na;
siga=zeros(4,4,Nslices); sigb=siga;
Xa=zeros(4,1,Nslices); Xb=Xa;
siga(1,1,1)=epsx*betax; siga(2,2,1)=epsx/betax;
siga(3,3,1)=epsy*betay; siga(4,4,1)=epsy/betay;
for k=1:Nslices % initialize the sigma matrices in all slices
  R=eye(4); R(1,2)=-(k-1)*dz; R(3,4)=R(1,2);  % propagate backwards
  siga(:,:,k)=R*siga(:,:,1)*R';
  sigb(:,:,k)=siga(:,:,k);
end
ssig=[siga(1,1)+sigb(1,1),siga(1,3)+sigb(1,3); ...
    siga(1,3)+sigb(1,3),siga(3,3)+sigb(3,3)];
lumi_total0=sum(Na)*sum(Nb)/(2*pi*sqrt(det(ssig)));
sax=zeros(1,Nslices); say=sax; sbx=sax; sby=sax;  % for display
lumi_total=0;
for t=0:2*Nslices-2    % loop over time steps
  disp(['at time step t=' num2str(t)])
  for j=1:Nslices  % loop over the slices that meet at time t
    k=t+2-j;      % plus 2 because of indexing that starts at 1
    if ((k<1) || (k>Nslices)), continue; end  % abort if slices do not meet
    disp(['    slice ' num2str(j) ' meets slice ' num2str(k)])
    % get here for each pair of meeting slices
    [sa,xa,sb,xb,lumi]=collide_slices(siga(:,:,j),Xa(:,:,j),Na(j), ...
       sigb(:,:,k),Xb(:,:,k),Nb(k),dz,gamma);
    siga(:,:,j)=sa; Xa(:,:,j)=xa;   % copy back updated values
    sigb(:,:,k)=sb; Xb(:,:,k)=xb;
    lumi_total=lumi_total+lumi;     % sum the luminosity per slice
  end
  for k=1:Nslices % copy to display-arrays in nm
    sax(k)=1e9*sqrt(siga(1,1,k)); say(k)=1e9*sqrt(siga(3,3,k));
    sbx(k)=1e9*sqrt(sigb(1,1,k)); sby(k)=1e9*sqrt(sigb(3,3,k)); 
  end
  za=1e6*dz*((1:Nslices)-t/2-1); zb=1e6*dz*(-Nslices+(1:Nslices)+t/2);
  subplot(3,1,1);
  plot(za,Na,'k',zb,flip(Nb),'k--','LineWidth',2)
  xlim([-Nslices*dz*1e6,Nslices*dz*1e6]); ylabel('N/slice')
  text(180,8e7,['t = ',num2str(1e15*t*dz/(2*3e8),4),' fs'],'FontSize',20)
    set(gca,'FontSize',16)
  subplot(3,1,2);
  plot(za,sax,'k',zb,flip(sbx),'k--','LineWidth',2)
  xlim([-Nslices*dz*1e6,Nslices*dz*1e6]); ylabel('\sigma_x [nm]')
  set(gca,'FontSize',16)
  subplot(3,1,3);
  plot(za,say,'k',zb,flip(sby),'k--','LineWidth',2)
  xlim([-Nslices*dz*1e6,Nslices*dz*1e6]);
  ylabel('\sigma_y [nm]'); xlabel('z [\mum]')
  legend('Beam a','Beam b');
  set(gca,'FontSize',16)
  pause(0.02)
  %if t>0.6*Nslices break; end 
  %if t>1.3*Nslices break; end
end
LL0=lumi_total/lumi_total0;
disp(['Enhancement factor = ',num2str(lumi_total/lumi_total0)]);

