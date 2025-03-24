set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_visiopharm_creer_medecin(
  AID integer,
  ANom varchar(50),   
  ACodeNational char(9),
  AAdresse1 varchar(50),  
  ACodePostal char(5),
  AVille varchar(50),  
  ATelephone char(12),
  AFax char(12),  
  ACommentaire varchar(200),  
	ACodeSpecialite varchar(3),
  AEMail varchar(100),
  ARPPS varchar(11)
)
as

declare variable intSpecialite integer;
declare variable strNom varchar(50);
declare variable strPrenom varchar(50);
declare variable strNJF varchar(50);

begin
  execute procedure ps_renvoyer_id_specialite(:ACodeSpecialite) returning_values :intSpecialite;
  execute procedure ps_separer_nom_prenom(:ANom, ' ') returning_values :strNom, :strPrenom, :strNJF;
    
  -- Créatioin du médecin
    insert into t_praticien(t_praticien_id,
                            type_praticien,
                            nom,
                            prenom,
                            rue_1,
                            code_postal,
                            nom_ville,
                            tel_standard,
                            fax,
                            t_ref_specialite_id,
                            no_finess,
                            num_rpps)
    values(:AID,
           '1',
           :strNom,
           :strPrenom,
           substring(:AAdresse1 from 1 for 40),
           :ACodePostal,
           substring(:AVille from 1 for 30),
           :ATelephone,
           :AFax,
           :intSpecialite,
           :ACodeNational,
           :ARPPS);

end;


/* ********************************************************************************************** */
create or alter procedure ps_visiopharm_creer_taux(
  ACouvertureAMO varchar(50), 
  ACouvertureAMC varchar(50),
  ACodeActe varchar(3),
  ATauxRemboursement smallint)
as
declare variable intPrestation integer;
begin 
  execute procedure ps_renvoyer_id_prestation(:ACodeActe) returning_values :intPrestation;
  
  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amo_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux)
  values(gen_id(seq_taux_prise_en_charge, 1),
         :ACouvertureAMO,
         :ACouvertureAMC,
         :intPrestation,
         :ATauxRemboursement);
end;


create or alter procedure ps_visiopharm_creer_organisme(
  AFlagAMO char,
  AFlagAMC char,
  AID integer,
  ANom varchar(70), 
  ACodeRegime char(2),
  ACodeCaisse char(3),
  ACodeCentre char(4),  
  AFlagCetip char,
  ACodePrefectoral varchar(10),
  AAdresse1 varchar(37),
  AAdresse2 varchar(37),
  ACodePostal char(5),
  AVille varchar(37),
  ATelephone char(10),
  AFax char(10),
  ARemarque varchar(500),
  ACommentaire varchar(500),
  ATauxCompl1 smallint,
  ATauxCompl2 smallint,
  ATauxCompl3 smallint,
  ATauxTips1 smallint,
  ATauxCompl4 smallint 
  )
as
declare variable intRegime integer;
begin
  execute procedure ps_renvoyer_id_regime(:ACodeRegime) returning_values :intRegime;


  if (AFlagAMO = 'T') then   
  insert into t_organisme(type_organisme,
                          t_organisme_id,
                          nom,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          t_ref_regime_id,
                          caisse_gestionnaire,
                          centre_gestionnaire,
                          commentaire)
  values(1,
         :AID,
         substring(:ANom from 1 for 50),
         :AAdresse1 ,
         :AAdresse2,
         :ACodePostal,
         substring(:AVille from 1 for 30), 
         :ATelephone,
         :AFax,
         :intRegime,
         :ACodeCaisse,
         :ACodeCentre,
         substring(:ARemarque||' , '||:ACommentaire from 1 for 200));
         
  if (AFlagAMC = 'T') then
  begin  
  /* creation de la mututelle */ 
    insert into t_organisme(type_organisme,
                          t_organisme_id,
                          nom,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          identifiant_national,
                          commentaire)
    values(2,
         :AID,
         substring(:ANom from 1 for 50),
         :AAdresse1,
         :AAdresse2,
         :ACodePostal,
         substring(:AVille from 1 for 30), 
         :ATelephone,
         :AFax,
         substring(:ACodePrefectoral from 1 for 8),
         substring(:ARemarque||' , '||:ACommentaire from 1 for 200));
         
         
    /* creation de la couverture par defaut meme ID que l'organisme*/ 
    insert into t_couverture_amc(t_couverture_amc_id,
                                 t_organisme_amc_id,
                                 libelle,
                                 montant_franchise,
                                 plafond_prise_en_charge,
                                 formule)
    values(:AID,
           :AID,
           substring(:ANom from 1 for 60),
           0,
           0,
           '021');
           
    
    /* et des taux */   
    /* ces taux viennent directemetn des caisses */
    /* possibilite d avoir des taux personalis‚s directement dans la fiche client FLAG CLIENT.TAUXSPECIAUX et CLIENTAY.TAUXSPECIAUX */ 
    
    execute procedure ps_visiopharm_creer_taux(null, :AID, 'PH4', :ATauxCompl1);
    execute procedure ps_visiopharm_creer_taux(null, :AID, 'PH7', :ATauxCompl2);
    execute procedure ps_visiopharm_creer_taux(null, :AID, 'PH1', :ATauxCompl3);
    execute procedure ps_visiopharm_creer_taux(null, :AID, 'PH2', :ATauxCompl4);    
    execute procedure ps_visiopharm_creer_taux(null, :AID, 'AAD', :ATauxCompl2);  
    execute procedure ps_visiopharm_creer_taux(null, :AID, 'PMR', :ATauxCompl2);  
  end              
         
end;


create or alter procedure ps_visiopharm_creer_couv_amo(
  AIDOrganismeAMO integer,
  AIDCouvertureAMO varchar(15), 
  ALibelle varchar(120),
  AAld char, 
  AJustifexo char,
  ABleue smallint,
  ABlanche smallint,
  ACent smallint,
  AOrange smallint
  )
as
begin

         
    /* creation de la couverture par defaut meme ID que l'organisme*/ 
    insert into t_couverture_amo(t_couverture_amo_id,
                                 t_organisme_amo_id,
                                 ald,
                                 libelle,
                                 justificatif_exo,
                                 nature_assurance
                                 )
    values(:AIDOrganismeAMO||'-'||:AIDCouvertureAMO||'-'||:AAld,
           :AIDOrganismeAMO,
           iif (:Aald = 'T','1','0'),
           iif (:Aald = 'T','ALD' , substring(:ALibelle from 1 for 50)),
           iif (:Aald = 'T',4,:AJustifexo),
           10
           );

    execute procedure ps_visiopharm_creer_taux(:AIDOrganismeAMO||'-'||:AIDCouvertureAMO||'-'||:AAld, null, 'PH4',  iif (:Aald = 'T',100,:ABleue));
    execute procedure ps_visiopharm_creer_taux(:AIDOrganismeAMO||'-'||:AIDCouvertureAMO||'-'||:AAld, null, 'PH7', iif (:Aald = 'T',100,:ABlanche));
    execute procedure ps_visiopharm_creer_taux(:AIDOrganismeAMO||'-'||:AIDCouvertureAMO||'-'||:AAld, null, 'PH1', iif (:Aald = 'T',100,:ACent));
    execute procedure ps_visiopharm_creer_taux(:AIDOrganismeAMO||'-'||:AIDCouvertureAMO||'-'||:AAld, null, 'PHN', 0);
    execute procedure ps_visiopharm_creer_taux(:AIDOrganismeAMO||'-'||:AIDCouvertureAMO||'-'||:AAld, null, 'PH2', iif (:Aald = 'T',100,:AOrange));           

end;

create or alter procedure ps_visiopharm_creer_assure (
AID integer,
ANom varchar(27),
APrenom varchar(27),
ANsecu varchar(15),
ARangGem smallint,
AQualite smallint,
AAdresse1 varchar(40),
AAdresse2 varchar(40),
ACodePostal varchar(5),
AVille varchar(40),
ATelephone varchar(10),
AIDOrganismeAMO integer,
ADateNaissance date,
ADateValiditeMutuelle date,
ANadherent varchar(16),
AIDOrganismeAMC integer,
ACommentaire varchar(1000),
ADateValiditeALD date,
AALD char,
ATypeRembt varchar(15),
ADateValiditeRembt date,
ACodeSituationBenef char(4),
AIdentMutuelle varchar(10),
ATelephone2 varchar(10)
)
as
declare variable strcentregestionnaire varchar(4);
declare variable strdatenaissance varchar(8);
begin

  select centre_gestionnaire from t_organisme where t_organisme_id = :AIDOrganismeAMO into :strCentreGestionnaire;

  strdatenaissance =  substring(:ADateNaissance from 9 for 2)||substring(:ADateNaissance from 6 for 2)||substring(:ADateNaissance from 1 for 4) ;

  /* Creation du client */
  insert into t_client(t_client_id,
                       numero_insee,
                       nom,
                       prenom,    
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       qualite,
                       rang_gemellaire,
                       date_naissance,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       t_organisme_amc_id,
                       t_couverture_amc_id,
                       fin_droit_amc,
                       numero_adherent_mutuelle,
                       commentaire_individuel,
                       tel_personnel,
                       tel_mobile)
  values(:AID,
         iif(:ANsecu<>'000000000000000',:ANsecu,null),
         :ANom,
         :APrenom,
         :AAdresse1,
         :AAdresse2,
         :ACodePostal,
         substring(:AVille from 1 for 30),
         :AQualite,
         :ARangGem,
         :strDateNaissance,
         :AIDOrganismeAMO,
         :strCentreGestionnaire,
         :AIDOrganismeAMC,
         :AIDOrganismeAMC,
         :ADateValiditeMutuelle,
         :ANadherent,
         substring(:ACommentaire from 1 for 200),
         :Atelephone,
         :Atelephone2
         
         );


 /* couv AMO */
     if (exists(select * from t_couverture_amo where t_couverture_amo_id = :AIDOrganismeAMO||'-'||:ATypeRembt||'-'||:AAld )) then
      insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                          t_client_id,
                                          t_couverture_amo_id,    
                                          fin_droit_amo)
      values(next value for seq_couverture_amo_client,
             :AID,
             :AIDOrganismeAMO||'-'||:ATypeRembt||'-'||:AAld,
             :ADateValiditeRembt);
 
    if ( :AAld = 'T' ) then          
      if (exists(select * from t_couverture_amo where t_couverture_amo_id = :AIDOrganismeAMO||'-'||:ATypeRembt||'-F' )) then
      insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                          t_client_id,
                                          t_couverture_amo_id,    
                                          fin_droit_amo)
      values(next value for seq_couverture_amo_client,
             :AID,
             :AIDOrganismeAMO||'-'||:ATypeRembt||'-F',
             :ADateValiditeRembt);
end;


create or alter procedure ps_visiopharm_creer_benef (
AIDAssur integer,
ANsecu varchar(15),
ADateNaissance date,
ARangGem smallint,
AQualite smallint,
AID integer,
ANom varchar(27),
APrenom varchar(27),
AAdresse1 varchar(60),
ACodePostal varchar(5),
AVille varchar(40),
ATelephone varchar(10),
ACommentaire varchar(1000),
AIDOrganismeAMC integer,
ANadherent varchar(16),
ADateValiditeMutuelle date,
ADateValiditeALD date,
ATypeRembt varchar(15),
ADateDernierPassage date,
ADateDroitSS date,
AALD char,
ACodeSituationBenef char(4),
AIdentMutuelle varchar(10),
ATelephone2 varchar(10),
AIDOrganismeAMO integer,
ANumeroCentre varchar(4)
)
as
declare variable strdatenaissance varchar(8);
begin
  
  strdatenaissance =  substring(:ADateNaissance from 9 for 2)||substring(:ADateNaissance from 6 for 2)||substring(:ADateNaissance from 1 for 4) ;

  /* Creation du client */
  insert into t_client(t_client_id,
                       numero_insee,
                       nom,
                       prenom,    
                       rue_1,
                       code_postal,
                       nom_ville,
                       qualite,
                       rang_gemellaire,
                       date_naissance,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       t_organisme_amc_id,
                       t_couverture_amc_id,
                       fin_droit_amc,
                       numero_adherent_mutuelle,
                       commentaire_individuel,
                       tel_personnel,
                       tel_mobile,
                       date_derniere_visite)
  values(:AID,
         iif(:ANsecu<>'000000000000000',:ANsecu,null),
         :ANom,
         :APrenom,
         substring(:AAdresse1 from 1 for 40),
         :ACodePostal,
         substring(:AVille from 1 for 30),
         :AQualite,
         :ARangGem,
         :strDateNaissance,
         :AIDOrganismeAMO,
         :ANumeroCentre,
         :AIDOrganismeAMC,
         :AIDOrganismeAMC,
         :ADateValiditeMutuelle,
         :ANadherent,
         substring(:ACommentaire from 1 for 200),
         :Atelephone,
         :Atelephone2,
         :ADateDernierPassage         
         );

 /* couv AMO */
     if (exists(select * from t_couverture_amo where t_couverture_amo_id = :AIDOrganismeAMO||'-'||:ATypeRembt||'-'||:AAld )) then
      insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                          t_client_id,
                                          t_couverture_amo_id,    
                                          fin_droit_amo)
      values(next value for seq_couverture_amo_client,
             :AID,
             :AIDOrganismeAMO||'-'||:ATypeRembt||'-'||:AAld,
             :ADateDroitSS);
             
    if ( :AAld = 'T' ) then          
      if (exists(select * from t_couverture_amo where t_couverture_amo_id = :AIDOrganismeAMO||'-'||:ATypeRembt||'-F' )) then
      insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                          t_client_id,
                                          t_couverture_amo_id,    
                                          fin_droit_amo)
      values(next value for seq_couverture_amo_client,
             :AID,
             :AIDOrganismeAMO||'-'||:ATypeRembt||'-F',
             :ADateDroitSS);
end;




/* ********************************************************************************************** */
create or alter procedure ps_visiopharm_creer_zonegeo(
ACodeGeo varchar(9),
AIntitule varchar(127))
as
begin
  insert into t_zone_geographique(t_zone_geographique_id,
                                 libelle)
  values(:ACodeGeo,
         substring( :AIntitule from 1 for 50));
end;


create or alter procedure ps_visiopharm_creer_fournisseur(
ACode varchar(8),
ANom varchar(32),
AAdresse1 varchar(36),
AAdresse2 varchar(36),
ACodePostal varchar(5),
AVille varchar(40),
ATelephone varchar(10),
AFax varchar(10),
AInterlocuteur varchar(40),
AModemTel varchar(10),
ACommentaire varchar(1000),
AIdPhcie varchar(8),
ATypeFournisseur char,
AEmail varchar(70),
ADirectExclusif char,
AServeurPML1 varchar(127),
AServeurPML2 varchar(127),
AUtilisateurPML varchar(32),
AMotDePassePML varchar(32),
AIDOfficinePML varchar(20),
AClePML varchar(4),
AIDRepartPML varchar(20),
ACodeRepartPML varchar(2)

)
as 
begin

	if (:ATypeFournisseur = 0 ) then
	begin
		-- Repartiteur
		insert into t_repartiteur ( t_repartiteur_id,
		                            raison_sociale,
		                            identifiant_171,
		                            numero_appel,
		                            commentaire,
		                            rue_1,
		                            rue_2,
		                            code_postal,
		                            nom_ville,
		                            tel_personnel,
		                            fax,
		                            email,
		                           	pharmaml_ref_id,
		                            pharmaml_url_1,
		                            pharmaml_url_2,
		                            pharmaml_id_officine,
		                            pharmaml_id_magasin,
		                            pharmaml_cle
		                            
		                                  ) 
		values (:ACode,  
						:ANom,
				    :AIdPhcie,
		        :AModemTel,
		        substring(:ACommentaire from 1 for 200),
		        :AAdresse1,
		        :AAdresse2,
		        :ACodePostal,
		        :AVille,
		        :ATelephone,
		        :AFax,
		        substring(:AEmail from 1 for 50),
		        :ACodeRepartPML,
		        :AServeurPML1,
		        :AServeurPML2,
		        :AIDOfficinePML,
		        null, --?
		        :AClePML                       
		        );
		        
		/* des parametres PharmaML incohenrent peuvent compromettre la reprise des rep -> insert simplifie */        
		when any  do		insert into t_repartiteur ( t_repartiteur_id,
		                            raison_sociale,
		                            identifiant_171,
		                            numero_appel,
		                            commentaire,
		                            rue_1,
		                            rue_2,
		                            code_postal,
		                            nom_ville,
		                            tel_personnel,
		                            fax,
		                            email  ) 
		values (:ACode,  
						:ANom,
				    :AIdPhcie,
		        :AModemTel,
		        substring(:ACommentaire from 1 for 200),
		        :AAdresse1,
		        :AAdresse2,
		        :ACodePostal,
		        :AVille,
		        :ATelephone,
		        :AFax,
		        substring(:AEmail from 1 for 50)                    
		        );       
		        
	end
	else
	begin
		-- Fournisseur d
		insert into t_fournisseur_direct ( t_fournisseur_direct_id,
		                                   raison_sociale,
		                                   identifiant_171,
		                                   numero_appel,
		                                   commentaire,
		                                   rue_1,
		                                   rue_2,
		                                   code_postal,
		                                   nom_ville,
		                                   tel_personnel,
		                                   fax,
		                                   represente_par,
		                                   email
		                                  ) 
		values (:ACode,
	          :ANom,  
		        :AIdPhcie,
		        :AModemTel,
		        substring(:ACommentaire from 1 for 200),
		        :AAdresse1,
		        :AAdresse2,
		        :ACodePostal,
		        :AVille,
		        :ATelephone,
		        :AFax,
		        :AInterlocuteur,
		        substring(:AEmail from 1 for 50)                         
		        );
	end

end;

create or alter procedure ps_visiopharm_creer_produit(
ACodeUv varchar(10),
ACodeProduit varchar(6),
ACip7 varchar(7),
AEan13 varchar(13),
AGtin13 varchar(13),
AIntituleCompletUV varchar(127),
APrixAchatOfficine float,
ARemise float, 
APrixPublic float,
ATauxTva float,
ABaseRemboursement float,
ACodeRegimeSS smallint,
AListe char,
AStockmaxi smallint, 
AStockmini smallint,
AQtestock smallint,
AQteReserve smallint,
APeremption date, 
ACodeCasier varchar(9),
ABlocage char,
ADerniereVente date,
ACodeLabo char,
ACodeActeB2 char(3),
ACodeinventorex char(2),
ACommentaire varchar(1000),
ABlocMin char,
APrixAchatCat float,
AMiniRayon smallint, 
AMaxiRayon smallint,
ABlocmax char
)
as
declare variable intTVA integer;
declare variable intPrestation integer;
declare variable t_depot_id dm_code;
begin

  if (:ATauxTVA > 19.6 ) then ATauxTVA = 19.6;

  execute procedure ps_renvoyer_id_tva(:ATauxTVA) returning_values :intTVA;
  execute procedure ps_renvoyer_id_prestation(:ACodeActeB2) returning_values :intPrestation;

  select t_depot_id from t_depot where libelle ='PHARMACIE' into :t_depot_id ;
  
  -- Produit
  insert into t_produit(t_produit_id,
                        code_cip,
                        designation,
                        liste,
                        t_ref_prestation_id,
                        date_derniere_vente,
                        type_homeo,
                        prix_achat_catalogue,
                        prix_vente,
                        base_remboursement,
                        t_ref_tva_id,
                        commentaire_vente,
                        date_peremption,
                        stock_mini,
                        stock_maxi)
  values (:ACodeUv,
          iif(:AEan13 similar to '340[01][[:DIGIT:]]{9}' ,:AEan13, :ACip7),
         substring(:AIntituleCompletUV from 1 for 50 ),        
         :AListe,
         :intPrestation,
         :ADerniereVente,
         iif(:ACodeLabo='0','0','2'), -- a trouver           
         coalesce(:APrixAchatCat,:APrixAchatOfficine,0) ,
         :APrixPublic,
         :ABaseRemboursement,
         :intTVA,
         substring(:ACommentaire from 1 for 200),
         :APeremption,
         :AStockMini,
         :AStockMaxi);

  -- Stocks
  insert into t_produit_geographique(t_produit_geographique_id,
                                     t_produit_id,
                                     t_zone_geographique_id,
                                     quantite,
                                     t_depot_id)
  values(next value for seq_produit_geographique,
         :ACodeUv,
         ( select t_zone_geographique_id  from t_zone_geographique where t_zone_geographique_id = :ACodeCasier),
         :AQteStock,
         :t_depot_id);
         
  -- reserve       
  if (AQtereserve > 0) then 
  insert into t_produit_geographique(t_produit_geographique_id,
                                     t_produit_id,
                                     t_zone_geographique_id,
                                     quantite,
                                     t_depot_id)
  values(next value for seq_produit_geographique,
         :ACodeUv,
         ( select t_zone_geographique_id  from t_zone_geographique where libelle = :ACodeCasier),
         :AQteStock,
         (select t_depot_id from t_depot where libelle ='RESERVE') );

  if ((:AEan13 similar to '[[:DIGIT:]]{13}' ) and (:AEan13 not similar to '340[01][[:DIGIT:]]{9}' )) then 
  insert into t_code_ean13(t_code_ean13_id,
                           t_produit_id,
                           code_ean13)
  values(next value for seq_code_ean13,
         :ACodeUv,
         :AEan13);

  if ( (:AGtin13 <> :AEan13) and  (:Agtin13 similar to '[[:DIGIT:]]{13}' ) and (:Agtin13 not similar to '340[01][[:DIGIT:]]{9}' )) then 
  insert into t_code_ean13(t_code_ean13_id,
                           t_produit_id,
                           code_ean13)
  values(next value for seq_code_ean13,
         :ACodeUv,
         :AGtin13);

end;

create procedure ps_visiopharm_creer_hist_entete(
AClient integer,
ADateOrdonnance date,  
ADateFacture date,   
ANFacture integer,
ANoPrescripteur varchar(9))
as
begin
  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  numero_facture,
                                  date_prescription,
                                  code_operateur,
                                  t_praticien_id,
                                  type_facturation,
                                  date_acte)
  values(:ANFacture,
         :AClient,
         :ANFacture,
         :ADateOrdonnance,
         '.',
         :ANoPrescripteur,
         '2',
         :ADateFacture);
end;

create or alter procedure ps_visiopharm_creer_hist_ligne (
  ANFacture integer,
  AProduit varchar(127),
  ACip varchar(7),
  AQuantite smallint,  
  APrix float
  )
as
begin
  if (AQuantite > 0) then
    insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                          t_historique_client_id,
                                          code_cip,
                                          designation,
                                          quantite_facturee,
                                          prix_vente)
    values(next value for seq_historique_client_ligne,
           :ANFacture,
           :ACip,
           substring(:AProduit from 1 for 50),
           :AQuantite,
           :APrix);
end;



/* ********************************************************************************************** */
create or alter procedure ps_visiopharm_creer_operateur (
ACodeVendeur smallint,
ANomVendeur varchar(20),
AMotPAsse varchar(16)
)
as
begin
  insert into t_operateur(t_operateur_id ,
                          nom,
                          mot_de_passe,
                          activation_operateur)
  values(:ACodeVendeur,
         :ANomVendeur,
         :AMotPasse,
         '1');
end;

create or alter procedure ps_visiopharm_creer_avance (
ANoAssure integer,
ACip varchar(7),
ADesignation varchar(127),
AQte smallint,  
ADateVignet date,
APrix float,
ACodeUV varchar(10),
ACodeVendeur varchar(6),
APrestation varchar(3),
ABaseRemboursement float
  )
as
begin

  /*  si operateur inexistant passage sur le premier op */
  if (not(exists(select t_operateur_id from t_operateur where t_operateur_id = :ACodeVendeur ))) then
  	select first 1 t_operateur_id from t_operateur into :ACodeVendeur;
  
				
        insert into t_vignette_avancee(t_vignette_avancee_id,
                                       t_client_id,
                                       date_avance,
                                       code_cip,
                                       designation,
                                       prix_vente,
                                       prix_achat,
                                       code_prestation ,
                                       t_produit_id,
                                       t_operateur_id,
                                       quantite_avancee,
                                       base_remboursement)
        values(next value for seq_vignette_avancee,
               :ANoAssure,
               :ADateVignet,
               :ACip,
               substring(:ADesignation from 1 for 50),
               :APrix,
               0.00,
               :APrestation,
               :ACodeUV,
               :ACodeVendeur,
               :AQte,
               :ABaseRemboursement);
end;


create or alter procedure ps_visiopharm_creer_histo_vente(
AIDproduit varchar(50),
AAnnee varchar(4),
AMois varchar(2),
AQte integer  )
as
begin
    /* periode = MMAAAA */
    if (:AQte >= 0) then
    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   periode,
                                   quantite_vendues,
                                   quantite_actes)
    values(next value for seq_historique_vente,
           :AIDproduit,
           lpad(:AMois,2,'0') || :AAnnee,
           :AQte,
           :AQte);

end;

/* ********************************************************************************************** */
create or alter procedure ps_visiopharm_creer_commande (
ANoCommande integer,
AEtat char,
ADateHeure date,
ADateLivraison date,
ACodeFournisseur varchar(50),
AMontantHT float,
ATypeFournis smallint
)
as

declare variable t_repartiteur_id varchar(50);
declare variable t_fournisseur_direct_id varchar(50);
declare variable type_commande char(1);
declare variable etat varchar(2);
begin

	if ( ATypeFournis is null ) then 
		if (exists(select t_repartiteur_id from t_repartiteur where t_repartiteur_id = :ACodeFournisseur)) then
			ATypeFournis = '0';
		 

  /* repartiteur */
  if ( ATypeFournis = '0' ) then
  begin
    t_repartiteur_id = ACodeFournisseur ;
    t_fournisseur_direct_id = null ;
    type_commande = '2' ;
    etat = '2' ;
  end
  else    /*  fournisseur */
  begin
    t_fournisseur_direct_id = ACodeFournisseur ;
    t_repartiteur_id = null ;
    type_commande = '1' ;
  end
  
  

  if (AEtat = '0' ) then etat = '2' ;
  /*if (flag_commande = '2' ) then etat = '22' ;*/
  if (AEtat = 'L' ) then etat = '3' ;

  insert into t_commande(t_commande_id,
                         type_commande,
                         date_creation,
                         date_reception,
                         mode_transmission,
                         montant_ht,
                         t_repartiteur_id,
                         t_fournisseur_direct_id,
                         etat)
  values(:ANoCommande,
         :type_commande,
         :ADateHeure,
         :ADateLivraison,
         '5',
         :AMontantHT,
         :t_repartiteur_id,
         :t_fournisseur_direct_id,
         :etat);
end;


create or alter procedure ps_visiopharm_creer_comm_ligne (
ANoCommande integer,
APrixAchatHT float,
AQteCmde integer,
AQteLivre integer,
AUniteGratuite integer,
ARemise float,
APrixAchatNet float,
ACodeUV varchar(10),
APrixVenteTTC float
  )
as
begin
  insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               prix_vente,
                               quantite_totale_recue,
                               unites_gratuites
                               )
  values(next value for seq_commande_ligne,
         :ANoCommande,
         :ACodeUV,
         :AQteCmde,
         :AQteLivre,
         :APrixAchatHT,
         :APrixAchatNet,
         :APrixVenteTTC,
         :AQteLivre,
         :AUniteGratuite
         );
end;


create or alter procedure ps_visiopharm_creer_credit(
  client_id varchar(50),
  date_credit date,
  montant float
  ) 
as
begin
  if (not(exists(select * from t_credit where t_client_id = :client_id or t_compte_id = :client_id)))  then
    insert into t_credit(t_credit_id,
               t_client_id,
               --t_compte_id,
               date_credit,
               montant)
    values(next value for seq_credit,
       :client_id,
       --:client_id,
       :date_credit,
       :montant);
  else     
    update t_credit
    set montant = montant + :montant
    where t_client_id = :client_id or t_compte_id =  :client_id ;    
     
end;

create or alter procedure ps_visiopharm_creer_document(
  ALibelle varchar(50),
  AFichier varchar(255))
as
declare variable numero_facture dm_code;
declare variable t_client_id dm_code;
begin
        
   -- scan ordo P-numerofacture-1.pdf     
  if (ALibelle like 'P-%-1.pdf') then
  begin
    numero_facture = replace(replace(ALibelle,'P-','') ,'-1.pdf','');   
    insert into t_document(t_document_id,
                           type_entite,
                           t_entite_id,
                           libelle,
                           document, 
                           commentaire)
    values(next value for seq_document,
           2, --doc client
           ( select t_client_id from t_historique_client where numero_facture = :numero_facture ),
           :ALibelle,
           :AFichier||:ALibelle,
           'Scan Ordonnance no '||:numero_facture);      
  end
  else 
  -- Attestation mutuelle numeroclient#page#.jpg
  if (ALibelle like '%#.jpg') then  
  begin 
    t_client_id = substring(ALibelle from 1 for position('_', ALibelle)-1 );
    insert into t_document(t_document_id,
                           type_entite,
                           t_entite_id,
                           libelle,
                           document, 
                           commentaire)
    values(next value for seq_document,
           2, --doc client
           :t_client_id,
           :ALibelle, 
           :AFichier||:ALibelle,
           'Attestation mutuelle');
  end  
end;