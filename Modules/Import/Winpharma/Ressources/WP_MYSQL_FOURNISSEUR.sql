select 
		fou.Code T_FOURNISSEUR_ID,
		fou.Nom RAISON_SOCIALE,
		fou.Adresse1 RUE_1,
		fou.Adresse2 RUE_2,
		substr(fou.Code_Postal,1,5) CODE_POSTAL,
		fou.Ville NOM_VILLE,
		fou.Modem_Tel NUMERO_APPEL,
		fou.Telephone TEL_PERSONNEL,
		rep2.foufax FAX,
		substr(memo.memo,1,200) COMMENTAIRE,
		fou.ID_Officine IDENTIFIANT_171,
		substr(CONCAT(rep2.RepNom,' ',rep2.RepPreNom),1,50) REPRESENTE_PAR,
		rep2.fax NUMERO_FAX,
		rep2.email EMAIL,
		rep2.portable PORTABLE_REP,
  rep2.telephone	TELEPHONE_REP	
from fournis fou
left join fourep0 rep2 on fou.code = rep2.code and rep2.ti = 0
left join memores memo on memo.ti = fou.memo and tbln = 20
where not( fou.flags = 4 or fou.flags = 5 )  