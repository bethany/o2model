% Script to run MyLake (v_12) for Lake BGR1
% Originally written by CB, September 2011
% Edited by BD for other applications, January 2014

% Command to change to SAS1A directory:
% cd('~/Desktop/Making_a_model/SAS1A_alldata');

% Useful link for colours:
% http://shirt-ediss.me/matlab-octave-more-colours/

% clear all;
path(path,'~/Desktop/Making_a_model/SAS1A_alldata/Mylake_v12/air_sea') %path for air-sea toolbox
path(path,'~/Desktop/Making_a_model/SAS1A_alldata/Mylake_v12/v12')     %path for MyLake model code

global ies80 Eevapor;
test_time=0;
Eevapor=0;

lake='SAS1A';
year=1971;
m_start=[1971,01,01];
m_stop= [2095,12,31];


initfile='~/Desktop/Making_a_model/SAS1A_alldata/SAS1A_init_alldata.xlsx';
inputfile='~/Desktop/Making_a_model/SAS1A_alldata/Met-Input_alldata.xlsx';
parafile='~/Desktop/Making_a_model/SAS1A_alldata/SAS1A_parameters.xlsx';

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





% ----------------------------------
% 

for i = 1:3
	for j = 1:length(tt)
		if (Oxygenzt(i,j) < 0)
			Oxygenztb(i,j) = 0;
		else 
			Oxygenztb(i,j) = Oxygenzt(i,j);
		end
	end
end


