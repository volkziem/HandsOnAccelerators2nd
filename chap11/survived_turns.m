% survived_turns.m, V. Ziemann, 240829
function out=survived_turns(N,R,x0,y0,dx,dy)
x=[x0;0;y0;0]; out=N;
for k=1:N
  thetax=(x(1)-dx)^2-(x(3)-dy)^2; thetay=-2*(x(1)-dx)*(x(3)-dy);
  x=R*[x(1);x(2)-thetax;x(3);x(4)-thetay];
  if ((abs(x(1))>3) || (abs(x(3))>3)), out=k; return; end
end