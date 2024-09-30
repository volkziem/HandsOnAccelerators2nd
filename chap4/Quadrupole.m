% Quadrupole.m, V. Ziemann, 240826
clear; close all

%..........................describe geometry
yoke=[2;16; ...
  0; 0.25;0.3;0.3;0.2;0.2;0.15;0.07;0.06;0.05;0.04;0.03;0.02;0.10;0.10;0;
  0.3;0.3;0.25;0;0;0.1;0.1;0.02;0.0233;0.028;0.035;0.0467;0.07;0.15;0.2;0.2];
C1=[2;5;0.1;0.2;0.2;0.15;0.1;0;0;0.1;0.1;0.05;zeros(22,1)];
C2=[2;5;0;0.1;0.1;0.05;0;0.2;0.2;0.15;0.1;0.1;zeros(22,1)]; 
World=[2;5;  0.001;0.4;0.4;0;0;  0;0;0.4;0.4;0.001;  zeros(22,1)];

gd=[World,yoke,C1,C2];  % assemble geometry
ns=char('World','yoke','C1','C2')';  % names of the regions                 
sf='World+yoke+C1+C2'; 
g=decsg(gd,sf,ns);
model=createpde(1);
geometryFromEdges(model,g);

figure('Name','Edgelabels');
pdegplot(model,'EdgeLabels','on');axis square 
figure('Name','Domainlabels'); 
pdegplot(model,'SubDomainLabels','on'); axis square 

%....Meshing
generateMesh(model,'Hmax',0.005);
figure('Name','Mesh'); pdemesh(model);

applyBoundaryCondition(model,'Edge',1:3,'u',0);
applyBoundaryCondition(model,'Edge',[12:15,26:29],'q',0,'g',0);

specifyCoefficients(model,'m',0,'d',0,'c',1/5000,'a',0,'f',0,'Face',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',[2,5]);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-1.2566,'Face',3);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',1.2566,'Face',4);

result=solvepde(model);

figure('Name','Magnetic Potential'); 
pdeplot(model,'xydata',result.NodalSolution,'contour','on'); 
set(gca,'FontSize',16)
hold on; pdegplot(model); axis square

figure('Name','Flux density B');
Bx=result.YGradients; By=-result.XGradients; Bmag=hypot(Bx,By);
%pdeplot(model,'xydata',Bmag,'xystyle','off', ...
%  'flowdata',[Bx,By],'contour','on','colorbar','off'); 
pdeplot(result.Mesh,XYData=Bmag,FlowData=[Bx,By]);
hold on; pdegplot(model);

figure('Name','Field along diagonal');
x=0.001:0.001:0.035; y=x;  % Diagonal
[dAx,dAy]=evaluateGradient(result,x,y); Bx=dAy; By=-dAx; B=hypot(Bx,By);
plot(hypot(x,y),B,'k','LineWidth',2)
xlabel('r [m]'); ylabel('B [T]');
set(gca,'FontSize',16)
% dlmwrite('temp_Quad.dat',[x',B],'delimiter','\t');
