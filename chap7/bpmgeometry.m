% bpmgeometry.m, V. Ziemann, 240820
clear; close all; 
bpm=[2; 8; -0.030;0.030;0.050;0.050;0.030;-0.030;-0.050;-0.050;  ...
  0.020;0.020;0.010;-0.010;-0.020;-0.020;-0.010;0.010];
dx=0.005; dy=-0.002;     % beam offset
beam=[1;dx;dy;0.001;zeros(14,1)];
gd=[bpm,beam];           % assemble geometry
ns=char('bpm','beam')';  % names of the regions                 
sf='bpm+beam'; 
g=decsg(gd,sf,ns); 
model=createpde(1); geometryFromEdges(model,g);
figure('Name','Edges and Domains');
pdegplot(model,'EdgeLabels','on','SubDomainLabels','on'); axis equal
generateMesh(model,'Hmax',0.002); 
figure('Name','Mesh'); pdemesh(model); axis equal;
applyBoundaryCondition(model,'Edge',1:8,'u',0);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',5.6e9,'Face',2);
result=solvepde(model); u=result.NodalSolution;
Ex=-result.XGradients; Ey=-result.YGradients; 
figure('Name','Beam position monitor'); pdegplot(model); hold on; 
pdeplot(model,'XYData',Ey,'Contour','on','Levels',200,'ColorBar','off')
axis([-0.054,0.054,-0.0299,0.0289]);
set(gca,'FontSize',16)

hold on
plot(-0.02,0.02,'r*',0.02,0.02,'r*',-0.02,-0.02,'r*',0.02,-0.02,'r*')
text(-0.021,0.024,'S_A','FontSize',16); text(0.019,0.024,'S_B','FontSize',16); 
text(-0.021,-0.025,'S_D','FontSize',16); text(0.019,-0.025,'S_C','FontSize',16); 

[Ex,Ey]=evaluateGradient(result,-0.02,0.02); Sa=abs(Ey);
[Ex,Ey]=evaluateGradient(result,0.02,0.02); Sb=abs(Ey);
[Ex,Ey]=evaluateGradient(result,0.02,-0.02); Sc=abs(Ey);
[Ex,Ey]=evaluateGradient(result,-0.02,-0.02); Sd=abs(Ey);
xpos=(Sb+Sc-Sa-Sd)/(Sa+Sb+Sc+Sd)
ypos=(Sa+Sb-Sc-Sd)/(Sa+Sb+Sc+Sd)
