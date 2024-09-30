% plot_betas.m, display the uncoupled beta functions, V. Ziemann, 240828
function plot_betas(beamline,sigma0)
[Racc,spos,nmat]=calcmat(beamline);
betax=zeros(1,nmat); betay=betax;
for k=1:length(spos)
   sigma=Racc(:,:,k)*sigma0*Racc(:,:,k)';
   betax(k)=sigma(1,1); betay(k)=sigma(3,3);
end
plot(spos,betax,'k',spos,betay,'k-.','LineWidth',2); 
xlabel(' s[m]'); ylabel('\beta_x,\beta_y [m]')
legend('\beta_x','\beta_y')
axis([0, max(spos), 0, 1.05*max([betax,betay])])
