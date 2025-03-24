set sql dialect 3;

/* ********************************************************************************************** */
create or alter trigger trg_hop_mise_en_forme for t_hopital
active before insert or update position 0
as
begin
  new.nom = upper(new.nom);
end;

/* ********************************************************************************************** */
create or alter trigger trg_prat_verification for t_praticien
active before insert or update position 0
as
begin
  if ((new.prenom is null) or (new.prenom = '')) then
    new.prenom = '_';

  if ((new.t_hopital_id is null) or (new.t_hopital_id = '')) then
    new.t_hopital_id = null;
end;

/* ********************************************************************************************** */
create or alter trigger trg_prat_mise_en_forme for t_praticien
active before insert or update position 1
as
begin
  new.nom = upper(new.nom);
  new.prenom = upper(substring(new.prenom from 1 for 1 )) || lower(substring(new.prenom from 2 for char_length(new.prenom)-1 ));
end;

/* ********************************************************************************************** */
create or alter trigger trg_org_verification for t_organisme
active before insert or update position 1
as
begin
  if (new.t_destinataire_id = '') then
    new.t_destinataire_id = null;
  else
    if (new.t_destinataire_id is not null) then
      new.type_releve = '5';
    
  if ((new.nom_reduit = '') or (new.nom_reduit is null)) then
    new.nom_reduit = substring(new.nom from 1 for 20);

  if (new.type_contrat is null) then
  begin  
    if (new.identifiant_national = '88888888') then new.type_contrat = 88;
    if (new.identifiant_national = '99999997') then new.type_contrat = 89;  
  end
end;

/* ********************************************************************************************** */
create or alter trigger trg_org_mise_en_forme for t_organisme
active before insert or update position 0
as
begin
  new.nom = upper(new.nom);
  new.caisse_gestionnaire = lpad(new.caisse_gestionnaire, 3, '0');
  new.centre_gestionnaire = lpad(new.centre_gestionnaire, 4, '0');
end;

/* ********************************************************************************************** */
create or alter trigger trg_couvamo_verification for t_couverture_amo
active before insert or update position 0
as
declare variable chALD char(1);
begin
  if (new.t_ref_couverture_amo_id is not null) then
  begin
    select substring(code_couverture from 1 for 1)
    from t_ref_couverture_amo
    where t_ref_couverture_amo_id = new.t_ref_couverture_amo_id
    into :chALD;
        
    new.ald = iif(chALD = '1', '1', '0');
    if (new.ald = '1') then
      new.t_ref_couverture_amo_id = null;    
  end
end;

/* ********************************************************************************************** */
create or alter trigger trg_couvamo_mise_en_forme for t_couverture_amo
active before insert or update position 1
as
begin
  new.libelle = upper(new.libelle);
end;

/* ********************************************************************************************** */
create or alter trigger trg_couvamc_mise_en_forme for t_couverture_amc
active before insert or update position 1
as
begin
  new.libelle = upper(new.libelle);
end;

/* ********************************************************************************************** */
create or alter trigger trg_cli_verification for t_client
active before insert or update position 0
as
declare variable chModeGestion char(1);
declare variable chAttestationAMEcomplementaire char(1);
begin
  if ((new.prenom is null) or (new.prenom = '')) then
    new.prenom = '_';

   -- Cas 5 = ADRI mais remis à 0 car pas droit jorunalier donc pas besoin de la reprendre 
   if (new.nat_piece_justif_droit not in ('0', '1', '2', '4', ' ')) then
     new.nat_piece_justif_droit = '0';

  if (new.date_naissance = '') then
    new.date_naissance = null;

  if ((new.t_organisme_amo_id = '') or 
      (not(exists(select *
                  from t_organisme
                  where t_organisme_id = new.t_organisme_amo_id)))) then
    new.t_organisme_amo_id = null;

  if (new.t_organisme_at_id = '') then
    new.t_organisme_at_id = null;

  if (new.t_organisme_a115_id = '') then
    new.t_organisme_a115_id = null;

  if ((new.t_organisme_amc_id is null) or (new.t_organisme_amc_id = '') or 
      (not(exists(select *
                  from t_organisme
                  where t_organisme_id = new.t_organisme_amc_id)))) then
  begin
    new.t_organisme_amc_id = null;
    new.t_couverture_amc_id = null;
    new.debut_droit_amc = null;
    new.fin_droit_amc = null;
  end

  if ((new.t_couverture_amc_id is null) or (new.t_couverture_amc_id = '') or 
      (not(exists(select *
                  from t_couverture_amc
                  where t_couverture_amc_id = new.t_couverture_amc_id)))) then
  	begin
  		/* si la couverture n existe pas */
    	new.t_couverture_amc_id = null;
    	new.debut_droit_amc = null;
    	new.fin_droit_amc = null;
  	end
  else
  	begin
  	  	 /* mode gestion AMC */
  	  select iif(identifiant_national='99999997' or identifiant_national='27000000' or identifiant_national='75500017','1',new.mode_gestion_amc), 
  	         iif(identifiant_national='75500017','N',new.attestation_ame_complementaire)
  	  from t_organisme where t_organisme_id = new.t_organisme_amc_id
  	  into :chModeGestion,
  	       :chAttestationAMEcomplementaire; 
  	  
 	 
  	  new.mode_gestion_amc = chModeGestion;
  	  new.attestation_ame_complementaire = chAttestationAMEcomplementaire; 
  	  /* remplissage auto de date debut si vide */
    	if (new.debut_droit_amc is null) then
    		if (new.fin_droit_amc is not null) then
    	 		if (new.fin_droit_amc >= current_date) then
						/* si date valide force au 1 janv */   
      			new.debut_droit_amc = cast('01-01-' || (extract(year from current_date) - 1) as date );
       		else
        		new.debut_droit_amc = new.fin_droit_amc;	
        		
				/* incohérence sur les dates debut fin */
      	if (new.fin_droit_amc < new.debut_droit_amc) then
        	new.debut_droit_amc = new.fin_droit_amc;
  	end      
  

  if (not(exists(select *
                 from t_organisme
                 where t_organisme_id = new.t_organisme_at_id))) then
    new.t_organisme_at_id = null;
    
  if (not(exists(select *
                 from t_organisme
                 where t_organisme_id = new.t_organisme_a115_id))) then
    new.t_organisme_a115_id = null;

    if (new.t_assure_rattache_id = '') then
    new.t_assure_rattache_id = null;
       
  if ((new.rang_gemellaire is null) or (new.rang_gemellaire <= 0)) then
    new.rang_gemellaire = 1;
  else
    if (new.rang_gemellaire > 9) then
       new.rang_gemellaire = 9;  

  if ((new.numero_insee is null) or (new.numero_insee = '')) then
    new.qualite = 0;  
end;

/* ********************************************************************************************** */
create or alter trigger trg_cli_mise_en_forme for t_client
active before insert or update position 1
as
begin
  new.nom = upper(new.nom);
  new.prenom = upper(substring(new.prenom from 1 for 1 )) || lower(substring(new.prenom from 2 for char_length(new.prenom)-1 ));
  -- if ( new.numero_adherent_mutuelle similar to '[[:ALNUM:]]{8,}') then
  --   new.numero_adherent_mutuelle = trim(upper(new.numero_adherent_mutuelle));
  -- else 
  --   new.numero_adherent_mutuelle = null;
end;

/* ********************************************************************************************** */
create or alter trigger trg_couvcli_verification for t_couverture_amo_client
active before insert or update position 0
as
begin
  /* pas de date de debut */
  if (new.debut_droit_amo is null) then
      new.debut_droit_amo = cast('01-01-'||substring(current_date from 1 for 4)as date );
  /* incoherence date debut */
    if (new.fin_droit_amo is not null) then
      if (new.fin_droit_amo < new.debut_droit_amo) then
        new.debut_droit_amo = new.fin_droit_amo;
end;

/* ********************************************************************************************** */
create or alter trigger trg_op_verification for t_operateur
active before insert or update position 0
as
begin
  if ((new.code_operateur is null) or (new.code_operateur = '')) then
    new.code_operateur = new.t_operateur_id;
    
  if ((new.prenom is null) or (new.prenom = '')) then
    new.prenom = '_';
    
  if ((new.mot_de_passe is null) or (new.mot_de_passe = '')) then
    new.mot_de_passe = new.t_operateur_id;
end;

/* ********************************************************************************************** */
create or alter trigger trg_four_verification for t_fournisseur_direct
active before insert or update position 0
as
begin
  if ((new.monogamme is null) or (new.monogamme = '')) then
    new.monogamme = null;
end;

/* ********************************************************************************************** */
create or alter trigger trg_four_mise_en_forme for t_fournisseur_direct
active before insert or update position 1
as
begin
  new.raison_sociale = upper(new.raison_sociale);
end;

/* ********************************************************************************************** */
create or alter trigger trg_rep_verification for t_repartiteur
active before insert or update position 0
as
begin
  if (new.pharmaml_ref_id = 0) then
    new.pharmaml_ref_id = null;
    
  if ((new.monogamme is null) or (new.monogamme = '')) then
    new.monogamme = null;

  if ((new.t_reaffectation_manquants_id is null) or (new.t_reaffectation_manquants_id = '')) then
    new.t_reaffectation_manquants_id = null;
    
  if (new.defaut = '1') then
    update t_repartiteur
    set defaut = '0'
    where t_repartiteur_id <> new.t_repartiteur_id
      and defaut = '1';
  else
    new.defaut = '0';
end;

/* ********************************************************************************************** */
create or alter trigger trg_rep_mise_en_forme for t_repartiteur
active before insert or update position 1
as
begin
  new.raison_sociale = upper(new.raison_sociale);
end;

/* ********************************************************************************************** */
create or alter trigger trg_zonegeo_verification for t_zone_geographique
active before insert or update
position 0
as
begin
  if ((new.libelle = '') or (new.libelle is null)) then
    new.libelle = new.t_zone_geographique_id;
end;

/* ********************************************************************************************** */
create or alter trigger trg_cdf_verification for t_codification
active before insert or update
position 0
as
begin
  if ((new.libelle = '') or (new.libelle is null)) then
    new.libelle = new.code;
end;

/* ********************************************************************************************** */
create or alter trigger trg_prd_verification for t_produit
active before insert or update
position 0
as
begin
  if ((new.t_repartiteur_id  = '') or
      (not(exists(select *
                  from t_repartiteur
                  where t_repartiteur_id = new.t_repartiteur_id)))) then
    new.t_repartiteur_id = null;

	new.code_cip7 =  null; -- le champs existe mais ne doit plus etre utilisé
	
	--if ((char_length(trim(new.code_cip)) <= 7) and (new.code_cip7 is null)) 
  --then new.code_cip7 =  lpad(trim(new.code_cip) ,7,'0');
	
end;

/* ********************************************************************************************** */
create or alter trigger trg_prd_valeurs_defaut for t_produit
active before insert or update
position 1
as
declare variable flTauxTVA numeric(5,2);
declare variable chSoumisMDL char(1);
declare variable chCodeTaux char(1);
begin  
  new.designation = upper(new.designation);
  
  if (new.profil_gs is null) then new.profil_gs = '0';
  if (new.calcul_gs is null) then new.calcul_gs = '0';
  if ((new.stock_mini is null) or (new.stock_mini < 0)) then new.stock_mini = 0;
  if (new.stock_maxi < new.stock_mini) then 
    if (new.calcul_gs = '4') then 
      new.stock_maxi = 99;
    else 
      new.stock_maxi = null;
  
  select taux, soumis_mdl
  from t_ref_tva
  where t_ref_tva_id = new.t_ref_tva_id
  into :flTauxTVA, :chSoumisMDL;
  
  if (row_count = 0) then
    flTauxTVA = 0;
  
  if ((new.pamp is null) or (new.pamp >= (new.prix_vente * (100 - flTauxTVA) / 100))) then
    if ((new.prix_achat_catalogue > new.prix_vente) and (new.prix_vente >= 0.1)) then
      new.pamp = (new.prix_vente * (100 - flTauxTVA) / 100) - 0.1;
    else
      new.pamp = new.prix_achat_catalogue;
        
  if (new.soumis_mdl is null) then
    if ((flTauxTVA is not null) and (new.t_ref_prestation_id is not null)) then
    begin      
      select code_taux
      from t_ref_prestation
      where t_ref_prestation_id = new.t_ref_prestation_id
      into chCodeTaux;
            
      if ((chSoumisMDL = '1') and (chCodeTaux <> '0')) then
        new.soumis_mdl = '1';
      else
        new.soumis_mdl = '0'; 
    end
    else
      new.soumis_mdl = '0';
    
  if (new.tarif_achat_unique is null) then
    if (new.soumis_mdl = '1') then
      new.tarif_achat_unique = '1';
    else
      new.tarif_achat_unique = '0';          
      
  if (new.prix_achat_remise is null) then
    new.prix_achat_remise = new.prix_achat_catalogue;
  else
    if (new.prix_achat_catalogue < new.prix_achat_remise) then
      new.prix_achat_catalogue = new.prix_achat_remise;
      
  -- Vrification de la "positivit" des prix
  if ((new.prix_vente = new.base_remboursement) or (new.base_remboursement < 0)) then new.base_remboursement = 0;
  if (new.prix_achat_remise < 0) then new.prix_achat_remise = 0;
  if (new.pamp < 0) then new.pamp = 0;
  if (new.prix_achat_catalogue < 0) then new.prix_achat_catalogue = 0;
  if (new.prix_vente < 0) then new.prix_vente = 0;
  if (new.prix_achat_metropole is null) then new.prix_achat_metropole = new.prix_achat_catalogue;
  if (new.prix_vente_metropole is null) then new.prix_vente_metropole = new.prix_vente;
end;

/* ********************************************************************************************** */
create or alter trigger trg_prdgeo_verification for t_produit_geographique
active before insert or update position 0
as
begin
  if ((new.t_zone_geographique_id = '') or
      (not(exists(select *
                  from t_zone_geographique
                  where t_zone_geographique_id= new.t_zone_geographique_id)))) then
    new.t_zone_geographique_id = null;

  if (new.quantite < 0) then
    new.quantite = 0;
    
  if (new.stock_mini is null) then
    new.stock_mini = 0;

    if (new.stock_maxi is null) then
    new.stock_maxi = 0;
end;

/* ********************************************************************************************** */
create or alter trigger trg_histclilig_verification for t_historique_client_ligne
active before insert or update position 0
as
begin
  if (char_length(trim(new.code_cip)) < 7) then new.code_cip =  lpad(trim(new.code_cip) ,7,'0');
end;

/* ********************************************************************************************** */
create or alter trigger trg_code_tips for t_produit_lpp
active before insert or update position 0
as
begin
  if ( (new.type_code = 2 ) and (char_length(new.code_lpp)>6) and ( new.code_lpp not like '%.%')  ) then 
  	new.code_lpp = substring(new.code_lpp from 1 for 6)||'.'||substring(new.code_lpp from 7 for 6);    
end;

/* ********************************************************************************************** */
create or alter trigger trg_commentaire for t_commentaire
active before insert or update position 0
as
begin
  if (new.type_entite = '0') then
    if (not exists(select *
                 from t_client
           where t_client_id = new.t_entite_id)) then
      exception exp_com_entite_inconnue 'Client inconnu !';
  else if (new.type_entite = '1') then
    if (not exists(select *
                 from t_fournisseur_direct
           where t_fournisseur_direct_id = new.t_entite_id)) then
      exception exp_com_entite_inconnue 'Fournisseur inconnu !';           
  else if (new.type_entite = '2') then
    if (not exists(select *
                 from t_repartiteur
           where t_repartiteur_id = new.t_entite_id)) then
      exception exp_com_entite_inconnue 'Répartiteur inconnu !';    
end;