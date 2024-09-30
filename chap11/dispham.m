% displays a hamiltonian, V. Ziemann, 240829
function dispham(H0,TXT)
global M0 MM CN
disp(' '); disp(TXT)
for ii=1:length(H0)
  if (abs(H0(ii))>1e-10)
    fprintf('%3d   %12g * %s\n',ii,H0(ii),char(CN(ii)));
  end
end