% magnetic_measurement.m
%clear; 
close all
%s=serial('/dev/ttyUSB0','BaudRate',9600)
%pause(2)
%fopen(s)
%pause(1)
fprintf(s,'SCAN?')
fscanf(s);
%pause(30)
Bfield=zeros(1,150);
for i=1:150
  Bfield(i)=str2double(fscanf(s));
  [i, Bfield(i)]
end
%fclose(s);
xscale=0.18*(0:149);  % 0.18 mm/step
plot(xscale,Bfield*1e-4,'k','LineWidth',2)
xlabel('s [mm]'); ylabel('B [T]')
xlim([0,max(xscale)]); ylim([0,0.178])
set(gca,'FontSize',16)