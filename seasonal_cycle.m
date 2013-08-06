%
% This script creates a seasonal cycle from monthly statistics
%
% The file structure is:
% 	year	month	day	discharge
%
% Pablo Otero, May-2010
clear all

%--------USER CONFIGURATION---------%
filename='Mondego_20130715.txt';
basin_ratio=1;
ponderate_by_sd=0;
order='seasonal'; % 1=linear, 2= cuadratic, 3=cubic, 4=4th order, 'seasonal'=harmonic

%-----END OF USER CONFIGURATION-----%


% Falta hacer la curva climatológica
kk=dlmread(filename);
d=kk(:,3); m=kk(:,2); a=kk(:,1); t2=julian(a,m,d);
q1=kk(:,4); q1(q1==0)=nan;
for i=1:12
 isee=find(m==i & ~isnan(q1));
 q1mean(i)=nanmean(q1(isee));
 q1sd(i)=std(q1(isee));
end

y_mean=q1mean'.*basin_ratio;
if(ponderate_by_sd)
  y_desv=q1sd';
else
  y_desv=[1 1 1 1 1 1 1 1 1 1 1 1]';
end

%Class mark for each month
x=[0.5:11.5]';

%Select the order of the poylonomial (1 to 4) or type 'seasonal'
if order==1
 A=[ones(size(x)) x];
 Awt=A./(y_desv*ones(1,2));
elseif order==2
 A=[ones(size(x)) x x.^2];
 Awt=A./(y_desv*ones(1,3));
elseif order==3
 A=[ones(size(x)) x x.^2 x.^3];
 Awt=A./(y_desv*ones(1,4));
elseif order==4
 A=[ones(size(x)) x x.^2 x.^3 x.^4];
 Awt=A./(y_desv*ones(1,5));
elseif order=='seasonal'
 A=[ones(size(x)) sin(2*pi*x./12) cos(2*pi*x./12)];
 Awt=A./(y_desv*ones(1,3));
 order=3;
end

df=length(y_mean)-1-order;

Qwt=y_mean./y_desv;

%Compute coefficients of the equation and their associated errors
x_1a=inv(Awt'*Awt)*Awt'*Qwt
xe_1a=sqrt(diag(inv(Awt'*Awt)))

%Predicted values;
y_1a=(Awt*x_1a).*y_desv;

%Goodness-of-fit
chi2_1a=sum((Awt*x_1a-Qwt).^2)

%Plot results
errorbar(x,y_mean,y_desv); hold on
plot(x,y_1a,'g')

