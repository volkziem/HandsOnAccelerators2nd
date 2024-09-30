% drawbox.m, V. Ziemann, 240827
function drawbox(v0,v,width,color)
box=zeros(2,6);
tmp=hypot(v(3)-v0(3),v(1)-v0(1));
if tmp > 1e-8
    p=[v(3)-v0(3),0,-(v(1)-v0(1))]/tmp;
    box(:,1)=[v0(3),v0(1)];
    box(:,2)=[v0(3)+p(3)*width,v0(1)+p(1)*width];
    box(:,3)=[v(3)+p(3)*width,v(1)+p(1)*width];
    box(:,4)=[v(3)-p(3)*width,v(1)-p(1)*width];
    box(:,5)=[v0(3)-p(3)*width,v0(1)-p(1)*width];
    box(:,6)=[v0(3),v0(1)];
end
plot(box(1,:),box(2,:),color,'LineWidth',3);
%hold on