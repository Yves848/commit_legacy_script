SELECT
 Code,
 null,
 No_Ident,
 Nom_Prenom, 
 Nom_Len, 
 Adresse1, 
 Adresse2, 
 substr(Code_Postal,1,5), 
 Ville, 
 Telephone, 
 Fax, 
 Note, 
 CodeSpec, 
 EMail, 
 CodeHopital,
 2, -- forcé 
 com.memo,
 noRPPS
FROM medecin0 med 
left join memores com on (com.ti = med.code and com.tbln =3  )
where No_Ident <>'' 
and if( (salarie >>14)>=1,1,0) =1
