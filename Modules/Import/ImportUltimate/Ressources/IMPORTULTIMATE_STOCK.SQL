select 
	cast(pg.t_prodgeo_id as varchar2(50)),
	cast(pg.t_produit_id as varchar2(50)),
    cast(pg.t_zonegeo_id as varchar2(50)),
	pg.quantite,
	pg.stockmini,
	pg.stockmaxi,
	pg.priorite,
	pg.depotvente,
	pg.t_depot_id
from bel.t_produitgeographique pg
inner join bel.t_produit p on p.t_produit_id = pg.t_produit_id
where p.materiel_location = '0' and p.d_del is null 