 -- comptes collectivites
 select
    ben.ci, 
    substring(ben.nom from 1 for 30),
    substring(ben.prenom from 1 for 30),
    substring(ben.rue from 1 for 40),
    substring(ben.cp from 1 for 5),
    substring(ben.ville from 1 for 30),
    substring(ben.tel from 1 for 20),
    substring(ben.fax from 1 for 20),
    substring(ben.gsm from 1 for 20),
    substring(ben.mail from 1 for 50)
from "LGO2".customers ben
where ben.ci in ( select tut.tuteur 
                  from "LGO2".customers tut 
                  where tut.tuteur > 0
                  and nir = '' )
-- where releve = 1