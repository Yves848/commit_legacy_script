select
  ci, 
  cast(idcp as varchar(20)),
  cast(nom as varchar(100)),
  cast(rue as varchar(200)),
  cast(cp as varchar(5)),
  cast(ville as varchar(150)),
  cast(contact as varchar(100)),
  cast(tel as varchar(20)),
  cast(fax as varchar(20)),
  cast(gsm as varchar(20)),
  cast(mail as varchar(200)),
  oct  
from "LGO2".amc