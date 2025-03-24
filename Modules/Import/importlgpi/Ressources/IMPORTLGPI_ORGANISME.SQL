select 
  cast(orgamo.t_organismeamo_id as varchar2(50)),
  '1', 
  orgamo.nomreduit,
  orgamo.commentaire,
  orgamo.commentairebloquant,
  adramo.rue1,
  adramo.rue2,
  cpamo.codepostal,
  cpamo.nomville,
  adramo.telpersonnel,
  adramo.telstandard,
  adramo.telmobile,
  adramo.fax,
  orgamo.orgreference,
  orgamo.mtseuiltierspayant,
  orgamo.accordtierspayant,
  decode(orgamo.docfacturation, 0, null, orgamo.docfacturation),  
  orgamo.typereleve,
  orgamo.editionrreleve,
  orgamo.frequencereleve,
  orgamo.mtseuiledreleve,
  reg.code,
  orgamo.caissegestionnaire,
  orgamo.centregestionnaire,
  orgamo.findroitsorgamc,
  orgamo.orgcirconscription,
  orgamo.orgconventionne,
  substr(orgamo.nom,1,50),
  null,
  '0',
  orgamo.applicationmtminipc,
  0,
  '0',
  cast(orgamo.t_destinataire_id as varchar2(50))
from 
  erp.t_organismeamo orgamo,
  erp.t_adresse adramo,
	 erp.t_cpville cpamo,
	 erp.t_regime reg
where orgamo.t_adresse_id = adramo.t_adresse_id(+)
  and adramo.t_cpville_id = cpamo.t_cpville_id(+)
  and orgamo.t_regime_id = reg.t_regime_id(+)
  and orgamo.t_organismeamo_id in (select t_organismeamo_id from erp.t_assureayantdroit)	 
  and orgamo.d_del is null
union all
select 
  cast(orgamc.t_organismeamc_id as varchar2(50)),
  '2',
  orgamc.nomreduit,
  orgamc.commentaire,
  orgamc.commentairebloquant,
  adramc.rue1,
  adramc.rue2,
  cpamc.codepostal,
  cpamc.nomville,
  adramc.telpersonnel,
  adramc.telstandard,
  adramc.telmobile,
  adramc.fax,
  orgamc.orgreference,
  orgamc.mtseuiltierspayant,
  orgamc.accordtierspayant,
  decode(orgamc.docfacturation, 0, null, orgamc.docfacturation),
  orgamc.typereleve,
  orgamc.editionrreleve,
  orgamc.frequencereleve,
  orgamc.mtseuiledreleve,
  null,
  null,
  null,
  '0',
  '0',
  '0',
  substr(orgamc.nom,1,50),
  orgamc.identifiantnational,
  orgamc.priseenchargeame,
  orgamc.applicationmtminipc,
  orgamc.typecontrat,
  orgamc.saisienoadherent,
  cast(orgamc.t_destinataire_id as varchar2(50))
from 
  erp.t_organismeamc orgamc,
  erp.t_adresse adramc,
	 erp.t_cpville cpamc  
where orgamc.t_adresse_id = adramc.t_adresse_id(+)
  and adramc.t_cpville_id = cpamc.t_cpville_id(+)
  and orgamc.d_del is null