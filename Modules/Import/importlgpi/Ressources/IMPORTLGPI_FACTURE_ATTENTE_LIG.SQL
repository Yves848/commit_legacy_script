select cast(t_facture_id as varchar2(50)),
       cast(t_produit_id as varchar2(50)),
       qtedelivree + qtemanquante,
       t_prestation_id,
       paht_remise,
       prixvente
from erp.t_lignevente
where t_facture_id in (select t_facture_id from erp.t_dossierattente tda
inner join erp.t_acte ta
on tda.id_acte = ta.t_acte_id
where ta.typeacte = 1
and etat_facture = 'V'
and the_type_facturation in (1,2,3)
and termine = 1)
