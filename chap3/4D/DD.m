% DD.m, drift space, V. Ziemann, 240828
function out=DD(L)
out=eye(4);
out(1,2)=L;
out(3,4)=L;
