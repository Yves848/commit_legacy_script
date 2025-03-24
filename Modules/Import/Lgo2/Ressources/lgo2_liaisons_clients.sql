 -- liaisons clients-compte ou assure rattache
 select
    ben.ci, 
    ben.tuteur
from "LGO2".customers ben
where ben.tuteur > 0
                 