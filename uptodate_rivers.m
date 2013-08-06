%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%     THIS SCRIPT COMPILES AND UPDATES ALL RIVER DATA IN JUST ONE FILE        %%%
%%%										%%%
%%%	River data come from a wide variety of databases (Aguas de Galicia,     %%%
%%%     INAG, CHN, HydroFrance, ect.), and it is a hard task to compile them in %%%
%%%     an easy way. With this script, you must previously donwload your new    %%%
%%%     runoff data and save them indiviually. You must have an ascii or text   %%%
%%%     file containing tab or comma separated values:                          %%%
%%%                     "year"  "month"  "day"  "runoff at the station".        %%%
%%%     Observed runoff data correspond to recorded data at a specific gauging  %%%
%%%     station; see the methodology document accompanying these scripts.       %%%
%%%                                                                             %%%
%%%										%%%
%%% 	The reconstruction starts 1/1/1986, corresponding with the first        %%%
%%%     available data at the Crestuma gauging station of the River Douro.      %%%
%%%     Of course, you can increase the time-series backwards.                  %%%
%%%										%%%
%%%	Pablo Otero, Mayo 2010							%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

%-----------------------START USER CONFIGURATION--------------------------------%%%

% -> Select the current file and the new file to be created
% ---------------------------------------------------------
currentfile='Rios_20130806.txt'; 
uptodatefile='Rios_update.txt';

% -> Select the time interval
% ---------------------------
tini=julian(1986,1,1);
tend=julian(2015,12,31);

% -> Do you have new gauging records to update data? 
% -> If the answer is yes, provide text files with 
% ---------------------------------------------------

Obs_Barbate=0; File_Barbate='Barbate_20130615.txt';
Obs_Guadalete=0; File_Guadalete='Guadalete_20130615.txt';
Obs_Guadalquivir=0; File_Guadalquivir='Guadalquivir_20130615.txt';
Obs_Guadiana=0; File_Guadiana='Guadiana_20130615.txt';
Obs_Quarteira=0; File_Quarteira='Quarteira_20130615.txt';
Obs_Aljezur=0; File_Aljezur='Aljezur_20130615.txt';
Obs_Mira=0; File_Mira='';
Obs_Sado=0; File_Sado='';
Obs_Tajo=0; File_Tajo='Tajo_20130615.txt';
Obs_Mondego=0; File_Mondego='Mondego_20130615.txt';
Obs_Vouga=0; File_Vouga='';
Obs_Duero=0; File_Duero='Duero_20130615.txt';
Obs_Ave=0; File_Ave='';
Obs_Cavado=0; File_Cavado='';
Obs_Lima=0; File_Lima='';
Obs_Minho=0; File_Minho='Minho_20130615.txt';
Obs_Verdugo=0; File_Verdugo='verdugo_combined_parche.txt';
Obs_Lerez=0; File_Lerez='lerez_parche.txt';
Obs_Umia=0; File_Umia='umia_parche.txt';
Obs_Ulla=0; File_Ulla='ulla_parche.txt';
Obs_Tambre=0; File_Tambre='tambre_parche.txt';
Obs_Grande=0; File_Grande='';
Obs_Anllons=0; File_Anllons='';
Obs_Mandeo=0; File_Mandeo='mandeo_parche.txt';
Obs_Eume=0; File_Eume='';
Obs_Xubia=0; File_Xubia='xubia_parche.txt';
Obs_Mera=0; File_Mera='mera_parche.txt';
Obs_Sor=0; File_Sor='';
Obs_Landro=0; File_Landro='landro_parche.txt';
Obs_Ouro=0; File_Ouro='';
Obs_Masma=0; File_Masma='';
Obs_Eo=0; File_Eo='Eo_20130805.txt';
Obs_Navia=0; File_Navia='';
Obs_Esba=0; File_Esba='Esva_20130805.txt';
Obs_Nalon=0; File_Nalon='Narcea_20130805.txt';
Obs_Sella=0; File_Sella='Sella_20130805.txt';
Obs_Bedon=0; File_Bedon='Bedon_20130805.txt';
Obs_Deva_Cantabria=0; File_Deva_Cantabria='Deva_20130805.txt';
Obs_Saja=0; File_Saja='Saja_20130805.txt';
Obs_Pas=0; File_Pas='Pas_20130805.txt';
Obs_Miera=0; File_Miera='Miera_20130805.txt';
Obs_Ason=0; File_Ason='Ason_20130805.txt';
Obs_Nervion=0; File_Nervion='Nervion_20130805.txt';
Obs_Deba_Euskadi=0; File_Deba_Euskadi='';
Obs_Oria=0; File_Oria='Oria_20130805.txt';
Obs_Bidasoa=0; File_Bidasoa='Bidasoa_20130805.txt';
Obs_Urumea=0; File_Urumea='Urumea_20130805.txt';
Obs_Adour=0; File_Adour='Adour_20130701.txt';
Obs_Eyre=0; File_Eyre='Eyre_20130701.txt';
Obs_Gironde=0; File_Gironde='Gironde_20130701.txt';
Obs_Charente=0; File_Charente='Charente_20130701.txt';
Obs_Sevre=0; File_Sevre='Sevre_20130701.txt';
Obs_Loire=0; File_Loire='Loire_20130701.txt';
Obs_Vilaine=0; File_Vilaine='Vilaine_20130701.txt';
Obs_Blavet=0; File_Blavet='Blavet_20130701.txt';
Obs_Laita=0; File_Laita='Laita_20130701.txt';
Obs_Odet=0; File_Odet='Odet_20130701.txt';

% -> Do you want a plot?
% ----------------------
plotdata=1;

%-----------------------END OF USER CONFIGURATION--------------------------------%%%

% Prefix "Q" means "discharge" and "F" means "quality Flag"
% Subfix "ud" means "updated"

time=[tini:tend]';

%%%  Read the current file  %%%
kk=importdata(currentfile,'\t',20);
colheaders=kk.colheaders;
data=kk.data;
isee=strmatch('Day',colheaders); day=data(:,isee);
isee=strmatch('Month',colheaders); month=data(:,isee);
isee=strmatch('Year',colheaders); year=data(:,isee);
t1=julian(year,month,day);	
isee=strmatch('QBarbate',colheaders); QBarbate=data(:,isee); FBarbate=data(:,isee+1);
isee=strmatch('QGuadalete',colheaders); QGuadalete=data(:,isee); FGuadalete=data(:,isee+1);
isee=strmatch('QGuadalquivir',colheaders); QGuadalquivir=data(:,isee); FGuadalquivir=data(:,isee+1);
isee=strmatch('QGuadiana',colheaders); QGuadiana=data(:,isee); FGuadiana=data(:,isee+1);
isee=strmatch('QQuarteira',colheaders); QQuarteira=data(:,isee); FQuarteira=data(:,isee+1);
isee=strmatch('QAljezur',colheaders); QAljezur=data(:,isee); FAljezur=data(:,isee+1);
isee=strmatch('QMira',colheaders); QMira=data(:,isee); FMira=data(:,isee+1);
isee=strmatch('QSado',colheaders); QSado=data(:,isee); FSado=data(:,isee+1);
isee=strmatch('QTajo',colheaders); QTajo=data(:,isee); FTajo=data(:,isee+1);
isee=strmatch('QMondego',colheaders); QMondego=data(:,isee); FMondego=data(:,isee+1);
isee=strmatch('QVouga',colheaders); QVouga=data(:,isee); FVouga=data(:,isee+1);
isee=strmatch('QDuero',colheaders); QDuero=data(:,isee); FDuero=data(:,isee+1);
isee=strmatch('QAve',colheaders); QAve=data(:,isee); FAve=data(:,isee+1);
isee=strmatch('QCavado',colheaders); QCavado=data(:,isee); FCavado=data(:,isee+1);
isee=strmatch('QLima',colheaders); QLima=data(:,isee); FLima=data(:,isee+1);
isee=strmatch('QMinho',colheaders); QMinho=data(:,isee); FMinho=data(:,isee+1);
isee=strmatch('QVerdugo',colheaders); QVerdugo=data(:,isee); FVerdugo=data(:,isee+1);
isee=strmatch('QLerez',colheaders); QLerez=data(:,isee); FLerez=data(:,isee+1);
isee=strmatch('QUmia',colheaders); QUmia=data(:,isee); FUmia=data(:,isee+1);
isee=strmatch('QUlla',colheaders); QUlla=data(:,isee); FUlla=data(:,isee+1);
isee=strmatch('QTambre',colheaders); QTambre=data(:,isee); FTambre=data(:,isee+1);
isee=strmatch('QGrande',colheaders); QGrande=data(:,isee); FGrande=data(:,isee+1);
isee=strmatch('QAnllons',colheaders); QAnllons=data(:,isee); FAnllons=data(:,isee+1);
isee=strmatch('QMandeo',colheaders); QMandeo=data(:,isee); FMandeo=data(:,isee+1);
isee=strmatch('QEume',colheaders); QEume=data(:,isee); FEume=data(:,isee+1);
isee=strmatch('QXubia',colheaders); QXubia=data(:,isee); FXubia=data(:,isee+1);
isee=strmatch('QMera',colheaders); QMera=data(:,isee); FMera=data(:,isee+1);
isee=strmatch('QSor',colheaders); QSor=data(:,isee); FSor=data(:,isee+1);
isee=strmatch('QLandro',colheaders); QLandro=data(:,isee); FLandro=data(:,isee+1);
isee=strmatch('QOuro',colheaders); QOuro=data(:,isee); FOuro=data(:,isee+1);
isee=strmatch('QMasma',colheaders); QMasma=data(:,isee); FMasma=data(:,isee+1);
isee=strmatch('QEo',colheaders); QEo=data(:,isee); FEo=data(:,isee+1);
isee=strmatch('QNavia',colheaders); QNavia=data(:,isee); FNavia=data(:,isee+1);
isee=strmatch('QEsba',colheaders); QEsba=data(:,isee); FEsba=data(:,isee+1);
isee=strmatch('QNalon',colheaders); QNalon=data(:,isee); FNalon=data(:,isee+1);
isee=strmatch('QSella',colheaders); QSella=data(:,isee); FSella=data(:,isee+1);
isee=strmatch('QBedon',colheaders); QBedon=data(:,isee); FBedon=data(:,isee+1);
isee=strmatch('QDeva_Cantabria',colheaders); QDeva_Cantabria=data(:,isee); FDeva_Cantabria=data(:,isee+1);
isee=strmatch('QSaja',colheaders); QSaja=data(:,isee); FSaja=data(:,isee+1);
isee=strmatch('QPas',colheaders); QPas=data(:,isee); FPas=data(:,isee+1);
isee=strmatch('QMiera',colheaders); QMiera=data(:,isee); FMiera=data(:,isee+1);
isee=strmatch('QAson',colheaders); QAson=data(:,isee); FAson=data(:,isee+1);
isee=strmatch('QNervion',colheaders); QNervion=data(:,isee); FNervion=data(:,isee+1);
isee=strmatch('QDeba_Euskadi',colheaders); QDeba_Euskadi=data(:,isee); FDeba_Euskadi=data(:,isee+1);
isee=strmatch('QOria',colheaders); QOria=data(:,isee); FOria=data(:,isee+1);
isee=strmatch('QBidasoa',colheaders); QBidasoa=data(:,isee); FBidasoa=data(:,isee+1);
isee=strmatch('QUrumea',colheaders); QUrumea=data(:,isee); FUrumea=data(:,isee+1);
isee=strmatch('QAdour',colheaders); QAdour=data(:,isee); FAdour=data(:,isee+1);
isee=strmatch('QEyre',colheaders); QEyre=data(:,isee); FEyre=data(:,isee+1);
isee=strmatch('QGironde',colheaders); QGironde=data(:,isee); FGironde=data(:,isee+1);
isee=strmatch('QCharente',colheaders); QCharente=data(:,isee); FCharente=data(:,isee+1);
isee=strmatch('QSevre',colheaders); QSevre=data(:,isee); FSevre=data(:,isee+1);
isee=strmatch('QLoire',colheaders); QLoire=data(:,isee); FLoire=data(:,isee+1);
isee=strmatch('QVilaine',colheaders); QVilaine=data(:,isee); FVilaine=data(:,isee+1);
isee=strmatch('QBlavet',colheaders); QBlavet=data(:,isee); FBlavet=data(:,isee+1);
isee=strmatch('QLaita',colheaders); QLaita=data(:,isee); FLaita=data(:,isee+1);
isee=strmatch('QOdet',colheaders); QOdet=data(:,isee); FOdet=data(:,isee+1);

%%%%%%%%%%%%%%%%
% Update Barbate
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QBarbate_ud(count)=QBarbate(isee);
     FBarbate_ud(count)=FBarbate(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QBarbate_ud(count)=2.52+1.18*sin(2*pi*monthofyear/12)-1.15*cos(2*pi*monthofyear/12);
     FBarbate_ud(count)=3;
  end
end
if(Obs_Barbate)
 disp(['UPDATING BARBATE FROM FILE.'])
 kk=importdata(File_Barbate);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QBarbate_ud(count)=q1(isee);
     FBarbate_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%
% Update Guadalete
%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QGuadalete_ud(count)=QGuadalete(isee);
     FGuadalete_ud(count)=FGuadalete(isee);
  else
     QGuadalete_ud(count)=7.35;
     FGuadalete_ud(count)=5;
  end
end
if(Obs_Guadalete)
 disp(['UPDATING GUADALETE FROM FILE.'])
 kk=importdata(File_Guadalete);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QGuadalete_ud(count)=q1(isee);
     FGuadalete_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%
% Update Guadalquivir
%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QGuadalquivir_ud(count)=QGuadalquivir(isee);
     FGuadalquivir_ud(count)=FGuadalquivir(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QGuadalquivir_ud(count)=99.03+64.29*sin(2*pi*monthofyear/12)+70.36*cos(2*pi*monthofyear/12);
     FGuadalquivir_ud(count)=3;
  end
end
if(Obs_Guadalquivir)
 disp(['UPDATING GUADALQUIVIR FROM FILE.'])
 kk=importdata(File_Guadalquivir);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 % No dejo que sea menor de 7 m3/s
 q1=kk(:,4); q1(q1<=0)=nan; q1(q1>0 & q1<7)=7;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QGuadalquivir_ud(count)=q1(isee);
     FGuadalquivir_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%
% Update Guadiana
%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QGuadiana_ud(count)=QGuadiana(isee);
     FGuadiana_ud(count)=FGuadiana(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QGuadiana_ud(count)=57.26+23.13*sin(2*pi*monthofyear/12)+60.82*cos(2*pi*monthofyear/12);
     FGuadiana_ud(count)=3;
  end
end
if(Obs_Guadiana)
 disp(['UPDATING GUADIANA FROM FILE.'])
 kk=importdata(File_Guadiana);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QGuadiana_ud(count)=q1(isee);
     FGuadiana_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%
% Update Quarteira
%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QQuarteira_ud(count)=QQuarteira(isee);
     FQuarteira_ud(count)=FQuarteira(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QQuarteira_ud(count)=1.99+0.42*sin(2*pi*monthofyear/12)+2.51*cos(2*pi*monthofyear/12);
     FQuarteira_ud(count)=3;
  end
end
if(Obs_Quarteira)
 disp(['UPDATING QUARTEIRA FROM FILE.'])
 kk=importdata(File_Quarteira);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QQuarteira_ud(count)=q1(isee);
     FQuarteira_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Aljezur
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QAljezur_ud(count)=QAljezur(isee);
     FAljezur_ud(count)=FAljezur(isee);
  else
     QAljezur_ud(count)=1;
     FAljezur_ud(count)=5;
  end
end
if(Obs_Aljezur)
 disp(['UPDATING ALJEZUR FROM FILE.'])
 kk=importdata(File_Aljezur);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QAljezur_ud(count)=q1(isee);
     FAljezur_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Mira
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QMira_ud(count)=QMira(isee);
     FMira_ud(count)=FMira(isee);
  else
     QMira_ud(count)=3;
     FMira_ud(count)=5;
  end
end
if(Obs_Mira)
 disp(['UPDATING MIRA FROM FILE.'])
 kk=importdata(File_Mira);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QMira_ud(count)=q1(isee);
     FMira_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Sado
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QSado_ud(count)=QSado(isee);
     FSado_ud(count)=FSado(isee);
  else
     QSado_ud(count)=40;
     FSado_ud(count)=5;
  end
end
if(Obs_Sado)
 disp(['UPDATING SADO FROM FILE.'])
 kk=importdata(File_Sado);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QSado_ud(count)=q1(isee);
     FSado_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Tajo
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QTajo_ud(count)=QTajo(isee);
     FTajo_ud(count)=FTajo(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QTajo_ud(count)=278.9+62.48*sin(2*pi*monthofyear/12)+220.80*cos(2*pi*monthofyear/12);
     FTajo_ud(count)=3;
  end
end
if(Obs_Tajo)
 disp(['UPDATING TAJO FROM FILE.'])
 kk=importdata(File_Tajo);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QTajo_ud(count)=q1(isee);
     FTajo_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Mondego
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QMondego_ud(count)=QMondego(isee);
     FMondego_ud(count)=FMondego(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QMondego_ud(count)=66.06+28.13*sin(2*pi*monthofyear/12)+57.58*cos(2*pi*monthofyear/12);
     FMondego_ud(count)=3;
  end
end
if(Obs_Mondego)
 disp(['UPDATING MONDEGO FROM FILE.'])
 kk=importdata(File_Mondego);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QMondego_ud(count)=q1(isee);
     FMondego_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Vouga
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QVouga_ud(count)=QVouga(isee);
     FVouga_ud(count)=FVouga(isee);
  else
     QVouga_ud(count)=32.2;
     FVouga_ud(count)=5;
  end
end
if(Obs_Vouga)
 disp(['UPDATING VOUGA FROM FILE.'])
 kk=importdata(File_Vouga);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QVouga_ud(count)=q1(isee);
     FVouga_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Duero
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QDuero_ud(count)=QDuero(isee);
     FDuero_ud(count)=FDuero(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QDuero_ud(count)=4.2399*monthofyear.^3-58.51*monthofyear.^2+90.839*monthofyear+960.13;
     FDuero_ud(count)=3;
  end
end
if(Obs_Duero)
 disp(['UPDATING DUERO FROM FILE.'])
 disp(['Be sure that you are using data from the Crestuma gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Duero);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*97682./96935;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QDuero_ud(count)=q1(isee);
     FDuero_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%
% Update Ave
%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QAve_ud(count)=QAve(isee);
     FAve_ud(count)=FAve(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QAve_ud(count)=0.285*monthofyear.^3-3.5448*monthofyear.^2+1.7966*monthofyear+73.651;
     FAve_ud(count)=3;
  end
end
if(Obs_Ave)
 disp(['UPDATING AVE FROM FILE.'])
 disp(['Be sure that you are using data from the Ponte de Ave gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Ave);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*1391./1109;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QAve_ud(count)=q1(isee);
     FAve_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%
% Update Cavado
%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QCavado_ud(count)=QCavado(isee);
     FCavado_ud(count)=FCavado(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QCavado_ud(count)=0.285*monthofyear.^3-3.5448*monthofyear.^2+1.7966*monthofyear+73.651;
     FCavado_ud(count)=3;
  end
end
if(Obs_Cavado)
 disp(['UPDATING CAVADO FROM FILE.'])
 disp(['Be sure that you are using data from the Barcelos gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Cavado);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*1648./1437;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QCavado_ud(count)=q1(isee);
     FCavado_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Lima
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QLima_ud(count)=QLima(isee);
     FLima_ud(count)=FLima(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QLima_ud(count)=0.6574*monthofyear^3-8.6071*monthofyear^2+8.7513*monthofyear+153.38;
     FLima_ud(count)=3;
  end
end
if(Obs_Lima)
 disp(['UPDATING LIMA FROM FILE.'])
 disp(['Be sure that you are using data from the Ponte de Lima gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Lima);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*2480./2220.56;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QLima_ud(count)=q1(isee);
     FLima_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Minho
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QMinho_ud(count)=QMinho(isee);
     FMinho_ud(count)=FMinho(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QMinho_ud(count)=1.7221*monthofyear^3-19.139*monthofyear^2-19.396*monthofyear+617.25;
     FMinho_ud(count)=3;
  end
end
if(Obs_Minho)
 disp(['UPDATING MINHO FROM FILE.'])
 disp(['Be sure that you are using data from the Foz do Mouro gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Minho);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*16347./15407;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QMinho_ud(count)=q1(isee);
     FMinho_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Verdugo
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QVerdugo_ud(count)=QVerdugo(isee);
     FVerdugo_ud(count)=FVerdugo(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QVerdugo_ud(count)=-0.0513*monthofyear^4+1.2755*monthofyear^3-9.2238*monthofyear^2+15.431*monthofyear+36.658;
     FVerdugo_ud(count)=3;
  end
end
if(Obs_Verdugo)
 disp(['UPDATING VERDUGO FROM FILE.'])
 disp(['Previously, this estimation was based on a combination of precipitation and runoff records.']);
 disp(['Modify the code to adapt it to you specific requirements.']);
 kk=importdata(File_Verdugo);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QVerdugo_ud(count)=q1(isee);
     FVerdugo_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Lerez
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QLerez_ud(count)=QLerez(isee);
     FLerez_ud(count)=FLerez(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QLerez_ud(count)=0.1268*monthofyear^3-1.0798*monthofyear^2-5.2356*monthofyear+58.915;
     FLerez_ud(count)=3;
  end
end
if(Obs_Lerez)
 disp(['UPDATING LEREZ FROM FILE.'])
 disp(['Be sure that you are using the station of Campolameiro. Maybe you are using O Couso']);
 kk=importdata(File_Lerez);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 %q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*409./248; %Campolameiro
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*450./408; %O Couso
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QLerez_ud(count)=q1(isee);
     FLerez_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Umia
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QUmia_ud(count)=QUmia(isee);
     FUmia_ud(count)=FUmia(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QUmia_ud(count)=0.1022*monthofyear^3-0.8155*monthofyear^2-4.3291*monthofyear+48.84;
     FUmia_ud(count)=3;
  end
end
if(Obs_Umia)
 disp(['UPDATING UMIA FROM FILE.'])
 disp(['Be sure that you are using data from the Caldas de Reis gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Umia);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*446./383;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QUmia_ud(count)=q1(isee);
     FUmia_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Ulla
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QUlla_ud(count)=QUlla(isee);
     FUlla_ud(count)=FUlla(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QUlla_ud(count)=0.5165*monthofyear^3-5.8022*monthofyear^2-2.947*monthofyear+153.85;
     FUlla_ud(count)=3;
  end
end
if(Obs_Ulla)
 disp(['UPDATING ULLA FROM FILE.'])
 disp(['Be sure that you are using data from the Santiso (now, PonteNova) gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Ulla);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*2804./516;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QUlla_ud(count)=q1(isee);
     FUlla_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%
% Update Tambre
%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QTambre_ud(count)=QTambre(isee);
     FTambre_ud(count)=FTambre(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QTambre_ud(count)=0.4238*monthofyear^3-4.1096*monthofyear^2-10.179*monthofyear+171.67;
     FTambre_ud(count)=3;
  end
end
if(Obs_Tambre)
 disp(['UPDATING TAMBRE FROM FILE.'])
 disp(['Be sure that you are using data from the Carollo-Sigueiro gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Tambre);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*1526./1146;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QTambre_ud(count)=q1(isee);
     FTambre_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update Grande - Camarinas
%%%%%%%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QGrande(isee)))
     QGrande_ud(count)=QGrande(isee);
     FGrande_ud(count)=FGrande(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QGrande_ud(count)=12.4537+4.1593*sin(2*pi*monthofyear/12)+11.1019*cos(2*pi*monthofyear/12);
     FGrande_ud(count)=3;
  end
end
if(Obs_Grande)
 disp(['UPDATING GRANDE FROM FILE.'])
 disp(['Be sure that you are using data from the As Casasnovas 497 gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Grande);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*283./251;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QGrande_ud(count)=q1(isee);
     FGrande_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Anll�ns
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QAnllons(isee)))
     QAnllons_ud(count)=QAnllons(isee);
     FAnllons_ud(count)=FAnllons(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QAnllons_ud(count)=13.1504+6.1333*sin(2*pi*monthofyear/12)+7.8843*cos(2*pi*monthofyear/12);
     FAnllons_ud(count)=3;
  end
end
if(Obs_Anllons)
 disp(['UPDATING ANLLONS FROM FILE.'])
 disp(['Be sure that you are using data from the Ponteceso 485 gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Anllons);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*516./438;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QAnllons_ud(count)=q1(isee);
     FAnllons_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%
% Update Mandeo
%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QMandeo_ud(count)=QMandeo(isee);
     FMandeo_ud(count)=FMandeo(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QMandeo_ud(count)=14.4608+8.9636*sin(2*pi*monthofyear/12)+8.7467*cos(2*pi*monthofyear/12);
     FMandeo_ud(count)=3;
  end
end
if(Obs_Mandeo)
 disp(['UPDATING MANDEO FROM FILE.'])
 disp(['Be sure that you are using data Aguas de Galicia 464 gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Mandeo);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*456.97/248.21; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QMandeo_ud(count)=q1(isee);
     FMandeo_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Eume
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QEume(isee)))
     QEume_ud(count)=QEume(isee);
     FEume_ud(count)=FEume(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QEume_ud(count)=14.9396+1.4619*sin(2*pi*monthofyear/12)+9.4839*cos(2*pi*monthofyear/12);
     FEume_ud(count)=3;
  end
end
if(Obs_Eume)
 disp(['UPDATING EUME FROM FILE.'])
 disp(['Be sure that you are using data from the 455 Riveiranova gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Eume);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*470./190;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QEume_ud(count)=q1(isee);
     FEume_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Xubia
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QXubia_ud(count)=QXubia(isee);
     FXubia_ud(count)=FXubia(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QXubia_ud(count)=5.8892+2.3060*sin(2*pi*monthofyear/12)+4.4092*cos(2*pi*monthofyear/12);
     FXubia_ud(count)=3;
  end
end
if(Obs_Xubia)
 disp(['UPDATING XUBIA FROM FILE.'])
 disp(['Be sure that you are using data Aguas de Galicia 446 gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Xubia);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*184.4./108.26; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QXubia_ud(count)=q1(isee);
     FXubia_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update Mera (mouth near Ortigueira)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QMera_ud(count)=QMera(isee);
     FMera_ud(count)=FMera(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QMera_ud(count)=6.2157+2.6235*sin(2*pi*monthofyear/12)+4.6965*cos(2*pi*monthofyear/12);
     FMera_ud(count)=3;
  end
end
if(Obs_Mera)
 disp(['UPDATING MERA FROM FILE.'])
 disp(['Be sure that you are using data Aguas de Galicia 443 gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Mera);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*126.99./102.20; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QMera_ud(count)=q1(isee);
     FMera_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%
% Update Sor
%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QSor(isee)))
     QSor_ud(count)=QSor(isee);
     FSor_ud(count)=FSor(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QSor_ud(count)=8.9280+2.3241*sin(2*pi*monthofyear/12)+7.4987*cos(2*pi*monthofyear/12);
     FSor_ud(count)=3;
  end
end
if(Obs_Sor)
 disp(['UPDATING SOR FROM FILE.'])
 disp(['Be sure that you are using data from the Sor Baixo 441 gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Sor);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*201./184;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QSor_ud(count)=q1(isee);
     FSor_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update Landro (mouth at Viveiro port)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QLandro_ud(count)=QLandro(isee);
     FLandro_ud(count)=FLandro(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QLandro_ud(count)=8.9362+4.0045*sin(2*pi*monthofyear/12)+4.2484*cos(2*pi*monthofyear/12);
     FLandro_ud(count)=3;
  end
end
if(Obs_Landro)
 disp(['UPDATING LANDRO FROM FILE.'])
 disp(['Be sure that you are using data Aguas de Galicia 438 gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Landro);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*269.6./198; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QLandro_ud(count)=q1(isee);
     FLandro_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Ouro
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QOuro(isee)))
     QOuro_ud(count)=QOuro(isee);
     FOuro_ud(count)=FOuro(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QOuro_ud(count)=5.1289+2.2654*sin(2*pi*monthofyear/12)+2.6942*cos(2*pi*monthofyear/12);
     FOuro_ud(count)=3;
  end
end
if(Obs_Ouro)
 disp(['UPDATING OURO FROM FILE.'])
 disp(['Be sure that you are using data from the 433 San Acisclo gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Ouro);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*189./162;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QOuro_ud(count)=q1(isee);
     FOuro_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Masma
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QMasma(isee)))
     QMasma_ud(count)=QMasma(isee);
     FMasma_ud(count)=FMasma(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QMasma_ud(count)=9.5422+3.0189*sin(2*pi*monthofyear/12)+4.4542*cos(2*pi*monthofyear/12);
     FMasma_ud(count)=3;
  end
end
if(Obs_Masma)
 disp(['UPDATING MASMA FROM FILE.'])
 disp(['Be sure that you are using data from the 431 Mondonhedo gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Masma);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*291./145;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QMasma_ud(count)=q1(isee);
     FMasma_ud(count)=1;
    end
 end
end

%%%%%%%%%%%
% Update EO
%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QEo_ud(count)=QEo(isee);
     FEo_ud(count)=FEo(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QEo_ud(count)=19.0445+8.1464*sin(2*pi*monthofyear/12)+11.6522*cos(2*pi*monthofyear/12);
     FEo_ud(count)=3;
  end
end
if(Obs_Eo)
 disp(['UPDATING EO FROM FILE.'])
 disp(['Be sure that you are using San Tirso gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Eo);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*826/712;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QEo_ud(count)=q1(isee);
     FEo_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Navia
%%%%%%%%%%%%%%
% Sólo hay datos climatológicos de medidas el el Doira de 1946 a 1968
% Había una curva climatológica puesta en el modelo, pero no
% sé de donde salió. Además, tenía el ciclo estacional incorrecto
% La curva de abajo ya está ponderada por el área de la cuenca (2578/2289)
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QNavia_ud(count)=QNavia(isee);
     FNavia_ud(count)=FNavia(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QNavia_ud(count)=75.4592+42.9443*sin(2*pi*monthofyear/12)+56.2306*cos(2*pi*monthofyear/12);
     FNavia_ud(count)=3;
  end
end
if(Obs_Navia)
 disp(['UPDATING NAVIA FROM FILE.'])
 disp(['Be sure that you are using the Doira gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Navia);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*2578/2289;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QNavia_ud(count)=q1(isee);
     FNavia_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Esba
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QEsba_ud(count)=QEsba(isee);
     FEsba_ud(count)=FEsba(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QEsba_ud(count)=11.2001+5.6429*sin(2*pi*monthofyear/12)+5.0437*cos(2*pi*monthofyear/12);
     FEsba_ud(count)=3;
  end
end
if(Obs_Esba)
 disp(['UPDATING ESBA FROM FILE.'])
 disp(['Be sure that you are using the Trevias gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Esba);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*465/411;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QEsba_ud(count)=q1(isee);
     FEsba_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update Nalon (Narcea is the main affluent)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QNalon_ud(count)=QNalon(isee);
     FNalon_ud(count)=FNalon(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QNalon_ud(count)=139.8184+75.4488*sin(2*pi*monthofyear/12)+52.4283*cos(2*pi*monthofyear/12);
     FNalon_ud(count)=3;
  end
end
if(Obs_Nalon)
 disp(['UPDATING NALON FROM FILE.'])
 disp(['Be sure that you are using the Requejo-Narcea (359) gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Nalon);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*4921/1705; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QNalon_ud(count)=q1(isee);
     FNalon_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Sella
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QSella_ud(count)=QSella(isee);
     FSella_ud(count)=FSella(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QSella_ud(count)=45.5121+24.1416*sin(2*pi*monthofyear/12)+20.9458*cos(2*pi*monthofyear/12);
     FSella_ud(count)=3;
  end
end
if(Obs_Sella)
 disp(['UPDATING SELLA FROM FILE.'])
 disp(['Be sure that you are using the Cangas de Onis gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Sella);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*1284/486; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QSella_ud(count)=q1(isee);
     FSella_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Bedon
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QBedon_ud(count)=QBedon(isee);
     FBedon_ud(count)=FBedon(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QBedon_ud(count)=5;
     FBedon_ud(count)=5;
  end
end
if(Obs_Bedon)
 disp(['UPDATING BEDON FROM FILE.'])
 disp(['Estacion de Rales']);
 kk=importdata(File_Bedon);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;   
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QBedon_ud(count)=q1(isee);
     FBedon_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%
% Update Deva_Cantabria
%%%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QDeva_Cantabria_ud(count)=QDeva_Cantabria(isee);
     FDeva_Cantabria_ud(count)=FDeva_Cantabria(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QDeva_Cantabria_ud(count)=26.5639+15.9053*sin(2*pi*monthofyear/12)+12.6800*cos(2*pi*monthofyear/12);
     FDeva_Cantabria_ud(count)=3;
  end
end
if(Obs_Deva_Cantabria)
 disp(['UPDATING DEVA-CANTABRIA FROM FILE.'])
 disp(['Be sure that you are using the Panes gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Deva_Cantabria);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*1208/643; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QDeva_Cantabria_ud(count)=q1(isee);
     FDeva_Cantabria_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Saja
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QSaja_ud(count)=QSaja(isee);
     FSaja_ud(count)=FSaja(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QSaja_ud(count)=23.8088+11.9912*sin(2*pi*monthofyear/12)+16.7616*cos(2*pi*monthofyear/12);
     FSaja_ud(count)=3;
  end
end
if(Obs_Saja)
 disp(['UPDATING SAJA FROM FILE.'])
 disp(['Be sure that you are using the Besaya gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Saja);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*1024/436; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QSaja_ud(count)=q1(isee);
     FSaja_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%
% Update Pas
%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QPas_ud(count)=QPas(isee);
     FPas_ud(count)=FPas(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QPas_ud(count)=15.8687+8.0690*sin(2*pi*monthofyear/12)+9.9056*cos(2*pi*monthofyear/12);
     FPas_ud(count)=3;
  end
end
if(Obs_Pas)
 disp(['UPDATING PAS FROM FILE.'])
 disp(['Be sure that you are using the Puente Viesgo gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Pas);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*661/357;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QPas_ud(count)=q1(isee);
     FPas_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Miera
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QMiera_ud(count)=QMiera(isee);
     FMiera_ud(count)=FMiera(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QMiera_ud(count)=6;
     FMiera_ud(count)=5;
  end
end
if(Obs_Miera)
 disp(['UPDATING MIERA FROM FILE.'])
 disp(['']);
 kk=importdata(File_Miera);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QMiera_ud(count)=q1(isee);
     FMiera_ud(count)=1;
    end
 end
end


%%%%%%%%%%%%%
% Update Ason
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QAson_ud(count)=QAson(isee);
     FAson_ud(count)=FAson(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QAson_ud(count)=23.7;
     FAson_ud(count)=5;
  end
end
if(Obs_Ason)
 disp(['UPDATING ASON FROM FILE.'])
 disp(['']);
 kk=importdata(File_Ason);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QAson_ud(count)=q1(isee);
     FAson_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Nervion
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QNervion_ud(count)=QNervion(isee);
     FNervion_ud(count)=FNervion(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QNervion_ud(count)=50.7733+29.3725*sin(2*pi*monthofyear/12)+34.6771*cos(2*pi*monthofyear/12);
     FNervion_ud(count)=3;
  end
end
if(Obs_Nervion)
 disp(['UPDATING NERVION FROM FILE.'])
 disp(['Be sure that you are using the Echevarri gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Nervion);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*1771/997; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QNervion_ud(count)=q1(isee);
     FNervion_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%
% Update Deba_Euskadi
%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QDeba_Euskadi_ud(count)=QDeba_Euskadi(isee);
     FDeba_Euskadi_ud(count)=FDeba_Euskadi(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QDeba_Euskadi_ud(count)=16.5625+6.7961*sin(2*pi*monthofyear/12)+10.2742*cos(2*pi*monthofyear/12);
     FDeba_Euskadi_ud(count)=3;
  end
end
if(Obs_Deba_Euskadi)
 disp(['UPDATING DEBA-EUSKADI FROM FILE.'])
 disp(['Be sure that you are using the Alzola gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Deba_Euskadi);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*530./456; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QDeba_Euskadi_ud(count)=q1(isee);
     FDeba_Euskadi_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Oria
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QOria_ud(count)=QOria(isee);
     FOria_ud(count)=FOria(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QOria_ud(count)=25.0091+12.3895*sin(2*pi*monthofyear/12)+15.1891*cos(2*pi*monthofyear/12);
     FOria_ud(count)=3;
  end
end
if(Obs_Oria)
 disp(['UPDATING ORIA FROM FILE.'])
 disp(['Be sure that you are using the Andoain gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Oria);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*883/775;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QOria_ud(count)=q1(isee);
     FOria_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Bidasoa
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QBidasoa_ud(count)=QBidasoa(isee);
     FBidasoa_ud(count)=FBidasoa(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QBidasoa_ud(count)=24.3340+13.2436*sin(2*pi*monthofyear/12)+13.8402*cos(2*pi*monthofyear/12);
     FBidasoa_ud(count)=3;
  end
end
if(Obs_Bidasoa)
 disp(['UPDATING BIDASOA FROM FILE.'])
 disp(['Be sure that you are using the Endarlaza gauging station (CHN). Otherwise, modify the script.']);
 kk=importdata(File_Bidasoa);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*703/681; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QBidasoa_ud(count)=q1(isee);
     FBidasoa_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%
% Update Urumea
%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QUrumea_ud(count)=QUrumea(isee);
     FUrumea_ud(count)=FUrumea(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QUrumea_ud(count)=16;
     FUrumea_ud(count)=5;
  end
end
if(Obs_Urumea)
 disp(['UPDATING URUMEA FROM FILE.'])
 disp(['']);
 kk=importdata(File_Urumea);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan;  
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QUrumea_ud(count)=q1(isee);
     FUrumea_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Adour
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QAdour_ud(count)=QAdour(isee);
     FAdour_ud(count)=FAdour(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QAdour_ud(count)=179.747+87.9269*sin(2*pi*monthofyear/12)+71.6678*cos(2*pi*monthofyear/12);
     FAdour_ud(count)=3;
  end
end
if(Obs_Adour)
 disp(['UPDATING ADOUR FROM FILE.']);
 disp(['Be sure that you are using the Saint Vicent de Paul gauging station (Q3120010). Otherwise, modify the script.']);
 kk=importdata(File_Adour);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*16880/7830; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QAdour_ud(count)=q1(isee);
     FAdour_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%
% Update Eyre
%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QEyre_ud(count)=QEyre(isee);
     FEyre_ud(count)=FEyre(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QEyre_ud(count)=17.7813+9.4535*sin(2*pi*monthofyear/12)+7.1821*cos(2*pi*monthofyear/12);
     FEyre_ud(count)=3;
  end
end
if(Obs_Eyre)
 disp(['UPDATING EYRE FROM FILE.']);
 disp(['Be sure that you are using the Salles gauging station (S2242510). Otherwise, modify the script.']); 
 kk=importdata(File_Eyre);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1*1700/1650; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QEyre_ud(count)=q1(isee);
     FEyre_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Gironde
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QGironde_ud(count)=QGironde(isee);
     FGironde_ud(count)=FGironde(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QGironde_ud(count)=1177+666*sin(2*pi*monthofyear/12)+427*cos(2*pi*monthofyear/12);
     FGironde_ud(count)=3;
  end
end
if(Obs_Gironde)
 disp(['UPDATING GIRONDE ESTUARY (GARONNE + DORDOGNE) FROM FILE.']);
 disp(['You are using the overall contribution of Garonne and Dordogne extrapolated at the total basin area. Please, modify the code to match your requirements.']);
 kk=importdata(File_Gironde);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*80780/66476; %The ratio is the sum of Garonne and Dordogne
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QGironde_ud(count)=q1(isee);
     FGironde_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WARNING: NO DATA FOR SEUDRE RIVER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
% Update Charente
%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QCharente_ud(count)=QCharente(isee);
     FCharente_ud(count)=FCharente(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QCharente_ud(count)=73.9650+52.2371*sin(2*pi*monthofyear/12)+33.7421*cos(2*pi*monthofyear/12);
     FCharente_ud(count)=3;
  end
end
if(Obs_Charente)
 disp(['UPDATING CHARENTE FROM FILE.']);
 disp(['Be sure that you are using the Chaniers gauging station (R5200010). Otherwise, modify the script.']);
 kk=importdata(File_Charente);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*10000/7412; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QCharente_ud(count)=q1(isee);
     FCharente_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%
% Update Sevre Noirtiase
%%%%%%%%%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QSevre_ud(count)=QSevre(isee);
     FSevre_ud(count)=FSevre(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QSevre_ud(count)=41.0799+22.7983*sin(2*pi*monthofyear/12)+32.6293*cos(2*pi*monthofyear/12);
     FSevre_ud(count)=3;
  end
end
if(Obs_Sevre)
 disp(['UPDATING SEVRE NOIRTIASE FROM FILE.']);
 disp(['Be sure that you are using the Niort gauging station (N4300623). Otherwise, modify the script.']);
 kk=importdata(File_Sevre);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*3650/1074;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QSevre_ud(count)=q1(isee);
     FSevre_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%
% Update Loire
%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QLoire_ud(count)=QLoire(isee);
     FLoire_ud(count)=FLoire(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QLoire_ud(count)=873.0637+489.2958*sin(2*pi*monthofyear/12)+392.2475*cos(2*pi*monthofyear/12);
     FLoire_ud(count)=3;
  end
end
if(Obs_Loire)
 disp(['UPDATING LOIRE FROM FILE.']);
 disp(['Be sure that you are using the Saint Nazare gauging station (M8420010). Otherwise, modify the script.']);
 kk=importdata(File_Loire);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; %The gauging station is close to the mouth
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QLoire_ud(count)=q1(isee);
     FLoire_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%%
% Update Vilaine
%%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee))
     QVilaine_ud(count)=QVilaine(isee);
     FVilaine_ud(count)=FVilaine(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QVilaine_ud(count)=78.9090+51.5990*sin(2*pi*monthofyear/12)+70.0185*cos(2*pi*monthofyear/12);
     FVilaine_ud(count)=3;
  end
end
if(Obs_Vilaine)
 disp(['UPDATING VILAINE FROM FILE.']);
 disp(['Be sure that you are using the Rieux gauging station (J9300611). Otherwise, modify the script.']);
 kk=importdata(File_Vilaine);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*10882/10100;
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QVilaine_ud(count)=q1(isee);
     FVilaine_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%
% Update Blavet
%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QBlavet(isee)))
     QBlavet_ud(count)=QBlavet(isee);
     FBlavet_ud(count)=FBlavet(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QBlavet_ud(count)=25.4758+15.3485*sin(2*pi*monthofyear/12)+17.6589*cos(2*pi*monthofyear/12);
     FBlavet_ud(count)=3;
  end
end
if(Obs_Blavet)
 disp(['UPDATING BLAVET FROM FILE.'])
 disp(['Be sure that you are using data from the Languidic (J5712130) gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Blavet);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*1; %The relation between areas is unknown
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QBlavet_ud(count)=q1(isee);
     FBlavet_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%
% Update Laita
%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QLaita(isee)))
     QLaita_ud(count)=QLaita(isee);
     FLaita_ud(count)=FLaita(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QLaita_ud(count)=13.4767+7.5138*sin(2*pi*monthofyear/12)+9.5886*cos(2*pi*monthofyear/12);
     FLaita_ud(count)=3;
  end
end
if(Obs_Laita)
 disp(['UPDATING LAITA FROM FILE.'])
 disp(['Be sure that you are using data from the Quimperl� (J4902012) gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Laita);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*1; %The relation between areas is unknown
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QLaita_ud(count)=q1(isee);
     FLaita_ud(count)=1;
    end
 end
end

%%%%%%%%%%%%%%%
% Update L'Odet
%%%%%%%%%%%%%%%
for count=1:length(time)
  isee=find(t1==time(count));
  if(~isempty(isee) & ~isnan(QOdet(isee)))
     QOdet_ud(count)=QOdet(isee);
     FOdet_ud(count)=FOdet(isee);
  else
     gd=gregorian(time(count));
     monthofyear=mod((time(count)-julian(gd(1),1,1)),365)*12/365.;
     QOdet_ud(count)=17.1470+6.3953*sin(2*pi*monthofyear/12)+11.6004*cos(2*pi*monthofyear/12);
     FOdet_ud(count)=3;
  end
end
if(Obs_Odet)
 disp(['UPDATING ODET FROM FILE.'])
 disp(['Be sure that you are using data from the Quimper (J4231910) gauging station. Otherwise, modify the script.']);
 kk=importdata(File_Odet);
 d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
 q1=kk(:,4); q1(q1<=0)=nan; q1=q1.*715/329; 
 for count=1:length(time)
    isee=find(t2==time(count));
    if(~isempty(isee) & ~isnan(q1(isee)))
     QOdet_ud(count)=q1(isee);
     FOdet_ud(count)=1;
    end
 end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Try to increase the quality level of the estimations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
updatebyclims;

%%%%%%%%%%%%%%%%%%
% Plot time-series 
%%%%%%%%%%%%%%%%%%
if(plotdata)
  plot_uptodate_rivers;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creación de un nuevo archivo 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fi=fopen(uptodatefile,'w');
%
% Escritura del cabecero
%
fprintf(fi,'%s\n','# MEAN DAILY RIVER DISCHARGE AT MOUTH RIVERS');
fprintf(fi,'%s\n','#');
fprintf(fi,'%s\n','# This file compiles runoff data from Porto (Portugal) to Bretagne (France)');
fprintf(fi,'%s\n','# The first letter means: "Q" discharge in m3s-1');
fprintf(fi,'%s\n','#                         "F" quality flag');
fprintf(fi,'%s\n','#');
fprintf(fi,'%s\n','# Qualily flags: 1 - Estimated runoff from the furthest downstream available gauging station');
fprintf(fi,'%s\n','#                2 - Estimation using the seasonal cycle and real data from other river basin');
fprintf(fi,'%s\n','#                3 - Seasonal cycle without correction');
fprintf(fi,'%s\n','#                4 - Estimation using the seasonal cycle and the NCEP precipitation data');
fprintf(fi,'%s\n','#                5 - Mean annual discharge; constant value');
fprintf(fi,'%s\n','#                6 - Interpolation between mean monthly values recorded by gauging stations');
fprintf(fi,'%s\n','#');
fprintf(fi,'%s\n','# For further information, see Otero et al. (2010) "Climatology and reconstruction of runoff time series');
fprintf(fi,'%s\n','# in northwest Iberia: influence in the shelf buoyancy budget off Ria de Vigo", Scientia Marina 74(2), 247-266');
fprintf(fi,'%s%s\n','# Last update: ',datestr(floor(now)));
fprintf(fi,'%s\n','# pablo.otero@co.ieo.es');
fprintf(fi,'%s\n','# INSTITUTO ESPAÑOL DE OCEANOGRAFIA');
fprintf(fi,'%s\n','#');

%for count=1:length(colheaders)
% nameheader=cell2str(colheaders(count));
% fprintf(fi,'%s\t',nameheader(3:end-1));
%end
%fprintf(fi,'\n');


fprintf(fi,'%s\t%s\t%s\t','Day', 'Month', 'Year');
fprintf(fi,'%s\t%s\t','QBarbate', 'FBarbate');
fprintf(fi,'%s\t%s\t','QGuadalete', 'FGuadalete');
fprintf(fi,'%s\t%s\t','QGuadalquivir', 'FGuadalquivir');
fprintf(fi,'%s\t%s\t','QGuadiana', 'FGuadiana');
fprintf(fi,'%s\t%s\t','QQuarteira', 'FQuarteira');
fprintf(fi,'%s\t%s\t','QAljezur', 'FAljezur');
fprintf(fi,'%s\t%s\t','QMira', 'FMira');
fprintf(fi,'%s\t%s\t','QSado', 'FSado');
fprintf(fi,'%s\t%s\t','QTajo', 'FTajo');
fprintf(fi,'%s\t%s\t','QMondego', 'FMondego');
fprintf(fi,'%s\t%s\t','QVouga', 'FVouga');
fprintf(fi,'%s\t%s\t','QDuero', 'FDuero');
fprintf(fi,'%s\t%s\t','QAve', 'FAve');
fprintf(fi,'%s\t%s\t','QCavado', 'FCavado');
fprintf(fi,'%s\t%s\t','QLima', 'FLima');
fprintf(fi,'%s\t%s\t','QMinho', 'FMinho');
fprintf(fi,'%s\t%s\t','QVerdugo', 'FVerdugo');
fprintf(fi,'%s\t%s\t','QLerez', 'FLerez');
fprintf(fi,'%s\t%s\t','QUmia', 'FUmia');
fprintf(fi,'%s\t%s\t','QUlla', 'FUlla');
fprintf(fi,'%s\t%s\t','QTambre', 'FTambre');
fprintf(fi,'%s\t%s\t','QGrande', 'FGrande');
fprintf(fi,'%s\t%s\t','QAnllons', 'FAnllons');
fprintf(fi,'%s\t%s\t','QMandeo', 'FMandeo');
fprintf(fi,'%s\t%s\t','QEume', 'FEume');
fprintf(fi,'%s\t%s\t','QXubia', 'FXubia');
fprintf(fi,'%s\t%s\t','QMera', 'FMera');
fprintf(fi,'%s\t%s\t','QSor', 'FSor');
fprintf(fi,'%s\t%s\t','QLandro', 'FLandro');
fprintf(fi,'%s\t%s\t','QOuro', 'FOuro');
fprintf(fi,'%s\t%s\t','QMasma', 'FMasma');
fprintf(fi,'%s\t%s\t','QEo', 'FEo');
fprintf(fi,'%s\t%s\t','QNavia', 'FNavia');
fprintf(fi,'%s\t%s\t','QEsba', 'FEsba');
fprintf(fi,'%s\t%s\t','QNalon', 'FNalon');
fprintf(fi,'%s\t%s\t','QSella', 'FSella');
fprintf(fi,'%s\t%s\t','QBedon', 'FBedon');
fprintf(fi,'%s\t%s\t','QDeva_Cantabria', 'FDeva_Cantabria');
fprintf(fi,'%s\t%s\t','QSaja', 'FSaja');
fprintf(fi,'%s\t%s\t','QPas', 'FPas');
fprintf(fi,'%s\t%s\t','QMiera', 'FMiera');
fprintf(fi,'%s\t%s\t','QAson', 'FAson');
fprintf(fi,'%s\t%s\t','QNervion', 'FNervion');
fprintf(fi,'%s\t%s\t','QDeba_Euskadi', 'FDeba_Euskadi');
fprintf(fi,'%s\t%s\t','QOria', 'FOria');
fprintf(fi,'%s\t%s\t','QBidasoa', 'FBidasoa');
fprintf(fi,'%s\t%s\t','QUrumea', 'FUrumea');
fprintf(fi,'%s\t%s\t','QAdour', 'FAdour');
fprintf(fi,'%s\t%s\t','QEyre', 'FEyre');
fprintf(fi,'%s\t%s\t','QGironde', 'FGironde');
fprintf(fi,'%s\t%s\t','QCharente', 'FCharente');
fprintf(fi,'%s\t%s\t','QSevre', 'FSevre');
fprintf(fi,'%s\t%s\t','QLoire', 'FLoire');
fprintf(fi,'%s\t%s\t','QVilaine', 'FVilaine');
fprintf(fi,'%s\t%s\t','QBlavet', 'FBlavet');
fprintf(fi,'%s\t%s\t','QLaita', 'FLaita');
fprintf(fi,'%s\t%s\n','QOdet', 'FOdet');

%
% Cubre con los datos
%
for count=1:length(time)
  gd=gregorian(time(count));
  fprintf(fi,'%d\t%d\t%d\t',gd(3),gd(2),gd(1));
  fprintf(fi,'%.2f\t%d\t',QBarbate_ud(count),FBarbate_ud(count));
  fprintf(fi,'%.2f\t%d\t',QGuadalete_ud(count),FGuadalete_ud(count));
  fprintf(fi,'%.2f\t%d\t',QGuadalquivir_ud(count),FGuadalquivir_ud(count));
  fprintf(fi,'%.2f\t%d\t',QGuadiana_ud(count),FGuadiana_ud(count));
  fprintf(fi,'%.2f\t%d\t',QQuarteira_ud(count),FQuarteira_ud(count));
  fprintf(fi,'%.2f\t%d\t',QAljezur_ud(count),FAljezur_ud(count));
  fprintf(fi,'%.2f\t%d\t',QMira_ud(count),FMira_ud(count));
  fprintf(fi,'%.2f\t%d\t',QSado_ud(count),FSado_ud(count));
  fprintf(fi,'%.2f\t%d\t',QTajo_ud(count),FTajo_ud(count));
  fprintf(fi,'%.2f\t%d\t',QMondego_ud(count),FMondego_ud(count));
  fprintf(fi,'%.2f\t%d\t',QVouga_ud(count),FVouga_ud(count));
  fprintf(fi,'%.2f\t%d\t',QDuero_ud(count),FDuero_ud(count));
  fprintf(fi,'%.2f\t%d\t',QAve_ud(count),FAve_ud(count));
  fprintf(fi,'%.2f\t%d\t',QCavado_ud(count),FCavado_ud(count));
  fprintf(fi,'%.2f\t%d\t',QLima_ud(count),FLima_ud(count));
  fprintf(fi,'%.2f\t%d\t',QMinho_ud(count),FMinho_ud(count));
  fprintf(fi,'%.2f\t%d\t',QVerdugo_ud(count),FVerdugo_ud(count));
  fprintf(fi,'%.2f\t%d\t',QLerez_ud(count),FLerez_ud(count));
  fprintf(fi,'%.2f\t%d\t',QUmia_ud(count),FUmia_ud(count));
  fprintf(fi,'%.2f\t%d\t',QUlla_ud(count),FUlla_ud(count));
  fprintf(fi,'%.2f\t%d\t',QTambre_ud(count),FTambre_ud(count));
  fprintf(fi,'%.2f\t%d\t',QGrande_ud(count),FGrande_ud(count));
  fprintf(fi,'%.2f\t%d\t',QAnllons_ud(count),FAnllons_ud(count));
  fprintf(fi,'%.2f\t%d\t',QMandeo_ud(count),FMandeo_ud(count));
  fprintf(fi,'%.2f\t%d\t',QEume_ud(count),FEume_ud(count));
  fprintf(fi,'%.2f\t%d\t',QXubia_ud(count),FXubia_ud(count));
  fprintf(fi,'%.2f\t%d\t',QMera_ud(count),FMera_ud(count));
  fprintf(fi,'%.2f\t%d\t',QSor_ud(count),FSor_ud(count));
  fprintf(fi,'%.2f\t%d\t',QLandro_ud(count),FLandro_ud(count));
  fprintf(fi,'%.2f\t%d\t',QOuro_ud(count),FOuro_ud(count));
  fprintf(fi,'%.2f\t%d\t',QMasma_ud(count),FMasma_ud(count));
  fprintf(fi,'%.2f\t%d\t',QEo_ud(count),FEo_ud(count)); 
  fprintf(fi,'%.2f\t%d\t',QNavia_ud(count),FNavia_ud(count)); 
  fprintf(fi,'%.2f\t%d\t',QEsba_ud(count),FEsba_ud(count)); 
  fprintf(fi,'%.2f\t%d\t',QNalon_ud(count),FNalon_ud(count)); 
  fprintf(fi,'%.2f\t%d\t',QSella_ud(count),FSella_ud(count));
  fprintf(fi,'%.2f\t%d\t',QBedon_ud(count),FBedon_ud(count));
  fprintf(fi,'%.2f\t%d\t',QDeva_Cantabria_ud(count),FDeva_Cantabria_ud(count));
  fprintf(fi,'%.2f\t%d\t',QSaja_ud(count),FSaja_ud(count));
  fprintf(fi,'%.2f\t%d\t',QPas_ud(count),FPas_ud(count));
  fprintf(fi,'%.2f\t%d\t',QMiera_ud(count),FMiera_ud(count));
  fprintf(fi,'%.2f\t%d\t',QAson_ud(count),FAson_ud(count));
  fprintf(fi,'%.2f\t%d\t',QNervion_ud(count),FNervion_ud(count));
  fprintf(fi,'%.2f\t%d\t',QDeba_Euskadi_ud(count),FDeba_Euskadi_ud(count));
  fprintf(fi,'%.2f\t%d\t',QOria_ud(count),FOria_ud(count));
  fprintf(fi,'%.2f\t%d\t',QBidasoa_ud(count),FBidasoa_ud(count));
  fprintf(fi,'%.2f\t%d\t',QUrumea_ud(count),FUrumea_ud(count));
  fprintf(fi,'%.2f\t%d\t',QAdour_ud(count),FAdour_ud(count));
  fprintf(fi,'%.2f\t%d\t',QEyre_ud(count),FEyre_ud(count));
  fprintf(fi,'%.2f\t%d\t',QGironde_ud(count),FGironde_ud(count));
  fprintf(fi,'%.2f\t%d\t',QCharente_ud(count),FCharente_ud(count));
  fprintf(fi,'%.2f\t%d\t',QSevre_ud(count),FSevre_ud(count));
  fprintf(fi,'%.2f\t%d\t',QLoire_ud(count),FLoire_ud(count));
  fprintf(fi,'%.2f\t%d\t',QVilaine_ud(count),FVilaine_ud(count));
  fprintf(fi,'%.2f\t%d\t',QBlavet_ud(count),FBlavet_ud(count));
  fprintf(fi,'%.2f\t%d\t',QLaita_ud(count),FLaita_ud(count));
  fprintf(fi,'%.2f\t%d\n',QOdet_ud(count),FOdet_ud(count));
end
fclose(fi)












