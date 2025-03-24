select 
		fou.Code T_REPARTITEUR_ID,
		fou.Nom RAISON_SOCIALE,
		fou.Adresse1 RUE_1,
		fou.Adresse2 RUE_2,
		fou.Code_Postal CODE_POSTAL,
		fou.Ville NOM_VILLE,
		fou.Modem_Tel NUMERO_APPEL,
		fou.Telephone TEL_PERSONNEL,
		rep.portable TEL_MOBILE,
		rep2.foufax FAX,
		rep.fouweb WEB,
  		memo.memo COMMENTAIRE,
		fou.ID_Officine IDENTIFIANT_171,
	  	rep.telephone login ,
	  	rep.fax mdp,
	  	substr(rep.adresse2,1,2 ) pharmaml_ref_id,
	  	memo_url1.memo url1,
		memo_url2.memo url2,
		rep.adresse1 pharmaml_id_officine,	
		substr(rep.adresse2,4,20 ) pharmaml_id_magasin,			
		rep.foufax pharmaml_cle		
		
from fournis fou
left join fourep0 rep on fou.code = rep.code and rep.ti = 32767
left join fourep0 rep2 on fou.code = rep2.code and rep2.ti = 0
left join memores memo_url1 on memo_url1.ti = rep.memo_rep and ( memo_url1.tbln = 44 and memo_url1.ti <> 0 )
left join memores memo_url2 on memo_url2.ti = rep.memo_perso and (  memo_url2.tbln = 44 and memo_url2.ti <> 0 )
left join memores memo on memo.ti = fou.memo and memo.tbln = 20
where ( fou.flags = 4 or fou.flags = 5 )