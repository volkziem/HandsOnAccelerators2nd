% TEMcoax.m, V. Ziemann, 240828
clear; close all; 
outer=[1;0;0;0.1]; inner=[1;0;0;0.02];
gd=[outer,inner]; ns=char('outer','inner')'; sf='outer-inner'; 
g=decsg(gd,sf,ns); 
model=createpde(1); geometryFromEdges(model,g);
figure('Name','Edges and Domains'); 
pdegplot(model,'EdgeLabels','on','SubDomainLabels','on'); axis equal
generateMesh(model,'Hmax',0.01);
figure('Name','Mesh'); pdemesh(model); axis equal;
applyBoundaryCondition(model,'Edge',1:4,'u',0); % outer
applyBoundaryCondition(model,'Edge',5:8,'u',1); % inner
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',1);
result=solvepde(model); Phi=result.NodalSolution;
Ex=-result.XGradients; Ey=-result.YGradients; Hx=-Ey; Hy=Ex;
figure('Name','Fields');
subplot(1,3,1); 
pdeplot(model,'XYData',Phi,'ZData',Phi,'ColorBar','off')
axis square; view([70,30]);
xlabel('x [m]'); ylabel('y [m]'); zlabel('\Phi [V]');
subplot(1,3,2); pdegplot(model); hold on; pdeplot(model,'flowdata',[Ex,Ey]); 
xlim([-0.12,0.12]); ylim([-0.12,0.12]); axis square; 
xlabel('x [m]'); ylabel('y [m]'); title('Transverse electric field');
subplot(1,3,3); pdegplot(model); hold on; pdeplot(model,'flowdata',[Hx,Hy]); 
xlim([-0.12,0.12]); ylim([-0.12,0.12]); axis square; 
xlabel('x [m]'); ylabel('y [m]'); title('Transverse magnetic field');
