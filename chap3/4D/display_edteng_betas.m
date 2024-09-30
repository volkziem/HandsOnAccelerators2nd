% display_edteng_betas.m, V. Ziemann
clear; close all
fodo=dlmread('fodo.bl');
fodor=dlmread('fodoroll.bl');
beamline=[fodo;fodor;repmat(fodo,6,1)];
[Racc,spos,nmat,nlines]=calcmat(beamline);
Rturn=Racc(:,:,end);  % full-turn-matrix at start
beta1=zeros(1,nmat); beta2=beta1;
for k=1:nmat
   R=Racc(:,:,k)*Rturn*inv(Racc(:,:,k));  % move FTM to point k
   [O,A,T,p]=sagrub(R); beta1(k)=p(3); beta2(k)=p(6);
end
plot(spos,beta1,'k',spos,beta2,'k-.','LineWidth',2); 
xlabel(' s[m]'); ylabel('\beta_1, \beta_2 [m]');
axis([0, max(spos), 0, 1.05*max([beta1,beta2])])
xlim([0, max(spos)]); ylim([0, 1.05*max([beta1,beta1])])
set(gca,'FontSize',16)
[p(1),p(4)]
