%
% This script updates runoff data to Flag = 2
%
% Matrix correlations are published in Otero et al., 2010. Scientia Marina, 74(2), 247-266
%
% Creation date: 24-May-2010 pablo.otero@co.ieo.es

disp(['Estimating runoff based on other near river basins'])

monthofyear=mod(time,365)*12/365.;
QDueroclim=(4.2399*monthofyear.^3-58.51*monthofyear.^2+90.839*monthofyear+960.13)';
QMinhoclim=(1.7221*monthofyear.^3-19.139*monthofyear.^2-19.396*monthofyear+617.25)';
QAveclim=(0.285*monthofyear.^3-3.5448*monthofyear.^2+1.7966*monthofyear+73.651)';
QCavadoclim=(0.285*monthofyear.^3-3.5448*monthofyear.^2+1.7966*monthofyear+73.651)';
QLimaclim=(0.6574*monthofyear.^3-8.6071*monthofyear.^2+8.7513*monthofyear+153.38)';
QMinhoclim=(1.7221*monthofyear.^3-19.139*monthofyear.^2-19.396*monthofyear+617.25)';
QVerdugoclim=(-0.0513*monthofyear.^4+1.2755*monthofyear.^3-9.2238*monthofyear.^2+15.431*monthofyear+36.658)';
QLerezclim=(0.1268*monthofyear.^3-1.0798*monthofyear.^2-5.2356*monthofyear+58.915)';
QUmiaclim=(0.1022*monthofyear.^3-0.8155*monthofyear.^2-4.3291*monthofyear+48.84)';
QUllaclim=(0.5165*monthofyear.^3-5.8022*monthofyear.^2-2.947*monthofyear+153.85)';
QTambreclim=(0.4238*monthofyear.^3-4.1096*monthofyear.^2-10.179*monthofyear+171.67)';
QNalonclim=(139.8184+75.4488*sin(2*pi*monthofyear/12)+52.4283*cos(2*pi*monthofyear/12))';
QSellaclim=(45.5121+24.1416*sin(2*pi*monthofyear/12)+20.9458*cos(2*pi*monthofyear/12))';
QSajaclim=(23.8088+11.9912*sin(2*pi*monthofyear/12)+16.7616*cos(2*pi*monthofyear/12))';
QPasclim=(15.8687+8.0690*sin(2*pi*monthofyear/12)+9.9056*cos(2*pi*monthofyear/12))';
QOriaclim=(25.0091+12.3895*sin(2*pi*monthofyear/12)+15.1891*cos(2*pi*monthofyear/12))';
QBidasoaclim=(24.3340+13.2436*sin(2*pi*monthofyear/12)+13.8402*cos(2*pi*monthofyear/12))';

% Update Duero from higher to lower correlations with adjacent rivers.
isee=find(FDuero_ud>2 & FMinho_ud==1);
  if(~isempty(isee)) QDuero_ud(isee)=QDueroclim(isee)./QMinhoclim(isee).*QMinho_ud(isee); FDuero_ud(isee)=2; end
isee=find(FDuero_ud>2 & FCavado_ud==1);
  if(~isempty(isee)) QDuero_ud(isee)=QDueroclim(isee)./QCavadoclim(isee).*QCavado_ud(isee); FDuero_ud(isee)=2; end
isee=find(FLima_ud>2 & FLima_ud==1);
  if(~isempty(isee)) QDuero_ud(isee)=QDueroclim(isee)./QLimaclim(isee).*QLima_ud(isee); FDuero_ud(isee)=2; end

% Update Ave from higher to lower correlations with adjacent rivers.
isee=find(FAve_ud>2 & FMinho_ud==1);
  if(~isempty(isee)) QAve_ud(isee)=QAveclim(isee)./QMinhoclim(isee).*QMinho_ud(isee); FAve_ud(isee)=2; end
isee=find(FAve_ud>2 & FLima_ud==1);
  if(~isempty(isee)) QAve_ud(isee)=QAveclim(isee)./QLimaclim(isee).*QLima_ud(isee); FAve_ud(isee)=2; end
isee=find(FAve_ud>2 & FCavado_ud==1);
  if(~isempty(isee)) QAve_ud(isee)=QAveclim(isee)./QCavadoclim(isee).*QCavado_ud(isee); FAve_ud(isee)=2; end

% Update Cavado from higher to lower correlations with adjacent rivers.
isee=find(FCavado_ud>2 & FAve_ud==1);
  if(~isempty(isee)) QCavado_ud(isee)=QCavadoclim(isee)./QAveclim(isee).*QAve_ud(isee); FCavado_ud(isee)=2; end
isee=find(FCavado_ud>2 & FMinho_ud==1);
  if(~isempty(isee)) QCavado_ud(isee)=QCavadoclim(isee)./QMinhoclim(isee).*QMinho_ud(isee); FCavado_ud(isee)=2; end
isee=find(FCavado_ud>2 & FDuero_ud==1);
  if(~isempty(isee)) QCavado_ud(isee)=QCavadoclim(isee)./QDueroclim(isee).*QDuero_ud(isee); FCavado_ud(isee)=2; end
isee=find(FCavado_ud>2 & FLima_ud==1);
  if(~isempty(isee)) QCavado_ud(isee)=QCavadoclim(isee)./QLimaclim(isee).*QLima_ud(isee); FCavado_ud(isee)=2; end

% Update Lima from higher to lower correlations with adjacent rivers.
isee=find(FLima_ud>2 & FAve_ud==1);
  if(~isempty(isee)) QLima_ud(isee)=QLimaclim(isee)./QAveclim(isee).*QAve_ud(isee); FLima_ud(isee)=2; end
isee=find(FLima_ud>2 & FMinho_ud==1);
  if(~isempty(isee)) QLima_ud(isee)=QLimaclim(isee)./QMinhoclim(isee).*QMinho_ud(isee); FLima_ud(isee)=2; end
isee=find(FLima_ud>2 & FCavado_ud==1);
  if(~isempty(isee)) QLima_ud(isee)=QLimaclim(isee)./QCavadoclim(isee).*QCavado_ud(isee); FLima_ud(isee)=2; end

% Update Minho from higher to lower correlations with adjacent rivers.
isee=find(FMinho_ud>2 & FAve_ud==1);
  if(~isempty(isee)) QMinho_ud(isee)=QMinhoclim(isee)./QAveclim(isee).*QAve_ud(isee); FMinho_ud(isee)=2; end
isee=find(FMinho_ud>2 & FCavado_ud==1);
  if(~isempty(isee)) QMinho_ud(isee)=QMinhoclim(isee)./QCavadoclim(isee).*QCavado_ud(isee); FMinho_ud(isee)=2; end
isee=find(FMinho_ud>2 & FDuero_ud==1);
  if(~isempty(isee)) QMinho_ud(isee)=QMinhoclim(isee)./QDueroclim(isee).*QDuero_ud(isee); FMinho_ud(isee)=2; end
isee=find(FMinho_ud>2 & FLima_ud==1);
  if(~isempty(isee)) QMinho_ud(isee)=QMinhoclim(isee)./QLimaclim(isee).*QLima_ud(isee); FMinho_ud(isee)=2; end

% Update Verdugo-Oitaven from higher to lower correlations with adjacent rivers.
isee=find(FVerdugo_ud>2 & FUlla_ud==1);
  if(~isempty(isee)) QVerdugo_ud(isee)=QVerdugoclim(isee)./QUllaclim(isee).*QUlla_ud(isee); FVerdugo_ud(isee)=2; end
isee=find(FVerdugo_ud>2 & FTambre_ud==1);
  if(~isempty(isee)) QVerdugo_ud(isee)=QVerdugoclim(isee)./QTambreclim(isee).*QTambre_ud(isee); FVerdugo_ud(isee)=2; end
isee=find(FVerdugo_ud>2 & FUmia_ud==1);
  if(~isempty(isee)) QVerdugo_ud(isee)=QVerdugoclim(isee)./QUmiaclim(isee).*QUmia_ud(isee); FVerdugo_ud(isee)=2; end

% Update Umia from higher to lower correlations with adjacent rivers.
isee=find(FUmia_ud>2 & FUlla_ud==1);
  if(~isempty(isee)) QUmia_ud(isee)=QUmiaclim(isee)./QUllaclim(isee).*QUlla_ud(isee); FUmia_ud(isee)=2; end
isee=find(FUmia_ud>2 & FVerdugo_ud==1);
  if(~isempty(isee)) QUmia_ud(isee)=QUmiaclim(isee)./QVerdugoclim(isee).*QVerdugo_ud(isee); FUmia_ud(isee)=2; end
isee=find(FUmia_ud>2 & FTambre_ud==1);
  if(~isempty(isee)) QUmia_ud(isee)=QUmiaclim(isee)./QTambreclim(isee).*QTambre_ud(isee); FUmia_ud(isee)=2; end

% Update Ulla from higher to lower correlations with adjacent rivers.
isee=find(FUlla_ud>2 & FTambre_ud==1);
  if(~isempty(isee)) QUlla_ud(isee)=QUllaclim(isee)./QTambreclim(isee).*QTambre_ud(isee); FUlla_ud(isee)=2; end
isee=find(FUlla_ud>2 & FVerdugo_ud==1);
  if(~isempty(isee)) QUlla_ud(isee)=QUllaclim(isee)./QVerdugoclim(isee).*QVerdugo_ud(isee); FUlla_ud(isee)=2; end
isee=find(FUlla_ud>2 & FUmia_ud==1);
  if(~isempty(isee)) QUlla_ud(isee)=QUllaclim(isee)./QUmiaclim(isee).*QUmia_ud(isee); FUlla_ud(isee)=2; end

% Update Tambre from higher to lower correlations with adjacent rivers.
isee=find(FTambre_ud>2 & FUlla_ud==1);
  if(~isempty(isee)) QTambre_ud(isee)=QTambreclim(isee)./QUllaclim(isee).*QUlla_ud(isee); FTambre_ud(isee)=2; end
isee=find(FTambre_ud>2 & FVerdugo_ud==1);
  if(~isempty(isee)) QTambre_ud(isee)=QTambreclim(isee)./QVerdugoclim(isee).*QVerdugo_ud(isee); FTambre_ud(isee)=2; end
isee=find(FTambre_ud>2 & FUmia_ud==1);
  if(~isempty(isee)) QTambre_ud(isee)=QTambreclim(isee)./QUmiaclim(isee).*QUmia_ud(isee); FTambre_ud(isee)=2; end

% Update Nalon with Sella (r=0.54)
isee=find(FNalon_ud>2 & FSella_ud==1);
  if(~isempty(isee)) QNalon_ud(isee)=QNalonclim(isee)./QSellaclim(isee).*QSella_ud(isee); FNalon_ud(isee)=2; end

% Update Sella with Nalon (r=0.54)
isee=find(FSella_ud>2 & FNalon_ud==1);
  if(~isempty(isee)) QSella_ud(isee)=QSellaclim(isee)./QNalonclim(isee).*QNalon_ud(isee); FSella_ud(isee)=2; end

% Update Saja with Pas (r=0.85)
isee=find(FSaja_ud>2 & FPas_ud==1);
  if(~isempty(isee)) QSaja_ud(isee)=QSajaclim(isee)./QPasclim(isee).*QPas_ud(isee); FSaja_ud(isee)=2; end

% Update Pas with Saja (r=0.85)
isee=find(FPas_ud>2 & FSaja_ud==1);
  if(~isempty(isee)) QPas_ud(isee)=QPasclim(isee)./QSajaclim(isee).*QSaja_ud(isee); FPas_ud(isee)=2; end

% Update Oria with Bidasoa (r=0.85)
isee=find(FOria_ud>2 & FBidasoa_ud==1);
  if(~isempty(isee)) QOria_ud(isee)=QOriaclim(isee)./QBidasoaclim(isee).*QBidasoa_ud(isee); FOria_ud(isee)=2; end

% Update Bidasoa with Oria (r=0.85)
isee=find(FBidasoa_ud>2 & FOria_ud==1);
  if(~isempty(isee)) QBidasoa_ud(isee)=QBidasoaclim(isee)./QOriaclim(isee).*QOria_ud(isee); FBidasoa_ud(isee)=2; end





