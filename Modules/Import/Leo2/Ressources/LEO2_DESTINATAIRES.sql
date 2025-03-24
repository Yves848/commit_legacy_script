select 
can.Ctr_Id,
can.Ctr_Libelle,
con.Con_NumeroDestinataire,
con.Con_ServeurPOP,
con.Con_PortPOP,
con.Con_EmailLOI

from CanalDeTransmission  can
left join Concentrateur con on con.Pmo_Id =can.Pmo_IdConcentrateur
where Ctr_IsActif = 1