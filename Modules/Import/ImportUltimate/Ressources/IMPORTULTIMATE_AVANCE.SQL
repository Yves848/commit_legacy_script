select f.t_client_id, 
       l.t_produit_id, 
       l.designation_fr, 
       lc.code, 
       f.montant_assure, 
       l.qtedelivree, 
       l.qtemanquante, 
       a.dateacte  
from bel.t_facture f
inner join bel.t_lignevente l on l.t_facture_id = f.t_facture_id  
inner join bel.t_acte a on a.t_acte_id = f.id_acte
left join bel.t_lignevente_cbu lc on lc.t_lignevente_id = l.t_lignevente_id
where a.termine  = '1'  
and f.the_type_facturation = '4'  
and f.etat_facture = 'V' 
and l.id_lv_magistrale is null 
and l.t_produit_id is not null 
and f.masquer_avprod = '0'