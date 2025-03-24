select
  av.av_num_id,
  av.av_num_client_fk,
  av.av_mod_dermodif,
  lp.lgprod_num_pro_fk,
  lp.lgprod_car_nom,
  maxvalue(coalesce(lp.lgprod_mnt_prixunitaire,0) , coalesce(av.av_mnt_prixunitaire,0) ) pvttc,
  maxvalue(coalesce(lp.lgprod_mnt_prixachat,0)  ,coalesce(pr.pro_mnt_prixachatmoyen,0)  ,coalesce(pr.pro_mnt_uppprixachatht,0)  ) paht,                                    
  maxvalue(coalesce(lp.lgprod_mnt_baserbt,0), coalesce(av.av_mnt_baserbt,0)) baserbt,
  ac.act_cde_code,
  av.av_num_qterestante
from
  tbl_avance_vignette av
  inner join tbl_client c on (c.cli_num_id = av.av_num_client_fk)
  inner join tbl_ligne_produit lp on (lp.lgprod_num_av_fk = av.av_num_id)
  inner join tbl_produit pr on (pr.pro_num_id = lp.lgprod_num_pro_fk)
  inner join tbl_acte ac on (ac.act_num_id = lp.lgprod_num_act_fk)
where
 av.av_num_qterestante > 0 and
 av.av_bol_annule = 0 and
 c.cli_bol_deleted = 0
 order by lp.lgprod_num_id