% drawmag.m, draw magnet lattice
function drawmag(beamline,vpos,height);
hold on
nlines=size(beamline,1);
nmat=sum(beamline(:,2))+1;
spos=zeros(nmat,1);
ic=1;
for line=1:nlines 
  for seg=1:beamline(line,2)
    ic=ic+1;
    switch beamline(line,1)
        case 2
            dv=0.15*height*sign(beamline(line,4));
            rectangle('Position',[spos(ic-1),vpos+dv,0.1,height])
        case 4
            L=beamline(line,3);
            rectangle('Position', ...
                [spos(ic-1),vpos+0.25*height,L,0.5*height])
        case 5
            L=beamline(line,3);
            dv=0.15*height*sign(beamline(line,4));
            rectangle('Position',[spos(ic-1),vpos+dv,L,height])
    end
    spos(ic)=spos(ic-1)+beamline(line,3);
  end
end
plot([spos(1),spos(end)],[vpos+0.5*height,vpos+0.5*height],'k:');