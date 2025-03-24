select
  p.ci code,
  cast(p.cip as varchar(50)) cip7, 
  cast(p.nom as varchar(60)) nom,
  cast(p.cip13 as varchar(13)) cip13,
  cast(p.ean13 as varchar(13)) ean13,
  cast(p.gtin as varchar(13)) gtin,
  --labo,
  p.acte,
  p.pfht,
  p.base,
  c.ttc,
  case when (p.registre = 3) then '3' else p.liste end,
  (select cast(trim(both '{}' from (string_to_array(data, '|'))[2]) as float) from "LGO2".commondata where index = tva and uid = 2),
  p.robot,
  c.lastvente,
  p.expirday,
  p.stockm,
  p.seuilu,
  p.stockmmin,
  p.stockmmax,
  p.stocka,
  p.stockr1,
  p.stockr2,
  p.stockr3,
  p.htgn,
  p.htmp,
  (select cast(trim(both '{}' from (string_to_array(data, '|'))[1]) as varchar(3)) from "LGO2".commondata where index = acte and uid = 7),
  cast(trim(both '{}' from lppr_code[1]) as varchar(13)),
  comv.commentaire_vente,
  comg.commentaire_general,
  case when (cg[1] > 0) then cg[1] else null end as zone_geo
from "LGO2".products p
left join "LGO2".canal c on c.product = p.ci
left join (select ci,  
           string_agg(cast(body as varchar(100)),'' order by rang) commentaire_vente 
           from "LGO2"."comments"
           where type = 0 and idt = 4
           group by ci ) as comv on (comv.ci = p.ci )
left join (select ci,  
           string_agg(cast(body as varchar(100)),'' order by rang) commentaire_general
           from "LGO2"."comments"
           where type = 1 and idt = 4
           group by ci )  comg on (comg.ci = p.ci)