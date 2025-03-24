select cast(t_facture_id as varchar2(50)),
       date_execution,
       cast(t_client_id as varchar2(50))
from erp.t_dossierattente tda
inner join erp.t_acte ta
on tda.id_acte = ta.t_acte_id
where ta.typeacte = 1
and etat_facture = 'V'
and the_type_facturation in (1,2,3)
and termine = 1
