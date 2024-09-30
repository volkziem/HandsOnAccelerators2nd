% SCdipole_ideal.m, V. Ziemann, 240826
clear; close all

%..........................describe geometry
C1=[1;0.05;0;0.5;zeros(6,1)];
C2=[1;-0.05;0;0.5;zeros(6,1)];
World=[2;4; -1;1;1;-1;-1;-1;1;1]; 

gd=[World,C1,C2];  % assemble geometry
ns=char('World','C1','C2')';  % names of the regions                 
sf='World+(C1-C2)'; 
g=decsg(gd,sf,ns);
model=createpde(1);
geometryFromEdges(model,g);

figure('Name','Edgelabels');
pdegplot(model,'EdgeLabels','on');axis square 
figure('Name','Domainlabels'); 
pdegplot(model,'SubDomainLabels','on'); axis square 
set(gca,'FontSize',16)

figure('Name','Mesh'); generateMesh(model,'Hmax',0.05);
pdemesh(model); axis square;

applyBoundaryCondition(model,'Edge',1:4,'u',0);

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',[1,4]);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',100,'Face',2);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-100,'Face',3);

result=solvepde(model);

figure('Name','Magnetic Potential'); 
pdeplot(model,'xydata',result.NodalSolution,'contour','on'); 
set(gca,'FontSize',16)
hold on; pdegplot(model); axis square

figure('Name','Flux density B');
Bx=result.YGradients; By=-result.XGradients; Bmag=hypot(Bx,By);
pdeplot(model,'xydata',result.NodalSolution,'xystyle','off', ...
  'flowdata',[Bx,By],'contour','on','colorbar','off'); 
%pdeplot(result.Mesh,XYData=Bmag,FlowData=[Bx,By]);
hold on; pdegplot(model);

figure('Name','Field in midplane');
x=-0.4:0.01:0.4; y=zeros(1,length(x));
[dAx,dAy]=evaluateGradient(result,x,y); Bx=dAy; By=-dAx; B=hypot(Bx,By);
plot(x,By,'k','LineWidth',2); 
xlabel('x [m]'); ylabel('B [T]'); ylim([0,4.7]);
set(gca,'FontSize',16)

