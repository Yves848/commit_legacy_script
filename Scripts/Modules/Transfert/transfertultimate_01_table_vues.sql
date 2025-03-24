set sql dialect 3;

/* ********************************************************************************************** */
/* grdPraticiens */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRATICIENS', '22', '1', 'Praticiens', 'grdPraticiens', next value for seq_grille_trf_praticiens);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertulti_praticien', 'pk_praticiens.creer_praticien', 'TW_PRATICIEN', '1', gen_id(seq_fct_fichier, 0));

/* grdOrganismes */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISME CPAS OA', '22', '1', 'Organismes CPAS OA', 'grdOrganismes', next value for seq_grille_trf_organismes);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionOrganismeCPAS', 'pk_organismes.CreationOrganismeCPAS_OA', 'tw_organismeCPAS_OA', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISME CPAS OC', '22', '1', 'Organismes CPAS OC', 'grdOrganismes', next value for seq_grille_trf_organismes);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionOrganismeCPAS', 'pk_organismes.CreationOrganismeCPAS_OC', 'tw_organismeCPAS_OC', '0', gen_id(seq_fct_fichier, 0));

/* grdClients */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PROFILREMISE', '22', '1', 'Profil de remise', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionProfilRemise', 'pk_clients.CreationProfilRemise', 'TW_PROFILREMISE', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PATIENTS', '22', '1', 'Patients - Clients', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionClient', 'pk_clients.CreationClient', 'TW_CLIENT', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MAJ_CPAS', '22', '1', 'Mise à jour des CPAS', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionMajCPAS', 'pk_clients.MajCPAS', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PATHOLOGIE', '22', '1', 'Patients - Pathologies', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertulti_pathologie', 'pk_clients.creer_pathologie', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ALLERGIE', '22', '1', 'Patients - Allergies', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertulti_allergie_atc', 'pk_clients.creer_allergie_atc', '1', gen_id(seq_fct_fichier, 0));

/* grdProduits */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DEPOT', '22', '1', 'Depot', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionDepot', 'pk_produits.CreationDepot', 'TW_DEPOT', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONES GEOGRAPHIQUES', '22', '1', 'Zones geographiques', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionZoneGeo', 'pk_produits.CreationZoneGeo', 'TW_ZONEGEO', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '22', '1', 'Produits - Tarifs', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionProduit', 'pk_produits.CreationProduit', 'TW_PRODUIT', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'STOCKS', '22', '1', 'Stocks', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionProduitGeographique', 'pk_produits.CreationProduitGeographique', 'TW_PRODUITGEOGRAPHIQUE', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'REPARTITEURS', '22', '1', 'Repartiteurs', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionRepartiteur', 'pk_produits.CreationRepartiteur', 'TW_REPARTITEUR', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '22', '1', 'Fournisseurs', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionFournisseur', 'pk_produits.CreationFournisseur', 'TW_FOURNISSEUR', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITSFOURNISSEURS', '22', '1', 'Lien Produits - Fournisseurs', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionPdtFournisseur', 'pk_produits.CreationPdtFournisseur', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODESBARRES', '22', '1', 'Codes EAN13', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionCodeBarre', 'pk_produits.CreationCodeBarre', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FICHEANALYSE', '22', '1', 'Fiches d analyse', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionFicheAnalyse', 'pk_produits.CreationFicheAnalyse', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FORMULAIRE', '22', '1', 'Formulaires magistrales', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'Selection_Formulaire', 'pk_produits.CreationFormulaire', 'TW_FORMULAIRE', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FORMULE', '22', '1', 'Formules magistrales', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'Selection_Formule', 'pk_produits.CreationFormule',  'TW_FORMULE', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FORMULE_LIGNE', '22', '1', 'Lignes des Formules magistrales', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'Selection_Formule_Ligne', 'pk_produits.CreationFormuleLigne',  null, '0', gen_id(seq_fct_fichier, 0));

/* grdEncours */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AVANCEPRODUIT', '22', '1', 'Avance Produit', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionAvanceProduit', 'pk_encours.CreationAvanceProduit', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DELDIF', '22', '1', 'Delivrances differees', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionDelDif', 'pk_encours.CreationDelDif', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITCLIENT', '22', '1', 'Credit Client', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionCredit', 'pk_encours.CreationCredit', null, '1', gen_id(seq_fct_fichier, 0));

--mis dans les encours car apres client et produit
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ATTESTATION', '22', '1', 'Attestation Client', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionAttestation', 'pk_encours.CreationAttestation', null, '1', gen_id(seq_fct_fichier, 0));

/*grdAutresDonnees*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PARAMETRES', '22', '1', 'Paramètres pharmacie', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertulti_parametres', 'pk_autres_donnees.maj_parametre', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELENTETE', '22', '1', 'Historiques Patients', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionHisto_Client_Entete', 'pk_autres_donnees.CreationHisto_Client_Entete', 'TW_HISTO_CLIENT_ENTETE', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELLIGNE', '22', '1', 'Historiques Patients - Lignes', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionHisto_Client_Ligne', 'pk_autres_donnees.CreationHisto_Client_Ligne', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELMAGISTRALE', '22', '1', 'Historiques Patients - Magistrale', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionHisto_Client_Magis', 'pk_autres_donnees.CreationHisto_Client_Magis', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTOVENTE', '22', '1', 'Historiques de ventes', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionHistoVente', 'pk_autres_donnees.CreationHistoVente', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTOACHAT', '22', '1', 'Historiques achats', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertulti_histo_achat', 'pk_autres_donnees.CreationHistoriqueAchat', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDICATION_PRODUIT', '22', '1', 'Schéma de médication - Produits', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'Selection_Medication_Produit', 'pk_autres_donnees.CreationMedicationProduit', 'tw_medication_produit', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDICATION_PRISE', '22', '1', 'Schéma de médication - Prises', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'Selection_Medication_Prise', 'pk_autres_donnees.CreationMedicationPrise', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SOLDE_TUH_PATIENT', '22', '1', 'Solde patients TUH', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'Selection_Solde_TUH_Patient', 'pk_autres_donnees.CreationSoldePatientTUH', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SOLDE_TUH_BOITE', '22', '1', 'Solde boite TUH', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'Selection_Solde_TUH_Boite', 'pk_autres_donnees.CreationSoldeBoiteTUH', null, '0', gen_id(seq_fct_fichier, 0));

/*grdCartesFidelites*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPTERIST', '22', '1', 'Comptes ristournes', 'grdCartesFidelites', next value for seq_grille_trf_avantages);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionCompte', 'pk_cartes_ristournes.CreationCompte', 'TW_COMPTE', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CARTERIST', '22', '1', 'Cartes ristournes', 'grdCartesFidelites', next value for seq_grille_trf_avantages);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionCarteRist', 'pk_cartes_ristournes.CreationCarteRist', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TRANSACTIONRIST', '22', '1', 'Transactions ristournes', 'grdCartesFidelites', next value for seq_grille_trf_avantages);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'SelectionTransactRist', 'pk_cartes_ristournes.CreationTransactRist', null, '1', gen_id(seq_fct_fichier, 0));
