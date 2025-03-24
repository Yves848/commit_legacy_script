select 
	cast(prd.id as integer),
	cast(prd.cip13 as varchar(13)),
	cast(prd.name as varchar(34)),
	cast (prd.purchase_price as float),
	case
          when prd.vat_rate = '' then 0
          else 
             cast (prd.vat_rate as float)
        end,
        cast(prd.sale_price as float),
	prd.stock_min,
	prd.stock_max,
	cast(prd.weighted_average_purchase_price as float) pamp,
	TO_DATE(NULLIF(prd.expiry_date, ''), 'YYYY-MM-DD') peremption,
	prd.ean13,
  prd.act_code,
  comment
from products prd
