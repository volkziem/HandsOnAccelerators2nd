% vtmini.m, minimal vaktrak, V. Ziemann, 180710
% supported codes with ordering: CODE,repeat,L,c,s,q
%   conductance only:    1, rep,  L,  c, 0,  0 
%   short pump:          2,   1,  0,  0, S,  0
%   short gas source:    3,   1,  0,  0, 0, dQ
%   generic element:     4, rep,  L,  c, s,  q  
% use repmat() and flip() to assemble larger systems
clear; close all

conduc=@(C)[1,-1/C,0; 0,1,0; 0,0,1];  % matrix for conductance
pump=@(S)[1,0,0;-S,1,0;0,0,1];        % matrix for short pump
outgas=@(dQ)[1,0,0;0,1,dQ;0,0,1];     % matrix for gas source, leak
%function csql.m defined externally
%
%       CODE  repeat   L     c     s     q
vaksys=[ 3,     1,     0,    0,    0,    1e-6;   % outgas, dQ
         1,   100,   0.1,   10,    0,    0;      % conductance, c
         2,     1,     0,    0,  100,    0];     % pump, S

v=[vaksys; flip(vaksys,1)];
beamline=repmat(v,2,1);      % description of the complete system

nlines=size(beamline,1);      % number of elements in beamline
nmat=sum(beamline(:,2))+1;    % number of matrices, incl repeat count           
Racc=zeros(3,3,nmat);         % accumulated transfer matrices
Racc(:,:,1)=eye(3);           % initialize the first one
spos=zeros(nmat,1);           % array for element (end-)positions

ic=1;
for line=1:nlines             % loop over elements
  for seg=1:beamline(line,2)  % and over the segements of each element
    ic=ic+1;                  % element counter
    Rcurr=eye(3);             % initialize to unit matrix
    switch beamline(line,1)   % brach accoding to element
      case 1       % pure conductance
        C=beamline(line,4)/beamline(line,3);   % C=c/L
        Rcurr=conduc(C);                       % large C 
      case 2       % short pump, zero length
        Rcurr=pump(beamline(line,5));          % large S
      case 3  % point-like gas source, zero length
        Rcurr=outgas(beamline(line,6));        % large dQ
      case 4  % generic element, c,s,q,L are all given
        Rcurr=csql(beamline(line,4),beamline(line,5),...
          beamline(line,6),beamline(line,3));
      otherwise
         disp('unsupported code')
    end
    Racc(:,:,ic)=Rcurr*Racc(:,:,ic-1);      % add new element  
    spos(ic)=spos(ic-1)+beamline(line,3);   % update the position
  end
end
R0=Racc(:,:,end);    % alias for the start-to-end matrix

%....find solution with Qr=Ql=0
Pr=-R0(2,3)/R0(2,1);
Pl=R0(1,3)-R0(1,1)*R0(2,3)/R0(2,1);
P0r=[Pr;0;1]; % vector at start

pressure=zeros(nmat,1); gasflow=pressure;   % allocate memory
for k=1:nmat            % loop over all elements
  PP=Racc(:,:,k)*P0r;   % and calculate [P;Q;1] at end of each element     
  pressure(k)=PP(1);    % stuff into arrays used for plotting
  gasflow(k)=PP(2);     
end
%...............make plots with pressure and gasflow profiles
figure('Name','Pressure and gasflow profiles'); 
subplot(2,1,1); semilogy(spos,pressure,'k','LineWidth',2); 
xlim([0,spos(end)]); ylim([0.6*min(pressure),2.5*max(pressure)])
xlabel('z [m]'); ylabel('Pressure [mbar]');
set(gca,'FontSize',16)
subplot(2,1,2); plot(spos,gasflow,'k','LineWidth',2); 
xlim([0,spos(end)]); ylim([1.4*min(gasflow),1.4*max(gasflow)])
xlabel('z [m]'); ylabel('Gasflow [mbar l/s]')  
set(gca,'FontSize',16)