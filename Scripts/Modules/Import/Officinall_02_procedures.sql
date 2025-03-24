set sql dialect 3;

/********************************************************************************************************/
/**************************************   Medecins  *****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_medecins (
   primkey integer
  ,ident varchar(20)
  ,nom varchar(100)
  ,rue varchar(60)
  ,titre varchar(50)--commentaire 200
  ,tel varchar(50)
  ,codep varchar(10)
  ,ville varchar(150)
  ,frontalier varchar(1)
  ,veterinaire varchar(1)
  )

as
declare variable StrNom varchar(100);
declare variable StrPrenom varchar(100);
declare variable StrNjf varchar(100);
begin

execute procedure ps_separer_nom_prenom(:NOM, ' ') returning_values :StrNom, :StrPrenom, :strNjf;

insert into T_MEDECIN(
	 MEDECIN
	,NOM
	,PRENOM
 ,COMMENTAIRES
	,IDENTIFIANT
	,MATRICULE
	,CODESPEC
	,VILLE
	,CP
	,TEL1
	,RUE1
	,CATEGORIE
	--ISDENTISTE dm_boolean NOT NULL
	,ISMEDFRONT
)
values(
  :primkey
 ,substring(:StrNom from 1 for 50)
 ,substring(:StrPrenom from 1 for 50)
 ,:titre
 ,:ident
 ,substring(:ident from 1 for 8)
 ,substring(:ident from 9 for 3)
 ,substring(:ville from 1 for 40)
 ,:codep
 ,substring(:tel from 1 for 20)
 ,:rue
 ,iif(:frontalier ='1', '2', iif(:veterinaire ='1', '3', '1'))
 ,iif(:frontalier ='1', 1, 0)
);
end;

/********************************************************************************************************/
/**************************************   ZONEGEO   *****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_zonegeo (
	 ZoneGeo_Cle int
	,ZoneGeo_Nom varchar(100)
)
as
begin
insert into t_zonegeo (
   zonegeo
  ,libelle
  )
values (
		 :ZoneGeo_Cle
		,substring(:ZoneGeo_Nom from 1 for 50)
  );
end;

/********************************************************************************************************/
/**************************************   PRODUIT   *****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_produits (
	 PRD_PRIMKEY int--varchar50
	,codeCNK_prod varchar(10)--varchar7
	,prixvente float--money en sql
	,stockmini integer--int
	,stockmaxi integer--int
	,stock_prd integer--int
	,stock_robot integer
	,nom_nl varchar(60)--varchar60
	,nom_fr varchar(60)--varchar60
	,prixachat float--float en sql
	,zonegeo_cle integer--varchar50
	,date_peremtion date
  ,date_peremtion2 date
  /*baseremboursement float,
  avec_cbu char(1),
  gereinteressement char(1),
  commentairevente varchar(200),
  geresuiviclient char(1),
  tracabilite char(1),
  profilgs char(1),
  calculgs char(1),
  veterinaire char(1),
  video char(1),
  designationlibrepossible char(1),
  frigo char(1),
  peremption_courte char(1),
  categ_prod varchar(5),
  statuscomm_prod varchar(5),
  usage_prod varchar(5),
  remise_interdite char(1),
  ristourne_interdite char(1),
  tva numeric(5,2),
  labo varchar(4),
  concess varchar(4),
  dateDernDeliv datetime,
  datePeremption datetime,
  zoneLibre varchar(50),
  tauxRemise numeric(5,2),
  tauxRist numeric(5,2),
  ventilation varchar(50),
  creationLgCmd char(1),  -- utilisé pour sabco old, offigest et farmix
  classifInt varchar(50) */
)
as
declare variable isPdtPropre char(1);
declare variable nomNL varchar(50);
declare variable nomFR varchar(50);
declare variable mini integer;
declare variable maxi integer;
begin
	if (codeCNK_prod > '9900000') then   -- Rien d'autres de trouvé pour avoir le flag produit propre
		isPdtPropre = '1';
	else
		isPdtPropre = '0';

	if ((stockmini=1) and (stockmaxi=1)) then
	begin
		mini = 0;
		maxi = 1;
	end
	else
	begin
		mini = stockmini;
		maxi = stockmaxi;
	end

	nomNL = replace( nom_nl,'/',' ');
	nomFR = replace( nom_fr,'/',' ');
	if (trim(nom_nl)='') then
		nomNL = nom_fr;
	else if (trim(nom_fr)='') then
		nomFR = nom_nl;
				
	--si pas de nomFR alors pas de nomNL non plus on passe
	if (trim(nomFR)<>'') then
	begin
		insert into t_produit (
			Produit
			,codeCNK_prod
			,prixvente
			,stockmini
			,stockmaxi
			,designCNKNL_prod
			,designCNKFR_prod
			,prixachatcatalogue
			,isPdtPropre
			,datePeremption
		) values (
			:PRD_PRIMKEY
			,substring(:codeCNK_prod from 1 for 7)
			,:prixvente
			,:mini
			,:maxi
			,:nomNL
			,:nomFR
			,:prixachat
			,:isPdtPropre
			,coalesce(:date_peremtion2, :date_peremtion)
		);

		-- Stocks
		if (stock_prd>0) then
		begin
			/*if (not exists(select * from t_depot where libelle = '<GREEN>')) then
			  insert into t_depot values(1, '<GREEN>', '0');*/
			  
			insert into t_stock(
				stock--int
				,qteEnStk--int
				--,stkMin
				--,stkMax
				,depot
				,zoneGeo
				,produit--int
				,priorite	/* 1 => stock prioritaire, 2 => stock secondaire) */
				,depotvente ) /* Integer : 1 => stock vente , 0 => stock non vente */
			values(
				:PRD_PRIMKEY
				,:stock_prd
				--,:mini
				--,:maxi
				,1
				,:zonegeo_cle
				,:PRD_PRIMKEY
				,1
				,1);
		end
				
		if (stock_robot>0) then
		begin
		/*	if (not exists(select * from t_depot where libelle = 'ROBOT')) then
			  insert into t_depot values(2, 'ROBOT', '1');*/
			  
			insert into t_stock(
				stock--int
				,qteEnStk--int
				--,stkMin
				--,stkMax
				,depot
				,produit--int
				,priorite	/* 1 => stock prioritaire, 2 => stock secondaire) */
				,depotvente ) /* Integer : 1 => stock vente , 0 => stock non vente */
			values(
				:PRD_PRIMKEY
				,:stock_robot
				--,:mini
				--,:maxi
				,3		
				,:PRD_PRIMKEY
				,2
				,0);	
		end
	end
end;

/********************************************************************************************************/
/***********************************      Repartiteurs   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_repartiteurs(
   repartiteur int --varchar50
  ,nomRepart varchar(150)--varchar50
  ,rueRepart varchar(150) --varchar40
  ,locRepart varchar(100) --varchar40
  ,cpRepart varchar(10) --varchar6
  ,TEL varchar(50) --varchar20
  ,FAX varchar(50)--varchar20
  ,EMAIL varchar(150)--varchar50
)
as
declare variable nb_prod integer;

Begin

select count(*)
from T_TARIFPDT
where fou=:repartiteur
into :nb_prod;

INSERT INTO T_REPARTITEUR(
   repartiteur
  ,nomRepart
  ,rueRepart
  ,locRepart
  ,cpRepart
  ,TEL
  ,FAX
  ,EMAIL
  ,nbPdtsAssocies
)
VALUES (
   :repartiteur
  ,substring(:nomRepart from 1 for 50)
  ,substring(:rueRepart from 1 for 40)
  ,substring(:locRepart from 1 for 40)
  ,substring(:cpRepart from 1 for 6)
  ,substring(:TEL from 1 for 20)
  ,substring(:FAX from 1 for 20)
  ,substring(:EMAIL from 1 for 50)
  ,:nb_prod
);
End;

/********************************************************************************************************/
/***********************************      Fournisseur    ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_fournisseurs(
  FOURNISSEUR int ,  --varchar50
  NOMFOURN varchar(150) ,--varchar50
  RUEFOURN varchar(150)  ,--varchar40
  LOCFOURN varchar(100)  ,--varchar40
  CPFOURN varchar(10)  ,--varchar6
  TEL varchar(50)  ,--varchar20
  FAX varchar(50)  ,--varchar20
  EMAIL varchar(150)--varchar50
  )
as
declare variable nb_prod integer;
declare variable code varchar(50);
Begin

select count(*)
from T_TARIFPDT
where fou=:FOURNISSEUR
into :nb_prod;

--Pas de num APB dans Officinall alors on recherche par nom + rue
select max(fournisseur)
from tr_fournisseur
where nomfourn=:NOMFOURN
and (ruefourn=:ruefourn or
cpfourn=:cpfourn)
into:code;

INSERT INTO T_FOURNISSEUR(
  FOURNISSEUR,
  TR_FOURNISSEUR,
  NOMFOURN,
  RUEFOURN,
  LOCFOURN,
  CPFOURN,
  TEL,
  FAX,
  EMAIL,
  NBPDTSASSOCIES
)
VALUES (
  :FOURNISSEUR,
  :code,
  substring(:NOMFOURN from 1 for 50),
  substring(:RUEFOURN from 1 for 40),
  substring(:LOCFOURN from 1 for 40),
  substring(:CPFOURN from 1 for 6),
  substring(:TEL from 1 for 20),
  substring(:FAX from 1 for 20),
  substring(:EMAIL from 1 for 50),
  :nb_prod
);
End;

/********************************************************************************************************/
/***********************************  CODES_BARRES ******************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_codesbarres(
  primkey int,
  produit int,
  codeb varchar(13)
  )
as
begin
  if ((codeb is not null) and (char_length(trim(codeb)) = 13)) then
    insert into t_codebarre(
      codebarre ,
      produit,
      code,
      ean13 ,
      cbu)
    values(:primkey,
           :produit,
           :codeb,
           1,
           0);
end;

/********************************************************************************************************/
/**************************************   TARIF PRODUITS ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_tarif_produit(
       plv_PrimKey integer
      ,plv_prd_primkey integer
      ,plv_lev_primkey integer
      ,plv_AankoopprijsVerpakking float
)
as
declare variable is_repar integer;

begin

if ((plv_lev_primkey>0) AND (plv_lev_primkey<1000)) then
 is_repar=1;
 else
 is_repar=0;

insert into T_TARIFPDT(
  tarifpdt
 ,produit
 ,fou
 ,prxAchat
 ,isRepart
 ,isAttitre
)
values(
  :plv_PrimKey
 ,:plv_prd_primkey
 ,:plv_lev_primkey
 ,:plv_AankoopprijsVerpakking
 ,:is_repar
 ,1
);
end;



/********************************************************************************************************/
/***********************************  Client / Patient   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_patients(
  COLLECTIVITE             char(1)--A 1 si client et non patient
  ,cle_CLIENT               int    --varchar(50) ,
  ,NOM                      varchar(100) --varchar(30)   -- 50 sur patient , 100 sur klant
  ,PRENOM1                  varchar(50) --varchar(20)
  ,SEXE                     char(1)--var 5
  ,LANGUE                   char(1)--varchar(5) ,
  ,DATENAISSANCE            date
  ,RUE1                     varchar(60)
  ,TEL1                     varchar(20)
  ,GSM                      varchar(20)
  ,CP                       varchar(10)
  ,LOCALITE                 varchar(100)--150
  ,EDITION704			    char(1)
  ,EDITIONBVAC				char(1)
  ,NISS                     varchar(15)  -- numéro d'identification à la sécurité social
  ,MATOA                    varchar(15)
  ,OA                       varchar(3)
  ,CT1                      numeric(3)
  ,CT2                      numeric(3)
  ,DATEDEBOA                date        -- date début validité de l'assurabilité
  ,DATEFINOA                date       -- date fin validité de l'assurabilité
  ,MATOC                    varchar(15)
  ,OC                       varchar(3)
  ,CATOC					int
  ,DERNIERE_LECTURE         date       -- derniere lecture carte sis (ou document d'assurabilite) = doc justif
  ,DATEDEBUTVALIDITEPIECE   date      -- date deb validite de la carte (ou du doc)
  ,DATEFINVALIDITEPIECE     date     -- date fin validite de la carte (ou du doc)
  ,NUMEROCARTESIS           numeric(10)  -- numéro carte SIS
  ,VERSIONASSURABILITE      integer -- On passe directement en integer puisque le test isnumeric est déjà fait
  ,CERTIFICAT               varchar(40)
  ,NUMGROUPE                int
  ,IDPROFILREMISE           int
  ,COMMENTAIREINDIV 		varchar(255)
  ,NUMCHAMBRE               varchar(20)
  ,ETAGE					varchar(20)    ----vérifier la taille
  ,VISIBLE					int 
  /* ,
  CATOA                    varchar(6) ,
  CATOC                    varchar(6) ,
  OAT                      varchar(5) ,
  MATAT                    varchar(13) ,
  CATAT                    varchar(6) ,
  NUM_TVA                  varchar(11) ,  -- numéro tva pour les groupes
  COMMENTAIREBLOQU         char(1) ,
  PAYEUR                   char(1) ,
  DATEDERNIEREVISITE       datetime ,
  IDFamille                varchar(50) ,
  CPAS					   varchar(50) ,
  EDITIONBVAC			   char(1),
  EDITIONCBL			   char(1),
  TYPEPROFILFACTURATION    char(1),
  COPIESCANEVASFACTURE 	   varchar(3) ,
  */
  
  /* aide au rajout de la requete sql server
      ,pat_DrukVerzekeringsAttest  --serait edition attestation d'asssurabilité
      ,pat_Korting
      ,pat_Art_primkey
      ,pvz_AktiefNr
      ,pvz_AktiefNr2
      ,pvz_VersieVerzekerbaarheid
      ,pvz_3eBetaler
      ,pvz_TypeCertificaat
      ,pvz_SocialeFranchise1
      ,pvz_SocialeFranchise2
      ,pvz_IsAttest
      ,pvz_TochTBTAflev
      ,pat_OverlDatum
      ,pat_Verdiep
      ,pat_fpz_primkey
	  ,pat_Kamer //chambre*/
  
)
as
declare variable cli varchar(50);
declare variable StrNom varchar(100);
declare variable StrPrenom varchar(100);
declare variable StrNjf varchar(100);
begin

StrNom = NOM;
StrPrenom = PRENOM1;
if ((StrPrenom is null OR trim(StrPrenom) ='' ) AND :COLLECTIVITE='0') then
	execute procedure ps_separer_nom_prenom(StrNom, ' ') returning_values :StrNom, :StrPrenom, :strNjf;

if (COLLECTIVITE='1') then
	cli='999'||cle_CLIENT;
else
	cli=cle_CLIENT;
	
insert into T_CLIENT(
  CLIENT
  ,NOM
  ,PRENOM1
  ,SEXE
  ,LANGUE
  ,DATENAISSANCE
  ,RUE1
  ,TEL1
  ,GSM
  ,CP
  ,LOCALITE
  ,EDITION704
  ,EDITIONBVAC
  ,NISS
  ,MATOA
  ,OA
  ,CT1
  ,CT2
  ,DATEDEBOA
  ,DATEFINOA
  ,MATOC
  ,OC
  ,CATOC
  ,DERNIERE_LECTURE
  ,DATEDEBUTVALIDITEPIECE
  ,DATEFINVALIDITEPIECE
  ,NUMEROCARTESIS
  ,VERSIONASSURABILITE
  ,CERTIFICAT
  ,NATPIECEJUSTIFDROIT
  ,COLLECTIVITE
  ,NUMGROUPE
  ,IDPROFILREMISE
  ,COMMENTAIREINDIV
  ,NUMCHAMBRE
  ,ETAGE
  ,ETAT
)
values(
  :cli
  ,substring(:StrNom from 1 for 30)
  ,substring(:StrPrenom from 1 for 20)
  ,case
    when :sexe = 'F' then '2'
    when :sexe = 'V' then '2'
    when :sexe = 'M' then '1'
    else '0'
  end
  ,case
    when :langue = 'N' then '1'
    when :langue = 'D' then '2'
    when :langue = 'E' then '3'
    else '0'
  end
  ,:DATENAISSANCE
  ,:RUE1
  ,:TEL1
  ,:GSM
  ,substring(trim(:CP) from 1 for 6)
  ,:LOCALITE
  ,:EDITION704
  ,:EDITIONBVAC
  ,substring(:NISS from 1 for 11)
  ,substring(:MATOA from 1 for 13)
  ,:OA
  ,:CT1
  ,:CT2
  ,:DATEDEBOA
  ,:DATEFINOA
  ,substring(:MATOC from 1 for 13)
  ,:OC
  ,case 
	when :CATOC = 51 then 93
	when :CATOC = 41 then 91
	else null
   end
  ,:DERNIERE_LECTURE
  ,:DATEDEBUTVALIDITEPIECE
  ,:DATEFINVALIDITEPIECE
  ,substring(:NUMEROCARTESIS from 1 for 10)
  ,:VERSIONASSURABILITE
  ,substring(:CERTIFICAT from 1 for 32)
  ,1
  ,:COLLECTIVITE
  ,iif(:NUMGROUPE=0, null, '999'||:NUMGROUPE)
  ,:IDPROFILREMISE
  ,:COMMENTAIREINDIV
  ,substring(trim(:NUMCHAMBRE) from 1 for 6)
  ,substring(trim(:ETAGE) from 1 for 6)
  ,iif(:VISIBLE =0, 2, 0)
);
End;

/********************************************************************************************************/
/**************************************   AVANCE PRODUIT ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_avance_produit(
	 litige int
	,client int
	,typeLitige char(1) /* 1 => Manque ordonnance */
	,descriptionLitige varchar(50)
	,nomPdt varchar(100)
	,produit varchar(50)
	,cdbu varchar(50)
	,noOrd varchar(50)--int
	,prixClient float /* Montant que le client paye (tva comprise) sans le montant payé par le tiers payant*/
	,autrePrix float
	,qtedelivree int
	,qtemanquante int
	,dateVente date
	,isFacture char(1)
)
as
begin
insert into t_litige(
	 litige
	,client
	,typeLitige  /* 1 => Manque ordonnance */
	,descriptionLitige
	,nomPdt
	,produit
	,cdbu
	,noOrd
	,prixClient  /* Montant que le client paye (tva comprise) sans le montant payé par le tiers payant*/
	,qtedelivree
	,qtemanquante
	,dateVente
	,isFacture
)
values(
	 :litige
	,:client
	,:typeLitige/* 1 => Manque ordonnance */
	,:descriptionLitige
	,substring(:nomPdt from 1 for 50)
	,:produit
	,substring(:cdbu from 1 for 50)
	,:noOrd
	,iif(:prixClient <>0, :prixClient , :autrePrix )
	,:qtedelivree
	,:qtemanquante
	,:dateVente
	,:isFacture
);
end;

/********************************************************************************************************/
/**************************************   DELDIF    *****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_deldif(
	 deldif int
	,produit int
	,client int
	,medecin int
	,noOrdon int
	,dateprescr date
	,dateDeliv date
	,qttDiff int
	,dateOrdon date
)
as
begin
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
 :deldif
,:produit
,:client
,:medecin
,:noOrdon
,:dateprescr
,:dateDeliv
,:qttDiff
,:dateOrdon
);
end;

/********************************************************************************************************/
/**************************************   Credit Client  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_creditclient(
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

--Mise à jour du commentaire client, inutile de passer commbloquant a 1, le transfert s'en charge
comm = '(Crédit du '||:datecredit||' Somme:'||:montant||'€)';
update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500),
     substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:client;

end;


/********************************************************************************************************/
/**************************************   COMPTE RISTOURNE  *********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_compterist(
  compte varchar(50)
 ,cliID int
 ,liberType int
 ,liberVal varchar(5000)
 ,etat int
)
as
begin
-- Requete d'import : Liste des client avec un compte puis union 
--On ajoute les clients qui ont montant de libéré mais sans compte apparent

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
 ,:liberType
 ,iif(:liberVal = '', 0, :liberVal)
 ,:etat
);
end;

/********************************************************************************************************/
/**************************************   CARTE RISTOURNE  **********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_carterist(
  carterist int
 ,compteid int
 ,code_cli int
 ,dateEmis date
	,numCarte varchar(50)
)
as
Begin
insert into T_CARTERIST(
  carterist
 ,compteid
 ,cliID
 ,dateEmis
	,numCarte
	,virtuel
	,etat
)
values(
  :carterist
 ,:compteid
 ,:code_cli
 ,:dateEmis
	,substring(:numCarte from 1 for 13)
	,0
	,1);
end;


/********************************************************************************************************/
/**************************************   TRANSACTION RISTOURNES ****************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_transactionrist(
 primkey int
,rek_primkey varchar(50)
,mem_compte varchar(50)
,montant0 float
,montant6 float
,montant12 float
,montant21 float
,totalTicket float
,dateticket DATE
,typetransaction char(1) -- 2 viens d'un memo credit client, 0 viens d'un compte : credit ristourne
)

as
declare variable i integer;
declare variable mont float;
begin

i=1;
while (i <= 4) do
begin
 if (i=1) then
  mont=:montant0;
 else if (i=2) then
  mont=:montant6;
 else if (i=3) then
  mont=:montant12;
 else
  mont=:montant21;

 if (mont <>0) then
  insert into T_TRANSACTIONRIST(
	  transactionrist
	 ,numcarte
  ,compteID
  ,montantRist
  ,typeTransact
  ,tauxTVA
	 ,totalTicket
	 ,justificatif
	 ,dateTicket
  )
  values(
   iif(:typetransaction='0',:i||'A'||:primkey,:i||'B'||:primkey)
   ,''
   ,iif(:rek_primkey='0',:mem_compte,:rek_primkey)
   ,:mont
   ,:typetransaction
   ,case
    when :i = 1 then 6
    when :i = 2 then 6
    when :i = 3 then 12
    else 21
   end
   ,:totalTicket
   ,'REPRISE DONNEES'
   ,:dateticket
  );
 i = i + 1;
end
end;

/********************************************************************************************************/
/**************************************   Memo Patient  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_memopatient(
memo int,
mem_type int,
patient int,
nom_prd varchar(100),
numero_attest varchar(20),
date_echeance date,
cat_attest varchar(2),
qte int
)

as
declare variable comm varchar(500);
begin

comm = case
        --when :mem_type = 7 then 'Renouvellement '
        when :mem_type = 9 then 'Bon pour '
        when :mem_type = 8 then 'Alerte '
        --when :mem_type = 11 then 'Pas en ordre Tarif. '
        -- 12 delivré NR
        else ''
       end;

comm = comm||'Pdt:'||:nom_prd||' Qte:'||:qte||' Ord:'||:numero_attest||' Date:'||:date_echeance;


update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500),
     substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:patient;

end;


/********************************************************************************************************/
/**************************************   Attestations  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_attestation(
	 attestation int
	,speID int
	,cliID int
	,numAtt varchar(20)
	,dateLimite date
	,catRemb varchar(2)
	,condRemb varchar(2)
 ,commentaire varchar(250)
 ,mem_type int
)
as
declare variable comm varchar(500);
declare t_cat int;
begin

t_cat = case
		when :catRemb = 'A' then 1
		when :catRemb  = 'B' then 2
		when :catRemb  = 'C' then 3
		when :catRemb  = 'S' then 4
		when :catRemb  = 'X' then 5
		when :catRemb  = 'D' then 6
		when :catRemb  = 'G' then 7
		when :catRemb  = 'W' then 8
		when :catRemb  = 'J' then 9
		else 0
	   end;

if (t_cat<>0) then
	insert into T_ATTESTATION(
		 attestation
		,speID
		,cliID
		,numAtt
		,scanne
		,dateLimite
		,catRemb
		,condRemb
	)
	values(
		 :attestation
		,:speID
		,:cliID
		,:numAtt
		,0
		,coalesce(:dateLimite,'01.01.1900')
		,:t_cat
		,case
		when :condRemb = '?' then 2
		when :condRemb = 'N' then 3
		when :condRemb = 'V' then 4
		when :condRemb = 'A' then 5
		when :condRemb = '$' then 5				
		when :condRemb = 'I' then 6
		when :condRemb = 'E' then 7
		when :condRemb = 'K' then 8
		when :condRemb = 'T' then 9
		when :condRemb = 'J' then 10
		when :condRemb = 'n' then 11
		else 1
	   end
	 );

-- on créé un commentaire si pas de cat ou si il existai un comm
if (t_cat=0 or commentaire is not null or trim(commentaire)<>'' ) then
	begin
		comm = 'Attestation à créér N°'||:numAtt||' Remarques : '||:commentaire;
		update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500),
                            substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:cliID;
		if (mem_type=10) then 
			update t_client set COMMENTAIREBLOQU=1 where client=:cliID;
	end
end;

/********************************************************************************************************/
/**************************************   HISTODELGENERAL ***********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histodelgeneral(
	 histodelgeneral int
	,clientID int
	,facture int
	,codeOperateur int
	,date_acte date
	,date_prescription date
	,nom_medecin varchar(100)
	)
as
begin

insert into T_HISTODELGENERAL(
	 histodelgeneral
	,clientID
	,facture/* Numero d'ordonnance */
	,codeOperateur
	,date_acte /*Date de la vente*/
	,date_prescription
	,nom_medecin
	,theTypeFactur /* 2 => Ordonnance, 3 => Vte Directe*/
)
values(
  :histodelgeneral
	,:clientID
	,:facture
	,:codeOperateur
	,:date_acte
	,:date_prescription
	,substring(:nom_medecin from 1 for 50)
	,iif(:facture = 0,3,2)
);
end;


/********************************************************************************************************/
/**************************************  Histo Details   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histodeldetails(
   histodeldetails int
  ,histodelgeneralID int
  ,cnkProduit varchar(8)
  ,designation varchar(100)
  ,qteFacturee int
  ,prixVte float
  ,produitID int
)
as

begin

if (qteFacturee>=0) then
insert into T_HISTODELDETAILS(
   histodeldetails
  ,histodelgeneralID
  ,cnkProduit
  ,designation
  ,qteFacturee
  ,prixVte
  ,produitID
)
values(
   :histodeldetails
  ,:histodelgeneralID
  ,:cnkProduit
  ,:designation
  ,:qteFacturee
  ,:prixVte
  ,:produitID
);
end;

/********************************************************************************************************/
/**************************************   HISTOVENTE   **************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histovente(
  aaaamm varchar(7)
 ,prd_pk int
 ,qteVendue int
 ,nbVentes int
)
as

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
 :aaaamm||:prd_pk
,substring(:aaaamm from 6 for 2)
,substring(:aaaamm from 1 for 4)
,substring(:aaaamm from 1 for 4)||'/'||substring(:aaaamm from 6 for 2)||'/01'
,:prd_pk
,:qteVendue
,:nbVentes
);
end;

create or alter procedure ps_officinall_upd_pha_ref(
  client_id integer,
  dateo date,
  cnk varchar(7)
)
as
  declare variable pha_ref integer;
begin
   -- '5520689','5520705','5520721','5520739','5520788','5521059'
   pha_ref = 0;
   if (:cnk = '5520689' or :cnk='5520705' or :cnk='5520739' or :cnk='5521059') then pha_ref = 2;       
   if (:cnk = '5520721' or :cnk='5520788') then pha_ref = 6;
   
   
   update t_client
   set ph_ref = :pha_ref
   where client = :client_id;
end; 

/********************************************************************************************************/
/**************************************   PROFILE REMISE  ***********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_profilremise(
xml varchar(8000))
as
declare variable profilrem varchar(50);
declare variable lib varchar(30);
declare variable tauxregl numeric(5,2); --modif juin 11
declare variable typerist varchar(1); --0 direct 1 indirect/différé pareil que pour officinall
declare variable plafondrist numeric(5,2);  --modif juin 11
declare variable nb int;
declare variable i int;
declare variable ttype int;
declare variable typeprofile int;
begin
 f_ouvrir_xml(0, cast(xml as varchar(8000)));
 i = 0;
 nb = f_renvoyer_nombre_enfants('KortingSysteem');
 while (i < nb) do
 begin
	profilrem = f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/@Id');
	lib = substring(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/Naam') from 1 for 30);
	typerist = f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/Manier');
	ttype = f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/KortingType');
	if (ttype='1') then
	begin
		execute procedure ps_convertir_chaine_en_float(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/KortingMethode[0]/Percentage1')) returning_values :tauxregl;
		execute procedure ps_convertir_chaine_en_float(replace(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/KortingMethode[0]/MaxBedrag'),',','.')) returning_values :plafondrist;
	end
	else if (ttype='3')  then--a tester
	begin
		execute procedure ps_convertir_chaine_en_float(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/KortingMethode[0]/Percentage')) returning_values :tauxregl;
		execute procedure ps_convertir_chaine_en_float(replace(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/KortingMethode[0]/MaxVast'),',','.')) returning_values :plafondrist;
	end
	else if (ttype='4') then
	begin
		execute procedure ps_convertir_chaine_en_float(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/KortingMethode[0]/VasteSchijven/Item/Percentage')) returning_values :tauxregl;
		execute procedure ps_convertir_chaine_en_float(replace(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/KortingMethode[0]/VasteSchijven/Item/MaxVast'),',','.')) returning_values :plafondrist;
	end	
	else if (ttype <> '6') then
	begin
		execute procedure ps_convertir_chaine_en_float(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/Percentage')) returning_values :tauxregl;
		execute procedure ps_convertir_chaine_en_float(replace(f_renvoyer_valeur_xml('//KortingSystemen/KortingSysteem[' || i ||']/MaxVast'),',','.')) returning_values :plafondrist;
	end
        
        
   -- if (ttype<>0) then     --type 0 pas de remise
		insert into t_profilremise(profilremise,
                              defaultofficine,
                              libelle,
                              tauxreglegen,
                              typeristourne,
                              plafondristourne)
		values(:profilrem,
          '0',
          :lib,
          :tauxregl,
          :typerist,
          :plafondrist);
	i = i + 1;
 end
end;
