select
  'FACT_' || fac.t_facture_id,
  fac.t_client_id,
  nvl(fac.numero_facture,0),
  fac.date_prescription,
  fac.code_operateur,
  prat.t_praticien_id, 
  fac.nom_praticien, 
  fac.prenom_praticien, 
  fac.the_type_facturation,
  act.dateacte
from
  erp.t_facture fac
  inner join erp.t_acte act on act.t_acte_id = fac.id_acte
  inner join erp.t_assureayantdroit cli on cli.t_aad_id = fac.t_client_id
  left join erp.t_praticien_structure prat on prat.t_praticien_structure_id = fac.t_praticien_structure_id 
where
  fac.t_client_id is not null and cli.id_del is null and cli.collectivite = '0' and
  act.valide = '1' and act.termine = '1'  
union
select 
  'HIST_' || t_histo_client_entete_id,
  t_client_id,
  numero_facture,
  date_prescription,
  code_operateur,
  null,
  nom_medecin,
  prenom_medecin,
  the_type_facturation,
  date_acte
from
  erp.t_histo_client_entete h
  inner join erp.t_assureayantdroit cli on cli.t_aad_id = h.t_client_id
where
  h.t_client_id is not null and cli.id_del is null and cli.collectivite = '0'
