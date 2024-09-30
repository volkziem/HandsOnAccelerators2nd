% blcomp.m, V. Ziemann, 240828
function [Ig,beta,tanpsi]=blcomp(Vhat,R,phisdeg,Ib)
phis=phisdeg*pi/180;
Pc=Vhat^2./(2*R);
Pb=Ib.*Vhat.*cos(phis);
beta=1+Pb./Pc;
tanpsi=-tan(phis).*(beta-1)./(beta+1);
Ig=(1+1i*tanpsi).*(1+beta).*Vhat.*exp(1i*phis)./R + 2.*Ib;