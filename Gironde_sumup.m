%
% This script combines data from Garonne and Dordogne in one file
%
% Pablo Otero, May 2010

clear all

garonne_file='Garonne_20062007.txt';
dordogne_file='Dordogne_20062007.txt';

% Falta hacer la curva climatológica
kk=dlmread(garonne_file);
a1=kk(:,1); m1=kk(:,2); d1=kk(:,3); t1=julian(a1,m1,d1);
q1=kk(:,4); q1(q1<=0)=nan;

kk=dlmread(dordogne_file);
a2=kk(:,1); m2=kk(:,2); d2=kk(:,3); t2=julian(a2,m2,d2);
q2=kk(:,4); q2(q2<=0)=nan;

for i=1:length(t1)
 isee=find(t2==t1(i) & ~isnan(q2));
 if(~isempty(isee))
   qtotal(i)=q1(i).*57000/51500+q2(isee).*23870/14976;
 else
   qtotal(i)=0;
 end
end

fi=fopen('Gironde_20062007.txt','w')
for i=1:length(t1)
 fprintf(fi,'%d\t%d\t%d\t%.2f\n',a1(i),m1(i),d1(i),qtotal(i));
end
fclose(fi);
