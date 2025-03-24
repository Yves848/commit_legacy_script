 -- assures et beneficiaires
 select
    ben.ci, 
    substring(ben.nom from 1 for 30),
    substring(ben.prenom from 1 for 30),
    ben.birthday,
    ben.rang,
    ben.sexe, 
    ben.quality,
    case when ben.nir >''
        then substring(ben.nir from 1 for 15)
        else substring(ass.nir from 1 for 15)
    end, 
    substring(ben.njf from 1 for 30),
    substring(ben.rue from 1 for 40),
    substring(ben.cp from 1 for 5),
    substring(ben.ville from 1 for 30),
    substring(ben.tel from 1 for 20),
    substring(ben.fax from 1 for 20),
    substring(ben.gsm from 1 for 20),
    substring(ben.mail from 1 for 50),
    ben.amo,
    ben.centre,
    ben.tuteur,
    ben.lastmove
from "LGO2".customers ben
left join "LGO2".customers ass on ass.ci = ben.assure
where ben.ci not in ( select tut.tuteur 
                  from "LGO2".customers tut 
                  where tut.tuteur > 0
                  and nir = '' )