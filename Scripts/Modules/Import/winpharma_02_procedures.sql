set sql dialect 3;


/* **************************************************************************************************************** */
/* ************************************************** Exceptions ************************************************** */
/* **************************************************************************************************************** */
create exception exp_win_depot_purge 'Dépot supprimé/purgé';
create exception exp_win_prestation_inconnue 'Code Prestation inconnu';

create or alter procedure PS_WP_SEPARE_CHAMP (
    chaine varchar(200),
    separateur char(1))
returns (
    souschaine varchar(200),
    reste varchar(200))
as
declare variable longueur integer;
declare variable position_separateur integer;
begin

    position_separateur = position(separateur in chaine);
    longueur = char_length(chaine);
    if ( position_separateur>1 ) then
    begin
        souschaine = substring(chaine from 1 for position_separateur-1);
        reste = substring(chaine from position_separateur+1 for longueur - position_separateur);
        suspend;
    end
end;

create or alter procedure ps_supprimer_donnees_modules(
  ATypeSuppression integer)
as
begin
  if (ATypeSuppression = 101) then
  begin
    delete from t_wp_categorie;
    delete from t_depot;
    delete from t_wp_prestation;   
  end
  
  if (ATypeSuppression = 102) then
    delete from t_credit;       
end;

/***********************************************************************************/
/**                           PRATICIENS / HOPITAUX                               **/
/***********************************************************************************/

create or alter procedure ps_wp_creer_medecin (
    t_praticien_id varchar(50),
    no_finess_med varchar(9),
    no_finess_hop varchar(9),
    nom_prenom varchar(60),
    nom_long integer,
    rue_1 varchar(40),
    rue_2 varchar(40),
    code_postal varchar(5),
    nom_ville varchar(50),
    telephone varchar(20),
    fax varchar(20),
    note varchar(100),
    specialite varchar(2),
    email varchar(50),
    t_hopital_id varchar(50),
    flag_hopital char(1),
    commentaire varchar(250),
    num_rpps varchar(11)
  )
as
declare variable t_ref_specialite_id integer;
declare variable prenom varchar(50);
declare variable nom varchar(50);
begin
  
  /* separation nom prenom uniquement pour les medecins , ne fonctionne pas pour les hopitaux */
  if ( (char_length(nom_prenom)-nom_long ) > 0 and (nom_prenom <>'') )  then
    prenom = substring( nom_prenom from nom_long+1 for  char_length(nom_prenom)-nom_long+1 );
  else
    prenom = '_';
  
  if (nom_prenom = '') then
      nom = 'pas de nom';
    else
      nom = substring( nom_prenom from 1 for nom_long );

  -- flag  2 =  données issues de la requete des hopitaux
  -- traitement hopitaux  
  if (flag_hopital = '2') then
  begin
  /* on ne creer l hopital que si le finess existe dans notre base de ref */
  /* si non erreur de FK */ 
      insert into t_hopital (t_hopital_id,
                           nom,
                           rue_1,
                           rue_2,
                           code_postal,
                           nom_ville,
                           no_finess,
                           tel_standard,
                           fax,
                           commentaire)
      values (:t_praticien_id,
              substring(:nom_prenom from 1 for 50),
              :rue_1,
              :rue_2,
              :code_postal,
              substring(:nom_ville from 1 for 30),
              :no_finess_hop,
              :telephone,
              :fax,
              :email);
  end
  else                  /* traitement medecins */
  begin

    select t_ref_specialite_id from t_ref_specialite where code = lpad(:specialite,2,'0') into :t_ref_specialite_id;
    if (t_ref_specialite_id is null ) then t_ref_specialite_id = 1;


    if ( t_hopital_id > 0 ) then -- praticien hospitalier
       insert into t_praticien (t_praticien_id,
                                   type_praticien,
                                   nom,
                                   prenom,
                                   rue_1,
                                   rue_2,
                                   code_postal,
                                   nom_ville,
                                   no_finess,
                                   tel_standard,
                                   t_ref_specialite_id,
                                   fax,
                                   commentaire,
                                   agree_ratp,
                                   t_hopital_id,
                                   num_rpps)
          values ('H'||:t_praticien_id,
                  2,
                  :nom,
                  :prenom,
                  :rue_1,
                  :rue_2,
                  :code_postal,
                  substring(:nom_ville from 1 for 30),
                  :no_finess_hop,
                  :telephone,
                  :t_ref_specialite_id,
                  :fax,
                  substring(coalesce(:note,'')||' '||coalesce(:email,'')||' '||coalesce(:commentaire,'') from 1 for 200),
                  '0',
                  :t_hopital_id,
                  :num_rpps);
      
    -- si on a un finess de cabinet creation d 'un praticien privé  
    if ( no_finess_med > '' )  then
      insert into t_praticien (t_praticien_id,
                               type_praticien,
                               nom,
                               prenom,
                               rue_1,
                               rue_2,
                               code_postal,
                               nom_ville,
                               no_finess,
                               tel_standard,
                               t_ref_specialite_id,
                               fax,
                               commentaire,
                               agree_ratp,
                               t_hopital_id,
                               num_rpps)
      values ('P'||:t_praticien_id,
              1,
              :nom,
              :prenom,
              :rue_1,
              :rue_2,
              :code_postal,
              substring(:nom_ville from 1 for 30),
              :no_finess_med,
              :telephone,
              :t_ref_specialite_id,
              :fax,
              substring(coalesce(:note,'')||' '||coalesce(:email,'')||' '||coalesce(:commentaire,'') from 1 for 200),
              '0',
              :t_hopital_id,
              :num_rpps);

    end

end;


/***********************************************************************************/
/**                            ORGANISMES AMO                                     **/
/***********************************************************************************/


create or alter procedure PS_WP_CREER_ORGANISME_AMO (
    t_organisme_id varchar(50),
    nom varchar(50),
    rue_1 varchar(40),
    rue_2 varchar(40),
    code_postal varchar(5),
    nom_ville varchar(30),
    telephone varchar(20),
    commentaire varchar(200),
    caisse varchar(5),
    centre_gestionnaire varchar(5),
    regime varchar(2))
as
declare variable compte integer;
declare variable identifiant_national varchar(20);
declare variable type_contrat integer;
declare variable t_ref_regime_id integer;
declare variable t_organisme_amo_id varchar(50);
declare variable t_organisme_payeur_id integer;
declare variable sanscentre char(1);
begin
  t_organisme_amo_id = :t_organisme_id;

  regime = lpad(regime,2,'0');
  select sans_centre_gestionnaire from t_ref_regime where code = :regime into :sanscentre ;

  if ( caisse = '65535') then
    caisse = '000';
  else
    caisse = lpad(caisse,3,'0');

  if ( sanscentre = '0')  then
    centre_gestionnaire = lpad(centre_gestionnaire,4,'0');
  else
    centre_gestionnaire = '';

  if ( centre_gestionnaire = '65535') then centre_gestionnaire = '0000';


  telephone = replace(:telephone,'.','');
  telephone = replace(:telephone,' ','');

  select t_ref_regime_id from t_ref_regime where code = :regime into :t_ref_regime_id ;

  identifiant_national=regime||caisse||centre_gestionnaire;

  if ( char_length(identifiant_national)>9 ) then
  begin
    --execute procedure ps_erreur('1',null,'',0,1, 'identifiant national trop long tronqué <'||:identifiant_national||'>');
    identifiant_national = substring(identifiant_national from 3 for 8 );
  end

  /* insertion dans t_organisme d'un amo */
  insert into t_organisme(t_organisme_id,
                          type_organisme,
                          nom_reduit,
                          nom,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_personnel,
                          identifiant_national,
                          t_ref_regime_id,
                          caisse_gestionnaire,
                          centre_gestionnaire,
                          commentaire )
  values('P-'||:t_organisme_amo_id,
         1,
         substring(:t_organisme_id from 1 for 20),
         iif(:nom = '', :t_organisme_amo_id, :nom),
         :rue_1,
         :rue_2,
         :code_postal,
         :nom_ville,
         :telephone,
         :identifiant_national,
         :t_ref_regime_id,
         :caisse,
         :centre_gestionnaire,
         :commentaire ) ;
end;

/***********************************************************************************/
/**                            ORGANISMES AMC                                     **/
/***********************************************************************************/

create or alter procedure PS_WP_CREER_ORGANISME_AMC (
    t_organisme_id varchar(50),
    nom varchar(50),
    rue_1 varchar(40),
    rue_2 varchar(40),
    code_postal varchar(5),
    nom_ville varchar(30),
    telephone varchar(20),
    fax varchar(20),
    code_rembt varchar(50),
    commentaire varchar(200),
    identifiant_national varchar(12),
    type_contrat varchar(10),
    org_sante_pharma char(1),
    code_vitale char(12))
as
declare variable compte integer;
declare variable t_organisme_payeur_id integer;
declare variable t_organisme_amc_id varchar(50);
begin
  t_organisme_amc_id = :t_organisme_id;
  if (type_contrat = '') then type_contrat ='0' ;

  telephone = replace(:telephone,'.','');
  telephone = replace(:telephone,' ','');
  fax =  replace(:fax,'.','');
  fax =  replace(:fax,' ','');


  if (identifiant_national <> '') then
  begin
    if ( char_length(identifiant_national)>9 ) then
    begin
      --execute procedure ps_erreur('1',null,'',0,1, 'identifiant national trop long tronqué <'||:identifiant_national||'>');
      identifiant_national = substring(identifiant_national from 3 for 8 );
    end
  end
  else
    identifiant_national = substring(code_vitale from 1 for 8);



  /* insertion d'n organisme amc */
   insert into t_organisme (t_organisme_id,
                            type_organisme,
                            nom_reduit,
                            nom,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_personnel,
                            fax,
                            identifiant_national,
                            org_sante_pharma,
                            type_contrat,
                            commentaire)
  values('M-'||:t_organisme_amc_id,
         '2',
         substring(:t_organisme_id from 1 for 20),
         iif(:nom = '', :t_organisme_amc_id, :nom),
         :rue_1,
         :rue_2,
         :code_postal,
         :nom_ville,
         :telephone,
         :fax,
         :identifiant_national,
         :org_sante_pharma,
         coalesce(:type_contrat, 0),
         :commentaire );
end;


/***********************************************************************************/
/**                         COUVERTURES                                           **/
/***********************************************************************************/
create or alter procedure ps_wp_creer_taux_amc(
  t_couverture_amc_id varchar(50),
  prestation varchar(3),
  taux float)
as
declare variable p integer;
begin
  execute procedure ps_renvoyer_id_prestation(:prestation) returning_values :p;

  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux)
  values(next value for seq_taux_prise_en_charge,
         :t_couverture_amc_id,
         :p,
         iif(:taux is null, 0, :taux * 100));
end;

CREATE or alter PROCEDURE PS_WP_CREER_COUVERTURE (
    section integer,
    valeur varchar(120))
as
declare variable longueur integer;
declare variable position_separateur integer;
declare variable libelle varchar(50);
declare variable id varchar(50);
declare variable sous_chaine varchar(120);
declare variable bleue numeric(15,2);
declare variable blanc numeric(15,2);
declare variable cent numeric(15,2);
declare variable exo char(1);
declare variable nature_assurance integer;
declare variable orange numeric(15,2);
declare variable lpp numeric(15,2);
declare variable ald char(1);
declare variable t_ref_prestation_id integer;
declare variable date_validite date;
declare variable date_str varchar(20);
declare variable flag varchar(10);
declare variable taux varchar(20);
begin
 /* AMO */
 if (section = 1) then
 begin
       execute procedure ps_wp_separe_champ( valeur ,  ',') returning_values :id, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :libelle, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       bleue = cast(taux as float)*100;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       blanc = cast(taux as float)*100;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       cent = cast(taux as float)*100;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;

       if (char_length(taux) = 3) then
       begin
        exo = substring(taux from 3 for 1) ;
        nature_assurance = cast(substring(taux from 1 for 2) as integer);
       end

       if (exo = '4') then ald =1;
       else ald = 0;

       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :flag, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       if ( taux is not null ) then
        lpp = cast(taux as float)*100;

       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :date_str, :sous_chaine;

       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       if ( taux is not null ) then
        orange = cast(taux as float)*100;

       if  ((char_length(date_str)) = 10) then
        date_validite=cast(replace(date_str,'/','.') as date );

       if ( (date_validite >= current_date) or (date_str='0')  ) then
       /* AMO */
       begin
        insert into t_couverture_amo( t_couverture_amo_id,ald , libelle,nature_assurance ,justificatif_exo)
        values (:id, :ald, :libelle,:nature_assurance,:exo);

        select t_ref_prestation_id from t_ref_prestation where code = 'PH4' into :t_ref_prestation_id;
        insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
        values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :bleue );

        select t_ref_prestation_id from t_ref_prestation where code = 'PH7' into :t_ref_prestation_id;
        insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
        values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :blanc );

        select t_ref_prestation_id from t_ref_prestation where code = 'PH1' into :t_ref_prestation_id;
        insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
        values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , 100 );

        select t_ref_prestation_id from t_ref_prestation where code = 'PH2' into :t_ref_prestation_id;
        if ( orange >= 0) then
            insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
            values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :orange );

       end
  end

/* AMO */
 if (section = 3) then
 begin
       execute procedure ps_wp_separe_champ( valeur ,  ',') returning_values :id, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :libelle, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       bleue = cast(taux as float);
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       blanc = cast(taux as float);
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       cent = cast(taux as float);
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
       orange  = cast(taux as float);


       /* AMO */
       begin
        insert into t_couverture_amo( t_couverture_amo_id, libelle)
        values (:id, :libelle);

        if ( bleue >= 0) then
        begin
            select t_ref_prestation_id from t_ref_prestation where code = 'PH4' into :t_ref_prestation_id;
            insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
                values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :bleue );
        end

        if ( blanc >= 0) then
        begin
            select t_ref_prestation_id from t_ref_prestation where code = 'PH7' into :t_ref_prestation_id;
            insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
                values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :blanc );
            select t_ref_prestation_id from t_ref_prestation where code = 'AAD' into :t_ref_prestation_id;
            insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
                values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :blanc );
            select t_ref_prestation_id from t_ref_prestation where code = 'PMR' into :t_ref_prestation_id;
            insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
                values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :blanc );        
        end

        if ( cent >= 0) then
        begin
            select t_ref_prestation_id from t_ref_prestation where code = 'PH1' into :t_ref_prestation_id;
            insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
                values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :cent );
        end

        select t_ref_prestation_id from t_ref_prestation where code = 'PH2' into :t_ref_prestation_id;
        if ( orange >= 0) then
            insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
            values ( next value for seq_taux_prise_en_charge ,:id, :t_ref_prestation_id , :orange );

       end
  end


   -- AMC
   if (section = 5) then
   begin
     execute procedure ps_wp_separe_champ( valeur ,  ',') returning_values :id, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :libelle, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     bleue = cast(taux as float);
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     blanc = cast(taux as float);
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     cent = cast(taux as float);
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     lpp = cast(taux as float);
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :taux, :sous_chaine;
     orange = cast(taux as float);

     insert into t_couverture_amc(t_couverture_amc_id,
                                  libelle,
                                  montant_franchise,
                                  plafond_prise_en_charge,
                                  couverture_cmu,
                                  formule)
     values (:id,
             :libelle,
             0,
             0,
             0,
             '02A');

     execute procedure ps_wp_creer_taux_amc(:id, 'PH4', :bleue);
     execute procedure ps_wp_creer_taux_amc(:id, 'PH7', :blanc);
     execute procedure ps_wp_creer_taux_amc(:id, 'PH1', 1);
     execute procedure ps_wp_creer_taux_amc(:id, 'PH2', :orange);
     execute procedure ps_wp_creer_taux_amc(:id, 'AAD', :lpp);
     execute procedure ps_wp_creer_taux_amc(:id, 'PMR', :blanc);
   end

end;

/***********************************************************************************/
/**                            COUVERTURES AMC                                    **/
/***********************************************************************************/
create or alter procedure ps_wp_creer_couverture_amc (
  mutu_code varchar(16),
  CodeMRembt smallint)
as
declare variable strCodeMRembt varchar(50);
declare variable o varchar(50);
declare variable c varchar(50);
declare variable libelle varchar(50);
declare variable taux numeric(15,2);
declare variable t_ref_prestation_id integer;
begin
  strCodeMRembt = cast(CodeMRembt as varchar(50));

  o = 'M-' || mutu_code;
  c = 'M-' || mutu_code || '-' || CodeMRembt;

  insert into t_couverture_amc(t_couverture_amc_id,
                               t_organisme_amc_id,
                               libelle,
                               montant_franchise,
                               plafond_prise_en_charge,
                               formule,
                               couverture_cmu)
  select :c,
         :o,
         libelle,
         montant_franchise,
         plafond_prise_en_charge,
         '02A',
         couverture_cmu
  from t_couverture_amc
  where t_couverture_amc_id = :strCodeMRembt
    and t_organisme_amc_id is null;

  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux)
  select next value for seq_taux_prise_en_charge,
         :c,
         t_ref_prestation_id,
         taux
  from t_taux_prise_en_charge
  where t_couverture_amc_id = :strCodeMRembt;
end;

/***********************************************************************************/
/**                            COUVERTURES AMO                                    **/
/***********************************************************************************/
create or alter procedure PS_WP_CREER_COUVERTURE_AMO (
    t_couverture_amo_id varchar(50),
    t_organisme_amo_id varchar(50))
as
declare variable ald char(1);
declare variable libelle varchar(50);
declare variable nature_assurance numeric(2,0);
declare variable justificatif_exo char(1);
declare variable t_ref_couverture_amo_id integer;
declare variable code_sesam varchar(5);
declare variable t_ref_prestation_id integer;
declare variable taux numeric(15,2);
begin

    t_organisme_amo_id= 'P-'||t_organisme_amo_id ;

    select
        libelle,
        ald,
        nature_assurance,
        justificatif_exo
    from  t_couverture_amo
    where t_couverture_amo_id = :t_couverture_amo_id
    into
        :libelle,
        :ald,
        :nature_assurance,
        :justificatif_exo;

    if ( exists (select t_couverture_amo_id from t_couverture_amo where t_couverture_amo_id = :t_couverture_amo_id ) ) then
    begin

        insert into t_couverture_amo (
            t_couverture_amo_id,
            t_organisme_amo_id,
            ald,
            libelle,
            nature_assurance,
            justificatif_exo   )
        values     (
            :t_couverture_amo_id||'-'||:t_organisme_amo_id,
            :t_organisme_amo_id,
            :ald,
            :libelle,
            :nature_assurance,
            :justificatif_exo   );

       /* on recopie tous les taux de la couverture de base */
      for select t_ref_prestation_id ,
                  taux
           from t_taux_prise_en_charge
           where t_couverture_amo_id = :t_couverture_amo_id
           into
               :t_ref_prestation_id ,
               :taux
           do
           begin
                if (exists(select t_couverture_amo_id from t_couverture_amo where t_couverture_amo_id = :t_couverture_amo_id||'-'||:t_organisme_amo_id ) ) then
                insert into t_taux_prise_en_charge( t_taux_prise_en_charge_id,t_couverture_amo_id, t_ref_prestation_id, taux )
                values ( next value for seq_taux_prise_en_charge ,:t_couverture_amo_id||'-'||:t_organisme_amo_id, :t_ref_prestation_id , :taux );
           end




    end
    else
    begin
        /* surement une couv sesam */
        if (exists( select code_sesam from t_wp_couverture_sesam where t_couverture_id = :t_couverture_amo_id) )        then
        begin

           select code_sesam
           from t_wp_couverture_sesam
           where t_couverture_id = :t_couverture_amo_id
           into :code_sesam;

           select t_ref_couverture_amo_id, libelle
           from t_ref_couverture_amo
           where code_couverture = :code_sesam
           into :t_ref_couverture_amo_id, :libelle ;

        insert into t_couverture_amo (
            t_couverture_amo_id,
            t_organisme_amo_id,
            ald,
            libelle,
            t_ref_couverture_amo_id )
        values     (
            :t_couverture_amo_id||'-'||:t_organisme_amo_id,
            :t_organisme_amo_id,
            substring( :code_sesam from 1 for 1),
            substring( :libelle from 1 for 50),
            :t_ref_couverture_amo_id
  );

        end
    end
end;


/***********************************************************************************/
/**                                 ASSURES                                       **/
/***********************************************************************************/
create or alter procedure ps_wp_creer_couv_amo_client(
  t_client_id varchar(50),
  t_organisme_amo_id varchar(50),
  t_couverture_amo_id varchar(50),
  fin_droit_amo date)
as
declare variable strCouvertureAMO varchar(50);
begin
  if ((t_couverture_amo_id is not null) and (t_organisme_amo_id is not null)) then
  begin
    strCouvertureAMO = :t_couverture_amo_id||'-'||:t_organisme_amo_id;
    if ((exists(select *
               from t_couverture_amo
               where t_couverture_amo_id = :strCouvertureAMO)) and
        (not(exists(select *
                    from t_couverture_amo_client
                    where t_client_id = :t_client_id
                      and t_couverture_amo_id = :strCouvertureAMO)))) then
      insert into t_couverture_amo_client(
        t_couverture_amo_client_id,
        t_client_id,
        t_couverture_amo_id,
        debut_droit_amo,
        fin_droit_amo)
      values(
        next value for seq_couverture_amo_client,
        :t_client_id,
        :strCouvertureAMO,
        current_date,
        :fin_droit_amo);
  end
end;

/* ********************************************************************************************** */
CREATE or ALTER PROCEDURE PS_WP_CREER_ASSURE (
    t_client_id varchar(50),
    nom_prenom varchar(50),
    nom_long integer,
    rue_1 varchar(40),
    rue_2 varchar(40),
    code_postal varchar(10),
    nom_ville varchar(30),
    telephone varchar(20),
    fax varchar(20),
    gsm varchar(250),
    email varchar(200),
    t_organisme_amo1_id varchar(50),
    centre integer,
    numero_insee varchar(15),
    t_organisme_amc_id varchar(50),
    t_couverture_amc_id varchar(50),
    numero_mutuelle_1 varchar(20),
    str_debut_droit_amc date,
    str_fin_droit_amc date,
    numero_mutuelle_2 varchar(20),
    numero_mutuelle_3 varchar(20),
    str_derniere_visite date,
    solde varchar(50),
    commentaire_global varchar(250),
    date_naissance integer,
    str_fin_droit_amo1 date,
    t_couverture_amo1_id varchar(50),
    str_fin_droit_amo2 date,
    t_couverture_amo2_id varchar(50),
    str_fin_droit_amo3 date,
    t_couverture_amo3_id varchar(50),
    str_fin_droit_amo4 date,
    t_couverture_amo4_id varchar(50),
    str_fin_droit_amo5 date,
    t_couverture_amo5_id varchar(50),
    str_fin_droit_amo6 date,
    t_couverture_amo6_id varchar(50),
    str_fin_droit_amo7 date,
    t_couverture_amo7_id varchar(50),
    AAMCGestionUnique char(1), 
    t_commentaire_id dm_code)
as
declare variable centre_gestionnaire varchar(4);
declare variable contrat_sante_pharma varchar(20);
declare variable numero_adherent_mutuelle varchar(20);
declare variable nom varchar(50);
declare variable nom_jeune_fille varchar(50);
declare variable prenom varchar(50);
declare variable date_derniere_visite date;
declare variable date_fin_droit_amo1 date;
declare variable date_fin_droit_amo2 date;
declare variable date_fin_droit_amo3 date;
declare variable date_fin_droit_amo4 date;
declare variable date_fin_droit_amo5 date;
declare variable date_fin_droit_amo6 date;
declare variable date_fin_droit_amo7 date;
declare variable date_debut_droit_amc date;
declare variable date_fin_droit_amc date;
declare variable an integer;
declare variable mois integer;
declare variable jour integer;
declare variable date_naissance2 varchar(20);
declare variable strSP varchar(8);
declare variable intAnnee smallint;
declare variable intMois smallint;
declare variable intJour smallint;
begin
  
  
  if ( (char_length(nom_prenom)-nom_long ) > 0 and (nom_prenom <>'') )  then
    prenom = substring( nom_prenom from nom_long+1 for  char_length(nom_prenom)-nom_long+1 );
  else
    prenom = '_';
  
  if (nom_prenom = '') then
      nom = 'pas de nom';
    else
      nom = substring( nom_prenom from 1 for nom_long );

  --execute procedure ps_separer_nom_prenom(:nom_prenom, ' ') returning_values :nom, :prenom, :nom_jeune_fille;
    
  t_organisme_amo1_id = 'P-'||t_organisme_amo1_id;
  t_organisme_amc_id = 'M-'||t_organisme_amc_id;

  if (numero_mutuelle_2 >'') then
  begin
        strSP = substring(numero_mutuelle_2 from 1 for 8);
        if (exists(select *
                    from t_ref_organisme
                    where identifiant_national = :strSP)) then
        begin
          if (not exists(select *
                         from t_organisme
                         where t_organisme_id = 'SPSANTE_' || :strSP)) then
        
            insert into t_organisme(
              t_organisme_id,
              type_organisme,
              nom,
              identifiant_national,
              code_postal,
              nom_ville)
            select 'SPSANTE_' || :strSP,
                   '2',
                   nom,
                   :strSP,
                   code_postal,
                   nom_ville
            from t_ref_organisme
            where identifiant_national = :strSP;
          
          if (not exists(select *
                         from t_couverture_amc
                         where t_couverture_amc_id = 'SPSANTE_' || :strSP || '_' || :t_couverture_amc_id)) then
          begin
            insert into t_couverture_amc(
              t_couverture_amc_id,
              t_organisme_amc_id,
              libelle,
              montant_franchise,
              plafond_prise_en_charge,
              formule,
              couverture_cmu)
            select 'SPSANTE_' || :strSP || '_' || :t_couverture_amc_id,
                   'SPSANTE_' || :strSP,
                   libelle,
                   montant_franchise,
                   plafond_prise_en_charge,
                   formule,
                   couverture_cmu
            from t_couverture_amc
            where t_couverture_amc_id = :t_organisme_amc_id || '-' || :t_couverture_amc_id;
            
            insert into t_taux_prise_en_charge(
              t_taux_prise_en_charge_id,
              t_couverture_amc_id,
              t_ref_prestation_id,
              taux)
            select next value for seq_taux_prise_en_charge,
                   'SPSANTE_' || :strSP || '_' || :t_couverture_amc_id,
                   t.t_ref_prestation_id,
                   t.taux
            from t_taux_prise_en_charge t
                 inner join t_couverture_amc c on c.t_couverture_amc_id = t.t_couverture_amc_id
            where t.t_couverture_amc_id = :t_organisme_amc_id || '-' || :t_couverture_amc_id;
          end
          t_organisme_amc_id = 'SPSANTE_' || strSP;
          t_couverture_amc_id = 'SPSANTE_' || strSP || '_' || t_couverture_amc_id;
          contrat_sante_pharma = null;
          numero_adherent_mutuelle = substring(numero_mutuelle_3 from 1 for 16);
        end
        else
        begin
          t_couverture_amc_id = t_organisme_amc_id || '-' || t_couverture_amc_id;
          contrat_sante_pharma = substring(numero_mutuelle_2 from 1 for 11)||'PH100TM';
          numero_adherent_mutuelle = substring(numero_mutuelle_3 from 1 for 16);
        end
  end
  else
  begin
    t_couverture_amc_id = t_organisme_amc_id || '-' || t_couverture_amc_id;
    numero_adherent_mutuelle = substring(numero_mutuelle_1 from 1 for 16);
  end

  intAnnee = nullif(bin_shr(date_naissance, 16), 0);
  if ((intAnnee is not null) or (char_length(intAnnee) <> 4)) then
  begin
    intMois = nullif(bin_shr(bin_and(date_naissance, 65280), 8), 0);
  if (intMois is not null) then
    intJour = nullif(bin_and(date_naissance, 255), 0);
  end
  else
    intAnnee = null;

    if (char_length(str_derniere_visite) = 10) then
        date_derniere_visite = cast(
        substring(:str_derniere_visite from 9 for 2)||'.'||
        substring(:str_derniere_visite from 6 for 2)||'.'||
        substring(:str_derniere_visite from 1 for 4) as date);
    else
        date_derniere_visite = null;

    if (char_length(str_fin_droit_amo1) = 10) then
        date_fin_droit_amo1 = cast(
        substring(:str_fin_droit_amo1 from 9 for 2)||'.'||
        substring(:str_fin_droit_amo1 from 6 for 2)||'.'||
        substring(:str_fin_droit_amo1 from 1 for 4) as date);
    else
        date_fin_droit_amo1 = null;

    if (char_length(str_fin_droit_amo2) = 10) then
        date_fin_droit_amo2 = cast(
        substring(:str_fin_droit_amo2 from 9 for 2)||'.'||
        substring(:str_fin_droit_amo2 from 6 for 2)||'.'||
        substring(:str_fin_droit_amo2 from 1 for 4) as date);
    else
        date_fin_droit_amo2 = null;

    if (char_length(str_fin_droit_amo3) = 10) then
        date_fin_droit_amo3 = cast(
        substring(:str_fin_droit_amo3 from 9 for 2)||'.'||
        substring(:str_fin_droit_amo3 from 6 for 2)||'.'||
        substring(:str_fin_droit_amo3 from 1 for 4) as date);
    else
        date_fin_droit_amo3 = null;

    if (char_length(str_fin_droit_amc) = 10) then
        date_fin_droit_amc = cast(
        substring(:str_fin_droit_amc from 9 for 2)||'.'||
        substring(:str_fin_droit_amc from 6 for 2)||'.'||
        substring(:str_fin_droit_amc from 1 for 4) as date);
    else
        date_fin_droit_amc = null ;

    if (char_length(str_debut_droit_amc) = 10) then
        date_debut_droit_amc = cast(
        substring(:str_debut_droit_amc from 9 for 2)||'.'||
        substring(:str_debut_droit_amc from 6 for 2)||'.'||
        substring(:str_debut_droit_amc from 1 for 4) as date);
    else
        date_debut_droit_amc = null ;

    /* remplissage T_CLIENT */
    insert into t_client (
        t_client_id,
        numero_insee,
        qualite,
        nom,
        nom_jeune_fille,
        prenom,
        rue_1,
        rue_2,
        code_postal,
        nom_ville,
        tel_personnel,
        tel_mobile,
        fax,
        date_naissance,
        t_organisme_amo_id,
        t_organisme_amc_id,
        t_couverture_amc_id,
        centre_gestionnaire,
        numero_adherent_mutuelle,
        debut_droit_amc,
        fin_droit_amc,
        date_derniere_visite,
        rang_gemellaire,
        commentaire_global,
        contrat_sante_pharma,
        mode_gestion_amc)
    values (
        :t_client_id,
        :numero_insee,
        0,
        substring(:nom from 1 for 30),
        :nom_jeune_fille,
        substring(:prenom from 1 for 30),
        :rue_1,
        :rue_2,
        substring( :code_postal from 1 for 5),
        :nom_ville,
        replace(replace(:telephone,'.',''), ' ', ''),
        substring(replace(replace(:gsm,'.',''), ' ', '') from 1 for 20),
        replace(replace(:fax,'.',''), ' ', ''),
        lpad(:intJour, 2, '0') || lpad(:intMois, 2, '0') || :intAnnee,
        :t_organisme_amo1_id,
        :t_organisme_amc_id,
        :t_couverture_amc_id,
        iif(:centre <> 65535, lpad(:centre, 4,'0'), :centre),
        :numero_adherent_mutuelle,
        :date_debut_droit_amc,
        :date_fin_droit_amc,
        :date_derniere_visite,
        1,        
        substring(replace(:commentaire_global, '  ' , ' ') from 1 for 2000),
        :contrat_sante_pharma,
        iif(:AAMCGestionUnique = '1', '1', '2'));

    if ( commentaire_global > '' ) then 
      insert into t_commentaire (t_commentaire_id,
                                 t_entite_id,
                                 type_entite,
                                 commentaire,
                                 est_global )
      values ( next value for seq_commentaire,
               :t_client_id,
               '0', -- client 
                cast(:commentaire_global as blob),
                1 );

     -- ne se lance que pour les assures pas les benef
     if ( t_commentaire_id > '' ) then 
      insert into t_winpharma_com_cli(t_commentaire_id,
                                       t_client_id)
      values ( :t_commentaire_id||'-1',
               :t_client_id);  

    /* remplissage t_couverture_client 1ere couv AMO*/
    execute procedure ps_wp_creer_couv_amo_client(:t_client_id, :t_organisme_amo1_id, :t_couverture_amo1_id, :date_fin_droit_amo1);
    execute procedure ps_wp_creer_couv_amo_client(:t_client_id, :t_organisme_amo1_id, :t_couverture_amo2_id, :date_fin_droit_amo2);
    execute procedure ps_wp_creer_couv_amo_client(:t_client_id, :t_organisme_amo1_id, :t_couverture_amo3_id, :date_fin_droit_amo3);
    
end;

/***********************************************************************************/
/**                           BENEFICIAIRES                                       **/
/***********************************************************************************/
create or alter procedure PS_WP_CREER_BENEF (
    t_client_assure_id varchar(50),
    t_client_ordre_id varchar(50),
    nom_prenom varchar(60),
    nom_long integer,
    lien varchar(2),
    t_organisme_amc_id varchar(50),
    t_couverture_amc_id varchar(50),
    numero_mutuelle_1 varchar(20),
    str_debut_droit_amc date,
    str_fin_droit_amc date,
    str_derniere_visite date,
    solde varchar(50),
    commentaire_global varchar(250),
    date_naissance integer,
    str_fin_droit_amo1 date,
    t_couverture_amo1_id varchar(50),
    str_fin_droit_amo2 date,
    t_couverture_amo2_id varchar(50),
    str_fin_droit_amo3 date,
    t_couverture_amo3_id varchar(50),
    str_fin_droit_amo4 date,
    t_couverture_amo4_id varchar(50),
    str_fin_droit_amo5 date,
    t_couverture_amo5_id varchar(50),
    str_fin_droit_amo6 date,
    t_couverture_amo6_id varchar(50),
    str_fin_droit_amo7 date,
    t_couverture_amo7_id varchar(50),
    qualite integer,
    AModeGestionUnique char(1),
    t_commentaire_id dm_code)
as
declare variable t_client_id varchar(50);
declare variable t_organisme_amo1_id varchar(50);
declare variable numero_insee varchar(15);
declare variable rue_1 varchar(40);
declare variable rue_2 varchar(40);
declare variable code_postal varchar(10);
declare variable nom_ville varchar(30);
declare variable gsm varchar(20);
declare variable telephone varchar(20);
declare variable fax varchar(20);
declare variable centre_gestionnaire varchar(6);
begin
  t_client_id = t_client_assure_id || '-'||t_client_ordre_id;
  
  /* recup des infos assures */
  select
    numero_insee,
    substring(t_organisme_amo_id from 3 for 50),
    centre_gestionnaire,
    rue_1,
    rue_2,
    code_postal,
    nom_ville,
    tel_personnel,
    tel_mobile,
    fax
  from t_client
  where t_client_id = :t_client_assure_id
  into
    :numero_insee,
    :t_organisme_amo1_id,
    :centre_gestionnaire,
    :rue_1,
    :rue_2,
    :code_postal,
    :nom_ville,
    :telephone,
    :gsm,
    :fax ;

  execute procedure ps_wp_creer_assure(
    :t_client_id,
    :nom_prenom,
    :nom_long,
    :rue_1,
    :rue_2,
    :code_postal,
    :nom_ville,
    :telephone,
    :gsm,
    :fax,
    null,
    :t_organisme_amo1_id,
    iif(:centre_gestionnaire similar to '[[:DIGIT:]]*', :centre_gestionnaire, null),
    :numero_insee,
    :t_organisme_amc_id,
    :t_couverture_amc_id,
    :numero_mutuelle_1,
    :str_debut_droit_amc,
    :str_fin_droit_amc,
    null,
    null,
    :str_derniere_visite,
    :solde,
    :commentaire_global,
    :date_naissance,
    :str_fin_droit_amo1,
    :t_couverture_amo1_id,
    :str_fin_droit_amo2,
    :t_couverture_amo2_id,
    :str_fin_droit_amo3,
    :t_couverture_amo3_id,
    :str_fin_droit_amo4,
    :t_couverture_amo4_id,
    :str_fin_droit_amo5,
    :t_couverture_amo5_id,
    :str_fin_droit_amo6,
    :t_couverture_amo6_id,
    :str_fin_droit_amo7,
    :t_couverture_amo7_id,
    AModeGestionUnique,
    '');
  
  if ( t_commentaire_id > '' ) then 
    insert into t_winpharma_com_cli(t_commentaire_id,
                                    t_client_id)
    values ( :t_commentaire_id||'-2', -- on ajoute -2 pour le tbln 
             :t_client_id);           


  update t_client
  set qualite = 
    case    when :lien = 'A' then '0' -- assure ??
            when :lien = 'P' then '1' -- parent
            when :lien = 'C' then '2' -- conjoint
            when :lien = 'D' then '3' -- conjoint divorce
            when :lien = 'U' then '4' -- concubin
            when :lien = 'S' then '5' -- conjoint separe  
            when :lien = 'E' then '6' -- enfant 
            when :lien = 'B' then '7' -- benef hors art 113 
            when :lien = 'V' then '8' -- conjoint veuf
            when :lien = 'Y' then '9' -- autre 
          end
  where t_client_id = :t_client_id;
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_commentaire(
  AIDCom dm_code,
  AWType smallint,
  AMemo varchar(250),
  ATbln integer)
as
begin  
    insert into t_commentaire (t_commentaire_id,
                               t_entite_id,
                               type_entite,
                               commentaire,
                               est_global )
    values ( next value for seq_commentaire,
             ( select t_client_id from t_winpharma_com_cli where t_commentaire_id = :AIDCom||'-'||:ATbln ),  
             '0', -- client 
             cast(:AMemo as blob),
             iif(:AWType = 3,1,0) 
             ); -- global

end;

/***************************************************************************************/
/***************************************************************************************/
/**                                                                                   **/
/**                               PRODUITS                                            **/
/**                                                                                   **/
/***************************************************************************************/
/***************************************************************************************/

create or alter procedure ps_wp_creer_prestation (
    section integer,
    valeur varchar(200))
as
declare variable s1 varchar(2000);
declare i integer;
declare variable libelle varchar(50);
declare variable id varchar(50);
declare variable t_ref_prestation_id integer;
declare variable id_vignette varchar(50);
declare variable prestation varchar(50);
declare variable flag_detail varchar(50);
declare variable coef float;
begin

    /* code prestations */
    if (section = 11) then
    begin
    i = 1;
    for select AValeur from ps_separer_valeurs(:valeur, ',') into :s1 do
    begin
      if ( i = 1 ) then id = :s1;
      if ( i = 3 ) then prestation = :s1;
      if ( i = 4 ) then id_vignette = :s1;
      if ( i = 5 ) then libelle = :s1;
      if ( i = 7 ) then flag_detail = :s1;
      if ( i = 9 ) then coef = :s1;
      i = i+1;
    end
  
    
      select t_ref_prestation_id from t_ref_prestation where code = :prestation into :t_ref_prestation_id;

      if (t_ref_prestation_id is not null) then
      begin
        if ( prestation in ('PHN','PH1','PH2','PH4','PH7','AAD','PMR') ) then
          insert into t_wp_prestation ( t_prestation_wp_id , t_prestation_id, libelle, vignette,coef )
          values  ( :id_vignette,:t_ref_prestation_id, substring(:id_vignette ||' '||:prestation ||' '||:libelle from 1 for 50), '1',:coef );
        else
          insert into t_wp_prestation ( t_prestation_wp_id , t_prestation_id, libelle, vignette,coef )
          values  ( :id,:t_ref_prestation_id, :prestation , '0' ,:coef );
      end
      else 
        exception exp_win_prestation_inconnue;    
    end

end;

/* ********************************************************************************************** */

create or alter procedure ps_wp_creer_depot (
    valeur varchar(120))
as
declare variable longueur integer;
declare variable position_separateur integer;
declare variable id varchar(50);
declare variable code varchar(50);
declare variable libelle varchar(50);
declare variable efface varchar(50);
declare variable sous_chaine varchar(120);
declare variable type_depot varchar(10);

begin

  execute procedure ps_wp_separe_champ( valeur ,  '#') returning_values :id, :sous_chaine;
  execute procedure ps_wp_separe_champ( :sous_chaine ,  '#') returning_values :code, :sous_chaine;
  execute procedure ps_wp_separe_champ( :sous_chaine ,  '#') returning_values :libelle, :sous_chaine;
  execute procedure ps_wp_separe_champ( :sous_chaine ,  '#') returning_values :efface, :sous_chaine;
  execute procedure ps_wp_separe_champ( :sous_chaine ,  '#') returning_values :efface, :sous_chaine;
  execute procedure ps_wp_separe_champ( :sous_chaine ,  '#') returning_values :efface, :sous_chaine;

  if ((upper(:libelle) like '%VENTE%') or (upper(:libelle) like '%PHARMACIE%')) then 
   type_depot = 'SUVE';
  else
   type_depot = 'SUAL_R';

  if ( efface = '0' ) then  
     insert into t_depot values ( :id,:libelle,'0', :type_depot );
  else
    exception exp_win_depot_purge;

end;



/* ********************************************************************************************** */

create or alter procedure ps_wp_creer_repartiteur (
    t_repartiteur_id varchar(50),
    raison_sociale varchar(50),
    rue_1 varchar(70),
    rue_2 varchar(70),
    code_postal varchar(5),
    nom_ville varchar(70),
    numero_appel varchar(20),
    tel_personnel varchar(20),
    tel_mobile varchar(20),
    fax varchar(20),
    web varchar(200),
    commentaire varchar(250),
    identifiant_171 varchar(12),
    login varchar(20),
    motdepasse varchar(20),
    pharmaml_ref_id varchar(4),
    pharmaml_url_1 varchar(150),
    pharmaml_url_2 varchar(150),
    pharmaml_id_officine varchar(20),
    pharmaml_id_magasin varchar(20),
    pharmaml_cle varchar(4))
as
declare variable mode_transmission char(1);
begin

    if (pharmaml_ref_id = '' ) then  pharmaml_ref_id = null;

    if ( identifiant_171 <> '' ) then
        mode_transmission = '1';
    else
        mode_transmission = '5';


    insert into t_repartiteur (
            t_repartiteur_id,
            raison_sociale,
            rue_1,
            rue_2,
            code_postal,
            nom_ville,
            commentaire,
            numero_appel,
            tel_personnel,
            tel_mobile,
            fax,
            vitesse_171,
            identifiant_171,
            mode_transmission,
            nombre_tentatives,
            pharmaml_ref_id,
            pharmaml_url_1,
            pharmaml_url_2,
            pharmaml_id_officine,
            pharmaml_id_magasin,
            pharmaml_cle )
    values (
            :t_repartiteur_id,
            :raison_sociale,
            substring(:rue_1 from 1 for 40),
            substring(:rue_2 from 1 for 40),
            :code_postal,
            substring(:nom_ville from 1 for 30),
            substring(:commentaire from 1 for 200),
            :numero_appel,
            :tel_personnel,
            :tel_mobile,
            :fax,
            1,
            substring(:identifiant_171 from 1 for 8),
            :mode_transmission,
            1,
            :pharmaml_ref_id,
            :pharmaml_url_1,
            :pharmaml_url_2,
            :pharmaml_id_officine,
            :pharmaml_id_magasin,
            :pharmaml_cle);

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_fournisseur (
    t_fournisseur_id varchar(50),
    raison_sociale varchar(50),
    rue_1 varchar(70),
    rue_2 varchar(70),
    code_postal varchar(5),
    nom_ville varchar(70),
    numero_appel varchar(20),
    tel_personnel varchar(20),
    fax varchar(20),
    commentaire varchar(200),
    identifiant_171 varchar(12),
    represente_par varchar(50),
    numero_fax varchar(20),
    email varchar(50),
    portable_rep varchar(20),
    telephone_rep varchar(20))
as
declare variable mode_transmission char(1);
begin


    if ( identifiant_171 <> '' ) then
        mode_transmission = '1';
    else
        mode_transmission = '5';


    insert into t_fournisseur_direct (
            t_fournisseur_direct_id,
            raison_sociale,
            rue_1,
            rue_2,
            code_postal,
            nom_ville,
            commentaire,
            numero_appel,
            tel_mobile,
            fax,
            vitesse_171,
            identifiant_171,
            mode_transmission,
            nombre_tentatives,
            represente_par,
            telephone_representant,
            numero_fax,            
            email
            )
    values (
            :t_fournisseur_id,
            :raison_sociale,
            substring(:rue_1 from 1 for 40),
            substring(:rue_2 from 1 for 40),
            :code_postal,
            substring(:nom_ville from 1 for 30),
            :commentaire,
            :numero_appel,
            :tel_personnel,
            :fax,
            1,
            substring(:identifiant_171 from 1 for 8),
            :mode_transmission,
            1,
            :represente_par,

            iif(:portable_rep = '', :telephone_rep, :portable_rep),
            :numero_fax,
            :email);

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_zonegeo (
    t_zone_geographique_id varchar(50),
    libelle varchar(50)

)
as
begin

    insert into t_zone_geographique (
            t_zone_geographique_id,
            libelle
            )
    values (:t_zone_geographique_id,
            :libelle
            );

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_codif (
    ti integer, 
    parent_ti integer, 
    code_categorie varchar(10),
    libelle varchar(64))
as
begin
  
  /* la classif parent n'existe pas on en creer une temporaire*/
  if ( (:parent_ti<>-1) and (not(exists(select * from t_classification_interne where t_classification_interne_id = :parent_ti)
      ) ) ) then
    insert into t_classification_interne(t_classification_interne_id, 
                                         libelle)
    values (:parent_ti,
            'classif temporaire '|| :parent_ti);

  /* si la classif existe deja , la completer */
  if (exists(select * from t_classification_interne where t_classification_interne_id = :ti)  ) then 
    update t_classification_interne set libelle = substring(:libelle from 1 for 50) where t_classification_interne_id = :ti ;
  else
    insert into t_classification_interne(t_classification_interne_id, 
                                         libelle,
                                         t_class_interne_parent_id)
    values (:ti,
            substring(:libelle from 1 for 50),
            iif(:parent_ti=-1, null, :parent_ti));
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_determiner_type_cat(
  id integer)
returns(
  t char(1))
as
declare variable id_parent integer;
declare variable l varchar(64);
begin
  select t_categorie_parent_id, libelle
  from t_wp_categorie
  where t_categorie_id = :id
  into :id_parent, :l;
  
  if (row_count > 0) then
    if (id_parent = -1) then
      t = case
            when l = 'INTERNE' then '0'
            when l = 'GAMMES FOURN' then '1'
            when l = 'GENERIQUES' then '2'
            when l = 'GESTION MARGE'  then '3'
            when l = 'LIBRE' then '4'
            when l = 'CATÉGORIE FORME' then '5'
          end;
    else
      execute procedure ps_wp_determiner_type_cat(id_parent) returning_values :t; 
  else
    t = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_codif_produit(
  cip integer,
  ti integer,
  libelle_n varchar(64),
  libelle_n1 varchar(64),
  libelle_n2 varchar(64),
  libelle_n3 varchar(64),
  libelle_n4 varchar(64),
  codification char(1))
as
declare variable c varchar(50);
declare variable c1 varchar(50);
declare variable c2 varchar(50);
declare variable c3 varchar(50);
declare variable c4 varchar(50);
declare variable c5 varchar(50);
declare variable tmp varchar(50);
declare variable t char(1);
begin
  execute procedure ps_wp_determiner_type_cat(:ti) returning_values :t; 
  if (t = codification) then
  begin
    execute procedure ps_renvoyer_id_codification_2('1', substring(libelle_n from 1 for 50)) returning_values c1;
    execute procedure ps_renvoyer_id_codification_2('2', substring(libelle_n1 from 1 for 50)) returning_values c2;
    execute procedure ps_renvoyer_id_codification_2('3', substring(libelle_n2 from 1 for 50)) returning_values c3;
    execute procedure ps_renvoyer_id_codification_2('4', substring(libelle_n3 from 1 for 50)) returning_values c4;
    execute procedure ps_renvoyer_id_codification_2('5', substring(libelle_n4 from 1 for 50)) returning_values c5;

    if (c5 is not null) then
    begin
      tmp = c5; c5 = c1; c1 = tmp;
      tmp = c4; c4 = c2; c4 = tmp;
    end
    else
      if ((c5 is null) and (c4 is not null)) then
      begin
        tmp = c4; c4 = c1; c1 = tmp;
        tmp = c3; c3 = c2; c2 = tmp;
      end
      else
        if ((c5 is null) and (c4 is null) and (c3 is not null)) then
        begin
          tmp = c3; c3 = c1; c1 = tmp;
        end
        else
          if ((c5 is null) and (c4 is null) and (c3 is null) and (c2 is not null)) then
          begin
            tmp = c2; c2 = c1; c1 = tmp;
          end

    c = cast(cip as varchar(50));
    update t_produit
    set t_codif_1_id = :c1,
        t_codif_2_id = :c2,
        t_codif_3_id = :c3,
        t_codif_4_id = :c4,
        t_codif_5_id = :c5
    where t_produit_id = :c;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_produit (
    t_produit_id varchar(50),
    designation varchar(50),
    code_13 varchar(15),
    liste char(1),
    base_remboursement float,
    prix_achat_catalogue float,
    pamp float,
    prix_vente float,
    taux_wp_id varchar(50),
    remboursement_wp_id varchar(50),
    forme_wp_id varchar(50),
    t_prestation_wp_id varchar(50),
    stock_mini integer,
    stock_maxi integer,
    commandes char(1), --Case commande dans Winpharma
    optimisation char(1),--Case optimisation
    gestionenpromis char(1), -- Case : détenir en stock toujours la quantité max
  --Case coché qui peux etre coché avec la case gérer en promis OU optimisation + un stock maxi
    etiquette char(1),
    pas_cmd_grossiste char(1),
    colisage varchar(5),
    marque varchar(50),
    date_derniere_vente date,
    peremption date,
    unite_contenance varchar(3),
    contenance numeric(18,0),
    homeo char(10),
    commentaire_produit varchar(260),
    code_tips varchar(13))
as
declare variable taux_tva numeric(10,2);
declare variable code_cip varchar(13);
declare variable unite_mesure char(1);
declare variable tableau char(1);
declare variable type_homeo char(1);
declare variable profil_gs char(1);
declare variable etat char(1);
declare variable calcul_gs char(1);
declare variable t_ref_prestation_id integer;
declare variable t_ref_tva_id integer;
--declare variable t_codif_4 integer;
declare variable commentaire varchar(200);
declare variable type_code char(1);
declare variable intMarque dm_cle;
declare variable strMarque dm_libelle;
declare variable code_ean13 varchar(13);
begin

    tableau='0';
    if ( liste='1' ) then tableau = 1;
    if ( liste='2' ) then tableau = 2;
    if ( liste='S' ) then tableau = 3;


    unite_mesure=0;etat='1';
    
    if (( code_13 not similar to '340[01][[:DIGIT:]]{9}') and ( code_13 not similar to '[[:DIGIT:]]{7}')) then
    begin
      code_ean13 = substring(trim(code_13) from 1 for 13); 
      code_cip = null;
    end  
    else 
    begin
      code_cip = substring(trim(code_13) from 1 for 13); 
      code_ean13 = null;
    end

    /* prestation a  partir du code remboursement ( vignette ) */
    select t_prestation_id from t_wp_prestation where t_prestation_wp_id =:remboursement_wp_id and vignette = 1 into :t_ref_prestation_id;

    /* prestation a  partir du code acte si ca n a rien donné*/
    if (:t_ref_prestation_id is null) then
        select t_prestation_id from t_wp_prestation where t_prestation_wp_id = :t_prestation_wp_id and vignette = 0 into :t_ref_prestation_id;

    /* si toujours rien => NR */
    if (:t_ref_prestation_id is null) then
     select t_ref_prestation_id from  t_ref_prestation   where code = 'PHN' into :t_ref_prestation_id;

    taux_tva = 0 ;
    if ( taux_wp_id = 1 ) then taux_tva = 2.1;
    if ( taux_wp_id = 2 ) then taux_tva = 20;
    if ( taux_wp_id = 3 ) then taux_tva = 5.5;
    if ( taux_wp_id = 5 ) then taux_tva = 10;

    --select t_ref_tva_id from t_ref_tva  where  ((taux-:taux_tva)*(taux-:taux_tva)) < 0.1  into :t_ref_tva_id;
    execute procedure ps_renvoyer_id_tva(:taux_tva) returning_values :t_ref_tva_id;
    
    if ( contenance > 0  ) then        /* pas tres important mais a voir qd mm*/
    begin
        if ( unite_contenance = 'KG' ) then
        begin
            unite_mesure = '1' ;

        end
        if ( unite_contenance = 'G' )  then
        begin
            unite_mesure = '2' ;
            contenance = contenance / 1000 ;
        end
        if ( unite_contenance = 'DG' ) then
        begin
            unite_mesure = '3' ;
            contenance = contenance / 10000 ;
        end
        if ( unite_contenance = 'CG' ) then
        begin
            unite_mesure = '4' ;
            contenance = contenance / 100000 ;
        end
        if ( unite_contenance = 'MG' ) then
        begin
            unite_mesure = '5' ;
            contenance = contenance / 1000000 ;
        end
        if ( unite_contenance = 'L' )  then
            unite_mesure = '6' ;

        if ( unite_contenance = 'CL' ) then
        begin
            unite_mesure = '8' ;
            contenance = contenance / 100 ;
        end
        if ( unite_contenance = 'ML' ) then
        begin
            unite_mesure = '9' ;
            contenance = contenance / 1000 ;
        end
    end
    else
        contenance = null;

    if ( contenance > 99999 ) then
    begin
       contenance =0;
    end

    /* si commandes = 1 => gestion de stock */
    if (pas_cmd_grossiste = '1') then
      profil_gs = '2';
    else
      if (commandes<>'0') then
          profil_gs = '0';
      else
          profil_gs = '2';

    /* si optimisation = 1 => gestion de stock sur historique de vente */

    if (optimisation = '1' ) then
        calcul_gs = '0';
    else
        calcul_gs = '4';

    if  ((gestionenpromis = '1' ) and (stock_maxi=0)) then
    begin
        calcul_gs = '4';
        stock_mini=0;
        stock_maxi=0;
    end

    if  ((gestionenpromis = '1' ) and (stock_maxi>0)) then
    begin
        calcul_gs = '4';
        stock_mini=:stock_maxi;
        stock_maxi=:stock_maxi;
    end

    if( stock_maxi < stock_mini)  then stock_maxi = null;
  
    if (homeo = '6') then
        type_homeo = '1';
    else
        if (homeo = '7') then
            type_homeo = '2';
        else
            type_homeo = '0';

    execute procedure ps_renvoyer_id_marque(:marque) returning_values :intMarque;

    insert into t_produit ( t_produit_id,
                            date_derniere_vente,
                            code_cip,
                            designation,
                            prix_achat_catalogue,
                            prix_achat_remise,
                            prix_vente,
                            base_remboursement,
                            edition_etiquette,
                            t_ref_tva_id,
                            liste,
                            t_ref_prestation_id,
                            service_tips,
                            t_codif_6_id,
                            type_homeo,
                            pamp,
                            profil_gs,
                            calcul_gs,
                            etat,
                            contenance,
                            unite_mesure,
                            --t_codif_4_id,
                            commentaire_vente,
                            stock_mini,
                            stock_maxi,
                            date_peremption,
                            lot_achat)
    values (:t_produit_id,
            :date_derniere_vente,
            trim(:code_cip),
            :designation,
            :prix_achat_catalogue,
            :pamp, -- mieux vaut y mettre le pamp plutot que rien 
            :prix_vente,
            :base_remboursement,
            :etiquette,
            :t_ref_tva_id,
            :tableau,
            :t_ref_prestation_id,
            null,
            :intMarque,
            :type_homeo,
            :pamp,
            :profil_gs,
            :calcul_gs,
            :etat,
            :contenance,
            :unite_mesure,
            --:t_codif_4,
            substring( :commentaire_produit from 1 for 200),
            :stock_mini,
            :stock_maxi,
            :peremption,
            :colisage );

    if (code_ean13 <> '' )  then
      insert into t_code_ean13 (t_code_ean13_id,t_produit_id,code_ean13) 
      values (next value for  seq_code_ean13,:t_produit_id,:code_ean13);

    if ((code_tips similar to '[[:ALNUM:]]*') and (code_tips <> '')) then
    begin
      insert into t_produit_lpp(t_produit_lpp_id,t_produit_id,type_code,code_lpp,quantite,tarif_unitaire)
      values (next value for seq_produit_lpp,:t_produit_id,'2',:code_tips,1,:base_remboursement);
    end
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_stock(
    t_produit_id varchar(50),
    t_depot_id varchar(50),
    t_zone_geographique_id varchar(50),
    quantite integer,
    stock_mini integer,
    stock_maxi integer)
as
begin

    insert into t_produit_geographique (t_produit_geographique_id,
                                        t_produit_id,
                                        quantite,
                                        t_zone_geographique_id,
                                        t_depot_id,
                                        stock_mini,
                                        stock_maxi)
    values (next value for seq_produit_geographique ,
            :t_produit_id,
            :quantite,
            :t_zone_geographique_id,
            :t_depot_id,
            :stock_mini,
            :stock_maxi);

    -- MAJ de la quantite stock TOTALE sur depot de VENTE
    if ( t_depot_id <> '0') then
      update t_produit_geographique
      set quantite = quantite - :quantite
      where t_depot_id = '0' and t_produit_id = :t_produit_id ;

end;



/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_code_ean13(
  ean varchar(14),
  pro_cip dm_code)
as
begin
 if ( ean not similar to '340[01][[:DIGIT:]]{9}' ) then
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id,
                             code_ean13)
    values(next value for seq_code_ean13,
           :pro_cip,
           substring(:ean from 1 for 13));
 else
    update t_produit 
    set code_cip = trim(:ean)
    where t_produit_id = :pro_cip and code_cip is null;  
end;

create or alter procedure ps_wp_creer_code_lpp(
  cip varchar(50),
  code_lppr varchar(10),
  qte integer,
  tarif float
  )
as
begin
  -- si vieux codes tips qui traine , gicler
  delete from t_produit_lpp where t_produit_id = :cip and type_code = 2;
  
  
  if ((code_lppr is not null) and (code_lppr <> '')) then
  begin
    insert into t_produit_lpp(t_produit_lpp_id,
                              t_produit_id,
                              type_code,
                              code_lpp,
                              quantite,
                tarif_unitaire)
    values (next value for seq_produit_lpp,
            :cip,
            '0',
            :code_lppr,
            iif((:qte is null) or (:qte <=0 ), 1, :qte),
      :tarif
      );
  end

  
  
end;

/***************************************************************************************/
/**                        HISTORIQUES DE VENTES                                      **/
/***************************************************************************************/
create or alter procedure ps_wp_historique_vente(
  t_produit_id varchar(50),
  periode date,
  qte_sortie integer
  )
returns(
  periode_suivante date)
as
declare variable strPeriode varchar(6);
begin
  periode_suivante = dateadd(month, -1, periode);

  if (qte_sortie > 0) then
  begin
    strPeriode = substring(cast(periode as varchar(25)) from 6 for 2) ||
                 substring(cast(periode as varchar(25)) from 1 for 4);

    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   periode,
                                   quantite_vendues,
                                   quantite_actes)
    values(next value for seq_historique_vente,
           :t_produit_id,
           :strPeriode,
           :qte_sortie,
           :qte_sortie);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_historique_vente (
    t_produit_id varchar(50),
    qte_sortie_0 integer,
    qte_sortie_1 integer,
    qte_sortie_2 integer,
    qte_sortie_3 integer,
    qte_sortie_4 integer,
    qte_sortie_5 integer,
    qte_sortie_6 integer,
    qte_sortie_7 integer,
    qte_sortie_8 integer,
    qte_sortie_9 integer,
    qte_sortie_10 integer,
    qte_sortie_11 integer,
    qte_sortie_12 integer,
    qte_sortie_13 integer,
    qte_sortie_14 integer,
    qte_sortie_15 integer,
    qte_sortie_16 integer,
    qte_sortie_17 integer,
    qte_sortie_18 integer,
    qte_sortie_19 integer,
    qte_sortie_20 integer,
    qte_sortie_21 integer,
    qte_sortie_22 integer,
    qte_sortie_23 integer,
    qte_sortie_24 integer)
as
declare variable periode date;
declare variable now timestamp;
declare variable ddv date;
begin
  select date_derniere_vente from t_produit
  where t_produit_id = :t_produit_id
  into ddv;

  if ((ddv is not null) and (ddv <current_date ) ) then
    periode = ddv;
  else
    periode = current_date;

  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_0) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_1) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_2) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_3) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_4) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_5) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_6) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_7) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_8) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_9) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_10) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_11) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_12) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_13) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_14) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_15) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_16) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_17) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_18) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_19) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_20) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_21) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_22) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_23) returning_values :periode;
  execute procedure ps_wp_historique_vente(:t_produit_id, :periode, :qte_sortie_24) returning_values :periode;


end;




/***************************************************************************************/
/**                        HISTORIQUES DELIVRANCES                                    **/
/***************************************************************************************/
create or alter procedure ps_wp_creer_historique_client (
    t_historique_client_id varchar(50),
    t_client_assure_id varchar(50),
    t_client_ordre_id  varchar(50),
    numero_facture numeric(10,0),
    date_prescription date,
    code_operateur varchar(10),
    t_praticien_id varchar(50),
    praticien_nom varchar(50),
    date_acte date)
as
declare variable t_client_id varchar(50);
begin

  if (:t_client_ordre_id <> '0') then
    t_client_id = :t_client_assure_id||'-'||:t_client_ordre_id;
  else
    t_client_id = :t_client_assure_id;

  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  numero_facture,
                                  date_prescription,
                                  code_operateur,
                                  t_praticien_id,
                                  nom_praticien,
                                  type_facturation ,
                                  date_acte )
   values(:t_historique_client_id,
          :t_client_id,
          :numero_facture,
          :date_prescription,
          :code_operateur,
          :t_praticien_id,
          :praticien_nom,
          '1',
          :date_acte );
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_histo_client_ligne (
    t_historique_client_id varchar(50),
    t_produit_id varchar(50),
    quantite_delivree integer,
    prix_vente float)
as
declare variable designation varchar(50);
declare variable code_cip varchar(13);
declare variable date_vente date;
begin
  select designation, code_cip
  from t_produit 
  where t_produit_id = trim(:t_produit_id) 
  into :designation, :code_cip ;
  
  select date_acte 
  from t_historique_client 
  where t_historique_client_id = :t_historique_client_id 
  into :date_vente;

  if ( trim(code_cip) = '' ) then code_cip = null ;

  if (row_count = 0) then
      t_produit_id = null;

  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                        t_historique_client_id,
                                        t_produit_id,
                                        code_cip,
                                        designation,
                                        quantite_facturee,
                                        prix_vente)
  values(next value for seq_historique_client_ligne,
         :t_historique_client_id,
         trim(:t_produit_id),
         :code_cip,
         :designation,
         :quantite_delivree,
         :prix_vente);

  update t_produit 
  set date_derniere_vente = :date_vente 
  where t_produit_id = trim(:t_produit_id);

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_catalogue(
    t_fournisseur_id varchar(50),
    t_produit_id varchar(50),
    prix_achat float,
    remise float,
    priorite integer)
as
declare variable prix_achat_remise numeric(10,3);
declare variable strRS dm_libelle;
declare variable intDernierNoLigne dm_numeric5;
begin
  prix_achat_remise = prix_achat - remise*prix_achat/100;
  if ((priorite = 1) and (exists(select t_repartiteur_id from t_repartiteur where t_repartiteur_id = :t_fournisseur_id))) then
    update t_produit
    set prix_achat_remise =  :prix_achat_remise,
        prix_achat_catalogue = :prix_achat,
        t_repartiteur_id = :t_fournisseur_id
    where t_produit_id = :t_produit_id;

  if (exists(select t_fournisseur_direct_id from t_fournisseur_direct where t_fournisseur_direct_id = :t_fournisseur_id)) then
  begin
    if (not(exists(select *
                   from t_catalogue
                   where t_fournisseur_id = :t_fournisseur_id))) then
    begin
      select raison_sociale
      from t_fournisseur_direct
      where t_fournisseur_direct_id = :t_fournisseur_id
      into :strRS;

      insert into t_catalogue (
        t_catalogue_id,
        designation,
        date_debut,
        date_fin,
        t_fournisseur_id,
        date_creation,
        date_fin_validite)
      values (
        :t_fournisseur_id,
        'Catalogue ' || :strRS,
        current_date,
        null,
        :t_fournisseur_id,
        current_date,
        null);
    end

    select coalesce(max(no_ligne) + 1, 1)
    from t_catalogue_ligne
    where t_catalogue_id = :t_fournisseur_id
    into :intDernierNoLigne;

    insert into t_catalogue_ligne(t_catalogue_ligne_id,
                                  t_catalogue_id,
                                  t_classification_fournisseur_id,
                                  no_ligne,
                                  t_produit_id,
                                  prix_achat_catalogue,
                                  prix_achat_remise,
                                  remise_simple,
                                  date_maj_tarif,
                                  date_creation)
    values(next value for seq_catalogue_ligne,
           :t_fournisseur_id,
           null,
           :intDernierNoLigne,
           :t_produit_id,
           :prix_achat,
           :prix_achat_remise,
           :remise,
           current_date,
           current_date);

  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_operateur (
    section integer,
    valeur varchar(255))
as
declare variable libelle varchar(50);
declare variable id varchar(50);
declare variable sous_chaine varchar(255);

begin
    /* code operateur */
    if (section = 2) then
    begin
     execute procedure ps_wp_separe_champ( valeur ,  ',') returning_values :id, :sous_chaine;
     execute procedure ps_wp_separe_champ( :sous_chaine ,  ',') returning_values :libelle, :sous_chaine;

     insert into t_operateur(t_operateur_id ,
                          nom ,
                          mot_de_passe,
                          activation_operateur)
     values(:id,
         :libelle,
         '',
         '1');

    end

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_forcetrans
as
begin

  if (not exists(select t_destinataire_id from t_destinataire)) then
    insert into t_destinataire (t_destinataire_id,nom) values (1,'DESTINATAIRE T');
  update t_organisme set t_destinataire_id = '1' where identifiant_national <> '';
  update t_organisme set t_destinataire_id = '1' where caisse_gestionnaire <> '';
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_avance (
    t_client_assure_id varchar(50),
    t_client_ordre_id varchar(50),
    date_fact date,
    numero_attente integer,
    t_produit_id varchar(50),
    quantite numeric(5,0),
    prix_vente float,
    base_remboursement float,
    t_operateur_id varchar(10))
as
declare variable t_client_id varchar(50);
declare variable code_cip varchar(13);
declare variable code_prestation varchar(3);
declare variable designation varchar(50);
begin

  if (:t_client_ordre_id <> '0') then
    t_client_id = :t_client_assure_id||'-'||:t_client_ordre_id;
  else
    t_client_id = :t_client_assure_id;

  if (not exists(select * from t_operateur  where t_operateur_id = :t_operateur_id)) then
    select first 1 t_operateur_id
    from t_operateur
    into :t_operateur_id;

    select
        pre.code,
        prd.code_cip,
        prd.designation
    from t_produit prd
    left join t_ref_prestation pre on pre.t_ref_prestation_id = prd.t_ref_prestation_id
    where t_produit_id = :t_produit_id
    into :code_prestation,
         :code_cip,
         :designation;



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
               :t_client_id,
               :date_fact,
               :code_cip,
               :designation,
               :prix_vente,
               0,
               :code_prestation,
               :t_produit_id,
               :t_operateur_id,
               :quantite,
               :base_remboursement);

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_fact_att (
    t_client_assure_id varchar(50),
    t_client_ordre_id varchar(50),
    date_fact date,
    numero_facture varchar(50))
as
declare variable t_client_id varchar(50);

begin

  if (:t_client_ordre_id <> '0') then
    t_client_id = :t_client_assure_id||'-'||:t_client_ordre_id;
  else
    t_client_id = :t_client_assure_id;


   insert into t_facture_attente(t_facture_attente_id,
                                 date_acte,
                                 t_client_id)
        values(:numero_facture,
               :date_fact,
               :t_client_id);

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_fact_att_ligne (
    numero_facture varchar(50),
    t_produit_id varchar(50),
    quantite numeric(5,0),
    prix_vente float
    )
as
declare variable t_ref_prestation_id integer;

begin

  select
    t_ref_prestation_id
  from t_produit
  where t_produit_id  = :t_produit_id
  into
    :t_ref_prestation_id;


  insert into t_facture_attente_ligne(t_facture_attente_ligne_id,
                                      t_facture_attente_id,
                                      t_produit_id,
                                      quantite_facturee,
                                      t_ref_prestation_id,
                                      prix_vente,
                                      prix_achat)
        values(next value for seq_facture_attente_ligne,
               :numero_facture,
               :t_produit_id,
               :quantite,
               :t_ref_prestation_id,
               :prix_vente,
               0);

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_compte_collec (
    t_compte_id varchar(50),
    nom varchar(60),
    rue_1 varchar(40),
    rue_2 varchar(40),
    code_postal varchar(5),
    nom_ville varchar(30),
    tel_standard varchar(20),
    fax varchar(20),
    tel_mobile varchar(20),
    remise float)
as
declare variable t_profil_remise_id varchar(50);
declare variable t_param_remise_fixe_id varchar(50);
begin
  if ( remise > 0 ) then
  begin
    t_profil_remise_id = cast(remise as varchar(10));
    t_param_remise_fixe_id = cast(remise as varchar(10));

    if (not(exists(select t_param_remise_fixe_id from t_param_remise_fixe where t_param_remise_fixe_id=:t_param_remise_fixe_id))) then
    begin
      insert into t_param_remise_fixe (t_param_remise_fixe_id,
                                       taux)
      values(:t_param_remise_fixe_id,
             :remise);

      insert into t_profil_remise(t_profil_remise_id,
                                  libelle,
                                  sur_vente_directe,
                                  sur_facture_ciale,
                                  sur_facture_retro,
                                  sur_ordonnance,
                                  t_param_remise_fixe_id,
                                  type_remise)
      values(:t_param_remise_fixe_id,
             'profil '||:remise||'%',
             '1',
             '1',
             '1',
             '0',
             :t_param_remise_fixe_id,
             '0');
    end
  end
  else
    t_profil_remise_id = null;

  insert into t_compte(t_compte_id,
                       nom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_standard,
                       fax,
                       tel_mobile,
                       payeur,
                       t_profil_remise_id)
  values('CPT'||:t_compte_id,
         substring(:nom from 1 for 30 ),
         :rue_1,
         :rue_2,
         :code_postal,
         :nom_ville,
         :tel_standard,
         :fax,
         :tel_mobile,
         'A',
         :t_profil_remise_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_compte_adh (
    t_client_id varchar(50),
    t_compte_id varchar(50))
as
begin


   /* une liaison dans t_compteclient */
  insert into t_compte_client
      values(next value for seq_compte_client,
             'CPT'||:t_compte_id ,
             :t_client_id
             );

end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_commande (
  nocomgros integer,
  Dtime_Send date,
  DT_livraison date,
  montantHT float,
  memo varchar(40),
  code_fourn varchar(8),
  etape char(1))
as
declare variable dtCreation date;
declare variable r varchar(50);
declare variable f varchar(50);
declare variable t char(1);
declare variable nocom varchar(20);
begin
  if ((Dtime_Send is not null) or (DT_livraison is null)) then
    dtCreation = Dtime_Send;
  else
    dtCreation =  :DT_livraison;

  if (exists(select t_repartiteur_id
             from t_repartiteur
             where t_repartiteur_id = :code_fourn)) then
  begin
    r = code_fourn;
    f = null;
    t = '2';
  end
  else
    if (exists(select t_fournisseur_direct_id
               from t_fournisseur_direct
               where t_fournisseur_direct_id = :code_fourn)) then
    begin
      f = code_fourn;
      r = null;
      t = '1';
    end

  if (nocomgros> 268435456) then 
    nocom = nocomgros-268435456 ;
  else
    nocom = nocomgros ;  


  insert into t_commande(t_commande_id,
                         type_commande,
                         date_creation,
                         date_reception,
                         mode_transmission,
                         montant_ht,
                         commentaire,
                         t_repartiteur_id,
                         t_fournisseur_direct_id,
                         etat)
  values(:nocomgros,
         :t,
         :dtCreation,
         :DT_livraison,
         '5',
         :montantHT,
         '['||:nocom||'] '||:memo,
         :r,
         :f,
         case
           when :etape = '1' then '2' -- En cours
           when :etape = '2' then '22' --  Receptionnée quantitativement
           else '3' -- Archivée
         end);
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_commande_ligne (
  nocomgros integer,
  cip integer,
  quantite smallint,
  qte_r smallint,
  qteUG smallint,
  prix_HT float,
  remise1 float,
  prixv_ttc float,
  dtLivraison date,
  dtLivraisonReel date)
as
declare variable c varchar(50);
declare variable ftPAR float;
declare dtReception date;
begin
  c = cast(nocomgros as varchar(50));
  ftPAR = prix_HT - remise1 * prix_HT / 100;

  select date_reception
  from t_commande
  where t_commande_id = :c
  into :dtReception;

  if (dtReception is null) then
    update t_commande
    set date_reception = coalesce(:dtLivraison, :dtLivraisonReel)
    where t_commande_id = :c;

  insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               prix_vente,
                               quantite_totale_recue,
                               unites_gratuites)
  values(next value for seq_commande_ligne,
         :c,
         :cip,
         :quantite,
         :qte_r,
         :prix_HT,
         :ftPAR,
         :prixv_ttc,
         :qte_r,
         :qteUG);
end;
              
/* ********************************************************************************************** */
create or alter procedure ps_wp_maj_ligne_commande(
  nocomgros integer,
  cip integer,
  qtec smallint,
  qteug smallint,
  qteRecue smallint,
  PrixPublic float)
as
declare variable c varchar(50);
declare variable p varchar(50);
declare variable lc integer;
begin
  c = cast(nocomgros as varchar(50));
  p = cast(cip as varchar(50));
  
  select t_commande_ligne_id
  from t_commande_ligne
  where t_commande_id = :c and t_produit_id = :p
  into :lc;
  
  if (row_count > 0) then
    update t_commande_ligne
    set quantite_commandee = quantite_commandee + :qtec,
        unites_gratuites = unites_gratuites + :qteug,
        quantite_recue =quantite_recue + :qteRecue,
        quantite_totale_recue = quantite_totale_recue+ :qteRecue
    where t_commande_ligne_id = :lc;
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_prix_dom as
declare variable t_prestation_id integer;
declare variable coef float;
begin
  for select t_prestation_id,
             coef
    from T_WP_PRESTATION
    where coef <> 1 and coef <> 0
    into :t_prestation_id,
           :coef
  do
  update t_produit
  set prix_vente = prix_vente*:coef,
    base_remboursement = base_remboursement*:coef
  where t_ref_prestation_id = :t_prestation_id;


end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_spsante
returns (
    nb_spsante_in integer,
    nb_spsante_cli integer,
    nb_spsante_out integer)
as
declare variable organisme_spsante varchar(50);
declare variable rue_1 varchar(40);
declare variable rue_2 varchar(40);
declare variable code_postal varchar(5);
declare variable nom_ville varchar(30);
declare variable t_destinataire_id varchar(50);
declare variable t_client_id varchar(50);
declare variable t_couverture_amc_id varchar(50);
declare variable contrat_sante_pharma varchar(20);
declare variable spsante_courante varchar(20);
declare variable spsante_couverture varchar(20);
declare variable lintpos integer;
declare variable identifiant_national varchar(8);
declare variable nomspsante varchar(50);
begin
    nb_spsante_cli =0;
    nb_spsante_in =0;
    nb_spsante_out =0;
  /* trouver le (les) organisme(s) spsante */
    for
      select t_organisme_id,
             rue_1,
             rue_2,
             code_postal,
             nom_ville,
             t_destinataire_id
      from t_organisme
      where type_organisme = 2
        and org_sante_pharma = 1
    into :organisme_spsante,
           :rue_1,
           :rue_2,
           :code_postal,
           :nom_ville,
           :t_destinataire_id

   do
   begin
      nb_spsante_in = nb_spsante_in +1;
      spsante_courante = '';
      for select cli.t_client_id,
                 cli.t_couverture_amc_id,
                 cli.contrat_sante_pharma
          from t_client cli

          where cli.t_organisme_amc_id = :organisme_spsante
            and cli.contrat_sante_pharma <> ''
            and cli.contrat_sante_pharma is not null
          order by cli.contrat_sante_pharma,
                   cli.t_couverture_amc_id
          into :t_client_id,
               :t_couverture_amc_id,
               :contrat_sante_pharma do
      begin
        /* creation organisme supp. spsante */
        lintpos = position('PH100' in contrat_sante_pharma);
        if (lintpos > 0) then
        begin
                if ((substring(contrat_sante_pharma from 1 for lintpos - 1) <> spsante_courante) and ( char_length(substring(contrat_sante_pharma from 1 for lintpos - 1)) <> 11 ))   then
                begin
                  nb_spsante_out = nb_spsante_out +1;
                  spsante_courante = substring(contrat_sante_pharma from 1 for lintpos - 1);
                  spsante_couverture = '';
                  select nom from t_ref_organisme where identifiant_national = :spsante_courante into :nomspsante;
                  if (nomspsante is null ) then  nomspsante = 'Org INCONNU no:'||:spsante_courante;
                  identifiant_national = lpad(spsante_courante, 8, '0') ;
                  if (not ( exists( select t_organisme_id from t_organisme where t_organisme_id = 'MSPSANTE' || :spsante_courante))) then
          insert into t_organisme(type_organisme,
                                          t_organisme_id,
                                          nom,
                                          nom_reduit,
                                          rue_1,
                                          rue_2,
                                          code_postal,
                                          nom_ville,
                                          type_releve,
                                          identifiant_national,
                                          t_destinataire_id,
                                          org_sante_pharma,
                                          prise_en_charge_ame,
                                          type_contrat,
                                          saisie_no_adherent)
          values('2',
                         'MSPSANTE' || :spsante_courante,
                         :nomspsante ,
                         :spsante_courante,
                         :rue_1,
                         :rue_2,
                         :code_postal,
                         :nom_ville,
                         '0',
                         :identifiant_national,
                         :t_destinataire_id,
                         '0',
                         '0',
                         0,
                         '0'
                         );
                end

                nb_spsante_cli = nb_spsante_cli +1;

                /* creation couverture pour org. supp. spsante */
                if (t_couverture_amc_id <> spsante_couverture) then
                begin
                     spsante_couverture = t_couverture_amc_id;
                     if (not (exists (select * from t_couverture_amc
                                   where t_couverture_amc_id = :spsante_courante || :spsante_couverture))) then
                     begin
                          insert into t_couverture_amc(t_organisme_amc_id,
                                                t_couverture_amc_id,
                                                libelle,
                                                montant_franchise,
                                                plafond_prise_en_charge,
                                                formule,
                                                couverture_cmu)
                          select 'MSPSANTE' || :spsante_courante,
                                            :spsante_courante || :spsante_couverture,
                                            libelle,
                                            montant_franchise,
                                            plafond_prise_en_charge,
                                            formule,
                                            couverture_cmu
                          from t_couverture_amc
                          where t_couverture_amc_id = :t_couverture_amc_id;

                          insert into t_taux_prise_en_charge  ( t_taux_prise_en_charge_id,
                                                                t_couverture_amc_id,
                                                    t_ref_prestation_id,
                                                    taux)

                           select  next value for seq_taux_prise_en_charge,       :spsante_courante || :spsante_couverture,
                                 t_ref_prestation_id,
                                 taux
                          from t_taux_prise_en_charge
                          where t_couverture_amc_id = :t_couverture_amc_id ;

                  end /* fin creation couverture pour org. supp. spsante */

                end

                /* mise a jour du client , sauf si vrai cetip 11 car */
                if ( char_length(substring(contrat_sante_pharma from 1 for lintpos - 1)) <> 11 ) then
                begin
                     contrat_sante_pharma = ''    ;
                     update t_client
                     set t_organisme_amc_id = 'MSPSANTE' || :spsante_courante,
                         t_couverture_amc_id = :spsante_courante || :spsante_couverture,
                         contrat_sante_pharma = :contrat_sante_pharma
                         where numero_insee in ( select numero_insee from t_client where t_client_id = :t_client_id)
             and numero_insee>'';
                end

            end
      end
   end
   suspend;
end;
 
/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_document(
    ATypeID varchar(20), -- TBLN     
    AID1 varchar(20), --ti
    AID2 varchar(20), --skey
    ADateModification varchar(10),  --tmcreate
    AFichier varchar(1024)) -- ExtraireDocumentTIFF  avec ('BLOB_TI') ('OFFSET') ('SIZE_FILECODE')
as
declare variable strID varchar(50);
declare variable strCommentaire varchar(50);
declare variable dtDate date;
begin
  -- le libelle DOIT etre le nom du fichier, et surtout l'extension qui impliquera le type mime


  if (ATypeID = '1') then
  begin
    strID = AID1;
    strCommentaire = 'Attestation du ' || ADateModification;
  end
  else if (ATypeID = '6') then
    begin
    select t_client_id, 'Ordonnance du ' || date_prescription
    from t_historique_client
    where t_historique_client_id = :AID1
    into :strID, :strCommentaire;
    end
    else if (ATypeID = '20') then
      begin  
      strID = AID2;
      strCommentaire = 'Document fournisseur du ' || ADateModification;
      end
        else if (ATypeID = '21') then
      begin
        select t_commande_id, 'Bon de livraison du ' || date_creation
        from t_commande
        where t_commande_id = :AID1
        into :strID, :strCommentaire;
      end
    
  if ((strID is not null) and (strID <> '')) then
    insert into t_document(t_document_id,
                           type_entite,
                           t_entite_id,
                           libelle,
                           document, 
                           commentaire)
    values(next value for seq_document,
           case
              when :ATypeID in('1', '6') then 2
              when :ATypeID = 20 then 16
              when :ATypeID = 21 then 3
           end,
           :strID,
           RIGHT(:AFichier,POSITION('\', REVERSE(:AFichier)) -1 ),
           :AFichier,
           :strCommentaire);
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_produit_du(
numero_du integer,  
ti integer,
cli_ti integer,
ben_ti integer,
date_order date,
cip integer,
quantite smallint)
as
begin
  insert into t_produit_du(t_produit_du_id,
                           t_client_id,
                           date_du,
                           t_produit_id,
                           quantite)
  values(next value for seq_produit_du,
         iif (:ben_ti <> '0', :cli_ti||'-'||:ben_ti, :cli_ti),
         :date_order,
         :cip,
         :quantite);
end;

/* ********************************************************************************************** */
create or alter procedure ps_wp_creer_mandataire(
  t_client_id varchar(50),
  t_mandataire_id varchar(50),
  type_lien integer)
as
begin
  insert into t_mandataire(
    t_client_id,
    t_mandataire_id,
    type_lien)
  values(
    :t_client_id,
    :t_mandataire_id,
    :type_lien);
end;

/*  --inutilisé ?
create or alter procedure PS_WP_CREER_FACTURE (
    numero_facture varchar(50),
    t_client_assure_id varchar(50),
    t_client_ordre_id varchar(50)
)
as
declare variable t_client_id varchar(50);
begin
   if (t_client_assure_id = '0') then t_client_id = null ;
   
   if (t_client_ordre_id <> '0' ) then
         t_client_id = t_client_assure_id || '-'||t_client_ordre_id;
   else
         t_client_id = t_client_assure_id;
         
         
   if  (( numero_facture <> '0') and exists(select null from t_client where t_client_id = :t_client_id )) then 
     insert into  t_winpharma_fac_cli values ( :numero_facture , :t_client_id) ;
         
end;
*/


/******************************************************* programme avantage *******************************************************/
create or alter procedure ps_wp_creer_programme_avantage(
    t_client_id varchar(50),
    date_creation date, 
    encours_initial float,
    encours_CA float
)
as
begin

--creation par défaut d'un programme avec nb boite = 10
if (not(exists(select null from t_programme_avantage where t_programme_avantage_id=1))) then
  insert into T_PROGRAMME_AVANTAGE (
    T_PROGRAMME_AVANTAGE_ID,
    type_carte,
    libelle,
    desactivee,
    type_objectif,
    valeur_objectif,
    valeur_point,
    type_avantage,
    mode_calcul_avantage,
    valeur_avantage,
    valeur_ecart,
    diff_assure)
values(
  1,
  '1',
  'PROGRAMME AVANTAGE',
  '0',
  '2',
  10,
  1,
  '1',
  '1',
  10,
  0,
  '0');             

insert into t_programme_avantage_client(t_programme_avantage_client_id,
                t_programme_avantage_id,
                t_client_id,
                statut,
                date_creation,
                encours_initial,
                encours_CA)
values(next value for seq_programme_avantage_client,
  '1',
  :t_client_id,
  '0',
  coalesce(:date_creation, current_date),
  :encours_initial,
  :encours_ca
  );

end;


/******************************************************* crédit  *******************************************************/
create table t_winpharma_credit_perdu(
numero_facture varchar(50),
date_credit date, 
nom_assure varchar(50),
nom_benef varchar(50),
montant float);

create or alter procedure ps_wp_credit2(
  date_credit date,
  numero_facture varchar(50),
  montant float,
  nom_assure varchar(50),
  nom_benef varchar(50)
  ) 
as
declare variable t_client_id varchar(50);
begin
    select first 1 t_client_id
    from T_HISTORIQUE_CLIENT
    where numero_facture = trim(:numero_facture) 
    into :t_client_id;  
    
    if ((:t_client_id is not null) and (:montant <> 0))  then
      if (not(exists(select t_client_id from t_credit where t_client_id = :t_client_id) ) )   then
          insert into t_credit(t_credit_id,
                                date_credit,
                                t_client_id,
                                montant)
          values(next value for seq_credit,
                        :date_credit,
                        :t_client_id,
                        :montant);
      else
        update t_credit 
        set montant =montant+:montant, date_credit = iif(:date_credit>date_credit, :date_credit, date_credit )             
        where t_client_id = :t_client_id; 
    else    
      insert into t_winpharma_credit_perdu values( :numero_facture, :date_credit, :nom_assure, :nom_benef, :montant );    
end;

/******************************************************* Programme relationnel *******************************************************/
create or alter procedure ps_wp_creer_carte_prog_rel(
    t_client_id varchar(50),
    carte_activ varchar(10),
    carte_affinity varchar(14),
    carte_lafayette varchar(14),
    carte_elsie varchar(14),
    carte_aprium varchar(14),
    carte_pharmacorp varchar(14),
    carte_alphega varchar(14)
    )
as
begin

if (carte_activ<>'') then 
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :carte_activ,
    7 );

if (carte_affinity<>'') then 
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :carte_affinity,
    6 );

if (carte_lafayette<>'') then 
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :carte_lafayette,
    8 );

if (carte_elsie<>'') then 
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :carte_elsie,
    11 );

if (carte_aprium<>'') then 
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :carte_aprium,
    15 );

if (carte_pharmacorp<>'') then 
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :carte_pharmacorp,
    13 );

if (carte_alphega<>'') then 
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :carte_alphega,
    14 );

end;
