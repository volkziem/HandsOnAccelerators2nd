% doublett_ptp.m, doublet point-to-point
clear
syms F L L1 n

DD=@(L)[1,L;0,1];
QQ=@(F)[1,0;-1/F,1];
 
L=1; L1=5*L;  

%F=1.507556722888818
%F=0.894427190999916
%F=0.577350269189626
%F=sqrt(25/11);
F=sqrt(25/11)*L;

R=DD(L1)*QQ(F)*DD(L)*QQ(-F)*DD(L1)

%R=collect(DD(5*L)*QQ(F)*DD(L)*QQ(-F)*DD(5*L))