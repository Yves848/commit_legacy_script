select
lig.no_commande,
coalesce(lig.prix_achat_net,0),
coalesce(lig.qte_cmde,0),
coalesce(lig.qte_livre,0),
coalesce(lig.unite_gratuite,0),
coalesce(lig.remise,0),
coalesce(lig.prix_achat_ht,0),
lig.codeuv ,
coalesce(lig.prix_vente_ttc,0)
from cmddet lig
where lig.qte_cmde >0 and lig.prix_achat_net > 0