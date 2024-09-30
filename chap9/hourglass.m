% hourglass.m for symmetric transparent beams, V. Ziemann, 240829
clear; hold off
a=0:0.1:5;              % sigma_s/beta_y
R=zeros(length(a),1);   % Hourglass reduction factor
for k=1:length(a)
  integrand=@(u)exp(-u.^2)./sqrt(1+a(k)^2.*u.^2);
  R(k)=2*integral(integrand,0,Inf)/sqrt(pi);
end
plot(a,R,'k','LineWidth',2)
xlabel('\sigma_s/\beta^*_y'); ylabel('R(0,\sigma_s/\beta^*_y)')
set(gca,'FontSize',16)