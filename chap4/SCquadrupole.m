% SCquadrupole.m, V. Ziemann, 240828
clear; close all

%..........................describe geometry
a=30;
CS1=circlesegment(0.05,0.07,-a,a,10); nn=length(CS1);
CS2=circlesegment(0.05,0.07,90-a,90+a,10);
CS3=circlesegment(0.05,0.07,180-a,180+a,10);
CS4=circlesegment(0.05,0.07,270-a,270+a,10);

ws=0.2;
World=[2;4; -ws;ws;ws;-ws;-ws;-ws;ws;ws;zeros(nn-10,1)]; 

gd=[World,CS1,CS2,CS3,CS4];  % assemble geometry
ns=char('World','CS1','CS2','CS3','CS4')';  % names of the regions                 
sf='World+CS1+CS2+CS3+CS4'; 
g=decsg(gd,sf,ns);
model=createpde(1); geometryFromEdges(model,g);

figure('Name','Edgelabels');
pdegplot(model,'EdgeLabels','on');axis square 
figure('Name','Domainlabels'); 
pdegplot(model,'SubDomainLabels','on'); axis square 
set(gca,'FontSize',16)
%return;
generateMesh(model,'Hmax',0.01);
figure('Name','Mesh'); pdemesh(model); axis square;

applyBoundaryCondition(model,'Edge',[1,2,90,91],'u',0);

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-628,'Face',[1,3]);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',628,'Face',[2,4]);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',5);

result=solvepde(model);

figure('Name','Magnetic Potential'); 
pdeplot(model,'xydata',result.NodalSolution,'contour','on'); 
set(gca,'FontSize',16)
hold on; pdegplot(model); axis square

figure('Name','Flux density B');
Bx=result.YGradients; By=-result.XGradients; Bmag=hypot(Bx,By);
pdeplot(model,'xydata',result.NodalSolution,'xystyle','off', ...
  'flowdata',[Bx,By],'contour','on','colorbar','off'); axis equal;
%pdeplot(result.Mesh,XYData=Bmag,FlowData=[Bx,By]);
hold on; pdegplot(model);set(gca,'FontSize',16)

figure('Name','By in midplane');
x=-0.04:0.001:0.04; y=zeros(1,length(x));
[dAx,dAy]=evaluateGradient(result,x,y); Bx=dAy; By=-dAx; B=hypot(Bx,By);
plot(x,By,'k','LineWidth',2);
xlabel('x [m]'); ylabel('B_y [T]')
set(gca,'FontSize',16)