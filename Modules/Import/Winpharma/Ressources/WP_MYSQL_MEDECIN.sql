SELECT
 med.Code,
 med.No_Ident finess_cabinet, 
 hop.No_Ident finess_hopital,
 med.Nom_Prenom, 
 med.Nom_Len, 
 med.Adresse1, 
 med.Adresse2, 
 substr(med.Code_Postal,1,5), 
 med.Ville, 
 med.Telephone, 
 med.Fax, 
 med.Note, 
 med.CodeSpec, 
 med.EMail, 
 mh.ti_hop,
 0,
 com.memo,
 med.noRPPS
FROM medecin0 med 
left join memores com on (com.ti = med.code and com.tbln =3  )
left join medhop mh on med.code = mh.ti_med
left join medecin0 hop on hop.code = mh.ti_hop
where if( (med.salarie >>14)>=1,1,0) =0  
