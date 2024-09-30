% sase_power_spectrum.m, V. Ziemann, 240829
close all
power=@(M,v)(M^M).*(v.^(M-1)).*exp(-M.*v)/gamma(M);
v=0.0:0.01:3;
plot(v,power(1,v),'k',v,power(3,v),'k--',v,power(10,v),'k-.','LineWidth',2);
ylim([0,1.37])
xlabel('v=U/<U>'); ylabel('p_M(v)')
legend('M=1','M=3','M=10')
set(gca,'FontSize',16)