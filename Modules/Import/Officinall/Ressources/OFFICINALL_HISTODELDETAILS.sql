select     
  lv.vdd_primkey as verkoopdetailpk,
  lv.vdd_vrk_primkey as verkooppk, 
  '' as cnk,  
  upper(lv.vdd_omschrijving) as omschrijving, 
  lv.vdd_aantal as aantal, 
  lv.vdd_tebetalen + lv.vdd_facturatietebetalen as tebetalen, 
  0 as productpk
from verkoopdetaildivers lv --ligne vente
  inner join btw on btw.btw_primkey = lv.vdd_btwcode 
  inner join verkoop vte on vte.vrk_primkey = lv.vdd_vrk_primkey 
  inner join patient pat on vte.vrk_pat_primkey = pat.pat_primkey 
  inner join klant cli on vte.vrk_klt_primkey = cli.klt_primkey 
  inner join arts med on vte.vrk_art_primkey = med.art_primkey 
  inner join artsriziv arz on vte.vrk_arz_primkey = arz.arz_primkey 
  inner join artsspecialisatie sm on arz.arz_asp_primkey = sm.asp_primkey
where vte.vrk_DatumAflevering > getdate()-365*2

union

select    
  2 * lvm.vdm_primkey,
  lvm.vdm_vrk_primkey, 
  '', 
  lvm.vdm_naam, 
  lvm.vdm_aantal, 
  lvm.vdm_tebetalen + lvm.vdm_facturatietebetalen,
  0 
from verkoopdetailmagis lvm -- ligne vente magistral
  inner join verkoop vte on vte.vrk_primkey = lvm.vdm_vrk_primkey 
  inner join patient pat on vte.vrk_pat_primkey = pat.pat_primkey 
  inner join klant cli on vte.vrk_klt_primkey = cli.klt_primkey 
  inner join arts med on vte.vrk_art_primkey = med.art_primkey 
  inner join artsriziv arz on vte.vrk_arz_primkey = arz.arz_primkey 
  inner join artsspecialisatie sm on arz.arz_asp_primkey = sm.asp_primkey
where vte.vrk_datumaflevering > getdate()-365*2 

union

select     
  3 * lvp.vdp_primkey,
  lvp.vdp_vrk_primkey, 
  lvp.vdp_prd_cnk, 
  lvp.vdp_prd_naam, 
  lvp.vdp_aantal, 
  lvp.vdp_tebetalen + lvp.vdp_facturatietebetalen, 
  lvp.vdp_prd_primkey
from 
  verkoopdetailproduct lvp -- ligne vente produit
  inner join btw btw on btw.btw_primkey = lvp.vdp_prd_btwcode 
  inner join verkoop vte on vte.vrk_primkey = lvp.vdp_vrk_primkey 
  inner join patient pat on vte.vrk_pat_primkey = pat.pat_primkey 
  inner join klant cli on vte.vrk_klt_primkey = cli.klt_primkey 
  inner join arts med on vte.vrk_art_primkey = med.art_primkey 
  inner join artsriziv arz on vte.vrk_arz_primkey = arz.arz_primkey 
  inner join artsspecialisatie sm on arz.arz_asp_primkey = sm.asp_primkey
where vte.vrk_datumaflevering > getdate()-365*2 