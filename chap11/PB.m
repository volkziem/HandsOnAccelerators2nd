% PB.m, Poisson bracket, V. Ziemann, 240829
function H3=PB(H1,H2)
global M0 MM
NM=length(H1); H3=zeros(NM,1);
for ii=1:NM
  if abs(H1(ii))<1e-10, continue; end
  i1=M0(ii,1); i2=M0(ii,2);
  for jj=1:NM
    if abs(H2(jj))<1e-10, continue; end
    j1=M0(jj,1); j2=M0(jj,2);
    x12=H1(ii)*H2(jj); l1=i1*j2-i2*j1; 
    if (l1==0), continue; end
    k1=i1+j1-1; if (k1<0 || k1>4), continue; end
    k2=i2+j2-1; if (k2<0 || k2>4), continue; end
    if (k1+k2>4), continue; end  % limit to octupole order
    kk=MM(k1+k2*10);
    H3(kk)=H3(kk)+x12*l1;
  end
end
