 set sql dialect 3;
/***********************************  Client / Patient   ************************************************/
create or alter procedure ps_supprimer_donnees_pha(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 0) then
  begin
    --delete from t_parametre;
  end
  else
    if (ATypeSuppression = 1) then --grille praticiens
    begin
      delete from t_medecin;
    end
    else
      if (ATypeSuppression = 2) then -- organisme
      begin
		delete from T_ORGANISMECPAS;
      end
      else
        if (ATypeSuppression = 3) then --grille clients
        begin
			delete from T_PROFILREMISE;
			delete from T_PROFILREMISESUPPL;
      delete from T_CREDIT;
			delete from T_CLIENT;
			delete from t_compte;
			delete from T_CARTERIST;
			delete from T_TRANSACTIONRIST;
			delete from T_ATTESTATION;
			delete from t_patient_pathologie;
			delete from t_patient_allergie_atc;	
        end
        else
          if (ATypeSuppression = 4) then	 --produits
          begin
            delete from t_zonegeo;
            delete from T_TARIFPDT;
            delete from t_histovente;
			delete from t_historique_achat;
            delete from t_produit;
            delete from T_STOCK;
            delete from t_depot;
			delete from t_fournisseur;
			delete from t_repartiteur;
            delete from T_FICHEANALYSE;
            delete from T_CODEBARRE;
			delete from T_MAGISTRALE_FORMULAIRE;
			delete from T_MAGISTRALE_FORMULE;
			delete from T_MAGISTRALE_FORMULE_LIGNE;
			delete from t_sch_medication_produit;
			delete from T_SCH_MEDICATION_PRISE;
			delete from T_SOLDE_TUH_PATIENT;
			delete from T_SOLDE_TUH_BOITE;
          end
          else
            if (ATypeSuppression = 5) then --encours
            begin
              delete from t_deldif;
              --delete from T_CREDIT;
              delete from T_LITIGE;
            end
            else
              if (ATypeSuppression = 8) then -- autre
              begin
                delete from t_parametres;
                delete from T_HISTODELDETAILS;
                delete from T_HISTODELGENERAL;
                delete from T_HISTODELMAGISTRALE;
              end
				else
				if (exists(select *
						 from rdb$procedures
						 where rdb$procedure_name = 'PS_SUPPRIMER_DONNEES_MODULES')) then
				execute statement 'execute procedure PS_SUPPRIMER_DONNEES_MODULES(' || '''' || ATypeSuppression || '''' || ')';
end;

/*  Source : patients.csv*/
create or alter procedure ps_creer_patients(
  CLIENT varchar(50)
 ,PRENOM varchar(100)
 ,NOM varchar(100)
 ,DATENAISSANCE varchar(30)    
 ,NISS varchar(13)
 ,SEXE varchar(1)  -- 0: unknown 1:male 2:female
 ,ETAT varchar(50) --1:active 2:hospitalized 3:dead
 ,RUE1 varchar(100)
 ,LOCALITE varchar(80)
 ,CP varchar(10)
 ,CODEPAYS varchar(2)
 ,NUM_TVA varchar(15)
 ,LANGUE varchar(10)
 ,TEL1 varchar(30)
 ,FAX varchar(30)
 ,EMAIL varchar(50)
 ,GSM varchar(30)
 ,TWITTER varchar(100) --a mettre en commentaire
 ,FACEBOOK varchar(100) --a mettre en commentaire 
 ,SITEWEB varchar(200)
 ,COMMENTAIREINDIV varchar(5000)
 ,NATIONALITY varchar(50) --??????????????????????????????
 ,OA varchar(50)
 ,MATOA varchar(13)
 ,CT1 varchar(50)
 ,CT2 varchar(50)
 ,DATEDEBOA varchar(30)
 ,DATEFINOA varchar(30)
 ,OC varchar(50)
 ,MATOC varchar(13)
 ,CTOC1 varchar(50)
 ,CTOC2 varchar(50)  --,CATOC varchar(2)
 ,DATEDEBOC varchar(30)
 ,DATEFINOC varchar(30)
 ,DERNIERE_LECTURE varchar(30)
 ,IDPROFILREMISE varchar(50)
 ,DEBT varchar(50)   --????????????????????????????? 
 ,supplementary_type varchar(1) --M for military, P for police if supplementary needs this info
 ,PH_REF varchar(50)
 ,dateordo varchar(30) --rp_last_init_at date when last init hono has been set
 ,datedernieretarification varchar(30)-- rp_last_hono_at date when last tarification hono has been set
 ,cpas_number varchar(50)  -- ???????????????
 ,cpas_case_number varchar(50)-- ???????????????
 ,cpas_max_patient_amount varchar(50)  -- ???????????????
 ,cpas_max_case_amount varchar(50)  -- ???????????????
 /*,TEL2 varchar(30)
 ,COLLECTIVITE varchar(1)
 ,TYPEPROFILFACTURATION int
 ,PRENOM1 varchar(20)
 ,NUMGROUPE int
 ,EDITION704 int
 ,EDITIONCBL int
 ,EDITIONBVAC int
 ,NUMCHAMBRE varchar(15)
 ,OAT int
 ,MATAT varchar(13)
 ,DATEDEBAT date
 ,DATEFINAT date
 ,VERSIONASSURABILITE int
 ,NUMEROCARTESIS numeric(10)
 ,CERTIFICAT varchar(32)
 ,NATPIECEJUSTIFDROIT int
 ,DATE_DECES date
 ,IDFamille int*/
 )
as
declare comm varchar(500);
declare TVA12 varchar(15);
declare d1 date;
declare d2 date;
declare variable StrNom varchar(100);
declare variable StrPrenom varchar(100);
declare variable StrNjf varchar(30);
declare variable credit decimal(5,2);
begin

TVA12 = replace(:NUM_TVA,'-','');
TVA12 = replace(:TVA12,'.','');
TVA12 = replace(:TVA12,' ','');
TVA12 = substring(:TVA12 from 1 for 12);

if (:COMMENTAIREINDIV is not null ) then comm = substring(:COMMENTAIREINDIV from 1 for 500);
if (:twitter is not null ) then comm = substring(:comm||' TWITTER : '||:twitter from 1 for 500);
if (:facebook is not null ) then comm = substring(:comm||' FACEBOOK : '||:facebook from 1 for 500);

if (trim(DATEDEBOC) <>  '') then d1 = substring(trim(:DATEDEBOC) from 1 for 10);
if (trim(DATEFINOC) <>  '') then d2 = substring(trim(:DATEFINOC) from 1 for 10);

StrNom = :NOM;
StrPrenom = :PRENOM;
if ((StrNom is null) or (StrNom = '')) then execute procedure ps_separer_nom_prenom(StrPrenom, ' ') returning_values :StrNom, :StrPrenom, :strNjf;

insert into T_CLIENT(
  CLIENT
 ,NOM
 ,PRENOM1
 ,DATENAISSANCE
 ,NISS
 ,SEXE
 ,ETAT
 ,RUE1
 ,LOCALITE
 ,CP
 ,CODEPAYS
 ,NUM_TVA
 ,LANGUE
 ,TEL1
 ,FAX
 --,TEL2
 ,EMAIL
 ,GSM
 ,URL
 ,COMMENTAIREINDIV
 --,nationality
 ,OA
 ,MATOA
 ,CT1
 ,CT2
 ,DATEDEBOA
 ,DATEFINOA
 ,OC
 ,MATOC
 ,CATOC  --,supplementary_type
 ,DATEDEBOC
 ,DATEFINOC
 ,DERNIERE_LECTURE
 ,IDPROFILREMISE
 --,debt ???
 ,PH_REF
 )
 values(
  :CLIENT
 ,substring(:StrNom from 1 for 30)
 ,substring(:StrPrenom from 1 for 35)
 ,substring(:DATENAISSANCE from 1 for 10)
 ,substring(:NISS from 1 for 11)
 ,:SEXE
 ,case when :ETAT = '2' then 3
       when :ETAT = '3' then 1
       else 0
  end
 ,substring(:RUE1 from 1 for 70)
 ,substring(:LOCALITE from 1 for 40)
 ,substring(trim(:CP) from 1 for 6)
 ,:CODEPAYS
 ,trim(:TVA12)
 ,iif(upper(substring(:langue from 1 for 2))= 'NL','1','0')
 ,substring(:TEL1 from 1 for 20)
 ,substring(:FAX from 1 for 20)
 ,substring(:EMAIL from 1 for 50)
 ,substring(:GSM from 1 for 20)
 ,:SITEWEB
 ,:comm
 ,:OA
 ,:MATOA
 ,:CT1
 ,:CT2
 ,substring(:DATEDEBOA from 1 for 10)
 ,substring(:DATEFINOA from 1 for 10)
 ,:OC
 ,:MATOC
 ,case
  when :supplementary_type='M' then 91
  when :supplementary_type='P' then 93
  --when :CATOC='CP' then 0
  else null
  end
 ,:d1
 ,:d2
 ,substring(:DERNIERE_LECTURE from 1 for 10)
 ,:IDPROFILREMISE
 --crp_state 1: accepted, 2: declined, 3: already set in another pharmacy, 4:possible   lgpi :  -- 0 aucun statut connu , 1 refusé, 2 accepté le patient a signé la convention auprès du pharmacien
 ,CASE 
  when :PH_REF = 1 then 2 
  when :PH_REF = 2 then 1
  else 0
 end
 );
 credit = cast(:debt as DECIMAL(5,2));
 if (credit <> 0) THEN
BEGIN
  insert into t_CREDIT(
 credit
,montant
,datecredit
,client
)
values(
 :client
,:credit
,CURRENT_DATE
,:client
);
END 

End;

/********************************************************************************************************/
/************************************** COLLECTIVITES ***************************************************/
/********************************************************************************************************/
/*
  Source : collectivites.csv
*/
create or alter procedure ps_creer_collectivites(
  client int,
  first_name varchar(100),
  last_name varchar(100),
  name varchar(100),
  street varchar(100),
  city varchar(80),
  postcode varchar(10),
  country_code varchar(2),
  vat_number varchar(20),
  langage varchar(5),
  phone_number varchar(30),
  fax varchar(30),
  email varchar(50),
  mobile_phone_number varchar(30),
  twitter varchar(30),
  facebook varchar(30),
  website varchar(100),
  commentaire varchar(500),
  fidelity_profile_id varchar(50),
  debt varchar(50)
  )
  as
    declare comm varchar(500);
    declare TVA12 varchar(20);
  begin
    TVA12 = replace(:vat_number,'-','');
TVA12 = replace(:TVA12,'.','');
TVA12 = replace(:TVA12,' ','');
TVA12 = substring(:TVA12 from 1 for 12);

if (:commentaire is not null ) then comm = substring(:commentaire from 1 for 500);
if (:twitter is not null ) then comm = substring(:comm||' TWITTER : '||:twitter from 1 for 500);
if (:facebook is not null ) then comm = substring(:comm||' FACEBOOK : '||:facebook from 1 for 500);

 insert into T_CLIENT(
  CLIENT
 ,NOM
 ,RUE1
 ,LOCALITE
 ,CP
 ,CODEPAYS
 ,NUM_TVA
 ,LANGUE
 ,TEL1
 ,FAX
 ,EMAIL
 ,GSM
 ,URL
 ,COMMENTAIREINDIV
 ,IDPROFILREMISE
 ,COLLECTIVITE
 )
 values(
  :CLIENT
 ,substring(coalesce (:name, : first_name) from 1 for 30)
 ,substring(:street from 1 for 70)
 ,substring(:city from 1 for 40)
 ,substring(trim(:postcode) from 1 for 6)
 ,:country_code
 ,trim(:TVA12)
 ,iif(upper(substring(:langage from 1 for 2))= 'NL','1','0')
 ,substring(:phone_number from 1 for 20)
 ,substring(:fax from 1 for 20)
 ,substring(:email from 1 for 50)
 ,substring(:mobile_phone_number from 1 for 20)
 ,:website
 ,:comm
 ,:fidelity_profile_id
 ,1
 );

  end;

/********************************************************************************************************/
/************************************* LIENS FAMILLE / COLLECTIVITES ************************************/
/********************************************************************************************************/

create or alter procedure ps_creer_liens(
  patient_id int,
  recipient_id int,
  collectivity_id int,
  section_id int,
  section_name varchar(50),
  etage varchar(6),
  chambre varchar(24),
  lit varchar(6)
)
as
begin
  if (:recipient_id is not null) then
    update T_CLIENT 
    set IDFAMILLE = :recipient_id
    where CLIENT = :patient_id;
  if (:collectivity_id is not null) then
    update T_CLIENT
    set NUMCHAMBRE = :chambre,
        ETAGE = :etage,
        LIT = :lit,
        MAISON = substring(:section_name from 1 for 6),
		NUMGROUPE = :collectivity_id
    where CLIENT = :patient_id;
end;

/********************************************************************************************************/
/************************************** MAGISTRALES *****************************************************/
/********************************************************************************************************/
create sequence seq_formulaire_id;
create or alter procedure ps_creer_magistrale(
  id varchar(50),
  nom_fr varchar(65),
  nom_nl varchar(65),
  formule_galenique int,
  contenu varchar(8000),
  nombre int,  -- souvent le numero d ordo ou juste un sequence  selon amaury
  quantite float,
  unite int -- => 'vide' : pièces, '10' : Gramme  selon amaury
)
as
declare formulaireId int;
begin

if (not(exists(select *
                   from T_MAGISTRALE_FORMULE
                   where COMMENTAIRE = substring(:contenu from 1 for 200) ))) then
begin
	insert into T_MAGISTRALE_FORMULAIRE(
		FORMULAIRE_ID ,
		LIBELLE_FR ,
		LIBELLE_NL ,
		NOM_COURT_FR ,
		NOM_COURT_NL ,
		TYPE_FORMULAIRE 
	)
	values
	(
		next value for seq_formulaire_id,
		substring(:nom_fr from 1 for 50),
		substring(:nom_nl from 1 for 50),
		substring(:nom_fr from 1 for 10),
		substring(:nom_nl from 1 for 10),
		2 -- je considère que l'import, c'est du "privé"
	) returning FORMULAIRE_ID into :formulaireId;
 
	insert into T_MAGISTRALE_FORMULE(
		FORMULE_ID,
		FORMULAIRE_ID,
		--FORMULE_UID,
		--CNK,
		LIBELLE_FR,
		LIBELLE_NL,
		TYPE_FORME_GALENIQUE,
		QUANTITEPREPAREE,
		UNITEQUANTITE,
		COMMENTAIRE,
		ETAT,
		DATEMAJ
	)
	values (
		:id,
		:formulaireId,
		--'',
		substring(:nom_fr from 1 for 50),
		substring(:nom_nl from 1 for 50),
		/*case 
			when :formule_galenique=20
			when :formule_galenique=30
			when :formule_galenique=40
			else null,*/
		:formule_galenique,	
		:quantite,
		iif(:unite =10,0,8), --si 10 grammes sinon piece
		substring(:contenu from 1 for 200),
		'0',
		cast('Today' as date)
	);
end

end;

/********************************************************************************************************/
/**************************************   PRODUITS   ****************************************************/
/********************************************************************************************************/
/*    Source : products.csv */
create or alter procedure ps_creer_produits(
   produit int -- (id)
  ,TVA varchar(15)-- (vat_rate)
  ,prixvente float -- (sale_price)
  ,prixachatcatalogue float -- (purchase_price)
  ,codeCNK_prod varchar(10) -- (code)
  ,commentaire varchar(200) -- (comment)
  ,stockmini int
  ,stockmaxi int
  ,designCNKFR_prod varchar(80) -- (name_fr)
  ,designCNKNL_prod varchar(80) -- (name_nl)
  ,stock_gere varchar(10) -- (stock_managed)
  ,dynamic_managed varchar(10)
  ,average_purchase_price float
  ,weighted_average_purchase_price float
  --,categ_prod varchar(1)
  --,dateDernDeliv date
  ,datePeremption varchar(30) -- (expiry_date)
)
as
begin
 insert into T_PRODUIT(
   produit
  ,codeCNK_prod
  ,designCNKFR_prod
  ,designCNKNL_prod
  ,prixachatcatalogue
  ,prixvente
  ,TVA
  --,categ_prod
  ,stockmini
  ,stockmaxi
  --,dateDernDeliv
  ,datePeremption
  ,profilgs
  ,isPdtPropre
  ,commentairevente
 )
  values(
   :produit
  ,substring(trim(:codeCNK_prod) from 1 for 7)
  --,'Produits issu de la reprise'
  --,'reprise'
  ,substring(trim(:designCNKFR_prod) from 1 for 50)
  ,substring(trim(:designCNKNL_prod) from 1 for 50)
  ,:prixachatcatalogue
  ,:prixvente
  ,:TVA
  --,:categ_prod
  ,:stockmini
  ,:stockmaxi
  --,:dateDernDeliv
  ,substring(:datePeremption from 1 for 10)
  ,iif(trim(:stock_gere)='TRUE',1,0)
  ,0   -- artType = div  pour les produits propres ??????
  ,:commentaire
  );
 end;

/*
  --,classifInt dm_varchar50 DEFAULT NULL
  --,baseremboursement dm_monetaire2 NOT NULL,
  --,avec_cbu dm_boolean NOT NULL,
  --,gereinteressement dm_boolean NOT NULL,
  --,commentairevente dm_commentaire DEFAULT NULL,
  --,geresuiviclient dm_boolean NOT NULL,
  --,tracabilite dm_boolean NOT NULL,
  --,calculgs dm_liste NOT NULL,
  --,veterinaire dm_boolean NOT NULL,
  --,video dm_boolean NOT NULL,
  --,designationlibrepossible dm_boolean NOT NULL,
  --,frigo dm_boolean NOT NULL,
  --,peremption_courte dm_boolean NOT NULL,
  --,statuscomm_prod dm_varchar5 NOT NULL,
  --,usage_prod dm_varchar5 NOT NULL,
  --,remise_interdite dm_boolean NOT NULL,
  --,ristourne_interdite dm_boolean NOT NULL,
  --,tva dm_tva NOT NULL,
  --,labo dm_varchar4 DEFAULT NULL,
  --,concess dm_varchar4 DEFAULT NULL,
  --,zoneLibre dm_varchar50 DEFAULT NULL,
  --,tauxRemise dm_remise DEFAULT NULL,
  --,tauxRist dm_remise DEFAULT NULL,
  --,ventilation dm_varchar50 DEFAULT NULL,
  --,creationLgCmd dm_boolean DEFAULT 0,
  */
 
/********************************************************************************************************/
/**************************************   STOCK   ****************************************************/
/********************************************************************************************************/
/*   Source : product_stocks.csv */
create or alter procedure ps_creer_stocks(
  stock int -- (id)
  ,produit int -- (product_id)
  ,depot int 
  ,zonegeo int -- (storage_location_id)
  ,stockTotal int -- (quantity)
  --,stockDepot int
  ,stockmini int -- (min)
  ,stockmaxi int -- (max)
  --,nb_stock int
  ,priorite int -- (priority)
)
as
declare variable prio integer;
declare variable prio_stock1 integer;
begin
 
--if (zonegeo is null) then
	insert into T_STOCK(
		stock--int
		,qteenstk--int
		,stkMin
		,stkMax
		,depot
		,produit--int
		,priorite	-- 1 => stock prioritaire, 2 => stock secondaire)
    ,zonegeo
		,depotvente
		) --Integer : 1 => stock vente , 0 => stock non vente 
	values(
		:stock
		,:stockTotal
		,:stockmini
		,:stockmaxi
		,:depot
		,:produit
		,:priorite
    ,:zonegeo
		,1
		);
/*else 
	begin
		if (nb_stock=2) then 
			if (:stockmini>0 or :stockmaxi>0) then 
				prio=1;
			else
				begin
					select priorite from T_STOCK where produit=:produit into :prio_stock1;
					if (prio_stock1=2) then
						prio=1;
					else 
						prio=2;
				end
		else 
			prio=1;
		
		insert into T_STOCK(
		   stock--int
		  ,qteenstk--int
		  ,stkMin
		  ,stkMax
		  ,depot
		  ,produit--int
		  ,priorite	-- 1 => stock prioritaire, 2 => stock secondaire) 
		  ,depotvente
		  ,zonegeo
		  ) -- Integer : 1 => stock vente , 0 => stock non vente 
		values(
		   :produit||'-'||:depot
		  ,:stockTotal
		  ,iif(:stockmini>0,:stockmini-1,0)
		  ,:stockmaxi
		  ,:depot
		  ,:produit
		  ,:prio
		  ,iif(:prio = 1,1,0)
		  ,:zonegeo
		  );
	end*/
end;

/**************************************   PROFILE REMISE ************************************************/
/*   Source : fidelity_profiles.csv */
create or alter procedure ps_creer_profilremise(
 PROFILREMISE int
--,TYPERISTOURNE varchar(1)
,LIBELLE varchar(30)
--,TAUXREGLEGEN float
 )
as

begin

  insert into T_PROFILREMISE(
     PROFILREMISE
    ,DEFAULTOFFICINE
    ,LIBELLE
	--,TYPERISTOURNE
	--,TAUXREGLEGEN
    )
   values(
     :PROFILREMISE
    ,0
    ,:LIBELLE
	--,iif(:TYPERISTOURNE='R',0,1)
	--,:TAUXREGLEGEN
   );

 end;



/********************************************************************************************************/
/***********************************      Suppliers      ************************************************/
/********************************************************************************************************/
/* Source : suppliers.csv 

  REMARQUES [ygodart] :
    -> Qu'est-ce que "PAUSE" ??

    Plutôt que créer 2 procédures distinctes, je filtre sur le code catégorie pour créer un fournisseur ou un répartiteur
*/

create or alter procedure ps_creer_suppliers(
   FOURNISSEUR int -- (id)
  ,NOMFOURN varchar(50) -- (name) 
  ,RUEFOURN varchar(80) -- (street) varchar40
  ,LOCFOURN varchar(30) -- (city)
  ,CPFOURN varchar(10) -- (postcode) varchar6
  ,CODEPAYS varchar(2)  
  ,tva varchar(15)
  ,iban varchar(50)
  ,TEL varchar(30) -- (phone_number) varchar20
  --,TEL2 varchar(30) -- varchar20
  ,FAX varchar(30) -- (fax) varchar20
  ,EMAIL varchar(50) -- (email)
  ,GSM varchar(30) -- (mobile_phone) varchar20
  ,TWITTER varchar(100) --a mettre en commentaire
  ,FACEBOOK varchar(100) --a mettre en commentaire
  ,SITEWEB varchar(200)   ----------------------------------- Il manque une colonne dans le fichier
   --,PAUSE varchar(1)
  ,CATEGORIE int -- (category 1 : repart ,2 : Fournisseur) 
  ,NUMAPB varchar(10) --code 
  ,contact_first_name varchar(100)
  ,contact_last_name varchar(100)
  ,contact_email varchar(100)
  ,contact_mobile_phone_number varchar(100)
  ,contact_fax varchar(100)
  ,commentaire varchar(100)
  )
as
declare variable nb_prod integer;
declare variable code varchar(50);
Begin

select count(*)
from T_TARIFPDT
where fou=:FOURNISSEUR
into :nb_prod;


if (:CATEGORIE = 2) then
    begin
      -- C'est un fournisseur
      --On cherche la coorespondance TR_four
    select max(fournisseur)
    from tr_fournisseur
    where numapb=trim(:NUMAPB)
    into :code;

    INSERT INTO T_FOURNISSEUR(
      FOURNISSEUR
      ,TR_FOURNISSEUR
      ,NOMFOURN
      ,RUEFOURN
      ,LOCFOURN
      ,CPFOURN
      ,TEL
      --,TEL2
      ,GSM
      ,FAX
      ,EMAIL
      --,PAUSE
      ,NUMAPB
      ,NBPDTSASSOCIES
    )
    VALUES (
      :FOURNISSEUR
      ,:code
      ,:NOMFOURN
      ,substring(:RUEFOURN from 1 for 40)
      ,:LOCFOURN
      ,substring(:CPFOURN from 1 for 6)
      ,substring(:TEL from 1 for 20)
      --,substring(:TEL2 from 1 for 20)
      ,substring(:GSM from 1 for 20)
      ,substring(:FAX from 1 for 20)
      ,:EMAIL
      --,:PAUSE
      ,substring(:NUMAPB from 1 for 4)
      ,:nb_prod
    );

    execute procedure CONVFOURNISSEUR;
end
else
begin
    -- C'est un répartiteur

    INSERT INTO T_REPARTITEUR(
    repartiteur
    ,nomRepart
    ,rueRepart
    ,locRepart
    ,cpRepart
    ,TEL
   -- ,TEL2
    ,GSM
    ,FAX
    ,EMAIL
    --,PAUSE
    ,nbPdtsAssocies
  )
  VALUES (
    :FOURNISSEUR
    ,:NOMFOURN
    ,substring(:RUEFOURN from 1 for 40)
    ,:LOCFOURN
    ,substring(:CPFOURN from 1 for 6)
    ,substring(:TEL from 1 for 20)
    --,substring(:TEL2 from 1 for 20)
    ,substring(:GSM from 1 for 20)
    ,substring(:FAX from 1 for 20)
    ,substring(:EMAIL from 1 for 50)
    --,:PAUSE
    ,:nb_prod
  );

  execute procedure CONVREPARTITEUR;

end



End;
--	nbTentatives dm_numpos3 DEFAULT NULL,
--	modeTransmission dm_char1 DEFAULT NULL,
--	fouPartenaire dm_char1 DEFAULT NULL,


/*
	repDefaut dm_char1 DEFAULT '0',
	objMensuel dm_ca DEFAULT 0,
	modeTransmission dm_char1 DEFAULT '5', --mode manuel
	monoGamme dm_char1 DEFAULT '0',
	nbPdtsAssocies dm_Int NOT NULL
*/

/********************************************************************************************************/
/**************************************   TARIF PRODUITS ************************************************/
/********************************************************************************************************/
/*create or alter procedure ps_creer_tarif_produit(
       tarifpdt varchar(50)
      ,produit int
      ,fou int
      ,isRepart int
      ,isAttitre int
)
as
begin
insert into T_TARIFPDT(
  tarifpdt
 ,produit
 ,fou
 ,prxAchat
 ,isRepart
 ,isAttitre
)
values(
  :tarifpdt
 ,:produit
 ,:fou
 ,0
 ,:isRepart
 ,:isAttitre
);
end;
*/
 /*
 remise dm_remise not null,
 prxAchtRemise dm_prixachat not null,
 gereofficentral dm_char1 default '0'
*/

/********************************************************************************************************/
/***********************************  CODES_BARRES ******************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_codesbarres(
   produit int
  ,codeb varchar(30)
  )
as
begin
 insert into t_codebarre(
   codebarre
  ,produit
  ,code
  ,ean13
  ,cbu
  )
 values(
   next value for seq_codebarre
  ,:produit
  ,:codeb
  ,iif(char_length(:codeb) = 13, 1,0)
  ,0
  );
end;

/********************************************************************************************************/
/**************************************   Medecins  ************************************************/
/********************************************************************************************************/

/*
  REMARQUE [ygodart]
    - pas de code spécialisation dans le fichier "test" de Pharmony
      => Si code spécialisation null ou vide, je mets "001"

  Source : prescribers.csv
*/
create or alter procedure ps_creer_medecins (
   MEDECIN int
  ,PRENOM varchar(50)
  ,NOM varchar(50)
  ,RUE1 varchar(70)
  ,VILLE varchar(40)
  ,CP varchar(10)
  ,CODEPAYS varchar(2)
  ,langue varchar(10) --inutilise
  ,TEL1 varchar(20) 
  ,FAX varchar(20) 
  ,EMAIL varchar(50)
  ,GSM varchar(20)
  ,TWITTER varchar(100) --a mettre en commentaire
  ,FACEBOOK varchar(100) --a mettre en commentaire
  ,SITEWEB varchar(200)
  ,COMMENTAIRE varchar(5000)
  ,typemed varchar(1)   --1:belgium contracted 2:veterinary 3:foreigner 4:non contracted
  ,MATRICULE varchar(8)
  ,CODESPEC varchar(3)
  --,TEL2 varchar(30)--20 (fax)
  --,COMMENTAIRES varchar(200)
  )

as
declare variable spec varchar(3);
begin

if (trim(:CODESPEC) = '' or :CODESPEC is null) then
  spec = '001';
else
  spec = trim(:CODESPEC);

insert into T_MEDECIN(
   MEDECIN
  ,NOM
  ,PRENOM
  ,MATRICULE
  ,CODESPEC
  ,IDENTIFIANT
  ,EMAIL
  ,FAX
  ,VILLE
  ,CP
  ,CODEPAYS
  ,TEL1
  ,GSM
  ,RUE1
  ,CATEGORIE
  ,SITE
  ,COMMENTAIRES
)
values(
  :MEDECIN
 ,:NOM
 ,:PRENOM
 ,:MATRICULE
 ,:spec
 ,:MATRICULE||:spec
 ,:EMAIL
 ,:FAX
 ,:VILLE
 ,:CP
 ,:CODEPAYS
 ,:TEL1
 ,:GSM
 ,:RUE1
 ,case
    when :typemed = '2' then 3
    when :typemed = '3' then 2
    when :typemed = '4' then 4
    else 1
     end 
 ,:SITEWEB
 ,substring(:COMMENTAIRE from 1 for 200)
 );
end;

/**************************************   HISTOVENTE   **************************************************/
/*   Source  : history_products.csv */
create or alter procedure ps_creer_histovente(
  aaaamm varchar(30)
 ,speSerie int
 ,qteVendue int
 ,prixvente float
 ,prixachat float
)
as
  declare variable annee varchar(4);
  declare variable mois varchar(2);
  declare variable jour varchar(2);
  declare variable periode varchar(20);
  declare variable cle varchar(30);
begin
 annee = substring(:aaaamm from 1 for 4);
 mois = substring(:aaaamm from 6 for 2);
 periode = :annee ||'/'|| :mois || '/01';
 cle = :periode || :speSerie;

 if (exists(select histovente from t_histovente where histovente = :cle)) then
 begin
    update t_histovente set
    qteVendue = qteVendue + iif(:qteVendue<0,0, :qteVendue),
    nbVentes = nbVentes +1
    where histovente = :cle; 
 end
 else 
 begin
   insert into t_histovente(
      histovente
      ,mois
      ,annee
      ,periode
      ,speSerie
      ,qteVendue
      ,nbVentes
      )
      values(
      :cle
      ,:mois
      ,:annee
      ,:periode
      ,:speSerie
      ,iif(:qteVendue<0,0, :qteVendue)
      ,1
      );
 end
end;

/********************************************************************************************************/
/************************************** HISTORIQUE PATIENT **********************************************/
/********************************************************************************************************/

create sequence seq_histodelentete;

create or alter procedure ps_creer_historique_patient(
  patient_id int,
  date_vente varchar(30),
  prescripteur_id int,
  prescripteur_nom varchar(50),
  produit_id int,
  preparation_id varchar(50),
  prix_publique float,
  prix_vente float,
  code_produit varchar(20),
  facture int,
  quantite int
)
as
  declare variable histodelGen int;
  declare variable designation_produit varchar(100);
  declare variable f integer;
Begin
  f = cast(facture as integer);
  if (f= 0) then f = null;

  select histodelgeneral from T_HISTODELGENERAL where facture=:f into :histodelGen;
  if (:histodelGen is null) then   
  begin
    insert into T_HISTODELGENERAL(histodelgeneral,
                                  clientID,
                                  facture,
                                  codeOperateur,
                                  date_acte,
                                  date_prescription,
                                  nom_medecin,
                                  theTypeFactur -- 2 => Ordonnance, 3 => Vte Directe
                                  )
    values(next value for seq_histodelentete,
        :patient_id,
        :f,
        '',
        substring(:date_vente from 1 for 10),
        substring(:date_vente from 1 for 10),
        :prescripteur_nom,
        iif(:f is null,3,2))
    returning histodelgeneral into :histodelGen;
  end
  
  if (:quantite>=0) then
  begin
    select designCNKFR_prod from T_PRODUIT where produit = cast(:produit_id as varchar(50)) into :designation_produit;
    
    insert into T_HISTODELDETAILS(histodeldetails,
                                  histodelgeneralID,
                                  cnkProduit,
                                  designation,
                                  qteFacturee,
                                  prixVte,
                                  produitID)
    values(next value for seq_historique_client_ligne,
          :histodelGen,
          substring(trim(:code_produit) from 1 for 7),
          :designation_produit,
          :quantite,
          :prix_vente,
          :produit_id);
  end  
end;



/********************************************************************************************************/
/**************************************   TRANSACTION RISTOURNES ****************************************/
/********************************************************************************************************/

create sequence seq_transaction_id;
create or alter procedure ps_creer_transactionrist(
 --numcarte varchar(13)
compteID int
 ,montantEnAttente float
 ,montantDisponible float
--,tauxTVA int
--,dateTicket date
)
as
begin
--On passe toutes les tva à 6, en effet la base greenock ne correspond pas forcement sur les ristourne et les liberation

--création d'un transaction poru les montants en cours, type 0
if (:montantEnAttente > 0 ) then 
  insert into T_TRANSACTIONRIST(
	 transactionrist
	--,numcarte
	,compteID
	,montantRist
	,typeTransact
	,tauxTVA
	,justificatif
	,dateTicket
  )
  values(
    next value for seq_transaction_id
   --,:numcarte
   ,:compteID
   ,:montantEnAttente
   ,'0'
   ,6
   ,'REPRISE DONNEES'
   ,current_timestamp
  );
  
--création d'un transaction poru les montants disponible type 2
if ( :montantDisponible > 0 ) then 
  insert into T_TRANSACTIONRIST(
	 transactionrist
	--,numcarte
	,compteID
	,montantRist
	,typeTransact
	,tauxTVA
	,justificatif
	,dateTicket
  )
  values(
    next value for seq_transaction_id
   --,:numcarte
   ,:compteID
   ,:montantDisponible
   ,'2'
   ,6
   ,'REPRISE DONNEES'
   ,current_timestamp
  );
    
end;


/********************************************************************************************************/
/**************************************   COMPTE RISTOURNE  *********************************************/
/********************************************************************************************************/
/*
REMARQUE [ygodart] :
  Dans Pharmony, le solde courant et le montant disponible se trouvent dans le compte.
  2018-06-05 10:00:58 +0200,1.00,fidelity_accounts,BE,PHARMONY ONE,1.0
  id,patient_id,pending_amount,available_amount
    => Créer une transaction (dans T_TRANSACTIONRIST) avec le solde

  Source : fidelity_accounts.csv

*/
create or alter procedure ps_creer_compterist(
  compte int
 ,cliID int
 ,montantEnAttente float
 ,montantDisponible float
 --,liberType varchar(1)
 --,liberVal varchar(6)
)
as
begin

insert into t_compte(
  compte
 ,cliID
 ,liberType
 ,liberVal
 ,etat
)
values(
  :compte
 ,:cliID
 ,'1'
 ,5
 ,1
);

/* Création d'une transaction ristourne pour les soldes.*/
execute PROCEDURE ps_creer_transactionrist( :compte, :montantEnAttente , :montantDisponible) ;
end;

/********************************************************************************************************/
/**************************************   CARTE RISTOURNE  **********************************************/
/********************************************************************************************************/
/*   Source : fidelity_cards.csv */
create or alter procedure ps_creer_carterist(
  id int
 ,carterist varchar(13)
 ,compteID int
 ,code_cli int
 --,dateEmis date
)
as
Begin


insert into T_CARTERIST(
	carterist
	,compteID
	,cliID
	--,dateEmis
	,numCarte
	,virtuel
	,etat
)
values(
	:id
	,:compteID
	,:code_cli
	--,:dateEmis
	,:carterist
	,0
	,1);
end;

/**************************************   DEPOT    ******************************************************/
/*   Source : storage_spaces.csv */
create or alter procedure ps_creer_depots(
  depot int -- (id)
 ,libelle varchar(30) -- (name)
 ,automate varchar(10) -- (robot)
 ,defaut varchar(10)
)
as
begin
 insert into T_DEPOT(
   depot
  ,libelle
  ,automate
 )
  values(
    :depot
   ,:libelle
   ,iif(:automate = 'true', 1, 0)
 );

end;

/**************************************   ZONEGEO   *****************************************************/
/*   Source : storage_locations.csv */
create or alter procedure ps_creer_zonegeo (
	 ZoneGeo_Cle int -- (id)
	,ZoneGeo_Nom varchar(30) -- (name)
	,depot int
)
as
begin
insert into t_zonegeo (
   zonegeo
  ,libelle
  )
values (
	:ZoneGeo_Cle
	,:ZoneGeo_Nom
  );
end;

/********************************************************************************************************/
/************************************** LITIGES / AVANCES ***********************************************/
/********************************************************************************************************/
/*
    REMARQUES [ygodart] :
      - Work in progress !!  code à affiner et contrôle d'erreur à mettre en place.
*/
create sequence seq_litige_id;
create or alter procedure ps_creer_litiges(
  patient_id int,
  categorie int, -- 1 : avance 2: délivrance différée 3:renouvellement
  produit int, 
  preparation varchar(50),
  prescripteur int,
  renouvellement_total int,
  renouvellement_fait int,
  renouvellement_periode int,
  renouvellement_periode_unit int, --1:day 2:week 3:weeks couple 4:month
  numero_de_prescription int,
  date_de_prescription varchar(30),
  quantite_dd int,  -- quantite del dif uniquement , 1 pour les avances
  type_avance int, -- 1 : prix publique 2 : prix mutuelle
  prix_paye float,
  nom_client varchar(50),
  nom varchar(80) -- nom du produit ou de la préparation
)
as
declare variable comm varchar(500);
begin
			
if (:categorie = 1) then
      -- avance
	  -- Si un jour il y a les CBU il faudrait créér une seul avance avec toutes les lignes
	if (preparation is null) then --produit donc avance produit
		insert into t_litige(
            litige
            ,client
            ,typeLitige  -- 1 => Manque ordonnance 
--            ,descriptionLitige
            ,nomPdt
            ,produit
            ,noOrd
            ,prixClient  -- Montant que le client paye (tva comprise) sans le montant payé par le tiers payant
            ,qtedelivree
            ,dateVente
            --,isFacture
            --,cdbu
        )
        values(
            next value for seq_litige_id
            ,:patient_id
            ,1
--            ,''
            ,substring(:nom from 1 for 50)
            ,:produit
            ,:numero_de_prescription
            ,:prix_paye
            ,1
            ,substring(:date_de_prescription from 1 for 10)
            --,:isFacture
            --,:cdbu
        );
	else 
		begin
			comm = 'Avance Prd Mag: ';
			if (:nom is not null) then comm = comm||' Pdt:'||trim(:nom)||' Qte:1 ';
			--if (qte<>0 and qte is not null) then comm = comm||' Qte:'||:qte;
			if (date_de_prescription is not null) then  comm = comm||'Date:'||substring(:date_de_prescription from 1 for 10);
			update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500), substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:patient_id;
			update t_client set COMMENTAIREBLOQU=1 where client=:patient_id;
		end

if (:categorie = 2) then
 	if (preparation is null) then --produit donc deldif
     -- délivrance différée
      insert into t_deldif(
        deldif
        ,produit
        ,client
        ,medecin
        ,noOrdon
        ,dateprescr
        ,dateDeliv
        ,qttDiff
        ,dateOrdon
        )
        values(
        next value for seq_deldif_id
        ,:produit
        ,:patient_id
        ,:prescripteur
        ,:numero_de_prescription
        ,substring(:date_de_prescription from 1 for 10)
        ,substring(:date_de_prescription from 1 for 10)
        ,:quantite_dd
        ,substring(:date_de_prescription from 1 for 10)
        );
	else
		begin
			comm = 'Del Dif Mag : ';
			if (nom is not null) then comm = comm||' Pdt:'||trim(:nom);
			if (quantite_dd is not null) then comm = comm||' Qte:'||:quantite_dd;
			if (date_de_prescription is not null) then  comm = comm||'Date:'||substring(:date_de_prescription from 1 for 10);
			update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500), substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:patient_id;
			update t_client set COMMENTAIREBLOQU=1 where client=:patient_id;
		end
		
if (:categorie = 3) then
    begin
		comm = 'Renouvellements ';
		if (nom is not null) then comm = comm||' Pdt: '||trim(:nom);
		if (date_de_prescription is not null) then  comm = comm||'Date: '||substring(:date_de_prescription from 1 for 10);
		if (renouvellement_total is not null) then  comm = comm||'Nb de Renouv.: '||:renouvellement_total;
		if (renouvellement_fait is not null) then  comm = comm||'dont : '||:renouvellement_fait||' déjà faits, ';
		if (renouvellement_periode is not null) then  comm = comm||'tous les : '||:renouvellement_periode;
		if (renouvellement_periode_unit is not null) then  comm = case 
			when renouvellement_periode_unit = 1 then comm||' jours'
			when renouvellement_periode_unit = 2 then comm||' semaines'
			when renouvellement_periode_unit = 3 then comm||' 2 semaines'
			when renouvellement_periode_unit = 4 then comm||' mois'
			else comm
			end;
		update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500),
			substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:patient_id;
		update t_client set COMMENTAIREBLOQU=1 where client=:patient_id;
    end
end;

create or alter procedure ps_creer_schema_produit(
	t_sch_medication_produit_id dm_code,
	t_produit_id int,
	t_aad_id int,
	date_debut varchar(20),
	date_fin varchar(20),
	commentaire varchar(200)
) as --declare variable comm varchar(500);
 declare variable libelle VARCHAR(100);
begin

select DESIGNCNKNL_PROD from t_produit
where  produit = :t_produit_id
into :libelle;

insert into
	t_sch_medication_produit(
		t_sch_medication_produit_id,
		t_produit_id,
		t_aad_id,
		date_debut,
		date_fin,
		commentaire,
		libelle,
		typemedication
	)
values
(
		:t_sch_medication_produit_id,
		:t_produit_id,
		:t_aad_id,
		:date_debut,
		:date_fin,
		substring(:commentaire from 1 for 200),
		substring(:libelle from 1 for 50),
		1
	);

update t_client set SCH_POSOLOGIE = 1 where client = :t_aad_id;

end;


CREATE PROCEDURE PS_CREER_SCHEMA_PRISE
 (
  SCHEMA_ID dm_code, 
  TYPESCHEMA Integer, 
	FREQUENCE Integer,
	TYPE_FREQUENCE Integer,
  FREQUENCE_JOURS varchar(7),
  PRISEAULEVER float, 
  SPPDNBAV float, 
  SPPDNBPENDANT float, 
  SPPDNBAPRES float, 
  PRISE10H00 float, 
  SPDNNBAV float, 
  SPDNNBPENDANT float, 
  SPDNNBAPRES float, 
  PRISE16H00 float, 
  SPSPNBAV float, 
  SPSPNBPENDANT float, 
  SPSPNBAPRES float, 
  PRISE20H float, 
  PRISEAUCOUCHER float)
AS
declare variable TYPE_MOMENT_PD int;
declare variable TYPE_MOMENT_DN int;
declare variable TYPE_MOMENT_SP int;
declare variable PrisePD float;
declare variable PriseDN float;
declare variable PriseSP float;
declare variable PriseDJ float;
begin 


TYPE_MOMENT_PD = 1;
if (:SPPDnbAV > 0) then TYPE_MOMENT_PD = 2; 
if (:SPPDnbPendant > 0) then TYPE_MOMENT_PD = 3;
if (:SPPDnbApres > 0) then TYPE_MOMENT_PD = 4;

PrisePD = (:SPPDnbAv + :SPPDnbPendant + :SPPDnbApres);

TYPE_MOMENT_DN = 1;
if (:SPDNnbAV > 0) then TYPE_MOMENT_DN = 2;
if (:SPDNnbPendant > 0) then TYPE_MOMENT_DN = 3;
if (:SPDNnbApres > 0) then TYPE_MOMENT_DN = 4;

PriseDN = (:SPDNnbAv + :SPDNnbPendant + :SPDNnbApres);
TYPE_MOMENT_SP = 1;
if (:SPSPnbAv > 0) then TYPE_MOMENT_SP = 2;
if (:SPSPnbPendant > 0) then TYPE_MOMENT_SP = 3;
if (:SPSPnbApres > 0) then TYPE_MOMENT_SP = 4;

PriseSP = (:SPSPnbAv + :SPSPnbPendant + :SPSPnbApres);
PriseDJ = :PriseAuLever;

if (PRISEAULEVER < 0) then begin
  PriseDJ = 0;
end

update t_sch_medication_produit 
set typemedication = :typeschema
where t_sch_medication_produit_id = :schema_id;

insert into t_sch_medication_prise(
    T_SCH_MEDICATION_PRISE_ID,
    T_SCH_MEDICATION_PRODUIT_ID,
    TYPE_FREQUENCE,
    FREQUENCE_JOURS,
    PRISE_LEVER,
    PRISE_PTDEJ,
    TYPE_MOMENT_PTDEJ,
    PRISE_MIDI,
    TYPE_MOMENT_MIDI,
    PRISE_SOUPER,
    TYPE_MOMENT_SOUPER,
    PRISE_COUCHER,
    PRISE_10HEURES,
    PRISE_16HEURES,
    PRISE_HEURE1,
    LIBELLE_HEURE1,
    Nb_jours
  )
values
  (
    :SCHEMA_ID,
    :SCHEMA_ID,
    :TYPE_FREQUENCE, 
    :FREQUENCE_JOURS,
    :PriseAuLever,
    :PrisePD,
    :TYPE_MOMENT_PD,
    :PriseDN,
    :TYPE_MOMENT_DN,
    :PriseSP,
    :TYPE_MOMENT_SP,
    :PriseAuCoucher,
    :Prise10h00,
    :Prise16h00,
    :Prise20H,
    '2000',
    :FREQUENCE
  );
End;

create or alter procedure ps_creer_ficheanalyse(
  no_analyse dm_code,
  cnk_produit int,
  no_autorisation varchar(20),
  ReferenceAnalytique varchar(20),
  date_entree date,
  fabricant_id dm_code,
  grossiste_id dm_code,
  no_lot varchar(20),
  prix_achat_total float,
  no_bon_livraison varchar(20),
  date_ouverture VARCHAR(20),
  date_peremption varchar(20),
  date_fermeture varchar(20),
  quantite_initial float,
  quantite_restante dm_float7_2,
  unites dm_varchar5,
  remarques varchar(5000)
)
as
  DECLARE VARIABLE date_ferme varchar(20);
  DECLARE VARIABLE date_ouvre varchar(20);
begin
  date_ferme = null; 
  if(trim(:date_fermeture) <> '') then date_ferme = :date_fermeture;
  date_ouvre = null;
  if (trim(:date_ouverture) <> '') then date_ouvre = :date_ouverture;

insert into T_FICHEANALYSE(
   fiche_analyse_id
  ,no_analyse
  ,cnk_produit
  ,no_autorisation
  ,ReferenceAnalytique
  ,date_entree
  ,fabricant_id
  ,grossiste_id
  ,no_lot
  ,prix_achat
  ,no_bon_livraison
  ,date_ouverture
  ,date_peremption
  ,date_fermeture
  ,etat
  ,quantite_initial
  ,quantite_restante
  ,unite_qte
  ,remarques
  ,cnk_lie
  ,datemaj
)
values(
   :no_analyse
  ,:no_analyse
  ,:cnk_produit
  ,:no_autorisation
  ,:ReferenceAnalytique
  ,coalesce(:date_entree, coalesce(:date_ouvre,current_date))
  ,:fabricant_id
  ,:grossiste_id
  ,:no_lot
  ,iif(:quantite_initial=0,:prix_achat_total,:prix_achat_total/:quantite_initial)
  ,:no_bon_livraison
  ,:date_ouvre
  ,:date_peremption
  ,:date_ferme
  ,iif(:date_ferme is not null or :quantite_initial=0,2,iif(:date_ouvre is not null,1,0))
  ,:quantite_initial
  ,:quantite_restante
  ,:unites
  ,substring(:remarques from 1 for 500)
  ,:cnk_produit
  ,current_date
);
end;


/********************************************************************************************************/
/**************************************   Credit Client  ************************************************/
/********************************************************************************************************/
/*create or alter procedure ps_creer_creditclient(
	 credit int
	,montant float
	,datecredit date
	,client int
)
as
declare variable comm varchar(500);
begin

insert into t_CREDIT(
 credit
,montant
,datecredit
,client
)
values(
 :credit
,:montant
,:datecredit
,:client
);
End;
*/