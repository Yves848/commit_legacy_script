SELECT 
  ina.idmednuminami
 ,m.nompr�nom
 ,adr.adresse
 ,adr.codepostal
 ,adr.localit�
 ,adr.pr�fixepays
 ,adr.t�l�phone
 ,adr.gsm
 ,adr.fax
 ,adr.email
 ,m.numinamicourt
 ,ina.numinamicomplet
 --,m.remarques 
FROM M�decins m 
LEFT OUTER JOIN Adresses adr ON m.idadresseprof = adr.idadresses
inner join MedNumInami ina on ina.idm�decin= m.idm�decin
WHERE m.numinamicourt is not null 
 and m.numinamicourt <> '' 
 and m.nompr�nom is not null 
 and m.nompr�nom <> ''
order by  ina.idmednuminami desc
