select 
      cast(trim(both '{}' from (string_to_array(data, '|'))[1]) as varchar(5)) id,
      cast((string_to_array(data, '|'))[2] as varchar(50)) libelle,
      cast(trim(both '{}' from (string_to_array(data, '|'))[4]) as varchar(500)) a,
      cast(trim(both '{}' from (string_to_array(data, '|'))[5]) as varchar(500)) b
from "LGO2".commondata
where uid = 10