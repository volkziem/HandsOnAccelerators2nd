% TEwaveguide.m, V. Ziemann, 240828
clear; close all; 
waveguide=[2; 4;   0; 0.1; 0.1; 0;  0.05; 0.05; 0; 0];
gd=waveguide;           % assemble geometry
ns=char('waveguide')';  % names of the regions                 
sf='waveguide'; 
g=decsg(gd,sf,ns); 
model=createpde(1); geometryFromEdges(model,g);
figure('Name','Edges and Domains'); 
pdegplot(model,'EdgeLabels','on','SubDomainLabels','on'); axis equal
generateMesh(model,'Hmax',0.002); 
figure('Name','Mesh'); pdemesh(model); axis equal;

applyBoundaryCondition(model,'Edge',1:4,'q',0,'g',0); % von Neumann
specifyCoefficients(model,'m',0,'d',1,'c',1,'a',0,'f',0,'Face',1);

result=solvepdeeig(model,[1,5000]); 

eigenvalues=result.Eigenvalues; Hz=result.Eigenvectors;
[p,e,t]=meshToPet(model.Mesh);
[dHx,dHy]=pdegrad(p,t,Hz(:,2)); Hx=-dHx; Hy=-dHy; Ex=-dHy; Ey=dHx;
figure('Name','Magnetic field Hz');
pdeplot(p,[],t,'XYData',Hz(:,2),'ZData',Hz(:,2),'ColorBar','off')
axis square; view([70,30]);
xlabel('x [m]'); ylabel('y [m]'); zlabel('H_z [arb. units]')
figure('Name','Fields')
subplot(2,1,1); pdegplot(model); hold on; pdeplot(model,'flowdata',[Ex;Ey]); 
axis equal; title('Electric field');
subplot(2,1,2); pdegplot(model); hold on; pdeplot(model,'flowdata',[Hx;Hy]); 
axis equal; title('Magnetic field');
