% landau_distribution.m, V. Ziemann, 240829
clear; close all
x=-3:0.01:20;               
landau=zeros(1,length(x)); 
for k=1:length(x)
  pint=@(t)exp(-t.*log(t)-x(k).*t).*sin(pi*t)/pi;
  landau(k)=integral(pint,0,Inf);
end
plot(x,landau,'k','LineWidth',2); 
xlabel('\lambda'); ylabel('p_L(\lambda)'); set(gca,'Fontsize',16)

