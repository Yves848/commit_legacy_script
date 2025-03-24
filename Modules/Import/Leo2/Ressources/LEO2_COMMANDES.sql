select 
c.Com_id, 
cast(c.com_DateCreation as datetime), 
c.Pmo_IdFournisseur, 
cast(c.Com_DateLivraison as datetime), 
eco.Eco_Interne,
sum(l.Lco_PrixRemiseReel*l.Lco_QuantiteCommande)
from dbo.Commande c
inner join dbo.EtatCommande eco on eco.Eco_Id = c.Eco_Id
left join dbo.LigneCommande l on c.Com_Id = l.Com_Id  
where eco.Eco_Interne in ('EnAttenteReception', 'ReceptionEnCours', 'ReceptionPartielle', 'Receptionnee', 'Cloturee')
and c.com_DateCreation > dateadd(year , -2 , getDate() )
group by c.Com_id, 
c.com_DateCreation, 
c.Pmo_IdFournisseur, 
c.Com_DateLivraison, 
eco.Eco_Interne
