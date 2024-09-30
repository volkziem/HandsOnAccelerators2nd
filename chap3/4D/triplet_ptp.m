% triplet_ptp.m, triplet point-to-point
clear all; close all
syms F L L1 L0

DD=@(L)[1,L;0,1];
QQ=@(F)[1,0;-1/F,1];

L0=5; L1=5; L=1; 

%F=-1.3956
%R=DD(L1)*QQ(2*F)*DD(L)*QQ(-F)*DD(L)*QQ(2*F)*DD(L0)

R=collect(DD(L1)*QQ(2*F)*DD(L)*QQ(-F)*DD(L)*QQ(2*F)*DD(L0))