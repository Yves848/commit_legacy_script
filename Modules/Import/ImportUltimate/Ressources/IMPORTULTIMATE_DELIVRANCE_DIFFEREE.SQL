select   
  d.t_delivrancediff_id, 
  d.t_produit_id, 
  d.t_aad_id, 
  d.t_praticienprive_id,
  d.no_ordonnance,
  d.dateprescription,
  a.dateacte,
  d.quantite_differee,
  d.dateordonnance  
from bel.t_delivrancediff d
inner join bel.t_acte a on d.t_acte_id = a.t_acte_id
inner join bel.t_produit p on d.t_produit_id = p.t_produit_id
where d.t_lignevente_id is null

union all

select 
  d.t_delivrancediff_id, 
  d.t_produit_id, 
  d.t_aad_id, 
  d.t_praticienprive_id,
  d.no_ordonnance,
  d.dateprescription,
  a.dateacte,
  d.quantite_differee,
  d.dateordonnance  
from bel.t_delivrancediff d, bel.t_acte a, bel.t_lignevente lv, bel.t_facture f
where (d.t_produit_id is not null or d.t_magi_magistrale_id is not null)
  and d.t_acte_id = a.t_acte_id
  and d.t_lignevente_id is not null
  and d.t_lignevente_id = lv.t_lignevente_id
  and lv.t_facture_id = f.t_facture_id
  and f.etat_facture = 'V'