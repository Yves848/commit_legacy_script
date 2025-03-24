select 
    cast(rep.t_fournisseur_id as varchar2(50)),
    rep.raisonsociale,
	   --rep.n171_identifiant,
	   --rep.n171_noappel,
	   rep.commentaire,
	   --decode(rep.n171_vitesse, 0, 1, rep.n171_vitesse),
	   rep.modetransmission,
	   adr.rue1,
	   adr.rue2,
	   cp.codepostal,
	   cp.nomville,
	   adr.telstandard,
	   adr.telpersonnel,
	   adr.telmobile,
	   adr.fax,	   
	   rep.rep_defaut,
	   rep.rep_objectifcamensuel,
	   rep.rep_gammeexclusive,
	   null,
	   rep.nofax,
    pharmaml_ref_id,
    pharmaml_url1,
    pharmaml_url2,
    pharmaml_id_officine,
    pharmaml_id_magasin,
    pharmaml_cle
from 
  erp.t_fournisseur rep,
  erp.t_adresse adr,
	 erp.t_cpville cp
where 
  rep.t_adresse_id = adr.t_adresse_id(+) and
  adr.t_cpville_id = cp.t_cpville_id(+) and 
  rep.type_fournisseur = 'R' and
  rep.d_del is null