select
trim(couv.og_code),
trim(couv.ac_code),
couv.tm_taux
from DROITAMO couv
inner join ORGANISM org on org.og_code = couv.og_code
