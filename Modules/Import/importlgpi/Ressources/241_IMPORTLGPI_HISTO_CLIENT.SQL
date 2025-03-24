select
  'FACT_' || fac.t_facture_id,
  fac.t_client_id,
  nvl(fac.numero_facture,0),
  fac.date_prescription,
  fac.code_operateur,
  nvl(fac.t_praticien_prive_id, fac.t_praticien_hospitalier_id),
  nvl(fac.nom_medecin_prive, fac.nom_praticien_hospitalier),
  nvl(fac.prenom_medecin_prive, fac.prenom_praticien_hospitalier),
  fac.the_type_facturation,
  act.dateacte
from
  erp.t_facture fac
  inner join erp.t_acte act on act.t_acte_id = fac.id_acte
  inner join erp.t_assureayantdroit cli on cli.t_aad_id = fac.t_client_id
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
