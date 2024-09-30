% sagrub.m, Sagan and Rubin coupling parametrixation, V. Ziemann, 240828
function [O,A,T,p]=sagrub(R,flipped)
if nargin==1, flipped=0; end
M=R(1:2,1:2); N=R(3:4,3:4); m=R(1:2,3:4); n=R(3:4,1:2);
nplus=[n(2,2),-n(1,2);-n(2,1),n(1,1)]; 
H=m+nplus;
TRMN=trace(M-N); 
if TRMN==0, TRMN=1e-16; end
gamma=sqrt(0.5+0.5*sqrt(TRMN^2/(TRMN^2+4*det(H))));
C=-H*sign(TRMN)/(gamma*sqrt(TRMN^2+4*det(H)));
Cplus=[C(2,2),-C(1,2);-C(2,1),C(1,1)];
AA=gamma^2*M-gamma*(C*n+m*Cplus)+C*N*Cplus;
BB=gamma^2*N+gamma*(n*C+Cplus*m)+Cplus*M*C;
if flipped==1           % calculate the fipped mode
  gammaf=sqrt(1-gamma^2);
  AAf=C*BB*Cplus/gammaf^2;
  BBf=Cplus*AA*C/gammaf^2;
  C=-gamma*C/gammaf;   % update C to flipped version
  Cplus=[C(2,2),-C(1,2);-C(2,1),C(1,1)]; % and Cplus
  gamma=gammaf; AA=AAf; BB=BBf;          % and the others  
end
T=[gamma*eye(2),-C;Cplus,gamma*eye(2)];
[Q1,alpha1,beta1,gamma1]=R2beta(AA);
[Q2,alpha2,beta2,gamma2]=R2beta(BB);
if ~isreal(Q1), disp('Mode 1 unstable'); end
if ~isreal(Q2), disp('Mode 2 unstable'); end
A=zeros(4);
A(1,1)=1/sqrt(beta1); A(2,1)=alpha1/sqrt(beta1); A(2,2)=sqrt(beta1);
A(3,3)=1/sqrt(beta2); A(4,3)=alpha2/sqrt(beta2); A(4,4)=sqrt(beta2);
O=zeros(4);
O(1,1)=cos(2*pi*Q1); O(1,2)=sin(2*pi*Q1); 
O(2,1)=-O(1,2); O(2,2)=O(1,1);
O(3,3)=cos(2*pi*Q2); O(3,4)=sin(2*pi*Q2);
O(4,3)=-O(3,4); O(4,4)=O(3,3);
p=[Q1,alpha1,beta1,Q2,alpha2,beta2,gamma,C(1,1),C(1,2),C(2,1),C(2,2)];
