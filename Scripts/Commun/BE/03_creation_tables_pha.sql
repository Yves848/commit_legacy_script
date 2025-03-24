set sql dialect 3;


create table t_profilremise(
  profilremise dm_code not null,
  defaultofficine dm_char1 default null,
  libelle dm_varchar30 default null,
  tauxreglegen dm_remise default null,
  typeristourne dm_char1 default null, --0 -> directe    1 -> différée
  plafondristourne dm_remise default null
);


alter table t_profilremise
add constraint pk_profilremise
primary key(profilremise);

CREATE TABLE T_PROFILREMISESUPPL(
  PROFILREMISESUPPL dm_chiffre_affaire NOT NULL
  ,PROFILREMISE dm_code NOT NULL
  ,TYPEREGLE dm_varchar5 DEFAULT NULL
  ,ORDRE dm_varchar5 DEFAULT NULL
  ,TYPERIST dm_char1 DEFAULT NULL
  ,PLAFRIST dm_monetaire2 DEFAULT NULL
  ,TAUX dm_varchar10 DEFAULT NULL
  ,CATPROD dm_char1 DEFAULT NULL /* (utilisé que pour offigest pour l'instant) */
  ,USAGE dm_char1 DEFAULT NULL
  ,CLASSINT dm_varchar50 DEFAULT NULL
);

create sequence seq_profil_remise_suppl;

CREATE TABLE T_CLASSIFICATIONINTERNE(   ---------Inutilise
	CLASSIFICATIONINTERNE dm_code NOT NULL
	,LIBELLE dm_varchar50 DEFAULT NULL
	,TAUXMARGE dm_varchar10 DEFAULT NULL
	,TAUXMARQUE dm_varchar10 DEFAULT NULL
);

ALTER TABLE T_CLASSIFICATIONINTERNE
ADD CONSTRAINT PK_CLASSIFICATIONINTERNE
PRIMARY KEY(CLASSIFICATIONINTERNE);

/* ALTER TABLE T_PROFILREMISESUPPL
ADD CONSTRAINT PK_PROFILREMISESUPPL
PRIMARY KEY(PROFILREMISESUPPL); */


/*CREATE TABLE T_FAMILLE(
	FAMILLE dm_code NOT NULL
);*/


CREATE TABLE T_MEDECIN(
	MEDECIN dm_code NOT NULL
	,NOM dm_varchar50 NOT NULL
	,PRENOM dm_varchar50 NOT NULL
	,COMMENTAIRES dm_commentaire DEFAULT NULL
	,IDENTIFIANT dm_varchar11 DEFAULT NULL   --- A remettre en numeric
	,MATRICULE dm_varchar8 DEFAULT NULL  --- A remettre en numeric
	,CODESPEC dm_varchar3 DEFAULT NULL  --- A remettre en numeric
	,EMAIL dm_varchar50 DEFAULT NULL
	,FAX dm_varchar20 DEFAULT NULL
	,VILLE dm_varchar40 DEFAULT NULL
	,CP dm_varchar10 DEFAULT NULL
	,CODEPAYS dm_varchar5 DEFAULT NULL
	,TEL1 dm_varchar20 DEFAULT NULL
	,TEL2 dm_varchar20 DEFAULT NULL
	,GSM dm_varchar20 DEFAULT NULL
	,RUE1 dm_varchar70 DEFAULT NULL
	,RUE2 dm_varchar70 DEFAULT NULL
	,SITE dm_varchar200 DEFAULT NULL
	,CATEGORIE dm_char1 NOT NULL
	,ISDENTISTE dm_boolean NOT NULL
	,ISMEDFRONT dm_boolean NOT NULL
	,constraint pk_medecin primary key(medecin)
);

ALTER TABLE t_medecin
ADD CONSTRAINT chk_med_cat
CHECK ((CATEGORIE like '1') OR	
       (CATEGORIE like '2') OR--frontalier
       (CATEGORIE like '3') OR--veterinaire
       (CATEGORIE like '4'));--non conventionne

ALTER TABLE t_medecin
ADD CONSTRAINT chk_med_nom
CHECK (trim(nom) <> '');


CREATE TABLE T_CHIMIQUE( -----------inutilise
	CHIMIQUE dm_code NOT NULL
	,CODEUNITE dm_numpos2 DEFAULT NULL
	/* Code unité par défaut utilisé lors de l'ajout d'un chimique en préparation magistrale */
	,CODEUNITEPRESC dm_numpos2 DEFAULT NULL
	,PRIXACHAT dm_monetaire3 DEFAULT 0
	,PRIXCOMPTOIR dm_monetaire3 DEFAULT 0
	,PRIXOFFICIEL dm_monetaire3 DEFAULT 0
	,DENSITE dm_float5_3 DEFAULT 0
	,DENSITETAR dm_float5_3 DEFAULT 0
);
ALTER TABLE t_chimique ADD CONSTRAINT PK_CHIM PRIMARY KEY(CHIMIQUE);

CREATE TABLE t_libelle_chimique(    -----------inutilise
	LIBELLECHIMIQUE dm_code NOT NULL
	,CHIMIQUE dm_code NOT NULL
	,DESIGNATION dm_varchar50 NOT NULL
	,LANGUE dm_varchar5 NOT NULL
	,SYNONYME dm_varchar5 NOT NULL
);
ALTER TABLE t_libelle_chimique ADD CONSTRAINT PK_LIBCHIM PRIMARY KEY(LIBELLECHIMIQUE);

ALTER TABLE t_libelle_chimique
ADD CONSTRAINT chk_chim_langue
CHECK((LANGUE = 'N') OR
      (LANGUE = 'F'));

ALTER TABLE t_libelle_chimique
ADD CONSTRAINT chk_chim_syn
CHECK((SYNONYME = '0') OR
      (SYNONYME = '1'));

create table t_client(
 client dm_code not null,
 nom dm_varchar30 not null,
 prenom1 dm_varchar35,
 sexe dm_varchar5,
 langue dm_varchar5 default '0',
 datenaissance dm_date,
 rue1 dm_varchar70,
 rue2 dm_varchar70,
 cp dm_varchar10,
 localite dm_varchar40,
 codepays dm_varchar5,
 tel1 dm_varchar20,
 tel2 dm_varchar20,
 gsm dm_varchar20,
 fax dm_varchar20,
 email dm_varchar50,
 url dm_varchar200,
 oa dm_varchar3,
 oacpas dm_code,
 matoa dm_varchar13,
 datedeboa dm_date,
 datefinoa dm_date,
 oc dm_varchar3,
 occpas dm_code,
 matoc dm_varchar13,
 catoc dm_varchar6,
 datedeboc dm_date,
 datefinoc dm_date,
 oat dm_varchar5,
 matat dm_varchar13,
 catat dm_varchar6,
 datedebat dm_date,
 datefinat dm_date,
 ct1 dm_numeric3,
 ct2 dm_numeric3,
 versionassurabilite dm_numpos2,
 num_tva dm_varchar15, --numéro tva pour les groupes
 numerocartesis dm_numeric10, 
 niss dm_varchar11, 
 inami dm_varchar11, 
 certificat dm_varchar32, -- certificat carte sis
 derniere_lecture dm_date, -- derniere lecture carte sis (ou document d'assurabilite) = doc justif
 datedebutvaliditepiece dm_date, -- date deb validite de la carte (ou du doc)
 datefinvaliditepiece dm_date, -- date fin validite de la carte (ou du doc)
 natpiecejustifdroit dm_char1 default '0', -- nature du document droit d'assurabilité --0 aucune, 1 carte sis inutilisé maintenant , 2 attestation , 3 mycare net
 commentaireindiv dm_commentaire2,
 commentairebloqu dm_char1,
 payeur dm_char1 default 'A' not null, --trig 'c' si collectivité = 1
 delaipaiement dm_numpos3,
 datedernierevisite dm_date_heure,
 collectivite dm_char1 default '0',
 numgroupe dm_code,
 idprofilremise dm_code,
 idfamille dm_code,
 editionbvac dm_char1 default '0',
 editioncbl dm_char1 default '0',
 edition704 dm_char1 default '0',
 typeprofilfacturation dm_char1, --trig '2' si collectivité = 1
 copiescanevasfacture dm_varchar3, --trig '1' si collectivité = 1
 editionimmediate dm_3etat, --0 si ultérieure et 1 si immédiate
 moment_facturation dm_numpos1, -- (0, "non défini"), (1, "date de la vente"),(2, "a la quinzaine"),(3, "fin de mois"),(4, "date précise");
 jour_facturation dm_numpos2, -- est en entier de 1 à 31 qui correspondant au typemomentfacturation 4
 plafond_credit dm_monetaire2,
 credit_en_cours dm_monetaire2,
 date_delivrance dm_char1 default'1', -- 0 : date de livraison, 1 : date de l'ordonnance
 numchambre dm_varchar24,
 etage dm_varchar6,
 maison dm_varchar6,
 lit dm_varchar6,
 code_court dm_varchar20,
 identifiant_externe dm_varchar20,
 nb_ticket_noteenvoi dm_numeric2 not null, -- si non null : coche ticket_noteenvoi
 nb_etiq_noteenvoi dm_numeric2 not null, -- si non null : coche etiq_noteenvoi
 sch_posologie dm_numpos1 default 0,
 ph_ref dm_numeric2 default 0, -- 0 aucun statut connu , 1 refusé, 2 accepté le patient a signé la convention auprès du pharmacien, 3 en attente de signature, 4 déjà fait dans une autre pharmacie, 5 autre_pharma_et_refus_ici, 6 arreté, 7 autre_pharma_et_arret_ici
 sejour_court dm_char1 default '0',
 tuh_boite_pleine dm_char1 default '0',
 decond_four dm_char1 default '0',
 sch_commentaire dm_commentaire2,
 numero_passport_cni varchar(25), 
 etat dm_char1 default '0'); --0 : actif , 1 : décédé, 2 : supprimé, 3 : hospitalisé

create index idx_clients on t_client (niss);
create index idx_famille on t_client (idfamille);

alter table t_client add constraint pk_clients primary key(client);
alter table t_client add constraint chk_cli_client check (trim(client) <> ' ');
alter table t_client add constraint chk_cli_nom check (trim(nom) <> '' and nom is not null);

alter table t_client
add constraint chk_cli_natpiecejustifdroit
check ((natpiecejustifdroit = '0') or
 (natpiecejustifdroit = '1') or
 (natpiecejustifdroit = '2') or
 (natpiecejustifdroit = '3') or
 (natpiecejustifdroit = '4') or
 (natpiecejustifdroit = ' '));

alter table t_client
add constraint chk_cli_payeur
check ((payeur = 'A') or
 (payeur = 'C'));

alter table t_client
add constraint chk_cli_sexe
check ((sexe = '0') or
 (sexe = '1') or
 (sexe = '2') or
 (sexe = ' '));

alter table t_client
add constraint chk_cli_collectivite
check((collectivite = '0') or
 (collectivite = '1') or
 (collectivite = ' '));

alter table t_client
add constraint chk_cli_langue
check((langue = '0') or
 (langue = '1') or
 (langue = '2') or
 (langue = '3'));
 
-- Contraintes désactivées pour NEXT
-- alter table t_client
-- add constraint fk_cli_profil_remise foreign key(idprofilremise)
-- references t_profilremise(profilremise)
-- on delete set null;

-- alter table t_client
-- add constraint fk_cli_collectivite foreign key(numgroupe)
-- references t_client(client)
-- on delete set null;
create table t_patient_pathologie(
  t_patient_pathologie_id dm_cle not null,
  t_client_id dm_code not null,
  pathologie varchar(2) not null,
  constraint pk_patient_pathologie primary key(t_patient_pathologie_id));

alter table t_patient_pathologie
add constraint fk_pat_pat_patient foreign key(t_client_id)
references t_client(client)
on delete cascade;

alter table t_patient_pathologie
add constraint fk_pat_pat_pathologie
check (pathologie in ('A', 'B', 'C', 'D', 'E', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                      'AV', 'BA', 'BB', 'BC', 'BD'));

create unique index unq_patient_pathologie on t_patient_pathologie(t_client_id, pathologie);

create sequence seq_patient_pathologie;

create table t_patient_allergie_atc(
  t_patient_allergie_atc_id dm_cle not null,
  t_client_id dm_code not null,
  classification_atc varchar(7) not null,
  constraint pk_patient_allergie_atc primary key(t_patient_allergie_atc_id));

alter table t_patient_allergie_atc
add constraint fk_pat_all_atc_patient foreign key(t_client_id)
references t_client(client)
on delete cascade;

create unique index unq_patient_allergie_atc on t_patient_allergie_atc(t_client_id, classification_atc);

create sequence seq_patient_allergie_atc;

      /* catRemb
 public final static TypeCategorieRemboursement CAT_A = new TypeCategorieRemboursement(1,"A"); 
  public final static TypeCategorieRemboursement CAT_B = new TypeCategorieRemboursement(2,"B"); 
  public final static TypeCategorieRemboursement CAT_C = new TypeCategorieRemboursement(3,"C"); 
  public final static TypeCategorieRemboursement CAT_S = new TypeCategorieRemboursement(4,"S"); 
  public final static TypeCategorieRemboursement CAT_X = new TypeCategorieRemboursement(5,"X"); 
  public final static TypeCategorieRemboursement CAT_D = new TypeCategorieRemboursement(6,"D"); 
  public final static TypeCategorieRemboursement CAT_G = new TypeCategorieRemboursement(7,"G"); 
  public final static TypeCategorieRemboursement CAT_W = new TypeCategorieRemboursement(8,"W"); 
  9  J
*/

/* condRemb
1 => Pas de condition '  '
2 => Attestation à rendre au patient (?)
3 => Tiers payant non autorisé. Reçu 704 (N)
4 => Mention écrite du médecin (v)
5 => Attestation à attacher (A)
6 => I
7 => Attestation à attacher à la dern.délivrance remb. (E)
8 => K
9 => Non remboursable si le médecin s'y oppose (t)
10 => Jeune femme de moins de 21 ans (J)
11 => Tiers_payant_autorisé_moyennant_un_cachet_sur_l'ordo. (n)
*/

CREATE TABLE T_ATTESTATION(
	 attestation dm_code NOT NULL
	,speID dm_code NOT NULL
	,cliID dm_code NOT NULL
	,numAtt dm_varchar20 NOT NULL
	,scanne dm_char1 NOT NULL
	,dateLimite dm_date_heure NOT NULL
	,condRemb dm_numpos2 NOT NULL
	,catRemb dm_numpos2 NOT NULL
	,nbCond dm_numpos2 DEFAULT '0'
	,nbMaxCond dm_numpos2 DEFAULT '0'
	,codAssurSocial dm_char1 DEFAULT NULL
);

ALTER TABLE t_attestation ADD CONSTRAINT PK_ATTESTATION PRIMARY KEY(attestation);
ALTER TABLE t_attestation ADD CONSTRAINT chk_numatt_not_null check (numAtt is not null);

ALTER TABLE t_attestation
ADD CONSTRAINT chk_attestation_scanne
CHECK ((scanne LIKE '0') OR
       (scanne LIKE '1'));

create sequence seq_attestation;

CREATE TABLE T_COMPTE(
  compte dm_code NOT NULL
 ,cliID dm_code NOT NULL
 ,liberType dm_char1 NOT NULL
 ,liberVal dm_varchar10 NOT NULL
 ,etat dm_char1 DEFAULT '0' NOT NULL
 ,id_centralisation dm_int DEFAULT NULL
);

ALTER TABLE t_compte ADD CONSTRAINT PK_COMPTE PRIMARY KEY(compte);

ALTER TABLE t_compte
ADD CONSTRAINT chk_compte_liberType
CHECK ((liberType LIKE '1') OR
       (liberType LIKE '2') OR
       (liberType LIKE '3') OR
       (liberType LIKE '4'));

ALTER TABLE t_compte
ADD CONSTRAINT chk_compte_etat
CHECK ((etat LIKE '0') OR
       (etat LIKE '1'));

CREATE TABLE T_CARTERIST(
	 carterist dm_code NOT NULL
	,compteID dm_code NOT NULL
	,cliID dm_code NOT NULL
	,dateEmis dm_date_heure NOT NULL
	,numCarte dm_varchar13 NOT NULL
	,virtuel dm_char1 NOT NULL
	,synonyme dm_char1 DEFAULT '0' NOT NULL
	,numAPBOfficine dm_varchar7 DEFAULT NULL
	,etat dm_char1 NOT NULL);

create sequence seq_carte_ristourne;

ALTER TABLE t_carterist ADD CONSTRAINT PK_CARTERIST PRIMARY KEY(carterist);

ALTER TABLE t_carterist
ADD CONSTRAINT chk_carterist_etat
CHECK ((etat LIKE '0') OR
       (etat LIKE '1'));


CREATE TABLE T_TRANSACTIONRIST(
	 transactionrist dm_code2 NOT NULL
	,numcarte dm_varchar13 DEFAULT NULL
	,compteID dm_code NOT NULL
	,montantRist dm_monetaire2 NOT NULL
	,typeTransact dm_char1 NOT NULL
	,tauxTVA dm_tva DEFAULT '6'
	,totalTicket dm_monetaire2 DEFAULT NULL
	,justificatif dm_varchar50 DEFAULT NULL
	,dateTicket dm_date_heure DEFAULT NULL
);

create sequence seq_transaction_ristourne;

ALTER TABLE t_transactionrist ADD CONSTRAINT PK_TRANSACTRIST PRIMARY KEY(transactionrist);
create index ix_transactionrist on t_transactionrist(typetransact,compteid);

ALTER TABLE t_transactionrist
ADD CONSTRAINT chk_transactionrist_tva
CHECK  ((tauxTVA = '6') OR
       (tauxTVA = '12') OR
       (tauxTVA = '21'));
--((tauxTVA = '0') OR --Le taux de tva 0 n'existe pas

ALTER TABLE t_transactionrist
ADD CONSTRAINT chk_transactionrist_type
CHECK ((typeTransact = '0') OR
       (typeTransact = '1') OR
       (typeTransact = '2') OR
       (typeTransact = '3'));
/*  0 et 1 : credit et  debit ristourne,
    2 et 3 : credit et debit ristourne dispo*/


CREATE TABLE T_HISTOVENTE(
   histovente dm_code NOT NULL
  ,mois dm_varchar7 NOT NULL
  ,annee dm_varchar7 NOT NULL
  ,periode dm_date NOT NULL
  ,speSerie dm_code NOT NULL
  ,qteVendue dm_Int NOT NULL
  ,nbVentes dm_Int NOT NULL
);
ALTER TABLE T_HISTOVENTE ADD CONSTRAINT PK_HISTOVENTE PRIMARY KEY(histovente);
ALTER TABLE T_HISTOVENTE ADD CONSTRAINT chk_hv_prod_not_null check (speSerie is not null);

create sequence seq_historique_vente;

CREATE TABLE T_HISTODELGENERAL(
	histodelgeneral dm_code NOT NULL,
	clientID dm_code NOT NULL,
	facture dm_Int DEFAULT NULL, -- Numero d'ordonnance
	codeOperateur dm_varchar10 DEFAULT NULL,       --inutile
	date_acte dm_date NOT NULL, --Date de la vente
	date_prescription dm_date DEFAULT NULL,
	nom_medecin dm_varchar50 DEFAULT NULL,
	prenom_medecin dm_varchar50 DEFAULT NULL,
	theTypeFactur dm_varchar2 NOT NULL -- 2 => Ordonnance, 3 => Vte Directe (avec facture)  -> remplir ce champs
);
ALTER TABLE T_HISTODELGENERAL ADD CONSTRAINT PK_HISTODELGENERAL PRIMARY KEY(histodelgeneral);
CREATE INDEX idx_histo_client on T_HISTODELGENERAL (clientID);
CREATE INDEX idx_histo_client_fac on T_HISTODELGENERAL (facture);


CREATE TABLE T_HISTODELDETAILS(
   histodeldetails dm_code NOT NULL
  ,histodelgeneralID dm_code NOT NULL
  ,cnkProduit dm_varchar8 DEFAULT NULL
  ,designation dm_varchar100 DEFAULT NULL
  ,qteFacturee dm_numeric7 DEFAULT NULL
  ,prixVte dm_monetaire2 DEFAULT NULL --prix unitaire
  ,produitID dm_code DEFAULT NULL
  ,rembourse dm_char1 
);
ALTER TABLE T_HISTODELDETAILS ADD CONSTRAINT PK_HISTODELDETAILS PRIMARY KEY(histodeldetails);
CREATE INDEX idx_histo_produit on T_HISTODELDETAILS (produitID);
CREATE INDEX idx_histo_cnk on T_HISTODELDETAILS (cnkProduit);
create sequence seq_historique_client_ligne;

CREATE TABLE T_HISTODELMAGISTRALE(
   histodelmagistrale dm_code NOT NULL
  ,histodelgeneralID dm_code NOT NULL
  ,designation dm_varchar100 DEFAULT NULL
  ,qteFacturee dm_Int DEFAULT NULL   -- quantité de magistrale vendu : 1 magistrale de 60 gellules
  ,detail dm_donnees DEFAULT NULL 
   -- :forme||';'||:qtfaire||'<br>'||   --forme : voir en dessous, qtfaire : 60 sur EX au dessus, Puis on rajoute ça par ligne : 
   -- lpad(:cnkProduit,7,'0')||';'||trim(:libproduit)||';'||trim(:complement)||';'||:qtprep||';'||:unite
   --||';'||:qte_gr||';'||:qte_a_pesee    ------------- Partie non utilisé dans Ultimate
   --||'<br>')   
  ,clemag dm_code NOT NULL
);
ALTER TABLE T_HISTODELMAGISTRALE ADD CONSTRAINT PK_HISTODELMAGISTRALE PRIMARY KEY(histodelmagistrale);
	/*  Formes galénique 
	GELULES = 1
    GELULES enrobées = 2
    CACHETS = 3
    PILULES = 4
    POUDRE_DIVISEE = 5
    SUPPOSITOIRES_ADULTES = 6
    NONE = 7, "PAS_DE_N°_DE_CERTIFICAT")
    SUPPOSITOIRES_ENFANTS = 8
    OVULES = 9
    SOLUTION_U_I = 10
    SOLUTION_U_E = 11
    GOUTTES_NASALES = 12
    TISANES = 13"
    MELANGE_POUDRE_U_I = 14
    MELANGE_POUDRE_U_E = 15
    POMMADE_DERMIQUE = 16
    COLLYRE = 17
    LOTION_OPHTALMIQUE = 18
    POMMADE_OPHTALMIQUE = 19, "POMMADE_OPHTAMIQUE"
    TEL_QUEL = 20, "TEL_QUEL"
    TIRET = 21, "------------------"
    SHAMPOOING = 22, "SHAMPOOING"
    EMULSION = 23, "EMULSION"
    INCONNU = 0, "INCONNU"
	*/
	
	/* Complement
	TypeMentionSabcoNew NONE = new TypeMentionSabcoNew(1, " ");
    TypeMentionSabcoNew AD = new TypeMentionSabcoNew(2, "AD");
    TypeMentionSabcoNew ANA = new TypeMentionSabcoNew(3, "ANA");
    TypeMentionSabcoNew QS = new TypeMentionSabcoNew(4, "Qs");
	*/
	
	/* unite
	TypeUniteSabcoNew GR = new TypeUniteSabcoNew(1, "Gr"); 
    TypeUniteSabcoNew MGR = new TypeUniteSabcoNew(2, "Mgr");
    TypeUniteSabcoNew ML = new TypeUniteSabcoNew(3, "Ml"); 
    TypeUniteSabcoNew GT = new TypeUniteSabcoNew(4, "Gttes"); 
    TypeUniteSabcoNew P = new TypeUniteSabcoNew(5, "Pièces"); 
    TypeUniteSabcoNew UG = new TypeUniteSabcoNew(6, "?g"); 
    TypeUniteSabcoNew POURCENT = new TypeUniteSabcoNew(7, "%"); 
    TypeUniteSabcoNew MILLE_L = new TypeUniteSabcoNew(8, "<1000 L>"); 
    TypeUniteSabcoNew UNITE = new TypeUniteSabcoNew(9, "Unités"); 
    TypeUniteSabcoNew MILLE_UI = new TypeUniteSabcoNew(10, "<1000 UI>"); 
	*/
	

CREATE TABLE T_CODEBARRE(
	codebarre dm_code NOT NULL
	,produit dm_code NOT NULL
	,code dm_varchar20 NOT NULL
	,ean13 dm_boolean NOT NULL
	,cbu dm_boolean NOT NULL
);
ALTER TABLE T_CODEBARRE ADD CONSTRAINT PK_CODEBARRE PRIMARY KEY(codebarre);
create sequence seq_codebarre;

CREATE TABLE T_PRODUIT(
  produit dm_code NOT NULL
  ,codeCNK_prod dm_varchar7
  ,designCNKFR_prod dm_varchar100 NOT NULL
  ,designCNKNL_prod dm_varchar100 NOT NULL
  ,prixachatcatalogue dm_monetaire2 DEFAULT NULL
  ,baseremboursement dm_monetaire2 DEFAULT NULL
  ,prixvente dm_monetaire2 DEFAULT NULL
  ,avec_cbu dm_boolean DEFAULT NULL
  ,gereinteressement dm_boolean DEFAULT NULL
  ,commentairevente dm_commentaire2 DEFAULT NULL
  ,geresuiviclient dm_boolean DEFAULT NULL
  ,tracabilite dm_boolean DEFAULT NULL
  ,profilgs dm_liste NOT NULL  --PROFIL_DEFAUT = 0, HISTORIQUE_SEUL = 1, HISTORIQUE_STOCK = 2, HISTORIQUE_STOCK_COMMANDE = 3   
	                               -- EST ce une bonne idee de reprende profil et calcul, ce parametre etant du coup prioritaire sur le parametre general ...
  ,calculgs dm_liste DEFAULT NULL --CALCUL_DEFAUT = 0, Automatique = 1, FIXE = 4, commande = qte vendue = 5
  ,veterinaire dm_boolean DEFAULT NULL
  ,video dm_boolean DEFAULT NULL
  ,designationlibrepossible dm_boolean DEFAULT NULL
  ,frigo dm_boolean DEFAULT NULL
  ,peremption_courte dm_boolean DEFAULT NULL
  ,categ_prod dm_varchar5 DEFAULT NULL --1 en select
  ,statuscomm_prod dm_varchar5 DEFAULT NULL --1 en select
  ,usage_prod dm_varchar5 DEFAULT NULL --1 en select
  ,remise_interdite dm_boolean DEFAULT NULL
  ,ristourne_interdite dm_boolean DEFAULT NULL
  ,isPdtPropre dm_boolean DEFAULT NULL
  ,tva dm_numeric3 DEFAULT NULL
  ,labo dm_varchar4 DEFAULT NULL
  ,concess dm_varchar4 DEFAULT NULL
  ,stockmini dm_numeric5 DEFAULT NULL
  ,stockmaxi dm_numeric5 DEFAULT NULL
  ,dateDernDeliv dm_date_heure DEFAULT NULL
  ,datePeremption dm_date_heure DEFAULT NULL
  ,zoneLibre dm_varchar50 DEFAULT NULL
  ,tauxRemise dm_remise DEFAULT NULL
  ,tauxRist dm_remise DEFAULT NULL
  ,ventilation dm_varchar50 DEFAULT NULL
  ,creationLgCmd dm_boolean DEFAULT 0 /* utilisé pour sabco old, offigest et farmix */
  ,classifInt dm_varchar50 DEFAULT NULL
  ,typePrixBloque dm_numeric1 DEFAULT 1  -- 1 non bloqué  2 bloqué si baisse prix  3 tjr bloqué
  ,designationBloquee dm_char1 DEFAULT '0'
  ,ficheBloquee dm_char1 DEFAULT '0'
); 

ALTER TABLE t_produit ADD CONSTRAINT PK_PRODUIT PRIMARY KEY(PRODUIT);

ALTER TABLE t_produit
ADD CONSTRAINT chk_prod_produit
CHECK (trim(produit) <> '');

ALTER TABLE t_produit
ADD CONSTRAINT chk_prod_design
CHECK((trim(designCNKfr_prod) <> ' ') AND (trim(designCNKnl_prod) <> ' '));


/* profilsgs :
   0 : (parametre général officine)
   1 : historique seul : pas de gestion des stocks, juste historique des ventes, 1 dépot, stock à 0
   2 : histo+stock
   3 : histo+stock+commande automatique ou proposition */

ALTER TABLE t_produit
ADD CONSTRAINT chk_prod_profilsgs
CHECK ((profilgs = '0') OR
       (profilgs = '1') OR
       (profilgs = '2') OR
       (profilgs = '3'));

CREATE UNIQUE INDEX idx_prod_codecip on t_produit (codeCNK_prod);

/* CalculGS
   0 : (parametre général officine)
   1 : automatique
   4 : fixe (il faut alors renseigner les mini/maxi)
   5 : qte commandée= qtevendues */

ALTER TABLE t_produit
ADD CONSTRAINT chk_prod_calculgs
CHECK ((calculgs = '0') OR
       (calculgs = '1') OR
       (calculgs = '4') OR
       (calculgs = '5'));


CREATE TABLE t_repartiteur(
	repartiteur dm_code NOT NULL
	,tr_repartiteur dm_code DEFAULT NULL
	,nomRepart dm_varchar50 NOT NULL
	,rueRepart dm_varchar70 DEFAULT NULL
	,rue2Repart dm_varchar70 DEFAULT NULL
	,locRepart dm_varchar40 DEFAULT NULL
	,cpRepart dm_varchar10 DEFAULT NULL
	,tel dm_varchar20 DEFAULT NULL
	,tel2 dm_varchar20 DEFAULT NULL
	,gsm dm_varchar20 DEFAULT NULL
	,fax dm_varchar20 DEFAULT NULL
	,email dm_varchar50 DEFAULT NULL
	,vitesse dm_numpos1 DEFAULT 0
	,pause dm_char1 DEFAULT '0'
	,nbTentatives dm_numpos3 DEFAULT 0
	,repDefaut dm_char1 DEFAULT '0'
	,objMensuel dm_chiffre_affaire DEFAULT 0
	,modeTransmission dm_char1 DEFAULT '5' --mode manuel
	,nbPdtsAssocies dm_Int NOT NULL   ------------------------------Pensez a compter aussi les fiche d analyse (voir ISA)
);
ALTER TABLE t_repartiteur ADD CONSTRAINT pk_repartiteur PRIMARY KEY(repartiteur);



CREATE TABLE t_fournisseur(
	fournisseur dm_code NOT NULL
	,tr_fournisseur dm_code DEFAULT NULL
	,nomFourn dm_varchar50 NOT NULL
	,rueFourn dm_varchar70 DEFAULT NULL
    ,rue2Fourn dm_varchar70 DEFAULT NULL
	,locFourn dm_varchar40 DEFAULT NULL
	,cpFourn dm_varchar10 DEFAULT NULL
	,tel dm_varchar20 DEFAULT NULL
	,tel2 dm_varchar20 DEFAULT NULL
	,gsm dm_varchar20 DEFAULT NULL
	,fax dm_varchar20 DEFAULT NULL
	,email dm_varchar50 DEFAULT NULL
	,vitesse dm_numpos1 DEFAULT NULL
	,pause dm_char1 DEFAULT NULL
	,nbTentatives dm_numpos3 DEFAULT NULL
	,modeTransmission dm_char1 DEFAULT NULL
	,fouPartenaire dm_char1 DEFAULT NULL
	,monoGamme dm_char1 DEFAULT NULL
	,nbPdtsAssocies dm_Int DEFAULT NULL
	,numAPB dm_num_apb4 DEFAULT NULL
);
ALTER TABLE t_fournisseur ADD CONSTRAINT pk_fournisseur PRIMARY KEY(fournisseur);

CREATE TABLE t_zonegeo(
	zonegeo dm_code NOT NULL,
	libelle dm_varchar50 NOT NULL
);
ALTER TABLE t_zonegeo ADD CONSTRAINT pk_zonegeo PRIMARY KEY(zonegeo);

CREATE TABLE t_depot(
	depot dm_code NOT NULL,
	libelle dm_varchar50 NOT NULL,
  automate dm_Int DEFAULT NULL
);

ALTER TABLE t_depot ADD CONSTRAINT pk_depot PRIMARY KEY(depot);

CREATE TABLE T_STOCK(
  stock dm_code NOT NULL
  ,qteEnStk dm_Int NOT NULL
  ,stkMin dm_Int NOT NULL /*sert de seuil déclencheur pour la commande de réapprovisionnement qd on est en multistock*/
  ,stkMax dm_Int DEFAULT NULL /*sert à calculer le nbre de pdts qu'on commande en réapprovisionnement*/
  /* ,qtePromise dm_Int DEFAULT NULL, */
  ,depot dm_code NOT NULL
  ,zoneGeo dm_code DEFAULT NULL
  ,produit dm_code NOT NULL
  ,priorite dm_varchar5 NOT NULL	/* 1 => stock prioritaire, 2 => stock secondaire) */
  ,depotvente dm_code NOT NULL  /* Integer : 1 => stock vente , 0 => stock non vente */
);

create sequence seq_stock;

alter table t_stock
add constraint chk_stock_prior
check ((priorite = '1') or
			(priorite = '2'));

CREATE TABLE T_TARIFPDT(
 tarifpdt dm_code not null
 ,produit dm_code not null
 ,fou dm_code not null
 ,prxAchat dm_prix_achat  --------inutile , à enlever
 ,remise dm_remise  --------inutile , à enlever
 ,prxAchtRemise dm_prix_achat  --------inutile , à enlever
 ,isRepart dm_numpos1 not null
 ,isAttitre dm_numpos1 not null
 ,gereofficentral dm_char1 default '0'
);

create sequence seq_tarif_produit;

ALTER TABLE T_TARIFPDT ADD CONSTRAINT pk_tarifpdt primary key (tarifpdt);
create index idx_tarifpdt_fou on t_tarifpdt(fou); 

alter table t_tarifpdt
add constraint chk_tarifpdt_fourn_repart
check ((isRepart = 0)or
       (isRepart = 1));

alter table t_tarifpdt
add constraint chk_tarifpdt_attitre
check ((isAttitre = 0)or
       (isAttitre = 1));

CREATE TABLE T_DELDIF(
	 deldif dm_code NOT NULL
	,produit dm_code NOT NULL
	,client dm_code NOT NULL
	,medecin dm_code -- not null   : on ne met pas le not null pour pouvoir créer une contrainte
	,noOrdon dm_varchar16 NOT NULL
	,dateprescr dm_date_heure DEFAULT NULL --triggers qui passe le null en date du jour 
	,dateDeliv dm_date_heure DEFAULT NULL
	,qttDiff dm_numeric7 NOT NULL
	,dateOrdon dm_date_heure DEFAULT NULL
	,typeDeldif dm_numpos1 DEFAULT 1 --1 del diff, 2 vente reporté, 3 renouvellement
	--Le type sert d'info uniquement, sauf renouvellement qui activera le flag : REPRISE_RENOUV  dans t_delivrancedifferree
);
create sequence seq_deldif_id;

ALTER TABLE T_DELDIF ADD CONSTRAINT pk_deldif primary key (deldif);
ALTER TABLE T_DELDIF ADD CONSTRAINT chk_prat_not_null check (medecin is not null);
ALTER TABLE T_DELDIF ADD CONSTRAINT chk_noOrdon_not_null check (noOrdon is not null);
ALTER TABLE T_DELDIF ADD CONSTRAINT chk_dd_prod_not_null check (produit is not null);

CREATE TABLE T_CREDIT(
	 credit dm_code NOT NULL
	,montant dm_monetaire2 NOT NULL
	,datecredit dm_date_heure
	,client dm_code NOT NULL
);
create sequence seq_credit_id;
ALTER TABLE T_CREDIT ADD CONSTRAINT pk_credit primary key (credit);

CREATE TABLE T_SYNONYME_PDT_CHIM(   ---------- utilise dans ISA
	 synonyme_pdt_chim dm_code NOT NULL
	,libelle dm_varchar50 NOT NULL
	,numAPB dm_varchar7 NOT NULL
	,langue dm_char1 NOT NULL
);

create sequence seq_synonyme_produit_chimique;

ALTER TABLE T_SYNONYME_PDT_CHIM ADD CONSTRAINT pk_synpdtchim primary key (synonyme_pdt_chim);


CREATE TABLE T_LITIGE(
	 litige dm_code not null
	,client dm_code not null
	,typeLitige dm_char1 NOT NULL -- 1 => Manque ordonnance/ avance produit
	,descriptionLitige dm_varchar50 DEFAULT NULL
	,nomPdt dm_varchar50 DEFAULT NULL
	,produit dm_code NOT NULL
	,cdbu dm_varchar1000 DEFAULT NULL
	,noOrd dm_varchar50 DEFAULT NULL
	,prixClient dm_monetaire2 NOT NULL -- Montant que le client paye (tva comprise) sans le montant payé par le tiers payant
	,qtedelivree dm_numeric7 NOT NULL
	,qtemanquante dm_numeric7 DEFAULT 0
	,dateVente dm_date_heure NOT NULL
	,isFacture dm_char1 DEFAULT NULL
	,gtin dm_varchar1000 DEFAULT NULL --14* x produits
	,numero_serie dm_varchar1000 DEFAULT NULL --20 (max) * x produits
  -- attention un gtin doit avoir un numéro de serie
);

ALTER TABLE T_LITIGE ADD CONSTRAINT pk_litige primary key (litige);
ALTER TABLE T_LITIGE ADD CONSTRAINT chk_lit_prod_not_null check (produit is not null);
create sequence seq_LITIGE;


CREATE TABLE T_ORGANISMECPAS( --récupération des CPAS
	organismeCPAS dm_code NOT NULL
	,nom dm_varchar50 NOT NULL
	,nomreduit dm_varchar20 DEFAULT NULL
	,orgreference dm_char1 DEFAULT '0'
	,typeoa dm_varchar20 NOT NULL
--	,identifiant dm_varchar3 DEFAULT NULL --inutile CPAS = 998
	,rue1 dm_varchar70 DEFAULT NULL
	,rue2 dm_varchar70 DEFAULT NULL
	,cp dm_varchar10 DEFAULT NULL
	,localite dm_varchar40 DEFAULT NULL
	,tel1 dm_varchar20 DEFAULT NULL
	,tel2 dm_varchar20 DEFAULT NULL
	,gsm dm_varchar20 DEFAULT NULL
	,fax dm_varchar20 DEFAULT NULL
	,email dm_varchar50 DEFAULT NULL
	,url dm_varchar200 DEFAULT NULL
	,destinataire_facture dm_code DEFAULT NULL --lien vers t_patient
	,nocpas dm_int DEFAULT NULL
	,dlg_mttclient_cpas dm_char1 DEFAULT NULL
);

CREATE TABLE T_FICHEANALYSE(
  fiche_analyse_id dm_code NOT NULL
  ,cnk_produit dm_code constraint chk_NULL_cnk_produit check (cnk_produit IS NOT NULL) --05 on lie au t_chim_produit ensuite
  ,no_analyse dm_code constraint chk_NULL_no_analyse check (no_analyse IS NOT NULL)
  ,no_autorisation dm_varchar20 constraint chk_NULL_no_autorisation check (no_autorisation IS NOT NULL)
  ,ReferenceAnalytique dm_code
  ,TR_ReferenceAnalytique dm_numpos1
  ,date_entree dm_date constraint chk_NULL_date_entree check (date_entree IS NOT NULL)
  ,fabricant_id dm_code constraint chk_NULL_fabricant_id check (fabricant_id IS NOT NULL)     -----------------------Pensez à ajouter un count dans la table t_fournisseur sur le nb de produits
  ,grossiste_id dm_code             -----------------------Pensez à ajouter un count dans la table t_repartiteur sur le nb de produits
  ,no_lot dm_varchar20 constraint chk_NULL_no_lot check (no_lot IS NOT NULL)
  ,prix_achat dm_monetaire3 default 0
  ,cnk_lie dm_varchar7 constraint chk_NULL_cnk_lie check (cnk_lie IS NOT NULL)   --cnk du t_produit lié
  ,no_bon_livraison dm_varchar20
  ,date_ouverture dm_date
  ,date_peremption dm_date constraint chk_NULL_date_peremption check (date_peremption IS NOT NULL)
  ,date_fermeture dm_date
  ,etat dm_numpos1 DEFAULT 0
  ,quantite_initial dm_float7_2 constraint chk_NULL_quantite_initial check (quantite_initial IS NOT NULL)
  ,unite_qte dm_varchar5 constraint chk_NULL_unite_qte check (unite_qte IS NOT NULL)
  ,quantite_restante dm_float7_2
  ,remarques dm_commentaire2
  ,datemaj dm_date_heure NOT NULL
  ,zonegeo dm_code --code de t_zonegeo
);

ALTER TABLE T_FICHEANALYSE ADD CONSTRAINT pk_ficheanalyse primary key (fiche_analyse_id);


CREATE TABLE T_MAGISTRALE_FORMULAIRE(
  formulaire_id dm_code NOT NULL
  ,libelle_FR dm_libelle NOT NULL
  ,libelle_NL dm_libelle NOT NULL
  ,nom_court_FR dm_varchar10 NOT NULL
  ,nom_court_NL dm_varchar10 NOT NULL
  ,type_formulaire dm_numpos1 NOT NULL-- 1 offciel, 2 privé
  );

ALTER TABLE T_MAGISTRALE_FORMULAIRE ADD CONSTRAINT pk_magistrale_formulaire primary key (formulaire_id);

CREATE TABLE T_MAGISTRALE_FORMULE(
  formule_id dm_code NOT NULL
  ,formulaire_id dm_code NOT NULL
  ,FORMULE_UID dm_int
  ,cnk dm_varchar7
  ,libelle_FR dm_libelle --not null
  ,libelle_NL dm_libelle -- not null
  ,TYPE_FORME_GALENIQUE dm_int NOT NULL
  ,QUANTITEPREPAREE dm_monetaire3 NOT NULL
  ,UNITEQUANTITE dm_int NOT NULL --on passe unite a 99 si non trouve pour générer une erreur dans ultimate mais que la ligne passe quand meme
  ,COMMENTAIRE dm_varchar200
  ,ETAT dm_char1
  ,DATEMAJ dm_date
  );
--  SUPPLEMENT            NUMBER(9,6),
--  FLACONNAGE            NUMBER(9,6),
--  HOMEOPATHIQUE         CHAR(1 BYTE),
ALTER TABLE T_MAGISTRALE_FORMULE ADD CONSTRAINT pk_magistrale_formule primary key (formule_id);
ALTER TABLE T_MAGISTRALE_FORMULE ADD CONSTRAINT chk_formule_gal_not_null check (TYPE_FORME_GALENIQUE is not null);
ALTER TABLE T_MAGISTRALE_FORMULE ADD CONSTRAINT chk_formule_qte_not_null check (QUANTITEPREPAREE is not null);

CREATE TABLE T_MAGISTRALE_FORMULE_LIGNE(
  formule_ligne_id dm_code NOT NULL
  ,formule_id dm_code NOT NULL
  ,ordre dm_int NOT NULL
  ,chim_produit_cnk dm_varchar7
  ,produit_id dm_code
  ,formule_incorporee_id dm_code
  ,unitequantite dm_int NOT NULL   --on passe unite a 99 si non trouve pour générer une erreur dans ultimate mais que la ligne passe quand meme
  ,quantite dm_monetaire3 NOT NULL
  ,mention_complementaire dm_char1
  ,datemaj dm_date NOT NULL
  );
ALTER TABLE T_MAGISTRALE_FORMULE_LIGNE ADD CONSTRAINT pk_magistrale_formule_ligne primary key (formule_ligne_id);

CREATE TABLE t_historique_achat(
  t_historique_achat_id dm_cle not null,
  t_produit_id dm_code not null,
  nombre_achats_repartiteur dm_quantite default 0 not null,
  quantite_achetee_repartiteur dm_quantite default 0 not null,
  nombre_achats_directe dm_quantite default 0 not null,
  quantite_achetee_directe dm_quantite default 0 not null,
  mois smallint,
  annee smallint,
  constraint pk_historique_achat primary key(t_historique_achat_id));

alter table t_historique_achat
add constraint fk_histach_produit foreign key(t_produit_id)
references t_produit(produit)
on delete cascade;

create sequence seq_historique_achat;

create table t_parametres(
	cle varchar(70), 
	valeur varchar(500)
	);  
create unique index unq_parametres on t_parametres(cle);

--Schema de medication
create table t_sch_medication_produit(
	t_sch_medication_produit_id dm_code not null,
	t_aad_id dm_code not null,
	t_produit_id dm_code not null,
	libelle dm_varchar250, --libellé article
	typeformedpp dm_cle,
	typemedication dm_cle default '1' not null,-- 1 Chronique, 2 Temporaire   --number 9  dans ultimate , à changer ???????????????????????????????????????????????
	date_debut dm_date,
	date_fin dm_date,
	commentaire dm_commentaire,
	--t_magistrale_id dm_cle,   -- on reprend les formules mais pas les magistrales donc ....
	t_formule_id dm_cle,
	date_debut_susp dm_date,
	date_fin_susp dm_date,
constraint pk_sch_medication_produit primary key(t_sch_medication_produit_id));

 /* typeformedpp
	public static final int SW_CUILLERES_CAFE = 1; // OK
    public static final int SW_CUILLERES_SOUPE = 2; // OK
    public static final int SW_COMP_EFFERV = 3;
    public static final int SW_COMPRIMES = 4; // OK
    public static final int SW_GELULES = 5; // OK
    public static final int SW_INJECTIONS = 6;
    public static final int SW_PULVERISATIONS = 7;
    public static final int SW_SUPPOSITOIRES = 8; // OK
    public static final int SW_APPLICATION = 9; // OK
    public static final int SW_SACHET = 10; // OK
    public static final int SW_GOUTTES = 11; // OK
    public static final int SW_INHALATIONS = 12; // OK
    public static final int SW_AMPOULE = 13; // OK*/


CREATE TABLE T_SCH_MEDICATION_PRISE(
	T_SCH_MEDICATION_PRISE_ID dm_code NOT NULL , 
	T_SCH_MEDICATION_PRODUIT_ID dm_code NOT NULL , 
	TYPE_FREQUENCE dm_numpos2 NOT NULL , --1 jorunalier, 2 jours au choix, 3 tous les nb_jours jours, 4 saisie libre, 5 posologie a la demande
--Certain type sont lié à la table t_sch_prise_date et t_sch_unite_prise qu on ne reprendra que plus tard si besoin est, trop specifique a ultimate pour l instant.
	FREQUENCE_JOURS dm_varchar7,  --'1000000' pour les lundis
	PRISE_LEVER dm_float6_3, 
	PRISE_PTDEJ dm_float6_3, 
	TYPE_MOMENT_PTDEJ dm_numpos2 default 1, --1 non precisé 2 avant 3 pendant 4 après
	PRISE_MIDI dm_float6_3, 
	TYPE_MOMENT_MIDI dm_numpos2 default 1, 
	PRISE_SOUPER dm_float6_3, 
	TYPE_MOMENT_SOUPER dm_numpos2 default 1, 
	PRISE_COUCHER dm_float6_3, 
	PRISE_HEURE1 dm_float6_3, 
	PRISE_HEURE2 dm_float6_3, 
	PRISE_HEURE3 dm_float6_3, 
	PRISE_10HEURES dm_float6_3, 
	PRISE_16HEURES dm_float6_3, 
	LIBELLE_HEURE1 dm_varchar200, 
	LIBELLE_HEURE2 dm_varchar200, 
	LIBELLE_HEURE3 dm_varchar200, 
	NB_JOURS dm_numeric4, 
CONSTRAINT PK_SCH_MEDICATION_PRISE PRIMARY KEY (T_SCH_MEDICATION_PRISE_ID));
create sequence seq_schem_prise;

CREATE TABLE T_SOLDE_TUH_PATIENT(
-- Attention il est possible de créer plusieurs solde pour le mm patient/produit si plusieurs ordo
	t_solde_tuh_patient_id dm_code not null
	,t_aad_id dm_code not null
  	,t_produit_id dm_code not null
	,solde dm_numeric7 --solde ordo du patient
	,noord dm_Int
	,date_ordo dm_date
	,catRemb dm_numpos2 
	,condRemb dm_numpos2 
	,t_praticien_id dm_code
	,t_type_tuh dm_numpos1 --1 patient, 2 boite mutu, 3 pmi pharmacie
	,t_collectivite_id dm_code not null
	,ordo_suspendu dm_int default 0 not null
	,cbu dm_varchar16 
	,DATE_DEBUT_ASS_OA dm_date
	,DATE_FIN_ASS_OA dm_date
	,DATEDEBVALIDITEPIECE dm_date
	,DATEFINVALIDITEPIECE dm_date
	,DATEDERNCONSULT_MYCARENET dm_date
	,CT1 dm_numeric3 
	,CT2 dm_numeric3 
	,CONSTRAINT PK_SOLDE_TUH_PATIENT PRIMARY KEY (t_solde_tuh_patient_id));
create sequence seq_solde_tuh_patient_id;

CREATE TABLE T_SOLDE_TUH_BOITE(
	t_solde_tuh_boite_id dm_code not null
	,t_collectivite_id dm_code -- si null alors boite stock pharmacie
	,t_produit_id dm_code not null
	,solde dm_numeric7 --solde boite de la colectivite
,CONSTRAINT PK_SOLDE_TUH_BOITE PRIMARY KEY (t_solde_tuh_boite_id));
create sequence seq_solde_tuh_boite_id;


COMMIT;