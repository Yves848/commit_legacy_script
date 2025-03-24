select 
 e.uid, -- no commande
 e.state, --3 archivée - 2 reception financiere 
 e.provider, -- fournisseur
 e.day, -- date commande
 e.wday, -- date reception prevue
 e.deliverylast, -- derniere recption
 sum(l.cqte*l.paht)
 from "LGO2".orders e
 left join "LGO2".orderlines l on e.uid = l.uid
 group by   e.uid , e.state, e.provider, e.day , e.wday , e.deliverylast