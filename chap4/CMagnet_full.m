% CMagnet_full.m, V. Ziemann, 240826
clear; close all
%..........................describe geometry
yoke=[2; 13; ...    %..Yoke
    0;0;0.3;0.3;1;1;-0.6;-0.6;1;1;0.3;0.3;0; ...
    0;0.3;0.3;0.05;0.05;0.8;0.8;-0.8;-0.8;-0.05;-0.05;-0.3;-0.3];
%..coils
C1=[3;4;0;0;0.3;0.3;  0.1;0.3;0.3;0.1;zeros(18,1)];
C2=[3;4;1;1;1.3;1.3;  0.1;0.3;0.3;0.1;zeros(18,1)];
dy=0.4;
C3=[3;4;0;0;0.3;0.3;  0.1-dy;0.3-dy;0.3-dy;0.1-dy;zeros(18,1)];
C4=[3;4;1;1;1.3;1.3;  0.1-dy;0.3-dy;0.3-dy;0.1-dy;zeros(18,1)];
World=[3;4;-1.8;1.8;1.8;-1.8;-1.2;-1.2;1.2;1.2;zeros(18,1)];
%.....................................................
gd=[World,yoke,C1,C2,C3,C4];  % assemble geometry
ns=char('World','yoke','C1','C2','C3','C4')';  % names of the regions                 
sf='World+yoke+C1+C2+C3+C4';
g=decsg(gd,sf,ns); 
model=createpde(1); 
geometryFromEdges(model,g);
figure('Name','Edgelabels');
pdegplot(model,'EdgeLabels','on'); set(gca,'FontSize',16);
figure('Name','Domainlabels'); 
pdegplot(model,'SubDomainLabels','on'); set(gca,'FontSize',16);
% return
figure('Name','Mesh'); generateMesh(model,'Hmax',0.05); 
pdemesh(model); set(gca,'FontSize',16);

applyBoundaryCondition(model,'Edge',[1,2,25,26],'u',0);

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0.8378,'Face',[2,4]);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-0.8378,'Face',[3,5]);
specifyCoefficients(model,'m',0,'d',0,'c',1/5000,'a',0,'f',0,'Face',6);

result=solvepde(model); %.. solve

figure('Name','Magnetic Potential'); 
pdeplot(model,'XYdata',result.NodalSolution,'contour','on');
hold on; pdegplot(model); set(gca,'FontSize',16); % geometry

figure('Name','Flux density B');
Bx=result.YGradients; By=-result.XGradients; Bmag=hypot(Bx,By);
pdeplot(result.Mesh,XYData=Bmag,FlowData=[Bx,By]);
hold on; pdegplot(model);

x=0.05:0.01:1.4; y=zeros(1,length(x));
[dAx,dAy]=evaluateGradient(result,x,y); Bx=dAy; By=-dAx; B=hypot(Bx,By);
figure('Name','Field in gap'); plot(x,B,'k','LineWidth',2)
xlabel('x [m]'); ylabel('B [T]'); ylim([0,1.1]); 
set(gca,'FontSize',16);
%dlmwrite('temp_field.dat',[x',B],'delimiter','\t');
