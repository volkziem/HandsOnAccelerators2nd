% SCdipole_real.m, V. Ziemann, 240828
clear; close all

%..........................describe geometry
CS1=circlesegment(0.05,0.07,180-60,180+60,10); nn=length(CS1);
CS2=circlesegment(0.05,0.07,-60,60,10);

ws=0.2;
World=[2;4; -ws;ws;ws;-ws;-ws;-ws;ws;ws;zeros(nn-10,1)]; 


gd=[World,CS1,CS2];  % assemble geometry
ns=char('World','CS1','CS2')';  % names of the regions                 
sf='World+CS1+CS2'; 
g=decsg(gd,sf,ns);
model=createpde(1); geometryFromEdges(model,g);

figure('Name','Edgelabels');
pdegplot(model,'EdgeLabels','on');axis square 
figure('Name','Domainlabels'); 
pdegplot(model,'SubDomainLabels','on'); axis square 
set(gca,'FontSize',16)

generateMesh(model,'Hmax',0.005);
figure('Name','Mesh'); pdemesh(model); axis square;

applyBoundaryCondition(model,'Edge',[1,2,46,47],'u',0);

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',628,'Face',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-628,'Face',2);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',3);

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
x=-0.04:0.001:0.04; y=zeros(1,length(x));
[dAx,dAy]=evaluateGradient(result,x,y); Bx=dAy; By=-dAx; B=hypot(Bx,By);
plot(x,B,'k','LineWidth',2);
xlabel('x [m]'); ylabel('B [T]')
set(gca,'FontSize',16)

