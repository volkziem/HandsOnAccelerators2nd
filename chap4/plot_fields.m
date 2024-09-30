% plot fields
clear all; close all
d0=dlmread("temp_field_5000.dat");
d1=dlmread("temp_field_500.dat");

plot(d0(:,1),d0(:,2),'k',d1(:,1),d1(:,2),'k-.','LineWidth',2);

xlabel('x [m]'); ylabel('B [T]'); 
xlim([0,1.4]); ylim([0,1.05]); 

set(gca,'FontSize',16);