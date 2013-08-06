%
% This script updates data to Flag =4
%
% The method is published in Otero et al., 2010. Scientia Marina, 74(2), 247-266
%
% Creation date: 25-May-2010 pablo.otero@co.ieo.es

% Total basin areas in km2
ADuero=97692;
AAve=1391;
ACavado=1648;
ALima=2480;
AMinho=15548.67;
AVerdugo=348;
ALerez=450;
AUmia=446;
AUlla=2804;
ATambre=1526;

kk=gregorian(time(1)); iniyear=kk(1);
kk=gregorian(time(end)); endyear=kk(1);
timencep=[julian(iniyear,1,1):julian(endyear,12,31)];

disp(['NCEP data will be downloaded in the working directory']);
if(length(iniyear:endyear)>5) disp(['Take a coffee break']); end
eval(['!wget ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis/surface_gauss/land.sfc.gauss.nc'])
for data_year=iniyear:endyear
   eval(['!wget ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.dailyavgs/surface_gauss/prate.sfc.gauss.' num2str(data_year) '.nc'])
end

for data_year=iniyear:endyear
  filename=['prate.sfc.gauss.' num2str(data_year) '.nc'];
  nc=netcdf(filename);
  if(data_year==iniyear)  
    lat=nc{'lat'}(:); lon=nc{'lon'}(:);
    lon(lon>180) = lon(lon>180) - 360.;
    lo_in = ones(length(lat),1)* lon';
    la_in = lat * ones(1,length(lon));
    prate=nc{'prate'}(:);
    off=nc{'prate'}.add_offset(:);
    scl=nc{'prate'}.scale_factor(:);
    choiva=prate.*scl+off; % Units in Kg/(m2s)
  else
    prate=nc{'prate'}(:);
    off=nc{'prate'}.add_offset(:);
    scl=nc{'prate'}.scale_factor(:);
    prate=prate.*scl+off; % Units in Kg/(m2s)
    choiva=vertcat(choiva,prate);
  end
  close(nc)
end

% Sadly, we have only one location in Galicia and North Portugal
isee=find(lo_in>=-9 & lo_in<=-6.5 & la_in>41. & la_in<=43.5);
choivaNW=squeeze(choiva(:,isee));
k=0.94; ndays=26;
ith=[ndays:-1:1];
for i=(ndays+1):length(choiva)
  kk=choivaNW(i-ndays:(i-1));
  A(i)=(1-k)/(k-k^(ndays+1))*sum(kk.*(k.^ith)');
end
QMinho_prate=A*AMinho*1000000/1000; %Convertimos de 'Km2' a 'm2' y de 'litros' a 'm3'

ref=zeros(length(FMinho_ud),1);
isee=find(FMinho_ud==3 |  FMinho_ud==5);
isee2=find(diff(isee)==1);
ref(isee(isee2))=1;
ref(1:5)=0; ref2=ref;
for count=6:length(ref)-6
  if(prod(ref(count-5:count+5))==0) 
    ref2(count)=0; 
  end
end

isee=find(ref==1);
for count=1:length(isee)
 isee3=find(time(count)==timencep);
 if(~isempty(isee3)) 
   QMinho_ud(isee(count))=QMinho_prate(isee3);
 else
   disp(['no']);
 end
end







