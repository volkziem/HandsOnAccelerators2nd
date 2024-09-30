% layout.m, V. Ziemann, 240827
clear; close all
hold on
fodo=[ 1  1  2.5  0 ; 
       5  1  1.0  0 ; 
       1  1  1.5  0 ; 
       4  1  2.0  60; 
       1  1  1.5  0; 
       5  1  1.0  0; 
       1  1  2.5  0;];    
beamline=repmat(fodo,6,1);
%beamline=[fodo];
nlines=size(beamline,1);       % number of lines
nele=sum(beamline(:,2))+1;     % number of elements
vvpos=zeros(3,nele);           % element positions
f=fopen('layout.scad','w');   % open output file for 3D view
vv=[0;0;0];                    % x,y,z or origin
ww=eye(3);                     % orientation of tripod
ic=1;                          % element counter
for line=1:nlines              % loop over input elements
  for seg=1:beamline(line,2)   % loop over repeat-count
    v0=vv; w0=ww;              % remember previous point
    ic=ic+1;                     
    switch beamline(line,1)  
      case {1,2,5,7}   % drift, quadrupole, solenoid
        dv=[0;0;beamline(line,3)]; 
        dw=eye(3);
      case 4   % sector dipole
        phi=beamline(line,4)*pi/180;  % convert to radians
        if abs(phi)>1e-7
          rho=beamline(line,3)/phi;                 % bending radius
          dv=[rho*(cos(phi)-1);0.0;rho*sin(phi)];   % sagitta
          dw=wmake(0,-phi,0);
          dw2=wmake(0,-phi/2,0); % for 3D renderer only
        else
          dv=[0;0;beamline(line,3)]; 
          dw=eye(3); 
        end 
      case 20   % coordinate rotation
        dv=[0;0;0];
        dw=wmake(0,0,beamline(line,4)*pi/180);
      otherwise
        disp('unsupported code')
        dv=[0;0;0]; dw=eye(3);
    end   
    [vv,ww]=wprop(vv,ww,dv,dw);
    vvpos(:,ic)=vv';
    switch beamline(line,1)      % plots boxes for magnets and pipe
      case 4   % sector dipole
        drawbox(vv,v0,0.5,'b'); 
        draw3D(f,v0,w0*dw2,[1.,0.6,beamline(line,3)],[0,0,1]);
      case 5   % quadrupole
        drawbox(vv,v0,0.7,'r');
        draw3D(f,v0,w0,[0.8,0.8,beamline(line,3)],[1,0,0]);
      otherwise % draw beampipe
        draw3Dpipe(f,v0,w0,0.05,beamline(line,3));     
    end
  end
end
plot(vvpos(3,:),vvpos(1,:),'k','LineWidth',2);
set(gca,'FontSize',16)
xlim([-12,12]); ylim([-23,2])
axis equal
xlabel('z [m]'); ylabel('x [m]');
fprintf(f,'color([0.99,0.99,0.99]) translate([-23,-1.5,-13.5])');
fprintf(f,'cube([25,0.2,27]);');
fclose(f);
%system('openscad layout.scad &')


