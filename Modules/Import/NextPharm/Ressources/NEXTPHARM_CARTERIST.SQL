SELECT 
  ct.idcartesfid
 ,ct.numcarte 
 ,ct.idpatient
 ,cm.idcomptefid
 FROM CartesFid ct , CompteFid cm , Patients pat
where ct.idpatient=pat.idpatient and cm.idtitulairecompte =  pat.idtitulaire