% adjoint3.m, V. Ziemann, 240829
% constructs the matrices to propagate thehamiltonian coefficients
% remember, they transform with the transpose of the inverse 
% transpose is done at the end
function [S1,S2,S3,S4]=adjoint3(R)
global M0 MM CN
N=2; N1=N; N2=N*(N+1)/2; N3=N2*(N+2)/3; N4=N3*(N+3)/4;
IR=zeros(1,N);
R=sinv(R);  % first invert the transfer matrix
%................first order
S1=R;
%...............second order
S2=zeros(3);
ii=0;
for i1=1:N
  for j1=i1:N
    ii=ii+1;
    for i2=1:N
      for j2=1:N
        IR(:)=0;
        IR(i2)=IR(i2)+1;
        IR(j2)=IR(j2)+1;
        jj=MM(IR(1)+10*IR(2))-N1;
        S2(ii,jj)=S2(ii,jj)+S1(i1,i2)*S1(j1,j2);      
      end
    end
  end
end
%...............third order
S3=zeros(4);
ii=0;
for i1=1:N
  for j1=i1:N
    for k1=j1:N
      ii=ii+1;
      for i2=1:N
        for j2=1:N
          for k2=1:N
            IR(:)=0;
            IR(i2)=IR(i2)+1;
            IR(j2)=IR(j2)+1;
            IR(k2)=IR(k2)+1;
            jj=MM(IR(1)+10*IR(2))-N1-N2;
            S3(ii,jj)=S3(ii,jj)+S1(i1,i2)*S1(j1,j2)*S1(k1,k2);
          end
        end
      end
    end
  end
end
%...............fourth order
S4=zeros(5); 
ii=0;
for i1=1:N
  for j1=i1:N
    for k1=j1:N
      for l1=k1:N
        ii=ii+1;     
        for i2=1:N
          for j2=1:N
            for k2=1:N
              for l2=1:N
                IR(:)=0;
                IR(i2)=IR(i2)+1;
                IR(j2)=IR(j2)+1;
                IR(k2)=IR(k2)+1;
                IR(l2)=IR(l2)+1;
                jj=MM(IR(1)+10*IR(2))-N1-N2-N3;
                S4(ii,jj)=S4(ii,jj)+S1(i1,i2)*S1(j1,j2)*S1(k1,k2)*S1(l1,l2);
              end
            end
          end
        end
      end
    end
  end
end

% return the transpose, because that maps the hamiltonian coefficients
S1=S1'; S2=S2'; S3=S3'; S4=S4';


