% celltm.m, V. Ziemann, 240828
% Calculate the 2x2 transfer matrix for a doublet lattice with
% the following setup  <--(L)(F)(L2)(-F)(L)<--
%     Usage: R=celltm(l,l2,f)
function R=celltm(l,l2,f)
R(1,1)=1+l2/f-l*l2/f^2;
R(2,2)=1-l2/f-l*l2/f^2;
R(2,1)=-l2/f^2;
R(1,2)=2*l+l2-l2*l^2/f^2;
return