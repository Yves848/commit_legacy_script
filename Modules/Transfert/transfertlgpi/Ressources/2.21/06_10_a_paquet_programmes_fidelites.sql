/* ********************************************************************************************** */
create or replace package migration.pk_programmes_fidelites as
     
  /* ********************************************************************************************** */
  function creer_prog_avantage(AIDprogrammeavantage in varchar2,
                                ATypeCarte in integer,
                                ACodeExterne in varchar2,
                                ALibelle in varchar2,
                                ANbMoisValidite in integer,
                                ADateFinValidite in date,
                                ADesactivee in char,
                                ATypeObjectif in integer,
                                AValeurObjectif in integer,
                                AValeurPoint in integer,
                                ANbpointTranche in integer,
                                AValeurTranche in integer,
                                AValeurArrondi in integer,
                                ATypeAvantage in integer,
                                AModeCalculAvantage in integer,
                                AValeurAvantage in integer,
                                AValeurEcart in integer,
                                ADiffAssure in char,
                                AValeurCarte in integer   )
                               return integer;
                               
	 /* ********************************************************************************************** */
  procedure creer_prog_avantage_client(AIDprogrammeavantage in varchar2,
                                        AIDClient in varchar2,
                                        ANumeroCarte in varchar2,
                                        AStatut in integer,
                                        ADateCreation in date,
                                        ADateCreationInitiale in date,
                                        ADateFinValidite in date,
                                        AEncoursInitial in integer,
                                        AEncoursCA in integer,
                                        AOperateur in varchar2);

  /* ********************************************************************************************** */
  function creer_prog_avantage_produit(AIDprogrammeavantage in varchar2,
                                        AIDProduit in varchar2,
                                        AGain in char,
                                        AOffert in char,
                                        ANbPointSupp in integer)
                                       return integer;

  procedure creer_carte_prog_rel(AIDcarteprogrel in integer,
                                AIDclient in varchar2,
                                Anumerocarte in varchar2,
                                AIDpfi_lgpi in integer);

end;
