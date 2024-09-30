% henon2D_threecurves.m, V. Ziemann, 240829
clear; close all;
NN=1000;    % maximum number of turns
Qx=0.31; Qy=0.28;
R1D=@(mu)[cos(mu),sin(mu);-sin(mu),cos(mu)];
R=[R1D(2*pi*Qx),zeros(2);zeros(2),R1D(2*pi*Qy)];
hold on
for phi=0:pi/100:pi   % no misalignment, dx=dy=0
  nmax=12; dr=10; r=dr;
  while (nmax)
     dr=0.5*dr;
     x0=r*cos(phi); y0=r*sin(phi);
     if (survived_turns(NN,R,x0,y0,0,0)==NN), r=r+dr; else, r=r-dr; end
     nmax=nmax-1;
  end
  plot(x0,y0,'k*');
end
ylim([0,0.52]); 

for phi=0:pi/100:pi   % dx=-0.05, dy=0
  nmax=12; dr=10; r=dr;
  while (nmax)
     dr=0.5*dr;
     x0=r*cos(phi); y0=r*sin(phi);
     if (survived_turns(NN,R,x0,y0,-0.05,0)==NN), r=r+dr; else, r=r-dr; end
     nmax=nmax-1;
  end
  plot(x0,y0,'k+');
end

for phi=0:pi/100:pi  % dx=-0.1, dy=0
  nmax=12; dr=10; r=dr;
  while (nmax)
     dr=0.5*dr;
     x0=r*cos(phi); y0=r*sin(phi);
     if (survived_turns(NN,R,x0,y0,-0.1,0)==NN), r=r+dr; else, r=r-dr; end
     nmax=nmax-1;
  end
  plot(x0,y0,'kx');
end

xlim([-0.39,0.52])  
plot([0,0.4],[0,0.4],'k:','LineWidth',2)
xlabel('$\hat x$','interpreter','latex'); 
ylabel('$\hat y$','interpreter','latex'); 
set(gca,'FontSize',16);