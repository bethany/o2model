% Test script for calibration algorithm Pricefit.m

% "True" parameters & "true" target values

par0  = [1.2, 3.4, 0.56];

x0    = 0.1:0.1:1;

model = @(par) par(1) .* x0 .^ par(2) + par(3);

y0    = model(par0);

% Define cost function

rmsd = @(par) ( sum( (model(par)-y0).^2 )/length(y0) ).^0.5;

%% Test Pricefit with default settings

par = [1, 2, 3];
[bestpar_0, bestcost_0, poppar_0, popcost_0, iter_0] = Pricefit(par, rmsd);


%% Test Pricefit with custom settings

% setting #1 = same as default
npar = length(par);

minpar   = repmat(-1e3, 1, npar);
maxpar   = repmat(1e3, 1, npar);
npop     = max(5*npar, 50);
numiter  = 1e4;
centroid = 3;
varleft  = 1e-9;

[bestpar_1, bestcost_1, poppar_1, popcost_1, iter_1] = Pricefit(par, rmsd, minpar, maxpar, npop, numiter, centroid, varleft);

%% settings #2
minpar   = repmat(-1e3, 1, npar);
maxpar   = repmat(1e3, 1, npar);
npop     = max(5*npar, 100);
numiter  = 1e4;
centroid = 5;
varleft  = 1e-12;

[bestpar_2, bestcost_2, poppar_2, popcost_2, iter_2] = Pricefit(par, rmsd, minpar, maxpar, npop, numiter, centroid, varleft);
