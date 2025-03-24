create or replace package migration.pk_clients as
  
  /* ********************************************************************************************** */
  procedure creer_couverture_amo_client(AIDClient integer,
                    AIDOrganismeAMO integer,
                    ACodeCouvertureAMO in char,
                                        ADebutDroitAMO in date,
                                        AFinDroitAMO in date,
                    ACentreGestionnaire in varchar2,
                                        AFusion in char);

  /* ********************************************************************************************** */
  function creer_client(AIDClientLGPI in integer,
                        ANumeroInsee in varchar2,
                        ANom in varchar2,
                        APrenom in varchar2,
                        ANomJeuneFille in varchar2,
                        ACommentaireGlobal in varchar2,
                        ACommentaireGlobalBloquant in char,
                        ACommentaireIndividuel in varchar2,
                        ACommentaireIndividuelBloquant in char,
                        ADateNaissance in varchar2,
                        AQualite in varchar2,
                        ARangGemellaire in number,
                        --ANatPieceJustifDroit in char,
                        ADateValiditePieceJustif in date,
                        AIDOrganismeAMO in integer,
                        --ACentreGestionnaire in varchar2,
                        AInformationsAMC in varchar2,
                        AIDOrganismeAMC in integer,
                        ANumeroAdherentMutuelle in varchar2,
                        --AContratSantePharma in varchar2,
                        AIDCouvertureAMC in integer,
                        ADebutDroitAMC in date,
                        AAttestationAMEComplementaire in char,
                        AFinDroitAMC in date,
                        --AMutuelleLueSurCarte in char,
                        ADateDerniereVisite in date,
                        AActivite in varchar2,
                        ARue1 in varchar2,
                        ARue2 in varchar2,
                        ACodePostal in varchar2,
                        ANomVille in varchar2,
                        ATelPersonnel in varchar2,
                        ATelStandard in varchar2,
                        ATelMobile in varchar2,
                        AFax in varchar2,
                        AEmail in varchar2,
                        ANumeroIdentifiantAMC in varchar2,
                        AModeGestionAMC in char,
                        AGenre in char,
                        AIDProfilRemise in integer,
                        ARefExterne in varchar2,
                        AFusion in char)
                       return integer;

  procedure rattacher_assure(AIDClient integer,
                             AIDAssure integer);

  procedure creer_mandataire(AIDClient integer,
                             AIDMandataire integer,
                             ATypeLien integer);
end; 
/
