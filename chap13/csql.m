% csql.m, full vaktrak transfer matrix, V. Ziemann, 240829
function R=csql(c,s,q,L)
R=eye(3);
sq=sqrt(s/c); cc=cosh(sq*L); ss=sinh(sq*L); 
R(1,1)=cc;
R(1,2)=-ss/(c*sq);
R(1,3)=-q*(cc-1)/s;
R(2,1)=-c*sq*ss;
R(2,2)=cc;
R(2,3)=q*ss/sq;