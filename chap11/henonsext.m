% henonsext.m, V. Ziemann. 240829
clear; close all;
Nturn=1024;
Q=0.2526; %Q=0.31;
dx=0.0;     % misalignment
R=@(mu)[cos(mu),sin(mu);-sin(mu),cos(mu)];
RR=R(2*pi*Q);

hold on
for x0=0.05:0.05:2
  % JJ=JJ+1;
  x=[x0;0];
  pos=zeros(1,Nturn);
  for n=1:Nturn
    x=RR*[x(1);x(2)-(x(1)-dx)^2];
    if (abs(x(1))>3), break; end
    plot(x(1),x(2),'k.');
    pos(n)=x(1);
  end
  title(num2str(x0))
  pause(0.001)
end
axis([-1.2,1.2,-1.2,1.2]); 
xlabel('$\hat x$','interpreter','latex'); 
ylabel('$\hat x''$','interpreter','latex'); 
title(''); set(gca,'FontSize',16)