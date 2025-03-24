unit mdlVisualisationPHA_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, mdlProjet, uibdataset, uib, mdlModuleOutils, Menus,
  JvMenus, mydbunit, fbcustomdataset, mdlPHA;

type
  TdmVisualisationPHA_fr = class(TdmModuleOutils)
    trPHA: TUIBTransaction;
    dSetClients: TUIBDataSet;
    dSetClientsT_CLIENT_ID: TWideStringField;
    dSetClientsNOM: TWideStringField;
    dSetClientsPRENOM: TWideStringField;
    dSetClientsNOM_JEUNE_FILLE: TWideStringField;
    dSetClientsNUMERO_INSEE: TWideStringField;
    dSetClientsDATE_NAISSANCE: TWideStringField;
    dSetClientsCOMMENTAIRE_GLOBAL: TWideStringField;
    dSetClientsCOMMENTAIRE_GLOBAL_BLOQUANT: TWideStringField;
    dSetClientsCOMMENTAIRE_INDIVIDUEL: TWideStringField;
    dSetClientsCOMMENTAIRE_INDIVIDUEL_BLOQUANT: TWideStringField;
    dSetClientsQUALITE: TWideStringField;
    dSetClientsTYPE_QUALITE: TWideStringField;
    dSetClientsLIBELLE_QUALITE: TWideStringField;
    dSetClientsRANG_GEMELLAIRE: TSmallintField;
    dSetClientsNAT_PIECE_JUSTIF_DROIT: TWideStringField;
    dSetClientsDATE_VALIDITE_PIECE_JUSTIF: TDateField;
    dSetClientsT_ORGANISME_AMO_ID: TWideStringField;
    dSetClientsNOM_ORGANISME_AMO: TWideStringField;
    dSetClientsNOM_REDUIT_ORGANISME_AMO: TWideStringField;
    dSetClientsSANS_CENTRE_GESTIONNAIRE: TWideStringField;
    dSetClientsIDENTIFIANT_NATIONAL_ORG_AMO: TWideStringField;
    dSetClientsCENTRE_GESTIONNAIRE: TWideStringField;
    dSetClientsT_ORGANISME_AMC_ID: TWideStringField;
    dSetClientsNOM_ORGANISME_AMC: TWideStringField;
    dSetClientsNOM_REDUIT_ORGANISME_AMC: TWideStringField;
    dSetClientsIDENTIFIANT_NATIONAL_ORG_AMC: TWideStringField;
    dSetClientsNUMERO_ADHERENT_MUTUELLE: TWideStringField;
    dSetClientsCONTRAT_SANTE_PHARMA: TWideStringField;
    dSetClientsMUTUELLE_LUE_SUR_CARTE: TWideStringField;
    dSetClientsDATE_DERNIERE_VISITE: TDateField;
    dSetClientsASSURE_RATTACHE: TWideStringField;
    dSetClientsNOM_ASSURE: TWideStringField;
    dSetClientsPRENOM_ASSURE: TWideStringField;
    dSetClientsRUE_1: TWideStringField;
    dSetClientsRUE_2: TWideStringField;
    dSetClientsCODE_POSTAL: TWideStringField;
    dSetClientsNOM_VILLE: TWideStringField;
    dSetClientsCODE_POSTAL_VILLE: TWideStringField;
    dSetClientsTEL_PERSONNEL: TWideStringField;
    dSetClientsTEL_STANDARD: TWideStringField;
    dSetClientsTEL_MOBILE: TWideStringField;
    dSetClientsFAX: TWideStringField;
    dSetClientsACTIVITE: TWideStringField;
    dSetFamilleClient: TUIBDataSet;
    dSetFamilleClientNOM: TWideStringField;
    dSetFamilleClientPRENOM: TWideStringField;
    dSetFamilleClientLIBELLE_QUALITE: TWideStringField;
    dSetFamilleClientDATE_NAISSANCE: TWideStringField;
    dSetFamilleClientRANG_GEMELLAIRE: TSmallintField;
    dSetFamilleClientNOM_ORGANISME_AMC: TWideStringField;
    dSetCouverturesAMOClient: TUIBDataSet;
    dSetCouverturesAMCClient: TUIBDataSet;
    dSetOrganismes: TUIBDataSet;
    dSetOrganismesT_ORGANISME_ID: TWideStringField;
    dSetOrganismesTYPE_ORGANISME: TWideStringField;
    dSetOrganismesLIBELLE_TYPE_ORGANISME: TWideStringField;
    dSetOrganismesNOM: TWideStringField;
    dSetOrganismesNOM_REDUIT: TWideStringField;
    dSetOrganismesREGIME: TWideStringField;
    dSetOrganismesCAISSE_GESTIONNAIRE: TWideStringField;
    dSetOrganismesCENTRE_GESTIONNAIRE: TWideStringField;
    dSetOrganismesIDENTIFIANT_NATIONAL: TWideStringField;
    dSetOrganismesNOM_DESTINATAIRE: TWideStringField;
    dSetOrganismesRUE_1: TWideStringField;
    dSetOrganismesRUE_2: TWideStringField;
    dSetOrganismesCODE_POSTAL_VILLE: TWideStringField;
    dSetOrganismesCODE_POSTAL: TWideStringField;
    dSetOrganismesNOM_VILLE: TWideStringField;
    dSetOrganismesTEL_PERSONNEL: TWideStringField;
    dSetOrganismesTEL_STANDARD: TWideStringField;
    dSetOrganismesTEL_MOBILE: TWideStringField;
    dSetOrganismesFAX: TWideStringField;
    dSetOrganismesORG_CONVENTIONNE: TWideStringField;
    dSetOrganismesORG_CIRCONSCRIPTION: TWideStringField;
    dSetOrganismesORG_REFERENCE: TWideStringField;
    dSetOrganismesTOP_R: TWideStringField;
    dSetOrganismesACCORD_TIERS_PAYANT: TWideStringField;
    dSetOrganismesDOC_FACTURATION: TSmallintField;
    dSetOrganismesMT_SEUIL_ED_RELEVE: TUIBBCDField;
    dSetOrganismesEDITION_RELEVE: TWideStringField;
    dSetOrganismesTYPE_RELEVE: TWideStringField;
    dSetOrganismesFREQUENCE_RELEVE: TSmallintField;
    dSetOrganismesCOMMENTAIRE: TWideStringField;
    dSetOrganismesCOMMENTAIRE_BLOQUANT: TWideStringField;
    dSetOrganismesPRISE_EN_CHARGE_AME: TWideStringField;
    dSetOrganismesTYPE_CONTRAT: TSmallintField;
    dSetOrganismesFIN_DROITS_ORG_AMC: TWideStringField;
    dSetOrganismesORG_SANTE_PHARMA: TWideStringField;
    dSetOrganismesSAISIE_NO_ADHERENT: TWideStringField;
    dSetOrganismesMT_SEUIL_TIERS_PAYANT: TUIBBCDField;
    dSetOrganismesAPPLICATION_MT_MINI_PC: TWideStringField;
    dSetCouverturesAMO: TUIBDataSet;
    dSetCouverturesAMC: TUIBDataSet;
    dSetAssociationsOrganismesAMOAMC: TUIBDataSet;
    dSetAssociationsOrganismesAMOAMCT_ORGANISME_AMC_ID: TWideStringField;
    dSetAssociationsOrganismesAMOAMCT_ORGANISME_AMO_ID: TWideStringField;
    dSetAssociationsOrganismesAMOAMCNOM_ORGANISME_AMO: TWideStringField;
    dSetAssociationsOrganismesAMOAMCTOP_MUTUALISTE: TWideStringField;
    dSetAssociationsOrganismesAMOAMCTYPE_CONTRAT: TSmallintField;
    dSetAssociationsOrganismesAMOAMCREGIME: TWideStringField;
    dSetAssociationsOrganismesAMOAMCCAISSE_GESTIONNAIRE: TWideStringField;
    dSetAssociationsOrganismesAMOAMCCENTRE_GESTIONNAIRE: TWideStringField;
    dSetAssociationsOrganismesAMOAMCT_DESTINATAIRE_ID: TWideStringField;
    dSetAssociationsOrganismesAMOAMCNOM_DESTINATAIRE: TWideStringField;
    dSetAssociationsOrganismesAMOAMCTYPE_DEBITEUR: TWideStringField;
    dSetPraticiens: TUIBDataSet;
    dSetPraticiensT_PRATICIEN_ID: TWideStringField;
    dSetPraticiensTYPE_PRATICIEN: TWideStringField;
    dSetPraticiensNOM: TWideStringField;
    dSetPraticiensPRENOM: TWideStringField;
    dSetPraticiensNO_FINESS: TWideStringField;
    dSetPraticiensAGREE_RATP: TWideStringField;
    dSetPraticiensRUE_1: TWideStringField;
    dSetPraticiensRUE_2: TWideStringField;
    dSetPraticiensCODE_POSTAL: TWideStringField;
    dSetPraticiensNOM_VILLE: TWideStringField;
    dSetPraticiensCODE_POSTAL_VILLE: TWideStringField;
    dSetPraticiensTEL_STANDARD: TWideStringField;
    dSetPraticiensTEL_PERSONNEL: TWideStringField;
    dSetPraticiensTEL_MOBILE: TWideStringField;
    dSetPraticiensFAX: TWideStringField;
    dSetPraticiensEMAIL: TWideStringField;
    dSetPraticiensCOMMENTAIRE: TWideStringField;
    dSetPraticiensT_HOPITAL_ID: TWideStringField;
    dSetPraticiensNOM_HOPITAL: TWideStringField;
    dSetPraticiensSPECIALITE: TWideStringField;
    dSetPraticiensRPPS: TWideStringField;
    dSetPraticienHospitalier: TUIBDataSet;
    dSetPraticienHospitalierNOM: TWideStringField;
    dSetPraticienHospitalierPRENOM: TWideStringField;
    dSetPraticienHospitalierSPECIALITE: TWideStringField;
    dSetPraticiensLIBELLE_TYPE_PRATICIEN: TWideStringField;
    dSetProduits: TUIBDataSet;
    dSetProduitsT_PRODUIT_ID: TWideStringField;
    dSetProduitsCODE_CIP: TWideStringField;
    dSetProduitsDESIGNATION: TWideStringField;
    dSetProduitsDATE_DERNIERE_VENTE: TDateField;
    dSetProduitsTAUX_TVA: TUIBBCDField;
    dSetProduitsSOUMIS_MDL: TWideStringField;
    dSetProduitsTARIF_ACHAT_UNIQUE: TWideStringField;
    dSetProduitsPRIX_VENTE: TUIBBCDField;
    dSetProduitsBASE_REMBOURSEMENT: TUIBBCDField;
    dSetProduitsPRIX_ACHAT_CATALOGUE: TUIBBCDField;
    dSetProduitsPAMP: TUIBBCDField;
    dSetProduitsPRESTATION: TWideStringField;
    dSetProduitsCONTENANCE: TIntegerField;
    dSetProduitsVETERINAIRE: TWideStringField;
    dSetProduitsDELAI_LAIT: TSmallintField;
    dSetProduitsDELAI_VIANDE: TSmallintField;
    dSetProduitsGERE_INTERESSEMENT: TWideStringField;
    dSetProduitsTRACABILITE: TWideStringField;
    dSetProduitsGERE_SUIVI_CLIENT: TWideStringField;
    dSetProduitsGERE_PFC: TWideStringField;
    dSetProduitsCOMMENTAIRE_VENTE: TWideStringField;
    dSetProduitsCOMMENTAIRE_COMMANDE: TWideStringField;
    dSetProduitsCOMMENTAIRE_GESTION: TWideStringField;
    dSetProduitsMARQUE: TWideStringField;
    dSetProduitsREPARTITEUR_ATTITRE: TWideStringField;
    dSetProduitsNOMBRE_MOIS_CALCUL: TSmallintField;
    dSetProduitsSTOCK_MINI: TIntegerField;
    dSetProduitsSTOCK_MAXI: TIntegerField;
    dSetProduitsCONDITIONNEMENT: TSmallintField;
    dSetProduitsLOT_ACHAT: TIntegerField;
    dSetProduitsLOT_VENTE: TIntegerField;
    dSetProduitsUNITE_MOYENNE_VENTE: TIntegerField;
    dSetProduitsMOYENNE_VENTE: TUIBBCDField;
    dSetProduitsNOMBRE_PRODUIT_DU: TIntegerField;
    dSetProduitsQUANTITE_TOTAL: TLargeintField;
    dSetProduitsZONE_GEOGRAPHIQUE_PHA: TWideStringField;
    dSetProduitsQUANTITE_PHA: TIntegerField;
    dSetProduitsLISTE: TWideStringField;
    dSetProduitsETAT: TWideStringField;
    dSetProduitsUNITE_MESURE: TWideStringField;
    dSetProduitsPROFIL_GS: TWideStringField;
    dSetProduitsCALCUL_GS: TWideStringField;
    dSetCodesEAN13: TUIBDataSet;
    dSetCodesEAN13T_PRODUIT_ID: TWideStringField;
    dSetCodesEAN13CODE_EAN13: TWideStringField;
    dSetProduitsPRODUIT_KIT: TWideStringField;
    dSetCatalogues: TUIBDataSet;
    dSetCataloguesT_PRODUIT_ID: TWideStringField;
    dSetCataloguesPRIX_ACHAT_CATALOGUE: TUIBBCDField;
    dSetCataloguesREMISE_SIMPLE: TUIBBCDField;
    dSetCataloguesPRIX_ACHAT_REMISE: TUIBBCDField;
    dSetProduitsLPP: TUIBDataSet;
    dSetProduitsLPPT_PRODUIT_ID: TWideStringField;
    dSetProduitsLPPTYPE_CODE: TWideStringField;
    dSetProduitsLPPCODE_LPP: TWideStringField;
    dSetProduitsLPPQUANTITE: TIntegerField;
    dSetProduitsLPPTARIF_UNITAIRE: TUIBBCDField;
    dSetProduitsLPPPRESTATION: TWideStringField;
    dSetProduitsLPPSERVICE_TIPS: TWideStringField;
    dSetProduitsTYPE_HOMEO: TWideStringField;
    dSetProduitsCODIFICATION_1: TWideStringField;
    dSetProduitsCODIFICATION_2: TWideStringField;
    dSetProduitsCODIFICATION_3: TWideStringField;
    dSetProduitsCODIFICATION_4: TWideStringField;
    dSetProduitsCODIFICATION_5: TWideStringField;
    dSetProduitsCODIFICATION_7: TWideStringField;
    dSetLibellesCodifications: TUIBDataSet;
    dSetFournisseurs: TUIBDataSet;
    dSetFournisseursTYPE_FOURNISSEUR: TWideStringField;
    dSetFournisseursTYPE_FOURNISSEUR_LIBELLE: TWideStringField;
    dSetFournisseursT_FOURNISSEUR_ID: TWideStringField;
    dSetFournisseursRAISON_SOCIALE: TWideStringField;
    dSetFournisseursIDENTIFIANT_171: TWideStringField;
    dSetFournisseursNUMERO_APPEL: TWideStringField;
    dSetFournisseursCOMMENTAIRE: TWideStringField;
    dSetFournisseursVITESSE_171: TWideStringField;
    dSetFournisseursRUE_1: TWideStringField;
    dSetFournisseursRUE_2: TWideStringField;
    dSetFournisseursCODE_POSTAL: TWideStringField;
    dSetFournisseursNOM_VILLE: TWideStringField;
    dSetFournisseursCODE_POSTAL_VILLE: TWideStringField;
    dSetFournisseursTEL_PERSONNEL: TWideStringField;
    dSetFournisseursTEL_STANDARD: TWideStringField;
    dSetFournisseursTEL_MOBILE: TWideStringField;
    dSetFournisseursFAX: TWideStringField;
    dSetFournisseursREPRESENTE_PAR: TWideStringField;
    dSetFournisseursCODE_PARTENAIRE: TSmallintField;
    dSetFournisseursOBJECTIF_CA_MENSUEL: TIntegerField;
    dSetFournisseursDEFAUT: TWideStringField;
    dSetFournisseursNUMERO_FAX: TWideStringField;
    dSetFournisseursID_PHARMACIE: TWideStringField;
    dSetFournisseursMODE_TRANSMISSION: TWideStringField;
    dSetProduitStock: TUIBDataSet;
    dSetProduitStockT_PRODUIT_ID: TWideStringField;
    dSetProduitStockQUANTITE: TIntegerField;
    dSetProduitStockSTOCK_MINI: TIntegerField;
    dSetProduitStockSTOCK_MAXI: TIntegerField;
    dSetProduitStockZONE_GEOGRAPHIQUE: TWideStringField;
    dSetProduitsEXPLICATION_PROFIL_GS: TWideStringField;
    dSetProduitStockDEPOT: TWideStringField;
    dSetCodifications: TUIBDataSet;
    dSetCodificationsLIBELLE: TWideStringField;
    dSetCodificationsTAUX_MARQUE: TUIBBCDField;
    dSetHistoriqueClient: TUIBDataSet;
    dSetHistoriqueClientNUMERO_FACTURE: TLargeintField;
    dSetHistoriqueClientTYPE_FACTURATION: TWideStringField;
    dSetHistoriqueClientDATE_ACTE: TDateField;
    dSetHistoriqueClientPRATICIEN: TWideStringField;
    dSetHistoriqueClientDATE_PRESCRIPTION: TDateField;
    dSetHistoriqueClientT_CLIENT_ID: TWideStringField;
    dSetHistoriqueClientNOM_CLIENT: TWideStringField;
    dSetHistoriqueClientPRENOM_CLIENT: TWideStringField;
    dSetHistoriqueClientCODE_OPERATEUR: TWideStringField;
    dSetHistoriqueClientCODE_CIP: TWideStringField;
    dSetHistoriqueClientDESIGNATION: TWideStringField;
    dSetHistoriqueClientQUANTITE_FACTUREE: TIntegerField;
    dSetHistoriqueClientPRIX_VENTE: TUIBBCDField;
    dSetHistoriqueClientNOM_PRENOM_CLIENT: TWideStringField;
    dSetCredits: TUIBDataSet;
    dSetCreditsT_CLIENT_ID: TWideStringField;
    dSetCreditsT_COMPTE_ID: TWideStringField;
    dSetCreditsTYPE_CLIENT: TWideStringField;
    dSetCreditsNOM_CLIENT: TWideStringField;
    dSetCreditsDATE_CREDIT: TDateField;
    dSetCreditsTYPE_CLIENT_LIBELLE: TWideStringField;
    dSetVignettesAvancees: TUIBDataSet;
    dSetVignettesAvanceesT_CLIENT_ID: TWideStringField;
    dSetVignettesAvanceesNOM: TWideStringField;
    dSetVignettesAvanceesPRENOM: TWideStringField;
    dSetVignettesAvanceesCODE_CIP: TWideStringField;
    dSetVignettesAvanceesDESIGNATION: TWideStringField;
    dSetVignettesAvanceesQUANTITE_AVANCEE: TIntegerField;
    dSetVignettesAvanceesPRIX_VENTE: TUIBBCDField;
    dSetVignettesAvanceesDATE_AVANCE: TDateField;
    dSetCodificationsT_CODIFICATION_ID: TWideStringField;
    dSetHistoriqueVentes: TUIBDataSet;
    dSetHistoriqueAchats: TUIBDataSet;
    dSetHistoriqueAchatsAQUANTITERECUES: TIntegerField;
    dSetHistoriqueVentesAPERIODE: TWideStringField;
    dSetHistoriqueVentesAQUANTITEVENDUES: TIntegerField;
    dSetHistoriqueAchatsAPERIODE: TWideStringField;
    dSetCommandesEnCours: TUIBDataSet;
    dSetCommandesEnCoursRAISON_SOCIALE: TWideStringField;
    dSetCommandesEnCoursQUANTITE_COMMANDEE: TIntegerField;
    dSetCommandesEnCoursDATE_CREATION: TDateField;
    dSetListeAchats: TUIBDataSet;
    dSetListeAchatsRAISON_SOCIALE: TWideStringField;
    dSetListeAchatsPRIX_ACHAT_TARIF: TUIBBCDField;
    dSetListeAchatsPRIX_ACHAT_REMISE: TUIBBCDField;
    dSetListeAchatsQUANTITE_COMMANDEE: TIntegerField;
    dSetListeAchatsQUANTITE_RECUE: TIntegerField;
    dSetListeAchatsQUANTITE_A_RECEVOIR: TLargeintField;
    dSetListeAchatsT_COMMANDE_ID: TWideStringField;
    dSetListeAchatsDATE_CREATION: TDateField;
    dSetListeAchatsETAT: TWideStringField;
    dSetHistoAchats1: TUIBDataSet;
    dSetHistoAchats1AABRMOIS: TWideStringField;
    dSetHistoAchats1AQUANTITERECUES: TIntegerField;
    dSetHistoAchats2: TUIBDataSet;
    dSetHistoAchats2AABRMOIS: TWideStringField;
    dSetHistoAchats2AQUANTITERECUES: TIntegerField;
    dSetProduitsCOMMANDES_EN_COURS: TIntegerField;
    dSetPromotions: TUIBDataSet;
    dSetPromotionsT_PROMOTION_ID: TWideStringField;
    dSetPromotionsLIBELLE: TWideStringField;
    dSetPromotionsCOMMENTAIRE: TWideStringField;
    dSetPromotionsDATE_DEBUT: TDateField;
    dSetPromotionsDATE_FIN: TDateField;
    dSetPromotionsDATE_DERNIERE_MAJ: TDateField;
    dSetPanierPromotion: TUIBDataSet;
    dSetPanierPromotionT_PROMOTION_ID: TWideStringField;
    dSetPanierPromotionDESIGNATION: TWideStringField;
    dSetPanierPromotionDECLENCHEUR: TWideStringField;
    dSetPanierPromotionQUANTITE: TIntegerField;
    dSetCreditsMONTANT: TUIBBCDField;
    dSetProduitsDus: TUIBDataSet;
    dSetProduitsDusT_CLIENT_ID: TWideStringField;
    dSetProduitsDusNOM: TWideStringField;
    dSetProduitsDusPRENOM: TWideStringField;
    dSetProduitsDusCODE_CIP: TWideStringField;
    dSetProduitsDusDESIGNATION: TWideStringField;
    dSetProduitsDusPRIX_VENTE: TUIBBCDField;
    dSetProduitsDusDATE_DU: TDateField;
    dSetProduitsDusNUMERO_INSEE: TWideStringField;
    dSetProduitsDusQUANTITE: TIntegerField;
    dSetFacturesAttentes: TUIBDataSet;
    dSetFacturesAttentesNOM_CLIENT: TWideStringField;
    dSetFacturesAttentesPRENOM_CLIENT: TWideStringField;
    dSetFacturesAttentesASSURE: TWideStringField;
    dSetFacturesAttentesRUE_1: TWideStringField;
    dSetFacturesAttentesCODE_POSTAL_VILLE: TWideStringField;
    dSetFacturesAttentesDATE_ACTE: TDateField;
    dSetFacturesAttentesCODE_CIP: TWideStringField;
    dSetFacturesAttentesDESIGNATION: TWideStringField;
    dSetFacturesAttentesQUANTITE_FACTUREE: TIntegerField;
    dSetFacturesAttentesPRESTATION: TWideStringField;
    dSetFacturesAttentesT_FACTURE_ATTENTE_ID: TWideStringField;
    dSetFacturesAttentesPRIX_ACHAT: TUIBBCDField;
    dSetFacturesAttentesPRIX_VENTE: TUIBBCDField;
    dSetCommandesEnCoursMODE_TRANSMISSION: TWideStringField;
    dSetCommandesEnCoursCODE_CIP: TWideStringField;
    dSetCommandesEnCoursDESIGNATION: TWideStringField;
    dSetCommandesEnCoursQUANTITE_TOTALE_RECUE: TIntegerField;
    dSetCommandesEnCoursPRIX_ACHAT_TARIF: TUIBBCDField;
    dSetCommandesEnCoursPRIX_ACHAT_REMISE: TUIBBCDField;
    dSetCommandesEnCoursPRIX_VENTE: TUIBBCDField;
    dSetCommandesEnCoursMONTANT_HT: TUIBBCDField;
    dSetProduitsDATE_PEREMPTION: TDateField;
    dSetCataloguesT_FOURNISSEUR_ID: TWideStringField;
    dSetCataloguesCODE_CIP: TWideStringField;
    dSetCataloguesRAISON_SOCIALE: TWideStringField;
    dSetProduitsExclusifs: TUIBDataSet;
    dSetProduitsExclusifsCODE_CIP: TWideStringField;
    dSetProduitsExclusifsDESIGNATION: TWideStringField;
    dSetAvantagePromo: TUIBDataSet;
    dSetAvantagePromoT_PROMOTION_ID: TWideStringField;
    dSetAvantagePromoA_PARTIR_DE: TIntegerField;
    dSetAvantagePromoTYPE_AVANTAGE_PROMO: TWideStringField;
    dSetAvantagePromoVAL_AVANTAGE: TUIBBCDField;
    dSetPromotionsTYPE_PROMOTION: TWideStringField;
    dSetPromotionsDATE_CREATION: TDateField;
    dSetPanierPromotionSTOCK_ALERTE: TIntegerField;
    qryCreerVuesCouvertures: TUIBQuery;
    dSetClientsDELAI_PAIEMENT: TSmallintField;
    dSetClientsCOLLECTIF: TWideStringField;
    dSetClientsPAYEUR: TWideStringField;
    dSetClientsPROFIL_REMISE: TWideStringField;
    dSetClientsPROFIL_EDITION: TWideStringField;
    dsetCollectivites: TUIBDataSet;
    dsetAdherent: TUIBDataSet;
    dSetClientsRELEVE_DE_FACTURE: TIntegerField;
    dSetClientsFIN_DE_MOIS2: TWideStringField;
    dSetCarteFiClient: TUIBDataSet;
    dSetCarteFiClientLIBELLE: TWideStringField;
    dSetCarteFiClientENCOURS_INITIAL: TBCDField;
    dSetCarteFiClientENCOURS_CA: TBCDField;
    dSetCarteFiClientDATE_FIN_VALIDITE: TDateField;
    dSetFournisseursPHARMAML_REF_ID: TSmallintField;
    dSetFournisseursPHARMAML_URL_1: TWideStringField;
    dSetFournisseursPHARMAML_URL_2: TWideStringField;
    dSetFournisseursPHARMAML_ID_OFFICINE: TWideStringField;
    dSetFournisseursPHARMAML_ID_MAGASIN: TWideStringField;
    dSetFournisseursPHARMAML_CLE: TWideStringField;
    dSetFournisseursTELEPHONE: TWideStringField;
    dSetCouverturesAMOCodeSV: TWideStringField;
    dSetCouverturesAMONatass: TSmallintField;
    dSetCouverturesAMOExo: TWideStringField;
    dSetCouverturesAMOPH2: TUIBBCDField;
    dSetCouverturesAMOPH4: TUIBBCDField;
    dSetCouverturesAMOPH7: TUIBBCDField;
    dSetCouverturesAMOPH1: TUIBBCDField;
    dSetCouverturesAMCClientPH2: TUIBBCDField;
    dSetCouverturesAMCClientPH4: TUIBBCDField;
    dSetCouverturesAMCClientPH7: TUIBBCDField;
    dSetCouverturesAMCClientAAD: TUIBBCDField;
    dSetCouverturesAMCClientFindroit: TDateField;
    dSetCouverturesAMOClientCodeSV: TWideStringField;
    dSetCouverturesAMOClientPH2: TUIBBCDField;
    dSetCouverturesAMOClientPH4: TUIBBCDField;
    dSetCouverturesAMOClientPH7: TUIBBCDField;
    dSetCouverturesAMOClientPH1: TUIBBCDField;
    dSetCouverturesAMOClientFindroit: TDateField;
    dSetCouverturesAMONÂdorganisme: TWideStringField;
    dSetCouverturesAMOLibÃllÃ: TWideStringField;
    dSetCouverturesAMCClientNÂdedossier: TWideStringField;
    dSetCouverturesAMCClientLibellÃ2: TWideStringField;
    dSetCouverturesAMCClientDÃbutdroit: TDateField;
    dSetCouverturesAMOClientNÂdedossier: TWideStringField;
    dSetCouverturesAMOClientLibellÃ: TWideStringField;
    dSetCouverturesAMOClientDÃbutdroit: TDateField;
    dSetCataloguesDESIGNATION: TWideStringField;
    dSetProduitsCODE_CIP2: TWideStringField;
    dSetDocumentClient: TUIBDataSet;
    dSetDocumentClientDOCUMENT: TWideStringField;
    dSetDocumentClientT_ENTITE_ID: TWideStringField;
    dSetDocumentClientT_DOCUMENT_ID: TIntegerField;
    dSetCouverturesAMCClientPH1: TUIBBCDField;
    dSetCouverturesAMCClientAAD2: TUIBBCDField;
    procedure dSetClientsAfterScroll(DataSet: TDataSet);
    procedure dSetClientsBeforeClose(DataSet: TDataSet);
    procedure dSetOrganismesAfterScroll(DataSet: TDataSet);
    procedure dSetOrganismesBeforeClose(DataSet: TDataSet);
    procedure dSetPraticiensAfterScroll(DataSet: TDataSet);
    procedure dSetPraticiensBeforeClose(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure dSetProduitsBeforeClose(DataSet: TDataSet);
    procedure dSetProduitsAfterScroll(DataSet: TDataSet);
    procedure dSetFournisseursBeforeClose(DataSet: TDataSet);
    procedure dSetFournisseursAfterScroll(DataSet: TDataSet);
    procedure dSetPromotionsBeforeClose(DataSet: TDataSet);
    procedure dSetPromotionsAfterScroll(DataSet: TDataSet);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
    procedure ConstruireVuesPrestations;
  end;

const
  C_TYPE_PRATICIEN_PRIVE = '1';
  C_TYPE_PRATICIEN_HOSPITALIER = '2';

  C_TYPE_ORGANISME_AMO = '1';
  C_TYPE_ORGANISME_AMC = '2';

  C_TYPE_FOURNISSEUR_DIRECT = '1';
  C_TYPE_REPARTITEUR = '2';

var
  dmVisualisationPHA_fr: TdmVisualisationPHA_fr;

implementation

{$R *.dfm}

constructor TdmVisualisationPHA_fr.Create(Aowner: TComponent;
  AProjet: TProjet);
begin
  inherited;

end;

procedure TdmVisualisationPHA_fr.dSetClientsAfterScroll(DataSet: TDataSet);
begin
  inherited;

  dSetClientsBeforeClose(DataSet);

  dSetFamilleClient.Params.ByNameAsString['AIDCLIENT'] := dSetClientsT_CLIENT_ID.AsString;
  dSetFamilleClient.Params.ByNameAsString['ANUMEROINSEE'] := dSetClientsNUMERO_INSEE.AsString;
  dSetFamilleClient.Open;

  dSetCouverturesAMOClient.Params.ByNameAsString['AIDCLIENT'] := dSetClientsT_CLIENT_ID.AsString;
  dSetCouverturesAMOClient.Open;
  dSetCouverturesAMCClient.Params.ByNameAsString['AIDCLIENT'] := dSetClientsT_CLIENT_ID.AsString;
  dSetCouverturesAMCClient.Open;
  dsetCollectivites.Params.ByNameAsString['AIDCLIENT'] := dSetClientsT_CLIENT_ID.AsString;
  dsetCollectivites.Open;
  dsetAdherent.Params.ByNameAsString['AIDCLIENT'] := dSetClientsT_CLIENT_ID.AsString;
  dsetAdherent.Open;
  dSetCarteFiClient.Params.ByNameAsString['AIDCLIENT'] := dSetClientsT_CLIENT_ID.AsString;
  dsetCarteFiClient.Open;
  dSetDocumentClient.Params.ByNameAsString['AIDCLIENT'] := dSetClientsT_CLIENT_ID.AsString;
  dSetDocumentClient.Open;
end;

procedure TdmVisualisationPHA_fr.dSetClientsBeforeClose(DataSet: TDataSet);
begin
  inherited;

  if dSetDocumentClient.Active then dSetDocumentClient.Close;
  if dSetCouverturesAMCClient.Active then dSetCouverturesAMCClient.Close;
  if dSetCouverturesAMOClient.Active then dSetCouverturesAMOClient.Close;
  if dSetFamilleClient.Active then dSetFamilleClient.Close;
  if dsetCollectivites.Active then dsetCollectivites.Close;
  if dsetAdherent.Active then dsetAdherent.Close;
  if dsetCarteFiClient.Active then dsetCarteFiClient.Close;
end;

procedure TdmVisualisationPHA_fr.dSetOrganismesAfterScroll(
  DataSet: TDataSet);
begin
  inherited;

  dSetOrganismesBeforeClose(DataSet);

  if dSetOrganismesTYPE_ORGANISME.AsString = C_TYPE_ORGANISME_AMO then
  begin
    dSetCouverturesAMO.Params.ByNameAsString['AIDORGANISMEAMO'] := dSetOrganismesT_ORGANISME_ID.AsString;
    dSetCouverturesAMO.Open;
  end
  else                             begin
    dSetCouverturesAMC.Params.ByNameAsString['AIDORGANISMEAMC'] := dSetOrganismesT_ORGANISME_ID.AsString;
    dSetCouverturesAMC.Open;

    dSetAssociationsOrganismesAMOAMC.Params.ByNameAsString['AIDORGANISMEAMC'] := dSetOrganismesT_ORGANISME_ID.AsString;
    dSetAssociationsOrganismesAMOAMC.Open;
  end;
end;

procedure TdmVisualisationPHA_fr.dSetOrganismesBeforeClose(DataSet: TDataSet);
begin
  inherited;

  if dSetCouverturesAMO.Active then dSetCouverturesAMO.Close;
  if dSetCouverturesAMC.Active then dSetCouverturesAMC.Close;
  if dSetAssociationsOrganismesAMOAMC.Active then dSetAssociationsOrganismesAMOAMC.Close;
end;

procedure TdmVisualisationPHA_fr.dSetPraticiensAfterScroll(
  DataSet: TDataSet);
begin
  inherited;

  dSetPraticiensBeforeClose(DataSet);

  if dSetPraticiensTYPE_PRATICIEN.AsString = C_TYPE_PRATICIEN_PRIVE then
    dSetPraticienHospitalier.Close
  else
  begin
    dSetPraticienHospitalier.Params.ByNameAsString['AIDHOPITAL'] := dSetPraticiensT_HOPITAL_ID.AsString;
    dSetPraticienHospitalier.Open;
  end;
end;

procedure TdmVisualisationPHA_fr.dSetPraticiensBeforeClose(DataSet: TDataSet);
begin
  inherited;

  if dSetPraticienHospitalier.Active then dSetPraticienHospitalier.Close;
end;

procedure TdmVisualisationPHA_fr.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dSetPraticiens.Database := Projet.PHAConnexion;
  dSetPraticienHospitalier.Database := Projet.PHAConnexion;

  dSetOrganismes.Database := Projet.PHAConnexion;
  dSetCouverturesAMO.Database := Projet.PHAConnexion;
  dSetCouverturesAMC.Database := Projet.PHAConnexion;
  dSetAssociationsOrganismesAMOAMC.Database := Projet.PHAConnexion;

  dSetClients.Database := Projet.PHAConnexion;
  dSetFamilleClient.Database := Projet.PHAConnexion;
  dSetCouverturesAMOClient.Database := Projet.PHAConnexion;
  dSetCouverturesAMOClient.Transaction := trPHA;
  dSetCouverturesAMCClient.Database := Projet.PHAConnexion;
  dSetCouverturesAMCClient.Transaction := trPHA;
  dSetDocumentClient.Database := Projet.PHAConnexion;
  dSetDocumentClient.Transaction := trPHA;

  dSetcodifications.Database := Projet.PHAConnexion;
  dSetFournisseurs.Database := Projet.PHAConnexion;
  dSetProduitsExclusifs.Database := Projet.PHAConnexion;

  dSetLibellesCodifications.Database := Projet.PHAConnexion;
  dSetProduits.Database := Projet.PHAConnexion;
  dSetCatalogues.Database := Projet.PHAConnexion;
  dSetCodesEAN13.Database := Projet.PHAConnexion;
  dSetProduitsLPP.Database := Projet.PHAConnexion;
  dSetProduitStock.Database := Projet.PHAConnexion;

  dSetHistoriqueClient.Database := Projet.PHAConnexion;
  dSetHistoriqueVentes.Database := Projet.PHAConnexion;
  dSetHistoriqueAchats.Database := Projet.PHAConnexion;
  dSetCommandesEnCours.Database := Projet.PHAConnexion;

  dSetPromotions.Database := Projet.PHAConnexion;
  dSetPanierPromotion.Database := Projet.PHAConnexion;
  dSetAvantagePromo.Database := Projet.PHAConnexion;

  dSetCredits.Database := Projet.PHAConnexion;
  dSetCredits.Transaction := trPHA;
  dSetVignettesAvancees.Database := Projet.PHAConnexion;
  dSetProduitsDus.Database := Projet.PHAConnexion;
  dSetFacturesAttentes.Database := Projet.PHAConnexion;

  trPHA.DataBase := Projet.PHAConnexion;

  qryCreerVuesCouvertures.DataBase := Projet.PHAConnexion;
end;

procedure TdmVisualisationPHA_fr.ConstruireVuesPrestations;
begin
  qryCreerVuesCouvertures.Transaction.StartTransaction;
  qryCreerVuesCouvertures.Execute;
  qryCreerVuesCouvertures.Close(etmCommit);
end;

procedure TdmVisualisationPHA_fr.dSetProduitsBeforeClose(DataSet: TDataSet);
begin
  inherited;

  if dSetProduitStock.Active then dSetProduitStock.Close;
  if dSetCatalogues.Active then dSetCatalogues.Close;
  if dSetCodesEAN13.Active then dSetCodesEAN13.Close;
  if dSetProduitsLPP.Active then dSetProduitsLPP.Close;
end;

procedure TdmVisualisationPHA_fr.dSetProduitsAfterScroll(DataSet: TDataSet);
begin
  inherited;

  dSetProduitsBeforeClose(DataSet);

  dSetProduitsLPP.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
  dSetProduitsLPP.Open;

  dSetCodesEAN13.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
  dSetCodesEAN13.Open;

  AjouterWhere(dSetCatalogues.SQL, 't_produit_id = ' + QuotedStr(dSetProduitsT_PRODUIT_ID.AsString));
  dSetCatalogues.Open;

  dSetProduitStock.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
  dSetProduitStock.Open;
end;

procedure TdmVisualisationPHA_fr.dSetFournisseursBeforeClose(
  DataSet: TDataSet);
begin
  inherited;

  if dSetProduitsExclusifs.Active then dSetProduitsExclusifs.Close;
  if dSetCatalogues.Active then dSetCatalogues.Close;
end;

procedure TdmVisualisationPHA_fr.dSetFournisseursAfterScroll(
  DataSet: TDataSet);
begin
  inherited;

  dSetFournisseursBeforeClose(DataSet);

  if dSetFournisseursTYPE_FOURNISSEUR.AsString = C_TYPE_FOURNISSEUR_DIRECT then
  begin
    dSetCatalogues.Params.ByNameAsString['AFOURNISSEURID'] := dSetFournisseursT_FOURNISSEUR_ID.AsString;
    dSetCatalogues.Open;
  end
  else
  begin
    dSetProduitsExclusifs.Params.ByNameAsString['AREPARTITEURID'] := dSetFournisseursT_FOURNISSEUR_ID.AsString;
    dSetProduitsExclusifs.Open;
  end;
end;

procedure TdmVisualisationPHA_fr.dSetPromotionsBeforeClose(DataSet: TDataSet);
begin
  inherited;

  if dSetPanierPromotion.Active then dSetPanierPromotion.Close;
  if dSetAvantagePromo.Active then dSetAvantagePromo.Close;
end;

procedure TdmVisualisationPHA_fr.dSetPromotionsAfterScroll(DataSet: TDataSet);
begin
  inherited;

  dSetPromotionsBeforeClose(DataSet);
  dSetPanierPromotion.Params.ByNameAsString['APROMOTIONID'] := dSetPromotionsT_PROMOTION_ID.AsString;
  dSetPanierPromotion.Open;
  dSetAvantagePromo.Params.ByNameAsString['APROMOTIONID'] := dSetPromotionsT_PROMOTION_ID.AsString;
  dSetAvantagePromo.Open;
end;

end.