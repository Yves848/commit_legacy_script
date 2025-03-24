SELECT 
 f.code
 ,f.nom
 ,adr.adresse
 ,adr.codepostal
 ,adr.localité
 ,adr.téléphone
 ,adr.gsm
 ,adr.fax
 ,adr.email
 ,f.Type
FROM fournisseurs f 
LEFT OUTER JOIN adresses adr ON f.idadresse = adr.idadresses