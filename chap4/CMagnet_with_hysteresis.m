% CMagnet_with_hysteresis.m, V. Ziemann, 240826
clear; close all
%..........................describe geometry
Cmag=[2; 8; ...    %..Yoke
    0;0;0.3;0.3;1;1;-0.6;-0.6; ...
    0;0.3;0.3;0.05;0.05;0.8;0.8;0];

C1=[2;4;0;0;0.3;0.3;  0.1;0.3;0.3;0.1;zeros(8,1)];
C2=[2;4;1;1;1.3;1.3;  0.1;0.3;0.3;0.1;zeros(8,1)]; 

World=[2;4; -1;1.6;1.6;-1;0;0;1;1]; World=[World;zeros(8,1)]; 
gd=[World,Cmag,C1,C2];  % assemble geometry
ns=char('World','Cmag','C1','C2')';  % names of the regions                 
sf='World+Cmag+C1+C2'; 
g=decsg(gd,sf,ns); 
model=createpde(1); geometryFromEdges(model,g);
figure('Name','Edgelabels');
pdegplot(model,'EdgeLabels','on'); axis square;
figure('Name','Domainlabels');
pdegplot(model,'SubDomainLabels','on'); axis square;
%return
figure('Name','Mesh'); 
generateMesh(model,'Hmax',0.02); pdemesh(model);

applyBoundaryCondition(model,'Edge',1:3,'u',0);
applyBoundaryCondition(model,'Edge',8:10,'q',0,'g',0);

muR=@(B)5000*(0.01+0.5*erfc((B-1.5)/0.3)); % define nonlinear muR
mufun=@(location,state)1./muR(hypot(state.ux,state.uy));

specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'Face',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-0.8378,'Face',2);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0.8378,'Face',3);
specifyCoefficients(model,'m',0,'d',0,'c',mufun,'a',0,'f',0,'Face',4);

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
dlmwrite('temp_nonlin.dat',[x',B],'delimiter','\t');

