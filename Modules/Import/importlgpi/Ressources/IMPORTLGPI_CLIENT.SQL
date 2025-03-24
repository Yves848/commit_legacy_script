select cast(cli.t_aad_id as varchar(50)),
       cli.numeroinsee,
   	   cli.nom,
   	   cli.prenom,
   	   cli.nomjeunefille,
   	   cli.commglobal,
   	   cli.commglobalbloquant,
   	   cli.commindividuel,
   	   cli.commindividuelbloquant,
   	   cli.datenaissance,
   	   q.code,
   	   cli.ranggemellaire,
   	   cli.piecejustifdroitsamo,
   	   cli.datevaliditepiecejustif,
   	   o.t_organismeamo_id,
   	   o.centregestionnaire,
   	   cli.t_organismeamc_id,
   	   cli.nadherentmut,
   	   couvamc.t_couvertureamc_id,
   	   cli.datedebdroitsamc,
	     cli.attestation_ame_complementaire,
   	   cli.datefindroitsamc,
   	   cli.datedernierevisite,
   	   cli.t_assurerattache_id,
   	   adr.rue1,
   	   adr.rue2,
   	   cp.codepostal,
   	   cp.nomville,
   	   adr.telstandard,
   	   adr.telpersonnel,
   	   adr.telmobile,
   	   adr.fax,
       adr.email,
   	   cli.t_activite_id,
   	   cli.datecreation,
       cli.genre,
       cli.collectivite,
       cli.payeur,
       cli.delaipaiement,
       cli.findemois,
	     cli.modegestionamc
from erp.t_assureayantdroit cli
     inner join erp.t_qualite q on q.t_qualite_id = cli.t_qualite_id
     left join erp.t_organismeaadamo o on (o.t_aad_id = cli.t_aad_id and o.type_organismeamo = '1')
     left join erp.t_couvertureaadamc couvamc on couvamc.t_aad_id = cli.t_aad_id
   	 left join erp.t_adresse adr on adr.t_adresse_id = cli.t_adresse_id
   	 left join erp.t_cpville cp on cp.t_cpville_id = adr.t_cpville_id
     left join erp.t_activite act on act.t_activite_id = cli.t_activite_id
where cli.id_del is null
order by cli.t_aad_id,
         cli.datefindroitsamc