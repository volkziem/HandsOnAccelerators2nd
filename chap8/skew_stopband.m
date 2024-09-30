% skew_stopband.m, V. Ziemann, 240829
clear; close all
OO=@(mu)[cos(mu),sin(mu);-sin(mu),cos(mu)];
RR=@(mux,muy)[OO(mux),zeros(2);zeros(2),OO(muy)];
kappa=0.1;
Q=[0,0;kappa,0];
S=[eye(2),Q;Q,eye(2)];
k1=0.1; SS=eye(4); SS(2,1)=k1; SS(4,3)=-k1; 
hold on
for Qx=0:0.01:1
  for Qy=0:0.01:1
     R=SS*S*RR(2*pi*Qx,2*pi*Qy);
     if (max(abs(eig(R)'))>1.0001)
       plot(Qx,Qy,'k+');
     end
  end
  pause(0.001)
end
xlabel('Q_x'); ylabel('Q_y')






