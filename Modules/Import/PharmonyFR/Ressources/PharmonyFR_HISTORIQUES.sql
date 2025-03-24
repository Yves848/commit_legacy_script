select 
	DISTINCT
  hist.patient_id,
	TO_DATE(NULLIF(hist.date, ''), 'YYYY-MM-DD') date_ordo,
	TO_DATE(NULLIF(hist.date, ''), 'YYYY-MM-DD') date_fact,
	CASE
    when hist.prescription_number = '' then 0
    else 
       cast(hist.prescription_number as integer)
    end prescription_number,
  case 
  hist.prescriber_id when '' then '0'
    else 
       cast(hist.prescriber_id as varchar(9))
    end prescriber_id
	
from history_patients hist