% wprop.m, updates the new vector vv and matrix ww, V. Ziemann, 240827
function [vnew,wnew]=wprop(vv,ww,dv,dw)
vnew=vv+ww*dv;
wnew=ww*dw;
