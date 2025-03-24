select cast(t_facture_id as varchar2(50)),
       cast(t_produit_id as varchar2(50)),
       qtedelivree + qtemanquante,
       t_prestation_id,
       paht_remise,
       prixvente
from erp.t_lignevente
where t_facture_id in ( select t_facture_id from erp.t_dossierattente  )
