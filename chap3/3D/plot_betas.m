% plot_betas.m, V. Ziemann
function plot_betas(beamline,sigma0)
[Racc,spos]=calcmat(beamline);
betax=zeros(1,length(spos)); betay=betax;
for k=1:length(spos)
   sigma=Racc(:,:,k)*sigma0*Racc(:,:,k)';
   betax(k)=sigma(1,1); 
end
plot(spos,betax,'k');
xlabel(' s[m]'); ylabel('\beta_x [m]')
axis([0, max(spos), 0, 1.05*max(betax)])
