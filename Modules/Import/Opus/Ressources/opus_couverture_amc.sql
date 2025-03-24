select
trim(couv.mu_code),
trim(substring(org.mu_num,3,8)) idnat,
trim(couv.ac_code),
couv.dr_taux
from DROITAMC couv 
inner join MUTUELLE org on org.mu_code = couv.mu_code