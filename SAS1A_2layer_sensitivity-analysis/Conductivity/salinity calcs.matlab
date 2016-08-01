Set longitude and latitude:
long = 55.218800;
lat = -77.707950;

% Loading cond file
condfile=xlsread('~/Desktop/Making_a_model/SAS1A/SAS1A_conductivity_20142015.xlsx');
Conddt = condfile';

tempfile=xlsread('~/Desktop/Making_a_model/SAS1A/Conductivity/SAS1A_MeasuredTemp_20142015.xlsx');

% Convert conductivity (mS/cm) to PSU:
Cond = condfile / 1000;
SalSurf = gsw_SP_from_C(Cond,tempfile,1);

% Convert Practice Salinity Units (PSU) to Absolute Salinity:
SASurf = gsw_SA_from_SP(SalSurf,1,long,lat);


% Calculate density:
rhoSurf = gsw_rho(SASurf,CTSurf,1);
