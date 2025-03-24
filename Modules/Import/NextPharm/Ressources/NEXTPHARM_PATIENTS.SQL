SELECT 
  cli.idpatient
 ,cli.nom
 ,cli.prenom
 ,cli.sexe
 ,cli.langue
 ,trim(cast(cli.datenaissance as varchar(10)))
 ,adr.adresse
 ,adr.codepostal
 ,adr.localité
 ,adr.préfixepays
 ,adr.téléphone
 ,adr.gsm
 ,adr.fax
 ,adr.email
 ,cli.mutuelle1
 ,cli.matricule1
 ,cli.cb1_1
 ,cli.cb2_1
 ,trim(cast(cli.datedebutassurabilité as varchar(10)))
 ,trim(cast(cli.datefinassurabilité as varchar(10)))
 ,cli.mutuelle2
 ,cli.matricule2
 ,cli.cb1_2
 ,cli.VersionAssurabilité
 ,cli.numtva
 ,cli.numcartesis
 ,cli.niss
 ,cli.certificatsis
 ,trim(cast(cli.DateDerLectureCarte as varchar(10))) 
 ,cli.remarques
 ,trim(cast(cli.datedervente as varchar(10)))
 ,'0'
 ,col.idclient
 ,cli.remristpc
 ,0
 ,cli.bvacauto
 ,cli.cblauto
 ,cli.annexe30auto 
 ,col.numchambre
 ,cli.idtitulaire
 ,cli.RemarqueSchema
 ,cli.NumCarteEid
FROM Patients cli
LEFT OUTER JOIN Adresses adr ON cli.idadresseprincipale = adr.idadresses
left outer join CLIHabituelsPAT col on col.idpatient=cli.idpatient
WHERE fichemasquée = 0 AND  cli.nom<>'' AND cli.nom is not null