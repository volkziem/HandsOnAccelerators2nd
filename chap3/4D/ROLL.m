% ROLL.m, roll-angle around s-axis, V. Ziemann, 240828
function out=ROLL(phi)  % phi in degree
c=cos(phi*pi/180); s=sin(phi*pi/180);
out=zeros(4);
out(1,1)=c; out(1,3)=s; out(2,2)=c; out(2,4)=s;
out(3,1)=-s; out(3,3)=c; out(4,2)=-s; out(4,4)=c;