select 
  cast(couvamc.t_couvertureamc_id as varchar2(50)),
  cast(couvorg.t_organismeamc_id as varchar2(50)),
  decode(substr(couvamc.libelle,7,53),'',couvamc.libelle,substr(couvamc.libelle,7,53)),
  couvamc.montantfranchise,
  couvamc.plafondpriseencharge,
  couvamc.couvcmu,
  f.no_formule
from t_couvertureamc couvamc
left join t_24 couvorg on couvorg.t_couvertureamc_id = couvamc.t_couvertureamc_id
left join t_organismeamc orgamc on orgamc.t_organismeamc_id = couvorg.t_organismeamc_id
left join t_pec_amc pec on pec.t_couverture_amc_id = couvamc.t_couvertureamc_id
left join t_prestation p on p.t_prestation_id = pec.t_prestation_id
left join t_formule_sts f on f.t_formule_sts_id = pec.t_formule_id
where orgamc.d_del is null and couvamc.couvreference = '0' and p.code = 'PH4'
  and pec.t_pec_amc_id in (select max(t_pec_amc_id) 
                         from t_pec_amc  
                         group by t_couverture_amc_id,t_prestation_id)