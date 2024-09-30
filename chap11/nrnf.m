% nrnf.m, non-resonant normal forms, V. Ziemann, 240829
function [K,C]=nrnf(H0,R)
%global BAS3 BAS3I BAS4 BAS4I
N=2; N1=N; N2=N*(N+1)/2; N3=N2*(N+2)/3; N4=N3*(N+3)/4; % size of subspaces
MM3=N1+N2+1:N1+N2+N3; MM4=N1+N2+N3+1:N1+N2+N3+N4;      % ranges of indices
K=0*H0; C=0*H0;             % initialize output arrays
[S1,S2,S3,S4]=adjoint3(R);  % calculate the S matrices
K(MM3)=inv(eye(N3)-S3)*H0(MM3);    % calculate K^(3) 
S3K3=0*K; S3K3(MM3)=S3*K(MM3);     % calculate S^(3)*K(3)
H3=0*H0; H3(MM3)=H0(MM3); H4=0*H0; H4(MM4)=H0(MM4); % init H^(3) and H^(4)
H4tmp=H4-0.5*PB(-S3K3,-H3);  % minus sign flips poisson bracket
[U,LAM,V]=svd(eye(N4)-S4);   % svd of 1-S^(4)
[val,pos]=min(diag(LAM));    % find position of smallest eigenvalue
P0=zeros(N4); 
if (abs(val)< 1e-10), P0=V(:,pos)*U(:,pos)'/(U(:,pos)'*V(:,pos)); end
C(MM4)=P0*H4tmp(MM4);
H4tmp(MM4)=H4tmp(MM4)-C(MM4);    % subtract from fourth order 
for j=1:N4
  if abs(LAM(j,j))>1e-10, LAM(j,j)=1/LAM(j,j); else, LAM(j,j)=0; end
end
K(MM4)=V*LAM*U'*H4tmp(MM4);   % calculate K^(4)


