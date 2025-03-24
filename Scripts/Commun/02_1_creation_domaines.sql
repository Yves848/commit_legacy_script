set sql dialect 3;

/* ********************************************************************************************** */
create domain dm_3etat char(1) default null check ((value = '0') or (value is null) or (value = '1'));
create domain dm_boolean char(1) default '0' not null check ((value = '0') or (value = '1'));
create domain dm_liste char(1) default '0';
create domain dm_liste2 char(2) default '0';
create domain dm_char1 char(1);
create domain dm_char2 char(2);
create domain dm_char3 char(3);
create domain dm_char5 char(5);
create domain dm_type_organisme char(1) check (value in ('1', '2', '3'));
create domain dm_mode_calcul char(1) check (value in ('0', '1', '2'));
create domain dm_mode_gestion_amc char(1) check (value in ('1', '2'));
create domain dm_justificatif_exo char(1) check ((value in ('0', '1', '2', '3', '4', '5', '6', '7', '9') or
                                                 (value is null)));

/* **************** */
-- 1 => 300
-- 3 => 9600
-- 4 => AUTO
/* **************** */
create domain dm_vitesse_171 char(1) check (value in ('1', '3', '4'));

/* **************** */
-- 1 => 'N171 Appel'
-- 2 => 'N171 Porteuse'
-- 3 => 'Fax'
-- 4 => 'E-Mail'
-- 5 => 'Manuel' 
/* **************** */
create domain dm_mode_transmission char(1) default '5' check (value in ('1', '2', '3', '4', '5'));
create domain dm_service_tips char(1) check ((value in ('A', 'E', 'L', 'P', 'R', 'V', 'S')) or
                                             (value is null));
create domain dm_periodicite char(1) check ((value in ('H', 'J', 'M', 'T')) or
                                            (value is null));


/* ********************************************************************************************** */
create domain dm_nom_table varchar(31);
create domain dm_nom_procedure varchar(31);
create domain dm_commentaire varchar(200);
create domain dm_commentaire_long varchar(2000);
create domain dm_memo varchar(8191) default '';
create domain dm_code varchar(50) check ((value <> '') or (value is null));
create domain dm_code_cip char(13);
create domain dm_code_cip7 char(7);
create domain dm_code_postal char(5);
create domain dm_code_prestation varchar(3);
create domain dm_date_naissance varchar(8) check (value is null or (value similar to '[[:DIGIT:]]{8}') );
create domain dm_donnees varchar(5000);
create domain dm_identifiant_171 varchar(8);
create domain dm_libelle varchar(50);
create domain dm_nom_fichier varchar(6);
create domain dm_periode varchar(6) check ((value similar to '[[:DIGIT:]]*') and
                                           (cast(substring(value from 1 for 2) as numeric(2)) between 1 and 12) and
                                           (cast(substring(value from 3 for 4) as numeric(4)) between 1 and 9999));
create domain dm_numero_adherent varchar(16);
create domain dm_contrat_sante_pharma varchar(18);
create domain dm_rue varchar(40);
create domain dm_nom_ville varchar(30);
create domain dm_telephone varchar(20);
create domain dm_message varchar(1000);
create domain dm_varchar2 varchar(2);
create domain dm_varchar3 varchar(3);
create domain dm_varchar4 varchar(4);
create domain dm_varchar5 varchar(5);
create domain dm_varchar6 varchar(6);
create domain dm_varchar7 varchar(7);
create domain dm_varchar8 varchar(8);
create domain dm_varchar9 varchar(9);
create domain dm_varchar10 varchar(10);
create domain dm_varchar13 varchar(13);
create domain dm_varchar15 varchar(15);
create domain dm_varchar20 varchar(20);
create domain dm_varchar30 varchar(30);
create domain dm_varchar50 varchar(50);
create domain dm_varchar60 varchar(60);
create domain dm_varchar70 varchar(70);
create domain dm_varchar80 varchar(80);
create domain dm_varchar100 varchar(100);
create domain dm_varchar150 varchar(150);

/* ********************************************************************************************** */
create domain dm_cle integer;
create domain dm_chiffre_affaire numeric(9) check (((value >= 0) and (value < 1000000000)) or (value is null));
create domain dm_tva numeric(5,2) check (((value >= 0) and (value < 1000)) or (value is null));
create domain dm_seuil numeric(15,2) check (((value >= -10000000000000) and (value < 10000000000000)) or (value is null));
create domain dm_remise numeric(5,2) check (((value >= 0) and (value < 1000)) or (value is null));
create domain dm_quantite numeric(5) check(((value >= 0) and (value < 100000)) or (value is null));
create domain dm_prix_achat numeric(10, 3) check (((value >=0) and (value < 10000000)) or (value is null));
create domain dm_prix_vente numeric(10, 2) check (((value >=0) and (value < 10000000)) or (value is null));
create domain dm_numeric1 numeric(1) check (((value >= -10) and (value < 10)) or (value is null));
create domain dm_numeric2 numeric(2) check (((value > -100 ) and (value < 100)) or (value is null));
create domain dm_numeric3 numeric(3) check (((value >= -1000) and (value < 1000)) or (value is null));
create domain dm_numeric4 numeric(4) check (((value >= -10000) and (value < 10000)) or (value is null));
create domain dm_numeric5 numeric(5) check (((value >= -100000) and (value < 100000)) or (value is null));
create domain dm_numeric10 numeric(10) check  (((value >= -10000000000) and (value < 10000000000)) or (value is null));
create domain dm_taux_marque numeric(4,3) check ((value >= 0) or (value < 10) or (value is null));
create domain dm_moyenne_vente numeric(6,1) check ((value >= 0) and (value < 1000000) or (value is null));
create domain dm_taille_bloc smallint check((value is null) or (value > 0));

/* ********************************************************************************************** */
create domain dm_heure time;
create domain dm_date date;
create domain dm_date_heure timestamp;
create domain dm_type_depot varchar(10) check(  value in ( 'SUVE', 'SUAL_R', 'SUAL_D', 'SURE', 'SURA')  );
/* **************** */
-- SUVE => Depot vente pharmacie
-- SUAL_R => Depot reserve proche
-- SUAL_D  => Depot Reserve eloignee
/* **************** */

create domain dm_type_promotion char(1) check (value in ('1', '2', '3'));
/* **************** */
-- 1 => Promotion produit sans panachage
-- 3 => Promotion lot ferme
-- 4 => Promotion avec panachage
/* **************** */
create domain dm_type_avantage_promo numeric(1) check ((value >= 1) and (value <= 10));
/* **************** */
-- 1:Nombre de produit(s) identique(s) offert(s)  
-- 2:Montant du lot  
-- 3:Remise sur le lot  
-- 4:Remise unitaire en montant  
-- 5:Remise unitaire en pourcentage  
-- 6:Nombre de produit(s) au choix offert(s)  
-- 7:Montant du produit au choix  
-- 8:Remise sur produit au choix  
-- 9:Produit offert autre que ceux delivres  
-- 10:Produit offert le moins cher
/* **************** */
create domain dm_formule varchar(3);
/* **************** */
create domain dm_finess varchar(9);
create domain dm_rpps varchar(11) check ( value similar to '[[:DIGIT:]]{11}' or value is null or value = '');


/* *************************************   BELGIQUE    ******************************* */
create domain dm_num_apb4 varchar(4);

commit;
