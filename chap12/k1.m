% k1.m, lattice focusing function, V. Ziemann, 240829
function out=k1(s)
kk1=0.29979*0.716792;  % quadrupole strength
out=zeros(length(s),1);
out(mod(s,10)>=2 & mod(s,10)<=3)=kk1;
out(mod(s,10)>=7 & mod(s,10)<=8)=-kk1;