SELECT 
  ina.idmednuminami
 ,m.nomprénom
 ,adr.adresse
 ,adr.codepostal
 ,adr.localité
 ,adr.préfixepays
 ,adr.téléphone
 ,adr.gsm
 ,adr.fax
 ,adr.email
 ,m.numinamicourt
 ,ina.numinamicomplet
 --,m.remarques 
FROM Médecins m 
LEFT OUTER JOIN Adresses adr ON m.idadresseprof = adr.idadresses
inner join MedNumInami ina on ina.idmédecin= m.idmédecin
WHERE m.numinamicourt is not null 
 and m.numinamicourt <> '' 
 and m.nomprénom is not null 
 and m.nomprénom <> ''
order by  ina.idmednuminami desc
