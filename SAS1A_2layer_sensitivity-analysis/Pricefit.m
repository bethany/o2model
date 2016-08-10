%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%
%#                                           %#
%# Adapted from:                             %#
%#                                           %#
%# Soetaert and Herman (2008)                %#
%# A practical guide to ecological modelling %#
%# Chapter 4.                                %#
%# Parameterisation                          %#
%# Chapter 4.4.3.                            %#
%# Pseudo-random search, a random-based      %#
%# minimisation routine                      %#
%#                                           %#
%# Maps F. 2016                              %#
%#                                           %#
%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%#%

% the Price algorithm

function [bestpar, bestcost, poppar, popcost, iter] = Pricefit(par, func, varargin)

% Inputs
%    
% --- REQUIRED ---
%    par         : initial parameters vector
%    func        : handle to the minimized function
%    
% --- OPTIONAL ---   
% If present, varargin{} MUST contain values for all these variables:
%    
%    minpar      : minimal parameter values
%    maxpar      : maximal parameter values
%    npop        : number of elements in population
%    numiter     : number of iterations
%    centroid    : number of points in centroid 
%    varleft     : relative variation upon stopping
%
%--------------------------------------------------------------------------   
% Outputs
%	 bestpar     : vector of "best" parameter (minimum cost value)
%    bestcost    : vector of cost values
%    poppar      : matrix of parameter for the population
%    popcost     : matrix of cost values
%    iter        : number of iterations for converging

tic

%% Initialization

rng('default');    % reset random generator

npar = length(par);

if nargin == 2     % default values

    minpar   = repmat(-1e3, 1, npar);
    maxpar   = repmat(1e3, 1, npar);
    npop     = max(5*npar, 50);
    numiter  = 1e4;
    centroid = 3;
    varleft  = 1e-9;

elseif nargin == 8 % provided values

    minpar   = varargin{1};
    maxpar   = varargin{2};
    npop     = varargin{3};
    numiter  = varargin{4};
    centroid = varargin{5};
    varleft  = varargin{6};

else
    error('Price:argChk', 'Wrong number of input arguments.\nCheck "help Price" for details.')
end

tiny    = 1e-9;
varleft = max(tiny, varleft);

poppar      = repmat(minpar, npop, 1) + repmat((maxpar-minpar), npop, 1) .* rand(npop,npar);
poppar(1,:) = par;

popcost = zeros(npop,1);

%% First cost-function evaluation

for i = 1:npop
    popcost(i) = feval(func, poppar(i,:));
end

[worstcost, iworst] = max(popcost);

figure
plot(1, poppar(1:numel(poppar)), 'k.'); axis([0,npop,-10,10]); hold on %%%*** JUST FOR DEBUGING

%% Hybridisation phase   

iter = 0;
 
while iter < numiter && range(popcost) > varleft

    iter = iter+1;

    select  = randsample(npop, centroid); % for cross-fertilisation
    mirror  = randsample(npop, 1);        % for mirroring  

    newpar  = mean(poppar(select,:));           % centroid
    
    newpar  = 2*newpar - poppar(mirror,:);      % mirroring

    newpar  = min( max(newpar,minpar), maxpar); % bounding

    
    newcost = feval(func, newpar); % evaluate cost of the new parameter vector
    
    if newcost < worstcost

        popcost(iworst) = newcost;
       
        poppar(iworst,:) = newpar;  
        
        [worstcost, iworst] = max(popcost); % new worst member
    
        plot(iter+1, newpar, 'k.') %%%***
    end
    
end

[bestcost, ibest] = min(popcost);

bestpar = poppar(ibest,:);

toc

end