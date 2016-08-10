
% cd /Volumes/Macintosh HD/Users/bethanydeshpande/Documents/PhD Research/C3-Physical and biotic controls of respiration/ArcticScience_June2015/o2model
% cd('/Volumes/Macintosh HD/Users/bethanydeshpande/Documents/PhD Research/C3-Physical and biotic controls of respiration/ArcticScience_June2015/o2model/SAS1A_2layer_sensitivity-analysis')

% Importing oxygen variables (as-is)
O2vars = importdata('O2vars.xlsx');
O2vars_working = zeros(1,18);
O2vars_working(1:end) = O2vars.data(1,1:end);

% Load observed values
load 'Oxygen/SAS1AO2.mat';

O2measured_70cm = oxygen(1:354,1)';
O2measured_120cm = oxygen(1:354,2);

% Calculate RMSD from results
RMSD = @(O2vars_working) (sqrt(sum(((solvemodel_v12(O2vars_working) - O2measured_70cm).^2)) / 354));


% Setting Pricefit standards
npar = length(O2vars_working);

minpar   = repmat(-300, 1, npar);
maxpar   = repmat(300, 1, npar);
npop     = max(5*npar, 50);
numiter  = 1e5;
centroid = 3;
varleft  = 1e-9;

[bestpar_1, bestcost_1, poppar_1, popcost_1, iter_1] = Pricefit(O2vars_working, RMSD, minpar, maxpar, npop, numiter, centroid, varleft);
