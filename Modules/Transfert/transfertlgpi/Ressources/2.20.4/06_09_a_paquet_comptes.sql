create or replace package migration.pk_comptes as
  
  /* ********************************************************************************************** */
  function creer_compte(AIDCompteLGPI in integer,
                        ANom in varchar2,
                        AActivite in varchar2,
                        ARue1 in varchar2,
                        ARue2 in varchar2,
                        ACodePostal in varchar2,
                        ANomVille in varchar2,
                        ATelPersonnel in varchar2,
                        ATelStandard in varchar2,
                        ATelMobile in varchar2,
                        AFax in varchar2,										                
                        ADelaiPaiement in number,
                        AFinDeMois in char,
                        ACollectivite in char,
                        AIDProfilremise in integer,
                        AIDProfilEdition in integer,		                        										                
                        APayeur in char,
                        AIDClient in integer)
                       return integer;
  
  /* ********************************************************************************************** */
  procedure rattacher_client(AIDCompte in integer,
                             AIDClient in integer);
  /* ********************************************************************************************** */
  function creer_param_remise_fixe(AIDParamRemiseFixeLGPI in integer,
  																 ATaux in number)
  																return integer;
  
  /* ********************************************************************************************** */      
  function creer_profil_remise(AIDProfilRemiseLgpi in integer,
															 ALibelle in varchar2,
															 AArrondi in number,
															 ATypeArrondi in char,
														   AIDParamRemiseFixe in integer,
														   ATypeRemise in char,
														   ASurVenteDirecte in char,
														   ASurFactureCiale in char,
															 ASurFactureRetro in char,
															 ASurOrdonnance in char)
  													 return integer;
                       
end; 
/
