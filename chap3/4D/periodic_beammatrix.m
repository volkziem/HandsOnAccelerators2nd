% periodic_beammatrix.m, V. Ziemann, 240828
function sigma=periodic_beammatrix(Rend,epsx,epsy)
[Qx,alphax,betax,gammax]=R2beta(Rend(1:2,1:2));
[Qy,alphay,betay,gammay]=R2beta(Rend(3:4,3:4));
sigma=zeros(4,4);
sigma(1:2,1:2)=epsx*[betax,-alphax;-alphax,gammax];
sigma(3:4,3:4)=epsy*[betay,-alphay;-alphay,gammay];
