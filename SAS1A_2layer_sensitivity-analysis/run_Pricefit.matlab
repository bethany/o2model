
% Importing oxygen variables (as-is)
O2vars = importdata('O2vars.xlsx');
O2vars_working = zeros(1,18);
O2vars_working(1:end) = O2vars.data(1,1:end);

% Setting Pricefit standards
npar = length(O2vars_working);

minpar   = repmat(-1e3, 1, npar);
maxpar   = repmat(1e3, 1, npar);
npop     = max(5*npar, 50);
numiter  = 1e4;
centroid = 3;
varleft  = 1e-9;

[bestpar_1, bestcost_1, poppar_1, popcost_1, iter_1] = Pricefit(O2vars_working, rmsd, minpar, maxpar, npop, numiter, centroid, varleft);
