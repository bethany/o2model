
% Create index for every Feb. 29

dum1 = datenum('1/1/1971')   ;
dum2 = datenum('12/31/2095') ;
date_idx = datevec(dum1:dum2) ;
leap_day_idx = (date_idx(:,2) == 2 & date_idx(:,3) == 29) ;

% Remove every Feb. 29
a_Tzt=Tzt;
a_Tzt(:,leap_day_idx) = [] ;

a_Oxygenztb=Oxygenztb;
a_Oxygenztb(:,leap_day_idx) = [] ;

a_Chlzt=Chlzt;
a_Chlzt(:,leap_day_idx) = [] ;

a_His=His;
a_His(:,leap_day_idx) = [] ;

a_O2Factors_Surface=O2Factors_Surface;
a_O2Factors_Surface(:,leap_day_idx) = [] ;

a_O2Factors_Middle=O2Factors_Middle;
a_O2Factors_Middle(:,leap_day_idx) = [] ;

a_O2Factors_Bottom=O2Factors_Bottom;
a_O2Factors_Bottom(:,leap_day_idx) = [] ;


% Reshape for excel
% total number of years: 125


a_Tzt_surf = reshape(a_Tzt(1,1:45625),[365,125])';
a_Tzt_middle = reshape(a_Tzt(2,1:45625),[365,125])';
a_Tzt_bottom = reshape(a_Tzt(3,1:45625),[365,125])';

a_Oxygenztb_surf = reshape(a_Oxygenztb(1,1:45625),[365,125])';
a_Oxygenztb_middle = reshape(a_Oxygenztb(2,1:45625),[365,125])';
a_Oxygenztb_bottom = reshape(a_Oxygenztb(3,1:45625),[365,125])';

a_Chlzt_surf = reshape(a_Chlzt(1,1:45625),[365,125])';
a_Chlzt_middle = reshape(a_Chlzt(2,1:45625),[365,125])';
a_Chlzt_bottom = reshape(a_Chlzt(3,1:45625),[365,125])';

a_His_ice = reshape(a_His(1,1:45625),[365,125])';
a_His_snow = reshape(a_His(2,1:45625),[365,125])';

a_O2Factors_Surface_Photosynthesis = reshape(a_O2Factors_Surface(1,1:45625),[365,125])';
a_O2Factors_Surface_Resp = reshape(a_O2Factors_Surface(2,1:45625),[365,125])';
a_O2Factors_Surface_SOD = reshape(a_O2Factors_Surface(3,1:45625),[365,125])';
a_O2Factors_Surface_BOD = reshape(a_O2Factors_Surface(4,1:45625),[365,125])';
a_O2Factors_Surface_FS = reshape(a_O2Factors_Surface(5,1:45625),[365,125])';

a_O2Factors_Middle_Photosynthesis = reshape(a_O2Factors_Middle(1,1:45625),[365,125])';
a_O2Factors_Middle_Resp = reshape(a_O2Factors_Middle(2,1:45625),[365,125])';
a_O2Factors_Middle_SOD = reshape(a_O2Factors_Middle(3,1:45625),[365,125])';
a_O2Factors_Middle_BOD = reshape(a_O2Factors_Middle(4,1:45625),[365,125])';
a_O2Factors_Middle_FS = reshape(a_O2Factors_Middle(5,1:45625),[365,125])';

a_O2Factors_Bottom_Photosynthesis = reshape(a_O2Factors_Bottom(1,1:45625),[365,125])';
a_O2Factors_Bottom_Resp = reshape(a_O2Factors_Bottom(2,1:45625),[365,125])';
a_O2Factors_Bottom_SOD = reshape(a_O2Factors_Bottom(3,1:45625),[365,125])';
a_O2Factors_Bottom_BOD = reshape(a_O2Factors_Bottom(4,1:45625),[365,125])';
a_O2Factors_Bottom_FS = reshape(a_O2Factors_Bottom(5,1:45625),[365,125])';

