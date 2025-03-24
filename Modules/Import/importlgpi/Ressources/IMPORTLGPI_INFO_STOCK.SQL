select cast(pg.t_produit_id as varchar2(50)),
       cast(pg.t_zonegeo_id as varchar2(50)),
       pg.quantite,
       decode(pg.priorite, 2, 0, 1), 
       pg.stockmini,
       pg.stockmaxi,
       pg.t_depot_id
from erp.t_produitgeographique pg
     inner join erp.t_produit p on p.t_produit_id = pg.t_produit_id
where p.materiel_location = '0'    