% display_eigen_tunes.m, V. Ziemann, 240828
clear; close all
fodo=dlmread('fodo.bl'); fodor=dlmread('fodoroll_1deg.bl');
beamline=[fodo;fodor;repmat(fodo,6,1)];
k=0;
for ff=1.85:0.01:2.3
  k=k+1; xval(k)=ff;
  beamline(4,4)=ff;  % QF is 4th element and F is 4th column
  [Racc,spos,nmat,nlines]=calcmat(beamline);  % update lattice
  [O,A,T,p]=sagrub(Racc(:,:,end));            % eigen-tunes
  Q1(k)=p(1); Q2(k)=p(4);
end
plot(xval,Q1,'k*',xval,Q2,'k*'); xlim([1.83,2.32]);
xlabel(' Focal length [m]'); ylabel('Eigen tunes Q_1, Q_2')
set(gca,'FontSize',16)

