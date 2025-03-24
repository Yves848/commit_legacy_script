select cast(cli.t_aad_id as varchar(50)),
       cli.nom,
       cli.prenom,
       cli.sexe,
       cli.langue,
       cli.datenaissance,
       adr.rue1,
       adr.rue2,
       cp.codepostal,
       cp.nomville,
       adr.telstandard,
       adr.telpersonnel,
       adr.telmobile,
       adr.fax,
       adr.email,
       adr.siteweb,
       oa.identifiant,
       oa.nocpas,
       oaass.num_inscription,
       oaass.datedebutdroit,
       oaass.datefindroit,
       oc.identifiant,
       oc.nocpas,
       ocass.num_inscription,
       categ.num_benef,
       ocass.datedebutdroit,
       ocass.datefindroit,
       oaass.ct1,
       oaass.ct2,
       cli.versionassurabilite,
       cli.notvaintracommunautaire,
       cli.numerocartesis,
       cli.numeroinsee,
       cli.certificatcartesis,
       cli.datedernierelecturesis,
       cli.datedebutvaliditepiece,
       cli.datefinvaliditepiece,
       cli.natpiecejustifdroit,
       cli.commindividuel,
       cli.commindividuelbloquant,
       cli.payeur,
       cli.delaipaiement,
       cli.datedernierevisite,
       cli.collectivite,
       col.no_collectivite,
       (select min(no_famille) from bel.t_familleaad fam where fam.t_aad_id = cli.t_aad_id),
       cli.editionbvac,
       cli.editioncbl,
       cli.editionrecu,
       cli.typeprofilfacturation,
       cli.copiescanevasfacture,
       col.chambre,
       col.etage,
       col.maison,
       col.lit,
       cli.code_court,
       cli.nb_ticket_noteenvoi,
       cli.nb_etiq_noteenvoi,
       cli.etat_client
from bel.t_assureayantdroit cli
left join bel.t_adresse adr on adr.t_adresse_id = cli.t_adresse_id
left join bel.t_cpville cp on cp.t_cpville_id = adr.t_cpville_id
   left join bel.t_organismeamo oa on cli.t_organismeamo_id = oa.t_organismeamo_id
   left join bel.t_assurabilite oaass on oaass.t_assurabilite_id = cli.t_assurabiliteoa_id
   left join bel.t_organismeamc oc on cli.t_organismeamc_id = oc.t_organismeamc_id
   left join bel.t_categoriebenef categ on categ.t_categoriebenef_id = cli.categoriebenefoc
   left join bel.t_assurabilite ocass on ocass.t_assurabilite_id = cli.t_assurabiliteoc_id
   left join bel.t_collectivite col on col.t_aad_id = cli.t_aad_id  
/* left join bel.t_organismeamo oat on cli.t_organismeamo_id = oat.t_organismeamo_id
   left join bel.t_assurabilite oatass on oatass.t_assurabilite_id = cli.t_assurabiliteoa_id*/
where cli.id_del is null 
and (col.no_collectivite = (select min(col1.no_collectivite) 
                            from bel.t_collectivite col1 
                            where col1.t_aad_id = cli.t_aad_id) 
     or col.no_collectivite is null)
order by cli.t_aad_id