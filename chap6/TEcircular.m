% TEcircular.m, V. Ziemann, 240820
clear all; close all; model=createpde(1);
waveguide=[1;0;0;0.1];
gd=waveguide;  % assemble geometry
ns=char('waveguide')';  % names of the regions                 
sf='waveguide'; [dl,bt]=decsg(gd,sf,ns);
geometryFromEdges(model,dl);
pdegplot(model,'EdgeLabels','on','SubDomainLabels','on'); axis equal
generateMesh(model,'Hmax',0.002); 
figure; pdemesh(model); axis equal;

applyBoundaryCondition(model,'Edge',1:4,'q',0,'g',0); % von Neumann
specifyCoefficients(model,'m',0,'d',1,'c',1,'a',0,'f',0,'Face',1);
result=solvepdeeig(model,[1,2000]); 
eigenvalues=result.Eigenvalues; Hz=result.Eigenvectors;
[p,e,t]=meshToPet(model.Mesh);
[dHx,dHy]=pdegrad(p,t,Hz(:,5)); Hx=-dHx; Hy=-dHy; Ex=dHy; Ey=-dHx;
figure; 
%pdesurf(p,t,Hz(:,5)); 
pdeplot(p,[],t,'XYData',Hz(:,5),'ZData',Hz(:,5),'ColorBar','off')
axis square; view([70,30]) 
figure;
subplot(1,2,1); pdegplot(model); hold on; pdeplot(model,'flowdata',[Ex;Ey]); 
axis square; title('Electric field');
subplot(1,2,2); pdegplot(model); hold on; pdeplot(model,'flowdata',[Hx;Hy]); 
axis square; title('Magnetic field');
