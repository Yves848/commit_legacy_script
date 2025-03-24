select 
  p.prest_num_regime_pk,
  r.reg_num_nature,
  a.act_cde_code,
  iif(reg_num_nature = 0, p.prest_num_txrbt, case 
                                               when p.prest_num_parametre1 > 0 then p.prest_num_parametre1
                                               when p.prest_num_parametre2 > 0 then p.prest_num_parametre2
                                               when p.prest_num_parametre3 > 0 then p.prest_num_parametre3
                                               when p.prest_num_parametre4 > 0 then p.prest_num_parametre4
                                               when p.prest_num_parametre5 > 0 then p.prest_num_parametre5
                                               when p.prest_num_parametre6 > 0 then p.prest_num_parametre6
                                               when p.prest_num_parametre7 > 0 then p.prest_num_parametre7
                                               when p.prest_num_parametre8 > 0 then p.prest_num_parametre8
                                               else 0
                                             end) taux   ,
					     replace(sts.stsform_num_numero,'032','02A' )
from 
  tbl_prestation p
  inner join tbl_acte a on (p.prest_num_acte_pk = a.act_num_id)
  inner join tbl_regime r on (r.reg_num_id = p.prest_num_regime_pk)
  left join tbl_sts_formules sts on ( sts.stsform_num_id = p.prest_num_formule_fk  )
where 
  a.act_cde_code in ('PH4', 'PH7', 'PH1', 'PH2', 'PHN', 'PMR', 'AAD') and
  r.reg_bol_deleted = 0
order by 
  p.prest_num_regime_pk