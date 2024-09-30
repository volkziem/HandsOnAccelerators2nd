% F0.m, beam-beam kick, V. Ziemann, 240829
% requires the Faddeeva package from matlab central
% https://www.mathworks.com/matlabcentral/fileexchange/  ...
%  38787-faddeeva-package-complex-error-functions
function out=F0(x,y,sig)
r=1/sqrt(2*(sig(1,1)-sig(2,2)+2*1i*sig(1,2)));
detsig=sig(1,1)*sig(2,2)-sig(1,2)^2;
if abs(r) > 1e8      % round beam
    out=1i*(x-1i*y).*(1-exp(-0.5*(x.^2+y.^2)./sig(1,1)))./(x.^2+y.^2+1e-10);
    return
end
a1=r;
a2=1i*r;
b1=r*(sig(2,2)-1i*sig(1,2))/sqrt(detsig);
b2=1i*r*(sig(1,1)+1i*sig(1,2))/sqrt(detsig);
g=0.5*(sig(2,2)*x.^2-2*sig(1,2).*x.*y+sig(1,1)*y.^2)/detsig;
z1=a1*x+a2*y;
z2=b1*x+b2*y;
zz1=conj(z1);
zz2=conj(z2);
q1=(imag(z2)>=0);  % use one or the other form , depending on sign of
q2=1-q1;           % imaginary part of argument of w(z)
out1=Faddeeva_w(z1)-exp(-g).*Faddeeva_w(z2);
out1(isnan(out1))=0; out1(isinf(out1))=0;
out2=conj(Faddeeva_w(zz1)-exp(-g).*Faddeeva_w(zz2));
out2(isnan(out2))=0; out2(isinf(out2))=0;
out=sqrt(pi)*r*(q1.*out1-q2.*out2);
