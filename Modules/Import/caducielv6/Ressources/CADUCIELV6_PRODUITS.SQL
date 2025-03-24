select 
  p.pro_num_id, 
  p.pro_car_nom, 
  a.act_cde_code,
  p.pro_mnt_prixvente,
  p.pro_mnt_prixrbt,
  p.pro_mnt_prixachatmoyen,
  p.pro_num_stocktotal,
  p.pro_num_stockmini,
  p.pro_num_stockmaxi,
  t.tab_car_code,  
  tva.tva_num_taux,
  p.pro_num_famille_fk,
  p.pro_num_lineaire_fk, 
  p.pro_num_categorie_fk,
  dp.dispo_cde_code,
  lt.labotx_num_code,
  p.pro_num_delaiviande,
  p.pro_num_delailait,
  p.pro_dti_datedernierevente,
  s.serv_cde_code,
  p.pro_car_remarque,
  p.pro_mem_memo,
  p.pro_dte_datecreation,
  p.pro_dte_peremption,
  fab.fab_car_nom,
  fp.fourprod_num_fournisseur_pk,
  stk_phie.stopro_num_qtemini,
  stk_phie.stopro_num_qtemaxi,
  stk_phie.stopro_num_qtecourante,
  stk_reserve.stopro_num_qtemini,
  stk_reserve.stopro_num_qtemaxi,
  stk_reserve.stopro_num_qtecourante,
  p.pro_bol_automate,
  p.pro_bol_stockauto,
  p.pro_num_seuil

from 
  tbl_produit p
  inner join tbl_acte a on (a.act_num_id = p.pro_num_acte_fk)
  inner join tbl_tableau t on (t.tab_num_num = p.pro_num_tableau_fk)
  inner join tbl_tva tva on (tva.tva_num_id = p.pro_num_tva_fk)
  inner join tbl_labotaux lt on (lt.labotx_num_id = p.pro_num_labotx_fk)
  inner join tbl_service s on (s.serv_num_id = p.pro_num_service_fk)
  inner join tbl_dispo_produit dp on (dp.dispo_num_id = p.pro_num_dispo_fk)  
  left join tbl_fabricant fab on (fab.fab_num_id = p.pro_num_fabricant_fk)
  left join tbl_fournir_produit fp on (fp.fourprod_num_produit_pk = p.pro_num_id and fp.fourprod_bol_defaut=-1)
  left join tbl_stock_produit stk_phie on (stk_phie.stopro_num_produit_fk = p.pro_num_id ) and ( stk_phie.stopro_num_stock_fk = 1 )
  left join tbl_stock_produit stk_reserve on (stk_reserve.stopro_num_produit_fk = p.pro_num_id ) and ( stk_reserve.stopro_num_stock_fk = 2 )
  
where p.pro_bol_deleted = 0 
and (pro_dti_datedernierevente > dateadd(-48 month to current_date)   or pro_num_stocktotal>0 )