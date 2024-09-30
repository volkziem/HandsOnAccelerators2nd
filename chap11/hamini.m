% hamini.m, V. Ziemann, 240829
% returns the array M0, MM, CN
% M0(ii,1) is the power of x in monomial ii
% M0(ii,2) is the power of xp in monomial ii
% ii=MM(n+10*m) position ii with x^n*xp^m
% CN strings with the monomials, nice to have for display
function [M0,MM,CN]=hamini
global BAS3 BAS3I BAS4 BAS4I
N=2; NM=14;
M0=zeros(NM,N);
MM=-1000*ones(40,1);
%.....................first
ii=0;
for i1=1:N
  ii=ii+1;
  M0(ii,:)=0;
  M0(ii,i1)=1;
  MM(M0(ii,1)+10*M0(ii,2))=ii;
end
%.....................second
for i1=1:N
  for j1=i1:N
    ii=ii+1;
    M0(ii,:)=0;
    M0(ii,i1)=M0(ii,i1)+1;
    M0(ii,j1)=M0(ii,j1)+1;
    MM(M0(ii,1)+10*M0(ii,2))=ii;
  end
end
%.....................third
for i1=1:N
  for j1=i1:N
    for k1=j1:N
      ii=ii+1;
      M0(ii,:)=0;
      M0(ii,i1)=M0(ii,i1)+1;
      M0(ii,j1)=M0(ii,j1)+1;
      M0(ii,k1)=M0(ii,k1)+1;
      MM(M0(ii,1)+10*M0(ii,2))=ii;
    end
  end
end
%.....................fourth
for i1=1:N
  for j1=i1:N
    for k1=j1:N
      for l1=k1:N
        ii=ii+1;
        M0(ii,:)=0;
        M0(ii,i1)=M0(ii,i1)+1;
        M0(ii,j1)=M0(ii,j1)+1;
        M0(ii,k1)=M0(ii,k1)+1;
        M0(ii,l1)=M0(ii,l1)+1;
        MM(M0(ii,1)+10*M0(ii,2))=ii;
      end
    end
  end
end
%.....................................
CN={'X','XP','X^2','X*XP','XP^2', ...
  'X^3','X^2*XP','X*XP^2','XP^3', ...
  'X^4','X^3*XP','X^2*XP^2','X*XP^3','XP^4'};
%................................. *sqrt(2*Jx)^3
BAS3=[3/4,0,1/4,0;   % cos(x) 
  0,1/4,0,3/4;       % sin(x)
  1/4,0,-1/4,0;      % cos(3*x)
  0,1/4,0,-1/4];     % sin(3*x)
BAS3I=inv(BAS3);
%................................. *sqrt(2*Jx)^4
BAS4=[3/8,0,1/8,0,3/8;     % 1   
  1/2,0 , 0, 0, -1/2;      % cos(2*x)
  0,1/4,0,1/4,0;           % sin(2*x)
  1/8,0,-1/8,0,1/8;        % cos(4*x)
  0,1/8,0,-1/8,0];         % sin(4*x)
BAS4I=inv(BAS4);

