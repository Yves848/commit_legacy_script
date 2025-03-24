select
  'FACT_' || l.t_lignevente_id,
  'FACT_' || f.t_facture_id,
  l.codecip,
  l.designation,
  l.qtefacturee,
  l.prixvente
from
  erp.t_lignevente l
  inner join erp.t_facture f on f.t_facture_id = l.t_facture_id
  inner join erp.t_acte act on act.t_acte_id = f.id_acte
  inner join erp.t_assureayantdroit cli on cli.t_aad_id = f.t_client_id
  inner join erp.t_produit p on p.t_produit_id = l.t_produit_id
where
  f.t_client_id is not null and l.qtefacturee > 0 and 
  cli.id_del is null and cli.collectivite = '0' and
  act.valide = '1' and act.termine = '1'  
union
select 
  'HIST_' || l.t_histo_client_ligne_id,
  'HIST_' || l.t_histo_client_entete_id,
  p.codecip7,
  l.designation,
  l.qtefacturee,
  l.prixvente
from
  erp.t_histo_client_ligne l
  inner join erp.t_histo_client_entete h on h.t_histo_client_entete_id = l.t_histo_client_entete_id
  inner join erp.t_produit p on p.t_produit_id = l.t_produit_id
  inner join erp.t_assureayantdroit a on a.t_aad_id = h.t_client_id
where
  h.t_client_id is not null and a.id_del is null and a.collectivite = '0' and
  p.id_del is null and
  l.qtefacturee > 0