select distinct
       ass.index_mutuelle , 
       ass.index_grille_mutuelle, 
       gm.intitule,
       cast(gm.detail_remb2020 as varchar(1000) )
 from assure ass 
  inner join dbo.grillemutuelle gm on (gm.index_grillemutuelle = ass.index_grille_mutuelle)
  where ass.index_mutuelle <> 0