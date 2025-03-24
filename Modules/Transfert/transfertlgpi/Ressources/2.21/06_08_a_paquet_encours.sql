create or replace package migration.pk_encours as                                   

  /* ********************************************************************************************** */
  type rec_facture is record(
    t_acte_id integer,
    t_facture_id integer);

  /* ********************************************************************************************** */
  function creer_facture(ADateFacture in date,
                         AIDClient in integer,
                         AMontant in number,
                         AAttente in boolean default false)
                        return rec_facture;

  function creer_histo_entete(AIDClient in integer,
                         ANumeroFacture in number,
                         ADatePrescription in date,
                         ACodeOperateur in varchar2,
                         AIDStructure in integer,
                         ATypePraticien in char,
                         ANomPraticien in varchar2,
                         APrenomPraticien in varchar2,
                         ANoFiness in varchar2,
                         ACodeSpecialite in varchar2,                         
                         ATypeFacturation in number,
                         ADateActe in date,
                         AMontant in number)
                        return integer;
                        
  procedure creer_histo_ligne(AIDHistoriqueClientEntete in integer,
                              AIDProduit in integer,
                              ACodeCIP in varchar2,
                              ADesignation in varchar2,
                              AQuantiteFacturee in number,
                              --APrixAchat in number,
                              APrixVente in number);
                              
  /* ********************************************************************************************** */
  procedure creer_vignette_avancee(AIDClient in integer,
                                   ADateAvance in date,
                                   ACodeCIP in varchar2,
                                   ADesignation in varchar2,
                                   APrixVente in number,
                                   APrixAchat in number,
                                   APrestation in varchar2,
                                   AIDProduit in integer,
                                   AQuantiteAvancee in number,
                                   ABaseremboursement in number,
                                   AIDOperateur in integer);
                                   
  function creer_credit(ADateCredit date,
                        AIDClient number,
                        AIDCompte number,
                        AMontant number)
                       return integer;
                         
  function creer_produit_du(AIDClient in integer,
                            ADateDu in date)
                           return integer;  

  procedure creer_produit_du_ligne(AIDFacture in integer,
                                   AIDProduit in number,
                                   AQuantite in number);  

  function creer_facture_attente(ADateFacture in date,
                                 AIDClient in integer)
                                return integer;
                                
  procedure creer_facture_attente_ligne(AIDFactureAttente in integer,
                                        AIDProduit in integer,
                                        AQuantiteFacturee in number,
                                        APrestation varchar2,
                                        APrixVente in number,
                                        APrixAChat in number);
										
  procedure maj_produit_du_stup;										
end; 
/
