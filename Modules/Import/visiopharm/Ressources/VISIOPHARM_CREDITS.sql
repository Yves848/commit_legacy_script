select no_client, date_vente, credit  
from VENTES
where CREDIT > 0
and etat = '0'