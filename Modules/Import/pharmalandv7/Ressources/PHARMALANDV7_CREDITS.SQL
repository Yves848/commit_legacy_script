select
ffnum,
ffclient,
max(ffdtfac),
sum(fftot[4]-fftot[5]) restant_du
from ffacture
where ffetat = 1 
and ffclient > '' 
and ffdtfac >=add_months(sysdate,-60)

group by ffetat,ffnum,ffclient  
having abs(sum(fftot[4]-fftot[5])) > 0.01