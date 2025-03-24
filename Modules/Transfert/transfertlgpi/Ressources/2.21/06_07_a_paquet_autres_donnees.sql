create or replace package migration.pk_autres_donnees as
  
  procedure maj_parametre(ACle in varchar,
                          AValeur in varchar);
                          
  function creer_operateur(AIDOperateur in varchar,
                           ACodeOperateur in varchar,
                           ANom in varchar,
                           APrenom in varchar,
                           AMotDePasse in varchar,
                           AActivationOperateur in char,
                           AGraviteInteraction in char)
                          return integer;
                          
  function creer_historique_client(AIDClient in integer,
                                   ANumeroFacture in number,
                                   ADatePrescription in date,
                                   ACodeOperateur in varchar,
                                   ANomPraticien in varchar,
                                   APrenomPraticien in varchar,
                                   ATypeFacturation in number,
                                   ADateActe in date)
                                  return integer;

  procedure creer_historique_client_ligne(AIDHistoriqueClientEntete in integer,
                                          ACodeCIP in varchar,
                                          AIDProduit in integer,
                                          ADesignation in varchar,
                                          AQuantiteFacturee in number,
                                          APrixAchat in number,
                                          APrixVente in number,
                                          AMontantNetHT in number,
                                          AMontantNetTTC in number,
                                          APrixAchatHTRemise in number);
  
  function creer_commentaire(AIDCommentaireLGPI in integer,
                             AIDEntite in integer,
                             ATypeEntite in integer,
                             AEstGlobal in char,
                             AEstBloquant in char,
                             ACommentaire in clob)
                            return integer;        

  procedure recreer_historiques_ventes(AFacteurVDL0 in number, AFacteurVDL1 in number);                                           

  procedure creer_document(ATypeEntite in int, 
                           AIDEntite in integer,
                           AContentType in integer,
                           ALibelle in varchar2,
                           ADateDocument in date, 
                           ACommentaire in varchar2,
                           ADocument in out blob);

  procedure completer_histo_client;			

  procedure calc_stat;
  
  procedure reactive_migration_muse;

/* ********************************************************************************************** */  



end;
/
