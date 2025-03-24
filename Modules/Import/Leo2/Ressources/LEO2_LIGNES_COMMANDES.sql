select 
l.Lco_Id, 
l.Com_Id, 
l.Bes_Id, 
l.Lco_QuantiteCommande, 
l.Lco_QuantiteLivree, 
l.Lco_QuantiteUG, 
l.Lco_PrixCatalogue, 
l.Lco_PrixRemiseReel, 
b.Bes_PrixPublicTTC
from dbo.LigneCommande l
inner join dbo.Commande c on c.Com_Id = l.Com_Id
inner join dbo.EtatCommande eco on eco.Eco_Id = c.Eco_Id
inner join BienEtService b on b.Bes_id = l.Bes_Id
where eco.Eco_Interne in ('EnAttenteReception', 'ReceptionEnCours', 'ReceptionPartielle', 'Receptionnee', 'Cloturee')
and c.com_DateCreation > dateadd(year , -2 , getDate() );
