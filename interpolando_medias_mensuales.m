
caudal=[
8.484202404
32.01855913
32.02810266
25.34762833
10.16386452
15.13604613
10.09705978
7.806611436
7.892503249
8.608268356
8.970922677
]';



time=[julian(2009,10,15)
    julian(2009,11,15)
    julian(2009,12,15)
    julian(2010,1,15)
    julian(2010,2,15)
    julian(2010,3,15)
    julian(2010,4,15)
    julian(2010,5,15)
    julian(2010,6,15)
    julian(2010,7,15)
    julian(2010,8,15)]';

time2=[julian(2009,10,15):1:julian(2010,8,15)];

caudal2=interp1(time,caudal,time2);

fi=fopen('eume_parche.txt','w');
for count=1:length(time2)
  gd=gregorian(time2(count));
  fprintf(fi,'%d\t%d\t%d\t',gd(3),gd(2),gd(1));
  fprintf(fi,'%.2f\n',caudal2(count));
end
fclose(fi);




