SELECT 
	DISTINCT l.credit_argent_id
	,round(-c.somme_due,2)
	,c.last_access
	,p.personne_id
FROM credit_argent_links l
INNER JOIN credit_argent c ON c.credit_argent_id = l.credit_argent_id AND c.visible = 1
INNER JOIN personne p on p.personne_id = l.personne_id
where round(-c.somme_due,2)>0