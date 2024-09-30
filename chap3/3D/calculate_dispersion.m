% calculate_dispersion.m, V. Ziemann, 240828
function D=calculate_dispersion(beamline,D0)
[Racc,spos]=calcmat(beamline);
D=zeros(length(spos),1);
for k=1:length(spos)
   D(k)=Racc(1,:,k)*D0;
end