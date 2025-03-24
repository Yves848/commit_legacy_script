create or replace package migration.pk_organismes as

   /* ********************************************************************************************** */
   function creer_destinataire(AIDDestinataireLGPI in integer,
                               ANumIdent in varchar2,
                               --ANomUtil in varchar2,
                               --AMotPasse in varchar2,
                               AServSmtp in varchar2,
                               AServPop3 in varchar2,
                               AServDNS in varchar2,
                               AUtilisateurPop3 in varchar2,
                               AMotPassePop3 in varchar2,
                               AAdresseBAL in varchar2,
                               ANoAppel in varchar2,
                               ATempo in number,
                               AEmailOCT in varchar2,
                               ANom in varchar2,
                               ARue1 in varchar2,
                               ARue2 in varchar2,
                               ACodePostal in varchar2,
                               ANomVille in varchar2,
                               ATelPersonnel in varchar2,
                               ATelStandard in varchar2,
                               ATelMobile in varchar2,
                               AFax in varchar2,
                               AApplicationOCT in varchar2,
                               ANumDestOCT in varchar2,
                               ANorme in varchar2,
                               ANormeRetour in varchar2,
                               --ANomFicAller in varchar2,
                               --ANomFicRetour in varchar2,
                               ACommentaire in varchar2,
                               AFlux in varchar2,
                               AZoneMessage in varchar2,
                               AOCT in varchar2,
                               AAuthentification in char,
                               ATyp in varchar2,
                               ARefuseHTP in char,
                               AGestionNumLots in char,
                               AXSL in varchar2)
                              return integer;
   /* ********************************************************************************************** */
   function creer_organisme(AIDOrganismeAMCLGPI in integer,
                            ATypeOrganisme in char,
                            ANomReduit in varchar2,
                            ACommentaire in varchar2,
                            ACommentaireBloquant in varchar2,
                            ARue1 in varchar2,
                            ARue2 in varchar2,
                            ACodePostal in char,
                            ANomVille in varchar2,
                            ATelPersonnel in varchar2,
                            ATelStandard in varchar2,
                            ATelMobile in varchar2,
                            AFax in varchar2,
                            AOrgReference in char,
                            AMtSeuilTiersPayant in number,
                            AAccordTiersPayant char,
                            AIDDestinataire in varchar2,
                            ADocFacturation in number,
                            ATypeReleve in varchar2,
                            AEditionReleve in char,
                            AFrequenceReleve in number,
                            AMtSeuilEdReleve in number,
                            ARegime in varchar2,
                            ACaisseGestionnaire in varchar2,
                            ACentreGestionnaire in varchar2,
                            AFinDroitsOrgAMC in char,
                            --ATopR in char,-- disparu 2.0 
                            AOrgCirconscription in char,
                            AOrgConventionne in char,
                            ANom in varchar2,
                            --AOrgSantePharma in char,-- disparu 2.0
                            AIdentifiantNational in varchar2,
                            APriseEnChargeAME in char,
                            AApplicationMtMiniPC in char,
                            ATypeContrat in number,
                            ASaisieNoAdherent in char,
                            AFusion in char)
                           return integer;

   function creer_couverture_amc(AIDCouvertureAMCLGPI in integer,
                                 AIDOrganismeAMC in integer,
                                 ALibelle in varchar2,
                                 AMontantFranchise in number,
                                 APlafondPriseEnCharge in number,
                                 ACouvertureCMU in char)
                                return integer;
                                
   procedure creer_taux_prise_en_charge(AIDCouvertureAMC in integer,
                                        APrestation in varchar2,
                                        ATaux in number,
             AFormule in varchar2);                               
                                
   /* ********************************************************************************************** */
  procedure ajuster_couvertures_amc; 
   /* ********************************************************************************************** */
   procedure maj_numero_lot(AIDDestinataire in integer,
                            ANumeroLot in  number);
 end;