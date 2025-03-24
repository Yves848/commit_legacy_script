select 
  id_Client, 
  id_Facture,
  s_subdir_path chemin,
  concat('sc',id_scan,'.',s_extension) nom_fichier,
  id_typescan type_scan
from 
  PHARMAVITALEBD.dbo.scanfiles sc
where 
  id_typescan in (2, 5, 9, 10) and     
  id_Client <> -1 and
  date_scan > dateadd(year , -2 , getdate() )