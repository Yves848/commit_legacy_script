select cast(p.t_couverture_amc_id as varchar2(50)),
       pr.code,
       pecp.valeur       
from t_pec_amc p
     inner join t_pec_amc_formule_parametre pecp on pecp.t_pec_amc_id = p.t_pec_amc_id
     inner join t_prestation pr on pr.t_prestation_id = p.t_prestation_id
     inner join t_24 t on t.t_couvertureamc_id = p.t_couverture_amc_id
     inner join t_couvertureamc c on c.t_couvertureamc_id = t.t_couvertureamc_id
where c.couvreference = '0'
and p.t_pec_amc_id in  ( select  max(t_pec_amc_id)  from t_pec_amc  group by t_couverture_amc_id,t_prestation_id) 
and code in ('PHN', 'PH1', 'PH2', 'PH4', 'PH7', 'AAD', 'PMR')
