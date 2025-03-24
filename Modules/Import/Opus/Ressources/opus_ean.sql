select
ar_cip,
ae_code13
from ART_CODE13
where  length(ae_code13) =13
and ae_code13 not in ( select  AR_CIP13 from ARTICLE )
and ae_code13 not in ( select  AR_EAN13 from ARTICLE )
and ar_cip in ( select  AR_CIP from ARTICLE )


