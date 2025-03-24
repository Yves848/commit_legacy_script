select
  lp.lgprod_num_id,
  lp.lgprod_car_nom,
  lp.lgprod_num_pro_fk,
  a.act_cde_code,
  lp.lgprod_num_deliv_fk,
  lp.lgprod_num_qte,
  lp.lgprod_mnt_prixunitaire,
  lp.lgprod_mnt_prixachat,
  lp.lgprod_car_codeproduit
from
  tbl_ligne_produit lp
  inner join tbl_produit p on (p.pro_num_id = lp.lgprod_num_pro_fk)
  inner join tbl_acte a on (a.act_num_id = lp.lgprod_num_act_fk)
  inner join tbl_delivrance d on (d.del_num_id = lp.lgprod_num_deliv_fk)
  inner join tbl_client c on (c.cli_num_id = d.del_num_cli_fk)
  left join tbl_ordonnance o on (o.ordo_num_delivrance_pk = d.del_num_id)  
where
  d.del_num_cli_fk is not null and
  d.del_dti_dateannulation is null and
  c.cli_bol_deleted = 0 and
  p.pro_bol_deleted = 0 and
 ( d.DEL_MOD_DERMODIF >  dateadd(-48 month to current_date) or 
  o.ordo_dte_dateacte > dateadd(-48 month to current_date) )  
  