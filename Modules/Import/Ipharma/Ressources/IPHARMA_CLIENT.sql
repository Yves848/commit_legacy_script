select distinct 
  p.personne_id, 
  p.nom, 
  p.prenom, 
  a.adresse, 
  p.famille_id,
  p.langue, 
  p.date_naissance, 
  p.institution_id, 
  p.niss, 
  p.escompte_profil_id, 
  p.carte_ristourne, 
  p.print_mo_704,
  p.print_mo_cbl, 
  p.print_mo_bvac,
  p.visible, 
  --cast(n.blobcontent as varchar(5000)), 
  e.email, 
  l.cp,
  l.pays,
  l.nom localite,
  t.telephone,
  g.gsm,
  fx.telefax
from 
  personne p
  --left join note n on n.parent_id = p.personne_id and n.table_parent = 'PERSONNE' and char_length(cast(n.blobcontent as varchar(5000)))>2 -- 2 parce que vide = 2 
  left join email e on e.owner_id = p.personne_id and e.owner_type = 'PERSONNE'
  left join adresse a on a.adresse_id = p.adresse_id
  left join localite l on l.localite_id = a.localite_id
  left join telephone t on t.owner_id = p.adresse_id and t.owner_type ='ADRESSE'
  left join gsm g on g.owner_id = p.adresse_id and g.owner_type ='ADRESSE'
  left join telefax fx on fx.owner_id = p.adresse_id and fx.owner_type ='ADRESSE'  
where 
  p.niss not like 'N%'   and personne_id >100