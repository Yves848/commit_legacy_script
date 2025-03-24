SELECT 
 IK_REKENINGID, 
 sum(COALESCE(IK_GESPAARD, 0) - (CASE WHEN (((IK_CNKNUMMER = '0000010') OR (IK_CNKNUMMER = '0000011') OR (IK_CNKNUMMER = '0000012')) AND (IK_VIID <> 0)) THEN 0 ELSE COALESCE(IK_BESCHIKBAAR, 0) END)),
 sum(COALESCE(IK_BESCHIKBAAR, 0)),
 3
FROM FTBIND_KORTING
group by  IK_REKENINGID
  
/* Ancien qui ne fonctionne pas bien !!!

select 
  max(k.ik_id),
  k.ik_rekeningid,
  k.ik_kaartid,
  sum(k.ik_gespaard), 
  sum(vi.vi_publieksprijs),
  btw.btw_percentage,
  0 as typet 
from 
  ftbind_korting k
  left join ftbbtw btw on btw.btw_code = k.ik_btwcode 
  left join ftbverkoopitems vi on vi.vi_id = k.ik_viid 
group by 
  k.ik_rekeningid,
  k.ik_kaartid,
  btw.btw_percentage 
union 
select 
  max(k.ik_id),
  k.ik_rekeningid,
  k.ik_kaartid, 
  sum(k.ik_beschikbaar) * -1,
  sum(vi.vi_publieksprijs),
  btw.btw_percentage,
  1 as typet 
from 
  ftbind_korting k
  left join ftbbtw btw on btw.btw_code = k.ik_btwcode 
  left join ftbverkoopitems vi on vi.vi_id = k.ik_viid 
where  
  k.ik_aantal_prod = -1 
group by 
  k.ik_rekeningid,
  k.ik_kaartid,
  btw.btw_percentage 
  */
  
  