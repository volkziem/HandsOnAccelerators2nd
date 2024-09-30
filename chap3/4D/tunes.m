function Q=tunes(Rend);
[Qx,alphax,betax,gammax]=R2beta(Rend(1:2,1:2));
[Qy,alphay,betay,gammay]=R2beta(Rend(3:4,3:4));
Q=[Qx,Qy];