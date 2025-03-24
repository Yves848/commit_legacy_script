SELECT 
as_code,
trim(cast(di_dtmaj as varchar(10))),
di_mtsol
FROM credit 
WHERE di_mtsol <> 0