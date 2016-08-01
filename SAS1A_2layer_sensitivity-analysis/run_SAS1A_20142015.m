% Script to run MyLake (v_12) for Lake BGR1
% Originally written by CB, September 2011
% Edited by BD for other applications, January 2014

% Command to change to SAS1A directory:
% cd('~/Desktop/Making_a_model/SAS1A_2layer');

% Useful link for colours:
% http://shirt-ediss.me/matlab-octave-more-colours/

% clear all;

tic
Variances = zeros(3,18);

for j = 1:37

path(path,'~/Desktop/Making_a_model/SAS1A_2layer/Mylake_v12/air_sea') %path for air-sea toolbox
path(path,'~/Desktop/Making_a_model/SAS1A_2layer/Mylake_v12/v12')     %path for MyLake model code

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


	O2vars = importdata('~/Desktop/Making_a_model/SAS1A_2layer/O2vars.xlsx');
	O2vars_working = zeros(1,18);

	O2vars_working(1:end) = O2vars.data(j,1:end);


        [zz,Az,Vz,tt,Qst,Kzt,Tzt,Czt,Szt,Pzt,Chlzt,PPzt,DOPzt,DOCzt,Qzt_sed,lambdazt,...
        P3zt_sed,P3zt_sed_sc,His,DoF,DoM,MixStat,Wt,i_fac,Cond_out,Tz,Oxygenzt,O2Factors_Surface,O2Factors_Bottom,O2Factors_Middle]...
           = solvemodel_v12(m_start,m_stop,initfile,'lake',inputfile,'timeseries',parafile,'lake',O2vars_working);    


% O2 Model variance

	Variances(1,j) = var(Oxygenzt(1,1:end));
	Variances(2,j) = var(Oxygenzt(2,1:end));
	Variances(3,j) = var(Oxygenzt(3,1:end));


	if (j == 1)
		Oxygenzt_ref = Oxygenzt;
		Correlations(1:6,j) = 1;
	else
		[rho,pval] = corrcoef(Oxygenzt_ref(1,:),Oxygenzt(1,:));
		Correlations(1,j) = rho(1,2);
		Correlations(2,j) = pval(1,2);

		[rho,pval] = corrcoef(Oxygenzt_ref(2,:),Oxygenzt(2,:));
		Correlations(3,j) = rho(1,2);
		Correlations(4,j) = pval(1,2);

		[rho,pval] = corrcoef(Oxygenzt_ref(3,:),Oxygenzt(3,:));
		Correlations(5,j) = rho(1,2);
		Correlations(6,j) = pval(1,2);
	end;

	clearvars -except Variances Oxygenzt_ref Correlations;

end;


run_time=toc;
