select cast(fd.t_fournisseur_id as varchar2(50)),
       fd.raisonsociale,
	   fd.n171_identifiant,
	   fd.n171_noappel,
	   fd.commentaire,
	   decode(fd.n171_vitesse, null, 1, 0, 1, fd.n171_vitesse),
	   decode(fd.modetransmission, null, '5', fd.modetransmission),
	   adr.rue1,
	   adr.rue2,
	   cp.codepostal,
	   cp.nomville,
	   adr.telstandard,
	   adr.telpersonnel,
	   adr.telmobile,
	   adr.fax,	   
	   fd.foud_partenaire,
	   fd.foud_codepartenaire,
	   fd.nofax,
	   fd.foud_codesel
from erp.t_fournisseur fd,
   	 erp.t_adresse adr,
	 erp.t_cpville cp
where fd.t_adresse_id = adr.t_adresse_id(+)
  and adr.t_cpville_id = cp.t_cpville_id(+)	  
  and fd.type_fournisseur = 'D'
  and fd.d_del is null