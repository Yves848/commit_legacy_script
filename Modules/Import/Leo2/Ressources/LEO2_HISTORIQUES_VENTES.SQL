select 
 es.Bes_Id
 , month(es.Eso_Date)
 , year(es.Eso_Date)
 , sum(es.Eso_Valeur)
from dbo.EntreeSortie es
  inner join dbo.TypeEntreeSortie tes on tes.Tes_Id = es.Tes_Id
  inner join dbo.BienEtService bes on bes.Bes_Id = es.Bes_Id
  left join dbo.BesGestionDeStock gds on gds.Bes_Id = es.Bes_Id  
where tes.Tes_Interne = 'Sortie'
  and  (bes.Bes_DateDerniereDelivrance is not null or gds.Gds_IsTenueEnStock = 1)
group by es.Bes_Id, month(es.Eso_Date), year(es.Eso_Date)