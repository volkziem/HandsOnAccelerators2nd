% calcmat.m, calculate the transfer-matrices, V. Ziemann, 240827
function [Racc,spos,nmat,nlines]=calcmat(beamline)
ndim=size(DD(1),1); 
nlines=size(beamline,1);      % number of lines in beamline
nmat=sum(beamline(:,2))+1;    % sum over repeat-count in column 2
Racc=zeros(ndim,ndim,nmat);   % matrices from start to element-end
Racc(:,:,1)=eye(ndim);        % initialize first with unit matrix
spos=zeros(nmat,1);           % longitudinal position
ic=1;                         % element counter
for line=1:nlines             % loop over input elements
  for seg=1:beamline(line,2)  % loop over repeat-count 
     ic=ic+1;                 % next element          
     Rcurr=eye(2);            % matrix in next element
     switch beamline(line,1)  
       case 1   % drift
         Rcurr=DD(beamline(line,3));
       case 2    % thin quadrupole
         Rcurr=Q(beamline(line,4)); 
       case 5   % thick quadrupole
         Rcurr=QQ(beamline(line,3),beamline(line,4)); 
       otherwise
         disp('unsupported code')
     end		  
     Racc(:,:,ic)=Rcurr*Racc(:,:,ic-1);    % concatenate 
     spos(ic)=spos(ic-1)+beamline(line,3); % position of element   
  end
end