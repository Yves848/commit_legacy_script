select 
  s.ads_num_assure_fk, 
  s.ads_car_nomfichier, 
  td.TDS_CAR_LIBELLE || ' du '|| substring(s.ads_dti_scan from 1 for 19)   ADS_CAR_COMMENTAIRE
  
from 
  tbl_assure_doc_scan s
  inner join tbl_type_document_scanne td on td.tds_num_id = s.ads_num_typedocscan_fk
where 
  td.tds_car_code in  ('AC','OD','CE','EC','OE','OB','GR') and 
  extract(year from s.ads_dti_scan) >= extract(year from current_date) -1
