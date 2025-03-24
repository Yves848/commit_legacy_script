select
c.ti,
c.last_visit,
count(c.nom_prenom) as nb_vente,
sum(x.montant) as CA
from clients0 c, clivenex x
where c.ti=x.cli_ti 
and x.type=2 /*attention il faut peux etre le changer*/
group by c.nom_prenom