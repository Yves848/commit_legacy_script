select
com.no_commande,
com.etat,
com.date_heure,
com.date_livraison,
com.code_fournisseur,
com.montant_ht,
com.type_fournis

from cmdbord com

where com.typecmde <> 1

and ( etat ='0'  ) or etat ='L'