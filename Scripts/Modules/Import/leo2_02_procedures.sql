set sql dialect 3;

create exception exp_leo2_no_formule_inexistant 'Numero de formule inexistant !';
create exception exp_leo2_couverture_inexistante 'couverture inexistante !';
create sequence seq_destinataire;

/* ********************************************************************************************** */
create or alter procedure ps_supprimer_donnees_modules(
  ATypeSuppression smallint)
as
begin

end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_etablissement(
  Pmo_Id integer,
  Ets_NumeroFiness varchar(9),
  Pmo_RaisonSociale varchar(100),  
  Cop_LigneAdresse varchar(155),
  Cop_CodePostal varchar(15),
  Cop_Ville varchar(100),
  Fixe varchar(20),
  Mobile varchar(20),
  Fax varchar(20))
as
begin
  update or insert into t_hopital(t_hopital_id,
                                  nom,
                                  no_finess,
                                  rue_1,
                                  rue_2,
                                  code_postal,
                                  nom_ville,
                                  tel_standard,
                              tel_mobile,
                              fax)
  values(:Pmo_Id,
         substring(:Pmo_RaisonSociale from 1 for 50),
         :Ets_NumeroFiness,
           trim(substring(replace(replace(:Cop_LigneAdresse, ASCII_CHAR(10) , ' '), ASCII_CHAR(13) , ' ') from 1 for 40)),
           trim(substring(replace(replace(:Cop_LigneAdresse, ASCII_CHAR(10) , ' '), ASCII_CHAR(13) , ' ') from 41 for 40)),

           substring(:Cop_CodePostal from 1 for 5),
           substring(:Cop_Ville from 1 for 30),
           substring(:Fixe from 1 for 20),
           substring(:Mobile from 1 for 20),
           substring(:Fax from 1 for 20));
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_prescripteur(
  Pph_Id integer, 
  Pph_Nom varchar(100),
  Pph_Prenom varchar(100),
  Cop_LigneAdresse varchar(155),
  Cop_CodePostal varchar(15),
  Cop_Ville varchar(100),
  Fixe varchar(20),
  Mobile varchar(20),
  Fax varchar(20),  
  Pmo_Id integer,
  Sps_IsAgreeSncf smallint,
  mex_id varchar(5),
  Pds_NumeroAdeli varchar(9), 
  Pds_NumeroRpps varchar(11),
  Csp_Id varchar(2))
as
declare variable intSpecialite integer;
begin
  execute procedure ps_renvoyer_id_specialite(:Csp_Id) returning_values :intSpecialite;

  if (mex_id = '00') then
    insert into t_praticien(t_praticien_id,
                            type_praticien,
                            nom,
                            prenom,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_standard,
                            tel_mobile,
                            fax,
                            t_ref_specialite_id,
                            no_finess,
                            num_rpps,
                            agree_ratp)
    values(:Pph_Id,
           '1',
           substring(:Pph_Nom from 1 for 50),
           substring(:Pph_Prenom from 1 for 50),
           trim(substring(replace(replace(:Cop_LigneAdresse, ASCII_CHAR(10) , ' '), ASCII_CHAR(13) , ' ') from 1 for 40)),
           trim(substring(replace(replace(:Cop_LigneAdresse, ASCII_CHAR(10) , ' '), ASCII_CHAR(13) , ' ') from 41 for 40)),
           substring(:Cop_CodePostal from 1 for 5),
           substring(:Cop_Ville from 1 for 30),
           substring(:Fixe from 1 for 20),
           substring(:Mobile from 1 for 20),
           substring(:Fax from 1 for 20),
           :intSpecialite,
           :Pds_NumeroAdeli,
           :Pds_NumeroRpps,
           coalesce(:Sps_IsAgreeSncf, '0'));
  else
    insert into t_praticien(t_praticien_id,
                            type_praticien,
                            nom,
                            prenom,
                            t_hopital_id,
                            no_finess,
                            num_rpps,
                            t_ref_specialite_id)
    values(:Pph_Id,
           '2',
           substring(:Pph_Nom from 1 for 50),
           substring(:Pph_Prenom from 1 for 50),
           :Pmo_Id,
           :Pds_NumeroAdeli,
           :Pds_NumeroRpps,
           :intSpecialite);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_destinataire(
   ctr_id varchar(38),
   ctr_libelle varchar(100),
   Con_NumeroDestinataire varchar(14),
   Con_ServeurPOP varchar(50),
   Con_PortPOP smallint,
   Con_EmailLOI varchar(100)
   
)
as
begin
   insert into t_destinataire(t_destinataire_id,
                              nom,
                              num_ident,
                              serv_pop3,
                    
                              adresse_bal
)
   values(:ctr_id,
          :ctr_libelle,
          :Con_NumeroDestinataire,
          :Con_ServeurPOP,
      
          :Con_EmailLOI
);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_caisse_primaire(
  Pmo_Id integer, 
  Pmo_RaisonSociale varchar(100), 
  Rgi_Id char(2), 
  Cpr_Code char(3), 
  Cge_Code char(4), 
  Cpr_IsCirconscription smallint,  
  Cop_LigneAdresse varchar(155),
  Cop_CodePostal varchar(15),
  Cop_Ville varchar(100),
  Fixe varchar(20),
  Mobile varchar(20),
  Fax varchar(20),    
  Ctr_Id smallint)
as
declare variable intRegime integer;
begin
   execute procedure ps_renvoyer_id_regime(:Rgi_Id) returning_values :intRegime;

   insert into t_organisme(type_organisme,
                           t_organisme_id,
                           nom,
                           rue_1,
                           rue_2,
                           code_postal,
                           nom_ville,
                           tel_standard,
                           tel_mobile,
                           fax,
                           t_ref_regime_id,
                           caisse_gestionnaire,
                           centre_gestionnaire,
                           t_destinataire_id,
                           org_circonscription)
   values(1,
          :Pmo_Id,
          substring(:Pmo_RaisonSociale from 1 for 50),
           trim(substring(:Cop_LigneAdresse from 1 for 40)),
           trim(substring(:Cop_LigneAdresse from 41 for 40)),
           substring(:Cop_CodePostal from 1 for 5),
           substring(:Cop_Ville from 1 for 30),
           substring(:Fixe from 1 for 20),
           substring(:Mobile from 1 for 20),
           substring(:Fax from 1 for 20),
          :intRegime,
          :Cpr_Code,
          :Cge_Code,
          null,
          :Cpr_IsCirconscription);
end;


/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_caisse_comp(
  Pmo_Id integer, 
  Pmo_RaisonSociale varchar(100), 
  Cco_CodePrefectoral varchar(8), 
  Cco_NumeroAMC varchar(10), 
  Rco_CodePrefectoral varchar(8),  
  Cop_LigneAdresse varchar(155),
  Cop_CodePostal varchar(15),
  Cop_Ville varchar(100),
  Fixe varchar(20),
  Mobile varchar(20),
  Fax varchar(20),    
  Ctr_Id smallint)
as
declare variable idnat varchar(9);
begin
   idnat = substring(iif (:Cco_CodePrefectoral <> '', :Cco_CodePrefectoral, coalesce(:Cco_NumeroAMC,:Rco_CodePrefectoral)) from 1 for 9);

   insert into t_organisme(type_organisme,
                           t_organisme_id,
                           nom,
                           rue_1,
                           rue_2,
                           code_postal,
                           nom_ville,
                           tel_standard,
                           tel_mobile,
                           fax,
                           identifiant_national,
                           t_destinataire_id)
   values(2,
          :Pmo_Id,
          substring(iif(:Pmo_RaisonSociale = '', :idnat, :Pmo_RaisonSociale) from 1 for 50),
           trim(substring(:Cop_LigneAdresse from 1 for 40)),
           trim(substring(:Cop_LigneAdresse from 41 for 40)),
           substring(:Cop_CodePostal from 1 for 5),
           substring(:Cop_Ville from 1 for 30),
           substring(:Fixe from 1 for 20),
           substring(:Mobile from 1 for 20),
           substring(:Fax from 1 for 20),
          :idnat,
          null);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_taux(
  ACouvertureAMO varchar(50),
  ACouvertureAMC varchar(50),
  APrestation varchar(3),
  taux integer,
  NoFormule varchar(3))
as
declare variable intPrestation integer;
declare variable intTauxPC integer;
begin
  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;

  if (ACouvertureAMO is not null) then
    select t_taux_prise_en_charge_id
    from t_taux_prise_en_charge
    where t_couverture_amo_id = :ACouvertureAMO
      and t_ref_prestation_id = :intPrestation
    into :intTauxPC;
  else
    if (ACouvertureAMC is not null) then
      select t_taux_prise_en_charge_id
      from t_taux_prise_en_charge
      where t_couverture_amc_id = :ACouvertureAMC
        and t_ref_prestation_id = :intPrestation
      into :intTauxPC;

  if (row_count = 0) then
    insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                       t_couverture_amo_id,
                                       t_couverture_amc_id,
                                       t_ref_prestation_id,
                                       taux)
    values(gen_id(seq_taux_prise_en_charge, 1),
           :ACouvertureAMO,
           :ACouvertureAMC,
           :intPrestation,
           :taux);
  else
    update t_taux_prise_en_charge
    set taux = :taux
    where t_taux_prise_en_charge_id = :intTauxPC;
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_maj_taux_comp(
  gco_id integer, 
  cpt_id varchar(5), 
  fdr_taux integer, 
  tfc_libellecourt varchar(30))
as
 declare variable strNoFormule varchar(3);
 declare variable strCouvertureAMC varchar(50);
begin
  if (Tfc_LibelleCourt = 'DR') then strNoFormule = '010';
  if (Tfc_LibelleCourt = '%DR') then strNoFormule = '012';
  if (Tfc_LibelleCourt = 'BR') then strNoFormule = '020';
  if (Tfc_LibelleCourt = '%BR') then strNoFormule = '021';
  if (Tfc_LibelleCourt = 'BR-RO') then strNoFormule = '029';
  if (Tfc_LibelleCourt = '%BR-RO') then strNoFormule = '02A'; -- 042 pose pb 
  if (Tfc_LibelleCourt = 'TM') then strNoFormule = '052';
  if (Tfc_LibelleCourt = '%TM') then strNoFormule = '050';
  if (Tfc_LibelleCourt = '%BR+RO+forfait') then strNoFormule = '027';
  --if (Tfc_LibelleCourt = 'Plafond/%DR-RO') then strNoFormule = '';
  if (Tfc_LibelleCourt = '%RO+forfait') then strNoFormule = '030';
  if (Tfc_LibelleCourt = '%TC') then strNoFormule = '060';
  
  for select t_couverture_amc_id
      from t_couverture_amc
      where t_couverture_amc_id similar to '[[:DIGIT:]]*_' || :gco_id
      into :strCouvertureAMC do
  begin
    execute procedure ps_leo2_creer_taux(null, :strCouvertureAMC, :cpt_id, :fdr_taux, :strNoFormule);
  end
 end;
 
/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_gar_prim_patient(
  pph_id integer,
  tap_id smallint,
  pmo_id integer,
  hor_centre varchar(4),
  ald char(1), 
  atp_codesituation varchar(4), 
  atp_datedebut varchar(20), 
  atp_datefin varchar(20))
as
declare variable strCC varchar(5);
declare variable chALD char(1);
declare variable strIDCouv varchar(50);
declare variable strIDCouvRef integer;
declare variable strLibelleCouv varchar(50);
declare variable strIDOrgAMO varchar(50);
declare variable strIDClient varchar(50);
begin
  strIDClient = pph_id;
  strIDOrgAMO = pmo_id;
    
  if (tap_id in (0, 1)) then
  begin
    chALD = iif(ald <> 0, '1', '0');
    strCC = chALD || atp_codesituation; 
  strIDcouv = pmo_id || '_' || strCC;
  strLibelleCouv = 'Couverture ' || strCC;  
  end
    else if (tap_id = 2) then
    begin      
    select t_organisme_amo_id
    from t_client
    where t_client_id = :strIDClient
    into strIDOrgAMO;
    
    strIDcouv = strIDOrgAMO || '_ALD';
    strLibelleCouv = 'Couverture ALD';
    strCC = null;
    chALD = '1';
    
    end
      else if (tap_id = 5) then
      begin
      chALD = '0';
      strIDcouv = '90MAT';
      strLibelleCouv = 'Couverture Maternité';
      strCC = null;  
      end
  
  if (strCC is not null) then
    execute procedure ps_renvoyer_id_couv_amo_ref(strCC) returning_values :strIDCouvRef;

 if (  trim(:strIDOrgAMO ) > '' ) then
  update t_client
  set t_organisme_amo_id = :strIDOrgAMO, centre_gestionnaire = :hor_centre
  where t_client_id = :strIDClient;
  
  if (not exists(select null
                 from t_couverture_amo
         where t_couverture_amo_id = :strIDcouv)) then
    insert into t_couverture_amo(t_couverture_amo_id,
    t_organisme_amo_id,
      libelle,
    ald,
    t_ref_couverture_amo_id)         
  values(:strIDcouv,
    :strIDOrgAMO,
      :strLibelleCouv,
    :ald,
    :strIDCouvRef);
   
  insert into t_couverture_amo_client(t_couverture_amo_client_id,
    t_couverture_amo_id,
  t_client_id,
  debut_droit_amo,
  fin_droit_amo)
  values(next value for seq_couverture_amo_client,
    :strIDCouv,
  :strIDClient,
  :atp_datedebut,
  :atp_datefin);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_garantie_comp(
   Pmo_IdCaisseComplementaire integer,
   gco_id integer,
   gco_libelle varchar(100),
   fdr_taux numeric(6,3),
   Tfc_LibelleCourt varchar(30))
as
declare variable strCouvertureAMC varchar(50);
declare variable strNoFormule varchar(3);
begin
  if (Tfc_LibelleCourt = 'DR') then strNoFormule = '010';
  if (Tfc_LibelleCourt = '%DR') then strNoFormule = '012';
  if (Tfc_LibelleCourt = 'BR') then strNoFormule = '020';
  if (Tfc_LibelleCourt = '%BR') then strNoFormule = '021';
  if (Tfc_LibelleCourt = 'BR-RO') then strNoFormule = '029';
  if (Tfc_LibelleCourt = '%BR-RO') then strNoFormule = '02A';
  if (Tfc_LibelleCourt = 'TM') then strNoFormule = '052';
  if (Tfc_LibelleCourt = '%TM') then strNoFormule = '050';
  if (Tfc_LibelleCourt = '%BR+RO+forfait') then strNoFormule = '027';
  --if (Tfc_LibelleCourt = 'Plafond/%DR-RO') then strNoFormule = '';
  if (Tfc_LibelleCourt = '%RO+forfait') then strNoFormule = '030';
  if (Tfc_LibelleCourt = '%TC') then strNoFormule = '060';
  
  strCouvertureAMC = :Pmo_IdCaisseComplementaire || '_' || :gco_id;
  insert into t_couverture_amc(t_couverture_amc_id,
                 t_organisme_amc_id,
                 libelle,
                 montant_franchise,
                 plafond_prise_en_charge,
                 formule)
  values(:strCouvertureAMC,
     :Pmo_IdCaisseComplementaire,
     substring(:gco_libelle from 1 for 50),
     0,
     0,
     :strNoFormule);

  if (fdr_taux is null) then fdr_taux = 100;
  
  execute procedure ps_leo2_creer_taux(null, :strCouvertureAMC, 'PH4', :fdr_taux, :strNoFormule);
  execute procedure ps_leo2_creer_taux(null, :strCouvertureAMC, 'PH7', :fdr_taux, :strNoFormule);
  execute procedure ps_leo2_creer_taux(null, :strCouvertureAMC, 'PH1', :fdr_taux, :strNoFormule);
  execute procedure ps_leo2_creer_taux(null, :strCouvertureAMC, 'PMR', :fdr_taux, :strNoFormule);
  execute procedure ps_leo2_creer_taux(null, :strCouvertureAMC, 'PH2', :fdr_taux, :strNoFormule);
  execute procedure ps_leo2_creer_taux(null, :strCouvertureAMC, 'AAD', :fdr_taux, :strNoFormule);  
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_gar_comp_patient(
  pph_id integer, 
  cmu char(1), 
  pmo_id integer, 
  gco_id integer, 
  atc_numeroadherentunique varchar(20), 
  atc_datedebut varchar(20), 
  atc_datefin varchar(20))
as
declare variable strIDClient varchar(50);
begin
  strIdClient = pph_id;
  
  update t_client
  set t_organisme_amc_id = :pmo_id,
    t_couverture_amc_id = :pmo_id || '_' || :gco_id,
    numero_adherent_mutuelle = :atc_numeroadherentunique,
  debut_droit_amc = :atc_datedebut,
    fin_droit_amc = :atc_datefin
  where t_client_id = :strIDClient;
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_compte(
  clp_id int,
  clp_nomouraisonsoc varchar(100),
  clp_adr1 varchar(155),
  clp_cp varchar(15),
  clp_commune varchar(100),
  clp_telfix varchar(20),
  clp_telmob varchar(20),
  clp_fax varchar(20),
  clp_telfixtrav varchar(20))
as
begin
  insert into t_compte(t_compte_id,
                       nom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_standard,
                       tel_personnel,
                       tel_mobile,
                       fax)
  values(:clp_id,
         substring(:clp_nomouraisonsoc from 1 for 30),
         substring(:clp_adr1 from 1 for 40),
         substring(:clp_adr1 from 41 for 40),
         substring(:clp_cp from 1 for 5),
         substring(:clp_commune from 1 for 30),
         substring(:clp_telfixtrav from 1 for 20),
         substring(:clp_telfix from 1 for 20),
         substring(:clp_telmob from 1 for 20),
         substring(:clp_fax from 1 for 20));
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_client(
   Pph_Id integer, 
   Pph_Nom varchar(100), 
   Pph_NomJeuneFille varchar(100),  
   Pph_Prenom varchar(100), 
   Pph_DateDeNaissance varchar(8),
   Pph_NumeroSecu varchar(15), 
   Pph_RangGemellaire varchar(1), 
   Cop_LigneAdresse varchar(155),
   Cop_CodePostal varchar(15),
   Cop_Ville varchar(100),
   Fixe varchar(20),
   Mobile varchar(20),
   Fax varchar(20),
   Prs_Commentaire varchar(2000),
   Prs_DateDernierePrestation date, 
   Qbe_Id smallint)
as
declare variable dtDateNaissance varchar(8);
begin
   if ((Pph_DateDeNaissance is not null) and (char_length(Pph_DateDeNaissance) = 8)) then
     dtDateNaissance = substring(Pph_DateDeNaissance from 7 for 2) ||
                       substring(Pph_DateDeNaissance from 5 for 2) ||
                       substring(Pph_DateDeNaissance from 1 for 4);
   else
     dtDateNaissance = null;

   insert into t_client(t_client_id,
                        numero_insee,
                        nom,
                        prenom,
                        nom_jeune_fille,
                        rue_1,
                        rue_2,
                        code_postal,
                        nom_ville,
                        tel_personnel,
                        tel_mobile,
                        fax,
                        qualite,
                        rang_gemellaire,
                        date_naissance,
                        date_derniere_visite,
                        commentaire_individuel)
   values(:Pph_Id,
          :Pph_NumeroSecu,
          substring(:Pph_Nom from 1 for 30),
          substring(:Pph_Prenom from 1 for 30),
          substring(:Pph_NomJeuneFille from 1 for 30),
          substring(:Cop_LigneAdresse from 1 for 40),
          substring(:Cop_LigneAdresse from 41 for 40),
          substring(:Cop_CodePostal from 1 for 5),
          substring(:Cop_Ville from 1 for 30),
          :Fixe,
          :Mobile,
          :Fax,
          coalesce(:Qbe_Id, '1'),
          :Pph_RangGemellaire,
          :dtDateNaissance,
          :Prs_DateDernierePrestation,
          substring(:Prs_Commentaire from 1 for 200));
  
  if (Prs_Commentaire <> '') then 
   insert into t_commentaire (t_commentaire_id,
                                 t_entite_id,
                                 type_entite,
                                 commentaire,
                                 est_global )
      values (next value for seq_commentaire,
              :Pph_Id,
              '0', -- client 
              cast(:Prs_Commentaire as blob),
              '0'  );   
      
      
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_fournisseur(
  Pmo_Id integer,
  Fou_CodeFournisseur integer,
  Pmo_RaisonSociale varchar(100),  
  Cop_LigneAdresse varchar(155),
  Cop_CodePostal varchar(15),
  Cop_Ville varchar(100),
  Fixe varchar(20),
  Mobile varchar(20),
  Fax varchar(20),
  Ptc_LoginOfficine varchar(20),
  Ptc_LoginRepartiteur varchar(20),
  Ptc_UrlPrimaire varchar(255),
  Ptc_UrlSecondaire varchar(255),
  Ptc_ClefSecrete varchar(10),
  Soc_Code smallint)  
as
begin
 if (Soc_Code is not null) then
    insert into t_repartiteur(t_repartiteur_id,
                              raison_sociale,
                              rue_1,
                              rue_2,
                              code_postal,
                              nom_ville,
                              tel_standard,
                              tel_mobile,
                              fax,
                              id_pharmacie,
                              pharmaml_id_officine,
                              pharmaml_ref_id,
                              pharmaml_url_1,
                              pharmaml_url_2,
                              pharmaml_id_magasin,
                              pharmaml_cle
                )
    values(:Pmo_Id,
           substring(:Pmo_RaisonSociale from 1 for 50),
           trim(substring(:Cop_LigneAdresse from 1 for 40)),
           trim(substring(:Cop_LigneAdresse from 41 for 40)),
           substring(:Cop_CodePostal from 1 for 5),
           substring(:Cop_Ville from 1 for 30),
           substring(:Fixe from 1 for 20),
           substring(:Mobile from 1 for 20),
           substring(:Fax from 1 for 20),
           substring(:Ptc_LoginOfficine from 1 for 8),
           substring(:Ptc_LoginOfficine from 1 for 10),
           :Soc_Code,
           substring(:Ptc_UrlPrimaire from 1 for 150),
           substring(:Ptc_UrlSecondaire from 1 for 150),
           :Ptc_LoginRepartiteur,
           substring(:Ptc_ClefSecrete from 1 for 4));
  else
    insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                     raison_sociale,
                                     rue_1,
                                     rue_2,
                                     code_postal,
                                     nom_ville,
                                     tel_standard,
                                     tel_mobile,
                                     fax,
                                     id_pharmacie)
    values(:Pmo_Id,
           substring(:Pmo_RaisonSociale from 1 for 50),
           trim(substring(:Cop_LigneAdresse from 1 for 40)),
           trim(substring(:Cop_LigneAdresse from 41 for 40)),
           substring(:Cop_CodePostal from 1 for 5),
           substring(:Cop_Ville from 1 for 30),
           substring(:Fixe from 1 for 20),
           substring(:Mobile from 1 for 20),
           substring(:Fax from 1 for 20),
           substring(:Ptc_LoginOfficine from 1 for 10));
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_historique_vente (
  Bes_Id integer, 
  mois integer, 
  annee integer, 
  quantite integer)
as
begin
  if (quantite > 0) then
    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   periode,
                                   quantite_vendues,
                                   quantite_actes)
    values(next value for seq_historique_vente,
           :Bes_Id,
           lpad(:mois, 2, '0') || lpad(:annee, 4, '0'),
           :quantite,
           :quantite);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_depot(
  Lst_Id smallint,
  Lst_Libelle varchar(25),
  Lst_PrioriteDestockage smallint)
as
declare variable strTypeDepot varchar(10);
begin
  insert into t_depot(t_depot_id,
                      libelle,
                      type_depot)
  values(:Lst_Id,
         :Lst_Libelle,
         trim(iif (:Lst_PrioriteDestockage = 1, 'SUVE', 'SUAL_D')));
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_zone_geographique(
noe_id integer,
noe_libelle varchar(255))
as
begin
    insert into t_zone_geographique (t_zone_geographique_id,
                                     libelle )
    values (:noe_id,
            substring(:noe_libelle from 1 for 50) );
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_produit (
  Bes_Id integer,
  Bes_CodeCipAcl13 varchar(13),
  Bes_CodeCipAcl7 varchar(7),
  Bes_CodeEANDefaut varchar(13),
  Bes_LibelleLibre varchar(255),
  Gds_IsTenueEnStock smallint,
  cpm_id smallint,
  dcl_id smallint,
  rcd_id smallint, 
  gds_valeurdeclenchement integer,
  gds_quantitemaxicommande integer, 
  Bes_DateDerniereDelivrance date,
  Bes_BaseDeRemboursement float,
  Bes_PrixPublicTTC float,
  prix_achat_catalogue float,
  prix_achat_remise float,
  pamp float,
  Bda_DelaiLaitJour smallint,
  Bda_DelaiOeufJour smallint,
  Bda_DelaiViandeJour smallint, 
  Tva_Taux float,
  Tyl_Libelle varchar(5),
  Tsr_Id_Ext char(1),
  tpl_interne varchar(30),
  Cpt_Id varchar(5),
  Epr_Id_Ext smallint,
  date_peremption date)
as
declare variable intTVA integer;
declare variable intPrestation integer;
declare variable intMarque integer;
begin
  execute procedure ps_renvoyer_id_tva(:Tva_Taux) returning_values :intTVA;
  execute procedure ps_renvoyer_id_prestation(:Cpt_Id) returning_values :intPrestation;

  -- Produit
  insert into t_produit(t_produit_id,
                        code_cip,
                        code_cip7,
                        designation,
                        veterinaire,
                        etat,
                        liste,
                        t_ref_prestation_id,
                        prix_vente,
                        prix_achat_catalogue,
                        pamp,
                        prix_achat_remise,
                        base_remboursement,
                        t_ref_tva_id,
                        profil_gs,
                        calcul_gs,
                        stock_mini,
                        stock_maxi,
                        delai_viande,
                        delai_lait,
                        service_tips,
                        date_derniere_vente,
                        date_peremption)
  values(:Bes_Id,
         :Bes_CodeCipAcl13,
         :Bes_CodeCipAcl7,
         substring(:Bes_LibelleLibre from 1 for 50),
         iif(:tpl_interne = 'Veterinaire', '1', '0'),
         case
           when :epr_id_ext = 0 then '1'
           when :epr_id_ext = 1 then '2'
           when :epr_id_ext in (32, 64) then '3'
           when :epr_id_ext in (2, 4, 8, 16) then '4'
           when :epr_id_ext = 128 then '5'
           else '1'
         end,
         case
           when :Tyl_Libelle = 'I' then '1'
           when :Tyl_Libelle = 'II' then '2'
           when :Tyl_Libelle = 'S' then '3'
           else '0'
         end,
         :intPrestation,
         :Bes_PrixPublicTTC,
         coalesce(:prix_achat_catalogue, 0),
         coalesce(:pamp, 0),
         coalesce(:prix_achat_remise, 0),
         :Bes_BaseDeRemboursement,
         :intTVA,
         iif(:Gds_IsTenueEnStock = 1, '0', '1'),
         case
           when (:dcl_id = 1 and :gds_quantitemaxicommande > 0) then '4' -- fixé
           when :dcl_id = 4 then '1' -- automatique         
           else '0' -- par défauts
         end,
         :gds_valeurdeclenchement,
         :gds_quantitemaxicommande, 
         :Bda_DelaiViandeJour,
         :Bda_DelaiLaitJour,
         iif(:Tsr_Id_Ext  in ('A', 'E', 'S', 'P', 'R', 'S'), :Tsr_Id_Ext,  null),
         :Bes_DateDerniereDelivrance,
         :date_peremption);

  -- Code EAN13
  if ((Bes_CodeEANDefaut is not null) and (char_length(trim(Bes_CodeEANDefaut)) = 13)) then
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id,
                             code_ean13)
    values(next value for seq_code_ean13,
           :Bes_Id,
           :Bes_CodeEANDefaut);
end;

create or alter procedure ps_leo2_creer_comm_produits(
  Bes_Id integer,
  commentaire_vente varchar(2000), 
  commentaire_gestion varchar(2000), 
  commentaire_commande varchar(2000)
)
as
begin
update t_produit set commentaire_vente = :commentaire_vente where t_produit_id = :Bes_Id;
update t_produit set commentaire_gestion = :commentaire_gestion where t_produit_id = :Bes_Id;
update t_produit set commentaire_commande = :commentaire_commande where t_produit_id = :Bes_Id;
end;


/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_stock(
  Bes_Id integer,
  Lst_Id smallint,
  Stp_Quantite smallint,
  zg_id integer,
  mini integer,
  maxi integer)
as
declare variable intStockMaxi integer;
begin
  /*if (not exists (select count(*)
                  from t_produit_geographique
                  where t_produit_id = :prd_id)) then
  begin
    update t_produit
    set stock_maxi = :lst_capacite
    where t_produit_id = :prd_id;

    intStockMaxi = 0;
  end
  else
  begin
    update t_produit
    set stock_maxi = null
    where t_produit_id = :prd_id;

    intStockMaxi = lst_capacite;
  end*/

/*  if (lst_priorestock = 1) then
    insert into t_produit_geographique(t_produit_geographique_id,
                                       t_produit_id,
                                       t_zone_geographique_id,
                                       stock_mini,
                                       stock_maxi,
                                       quantite,
                                       t_depot_id)
    values(next value for seq_produit_geographique,
           :prd_id,
           :noe_id,
           0,
           :intStockMaxi,
           :stp_qteactuelle,
           1);
  else
    if (not exists(select *
                   from t_produit_geographique
                   where t_produit_id = :prd_id
                     and t_depot_id = 2)) then*/
      insert into t_produit_geographique(t_produit_geographique_id,
                                         t_produit_id,
                                         t_zone_geographique_id,
                                         stock_mini,
                                         stock_maxi,
                                         quantite,
                                         t_depot_id)
      values(next value for seq_produit_geographique,
             :Bes_Id,
             :zg_id,
             :mini,
             :maxi,
             :Stp_Quantite,
             :Lst_Id);
/*    else
      update t_produit_geographique
      set quantite = quantite + :stp_qteactuelle
      where t_produit_id = :prd_id
        and t_depot_id = 2;*/
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_code_lpp(
  Bes_Id integer, 
  Lpp_Code varchar(10), 
  Cpt_Id varchar(5), 
  Bal_Coeff smallint, 
  Lpp_PxPubReglementaire float, 
  Tsr_Id_Ext char(1))
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(Cpt_Id) returning_values :intPrestation;

  insert into t_produit_lpp(t_produit_lpp_id,
                            t_produit_id,
                            type_code,
                            code_lpp,
                            tarif_unitaire,
                            quantite,
                            service_tips,
                            t_ref_prestation_id)
  values (next value for seq_produit_lpp,
          :Bes_Id,
          iif(:lpp_code not similar to '[[:DIGIT:]]*', '2', '0'),
          :lpp_code,
          :lpp_pxpubreglementaire,
          :bal_coeff,
          :Tsr_Id_Ext,
          :intPrestation);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_historique_client(
  t_historique_client_id int,
  t_client_id integer,
  numero_facture integer,
  date_prescription date,
  date_acte date,
  code_operateur varchar(15),
  nom_praticien varchar(100),
  prenom_praticien varchar(100)
  )
as
begin
  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  numero_facture,
                                  date_prescription,
                                  code_operateur,
                                  nom_praticien,
                                  prenom_praticien,
                                  type_facturation,
                                  date_acte)
  values(:t_historique_client_id,
         :t_client_id,
         coalesce(:numero_facture,0),
         :date_prescription,
         substring(:code_operateur from 1 for 10),
       substring(:nom_praticien from 1 for 50),
         substring(:prenom_praticien from 1 for 50),
         '2',
         :date_acte);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_hist_client_ligne (
  t_historique_client_id int,
  t_produit_id int,
  code_cip varchar(13),
  designation varchar(255),
  quantite_facturee integer,
  prix_achat float,
  prix_venteTTC float,
  prix_venteHT float
  )
as
begin
  if (quantite_facturee > 0) then
  begin
  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                          t_historique_client_id,
                      t_produit_id,
                                          code_cip,
                                          designation,
                                          quantite_facturee,
                      prix_achat,
                                          prix_vente,
                      montant_net_ht,
                      montant_net_ttc
                      )
    values(next value for seq_historique_client_ligne,
           :t_historique_client_id,
       :t_produit_id,
           :code_cip,
           substring(:designation from 1 for 50),
           :quantite_facturee,
       :prix_achat,
           :prix_venteTTC,
       :prix_venteHT*:quantite_facturee,
       :prix_venteTTC*:quantite_facturee
       );
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_vignette_avancee(
  IdPersonne integer,
  IdProduit integer,
  DateDelivrance date,
  pel_codecip varchar(13),
  libelleproduit varchar(255),
  Pel_PrixAchat float,
  Pel_PrixPublic float,
  CodePrestation varchar(5),
  base_remboursement float,
  QteAvance integer)
as
begin
  insert into t_vignette_avancee(t_vignette_avancee_id,
                                     t_client_id,
                                     t_produit_id,
                                     date_avance,
                                     code_cip,
                                     designation,
                                     prix_vente,
                                     prix_achat,
                                     code_prestation ,
                                     quantite_avancee,
                                     base_remboursement
  )
  values(next value for seq_vignette_avancee,
         :IdPersonne,
         :IdProduit,
         :DateDelivrance,
         :pel_codecip,
         substring(:libelleproduit from 1 for 50),
         :Pel_PrixPublic,
         :Pel_PrixAchat,
         :CodePrestation,
         :QteAvance,
         :base_remboursement
     );

end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_credit(
  cli_idclient int,
  soldeclient float,
  date_credit date)
as
declare variable strClient int;
declare variable strCompte int;
begin
  if (exists(select *
             from t_compte
             where t_compte_id = :cli_idclient)) then
  begin
    strClient = null;
    strCompte = cli_idclient;
  end
  else
  begin
    strClient = cli_idclient;
    strCompte = null;
  end
  
  if (not(exists(select * from t_credit where t_client_id = :cli_idclient or t_compte_id = :cli_idclient)))  then
    insert into t_credit(t_credit_id,
               t_client_id,
               t_compte_id,
               date_credit,
               montant)
    values(next value for seq_credit,
       :strClient,
       :strCompte,
       :date_credit,
       :soldeclient);
  else     
    update t_credit
    set montant = montant + :soldeclient
    where t_client_id = :cli_idclient or t_compte_id =  :cli_idclient ;    
     
end;


/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_commande(
  Com_id integer,
  Com_DateCreation date,
  Pmo_IdFournisseur integer,
  Com_DateLivraison date,
  Eco_Interne varchar(30),
  montant_ht float)
as
declare variable chTypeCommande char(1);
declare variable strFournisseur varchar(50);
declare variable strRepartiteur varchar(50);
begin
  if (exists(select null from t_fournisseur_direct where t_fournisseur_direct_id = :Pmo_IdFournisseur)) then
  begin
    chTypeCommande = '1';
    strFournisseur = Pmo_IdFournisseur;
    strRepartiteur = null;
  end
  else
  begin
    chTypeCommande = '2';
    strRepartiteur = Pmo_IdFournisseur;
    strFournisseur = null;
  end

  insert into t_commande(t_commande_id,
                         type_commande,
                         t_fournisseur_direct_id,
                         t_repartiteur_id,
                         date_creation,
                         date_reception,
                         etat,
                         mode_transmission,
                         montant_ht)
  values(:Com_id,
         :chTypeCommande,
         :strFournisseur,
         :strRepartiteur,
         :Com_DateCreation,
         :Com_DateLivraison,
         trim(case
             when :Eco_Interne = 'EnAttenteReception' then '2'
             when :Eco_Interne in ('ReceptionEnCours', 'ReceptionPartielle') then '21'
             when :Eco_Interne in ('Receptionnee', 'Cloturee') then '3'
           end),
         '5',
         :montant_ht);
end;

/* ********************************************************************************************** */
create or alter procedure ps_leo2_creer_ligne_commande(
  Lco_Id integer,
  Com_Id integer,
  bes_Id integer,
  Lco_QuantiteCommande integer,
  Lco_QuantiteLivree integer,
  Lco_QuantiteUG integer,
  Lco_PrixAchatCat float,
  Lco_PrixAchatRemise float,
  Bes_PrixPublicTTC float
  )
as
begin
  insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               quantite_totale_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               prix_vente,
                               unites_gratuites)
  values(next value for seq_commande_ligne,
         :Com_Id,
         :Bes_Id,
         :Lco_QuantiteCommande,
         coalesce(:Lco_QuantiteLivree, 0),
         coalesce(:Lco_QuantiteLivree, 0) + coalesce(:Lco_QuantiteUG,0),
         coalesce(:Lco_PrixAchatCat, 0),
         coalesce(:Lco_PrixAchatRemise, 0),
         coalesce(:Bes_PrixPublicTTC, 0),
         coalesce(:Lco_QuantiteUG,0));

  -- la reprise des montants de commande a été integrée dans les entetes directement
  -- update t_commande
  -- set montant_ht = montant_ht + (:Lco_QuantiteCommande * coalesce(:Lco_PrixAchatRemise, 0))
  -- where t_commande_id = :Com_Id;
end;

/* ********************************************************************************************** */
/*
create or alter procedure ps_leo2_creer_catalogue(
  fou_id varchar(38),
  fou_nom varchar(100),
  prd_id varchar(38),
  crp_minligcomqte integer,
  crp_pxachatcatht float,
  crp_pxachathtreel float,
  crp_pctremise float,
  crp_dtemajetatchezfour date)
as
declare variable i integer;
begin
  -- Creation catalogue
  if (not exists(select *
                 from t_catalogue
                 where t_catalogue_id = :fou_id)) then
    insert into t_catalogue(t_catalogue_id,
                            designation,
                            t_fournisseur_id)
    values(:fou_id,
           substring('Catalogue ' || :fou_nom from 1 for 0),
           :fou_id);

  -- Ajout de la ligne
  select coalesce(max(no_ligne), 1)
  from t_catalogue_ligne
  where t_catalogue_id = :fou_id
  into i;

  insert ino t_catalogue_ligne(t_catalogue_ligne_id,
                                t_catalogue_id,
                                no_ligne,
                                t_produit_id,
                                quantite,
                                prix_achat_catalogue,
                                prix_achat_remise,
                                remise_simple,
                                date_maj_tarif)
  values (next value for seq_catalogue_ligne,
          :fou_id,
          :i + 1,
          :prd_id,
          :crp_minligcomqte,
          :crp_pxachatcatht,
          :crp_pxachathtreel,
          :crp_pctremise,
          :crp_dtemajetatchezfour);
end;
*/
create or alter procedure ps_leo2_creer_utilisateur(
  Pph_Id integer,
  Pph_Nom varchar(100),
  Pph_Prenom varchar(30),
  Uti_Identifiant varchar(15))
as
begin
  insert into t_operateur(t_operateur_id,
                          code_operateur,
                          nom,
                          prenom,
                          mot_de_passe)
 values(:Pph_Id,
        substring(:Uti_Identifiant from 1 for 10),
        substring(:Pph_Nom from 1 for 50),
        :Pph_Prenom,
        :Uti_Identifiant);
end;

/* ********************************************************************************************** */
/*
create or alter procedure ps_leo2_creer_doc_scannee(
  cli_id varchar(38),
  dcn_nom varchar(255),
  dcn_description varchar(250))
as
begin
  insert into t_document( t_document_id ,
                                type_entite ,
                                t_entite_id,
                                document,
                                libelle)
  values(next value for seq_document,
         2,
         :cli_id,
         :dcn_nom,
         :dcn_description);
end;*/

create or alter procedure ps_leo2_creer_produit_du(
id_client integer,
date_creation date,
id_produit integer,
quantite smallint)
as
begin
  insert into t_produit_du(t_produit_du_id,
                           t_client_id,
                           date_du,
                           t_produit_id,
                           quantite)
  values(next value for seq_produit_du,
         :id_client,
         :date_creation,
         :id_produit,
         :quantite);
end;


/* ********************************************************************************************** */
create or alter procedure ps_leo2_maj_destinataire
as 
declare variable id dm_code;
begin

if (not(exists(select null from t_destinataire))) then
begin
   insert into t_destinataire (t_destinataire_id,nom) values (next value for seq_destinataire,'DESTINATAIRE T');
   id = cast(gen_id(seq_destinataire,0) as varchar(50));
end
else
   id = (select first 1 t_destinataire_id from t_destinataire);


update t_organisme set t_destinataire_id = :id where identifiant_national <> '' and t_destinataire_id is null;
update t_organisme set t_destinataire_id = :id where caisse_gestionnaire <> '' and t_destinataire_id is null;


end;

/******************************************************* Programme relationnel *******************************************************/
create or alter procedure ps_leo2_creer_prog_relationnel(
    t_client_id integer,
    numero_carte varchar(30),
    prog_id integer
    )
as
begin

insert into t_carte_programme_relationnel(
  t_carte_prog_relationnel_id,
  t_aad_id,
  numero_carte,
  t_pfi_lgpi_id)
values(
  next value for seq_programme_relationnel,
  :t_client_id,
  substring(trim(:numero_carte) from 1 for 13),
  case  
    when :prog_id = 2 then 14 --alphega
    when :prog_id = 4 then 6 -- affinity
    when :prog_id = 5 then 20  --primalis
    when :prog_id = 7 then 13 -- pharmacorp
    when :prog_id = 8 then 15 -- aprium
    when :prog_id = 13 then 27 --pharmacyal
    when :prog_id = 15 then 30
    else 0
  end
  );

end;
