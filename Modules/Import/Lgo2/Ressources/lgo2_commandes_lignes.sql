select lc.uid,
       lc.product,
       lc.cqte qte_commandee ,
       lc.lqte qte_recue,
       lc.lug unites_gratuites,
       lc.paht Prix_achat_remise,
       lc.discount remise,
       case when (lc.lttc>0) then lc.lttc else c.ttc end PV_TTC
from "LGO2".orderlines lc  
left join "LGO2".canal c on c.product = lc.product
