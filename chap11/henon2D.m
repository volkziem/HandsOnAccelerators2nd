% henon2D.m, survival plots, V. Ziemann, 240829
clear; close all;
NN=1000;
Qx=0.31; Qy=0.28;
R1D=@(mu)[cos(mu),sin(mu);-sin(mu),cos(mu)];
R=[R1D(2*pi*Qx),zeros(2);zeros(2),R1D(2*pi*Qy)];
phi=30*pi/180;
r=2:-0.0001:0.1; turns=zeros(1,length(r)); turns2=turns; turns3=turns;
for k=1:length(r)
  x0=r(k)*cos(phi); y0=r(k)*sin(phi);
  turns(k)=survived_turns(NN,R,x0,y0,0,0);
  turns2(k)=survived_turns(NN,R,x0,y0,-0.05,0);
  turns3(k)=survived_turns(NN,R,x0,y0,-0.1,0);
end
loglog(r,turns,'k',r,turns2,'k--',r,turns3,'k-.','LineWidth',2)
axis([0.1,2,2,1700])
legend('d_x = 0','d_x = -0.05','d_x = -0.1')
xlabel('Starting position r'); ylabel('Survived turns')
set(gca,'FontSize',16);
