select cast(date as varchar(7)),
       cast(product_id as varchar(50)),
       sum(cast(quantity as integer))
from history_products    
group by  cast(date as varchar(7)),
         product_id   