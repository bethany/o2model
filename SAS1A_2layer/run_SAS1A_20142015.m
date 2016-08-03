% Script to run MyLake (v_12) for Lake BGR1
% Originally written by CB, September 2011
% Edited by BD for other applications, January 2014

% Command to change to SAS1A directory:
% cd('~/Desktop/Making_a_model/SAS1A_2layer');

% Useful link for colours:
% http://shirt-ediss.me/matlab-octave-more-colours/

% clear all;
path(path,'~/Desktop/Making_a_model/SAS1A_2layer/Mylake_v12/air_sea'); %path for air-sea toolbox
path(path,'~/Desktop/Making_a_model/SAS1A_2layer/Mylake_v12/v12');     %path for MyLake model code

global ies80 Eevapor;
test_time=0;
Eevapor=0;

lake='SAS1A';
year=2014;
m_start=[2014,09,05]; 
m_stop= [2015,08,24];

load '~/Desktop/Making_a_model/SAS1A_2layer/SAS1A_Temp_2014.csv';
temp1 = SAS1A_Temp_2014;

initfile='~/Desktop/Making_a_model/SAS1A_2layer/SAS1A_init_2014.xlsx';
inputfile='~/Desktop/Making_a_model/SAS1A_2layer/SAS1A_Met-Input_2014-2015_b.xlsx';
parafile='~/Desktop/Making_a_model/SAS1A_2layer/SAS1A_parameters.xlsx';

tic
        [zz,Az,Vz,tt,Qst,Kzt,Tzt,Czt,Szt,Pzt,Chlzt,PPzt,DOPzt,DOCzt,Qzt_sed,lambdazt,...
        P3zt_sed,P3zt_sed_sc,His,DoF,DoM,MixStat,Wt,i_fac,Cond_out,Tz,Oxygenzt,O2Factors_Surface,O2Factors_Bottom,O2Factors_Middle]...
           = solvemodel_v12(m_start,m_stop,initfile,'lake',inputfile,'timeseries', parafile,'lake');    
run_time=toc;

DoF_realtime=DoF+tt(1)-1; %TSA, antatt at tidsteg er 1 dag
DoM_realtime=DoM+tt(1)-1; %TSA
DoF_plottime=DoF+tt(1)-1-datenum(year,1,1); %TSA, antatt at tidsteg er 1 dag
DoM_plottime=DoM+tt(1)-1-datenum(year,1,1); %TSA

tt_mod = tt - datenum(year,1,1); %time now scaled so that it begins from the 1 january of the "year" (=0)


% limits for figures
zlim = [0 max(zz)];

tiks(1)=datenum(2014,9,1,0,0,0);
tiks(2)=datenum(2014,10,1,0,0,0);
tiks(3)=datenum(2014,11,1,0,0,0);
tiks(4)=datenum(2014,12,1,0,0,0);
tiks(5)=datenum(2015,1,1,0,0,0);
tiks(6)=datenum(2015,2,1,0,0,0);
tiks(7)=datenum(2015,3,1,0,0,0);
tiks(8)=datenum(2015,4,1,0,0,0);
tiks(9)=datenum(2015,5,1,0,0,0);
tiks(10)=datenum(2015,6,1,0,0,0);
tiks(11)=datenum(2015,7,1,0,0,0);
tiks(12)=datenum(2015,8,1,0,0,0);
tiks(13)=datenum(2015,9,1,0,0,0);

tlim =[tiks(1) tiks(13)];

% thermocline depth
zt = MixStat(12,:);
 
% ***************
figure(1) % modelled temperature profiles and ice thickness
	clf % clears figure to start clean.

subplot(2,1,1) % modelled temperature profiles; numbers (ie, 211) positions the plot Height, Width, X-position.
	pcolor(tt,zz,Tzt)
		shading interp
		axis ij
		hold on

	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');
	set(gca,'ylim',zlim);
	caxis([0 22]); % sets the colour bar scaling
	xlabel('Date')

	colorbar;
	set(gca,'fontsize',9);
	H=get(gca,'Position');
	ylabel('Depth (m)')
	set(gca,'TickDir','out')


subplot(2,1,2); %ice thickness

	plot(tt,His(1,:)+His(2,:),'-r',tt,His(1,:),'-b')
	hold on

	H(2)=H(2)+0.23;
	% set(gca,'Position',H);
	set(gca,'fontsize',9);
	set(gca,'ylim',[0 1.8]);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');
	% set(gca,'XTickLabel',[]);
	set(gca,'YTick',[0.0 0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8]);
	set(gca,'TickDir','out')
	ylabel('Thickness_i_c_e, Height_s_n_o_w (m)');
	legend('Snow and ice thickness','Ice thickness')
	grid on;


fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 20 20];
fig.PaperPositionMode = 'manual';
print('-r300','Fig1_IceIsoplot','-dpng')




% ***************
figure(2) % plot observed and modelled temperatures at 5 depths
clf

mintime = [2014  9  1  0  0  0];
maxtime = [2015  9  1  0  0  0];
mintem =  0.0;
maxtem =  20.0;

mintime = datenum(mintime);
maxtime = datenum(maxtime);

tiks(1)=datenum(2014,9,1,0,0,0);
tiks(2)=datenum(2014,10,1,0,0,0);
tiks(3)=datenum(2014,11,1,0,0,0);
tiks(4)=datenum(2014,12,1,0,0,0);
tiks(5)=datenum(2015,1,1,0,0,0);
tiks(6)=datenum(2015,2,1,0,0,0);
tiks(7)=datenum(2015,3,1,0,0,0);
tiks(8)=datenum(2015,4,1,0,0,0);
tiks(9)=datenum(2015,5,1,0,0,0);
tiks(10)=datenum(2015,6,1,0,0,0);
tiks(11)=datenum(2015,7,1,0,0,0);
tiks(12)=datenum(2015,8,1,0,0,0);
tiks(13)=datenum(2015,9,1,0,0,0);

ticks_y = [0 0.5 1 1.5 2];

time1 = datenum(temp1(:,1:6)); % creates dates from measured temperatures CSV.


% *** subplot no.1 - temperature at 0 m ***
subplot(3,1,1)
	
	% Plot elements
	plot(time1,temp1(:,7),'k'); % measured, in fine black line
	hold on;
	plot(tt,Tzt(1,:),'blue','linewidth',1.5); % modelled temp in thicker blue line.
	hold on;
	
	% General plot design
	legend('Measured at 0.70 m', 'Modelled at 0.0 m')
	title('Temperature at surface');
	ylabel('Temperature (^{\circ}C)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');


% *** subplot no.2 - temperature at 0.5 m ***
subplot(3,1,2)

	% Plot elements
	plot(time1,temp1(:,7),'k'); % measured, in fine black line
	hold on;
	plot(tt,Tzt(2,:),'blue','linewidth',1.5); % modelled temp in thicker blue line.
	hold on;
	
	% General plot design
	legend('Measured at 0.7 m', 'Modelled at 0.7 m')
	title('Temperature at middle depth');
	ylabel('Temperature (^{\circ}C)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');



subplot(3,1,3)

	% Plot elements
	plot(time1,temp1(:,8),'k'); % measured, in fine black line
	hold on;
	plot(tt,Tzt(3,:),'blue','linewidth',1.5); % modelled temp in thicker blue line.
	hold on;
	
	% General plot design
	legend('Measured at 1.2 m', 'Modelled at 1.2 m')
	title('Temperature at depth');
	ylabel('Temperature (^{\circ}C)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');



fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 20 20];
fig.PaperPositionMode = 'manual';
print('-r300','Fig2_Temperature','-dpng')




figure(3) % plot of met data
clf

mintime = [2014  9  1  0  0  0];
maxtime = [2015  9  1  0  0  0];
mintem =  0.0;
maxtem =  20.0;

mintime = datenum(mintime);
maxtime = datenum(maxtime);

tiks(1)=datenum(2014,9,1,0,0,0);
tiks(2)=datenum(2014,10,1,0,0,0);
tiks(3)=datenum(2014,11,1,0,0,0);
tiks(4)=datenum(2014,12,1,0,0,0);
tiks(5)=datenum(2015,1,1,0,0,0);
tiks(6)=datenum(2015,2,1,0,0,0);
tiks(7)=datenum(2015,3,1,0,0,0);
tiks(8)=datenum(2015,4,1,0,0,0);
tiks(9)=datenum(2015,5,1,0,0,0);
tiks(10)=datenum(2015,6,1,0,0,0);
tiks(11)=datenum(2015,7,1,0,0,0);
tiks(12)=datenum(2015,8,1,0,0,0);
tiks(13)=datenum(2015,9,1,0,0,0);

ticks_y = [0 0.5 1 1.5 2];

time1 = datenum(temp1(:,1:6)); % creates dates from measured temperatures CSV.


% Get data
load('~/Desktop/Making_a_model/SAS1A_2layer/SAS1A_MetFile.mat');


% *** subplot no.1 - Air Temperature ***
subplot(4,1,1)
	
	% Plot elements
	plot(time1,MetFile(:,6),'black','linewidth',1.0); 
	hold on;
	
	% General plot design
	title('Air Temperature');
	ylabel('Temperature (^{\circ}C)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');



% *** subplot no.2 - Solar Radiation ***
subplot(4,1,2)
	
	% Plot elements
	plot(time1,MetFile(:,4),'black','linewidth',1.0); 
	hold on;
	
	% General plot design
	title('Solar Radiation');
	ylabel('Solar Radiation (MJ/M^2)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');




% *** subplot no.2 - Wind Speed ***
subplot(4,1,3)
	
	% Plot elements
	plot(time1,MetFile(:,9),'black','linewidth',1.); 
	hold on;
	
	% General plot design
	title('Wind Speed');
	ylabel('Wind Speed (m/s)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');




% *** subplot no.2 - Precipitation ***
subplot(4,1,4)
	
	% Plot elements
	plot(time1,MetFile(:,10),'black','linewidth',1.0);
	hold on;
	
	% General plot design
	title('Precipitation');
	ylabel('Precipitation (mm)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');

	

fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 20 20];
fig.PaperPositionMode = 'manual';
print('-r300','Fig3_MetData','-dpng')




load '~/Desktop/Making_a_model/SAS1A_2layer/Oxygen/SAS1AO2.mat';

figure (4) % plot of oxygen data
clf;

% *** subplot no.1 - oxygen at 0 m ***
subplot(3,1,1)
	
	% Plot elements

	plot(tt,Oxygenzt(1,:),'red','linewidth',1.0); % modelled temp in thicker blue line.
	hold on;
	plot(time1,oxygen(:,1),'k'); % measured, in fine black line
	hold on;
	
	% General plot design
	legend('Measured at 0.70 m', 'Modelled at 0.0 m')
	title('Dissolved oxygen at surface');
	ylabel('Oxygen (mg O_2 L^-^1)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');


% *** subplot no.2 - oxygen at 0.7 m ***
subplot(3,1,2)

	% Plot elements
	plot(tt,Oxygenzt(2,:),'red','linewidth',1.0); % modelled temp in thicker blue line.
	hold on;
	plot(time1,oxygen(:,1),'k'); % measured, in fine black line
	hold on;
	
	% General plot design
	legend('Measured at 0.7 m', 'Modelled at 0.7 m')
	title('Dissolved oxygen at depth');
	ylabel('Oxygen (mg O_2 L^-^1)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');


% *** subplot no.3 - oxygen at 1.2 m ***
subplot(3,1,3)

	% Plot elements
	plot(tt,Oxygenzt(3,:),'red','linewidth',1.0); % modelled temp in thicker blue line.
	hold on;
	plot(time1,oxygen(:,2),'k'); % measured, in fine black line
	hold on;
	
	% General plot design
	legend('Measured at 1.2 m', 'Modelled at 1.2 m')
	title('Dissolved oxygen at depth');
	ylabel('Oxygen (mg O_2 L^-^1)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');


fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 20 20];
fig.PaperPositionMode = 'manual';
print('-r300','Fig4_O2Results','-dpng')



figure (5) % plot of oxygen factors
clf;

% Colours
beige_green = [66 125 59] ./ 255;
orange_red = [232 80 73] ./ 255;
purple = [94 64 255] ./ 255;
blue_teal = [94 194 159] ./ 255;
yellow_green = [196 196 90] ./ 255;


% *** subplot no.1 - oxygen at 0 m ***
subplot(3,1,1)
	
	% Plot elements

	plot(tt,O2Factors_Surface(1,:),'Color',beige_green,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Surface(2,:),'Color',orange_red,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Surface(3,:),'Color',purple,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Surface(4,:),'Color',blue_teal,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Surface(5,:),'Color',yellow_green,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
					
	% General plot design
	legend('Photosynthesis', 'Respiration', 'Sediment Demand', 'Biochemical Demand', 'Surface Transfer')
	title('Oxygen Factors - Surface at 0.0 m');
	ylabel('Oxygen (mg O_2 L^-^1)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');


% *** subplot no.2 - oxygen at 0.7 m ***
subplot(3,1,2)

	% Plot elements

	plot(tt,O2Factors_Middle(1,:),'Color',beige_green,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Middle(2,:),'Color',orange_red,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Middle(3,:),'Color',purple,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Middle(4,:),'Color',blue_teal,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
					
	% General plot design
	legend('Photosynthesis', 'Respiration', 'Sediment Demand', 'Biochemical Demand')
	title('Oxygen Factors - Middle at 0.7 m');
	ylabel('Oxygen (mg O_2 L^-^1)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');


% *** subplot no.3 - oxygen at 1.2 m ***
subplot(3,1,3)

	% Plot elements

	plot(tt,O2Factors_Bottom(1,:),'Color',beige_green,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Bottom(2,:),'Color',orange_red,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Bottom(3,:),'Color',purple,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
	plot(tt,O2Factors_Bottom(4,:),'Color',blue_teal,'linewidth',1); % modelled temp in thicker blue line.
	hold on;
					
	% General plot design
	legend('Photosynthesis', 'Respiration', 'Sediment Demand', 'Biochemical Demand')
	title('Oxygen Factors - Bottom at 1.2 m');
	ylabel('Oxygen (mg O_2 L^-^1)');
	xlabel('Date');
	grid on;

	% Dates along x-axis
	set(gca,'xticklabel',[]);
	set(gca,'fontsize',9);
	set(gca,'xtick',tiks);
	datetick('x','mmm yy','keepticks');



fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 20 20];
fig.PaperPositionMode = 'manual';
print('-r300','Fig5_O2Factors','-dpng')



% figure (6)

% % *** subplot no.1 - oxygen at 0.7 m ***
% subplot(2,1,1)

% 	% Plot elements
% 	plot(time1,MetFile(:,9).^2,'blue','linewidth',1.0); 
% 	hold on;	
% 	plot(tt,Oxygenzt(2,:),'red','linewidth',1.0); % modelled temp in thicker blue line.
% 	hold on;
% 	plot(time1,oxygen(:,1),'k','linewidth',2.0); % measured, in fine black line
% 	hold on;
	
% 	% General plot design
% 	legend('Wind stress (m s^-^1)^2','Measured at 0.7 m', 'Modelled at 0.7 m')
% 	title('Dissolved oxygen and wind speed, 0.7 m');
% 	ylabel('Oxygen (mg O_2 L^-^1), Wind stress (m s^-^1)^2');
% 	xlabel('Date');
% 	grid on;

% 	% Dates along x-axis
% 	set(gca,'xticklabel',[]);
% 	set(gca,'fontsize',9);
% 	set(gca,'xtick',tiks);
% 	datetick('x','mmm yy','keepticks');


% % *** subplot no.2 - oxygen at 1.2 m ***
% subplot(2,1,2)

% 	% Plot elements
% 	plot(time1,MetFile(:,9).^2,'blue','linewidth',1.0); 
% 	hold on;
% 	plot(tt,Oxygenzt(3,:),'red','linewidth',1.0); % modelled temp in thicker blue line.
% 	hold on;
% 	plot(time1,oxygen(:,2),'k','linewidth',2.0); % measured, in fine black line
% 	hold on;
	
% 	% General plot design
% 	legend('Wind stress (m s^-^1)^2','Measured at 1.2 m', 'Modelled at 1.2 m')
% 	title('Dissolved oxygen and wind speed, 1.2 m');
% 	ylabel('Oxygen (mg O_2 L^-^1), Wind stress (m s^-^1)^2');
% 	xlabel('Date');
% 	grid on;

% 	% Dates along x-axis
% 	set(gca,'xticklabel',[]);
% 	set(gca,'fontsize',9);
% 	set(gca,'xtick',tiks);
% 	datetick('x','mmm yy','keepticks');



% fig = gcf;
% fig.PaperUnits = 'centimeters';
% fig.PaperPosition = [0 0 20 20];
% fig.PaperPositionMode = 'manual';
% print('-r300','Fig6_O2andWind','-dpng')


