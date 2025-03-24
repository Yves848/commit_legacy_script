create or replace package migration.pk_produits as
     
  /* ********************************************************************************************** */
  function creer_fournisseur(AIDFournisseurLGPI in integer,
                                    ATypeFournisseur in char,
                                    ARaisonSociale in varchar2,
                                    AN171Identifiant in varchar2,-- plus utilisé
                                    AN171NumeroAppel in varchar2,-- plus utilisé
                                    ACommentaire in varchar2,
                                    AN171Vitesse in char,-- plus utilisé
                                    AModeTransmission in char,
                                    ARue1 in varchar2,
                                    ARue2 in varchar2,
                                    ACodePostal in varchar,
                                    ANomVille in varchar2,
                                    ATelPersonnel in varchar2,
                                    ATelStandard in varchar2,
                                    ATelMobile in varchar2,
                                    AFax in varchar2,                             
                                    ARepresentePar in varchar2,
                                    ATelephoneRepresentant in varchar2,
                                    AMobileRepresentant in varchar2,
                                    ANumeroFax in varchar2,
                                    AFDPartenaire in char,
                                    AFDCodePartenaire in number,                               
                                    ARepDefaut in char,
                                    ARepObjectifCAMensuel in number,
                                    ARepPharmaMLRefID in number,
                                    ARepPharmaMLURL1 in varchar2,
                                    ARepPharmaMLURL2 in varchar2,
                                    ARepPharmaMLIDOfficine in varchar2,
                                    ARepPharmaMLIDMagasin in varchar2,
                                    ARepPharmaMLCle in varchar2,
									                  AFDCodeSel in varchar2,
                                    AEmail in varchar2,
                                    AEmailRepresentant in varchar2,
                                    AFusion in char)
                                   return integer;

  /* ********************************************************************************************** */
  function creer_zone_geographique(ALibelle in varchar2)
                                  return integer;
                                                                       
  /* ********************************************************************************************** */
  function creer_codification(ARang in integer,
                              ALibelle in varchar2)
                             return integer;
                                  
  /* ********************************************************************************************** */
  function creer_produit(AIDProduitLGPI in integer,
                         ACodeCIP in varchar2,        
                         ACodesEAN in varchar2,                     
                         ADesignation in varchar2,
                         APrixAchatCatalogue in number, 
                         APrixVente in number, 
                         ABaseremboursement in number, 
                         AEtat in char,
                         ADelaiViande in number, 
                         ADelaiLait in number,                            
                         AGereInteressement in char, 
                         ACommentaireVente in varchar2,                            
                         AEditionEtiquette in char,                            
                         ACommentaireCommande in varchar2, 
                         ACommentaireGestion in varchar2, 
                         APrestation in varchar2, 
                         AGereSuiviClient in char,
                         ATauxTVA in number,
                         AListe in char, 
                         ATracabilite in char, 
                         ALotAchat in number, 
                         ALotVente in number, 
                         AStockMini in number, 
                         AStockMaxi in number,
                         APAMP in number, 
                         ATarifAchatUnique in char, 
                         AProfilGS in char, 
                         ACalculGS in char, 
                         ANombreMoisCalcul in number, 
                         AGerePFC in char, 
                         ASoumisMDL in char, 
                         AIDClassificationInterne in integer,    
                         AConditionnement in number, 
                         AMoyenneVente in number, 
                         AUniteMoyenneVente in number, 
                         ADateDerniereVente in date,   
                         ADatePremiereVente in date,                         
                         AContenance in number, 
                         AUniteMesure in char,                                                                                  
                         APrixAchatRemise in number, 
                         AVeterinaire in char, 
                         AServiceTips in varchar2, 
                         ATypeHomeo in char,                           
                         AMarque in varchar2,
                         AIDRepartiteurExclusif in integer,
                         AQuantite in number,
                         AZoneGeographique in varchar2,
                         AStockMiniPharmacie in number,
                         AStockMaxiPharmacie in number,
                         ACodification1 in varchar2,
                         ACodification2 in varchar2,
                         ACodification3 in varchar2,
                         ACodification4 in varchar2,
                         ACodification5 in varchar2,
                         ADatePeremption in date,
                         APrixAchatMetropole in number,
                         APrixVenteMetropole in number,
						             ACodecip7 in varchar2,
                         AIDArticleRemise in number,
                         AFusion in char)
                        return integer;
                        
  /* ********************************************************************************************** */
  procedure creer_information_stock(AIDProduit in integer,
                                    AQuantite in number,         
                                    AStockMini in number,
                                    AStockMaxi in number,
                                    AZoneGeographique in varchar2,
                                    AIDDepot in integer,
                                    AFusion in char default '0');  

  /* ********************************************************************************************** */
  procedure creer_code_lpp(AIDProduit in integer,
                           ATypeCode in char,
                           ACodeLPP in varchar2,
                           AQuantite in number,
                           ATarifUnitaire in number,
                           APrestation in varchar2,
                           AService in char,
                           AFusion in char);
                           
  /* ********************************************************************************************** */
  procedure creer_code_ean13(AIDProduit in integer,
                             ACodeEAN13 in varchar2,
                             AReferent in integer,
                             AFusion in char);                             

  /* ********************************************************************************************** */
  function creer_depot(ALibelle in varchar2,
                       AAutomate in char,
                       ATypeDepot in varchar2,
                       AFusion in char)
                      return integer;       
  /* ********************************************************************************************** */
  procedure creer_historique_vente(AIDProduit in integer,
                                   APeriode in varchar,
                                   AQuantiteVendues in number,
                                   AQuantiteActes in number,
                                   AFusion in char default '0');
                                   
  /* ********************************************************************************************** */
  function creer_promotion(AIDPromotionLGPI in integer,
                           ALibelle in varchar2,
                           ADateDebut in date,
                           ADateFin in date,
                           ACommentaire in varchar2,
                           ANombreLotsAffectes in number,
                           AStockAlerte in number,
                           ANombreLotsVendus in number,
                           ADateCreation in date)
                          return integer;
                          
  /* ********************************************************************************************** */
  procedure creer_produit_promotion(AIDProduit in integer,
                                    AIDPromotion in integer,
                                    ADeclencheur in char,
                                    AQuantite in number,
                                    APrixVente in number,
                                    ARemise in number,
                                    APrixVenteRemise in number);
                                   
  /* ********************************************************************************************** */
  function creer_commande(AIDCommandeLGPI in integer, 
						              ANumero in integer,
                          AModeTransmission in char,                         
                          ADateCreation in date,
                          AMontantHt in number,
                          ACommentaire in varchar2,
                          AIDFournisseur in integer,
                          AIDRepartiteur in integer,
                          AEtat varchar2,
                          ADateReception in date,
                          ADateReceptionPrevue in date)
                         return integer;
                         
  /* ********************************************************************************************** */
  procedure creer_ligne_commande(AIDCommande in integer,
                                 ADateCreation in date,
                                 AIDFournisseur in number,
                                 AIDRepartiteur in number,
                                 AIDProduit in number,
                                 AQuantiteCommandee in number,
                                 AQuantiteRecue in number,
                                 AQuantiteTotaleRecue in number,
                                 APrixAchatTarif in number,
                                 APrixAchatRemise in number,
                                 APrixVente in number,
                                 AChoixReliquat in number,
                                 AUnitesGratuites in number,
                                 AEtat varchar2,
                                 AReceptionFinanciere in char,
                                 AColisage in number,
                                 ADateReceptionprevue in date);  

  /* ********************************************************************************************** */
  function creer_catalogue(AIDCatalogueLGPI in integer,
                           ADesignation in varchar2,
                           ADateDebut in date,
                           ADateFin in date,
                           AIDFournisseur in integer,
                           ADateCreation in date,
                           ADateFinValidite in date)
                          return integer;
                          
  /* ********************************************************************************************** */
  function creer_classif_fournisseur(AIDClassifFournisseurLGPI in integer,
                                     ADesignation in varchar2,
                                     ADateDebutMarche in date,
                                     ADureeMarche in number,
                                     AIDClassificationParent in integer,
                                     AIDCatalogue in integer)
                                    return integer;
                                    
  /* ********************************************************************************************** */
  procedure creer_ligne_catalogue(AIDCatalogue in integer,
                                  ANoLigne in number,
                                  AIDProduit in integer,
                                  AQuantite in number,
                                  AIDClassificationFournisseur in integer,
                                  APrixAchatCatalogue in number,
                                  APrixAchatRemise in number,
                                  ARemiseSimple in number,
                                  ADateMAJTarif in date,
                                  ADateCreation in date,
                                  AColisage in number);

  /* ********************************************************************************************** */
  procedure creer_histo_stock(AIDFournisseur in integer,
                              AMois in number,
                              AAnnee in number,
                              AValeurStock in number);
  
  /* ********************************************************************************************** */
  procedure maj_commandes;
  
  /* ********************************************************************************************** */
  procedure maj_clickadoc_lppr;
  procedure maj_produit_stup(ACodeCIP in varchar2);
  procedure maj_stock_stup;  
  procedure maj_commande_stup;  
  procedure maj_dictionnaire;  
end; 
/
