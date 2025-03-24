;with XMLNAMESPACES(DEFAULT 'schemas.microsoft.com/winfx/2006/xaml/presentation'),
  prix as (select Bes_Id, Tpx_Id, Hpx_Valeur, Tpx_Interne
           from
            (select hpx.Bes_Id, hpx.Tpx_Id, hpx.Hpx_Valeur, tpx.Tpx_Interne, ROW_NUMBER() over(partition by hpx.Bes_Id, tpx.Tpx_Interne order by hpx.VerData desc) as rn
             from dbo.HistoriquePrix hpx
               inner join dbo.TypePrix tpx on tpx.Tpx_Id = hpx.Tpx_Id) px
             where rn = 1),
  prix_ac as (select * from prix where Tpx_Interne = 'PrixCatalogue'),
  prix_r as (select * from prix where Tpx_Interne = 'PrixRemise'),
  prix_mp as (select * from prix where Tpx_Interne = 'Pmp')
select 
  bess.Bes_Id,
  bes.Bes_CodeCipAcl13,
  bes.Bes_CodeCipAcl7,
  bes.Bes_CodeEANDefaut,
  bess.Bes_LibelleLibre,
  cast(gds.Gds_IsTenueEnStock as integer) enstock,
  gds.cpm_id comportement,
  gds.dcl_id declenchement,
  gds.rcd_id reglecommande, 
  gds.gds_valeurdeclenchement,
  gds.gds_quantitemaxicommande,   
  convert(datetime, bes.Bes_DateDerniereDelivrance, 120),
  bes.Bes_BaseDeRemboursement,
  bes.Bes_PrixPublicTTC,
  pac.Hpx_Valeur prix_achat_catalogue,
  pr.Hpx_Valeur prix_achat_remise,
  pmp.Hpx_Valeur pamp,
  bda.Bda_DelaiLaitJour,
  bda.Bda_DelaiOeufJour,
  bda.Bda_DelaiViandeJour, 
  tva.Tva_Taux,
  tpl.Tyl_Libelle,
  bes.Tsr_Id_Ext,
  tyl.tpl_interne,
  coalesce( bes.cpt_id ,  (select cpt_id from dbo.RefLpp where lpp_id = (select min(lpp_id) from Bes_Asso_Lpp where bes_id = bes.bes_id group by bes_id))),
  bes.Epr_Id_Ext,
  cast(ddp.bdi_dateminiperemption as datetime)
from 
  dbo.BiensEtServices bess
  inner join dbo.BienEtService bes on bes.Bes_Id = bess.Bes_Id
  left join dbo.BesDonneeAdministrative bda on bda.Bes_Id = bes.Bes_Id
  left join prix_ac pac on pac.Bes_Id = bes.Bes_Id
  left join prix_mp pmp on pmp.Bes_Id = bes.Bes_Id
  left join prix_r pr on pr.Bes_Id = bes.Bes_Id
  left join dbo.CodeTva tva on tva.Tva_Id = bess.Tva_Id 
  left join dbo.TypeListe tpl on tpl.Tyl_Id = bes.Tyl_Id
  left join dbo.BesGestionDeStock gds on gds.Bes_Id = bes.Bes_Id
  left join dbo.typologie tyl on tyl.Tpl_Id = bes.Tpl_Id
  left join dbo.BesCommentaire comv on comv.Bes_Id = bess.Bes_Id 
  left join dbo.BesDenoInfo ddp on ddp.Bes_Id = bess.Bes_Id 
where
  (bes.Bes_DateDerniereDelivrance is not null or gds.Gds_IsTenueEnStock = 1)
