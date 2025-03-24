select
	  'FACT_' || f.t_facture_id,
	  f.t_client_id,
	  f.numero_facture,
	  f.date_prescription,
	  o.codeoperateur,
	  f.t_praticien_prive_id,
	  f.nom_praticien,
	  f.prenom_praticien,
	  f.the_type_facturation,
	  ac.dateacte
from
  bel.t_facture f
  inner join bel.t_acte ac on ac.t_acte_id = f.id_acte
  inner join bel.t_assureayantdroit a on a.t_aad_id = f.t_client_id
  inner join bel.t_operateur o on o.t_operateur_id = f.t_operateur_id
where
  f.t_client_id is not null 
  and (a.id_del is null or a.d_del is null)
  and a.collectivite = '0' and ac.termine = '1'  

union

select 
  'HIST_' || h.t_histo_client_entete_id,
  h.t_client_id,
  h.numero_facture,
  h.date_prescription,
  h.code_operateur,
  null,
  h.nom_medecin,
  h.prenom_medecin,
  h.the_type_facturation,
  h.date_acte
from
  bel.t_histo_client_entete h
  inner join bel.t_assureayantdroit a on a.t_aad_id = h.t_client_id
where
  h.t_client_id is not null 
  and (a.id_del is null or a.d_del is null)
  and a.collectivite = '0'
