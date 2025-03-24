select 
bal.Bes_Id
, lpp.Lpp_Code
, lpp.Cpt_Id
, bal.Bal_Coeff
, lpp.Lpp_PxPubReglementaire
, lpp.Tsr_Id_Ext
from dbo.Bes_Asso_Lpp bal 
  inner join dbo.RefLpp lpp on lpp.Lpp_Id = bal.Lpp_Id
  inner join dbo.BienEtService bes on bes.Bes_Id = bal.Bes_Id
  left join dbo.BesGestionDeStock gds on gds.Bes_Id = bes.Bes_Id
where
 (bes.Bes_DateDerniereDelivrance is not null or gds.Gds_IsTenueEnStock = 1)