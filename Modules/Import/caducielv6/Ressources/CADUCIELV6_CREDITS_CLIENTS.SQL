select 
  cre.cred_num_id,
  ope.oper_dti_date,
  cre.cred_num_crediteur_fk,
  pv.payvente_mnt_mnt
from
  tbl_credit cre
  inner join tbl_client cli on (cli.cli_num_id = cre.cred_num_crediteur_fk)
  inner join tbl_vente ven on (ven.ven_num_oper_pk = cre.cred_num_vente_pk)
  inner join tbl_operation ope on (ope.oper_num_id = ven.ven_num_oper_pk)
  inner join tbl_operateur OT on OT.OPE_NUM_ID = OPE.OPER_NUM_OPERATEUR_FK
  inner join tbl_payer_vente pv on (pv.payvente_num_credit_fk = cre.cred_num_id)
where
  pv.payvente_num_typpaie_pk in (4, 8) and
  cli_bol_estcompte = 0 and
  cre.cred_bol_traite = 0 and
  cre.cred_bol_annuler = 0 and
  (cli.cli_num_compte_fk is null or cre.cred_bol_personnel = -1) and
  cli.cli_bol_deleted = 0