select cast(t_assureayantdroit_id as varchar2(50)),
       dateavance,
       codecip,
       designation,
       prixvente,
       paht_brut,
       codeprestation,
       cast(t_produit_id as varchar2(50)),
       cast(t_operateur_id as varchar2(50)),
       qteavancee,
       baseremboursement
from erp.t_vignetteavancee