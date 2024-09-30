% CBH.m, Campbell-Baker-Hausdorff, V. Ziemann, 240829
function H3=CBH(H1,H2)
Haux=PB(H1,H2);
H3=H1+H2+0.5*Haux+PB(H1-H2,Haux)/12;