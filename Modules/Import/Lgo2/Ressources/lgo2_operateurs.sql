select 
ascii(cast(trim(both '{}' from (string_to_array(data, '|'))[1]) as char)),
cast(trim(both '{}' from (string_to_array(data, '|'))[1]) as varchar(10)),
cast(trim(both '{}' from (string_to_array(data, '|'))[2]) as varchar(50))
from "LGO2".commondata
where uid = 102