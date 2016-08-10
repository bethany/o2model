%% Calibration %%

function [RMSD_70cm, RMSD_120cm] = rmsd(O2vars_working)


% Run the model

% clear all;

tic

path(path,'Mylake_v12/air_sea') %path for air-sea toolbox
path(path,'Mylake_v12/v12')     %path for MyLake model code

global ies80 Eevapor;
test_time=0;
Eevapor=0;

lake='SAS1A';
year=2014;
m_start=[2014,09,05]; 
m_stop= [2015,08,24];

initfile='SAS1A_init_2014.xlsx';
inputfile='SAS1A_Met-Input_2014-2015_b.xlsx';
parafile='SAS1A_parameters.xlsx';

% Running solvemodel
[zz,Az,Vz,tt,Qst,Kzt,Tzt,Czt,Szt,Pzt,Chlzt,PPzt,DOPzt,DOCzt,Qzt_sed,lambdazt,...
    P3zt_sed,P3zt_sed_sc,His,DoF,DoM,MixStat,Wt,i_fac,Cond_out,Tz,Oxygenzt,O2Factors_Surface,O2Factors_Bottom,O2Factors_Middle]...
    = solvemodel_v12(m_start,m_stop,initfile,'lake',inputfile,'timeseries',parafile,'lake',O2vars_working);    

% Once model has been run and variables returned....

% Load observed values
load 'Oxygen/SAS1AO2.mat';

O2measured_70cm = oxygen(:,1);
O2measured_120cm = oxygen(:,2);

% Calculate RMSD from results
a = (O2measured_70cm - Oxygenzt(2,1:end))^2;
b = sum(a,1);
RMSD_70cm = (b / 354);

a = (O2measured_120cm - Oxygenzt(3,1:end))^2;
b = sum(a,1);
RMSD_120cm = (b / 354);