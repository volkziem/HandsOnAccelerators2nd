% TMcircular.m, V. Ziemann, 240828
clear; close all; 
waveguide=[1;0;0;0.1];
gd=waveguide;  % assemble geometry
ns=char('waveguide')';  % names of the regions                 
sf='waveguide'; 
g=decsg(gd,sf,ns); 
model=createpde(1); geometryFromEdges(model,g);
figure('Name','Edges and Domains'); 
pdegplot(model,'EdgeLabels','on','SubDomainLabels','on'); axis equal
generateMesh(model,'Hmax',0.002); 
figure('Name','Mesh'); pdemesh(model); axis equal;

applyBoundaryCondition(model,'Edge',1:4,'u',0); % Dirichlet
specifyCoefficients(model,'m',0,'d',1,'c',1,'a',0,'f',0,'Face',1);

result=solvepdeeig(model,[1,2000]); 

eigenvalues=result.Eigenvalues; Ez=result.Eigenvectors;
[p,e,t]=meshToPet(model.Mesh);  % needed for pdegrad()

figure('Name','Fields');
mymode=1;
[dEx,dEy]=pdegrad(p,t,Ez(:,mymode)); Hx=dEx; Hy=-dEy; Ex=-dEx; Ey=-dEy;
subplot(2,3,1); 
pdeplot(model,'XYData',Ez(:,mymode),'ZData',Ez(:,mymode),'ColorBar','off')
axis square; view([70,30]);
xlabel('x [m]'); ylabel('y [m]'); zlabel('E_z [arb. units]')
subplot(2,3,2); pdegplot(model); hold on; pdeplot(model,'flowdata',[Ex;Ey]); 
xlim([-0.12,0.12]); ylim([-0.12,0.12]); axis square; 
xlabel('x [m]'); ylabel('y [m]'); title('Transverse electric field');
subplot(2,3,3); pdegplot(model); hold on; pdeplot(model,'flowdata',[Hx;Hy]); 
xlim([-0.12,0.12]); ylim([-0.12,0.12]); axis square; 
xlabel('x [m]'); ylabel('y [m]'); title('Transverse magnetic field');

mymode=2;
[dEx,dEy]=pdegrad(p,t,Ez(:,mymode)); Hx=dEx; Hy=-dEy; Ex=-dEx; Ey=-dEy;
subplot(2,3,4); 
pdeplot(model,'XYData',Ez(:,mymode),'ZData',Ez(:,mymode),'ColorBar','off')
axis square; view([70,30]);
xlabel('x [m]'); ylabel('y [m]'); zlabel('E_z [arb. units]')
subplot(2,3,5); pdegplot(model); hold on; pdeplot(model,'flowdata',[Ex;Ey]); 
xlim([-0.12,0.12]); ylim([-0.12,0.12]); axis square; 
xlabel('x [m]'); ylabel('y [m]'); title('Transverse electric field');
subplot(2,3,6); pdegplot(model); hold on; pdeplot(model,'flowdata',[Hx;Hy]); 
xlim([-0.12,0.12]); ylim([-0.12,0.12]); axis square; 
xlabel('x [m]'); ylabel('y [m]'); title('Transverse magnetic field');
