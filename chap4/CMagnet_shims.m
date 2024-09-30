% CMagnet_shims.m, V. Ziemann, 240826
clear; close all

%..........................describe geometry
Cmag=[2; 8; ...    %..Yoke
    0;0;0.3;0.3;1;1;-0.6;-0.6; ...
    0;0.3;0.3;0.05;0.05;0.8;0.8;0];

C1=[2;4;0;0;0.3;0.3;  0.1;0.3;0.3;0.1;zeros(8,1)];
C2=[2;4;1;1;1.3;1.3;  0.1;0.3;0.3;0.1;zeros(8,1)]; 

dx=0.05; dy=0.002; % shim width and height
S1=[2;4;0.3;0.3+dx;0.3+dx;0.3;0.05-dy;0.05-dy;0.05;0.05;zeros(8,1)];
S2=[2;4;0.95;0.95+dx;0.95+dx;0.95;0.05-dy;0.05-dy;0.05;0.05;zeros(8,1)];

World=[2;4; -1;1.6;1.6;-1;0;0;1;1]; World=[World;zeros(8,1)]; 
gd=[World,Cmag,C1,C2,S1,S2];  % assemble geometry
ns=char('World','Cmag','C1','C2','S1','S2')';  % names of the regions                 
sf='World+Cmag+C1+C2+S1+S2';
g=decsg(gd,sf,ns); 
model=createpde(1); geometryFromEdges(model,g);
figure('Name','Edgelabels');
pdegplot(model,'EdgeLabels','on'); axis square;
figure('Name','Domainlabels');
pdegplot(model,'SubDomainLabels','on'); axis square; set(gca,'FontSize',16)
figure('Name','Mesh'); 
generateMesh(model,'Hmax',0.02); pdemesh(model); axis square;
%return

applyBoundaryCondition(model,'Edge',1:3,'u',0);
applyBoundaryCondition(model,'Edge',9:11,'q',0,'g',0);

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-0.8378,'Face',2);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0.8378,'Face',3);
specifyCoefficients(model,'m',0,'d',0,'c',1/5000,'a',0,'f',0,'Face',4:6);
result=solvepde(model);
figure('Name','Magnetic Potential'); 
pdeplot(model,'xydata',result.NodalSolution,'contour','on'); 
set(gca,'FontSize',16); hold on; pdegplot(model)

figure('Name','Flux density B');
Bx=result.YGradients; By=-result.XGradients; Bmag=hypot(Bx,By);
pdeplot(result.Mesh,XYData=Bmag,FlowData=[Bx,By]);
hold on; pdegplot(model);

figure('Name','Field in gap');
x=0.05:0.01:1.4; y=zeros(1,length(x));
[dAx,dAy]=evaluateGradient(result,x,y); Bx=dAy; By=-dAx; B=hypot(Bx,By);
plot(x,B,'k','LineWidth',2)
xlabel('x [m]'); ylabel('B [T]'); ylim([0,1.1]); 
set(gca,'FontSize',16);
%writematrix([x',B],'temp_shim_2mm.dat','delimiter','\t');
%dlmwrite('temp_shim_2mm.dat',[x',B],'delimiter','\t');

