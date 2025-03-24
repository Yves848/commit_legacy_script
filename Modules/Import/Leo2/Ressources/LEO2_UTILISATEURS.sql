select uti.Pph_Id, pph.Pph_Nom, pph.Pph_Prenom, uti.Uti_Identifiant
from dbo.Utilisateur uti
  inner join dbo.PersonnePhysique pph on pph.Pph_Id = uti.Pph_Id
where uti.Grp_Id not in (1, 11)