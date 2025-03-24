SELECT 
 ol.vente_ligne_specialite_id
,ol.tar_id
,v.personne_id
,v.prescripteur_id
,v.numero_ordonnance
,(ol.non_delivre - ol.delivre_ulterieurement) as qte
,v.date_vente
,v.date_prescription
FROM ordo_ligne_specialite ol
--INNER JOIN vente_ligne_specialite vl on ol.vente_ligne_specialite_id = vl.vente_ligne_specialite_id
INNER JOIN vente v on ol.vente_id = v.vente_id
WHERE ol.non_delivre > 0 AND v.date_vente >= dateadd(month, -36, current_date) AND v.numero_ordonnance > 0 AND ol.delivre_ulterieurement < ol.non_delivre