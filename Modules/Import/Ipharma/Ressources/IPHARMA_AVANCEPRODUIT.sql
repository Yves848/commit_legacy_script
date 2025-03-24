SELECT 
	o.credit_id
	,o.personne_id
	,o.tar_id
	,o.libelle
	,o.date_delivrance
	,o.ticket_moderateur
	--,s.PRIX_PUBLIC_PIECE
	--,s.REMISE
	,o.cbu
	--,s.DOUBLE_OA_TM
FROM credit_ordo o
inner join vente_ligne_specialite s on (s.vente_ligne_specialite_id = o.vente_ligne_id)
WHERE o.visible = 1 AND o.apure_id = 0 AND o.date_delivrance >= dateadd(month, -36, current_date)  AND o.tar_id > 0 AND o.personne_id > 0
