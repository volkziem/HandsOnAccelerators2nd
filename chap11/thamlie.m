% Constructs Hamiltonians, V.  Ziemann, 240829
function H0=thamlie(strength,M)
H0=zeros(14,1);
switch (M) 
  case 2    % quadrupole
    H0(3)=strength/2;
  case 3    % sextupole
    H0(6)=strength/6;
  case 4    % octupole
    H0(10)=strength/24; 
  otherwise
    disp('ERROR(thamlie): unsupported code')
end
