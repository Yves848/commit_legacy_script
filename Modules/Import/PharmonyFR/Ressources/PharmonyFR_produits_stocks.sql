select 
	cast(stk.product_id as int),
	cast(stk.Quantity as float),
	cast('1' as varchar(1)) as priority,
        case 
            when stk.min = '' then 0
            else
              cast(stk.min as int)
        end,
	case 
            when stk.max = '' then 0
            else
              cast(stk.max as int)
        end,
	cast(stk.storage_location_id as varchar(6)),
	cast(stk.storage_space_id as varchar(6))	
from product_stocks stk