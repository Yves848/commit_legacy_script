select cast(l.t_facture_id as varchar2(50)),
       cast(t_produit_id as varchar2(50)),
       qtedelivree + qtemanquante,
       codeprestation,
       paht_remise,
       prixvente
from erp.t_lignevente