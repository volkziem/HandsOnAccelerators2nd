% collide_slices.m, V. Ziemann, 240829
% siga = 4x4 sigma matrix of beam a
% Xa = 4x1 centroid positions of beam a
% Na = number of particles in beam a
function [siga2,Xa2,sigb2,Xb2,lumi]=collide_slices(siga,Xa,Na,sigb,Xb,Nb,dz,gamma)
Relec=2.8179e-15;        % classical electron radius
sx=sqrt(sigb(1,1)); sy=sqrt(sigb(3,3));
fxinv=2*Nb*Relec/(gamma*sx*(sx+sy));
fyinv=2*Nb*Relec/(gamma*sy*(sx+sy));
Ra=CTM(dz,fxinv,fyinv);        % Field from b to deflect a
sx=sqrt(siga(1,1)); sy=sqrt(siga(3,3));
fxinv=2*Na*Relec/(gamma*sx*(sx+sy));
fyinv=2*Na*Relec/(gamma*sy*(sx+sy));
Rb=CTM(dz,fxinv,fyinv);         % Field from a to deflect b
ssig=[siga(1,1)+sigb(1,1),siga(1,3)+sigb(1,3); ...
    siga(1,3)+sigb(1,3),siga(3,3)+sigb(3,3)];
lumi=Na*Nb/(2*pi*sqrt(det(ssig)));
Xa2=Ra*Xa; siga2=Ra*siga*Ra';  % update beam a
Xb2=Rb*Xb; sigb2=Rb*sigb*Rb';  % and beam b


