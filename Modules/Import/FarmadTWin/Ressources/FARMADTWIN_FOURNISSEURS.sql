select 
  l.l_type_leverancier,
  l.l_levnummer,
  l.l_leverancier,
  l.l_adres,
  l.l_postcodenummer,
  l.l_gemeente, 
  l.l_email_adres,
  l.l_klantnummer
from 
  ftbleveranciers l  
where 
  l_leverancier is not null and 
  l_type_leverancier in (2, 6)
order by 
  l_levnummer