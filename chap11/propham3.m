% Propagates a Hamiltonian through transfer matrix R, V. Ziemann, 240829
function H1=propham3(R,H0)
N=2; N1=N; N2=N*(N+1)/2; N3=N2*(N+2)/3; N4=N3*(N+3)/4;
NM=length(H0); 
H1=zeros(NM,1);
[S1,S2,S3,S4]=adjoint3(R);  % this returns the S-matrices with transpose
H1(1:N1)=S1*H0(1:N1);
H1(N1+1:N1+N2)=S2*H0(N1+1:N1+N2);
H1(N1+N2+1:N1+N2+N3)=S3*H0(N1+N2+1:N1+N2+N3);
H1(N1+N2+N3+1:N1+N2+N3+N4)=S4*H0(N1+N2+N3+1:N1+N2+N3+N4);
