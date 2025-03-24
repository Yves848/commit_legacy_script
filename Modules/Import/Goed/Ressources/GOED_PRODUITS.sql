select artnr, -- id
       case when natnr <> '0000000' then natnr -- equiv cip
       else null 
       end natnr,
       naam,
       case 
       when stock similar to '\d{1,}' then cast(stock as integer)
       else 0
       end commande,
       lokalisatie zone_geo,
       case
       when publprijs like '%.%' then cast(publprijs as float)    -- Prix vente
       else 0.00
       end prix_public,
       case
       when apothprijs like '%.%' then cast(apothprijs as float)    -- Prix vente
       else 0.00
       end prix_achat,     
       vervangproduct remplace_par,
       case 
       when minstock similar to '\d{1,}' then cast(minstock as integer)
       else 0
       end minstock,
       case 
       when tebestellen similar to '\d{1,}' then cast(tebestellen as integer)
       else 0
       end commande,
       case 
        when length(vervaldatum)= 10 then to_date(vervaldatum, 'DD/MM/YYYY')  
        when length(vervaldatum)= 8 then to_date(vervaldatum, 'DD/MM/YY') 
        else null
       end date_peremption,
       statuscode,
       levnr numero_livraison,
       btw, --?
       soortproduct type_produit,
       generisch generique,
       aci, 
       ci, 
       case 
       when verpakkingsgrootte similar to '\d{1,}' then cast(verpakkingsgrootte as integer)
       else 0
       end int_verpakkingsgrootte,
       case 
       when verpakkingsfreq similar to '\d{1,}' then cast(verpakkingsfreq as integer)
       else 0
       end int_verpakkingsfreq, 
       standdosering , --poso ?
       atc_code
from import.artikel
limit 1000