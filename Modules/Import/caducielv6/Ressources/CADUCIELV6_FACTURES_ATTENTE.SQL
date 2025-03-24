select 
fa.att_num_id,
fa.att_dte_date,
coalesce(fa.att_num_numclient_fk,fad.ATTDEL_NUM_CLIENT_FK)
from tbl_attente fa
left join TBL_ATTENTE_DETAIL fad on fad.ATTDEL_NUM_ATTENTE_PK =  fa.att_num_id