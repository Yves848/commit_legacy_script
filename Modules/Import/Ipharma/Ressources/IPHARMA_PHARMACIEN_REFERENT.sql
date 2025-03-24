select
distinct(p.personne_id)
from personne p
inner join assure a
ON p.niss = a.niss
inner join vente v 
on v.assure_id = a.assure_id
inner join vente_ligne_specialite d 
ON v.vente_id = d.vente_id
where tar_id in ('351975')
