% periodic_dispersion.m, V. Ziemann, 240828
function D0=periodic_dispersion(Rend)
D=(eye(2)-Rend(1:2,1:2))\Rend(1:2,3);
D0=[D;1];