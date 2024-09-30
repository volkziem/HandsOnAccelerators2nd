% wmake.m, rotation around Euler angles, V. Ziemann, 240827
function dw=wmake(phix,phiy,phiz)
wx=eye(3); 
wx(2,2)=cos(phix); wx(3,3)=wx(2,2);
wx(2,3)=sin(phix); wx(3,2)=-wx(2,3);
wy=eye(3); 
wy(1,1)=cos(phiy); wy(3,3)=wy(1,1);
wy(1,3)=sin(phiy); wy(3,1)=-wy(1,3);
wz=eye(3);
wz(1,1)=cos(phiz); wz(2,2)=wz(1,1);
wz(1,2)=sin(phiz); wz(2,1)=-wz(1,2);
dw=wx*wy*wz;
