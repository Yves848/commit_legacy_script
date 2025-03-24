select
  tar_id,
  barcode, 
  barcode_type 
from 
  tar_barcode
where barcode_type <>'PHA' 