select 
  oms.pt_cnknummer,
  oms.pt_omschrijvingfr,
  oms.pt_omschrijving$$,
  prd.p_verkoopprijs,
  bk.bk_bestelpunt,
  bk.bk_bestelparameter,
  btw.btw_percentage,
  prd.p_vervaldatum,
  prd.p_labo,
  prd.p_tekst,
  stk.ps_apotheek_stock stk_pharma, -- stock pharmacie  
  vr.vr_plaatsnummer,
  stk.ps_buffer_stock stk_reserve, --stock reserve
  prd.p_robot_stock stk_robot,
  stk.ps_dubbelestock,  
  prd.p_eigenproduct
from 
  ftbproductstock stk
  inner join ftbproducten prd on prd.p_cnknummer = stk.ps_cnknummer
  inner join ftbbtw btw on btw.btw_code = prd.p_btw_verkoop
  inner join ftbpomschrijving oms on oms.pt_cnknummer = stk.ps_cnknummer and pt_volgnummer = (select min(oo.pt_volgnummer) from ftbpomschrijving oo where oo.pt_cnknummer=oms.pt_cnknummer)
  left join ftbbestelklassen bk on bk.bk_bestelpolitiek = stk.ps_bestelpolitiek and bk.bk_bestelklasse = stk.ps_bestelklasse
  left join ftbvplaatsen vr on vr.vr_plaatsnummer = prd.p_voorraadplaats   
where 
  ((stk.ps_apotheek_stock > 0) or 
   (stk.ps_instock > 0) or 
   (stk.ps_min_apotheek > 0) or 
   (stk.ps_max_apotheek > 0) or 
   (stk.ps_buffer_stock > 0) or 
   (stk.ps_apotheek_stock > 0) or 
   ((stk.ps_laatstverkocht is not null) and (stk.ps_laatstbesteld is not null))) 
   or oms.PT_CNKNUMMER like '09%'
 order by 
   oms.pt_cnknummer