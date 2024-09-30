% Symplectic inverse, V. Ziemann, 240829
function S=sinv(R)
S=zeros(2);
S(1,1)=R(2,2);
S(1,2)=-R(1,2);
S(2,1)=-R(2,1);
S(2,2)=R(1,1);
