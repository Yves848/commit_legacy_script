select cast(prd.t_produit_id as varchar2(50)),
       prd.codecip,
       prd.designation,
       prd.designation_nl,
       tva.tauxtva,
       prd.type_prix_bloque,
       prd.designation_bloquee,
       prd.fiche_bloquee,
       prd.stockmini,
       prd.stockmaxi
          /*,
       prd.prixachatcatalogue,
       prd.prixvente,
       prd.baseremboursement,
       prd.etat,
       prd.delaiviande,
       prd.delailait,       
       prd.gereinteressement,
       prd.commentairevente,
       prd.commentairecommande,
       prd.commentairegestion,
       prest.code,
       prd.geresuiviclient,
       prd.liste,
       prd.tracabilite,
       prd.lotachat,
       prd.lotvente,
       prd.pamp,
       prd.tarifachatunique,
       prd.profilgs,
       prd.calculgs,
       prd.nbmoiscalcul,
       prd.gerepfc,
       prd.soumismdl,
       prd.conditionnement,
       prd.moyvte,
       prd.umoyvte,
       prd.datedernvte,
       prd.contenance,
       prd.unitemesure,
       prd.prixachatremise,
       prd.veterinaire,
       prd.servicetips,
       prd.typehomeo,
       prd.t_repartiteur_exclusif_id,
       prd.dateperemption*/
from bel.t_produit prd 
inner join bel.t_tarif_produit tar on prd.t_produit_id = tar.t_produit_id and 
                                      tar.date_valid_debut = (select max (tarif.date_valid_debut) 
                                                              from t_tarif_produit tarif
                                                              where tarif.t_produit_id = tar.t_produit_id and tarif.date_valid_debut <= sysdate)
inner join bel.t_tva tva on tar.t_tva_id = tva.t_tva_id
--where  prd.materiel_location = '0'    and prd.d_del is null
where prd.d_del is null