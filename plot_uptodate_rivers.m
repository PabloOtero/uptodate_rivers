%
% This script plots updated runoff at the mouth of river.
% This script is called by uptodate_rivers.m
%

fig1=figure('position', [20 20 700 800]);
set(fig1,'Name','Andalucia and Algarve');
for count=1:5
 if(count==1)
   Q=QBarbate_ud; F=FBarbate_ud; rivername='Barbate';
 elseif(count==2)
   Q=QGuadalete_ud; F=FGuadalete_ud; rivername='Guadalate';
 elseif(count==3)
   Q=QGuadalquivir_ud; F=FGuadalquivir_ud; rivername='Guadalquivir';
 elseif(count==4)
   Q=QGuadiana_ud; F=FGuadiana_ud; rivername='Guadiana';
 elseif(count==5)
   Q=QQuarteira_ud; F=FQuarteira_ud; rivername='Quarteira';
 end
 subplot(5,2,count)
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([min(time) max(time) 0 max(Q)]);
 gregaxy(time,4);
 kk=text((time(1)+time(end))/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 Andalucia_Algarve_rivers.png


fig2=figure('position', [20 20 700 800]);
set(fig2,'Name','Atlantic Rivers - South');
for count=1:6
 if(count==1)
   Q=QAljezur_ud; F=FAljezur_ud; rivername='Aljezur';
 elseif(count==2)
   Q=QMira_ud; F=FMira_ud; rivername='Mira';
 elseif(count==3)
   Q=QSado_ud; F=FSado_ud; rivername='Sado';
 elseif(count==4)
   Q=QTajo_ud; F=FTajo_ud; rivername='Tajo';
 elseif(count==5)
   Q=QMondego_ud; F=FMondego_ud; rivername='Mondego';
 elseif(count==6)
   Q=QVouga_ud; F=FVouga_ud; rivername='Vouga';
 end
 subplot(5,2,count)
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([min(time) max(time) 0 max(Q)]);
 gregaxy(time,4);
 kk=text((time(1)+time(end))/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 Atlantic_rivers_south.png



fig3=figure('position', [20 20 700 800]);
set(fig3,'Name','Atlantic Rivers - North');
for count=1:10
 if(count==1)
   Q=QDuero_ud; F=FDuero_ud; rivername='Duero';
 elseif(count==2)
   Q=QAve_ud; F=FAve_ud; rivername='Ave';
 elseif(count==3)
   Q=QCavado_ud; F=FCavado_ud; rivername='Cavado';
 elseif(count==4)
   Q=QLima_ud; F=FLima_ud; rivername='Lima';
 elseif(count==5)
   Q=QMinho_ud; F=FMinho_ud; rivername='Minho';
 elseif(count==6)
   Q=QVerdugo_ud; F=FVerdugo_ud; rivername='Verdugo';
 elseif(count==7)
   Q=QLerez_ud; F=FLerez_ud; rivername='Lerez';
 elseif(count==8)
   Q=QUmia_ud; F=FUmia_ud; rivername='Umia';
 elseif(count==9)
   Q=QUlla_ud; F=FUlla_ud; rivername='Ulla';
 elseif(count==10)
   Q=QTambre_ud; F=FTambre_ud; rivername='Tambre';
 end
 subplot(5,2,count)
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([min(time) max(time) 0 max(Q)]);
 gregaxy(time,4);
 kk=text((time(1)+time(end))/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 Atlantic_rivers_north.png


fig4=figure('position', [20 20 700 800]);
set(fig4,'Name','Northern Galician Rivers');
for count=1:10
 if(count==1)
   Q=QGrande_ud; F=FGrande_ud; rivername='Grande'; 
 elseif(count==2)
   Q=QAnllons_ud; F=FAnllons_ud; rivername='Anllons';  
 elseif(count==3)
   Q=QMandeo_ud; F=FMandeo_ud; rivername='Mandeo';
 elseif(count==4)
   Q=QEume_ud; F=FEume_ud; rivername='Eume';
 elseif(count==5)
   Q=QXubia_ud; F=FXubia_ud; rivername='Xubia';
 elseif(count==6)
   Q=QMera_ud; F=FMera_ud; rivername='Mera';
 elseif(count==7)
   Q=QSor_ud; F=FSor_ud; rivername='Sor';
 elseif(count==8)
   Q=QLandro_ud; F=FLandro_ud; rivername='Landro';
 elseif(count==9)
   Q=QOuro_ud; F=FOuro_ud; rivername='Ouro';
 elseif(count==10)
   Q=QMasma_ud; F=FMasma_ud; rivername='Masma';
 end
 subplot(5,2,count)
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([min(time) max(time) 0 max(Q)]);
 gregaxy(time,4);
 kk=text((time(1)+time(end))/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 NorthernGalician_rivers.png


fig5=figure('position', [20 20 700 800]);
set(fig5,'Name','Asturian Rivers');
for count=1:6
 if(count==1)
   Q=QEo_ud; F=FEo_ud; rivername='Eo';
 elseif(count==2)
   Q=QNavia_ud; F=FNavia_ud; rivername='Navia';
 elseif(count==3)
   Q=QEsba_ud; F=FEsba_ud; rivername='Esba';
 elseif(count==4)
   Q=QNalon_ud; F=FNalon_ud; rivername='Nalon';
 elseif(count==5)
   Q=QSella_ud; F=FSella_ud; rivername='Sella';
 elseif(count==6)
   Q=QBedon_ud; F=FBedon_ud; rivername='Bedon';
 end
 subplot(5,2,count)
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 axis([min(time) max(time) 0 max(Q)]);
 gregaxy(time,4);
 kk=text((time(1)+time(end))/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 clear Q, F;
end

fixedar;
print -dpng -r200 Asturian_rivers.png

fig6=figure('position', [20 20 700 800]);
set(fig6,'Name','Cantabrian and Basque Country Rivers');
for count=1:10
 if(count==1)
    Q=QDeva_Cantabria_ud; F=FDeva_Cantabria_ud; rivername='Deva Cantabria';
 elseif(count==2)
   Q=QSaja_ud; F=FSaja_ud; rivername='Saja';
 elseif(count==3)
   Q=QPas_ud; F=FPas_ud; rivername='Pas';
 elseif(count==4)
   Q=QMiera_ud; F=FMiera_ud; rivername='Miera';
 elseif(count==5)
   Q=QAson_ud; F=FAson_ud; rivername='Ason';
 elseif(count==6)
   Q=QNervion_ud; F=FNervion_ud; rivername='Nervion';
 elseif(count==7)
   Q=QDeba_Euskadi_ud; F=FDeba_Euskadi_ud; rivername='Deba Euskadi';
 elseif(count==8)
   Q=QOria_ud; F=FOria_ud; rivername='Oria';
 elseif(count==9)
   Q=QBidasoa_ud; F=FBidasoa_ud; rivername='Bidasoa';
 elseif(count==10)
   Q=QUrumea_ud; F=FUrumea_ud; rivername='Urumea';
 end
 subplot(5,2,count)
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 if(min(Q)==max(Q))
    axis([min(time) max(time) 0 max(Q)*2]);
    kk=text((time(1)+time(end))/2,(min(Q)+max(Q)*2)/2,rivername); set(kk,'FontWeight','b');
 else
    axis([min(time) max(time) 0 max(Q)]);
    kk=text((time(1)+time(end))/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 end
 gregaxy(time,4);
 clear Q, F;
end

fixedar;
print -dpng -r200 Cantabrian_BasqueCountry_rivers.png

fig7=figure('position', [20 20 700 800]);
set(fig7,'Name','French Rivers');
for count=1:10
 if(count==1)
   Q=QAdour_ud; F=FAdour_ud; rivername='Adour';
 elseif(count==2)
   Q=QEyre_ud; F=FEyre_ud; rivername='Eyre';
 elseif(count==3)
   Q=QGironde_ud; F=FGironde_ud; rivername='Gironde Estuary';
 elseif(count==4)
   Q=QCharente_ud; F=FCharente_ud; rivername='Charente';
 elseif(count==5)
   Q=QSevre_ud; F=FSevre_ud; rivername='Sevre Niortaise';
 elseif(count==6)
   Q=QLoire_ud; F=FLoire_ud; rivername='Loire';
 elseif(count==7)
   Q=QVilaine_ud; F=FVilaine_ud; rivername='Vilaine';
 elseif(count==8)
   Q=QBlavet_ud; F=FBlavet_ud; rivername='Blavet';
 elseif(count==9)
   Q=QLaita_ud; F=FLaita_ud; rivername='Laita';
 elseif(count==10)
   Q=QOdet_ud; F=FOdet_ud; rivername='Odet';
 end
 subplot(5,2,count)
 isee=find(F==1); plot(time(isee),Q(isee),'.k'); hold on;
 isee=find(F==2); plot(time(isee),Q(isee),'.b');
 isee=find(F==3); plot(time(isee),Q(isee),'.r');
 isee=find(F==4); plot(time(isee),Q(isee),'.g');
 isee=find(F==5); plot(time(isee),Q(isee),'.m');
 isee=find(F==6); plot(time(isee),Q(isee),'.y');
 if(min(Q)==max(Q))
    axis([min(time) max(time) 0 max(Q)*2]);
    kk=text((time(1)+time(end))/2,(min(Q)+max(Q)*2)/2,rivername); set(kk,'FontWeight','b');
 else
    axis([min(time) max(time) 0 max(Q)]);
    kk=text((time(1)+time(end))/2,(min(Q)+max(Q))/2,rivername); set(kk,'FontWeight','b');
 end
 gregaxy(time,4);
 clear Q, F;
end

fixedar;
print -dpng -r200 French_rivers.png
