select 
  ent.nocomgros - (ent.nocomgros>>28)* 268435456,
  cast(from_unixtime(lig.Create_Time) as date), 
  ent.DT_livraison,
  ent.montantHT,
  ent.memo,
  ent.code_fourn,
  cast(ent.etape as char(1))

from 
  COMGROit lig
  inner join COMGROS ent on lig.nocomgros =ent.nocomgros  
 
where 
  etape in (1, 2, 3) 
and ent.code_fourn > ''
and datediff(current_date,cast(from_unixtime(lig.Create_Time) as date))<1095
 
group by 
  ent.nocomgros