% TM.m, Tranfer matrix from i1 to i2, V. Ziemann, 240829
function R=TM(ibl1,ibl2)
global Racc spos ipos nlines
if ibl2==nlines
  i2=length(spos);
else
  i2=ipos(min(ibl2+1,length(ipos)))-1; 
end
i1=ipos(ibl1);
R=Racc(:,:,i2)*sinv(Racc(:,:,i1-1));

