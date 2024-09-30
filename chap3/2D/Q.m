% QT.m thin quadrupole, V. Ziemann, 240827
function out=Q(F)
out=eye(2);
if abs(F)<1e-8, return; end
out=[1,0;-1/F,1];
