select 
	CASE
    when hist.prescription_number = '' then 0
    else 
       cast(hist.prescription_number as integer)
    end prescription_number,
	cast(prd.name as varchar(50)),
	cast(prd.cip13 as varchar(13)),
	cast(hist.quantity as integer),
	round(cast(hist.public_price as numeric ) ,2)
	
	
from history_patients hist
left join products prd on hist.product_id = prd.id