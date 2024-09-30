% centers2edges.m, V. Ziemann, 240819
% input: binning centers for a histogram
% output: the edges of those bins
function out=centers2edges(centers)
  dx=centers(2)-centers(1);
  out=centers-0.5*dx;
  out(end+1)=out(end)+dx;
end

