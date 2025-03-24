create or replace package migration.pk_commun as
  
  type tab_identifiants is table 
    of integer index by varchar2(55);

	type rec_options is record(
    praticiens_creer_si_inexistant char(1),
    produits_fusionner_stock char(1));
		
	type rec_prestation is record(
    id integer,
    code_taux char(1),
    est_tips char(1),
    est_lpp char(1));
	
	Options rec_options;
	
	C_MODE_NORMAL constant integer := 0;
	C_MODE_MISE_A_JOUR constant integer := 1;
	C_MODE_FUSION constant integer := 2;
	
	type tab_prestations is table
		of rec_prestation index by varchar(4);  
  
	Prestations tab_prestations;
	Activites tab_identifiants;
	Qualites tab_identifiants;	      
  
	IDQualiteAssure integer;
	IDTVA0 integer;
	IDSpecialiteGeneraliste integer;
	--IDPrestationMX1 integer;
	IDPrestationPHN integer;
	IDOperateurPoint integer;
	IDPoste0 integer;
	IDTiroirCaissePoste0 integer;
	IDDeviseEuro integer;
	IDModeReglementCredit integer;IDProfilEditionDefaut integer;
  
  
  function creer_adresse(ARue1 in varchar2,
                         ARue2 in varchar2,
                         ACodePostal in char,
                         ANomVille in varchar2,
                         ATelPersonnel in varchar2,
                         ATelStandard in varchar2,
                         ATelMobile in varchar2,
                         AAdresseMail in varchar2,
                         AFax in varchar2,
                         ACodePays in varchar2)
                        return integer;

  procedure initialiser_transfert(AOptions in rec_options,
                                  AMode in integer,
                                  ASuppressionTableTMP in char);
								  
  procedure initialiser_transfert; 
  
  IDCanevasFacture integer;  
end; 
/
