
O2vars = importdata('~/Desktop/Making_a_model/SAS1A_2layer/O2vars.xlsx');
j = 1;
O2vars_working = zeros(1,18);
O2vars_working(1:end) = O2vars.data(j,1:end);

RespTheta_epilimnion = 	O2vars(1);	% d-1; respiration temperature adjustment coefficient
Kr_epilimnion = 		O2vars(2);	% d-1; respiration rate coefficient
Kb_epilimnion = 		O2vars(3);	% d-1; first-order decay coefficient 
BOD_epilimnion = 		O2vars(4);	% mg L-1; detritus as oxygen equivalent;  represents eutrophic lake
Sb20_epilimnion = 		O2vars(5);	% g O2 m-2 d-1; sedimentary oxygen demand co-efficient
SedArea_epilimnion = 	O2vars(6);	% m^2; sediment area

RespTheta_metalimnion = O2vars(7);	% d-1; respiration temperature adjustment coefficient
Kr_metalimnion = 		O2vars(8);	% d-1; respiration rate coefficient
Kb_metalimnion = 		O2vars(9);	% d-1; first-order decay coefficient 
BOD_metalimnion = 		O2vars(10);	% mg L-1; detritus as oxygen equivalent;  represents eutrophic lake
Sb20_metalimnion = 		O2vars(11);	% g O2 m-2 d-1; sedimentary oxygen demand co-efficient
SedArea_metalimnion = 	O2vars(12);	% m^2; sediment area

RespTheta_hypolimnion = O2vars(13);	% d-1; respiration temperature adjustment coefficient
Kr_hypolimnion = 		O2vars(14);	% d-1; respiration rate coefficient
Kb_hypolimnion = 		O2vars(15);	% d-1; first-order decay coefficient 
BOD_hypolimnion = 		O2vars(16);	% mg L-1; detritus as oxygen equivalent;  represents eutrophic lake
Sb20_hypolimnion = 		O2vars(17);	% g O2 m-2 d-1; sedimentary oxygen demand co-efficient
SedArea_hypolimnion = 	O2vars(18);	% m^2; sediment area


% RMSE calculation

N = length(Oxygenzt);
load '~/Desktop/Making_a_model/SAS1A_2layer/Oxygen/SAS1AO2.mat';
oxygenmdl = Oxygenzt(2:3,:)';

diffs = oxygen - oxygenmdl;
a = sum(diffs) / N;

RMSE = sqrt(a)













