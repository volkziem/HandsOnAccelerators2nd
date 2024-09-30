% circlesegment.m, V. Ziemann, 240828
function cseg=circlesegment(Ri,Ro,phi1,phi2,N)
p1=phi1*pi/180; p2=phi2*pi/180;
dphi=(p2-p1)/N;
xlist=zeros(1,2*N+2); ylist=xlist;
ic=0;
for k=0:N
  ic=ic+1;
  xlist(ic)=Ri*cos(p1+k*dphi); 
  ylist(ic)=Ri*sin(p1+k*dphi);
end
for k=0:N
  ic=ic+1;  
  xlist(ic)=Ro*cos(p2-k*dphi); 
  ylist(ic)=Ro*sin(p2-k*dphi);
end
cseg=[2;ic;xlist';ylist'];
