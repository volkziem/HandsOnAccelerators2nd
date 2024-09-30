% equipotential_lines.m, V. Ziemann, 240828
clear; close all
%Vpot=@(x,y)-y;                 % dipole
%Vpot=@(x,y)-0.5*x.*y;          % quadrupole
Vpot=@(x,y)-(3.*x.^2.*y-y.^3);  % sextupole
r=-5:0.05:5; [X,Y]=meshgrid(r,r); V=Vpot(X,Y); % Pot on fine grid
contour(X,Y,V,'LevelList',[0,quantile(V(:),10)],'Color','k');
r=-5:1:5; [XX,YY]=meshgrid(r,r); % Fields on coarse grid
V=Vpot(XX,YY); [Bx,By]=gradient(-V);
hold on; quiver(XX,YY,Bx,By,'Color','r');
axis square; axis off; xlim([-5,5]); ylim([-5,5])