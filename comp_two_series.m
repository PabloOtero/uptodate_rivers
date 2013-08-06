clear all
close all

currentfile='Rios_20120730g.txt'; 
oldfile='Rios_20101228.txt';

% -> Select the time interval
% ---------------------------
tini=julian(2006,1,1);
tend=julian(2008,1,1);

%%%  Read the current file  %%%
kk=importdata(oldfile,'\t',20);
colheaders=kk.colheaders;
data=kk.data;
isee=strmatch('Day',colheaders); day=data(:,isee);
isee=strmatch('Month',colheaders); month=data(:,isee);
isee=strmatch('Year',colheaders); year=data(:,isee);
time=julian(year,month,day);
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
isee=strmatch('QDeva_Cantabria',colheaders); QDeva_Cantabria=data(:,isee); FDeva_Cantabria=data(:,isee+1);
isee=strmatch('QSaja',colheaders); QSaja=data(:,isee); FSaja=data(:,isee+1);
isee=strmatch('QPas',colheaders); QPas=data(:,isee); FPas=data(:,isee+1);
isee=strmatch('QNervion',colheaders); QNervion=data(:,isee); FNervion=data(:,isee+1);
isee=strmatch('QDeba_Euskadi',colheaders); QDeba_Euskadi=data(:,isee); FDeba_Euskadi=data(:,isee+1);
isee=strmatch('QOria',colheaders); QOria=data(:,isee); FOria=data(:,isee+1);
isee=strmatch('QBidasoa',colheaders); QBidasoa=data(:,isee); FBidasoa=data(:,isee+1);
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

fig1=figure('position', [20 20 700 800]);
set(fig1,'Name','Atlantic Rivers');
for count=1:10
 if(count==1)
   Q=QDuero; F=FDuero; rivername='Duero';
 elseif(count==2)
   Q=QAve; F=FAve; rivername='Ave';
 elseif(count==3)
   Q=QCavado; F=FCavado; rivername='Cavado';
 elseif(count==4)
   Q=QLima; F=FLima; rivername='Lima';
 elseif(count==5)
   Q=QMinho; F=FMinho; rivername='Minho';
 elseif(count==6)
   Q=QVerdugo; F=FVerdugo; rivername='Verdugo';
 elseif(count==7)
   Q=QLerez; F=FLerez; rivername='Lerez';
 elseif(count==8)
   Q=QUmia; F=FUmia; rivername='Umia';
 elseif(count==9)
   Q=QUlla; F=FUlla; rivername='Ulla';
 elseif(count==10)
   Q=QTambre; F=FTambre; rivername='Tambre';
 end
 subplot(5,2,count)
 hh=bar(time,Q)
 set(hh,'EdgeColor',[0.5 0.5 0.5])
 axis([min(time) max(time) 0 max(Q)]);
 gregaxy(time,4);
 clear Q, F;
end


fig2=figure('position', [20 20 700 800]);
set(fig2,'Name','Northern Galician Rivers');
for count=1:10
 if(count==1)
   Q=0; F=0; rivername='Grande'; 
 elseif(count==2)
   Q=0; F=0; rivername='Anllons';  
 elseif(count==3)
   Q=QMandeo; F=FMandeo; rivername='Mandeo';
 elseif(count==4)
   Q=0; F=0; rivername='Eume';
 elseif(count==5)
   Q=QXubia; F=FXubia; rivername='Xubia';
 elseif(count==6)
   Q=QMera; F=FMera; rivername='Mera';
 elseif(count==7)
   Q=0; F=0; rivername='Sor';
 elseif(count==8)
   Q=QLandro; F=FLandro; rivername='Landro';
 elseif(count==9)
   Q=0; F=0; rivername='Ouro';
 elseif(count==10)
   Q=0; F=0; rivername='Masma';
 end
 subplot(5,2,count)
 hh=bar(time,Q)
 set(hh,'EdgeColor',[0.5 0.5 0.5])
 if(max(Q)>0)
  axis([min(time) max(time) 0 max(Q)]);
 else
  axis([min(time) max(time) 0 100]);   
 end 
 gregaxy(time,4);
 clear Q, F;
end



fig3=figure('position', [20 20 700 800]);
set(fig3,'Name','Asturian Rivers');
for count=1:5
 if(count==1)
   Q=QEo; F=FEo; rivername='Eo';
 elseif(count==2)
   Q=QNavia; F=FNavia; rivername='Navia';
 elseif(count==3)
   Q=QEsba; F=FEsba; rivername='Esba';
 elseif(count==4)
   Q=QNalon; F=FNalon; rivername='Nalon';
 elseif(count==5)
   Q=QSella; F=FSella; rivername='Sella';
 end
 subplot(5,2,count)
 hh=bar(time,Q)
 set(hh,'EdgeColor',[0.5 0.5 0.5])
 axis([min(time) max(time) 0 max(Q)]);
 gregaxy(time,4);
 clear Q, F;
end


fig4=figure('position', [20 20 700 800]);
set(fig4,'Name','Cantabrian and Basque Country Rivers');
for count=1:7
 if(count==1)
    Q=QDeva_Cantabria; F=FDeva_Cantabria; rivername='Deva Cantabria';
 elseif(count==2)
   Q=QSaja; F=FSaja; rivername='Saja';
 elseif(count==3)
   Q=QPas; F=FPas; rivername='Pas';
 elseif(count==4)
   Q=QNervion; F=FNervion; rivername='Nervion';
 elseif(count==5)
   Q=QDeba_Euskadi; F=FDeba_Euskadi; rivername='Deba Euskadi';
 elseif(count==6)
   Q=QOria; F=FOria; rivername='Oria';
 elseif(count==7)
   Q=QBidasoa; F=FBidasoa; rivername='Bidasoa';
 end
 subplot(5,2,count)
 hh=bar(time,Q)
 set(hh,'EdgeColor',[0.5 0.5 0.5])
 gregaxy(time,4);
 clear Q, F;
end


fig5=figure('position', [20 20 700 800]);
set(fig5,'Name','French Rivers');
for count=1:10
 if(count==1)
   Q=QAdour; F=FAdour; rivername='Adour';
 elseif(count==2)
   Q=QEyre; F=FEyre; rivername='Eyre';
 elseif(count==3)
   Q=QGironde; F=FGironde; rivername='Gironde Estuary';
 elseif(count==4)
   Q=QCharente; F=FCharente; rivername='Charente';
 elseif(count==5)
   Q=QSevre; F=FSevre; rivername='Sevre Niortaise';
 elseif(count==6)
   Q=QLoire; F=FLoire; rivername='Loire';
 elseif(count==7)
   Q=QVilaine; F=FVilaine; rivername='Vilaine';
 elseif(count==8)
   Q=0; F=0; rivername='Blavet';
 elseif(count==9)
   Q=0; F=0; rivername='Laita';
 elseif(count==10)
   Q=0; F=0; rivername='Odet';
 end
 subplot(5,2,count)
 hh=bar(time,Q)
 set(hh,'EdgeColor',[0.5 0.5 0.5])
 if(max(Q)>0)
  axis([min(time) max(time) 0 max(Q)]);
 else
  axis([min(time) max(time) 0 100]);   
 end 
 gregaxy(time,4);
 clear Q, F;
end



%%%%%% CURRENT %%%%%%%%%

%%%  Read the current file  %%%
kk=importdata(currentfile,'\t',20);
colheaders=kk.colheaders;
data=kk.data;
isee=strmatch('Day',colheaders); day=data(:,isee);
isee=strmatch('Month',colheaders); month=data(:,isee);
isee=strmatch('Year',colheaders); year=data(:,isee);
time=julian(year,month,day);
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
isee=strmatch('QDeva_Cantabria',colheaders); QDeva_Cantabria=data(:,isee); FDeva_Cantabria=data(:,isee+1);
isee=strmatch('QSaja',colheaders); QSaja=data(:,isee); FSaja=data(:,isee+1);
isee=strmatch('QPas',colheaders); QPas=data(:,isee); FPas=data(:,isee+1);
isee=strmatch('QNervion',colheaders); QNervion=data(:,isee); FNervion=data(:,isee+1);
isee=strmatch('QDeba_Euskadi',colheaders); QDeba_Euskadi=data(:,isee); FDeba_Euskadi=data(:,isee+1);
isee=strmatch('QOria',colheaders); QOria=data(:,isee); FOria=data(:,isee+1);
isee=strmatch('QBidasoa',colheaders); QBidasoa=data(:,isee); FBidasoa=data(:,isee+1);
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


figure(fig1); hold on;
for count=1:10
 if(count==1)
   Q=QDuero; F=FDuero; rivername='Duero';
 elseif(count==2)
   Q=QAve; F=FAve; rivername='Ave';
 elseif(count==3)
   Q=QCavado; F=FCavado; rivername='Cavado';
 elseif(count==4)
   Q=QLima; F=FLima; rivername='Lima';
 elseif(count==5)
   Q=QMinho; F=FMinho; rivername='Minho';
 elseif(count==6)
   Q=QVerdugo; F=FVerdugo; rivername='Verdugo';
 elseif(count==7)
   Q=QLerez; F=FLerez; rivername='Lerez';
 elseif(count==8)
   Q=QUmia; F=FUmia; rivername='Umia';
 elseif(count==9)
   Q=QUlla; F=FUlla; rivername='Ulla';
 elseif(count==10)
   Q=QTambre; F=FTambre; rivername='Tambre';
 end
 subplot(5,2,count)
 hold on;
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([tini tend 0 max(Q)]);
 gregaxy(time,1);
 kk=text((tini+tend)/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 Atlantic_rivers_comp.png

figure(fig2); hold on;
for count=1:10
 if(count==1)
   Q=QGrande; F=FGrande; rivername='Grande'; 
 elseif(count==2)
   Q=QAnllons; F=FAnllons; rivername='Anllons';  
 elseif(count==3)
   Q=QMandeo; F=FMandeo; rivername='Mandeo';
 elseif(count==4)
   Q=QEume; F=FEume; rivername='Eume';
 elseif(count==5)
   Q=QXubia; F=FXubia; rivername='Xubia';
 elseif(count==6)
   Q=QMera; F=FMera; rivername='Mera';
 elseif(count==7)
   Q=QSor; F=FSor; rivername='Sor';
 elseif(count==8)
   Q=QLandro; F=FLandro; rivername='Landro';
 elseif(count==9)
   Q=QOuro; F=FOuro; rivername='Ouro';
 elseif(count==10)
   Q=QMasma; F=FMasma; rivername='Masma';
 end
 subplot(5,2,count)
 hold on
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([tini tend 0 max(Q)]);
 gregaxy(time,1);
 kk=text((tini+tend)/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 NorthernGalician_rivers_comp.png

figure(fig3); hold on;
for count=1:5
 if(count==1)
   Q=QEo; F=FEo; rivername='Eo';
 elseif(count==2)
   Q=QNavia; F=FNavia; rivername='Navia';
 elseif(count==3)
   Q=QEsba; F=FEsba; rivername='Esba';
 elseif(count==4)
   Q=QNalon; F=FNalon; rivername='Nalon';
 elseif(count==5)
   Q=QSella; F=FSella; rivername='Sella';
 end
 subplot(5,2,count)
 hold on;
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([tini tend 0 max(Q)]);
 gregaxy(time,1);
 kk=text((tini+tend)/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 Asturian_rivers_comp.png

figure(fig4); hold on;
for count=1:7
 if(count==1)
    Q=QDeva_Cantabria; F=FDeva_Cantabria; rivername='Deva Cantabria';
 elseif(count==2)
   Q=QSaja; F=FSaja; rivername='Saja';
 elseif(count==3)
   Q=QPas; F=FPas; rivername='Pas';
 elseif(count==4)
   Q=QNervion; F=FNervion; rivername='Nervion';
 elseif(count==5)
   Q=QDeba_Euskadi; F=FDeba_Euskadi; rivername='Deba Euskadi';
 elseif(count==6)
   Q=QOria; F=FOria; rivername='Oria';
 elseif(count==7)
   Q=QBidasoa; F=FBidasoa; rivername='Bidasoa';
 end
 subplot(5,2,count)
 hold on;
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([tini tend 0 max(Q)]);
 gregaxy(time,1);
 kk=text((tini+tend)/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end


fixedar;
print -dpng -r200 Cantabrian_BasqueCountry_rivers_comp.png

figure(fig5); hold on;
for count=1:10
 if(count==1)
   Q=QAdour; F=FAdour; rivername='Adour';
 elseif(count==2)
   Q=QEyre; F=FEyre; rivername='Eyre';
 elseif(count==3)
   Q=QGironde; F=FGironde; rivername='Gironde Estuary';
 elseif(count==4)
   Q=QCharente; F=FCharente; rivername='Charente';
 elseif(count==5)
   Q=QSevre; F=FSevre; rivername='Sevre Niortaise';
 elseif(count==6)
   Q=QLoire; F=FLoire; rivername='Loire';
 elseif(count==7)
   Q=QVilaine; F=FVilaine; rivername='Vilaine';
 elseif(count==8)
   Q=QBlavet; F=FBlavet; rivername='Blavet';
 elseif(count==9)
   Q=QLaita; F=FLaita; rivername='Laita';
 elseif(count==10)
   Q=QOdet; F=FOdet; rivername='Odet';
 end
 subplot(5,2,count)
 hold on;
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([tini tend 0 max(Q)]);
 gregaxy(time,1);
 kk=text((tini+tend)/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 French_rivers_comp.png

