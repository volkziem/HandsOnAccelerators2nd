% analyze_image.m, V. Ziemann, 240829
clear; close all
im=rgb2gray(imread('power1.jpg'));
subplot(2,2,1); roi=im(260:400,320:500); 
roi=min(250,roi); imshow(250-roi); 
subplot(2,2,4); contour(flipud(roi)); 
xlabel('x [pixel]'); ylabel('y [pixel]')
subplot(2,2,2); plot(sum(roi,2),'k'); xlim([0,size(roi,1)]); 
camroll(270); set(gca,'YTick',[]); xlabel('y [pixel]'); 
title(['FWHM = ',num2str(fwhm(sum(roi,2))),' pixel'])
subplot(2,2,3); plot(sum(roi,1),'k'); xlim([0,size(roi,2)]);
set(gca,'YTick',[]); xlabel('x [pixel]')
title(['FWHM = ',num2str(fwhm(sum(roi,1))),' pixel'])
