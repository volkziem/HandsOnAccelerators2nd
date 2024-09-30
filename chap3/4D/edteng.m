% edteng.m, Edwards-Teng coupling parametrization, V. Ziemann, 240828
function [O,A,T,para]=edteng(R)
TRMN=0.5*(R(1,1)-R(3,3)+R(2,2)-R(4,4));
DETM=R(3,1)*R(4,2)-R(3,2)*R(4,1);
TR=R(1,3)*R(3,1)+R(1,4)*R(4,1)+R(2,3)*R(3,2)+R(2,4)*R(4,2);
CCMU=sqrt(TRMN*TRMN+2*DETM+TR)*sign(TRMN);
if (abs(DETM) < 1E-10 && abs(TR)<1E-10), CCMU=TRMN; end
QQ=TRMN/CCMU;
if (abs(QQ)>1), QQ=0; end
phi=0.5*acos(QQ);
DENOM=CCMU*sin(2D0*phi);
if (abs(DENOM)>1E-10) 
  D11=-(R(3,1)+R(2,4))/DENOM; D12=-(R(3,2)-R(1,4))/DENOM;
  D21=-(R(4,1)-R(2,3))/DENOM; D22=-(R(4,2)+R(1,3))/DENOM;
else
  D11=0; D12=0; D21=0; D22=0;
end
A11=R(1,1)-(D22*R(3,1)-D12*R(4,1))*tan(phi);
A12=R(1,2)-(D22*R(3,2)-D12*R(4,2))*tan(phi);
A21=R(2,1)-(D11*R(4,1)-D21*R(3,1))*tan(phi);
A22=R(2,2)-(D11*R(4,2)-D21*R(3,2))*tan(phi);
B11=R(3,3)+(D11*R(1,3)+D12*R(2,3))*tan(phi);
B12=R(3,4)+(D11*R(1,4)+D12*R(2,4))*tan(phi);
B21=R(4,3)+(D21*R(1,3)+D22*R(2,3))*tan(phi);
B22=R(4,4)+(D21*R(1,4)+D22*R(2,4))*tan(phi);
[Q1,alpha1,beta1,gamma1]=R2beta([A11,A12;A21,A22]);
[Q2,alpha2,beta2,gamma2]=R2beta([B11,B12;B21,B22]);
if ~isreal(Q1), disp('Mode 1 unstable'); end
if ~isreal(Q2), disp('Mode 2 unstable'); end

A=zeros(4);
A(1,1)=1/sqrt(beta1); A(2,1)=alpha1/sqrt(beta1); A(2,2)=sqrt(beta1);
A(3,3)=1/sqrt(beta2); A(4,3)=alpha2/sqrt(beta2); A(4,4)=sqrt(beta2);
O=eye(4);
O(1,1)=cos(2*pi*Q1); O(1,2)=sin(2*pi*Q1); 
O(2,1)=-O(1,2); O(2,2)=O(1,1);
O(3,3)=cos(2*pi*Q2); O(3,4)=sin(2*pi*Q2);
O(4,3)=-O(3,4); O(4,4)=O(3,3);
T=eye(4)*cos(phi);
T(3:4,1:2)=[D11,D12;D21,D22]*sin(phi);
T(1:2,3:4)=[-D22,D12;D21,-D11]*sin(phi);
para=[Q1,alpha1,beta1,Q2,alpha2,beta2,phi,D11,D12,D21,D22];

