  select
  d.del_num_id,
  d.del_num_cli_fk,
  d.del_num_medecin_fk,  
  coalesce(o.ordo_num_numfactordo, 0),
  o.ordo_dte_prescription,
  o.ordo_dte_dateacte,
  t.TIK_DTI_HORODATAGE,
  d.del_mnt_mntdu        
from 
  tbl_delivrance d
  inner join tbl_client c on (c.cli_num_id = d.del_num_cli_fk)
  left join tbl_ordonnance o on (o.ordo_num_delivrance_pk = d.del_num_id)
  left join  TBL_CC_TICKET t on t.TIK_NUM_ID = d.DEL_NUM_TICKET_FK
where 
  d.del_num_cli_fk is not null and
  d.del_dti_dateannulation is null and
  c.cli_bol_deleted = 0 and
( d.DEL_MOD_DERMODIF >  dateadd(-48 month to current_date) or 
  o.ordo_dte_dateacte > dateadd(-48 month to current_date) ) 