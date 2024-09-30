% dispersion_trajectory.m, V. Ziemann, 240828
clear; close 'all'
fodo=[ 1  5  0.5  0  ; 
       5  5  0.2 -0.1799; 
       1  3  0.5  0  ; 
       4  10 0.2  20/10 ; 
       1  3  0.5  0  ; 
       5  5  0.2  0.1799; 
       1  5  0.5  0  ];
beamline=repmat(fodo,3,1);
[Racc,spos,nmat,nlines]=calcmat(beamline);
delta0=1e-3;
x=delta0*reshape(Racc(1,3,:),1,nmat);
plot(spos,x*1e3,'k','LineWidth',2); xlabel('s [m]'); ylabel('x [mm]');
drawmag(beamline,0,1)
axis([0, max(spos), 0, 1.05e3*max(x)])
set(gca,'FontSize',16)