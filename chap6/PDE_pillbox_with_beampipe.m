% PDE_pillbox_with_beampipe.m, V. Ziemann, 240828
clear; close all; 
rr=0.01;          % beam pipe radius
cr=0.23;  cl=0.3; % Cavity radius and length
Cav=[2;4; -cl/2;cl/2;cl/2;-cl/2;  0.0;0.0;cr;cr];   % cavity
Pl=[2;4; -0.4;-cl/2;-cl/2;-0.4;  0.0;0.0;rr;rr];    % pipe left
Pr=[2;4; cl/2;0.4;0.4;cl/2;  0.0;0.0;rr;rr];        % pipe right
gd=[Cav,Pl,Pr];                % assemble geometry
ns=char('Cavity','Pl','Pr')';  % names of the regions                 
sf='Cavity+Pl+Pr';             % geometry relations
g=decsg(gd,sf,ns); 
model=createpde(1); geometryFromEdges(model,g);
figure('Name','Edges and Domains');
pdegplot(model,'EdgeLabels','on','SubDomainLabels','on')
generateMesh(model,'Hmax',0.01);
figure('Name','Mesh'); pdemesh(model); % axis square;

applyBoundaryCondition(model,'Edge',[1,2,3,9,10],'u',0);       % Dirichlet
applyBoundaryCondition(model,'Edge',[6,7,8,5,12],'q',0,'g',0); % Neumann
cfun=@(location,state)-location.y;
dfun=@(location,state)-location.y;
specifyCoefficients(model,'m',0,'d',dfun,'c',cfun,'a',0,'f',0);

result=solvepdeeig(model,[1,800]); 

k2=result.Eigenvalues; Ez=result.Eigenvectors;
freq_GHz=sqrt(k2')*3e8/(2*pi*1e9)   % display the eigenfrequencies

mode=1;    % mode to view and analyze
[p,e,t]=meshToPet(model.Mesh);
F=pdeInterpolant(p,t,Ez(:,mode)); Ez0=evaluate(F,0,0);

figure('Name','Ez of mode 1'); 
pdeplot(model,'XYData',Ez(:,mode)/Ez0,'Contour','on','ColorBar','off')
hold on; pdegplot(model); 
xlabel('z [m]'); ylabel('r [m]');

figure('Name','Ez at two radii');
y=0:0.01:cr; x=0*cl*ones(1,length(y)); DD2=evaluate(F,x,y)/Ez0;
EEz=besselj(0,2.405*y/cr);
subplot(2,1,1); plot(y,DD2,'k',y,EEz,'k*','LineWidth',2); 
legend('Numerical','J_0(2.405*r/R)')
xlabel('r [m]'); ylabel('E_z/E_{z,max}'); xlim([0,cr]); ylim([0,1.08]);
set(gca,'FontSize',16);
x=-0.4:0.01:0.4; y=0*ones(1,length(x)); DD3=evaluate(F,x,y)/Ez0;
y=0.5*cr*ones(1,length(x)); DD4=evaluate(F,x,y)/Ez0;
subplot(2,1,2); plot(x,DD3,'k',x,DD4,'k:','LineWidth',2); 
xlabel('z [m]'); ylabel('E_z/E_{z,max}'); ylim([0,1.08]);
legend('E_z ar r=0','E_z at r=R/2')
set(gca,'FontSize',16);