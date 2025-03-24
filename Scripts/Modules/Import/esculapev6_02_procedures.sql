set sql dialect 3;

create exception exp_esculape_debug 'debug';

create or alter procedure ps_supprimer_donnees_modules(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 101) then
  begin
    delete from t_esculapev6_org_couv_amc;
  end
  else
    if (ATypeSuppression = 102) then
    begin
      delete from t_esculapev6_taux_tva;
      delete from t_esculapev6_acte;
    end
    else
      if (ATypeSuppression = 103) then
      begin
        delete from t_esculapev6_specialite;
      end
	  else
      if (ATypeSuppression = 104) then
      begin
            delete from t_historique_client;
            delete from t_document;
      end
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_medecin(
  id integer,
  finess varchar(9),
  nom varchar(50),
  prenom varchar(30),
  rue varchar(80),
  codepostal varchar(5),
  ville varchar(40),
  telephone varchar(20),  
  specialite smallint, 
  rpps varchar(11),
  telephone2 varchar(20), 
  email varchar(200) 
  )
as
declare variable c varchar(2);
declare variable intSpecialite integer;
begin
  execute procedure ps_renvoyer_id_specialite(:specialite) returning_values :intSpecialite;
   
  insert into t_praticien(t_praticien_id,
                          nom,
                          prenom,
                          t_ref_specialite_id,
                          rue_1,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          tel_personnel,
                          no_finess, 
                          num_rpps,
                          commentaire)
  values(:id,
         :nom,
         :prenom,
         :intSpecialite,
         substring(:rue from 1 for 40 ),
         iif( :codepostal = '00000' and :ville <= '9' , (select first 1 Avaleur from ps_separer_valeurs(:ville,' ') where avaleur > '00000' ),:codepostal),
         iif( :codepostal = '00000' and :ville <= '9' , (select first 1 skip 1 Avaleur from ps_separer_valeurs(:ville,' ') where avaleur > '00000' ), substring(:ville from 1 for 30)),
         :telephone,
         :telephone2,
         :finess,
         :rpps,
         :email
         );
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_dest(
  ADestinataire integer,
  ANom varchar(40),
  AMessage varchar(37),
  ANum_Ident varchar(40),
  AMot_Passe varchar(40),
  AServ_Smtp varchar(40),
  AServ_Pop3 varchar(40),
  ANo_Appel varchar(14),
  AEmail_Oct varchar(40),
  ANom_Util varchar(40),
  AAdresse_Bal varchar(40))
as
begin
  insert into t_destinataire(t_destinataire_id,
                             nom,
                             commentaire,
                             num_ident,
                             mot_passe,
                             serv_smtp,
                             serv_pop3,
                             no_appel,
                             email_oct,
                             nom_util,
                             adresse_bal)
  values(:ADestinataire,
         :ANom,
         :AMessage,
         :ANum_Ident,
         :AMot_Passe,
         :AServ_Smtp,
         :AServ_Pop3,
         :ANo_Appel,
         :AEmail_Oct,
         :ANom_Util,
         :AAdresse_Bal);
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_org_amo(
  AOrganisme integer,
  ANom varchar(80),
  ANomReduit varchar(20),
  AVitale varchar(9),
  ARue varchar(80),
  ACP varchar(5),
  ANomVille varchar(40),
  ATelephone varchar(20),
  AFax varchar(20),
  ADestinataire integer)
as
declare variable intRegime integer;
begin
  if ((ANom is null) or (ANom = '')) then
    ANom = AOrganisme;

  execute procedure ps_renvoyer_id_regime(substring(:AVitale from 1 for 2)) returning_values intRegime;

  insert into t_organisme(type_organisme,
                          t_organisme_id,
                          nom,
                          nom_reduit,
                          rue_1,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          t_ref_regime_id,
                          caisse_gestionnaire,
                          centre_gestionnaire,
                          t_destinataire_id)
  values('1',
         'P' || '-' || :AOrganisme,
         substring(:ANom from 1 for 50 ),
         :ANomReduit,
         substring(:Arue from 1 for 40 ),
         lpad(:ACp, 5, '0'),
         substring(:ANomVille from 1 for 30),
         :ATelephone,
         :AFax,
         :intRegime,
         substring(:AVitale from 3 for 3),
         substring(:AVitale from 6 for 4),
         nullif(:ADestinataire, 0));
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_org_amc (
  AOrganisme dm_code,
  ANom varchar(80),
  ANomReduit varchar(50),
  AIdentifiantNational varchar(10),
  AContrat smallint,
  ARue varchar(80),
  ACP varchar(5),
  ANomVille varchar(40),
  ATelephone varchar(20),
  AFax varchar(20),
  ADestinataire integer,
  ACodeRemboursement integer)
as
declare variable strOrganismeID varchar(50);
begin
  if ((ANom is null) or (ANom = '')) then
    ANom = AOrganisme;

  if (char_length(AIdentifiantNational)= 10 ) then
  begin
   if (substring(AIdentifiantNational from 1 for 2) = '00')   then
      AIdentifiantNational =  substring(:AIdentifiantNational from 3 for 8) ;
   else
      AIdentifiantNational =  substring(:AIdentifiantNational from 2 for 9) ;
  end
  else
   AIdentifiantNational =  substring(:AIdentifiantNational from 1 for 9) ;

  /* --- Insertion des Organismes AMC --- */
  strOrganismeID = 'M' || '-' || AOrganisme;
  insert into t_organisme(type_organisme,
                          t_organisme_id,
                          nom,
                          nom_reduit,
                          rue_1,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          identifiant_national,
                          type_contrat,
                          t_destinataire_id)
  values('2',
         :strOrganismeID,
         substring(:ANom from 1 for 50),
         substring(:ANomReduit from 1 for 20),
         substring(:Arue from 1 for 40 ),
         :ACp,
         substring(:ANomVille from 1 for 30),
         :ATelephone,
         :AFax,
         :AIdentifiantNational,
         coalesce(nullif(:AContrat, 0), 0),
         nullif(:ADestinataire, 0));

  insert into t_esculapev6_org_couv_amc(t_organisme_amc_id,
                                      code_remboursement)
  values(:strOrganismeID,
         :ACodeRemboursement);
     
     
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_taux_couv(
  ACouvertureAMO varchar(50),
  ACouvertureAMC varchar(50),
  APrestation varchar(3),
  ATaux integer)
as
declare variable intPrestation integer;
declare variable t integer;
begin
  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;

  if (ACouvertureAMO is not null) then
    insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                       t_couverture_amo_id,
                                       t_ref_prestation_id,
                                       taux)
    values(next value for seq_taux_prise_en_charge,
           :ACouvertureAMO,
           :intPrestation,
           :ATaux);
  else
    insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                       t_couverture_amc_id,
                                       t_ref_prestation_id,
                                       taux)
    values(next value for seq_taux_prise_en_charge,
           :ACouvertureAMC,
           :intPrestation,
           :ATaux);
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_couv_amo(
  AGrandRegime integer,
  ACodeSituation integer,
  ARisque integer)
as
declare variable intRegime integer;
declare variable intCouvertureRef integer;
declare variable o varchar(50);
declare variable c varchar(50);
begin
  if (ARisque <> 0) then
  begin
    execute procedure ps_renvoyer_id_regime(:AGrandRegime) returning_values :intRegime;
    if (intRegime is not null) then
      for select t_organisme_id
          from t_organisme
          where t_ref_regime_id = :intRegime
          into o do
      begin
        execute procedure ps_renvoyer_id_couv_amo_ref(lpad(:ACodeSituation, 5, '0')) returning_values :intCouvertureRef;

        c = o || '-' || ARisque || '-' || ACodeSituation;
        insert into t_couverture_amo(t_couverture_amo_id,
                                     t_organisme_amo_id,
                                     ald,
                                     libelle,
                                     t_ref_couverture_amo_id)
         values(:c,
                :o,
                '0',
                :c,
                :intCouvertureRef);
      end
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_maj_couv_amo(
  ARisque integer,
  ANatureAssurance varchar(2),
  AJustificatifExo char(1),
  ALibelle varchar(15))
as
begin
  if (ANatureAssurance <> '00') then
  begin
      ANatureAssurance =  iif(:ANatureAssurance in ('10', '13','30', '41', '90') ,:ANatureAssurance , '10');
      if ((upper(Alibelle) like 'AM %' ) or ( upper(Alibelle) like 'ALSACE %')) then ANatureAssurance = 13 ;
      update t_couverture_amo
      set nature_assurance =  :ANatureAssurance ,
          justificatif_exo = :AJustificatifExo,
          libelle = :ALibelle,
          ald = iif(:AJustificatifExo = '4', '1', '0')
      where t_couverture_amo_id like '%-' || :ARisque || '-%' ;
    end
  else
    delete from t_couverture_amo
    where t_couverture_amo_id like '%-' || :ARisque || '-%' ;
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_couv_amc(
  ACodeRemboursement integer,
  ALibelle varchar(255),
  APH1 varchar(3), 
  APH2 varchar(3),  
  APH4 varchar(3),
  APH7 varchar(3),
  AAAD varchar(3),
  APMR varchar(3)
)
as
declare variable strOrganismeID varchar(50);
begin

   insert into t_couverture_amc(t_organisme_amc_id,
                                 t_couverture_amc_id,
                                 libelle,
                                 montant_franchise,
                                 plafond_prise_en_charge,
                                 formule)
    values(null,
           cast(:ACodeRemboursement as varchar(50)),
           :ALibelle,
           0,
           0,
           '02A');

    execute procedure ps_esculapev6_creer_taux_couv(null, :ACodeRemboursement, 'PH4', APH4);
    execute procedure ps_esculapev6_creer_taux_couv(null, :ACodeRemboursement, 'PH7', APH7);
    execute procedure ps_esculapev6_creer_taux_couv(null, :ACodeRemboursement, 'PH1', APH1);
    execute procedure ps_esculapev6_creer_taux_couv(null, :ACodeRemboursement, 'PH2', APH2);
    execute procedure ps_esculapev6_creer_taux_couv(null, :ACodeRemboursement, 'AAD', AAAD);
    execute procedure ps_esculapev6_creer_taux_couv(null, :ACodeRemboursement, 'PMR', APMR);


end;

/* ********************************************************************************************** */
create or alter procedure ps_convertir_entier_vers_date(
  AInDate integer)
returns(
  AOutDate date)
as
declare variable d varchar(8);
begin
  d = cast(AInDate as varchar(8));
  AOutDate = cast(substring(d from 1 for 4) || '-' ||
                  substring(d from 5 for 2) || '-' ||
				  substring(d from 7 for 2) as date);

  when any do
    AOutDate = null;  
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_couv_amo_cl(
  AClient integer,
  AOrganismeAMO varchar(50),
  ARisque smallint,
  ADebutDroitAMO integer,
  AFinDroitAMO integer,
  AAld integer)
as
declare variable d date;
declare variable d2 date;
declare variable dd date;
declare variable fd date;
declare variable cli varchar(50);
declare variable c varchar(50);
begin
  execute procedure ps_convertir_entier_vers_date(ADebutDroitAMO) returning_values :dd;
  execute procedure ps_convertir_entier_vers_date(AFinDroitAMO) returning_values :fd;
 
  if (( aald = 1  ) and ( ARisque = 1)) then
    select first 1 t_couverture_amo_id
    from t_couverture_amo
    where t_organisme_amo_id = :AOrganismeAMO
      and justificatif_exo = 4
    into :c;
  else
    select t_couverture_amo_id
    from t_couverture_amo
    where t_organisme_amo_id = :AOrganismeAMO
      and t_couverture_amo_id like :AOrganismeAMO || '-' || :ARisque || '-%' 
    into :c;

  if (row_count > 0) then
  begin
    cli = cast(AClient as varchar(50));
  
 --   select debut_droit_amo,fin_droit_amo
--    from t_couverture_amo_client
--    where t_client_id = :cli
 --     and t_couverture_amo_id = :c
 --   into d2, d;
      
    fd = nullif(fd, '1899-12-30');    
--if (row_count = 0) then
	begin
	 insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                          t_client_id,
                                          t_couverture_amo_id,
										  debut_droit_amo,
                                          fin_droit_amo)
      values(next value for seq_couverture_amo_client,
             :cli,
             :c,
			 :dd,
             :fd);
	 -- cas speciaux ALD + INV ... on ajoute une couv ALD
	 if (( aald = 1  ) and ( ARisque <> 1)) then 
	 begin
		select first 1 t_couverture_amo_id
		from t_couverture_amo
		where t_organisme_amo_id = :AOrganismeAMO
		  and justificatif_exo = 4
		into :c;
		
		insert into t_couverture_amo_client(t_couverture_amo_client_id,
										  t_client_id,
										  t_couverture_amo_id,
										  debut_droit_amo,
										  fin_droit_amo)
		values(next value for seq_couverture_amo_client,
			 :cli,
			 :c,
			 :dd,
			 :fd);
	 end 
	end		 
 --   else
--if (fd < d) then
 --       update t_couverture_amo_client
  --      set debut_droit_amo = :d2,
--			fin_droit_amo = :d
 --       where t_client_id = :cli
  --        and t_couverture_amo_id = :c;
  end
end;



/* **************************************************************** */

create or alter procedure ps_esculapev6_creer_couv_amc2(
  AOrganismeAMCID varchar(50),
  AContratTypeID integer)
as
declare variable strCouvertureRefID varchar(50);
declare variable strCouvertureID varchar(50);
begin
  strCouvertureRefID = cast(:AContratTypeID as varchar(50));
  if (exists(select *
             from t_couverture_amc
             where t_couverture_amc_id = :strCouvertureRefID)) then
  begin
    strCouvertureID = :AOrganismeAMCID || '_' || :strCouvertureRefID;
    if (not (exists(select *
                    from t_couverture_amc
                    where t_couverture_amc_id = :strCouvertureID))) then
    begin
      insert into t_couverture_amc(t_couverture_amc_id,
                                   t_organisme_amc_id,
                                   libelle,
                                   montant_franchise,
                                   plafond_prise_en_charge,
                                   formule)
      select :strCouvertureID,
             :AOrganismeAMCID,
             libelle,
             montant_franchise,
             plafond_prise_en_charge,
             formule
      from t_couverture_amc
      where t_couverture_amc_id = :strCouvertureRefID;


      insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                         t_couverture_amo_id,
                                         t_couverture_amc_id,
                                         t_ref_prestation_id,
                                         taux)
      select next value for seq_taux_prise_en_charge,
             null,
             :strCouvertureID,
             t_ref_prestation_id,
             taux
      from t_taux_prise_en_charge
      where t_couverture_amc_id = :strCouvertureRefID;
    end
  end

end;





/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_client (
  AClient integer,
  ANSSAssure varchar(15),
  ANSS varchar(15),
  ANom varchar(50),
  APrenom varchar(50),
  ARue1 varchar(60),
  ACP varchar(5),
  ANomVille varchar(40),
  ATelephone varchar(20),
  ADateNaissance integer,
  ARang smallint,
  AQualite smallint,
  AOrgAMO integer,
  ACentre integer,
  ACouvertureAMO1 smallint,
  ASesam1 smallint,
  AAld1 integer,
  ADebutdroitAMO1 integer,
  AFindroitAMO1 integer,
  ACouvertureAMO2 smallint,
  ASesam2 smallint,
  AAld2 integer,
  ADebutdroitAMO2 integer,
  AFindroitAMO2 integer,
  ACouvertureAMO3 smallint,
  ASesam3 smallint,
  AAld3 integer,
  ADebutdroitAMO3 integer,
  AFindroitAMO3 integer,
  AOrgAMC1 integer,
  AContratAMC1 integer,
  ADebutAMC1 integer,
  AFinAMC1 integer,
  AAdherentAMC1 varchar(16),
  AOrgAMC2 integer,
  AContratAMC2 integer,
  ADebutAMC2 integer,
  AFinAMC2 integer,
  AAdherentAMC2 varchar(16),  
  AOrgAMC3 integer,
  AContratAMC3 integer,
  ADebutAMC3 integer,
  AFinAMC3 integer,
  AAdherentAMC3 varchar(16),    
  ADateDerniereVisite integer,
  ACollectivite integer,
  AScanID integer)
as
declare variable strOrganismeAMO varchar(50);
declare variable strOrganismeAMC varchar(50);
declare variable strCouvertureAMC varchar(50);
declare variable dtDebutAMC1 date;
declare variable dtFinAMC1 date;
declare variable dtDebutAMC2 date;
declare variable dtFinAMC2 date;
declare variable debut date;
declare variable fin date;
declare variable strAdherent varchar(16);
declare variable ddv date;
declare variable dn varchar(8);
begin 
  execute procedure ps_convertir_entier_vers_date(:ADateDerniereVisite) returning_values :ddv;
  strOrganismeAMO = 'P-' || AOrgAMO;
  
  -- Date de naissance
  dn = substring(ADateNaissance from 7 for 2) || substring(ADateNaissance from 5 for 2) || substring(ADateNaissance from 1 for 4);
  
  /* --- Insertion des Clients --- */
  execute procedure ps_convertir_entier_vers_date(ADebutAMC1) returning_values :dtDebutAMC1;
  execute procedure ps_convertir_entier_vers_date(AFinAMC1) returning_values :dtFinAMC1;
  execute procedure ps_convertir_entier_vers_date(ADebutAMC2) returning_values :dtDebutAMC2;
  execute procedure ps_convertir_entier_vers_date(AFinAMC2) returning_values :dtFinAMC2;
  
--  if (AFinAMC2 > AFinAMC1) then
--  begin
--    debut = dtDebutAMC2;
--	fin = dtFinAMC2;
--	strOrganismeAMC = 'M-' || AOrgAMC2;
--    strAdherent = AAdherentAMC2;
--  end
--  else
  if ( AOrgAMC1 <> 0) then
  begin
    debut = dtDebutAMC1;
	fin = dtFinAMC1;
	strOrganismeAMC = 'M-' || AOrgAMC1;
    strAdherent = AAdherentAMC1; 
	strCouvertureAMC = strOrganismeAMC ||'_'||AContratAMC1;
    execute procedure ps_esculapev6_creer_couv_amc2(:strOrganismeAMC, :AContratAMC1); 	
  end


   
  insert into t_client(t_client_id,
                       numero_insee,
                       qualite,
                       nom,
                       prenom,
                       date_naissance,
                       rang_gemellaire,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_personnel,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       t_organisme_amc_id,
                       t_couverture_amc_id,
                       debut_droit_amc,
                       fin_droit_amc,
                       numero_adherent_mutuelle,
                       date_derniere_visite)
  values(:AClient,
         iif(:AQualite <> '0', :ANSSAssure, :ANSS),
         :AQualite,
         substring(:ANom from 1 for 30),
         substring(:APrenom from 1 for 30),
         :dn,
         :ARang,
         substring(:ARue1 from 1 for 40 ),
         substring(:ARue1 from 40 for 40 ),
         :ACP,
         :ANomVille,
         :ATelephone,
         :strOrganismeAMO,
         :ACentre,
         :strOrganismeAMC,
         :strCouvertureAMC,
         nullif(:debut, '1899-12-30'),
         nullif(:fin, '1899-12-30'),
         :strAdherent,
         :ddv);

  if ( :AFinDroitAMO1 > 0 ) then 
    execute procedure ps_esculapev6_creer_couv_amo_cl(:AClient, :strOrganismeAMO, :ACouvertureAMO1, :ADebutDroitAMO1, :AFinDroitAMO1, :AAld1);
  if ( :AFinDroitAMO2 > 0 ) then
    execute procedure ps_esculapev6_creer_couv_amo_cl(:AClient, :strOrganismeAMO, :ACouvertureAMO2, :ADebutDroitAMO2,  :AFinDroitAMO2, :AAld2);
  if ( :AFinDroitAMO3 > 0 ) then
    execute procedure ps_esculapev6_creer_couv_amo_cl(:AClient, :strOrganismeAMO, :ACouvertureAMO3, :ADebutDroitAMO3,  :AFinDroitAMO3, :AAld3);
  
  if ( :ACollectivite > 0 ) then
  begin
  if (not(exists(select t_compte_id from t_compte where t_compte_id = :ACollectivite))) then
  begin
      insert into t_compte (t_compte_id , 
                  nom, 
                  collectif )
      values(:ACollectivite, 
           'mettre a jour',
           1 ); 
  end
    
  insert into t_compte_client values ( next value for seq_compte_client , :ACollectivite ,:AClient );
  end
  

     
  insert into t_esculapev6_scan(t_client_id,
                                t_document_id)
  values(:AClient,
         :AScanID);
  
end;


create or alter procedure ps_esculapev6_maj_comptes 
as
begin
  update t_compte cpt
  set cpt.nom = 
  coalesce( ( select substring(cli.nom||' '||cli.prenom from 1 for 30) from t_client cli where cli.t_client_id = cpt.t_compte_id ) , 'PAS DE NOM' ),
    cpt.rue_1 = ( select cli.rue_1 from t_client cli where cli.t_client_id = cpt.t_compte_id ),
    cpt.rue_2 = ( select cli.rue_2 from t_client cli where cli.t_client_id = cpt.t_compte_id ),
    cpt.tel_standard = ( select cli.tel_personnel from t_client cli where cli.t_client_id = cpt.t_compte_id ),
    cpt.code_postal = ( select cli.code_postal from t_client cli where cli.t_client_id = cpt.t_compte_id ),
    cpt.nom_ville = ( select cli.nom_ville from t_client cli where cli.t_client_id = cpt.t_compte_id )
  where t_compte_id in (select t_compte_id from T_COMPTE where nom = 'mettre a jour' );
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_fournisseur(
  type smallint,
  code integer,
  nom varchar(80),
  rue varchar(80),
  codepostal char(5),
  ville varchar(40),
  telfour varchar(20),
  faxfour varchar(20),
  representant varchar(40))
as
begin
  if (type = '0') then
    insert into t_repartiteur(t_repartiteur_id,
                              raison_sociale,
                              rue_1,
                rue_2,
                              code_postal,
                              nom_ville,
                              tel_standard,
                              fax)
    values(:code,
           substring(:nom from 1 for 50),
           substring(:rue from 1 for 40),
           substring(:rue from 40 for 40),
           :codepostal,
           substring(:ville from 1 for 30),
           :telfour,
           :faxfour);
  if (type in ('1', '2')) then
    insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                     raison_sociale,
                                     rue_1,
                   rue_2,
                                     code_postal,
                                     nom_ville,
                                     tel_standard,
                                     fax,
                                     represente_par)
    values(:code,
           substring(:nom from 1 for 50),
           substring(:rue from 1 for 40),
           substring(:rue from 40 for 40),
           :codepostal,
           substring(:ville from 1 for 30),
           :telfour,
           :faxfour,
           :representant);

  if (type = '2') then
    insert into t_codification(t_codification_id,
                               rang,
                               code,
                               libelle)
    values(next value for seq_codification,
           6,
           :code,
           substring(:nom from 1 for 50));
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_zone_geo(
  code integer,
  nom varchar(40))
as
begin
  insert into t_zone_geographique(t_zone_geographique_id,
                                  libelle)
  values(:code,
         substring(:nom from 1 for 50));
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_taux_tva(
  code smallint,
  taux_tva float)
as
begin
  insert into t_esculapev6_taux_tva(code, taux_tva)
  values(:code, :taux_tva);
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_acte(
  id integer,
  code varchar(5))
as
begin
  insert into t_esculapev6_acte(id, code)
  values(:id, :code);
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_produit(
  code integer,
  cip varchar(50),
  nom varchar(60),
  cip13 varchar(13),
  ean13 varchar(13),
  distributeur smallint,
  acte smallint,
  pachat float,
  pvente float,
  base float,
  liste char(1),
  tva char(1),
  geo integer,
  datedernierevente integer,
  stock smallint,
  stock_mini smallint,
  stock_maxi smallint,
  pachat_remise float, 
  Pamp float)
as
declare variable intCodif6 integer;
declare variable strDistrib varchar(50);
declare variable ftTauxTVA dm_tva;
declare variable intTVA integer;
declare variable strPrestation varchar(3);
declare variable intPrestation integer;
declare variable ddv date;
declare variable cip7 char(7);
begin
  strDistrib = cast(distributeur as varchar(50));
  execute procedure ps_renvoyer_id_codification(6, :strDistrib) returning_values :intCodif6;
  execute procedure ps_convertir_entier_vers_date(datedernierevente) returning_values :ddv;

  if ( char_length(trim(:cip)) <> 7 or :cip = '0000000' ) then cip7  = cip;

  intTVA = cast(tva as smallint);
  select round(trunc(taux_tva, 2), 1)
  from t_esculapev6_taux_tva
  where code = :intTVA
  into :ftTauxTVA;
  execute procedure ps_renvoyer_id_tva( ftTauxTVA) returning_values :intTVA;

  select code
  from t_esculapev6_acte
  where id = :acte
  into :strPrestation;
  execute procedure ps_renvoyer_id_prestation(:strPrestation) returning_values :intPrestation;

  insert into t_produit(t_produit_id,
                        code_cip,
                        designation,
                        t_codif_6_id,
                        t_ref_prestation_id,
                        prix_achat_catalogue,
                        prix_vente,
                        base_remboursement,
                        liste,
                        t_ref_tva_id,
                        date_derniere_vente,
                        stock_mini,
                        stock_maxi,
                        code_cip7,
                        pamp
			)
  values(:code,
        :cip13,
        substring(:nom from 1 for 50),
        :intCodif6,
        :intPrestation,
        :pachat,
        :pvente,
        :base,
        replace(:liste,'S','3'),
        :intTVA,
        :ddv,
		    :stock_mini,
        :stock_maxi,
		    :cip7,
		    :pamp
	 );

    if ( trim(ean13) <> '')   then
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id,
                             code_ean13)
    values(next value for seq_code_ean13,
           :code,
           :ean13);

  insert into t_produit_geographique(t_produit_geographique_id,
                                     t_produit_id,
                                     t_zone_geographique_id,
                                     quantite,
                                     t_depot_id)
  values(next value for seq_produit_geographique,
         :code,
         :geo,
         :stock,
         1);        
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_histo_vente(
  AProduit integer,
  AMois integer,
  AAnnee integer,
  AQuantite integer)
as
declare variable a integer;
declare variable m integer;
begin
    insert into t_historique_vente(
      t_historique_vente_id,
      t_produit_id,
      periode,
      quantite_actes,
      quantite_vendues)
    values(next value for seq_historique_vente,
           :AProduit,
           lpad(:AMois, 2, '0') || lpad(:AAnnee, 4, '0'),
           :AQuantite,
           :AQuantite);
end;

create or alter procedure ps_esculapev6_creer_histo_achat(
  aid integer,
  fournisseur integer,
  numero_commande integer,
  date_creation date,
  date_reception date,
  quantite_commandee integer,
  quantite_recue integer,
  prix_achat float,
  prix_vente float)
as
declare variable t char(1);
declare variable c varchar(50);
declare variable strFournisseur varchar(50);
declare variable f varchar(50);
declare variable r varchar(50);
begin
  c = cast(numero_commande as varchar(50));
  strFournisseur = cast(fournisseur as varchar(50));
  if (not exists(select *
                from t_commande
        where t_commande_id = :c)) then
  begin
    if (exists (select *
                from t_fournisseur_direct
                where t_fournisseur_direct_id = :strFournisseur)) then
    begin
      f = fournisseur;
      r = null;
    t = '1';
  end
  else
  begin
      r = fournisseur;
      f = null;
    t = '2';
  end
  
  insert into t_commande(t_commande_id,
                         type_commande,
                           mode_transmission,
                           t_fournisseur_direct_id,
                           t_repartiteur_id,
                           date_creation,
                           date_reception,
                           etat,
                           montant_ht)
  values(:c,
         :t,
       '5',
       :f,
       :r,
       :date_creation,
       :date_reception,
       '3',
       :quantite_commandee * :prix_achat);
  end
  else
    update t_commande
  set montant_ht = montant_ht + :quantite_commandee * :prix_achat
  where t_commande_id = :c;
               
  insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               quantite_totale_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               reception_financiere,
                               prix_vente)
  values(next value for seq_commande_ligne,
         :c,
     :aid,
     :quantite_commandee,
     :quantite_recue,
     :quantite_recue,
     :prix_achat,
     :prix_achat,
     '1',
     :prix_vente);
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_histo_cli (
  code integer,
  dtefact integer,
  dteordo integer,
  client integer,
  docteur integer)
as
declare variable dtf date;
declare variable dto date;
begin
  execute procedure ps_convertir_entier_vers_date(:dtefact) returning_values dtf;
  execute procedure ps_convertir_entier_vers_date(:dteordo) returning_values dto;

  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  date_prescription,
                                  date_acte,
                                  t_praticien_id,
                                  numero_facture,
                                  type_facturation)
  values(:code,
         :client,
         :dto,
         :dtf,
         :docteur,
         :code,
         '2');
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_ligne_histo(
  AID integer,
  AProduit integer,
  AQuantite integer,
  APrixVente float)
as
declare variable p varchar(50);
declare variable strDesignation varchar(50);
declare variable CodeCIP numeric(18);
declare prix_achat float;
declare prix_achat_remise  float;

begin
  p = cast(:AProduit as varchar(50));
  select designation, iif(trim(code_cip)>'',cast(code_cip as numeric(18)),null) , prix_achat_catalogue , prix_achat_remise
  from t_produit
  where t_produit_id = :p
  into :strDesignation, :CodeCIP, :prix_achat , :prix_achat_remise ;

  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                        t_historique_client_id,
                                        code_cip,
                                        quantite_facturee,
                                        designation,
                                        prix_vente,
                                        prix_achat_ht_remise,
                                        t_produit_id)
  values(next value for seq_historique_client_ligne,
         :AID,
         :CodeCIP,
         :AQuantite,
         :strDesignation,
         :APrixVente,
         :prix_achat_remise,
         :p);
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_operateur(
  code char(1),
  nom varchar(30),
  psw varchar(10))
as
declare variable p varchar(40);
declare variable n varchar(40);
declare variable njf varchar(40);
begin
  execute procedure ps_separer_nom_prenom(:nom, ' ') returning_values :n, :p, :njf;

  insert into t_operateur(t_operateur_id,
                          code_operateur,
                          nom,
                          prenom)
  values(:code,
         :code,
         iif(:nom is null, :code, :n),
         iif(:nom is null, :code, :p));
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_avance(
  AProduitID dm_code,  
  AClientID dm_code,
  ACodeOperateur varchar(1),
  AQuantite integer,  
  ADateAvance  varchar(20))
as
declare variable chCodeCIP char(13);
declare variable strDesignation varchar(50);
declare variable lFtPrixAchat numeric(10,3);
declare variable lFtPrixVente numeric(10,3);
declare variable lStrCodePrestation varchar(4);
declare variable lFtBaseRemboursement numeric(10,2);
begin

    select prd.code_cip7,
           prd.designation,
           prd.prix_achat_catalogue,
           prd.t_ref_prestation_id,
           prd.base_remboursement,
           prd.prix_vente
    from t_produit prd
    where prd.t_produit_id = :AProduitID 
    into :chCodeCIP,
         :strDesignation,
         :lFtPrixAchat,
         :lStrCodePrestation,
         :lFtBaseRemboursement,
         :lFtPrixVente;

    insert into t_vignette_avancee(t_vignette_avancee_id,
                                   t_client_id,
                                   date_avance,
                                   code_cip,
                                   designation,
                                   prix_vente,
                                   prix_achat,
                                   code_prestation,
                                   t_produit_id,
                                   t_operateur_id,
                                   quantite_avancee,
                                   base_remboursement)
    values(next value for seq_vignette_avancee,
           :AClientID,
           cast(substring(:ADateAvance from 7 for 4) || '-' ||
              substring(:ADateAvance from 4 for 2) || '-' ||
              substring(:ADateAvance from 1 for 2) as date),
           :chCodeCIP,
           :strDesignation,
           :lFtPrixVente,
           :lFtPrixAchat,
           :lStrCodePrestation,
           :AProduitID,
           null,
           :AQuantite,
           :lFtbaseRemboursement);

end;

 
/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_credit(
  client integer,
  montant float,
  date_credit varchar(20))
as
begin
  insert into t_credit(t_credit_id,
                       t_client_id,
                       montant,
                       date_credit)
  values(:client,
         :client,
         :montant,
         cast(substring(:date_credit from 7 for 4) || '-' ||
              substring(:date_credit from 4 for 2) || '-' ||
              substring(:date_credit from 1 for 2) as date));
end;

 
/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_comm_client(
  id integer,
  commentaire varchar(500),
  type_com integer  )
as
declare variable strID varchar(50);
begin
  strID = cast(id as varchar(50));
  if (:type_com in (8, 11)) then
  begin
	update t_client
	set commentaire_individuel = substring(coalesce(commentaire_individuel, '') || :commentaire from 1 for 200)
	where t_client_id = :strID;
  
	insert into t_commentaire (t_commentaire_id,
                                   t_entite_id,
                                   type_entite,
                                   commentaire )
	values ( next value for seq_commentaire,
                 :id,
                 '0', -- client 
                cast(:commentaire as blob)   );
  end
  
  if (:type_com = 1) then
   update t_produit
   set commentaire_vente = substring( :commentaire from 1 for 200)
   where t_produit_id = :strID;   
end;

/* ********************************************************************************************** */
create or alter procedure ps_esculapev6_creer_document(  
  AScanID dm_code,
  AFichier varchar(255))
as
begin
  insert into t_document(t_document_id,
                         type_entite,
                         t_entite_id,
                         libelle,
                         document)
  values(next value for seq_document,
         2, --doc client
         ( select t_client_id from t_esculapev6_scan where t_document_id = :AScanID ),
         'Scan mutuelle ',
         :AFichier);
end;