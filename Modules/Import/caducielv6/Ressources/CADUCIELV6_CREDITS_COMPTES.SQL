select
  cre.cred_num_id,
  ope.oper_dti_date,
  iif(cred_num_factcompte_fk is null, cred_num_crediteur_fk, coalesce(cli.cli_num_compte_fk, cre.cred_num_crediteur_fk)),
  pv.payvente_mnt_mnt
from
  tbl_credit cre
  inner join tbl_client cli on (cli.cli_num_id = cre.cred_num_crediteur_fk)
  left join tbl_client cpt on (cpt.cli_num_id = cli.cli_num_compte_fk)
  inner join tbl_vente ven on (ven.ven_num_oper_pk = cre.cred_num_vente_pk)
  inner join tbl_operation ope on (ope.oper_num_id = ven.ven_num_oper_pk)
  inner join tbl_operateur ot on ot.ope_num_id = ope.oper_num_operateur_fk
  inner join tbl_payer_vente pv on (pv.payvente_num_credit_fk = cre.cred_num_id)  
where
  pv.payvente_num_typpaie_pk in (4, 8) and
  cre.cred_bol_traite = 0 and
  cre.cred_bol_annuler = 0 and
  cre.cred_bol_personnel = 0 and
  (((cli.cli_bol_estcompte = -1) and (cli.cli_bol_deleted = 0)) or 
   ((cli.cli_bol_estcompte = 0) and (cli.cli_num_compte_fk is not null) and (cpt.cli_bol_deleted = 0)))
  
