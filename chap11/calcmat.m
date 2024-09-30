% calcmat.m, calculate the transfer-matrices, V. Ziemann, 240829
function [Racc,spos,nmat,nlines,ipos]=calcmat(beamline)
ndim=size(DD(1),1);  
nlines=size(beamline,1);      % number of lines in beamline
ipos=zeros(nlines,1);
nmat=sum(beamline(:,2))+1;    % sum over repeat-count in column 2
Racc=zeros(ndim,ndim,nmat);   % matrices from start to element-end
Racc(:,:,1)=eye(ndim);        % initialize first with unit matrix
spos=zeros(nmat,1);           % longitudinal position
ic=1;                         % element counter
for line=1:nlines             % loop over input elements
  ipos(line)=ic+1;
  for seg=1:beamline(line,2)  % loop over repeat-count 
     ic=ic+1;                 % next element          
     Rcurr=eye(ndim);         % matrix in next element
     switch beamline(line,1)  
       case 1   % drift
         Rcurr=DD(beamline(line,3));
       case 2    % thin quadrupole
         %Rcurr=Q(beamline(line,4));   
         k1=0.29979*beamline(line,4)/beamline(line,6);
         Rcurr=QQ(k1,beamline(line,3));
       case 5   % thick quadrupole
         Rcurr=QQ(beamline(line,3),beamline(line,4));
       case 201  % phase advance or tune
         cc=cos(2*pi*beamline(line,4));
         ss=sin(2*pi*beamline(line,4));
         Rcurr=[cc,ss;-ss,cc];
       case {0,1000,1002,1003,1004}
         Rcurr=eye(ndim);
       otherwise
         disp('unsupported code')
     end		  
     Racc(:,:,ic)=Rcurr*Racc(:,:,ic-1);    % concatenate 
     spos(ic)=spos(ic-1)+beamline(line,3); % position of element   
  end
end