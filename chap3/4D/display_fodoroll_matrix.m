% display_fodoroll_matrix.m, V. Ziemann
clear all; close all
fodo=dlmread('fodoroll.bl');
beamline=repmat(fodo,1,1);
[Racc,spos,nmat,nline]=calcmat(beamline);
Rturn=Racc(:,:,end) 
