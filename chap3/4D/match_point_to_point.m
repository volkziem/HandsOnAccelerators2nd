% match_point_to_point.m, match the R12
  clear;
  global beamline
  beamline=[1,  1,  1,  0;    % g
            2,  1,  0,  3;    % f
            1,  1,  2,  0];   % b  
  f0=3;  % starting guess
  [f,fval]=fminsearch(@chisq_R12,f0)