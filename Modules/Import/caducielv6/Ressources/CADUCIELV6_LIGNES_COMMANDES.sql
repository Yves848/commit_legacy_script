select
  lgcom_num_id,
  lgcom_num_commande_fk,
  lgcom_num_produit_fk,
  lgcom_num_qtecom,
  iif(com_num_etatcom_fk=3, LGBL_NUM_QTELIVREE,lgcom_num_qtecom),
  --si commande non receptionné on prend la qté delivree sinon on prend la qté commandé
  lgcom_num_prixachat,
  lgcom_num_prixachat_pml,
  lgcom_mnt_prixcatalogueht,
  lgcom_num_prixcataloguepml,
  coalesce(lgcom_mnt_prixventettc, pro_mnt_prixvente),
  lgcom_num_remise1,
  lgcom_num_remise2,
  lgcom_num_qtegratuite
from
  tbl_ligne_commande l
  inner join tbl_commande c on (c.com_num_id = l.lgcom_num_commande_fk)
  inner join tbl_fournisseur f on (f.four_num_id = c.com_num_fournisseur_fk)
  inner join tbl_produit p on (p.pro_num_id = l.lgcom_num_produit_fk)
  left join tbl_bon_livraison bl on (bl.bl_num_commande_fk = c.com_num_id) 
  left join tbl_ligne_bon_livraison lbl on (lbl.lgbl_num_bl_fk = bl.bl_num_id)
where
  c.com_num_etatcom_fk in (3, 4, 6)
  and p.pro_bol_deleted = 0 
  and f.four_bol_deleted = 0
  and c.com_dte_datecreation > dateadd(-24 month to current_date)