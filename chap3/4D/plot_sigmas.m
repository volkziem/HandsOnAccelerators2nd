% plot_betas.m, display the beam sizes, V. Ziemann, 240828
function plot_sigmas(beamline,sigma0)
[Racc,spos,nmat]=calcmat(beamline);
betax=zeros(1,nmat); betay=betax;
for k=1:length(spos)
   sigma=Racc(:,:,k)*sigma0*Racc(:,:,k)';
   betax(k)=sqrt(sigma(1,1)); betay(k)=sqrt(sigma(3,3));
end
plot(spos,betax,'k',spos,betay,'k-.'); 
xlabel(' s[m]'); ylabel('\sigma_x,\sigma_y [m]')
legend('\sigma_x','\sigma_y')
axis([0, max(spos), 0, 1.05*max([betax,betay])])

