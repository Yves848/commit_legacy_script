set sql dialect 3;

/***********************************  Client / Patient   ************************************************/
create or alter procedure ps_creer_patients(
  CLIENT int
 ,NOM varchar(30)
 ,LANGUE varchar(1)
 ,RUE1 varchar(80)
 ,TEL1 varchar(30)
 ,TEL2 varchar(30)
 ,GSM varchar(30)
 ,FAX varchar(30)
 ,EMAIL varchar(50)
 ,CP varchar(10)
 ,LOCALITE varchar(30)
 ,CODEPAYS varchar(3)
 ,NUM_TVA varchar(12)
 ,COLLECTIVITE varchar(1)
 ,IDPROFILREMISE varchar(5)
 ,TYPEPROFILFACTURATION int
 ,PRENOM1 varchar(20)
 ,DATENAISSANCE date
 ,NUMGROUPE int
 ,NISS varchar(11)
 ,EDITION704 int
 ,EDITIONCBL int
 ,EDITIONBVAC int
 ,NUMCHAMBRE varchar(15)
 ,SEXE varchar(1)
 ,OA int
 ,MATOA varchar(13)
 ,DATEDEBOA date
 ,DATEFINOA date
 ,CT1 numeric(3)
 ,CT2 numeric(3)
 ,OC int
 ,MATOC varchar(13)
 ,CATOC varchar(2)
 ,DATEDEBOC date
 ,DATEFINOC date
 ,OAT int
 ,MATAT varchar(13)
 ,DATEDEBAT date
 ,DATEFINAT date
 ,VERSIONASSURABILITE int
 ,NUMEROCARTESIS numeric(10)
 ,DERNIERE_LECTURE date
 ,CERTIFICAT varchar(32)
 ,NATPIECEJUSTIFDROIT int
 ,COMMENTAIREINDIV varchar(500)
 ,DATE_DECES date
 ,IDFamille int
 ,PH_REF int
 )
as
declare variable StrNom varchar(30);
declare variable StrPrenom varchar(30);
declare variable StrNjf varchar(30);
begin

if (position(',', nom)>0) then StrNom = substring(nom from 1 for position(',', nom)-1); else StrNom=nom;
StrPrenom = PRENOM1;
if ((StrPrenom is null OR trim(StrPrenom) ='' ) AND COLLECTIVITE='0') then
	execute procedure ps_separer_nom_prenom(StrNom, ' ') returning_values :StrNom, :StrPrenom, :strNjf;

if (StrNom <> '') then 
 insert into T_CLIENT(
  CLIENT
 ,NOM
 ,LANGUE
 ,RUE1
 ,TEL1
 ,TEL2
 ,GSM
 ,FAX
 ,EMAIL
 ,CP
 ,LOCALITE
 ,CODEPAYS
 ,NUM_TVA
 ,COLLECTIVITE
 ,IDPROFILREMISE
 ,TYPEPROFILFACTURATION
 ,PRENOM1
 ,DATENAISSANCE
 ,NUMGROUPE
 ,NISS
 ,EDITION704
 ,EDITIONCBL
 ,EDITIONBVAC
 ,NUMCHAMBRE
 ,SEXE
 ,OA
 ,MATOA
 ,DATEDEBOA
 ,DATEFINOA
 ,CT1
 ,CT2
 ,OC
 ,MATOC
 ,CATOC
 ,DATEDEBOC
 ,DATEFINOC
 ,OAT
 ,MATAT
 ,DATEDEBAT
 ,DATEFINAT
 ,VERSIONASSURABILITE
 ,NUMEROCARTESIS
 ,DERNIERE_LECTURE
 ,CERTIFICAT
 ,NATPIECEJUSTIFDROIT
 ,COMMENTAIREINDIV
 ,ETAT
 ,IDFamille
 ,PH_REF
 )
 values(
  :CLIENT
 ,:StrNom
 ,iif(:langue = 'N','1','0')
 ,substring(:RUE1 from 1 for 70)
 ,substring(:TEL1 from 1 for 20)
 ,substring(:TEL2 from 1 for 20)
 ,substring(:GSM from 1 for 20)
 ,substring(:FAX from 1 for 20)
 ,:EMAIL
 ,substring(trim(:CP) from 1 for 6)
 ,:LOCALITE
 ,case when :CODEPAYS = 'B' then 'BE'
       when :CODEPAYS = 'D' then 'DE'
       when :CODEPAYS = 'F' then 'FR'
       when :CODEPAYS = 'L' then 'LU'
       when :CODEPAYS = 'NL' then 'NL'
       else 'BE'
  end
 ,trim(:NUM_TVA)
 ,:COLLECTIVITE
 ,:IDPROFILREMISE
 ,:TYPEPROFILFACTURATION
 ,substring(:StrPrenom from 1 for 20)
 ,:DATENAISSANCE
 ,:NUMGROUPE
 ,:NISS
 ,iif((:EDITION704=0 or :EDITION704=2),'1','0')
 ,:EDITIONCBL
 ,iif(:EDITIONBVAC>0,'1','0')
 ,substring(trim(:NUMCHAMBRE) from 1 for 6)
 ,:SEXE
 ,:OA
 ,:MATOA
 ,:DATEDEBOA
 ,:DATEFINOA
 ,:CT1
 ,:CT2
 ,:OC
 ,:MATOC
 ,case
  when :CATOC='SM' then 91
  when :CATOC='PF' then 93
  when :CATOC='CP' then 0
  else null
  end
 ,:DATEDEBOC
 ,:DATEFINOC
 ,:OAT
 ,:MATAT
 ,:DATEDEBAT
 ,:DATEFINAT
 ,:VERSIONASSURABILITE
 ,:NUMEROCARTESIS
 ,:DERNIERE_LECTURE
 ,:CERTIFICAT
 ,case
   when :NATPIECEJUSTIFDROIT=1 then '2'
   when :NUMEROCARTESIS is not null then '1'
   else '0'
  end
  ,:COMMENTAIREINDIV
  ,iif(:DATE_DECES is not null, 1, 0)
  ,iif(:IDFamille<>:CLIENT, :IDFamille, null)
  ,iif(:PH_REF=0, 1, iif(:PH_REF=1, 2, 0))
 );

End;
/*
CREATE TABLE T_CLIENT(
  CERTIFICAT               dm_varchar32 DEFAULT NULL, --------------> ShInsrCatID??????
  DATEDEBUTVALIDITEPIECE   dm_date DEFAULT NULL,
  DATEFINVALIDITEPIECE     dm_date DEFAULT NULL,
  COMMENTAIREBLOQU         dm_char1 DEFAULT NULL,
  PAYEUR                   dm_char1  DEFAULT 'A'  NOT NULL,
  DATEDERNIEREVISITE       dm_dateheure DEFAULT NULL,
  CPAS										 dm_code DEFAULT NULL,
  COPIESCANEVASFACTURE 		 dm_varchar3 DEFAULT NULL,
  */


/********************************************************************************************************/
/**************************************   PRODUITS   ****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_produits(
   produit int
  ,codeCNK_prod varchar(10)
  ,designCNKFR_prod varchar(50)
  ,designCNKNL_prod varchar(50)
  ,prixachatcatalogue float
  ,prixvente float
  ,categ_prod varchar(1)
  ,dateDernDeliv date
  ,datePeremption date
  ,stock int
  ,stockmini int
  ,stockmaxi int
  ,commentaire varchar(200)
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
  ,categ_prod
  ,stockmini
  ,stockmaxi
  ,dateDernDeliv
  ,datePeremption
  ,profilgs
  ,isPdtPropre
  ,commentairevente
 )
  values(
   :produit
  ,substring(trim(:codeCNK_prod) from 1 for 7)
  ,:designCNKFR_prod
  ,:designCNKNL_prod
  ,:prixachatcatalogue
  ,:prixvente
  ,:categ_prod
  ,iif(:stockmini>0,:stockmini-1,0)
  ,:stockmaxi
  ,:dateDernDeliv
  ,:datePeremption
  ,iif(:stock is null,1,0)
  ,0   -- artType = div  pour les produits propres ??????
  ,:commentaire
  );

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
 end;
 
/********************************************************************************************************/
/**************************************   STOCK   ****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_stocks(
   produit int
  ,stockTotal int
  ,stockDepot int
  ,stockmini int
  ,stockmaxi int
  ,depot int
  ,zonegeo int
  ,nb_stock int
)
as
declare variable prio integer;
declare variable prio_stock1 integer;
begin
 
if (stockDepot is null) then
	insert into T_STOCK(
		stock--int
		,qteenstk--int
		,stkMin
		,stkMax
		,depot
		,produit--int
		,priorite	/* 1 => stock prioritaire, 2 => stock secondaire) */
		,depotvente
		) /* Integer : 1 => stock vente , 0 => stock non vente */
	values(
		:produit
		,:stockTotal
		,iif(:stockmini>0,:stockmini-1,0)
		,:stockmaxi
		,1
		,:produit
		,1
		,1
		);
else 
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
		  ,priorite	/* 1 => stock prioritaire, 2 => stock secondaire) */
		  ,depotvente
		  ,zonegeo
		  ) /* Integer : 1 => stock vente , 0 => stock non vente */
		values(
		   :produit||'-'||:depot
		  ,:stockDepot
		  ,iif(:stockmini>0,:stockmini-1,0)
		  ,:stockmaxi
		  ,:depot
		  ,:produit
		  ,:prio
		  ,iif(:prio = 1,1,0)
		  ,:zonegeo
		  );
	end
end;
 
 
 

/********************************************************************************************************/
/**************************************   PROFILE REMISE ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_profilremise(
 PROFILREMISE varchar(5)
,TYPERISTOURNE varchar(1)
,LIBELLE varchar(30)
,TAUXREGLEGEN float
 )
as

begin

  insert into T_PROFILREMISE(
     PROFILREMISE
    ,DEFAULTOFFICINE
    ,LIBELLE
	,TYPERISTOURNE
	,TAUXREGLEGEN
    )
   values(
     :PROFILREMISE
    ,0
    ,:LIBELLE
	,iif(:TYPERISTOURNE='R',0,1)
	,:TAUXREGLEGEN
   );

 end;


/********************************************************************************************************/
/***********************************      Fournisseur    ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_fournisseurs(
   FOURNISSEUR int
  ,NOMFOURN varchar(50)
  ,RUEFOURN varchar(80) --varchar40
  ,LOCFOURN varchar(30)
  ,CPFOURN varchar(10) --varchar6
  ,TEL varchar(30) --varchar20
  ,TEL2 varchar(30) --varchar20
  ,GSM varchar(30) --varchar20
  ,FAX varchar(30) --varchar20
  ,EMAIL varchar(50)
  ,PAUSE varchar(1)
  ,NUMAPB varchar(10)
  )
as
declare variable nb_prod integer;
declare variable code varchar(50);
Begin

select count(*)
from T_TARIFPDT
where fou=:FOURNISSEUR
into :nb_prod;

--On cherche la coorespondance TR_four
select max(fournisseur)
from tr_fournisseur
where numapb=:NUMAPB
into :code;

INSERT INTO T_FOURNISSEUR(
   FOURNISSEUR
  ,TR_FOURNISSEUR
  ,NOMFOURN
  ,RUEFOURN
  ,LOCFOURN
  ,CPFOURN
  ,TEL
  ,TEL2
  ,GSM
  ,FAX
  ,EMAIL
  ,PAUSE
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
  ,substring(:TEL2 from 1 for 20)
  ,substring(:GSM from 1 for 20)
  ,substring(:FAX from 1 for 20)
  ,:EMAIL
  ,:PAUSE
  ,substring(:NUMAPB from 1 for 4)
  ,:nb_prod
);

execute procedure CONVFOURNISSEUR;

End;
--	nbTentatives dm_numpos3 DEFAULT NULL,
--	modeTransmission dm_char1 DEFAULT NULL,
--	fouPartenaire dm_char1 DEFAULT NULL,

 /********************************************************************************************************/
/***********************************      Repartiteurs   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_repartiteurs(
   repartiteur int  --varchar50
  ,nomRepart varchar(150)--varchar50
  ,rueRepart varchar(150) --varchar40
  ,locRepart varchar(100) --varchar40
  ,cpRepart varchar(10) --varchar6
  ,TEL varchar(30) --varchar20
  ,TEL2 varchar(30)--varchar20
  ,GSM varchar(30) --varchar20
  ,FAX varchar(30) --varchar20
  ,EMAIL varchar(50)
  ,PAUSE varchar(1)
  ,DATEMAJ date
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
  ,TEL2
  ,GSM
  ,FAX
  ,EMAIL
  ,PAUSE
  ,nbPdtsAssocies
)
VALUES (
   :repartiteur
  ,:nomRepart
  ,substring(:rueRepart from 1 for 40)
  ,:locRepart
  ,substring(:cpRepart from 1 for 6)
  ,substring(:TEL from 1 for 20)
  ,substring(:TEL2 from 1 for 20)
  ,substring(:GSM from 1 for 20)
  ,substring(:FAX from 1 for 20)
  ,substring(:EMAIL from 1 for 50)
  ,:PAUSE
  ,:nb_prod
);

execute procedure CONVREPARTITEUR;

End;

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
create or alter procedure ps_creer_tarif_produit(
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
  ,codeb varchar(13)
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
  ,1
  ,0
  );
end;

/********************************************************************************************************/
/**************************************   Medecins  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_medecins (
   MEDECIN int
  ,NOM varchar(50)
  ,PRENOM varchar(20)
  ,MATRICULE varchar(8)
  ,CODESPEC varchar(3)
  ,EMAIL varchar(50)
  ,FAX varchar(30) --20
  ,VILLE varchar(30)
  ,CP varchar(10)
  ,CODEPAYS varchar(3)
  ,TEL1 varchar(30) --20
  ,TEL2 varchar(30)--20
  ,GSM varchar(30)--20
  ,RUE1 varchar(80)--46
  ,codeprof varchar(3)
  ,COMMENTAIRES varchar(200)
  )

as
declare variable ident varchar(11);
declare variable paysCli varchar(2);
declare variable StrNom varchar(50);
declare variable StrPrenom varchar(50);
declare variable StrNjf varchar(30);
declare variable inaminr varchar(8);
begin

StrNom = NOM;
StrPrenom = PRENOM;



if (StrPrenom is null OR trim(StrPrenom) ='' ) then
    execute procedure ps_separer_nom_prenom(StrNom, ' ') returning_values :StrNom, :StrPrenom, :strNjf;

 if (CODEPAYS = 'B') then
     paysCli = 'BE';
 else if (CODEPAYS = 'D') then
    paysCli = 'DE';
 else if (CODEPAYS = 'F') then
    paysCli = 'FR';
 else if (CODEPAYS = 'L') then
    paysCli = 'LU';
 else if (CODEPAYS = 'NL') then
    paysCli = 'NL';
 else
    paysCli = 'BE';

if (matricule is null or matricule = '') THEN
  inaminr = '10000205';
ELSE 
  inaminr = matricule;

ident=:inaminr||:CODESPEC;

insert into T_MEDECIN(
     MEDECIN
    ,NOM
    ,PRENOM
    ,MATRICULE
    ,CODESPEC
    ,EMAIL
    ,FAX
    ,VILLE
    ,CP
    ,CODEPAYS
    ,TEL1
    ,TEL2
    ,GSM
    ,RUE1
    ,IDENTIFIANT
    ,CATEGORIE
    ,ISDENTISTE
    ,ISMEDFRONT
    ,COMMENTAIRES
)
values(
  :MEDECIN
 ,:StrNom
 ,:StrPrenom
 ,:inaminr
 ,coalesce(:codespec,'999')
 ,:EMAIL
 ,substring(:FAX from 1 for 20)
 ,:VILLE
 ,:CP
 ,:paysCli
 ,substring(:TEL1 from 1 for 20)
 ,substring(:TEL2 from 1 for 20)
 ,substring(:GSM from 1 for 20)
 ,substring(:RUE1 from 1 for 70)
 ,:ident
 ,case when (trim(:inaminr))='10000205' then '3' else '1' end
 ,iif(:codeprof = 'DEN' ,1,0)
 ,iif(:codeprof = 'MEF' ,1,0)
 ,:COMMENTAIRES
 );
end;
-- COMMENTAIRES dm_commentaire DEFAULT NULL,
--	SITE dm_varchar200 DEFAULT NULL,

/********************************************************************************************************/
/**************************************   HISTOVENTE   **************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histovente(
  aaaamm varchar(7)
 ,speSerie int
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
 :aaaamm||:speSerie
,substring(:aaaamm from 6 for 2)
,substring(:aaaamm from 1 for 4)
,substring(:aaaamm from 1 for 4)||'/'||substring(:aaaamm from 6 for 2)||'/01'
,:speSerie
,:qteVendue
,:nbVentes
);
end;

/********************************************************************************************************/
/**************************************   HISTODELGENERAL ***********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histodelgeneral(
	 histodelgeneral int
  ,SsecNr int
	,clientID int
	,facture int
	,codeOperateur int
	,date_acte date
	,date_prescription date
	,nom_medecin varchar(50)
 ,prenom_medecin varchar(20)
	)
as
begin

insert into T_HISTODELGENERAL(
	 histodelgeneral
	,clientID
	,facture
	,codeOperateur
	,date_acte
	,date_prescription
	,nom_medecin
    ,prenom_medecin
	,theTypeFactur /* 2 => Ordonnance, 3 => Vte Directe*/
)
values(
  :histodelgeneral||:SsecNr
	,:clientID
	,:facture
	,:codeOperateur
	,:date_acte
	,:date_prescription
	,:nom_medecin
	,:prenom_medecin
    ,iif(:facture is null,3,2)
);
end;

/********************************************************************************************************/
/**************************************  Histo Details   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histodeldetails(
   histodeldetails1 int
  ,histodeldetails2 int
  ,histodelgeneralID int
  ,cnkProduit varchar(10)
  ,designation varchar(50)
  ,qteFacturee int
  ,prixVte float
  ,produitID int
)
as
begin
--if (qteFacturee>=0) then
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
   'A'||:histodelgeneralID||'B'||:histodeldetails1||'c'||:histodeldetails2
  ,:histodelgeneralID||:histodeldetails1
  ,substring(trim(:cnkProduit) from 1 for 7)
  ,substring(trim(:designation) from 1 for 100) --substring car un cas qui passe a 77 malgre la taille de 50
  ,:qteFacturee
  ,:prixVte
  ,:produitID
);
end;

/********************************************************************************************************/
/**************************************   COMPTE RISTOURNE  *********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_compterist(
  compte varchar(50)
 ,cliID int
 ,liberType varchar(1)
 ,liberVal varchar(6)
)
as
begin
/*Type de lybération :
Par période fixe : D, val = mois ?
Par montant fixe : E , val / 100
Une fois par an , à date faixe : C , val = date mm/jj   08/17
A partir d'un montant : A, val / 100
A partir d'un nombre de visites : B, val
*/

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
 ,case
   when :liberType ='A' then '1'
   when :liberType ='B' then '2'
   when :liberType ='C' then '3'
   when :liberType ='D' then '4'
   when :liberType ='E' then '1'
   else '1'
   end
 ,case
   when :liberType ='A' then substring(:liberVal from 1 for 3)
   when :liberType ='B' then :liberval
   when :liberType ='C' then substring(:liberVal from 4 for 2)||substring(:liberVal from 1 for 2)
   when :liberType ='D' then :liberval
   when :liberType ='E' then substring(:liberVal from 1 for 3)
   when :liberVal is null then 5
   else substring(:liberVal from 1 for 3)
   end
 ,1
);
end;

/********************************************************************************************************/
/**************************************   CARTE RISTOURNE  **********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_carterist(
  carterist varchar(13)
 ,compteID int
 ,code_cli int
 ,dateEmis date
)
as
declare variable clicli int;
Begin

if (code_cli is null) then
    select cliID
    from t_compte
    where compte = :compteID
    into :clicli;
else 
	clicli=:code_cli;
	
insert into T_CARTERIST(
	carterist
	,compteID
	,cliID
	,dateEmis
	,numCarte
	,virtuel
	,etat
)
values(
	:carterist
	,:compteID
	,:code_cli
	,:dateEmis
	,:carterist
	,0
	,1);
end;

/********************************************************************************************************/
/**************************************   TRANSACTION RISTOURNES ****************************************/
/********************************************************************************************************/
create sequence seq_transaction_id;
create or alter procedure ps_creer_transactionrist(
 numcarte varchar(13)
,compteID int
,montantRist float
--,tauxTVA int
,dateTicket date
)
as
begin
--On passe toutes les tva à 6, en effet la base greenock ne correspond pas forcement sur les ristourne et les liberation
  insert into T_TRANSACTIONRIST(
	 transactionrist
	,numcarte
	,compteID
	,montantRist
	,typeTransact
	,tauxTVA
	,justificatif
	,dateTicket
  )
  values(
    next value for seq_transaction_id
   ,:numcarte
   ,:compteID
   ,:montantRist
   ,'0'
   ,6
   ,'REPRISE DONNEES'
   ,:dateticket
  );
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
	,condRemb varchar(1)
 ,nbCond int
 ,mem varchar(1000) --a la place de text
)
as
declare variable comm varchar(500);
declare variable cat varchar(1);
begin

cat = substring(:catRemb from 1 for 1);
cat = case
		when :cat = 'A' then 1
		when :cat  = 'B' then 2
		when :cat  = 'C' then 3
		when :cat  = 'S' then 4
		when :cat  = 'X' then 5
		when :cat  = 'D' then 6
		when :cat  = 'G' then 7
		when :cat  = 'W' then 8
		when :cat  = 'J' then 9
		else 0
	   end;

if (cat<>0) then
	insert into T_ATTESTATION(
		 attestation
		,speID
		,cliID
		,numAtt
		,scanne
		,dateLimite
		,catRemb
		,condRemb
		,nbCond
	)
	values(
		 next value for seq_attestation
		,:speID
		,:cliID
		,:numAtt
		,0
		,coalesce(:dateLimite,'01.01.1900')
		,:cat
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
	 ,:nbcond
	 );
-- on créé un commentaire si pas de cat ou si il existai un comm
if (cat=0 or trim(mem)<>'' ) then
		begin
			comm = 'Attest. N°'||:numAtt||'Rem. :'||:mem;
			update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500),
				substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:cliID;
		end
end;
/********************************************************************************************************/
/**************************************   DEPOT    ******************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_greenock_depot(
  depot int
 ,libelle varchar(30)
 ,automate int
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
   ,:automate
 );

end;

/********************************************************************************************************/
/**************************************   ZONEGEO   *****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_zonegeo (
	 ZoneGeo_Cle int
	,ZoneGeo_Nom varchar(30)
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
/**************************************   AVANCE PRODUIT ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_avance_produit(
  litige int
 ,client int
    ,nomPdt varchar(50)
    ,produit int
    --,noOrd varchar(50)--int
    ,prixClient float /* Montant que le client paye (tva comprise) sans le montant payé par le tiers payant*/
    ,qtedelivree float
    ,qtemanquante float
    ,dateVente date
    --,isFacture char(1)
    ,cdbu varchar(16)
)
as
declare variable nb int;

begin

--Si la ligne est doublé c'est qu'il y 'a plusieurs CBU, donc not null
if (cdbu is not null) then
    select count(*)
    from t_litige
    where litige = :litige
    into :nb;
else
    nb=0;

if (nb =1) then --mise à jour de la ligne
   update t_litige set cdbu=cdbu||';'||:cdbu where litige = :litige;
else
    insert into t_litige(
         litige
        ,client
        ,typeLitige  /* 1 => Manque ordonnance */
        ,descriptionLitige
        ,nomPdt
        ,produit
        --,noOrd
        ,prixClient  /* Montant que le client paye (tva comprise) sans le montant payé par le tiers payant*/
        ,qtedelivree
        ,qtemanquante
        ,dateVente
        --,isFacture
        ,cdbu
    )
    values(
         :litige
        ,:client
        ,1
        ,''
        ,:nomPdt
        ,:produit
        --,:noOrd
        ,:prixClient
        ,:qtedelivree
        ,:qtemanquante
        ,:dateVente
        --,:isFacture
        ,:cdbu
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
End;

/********************************************************************************************************/
/**************************************   Memo Patient  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_memopatient(
memo int,
mem_type varchar(1),
patient int,
nom_prd varchar(50),
date_echeance date,
qte float,
numOrdo int
)
--inutile pour avance et deldif car ligne de vente créé
as
declare variable strPatient varchar(50);
declare variable comm varchar(500);
declare variable blo int;
declare variable quantite numeric(10,2);
begin

quantite = round(:qte,2);--- Pour ne laisser que 2 chiffres derrière la virgule

comm = case
        when :mem_type = '1' then 'Crédit du '
        when :mem_type = '2' then 'Attente Tarification '
        when :mem_type = '4' then 'Att Manq. '
        when :mem_type = '5' then 'Reservé payé '
        when :mem_type = '6' then 'Reservé non payé '
        when :mem_type = '7' then 'Bon pour '
        when :mem_type = '8' then 'Renouv. '
        when :mem_type = '9' then 'Carte Sis manq. '
        when :mem_type = 'C' then 'Deliv non payé '
        when :mem_type = 'D' then 'Remb ristourne '
        when :mem_type = 'L' then 'Location '
        else ''
       end;

if ((mem_type = '1') or (mem_type = '4') or (mem_type = '9') or (mem_type = 'C')) then blo=1;

if (mem_type='1') then
 comm = :date_echeance||' Somme:'||:quantite||'€)';
else
 begin
    if (nom_prd<>'') then comm = comm||'Pdt:'||:nom_prd;
    if (quantite>0) then comm = comm||' Qte:'||:quantite;
    if (date_echeance is not null) then  comm = comm||' Date:'||:date_echeance;
	if (numOrdo is not null) then  comm = comm||' Ordo:'||:numOrdo;
 end

strPatient = cast(patient as varchar(50));
update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500),
       substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:strPatient;

update t_client set COMMENTAIREBLOQU=:blo where client=:strPatient;

end;

/**************************************   Schema de medication produit  ************************************************/
create or alter procedure ps_creer_schema_produit(
	t_sch_medication_produit_id int
	,t_produit_id int
	,t_aad_id int
	,date_debut date
	,date_fin date
	,commentaire varchar(200)
	,libelle varchar(50)
)
as
--declare variable comm varchar(500);
begin

insert into t_sch_medication_produit(
	t_sch_medication_produit_id
	,t_produit_id
	,t_aad_id
	,date_debut
	,date_fin
	,commentaire
	,libelle
	,typemedication
	)
values(
	:t_sch_medication_produit_id
	,:t_produit_id
	,:t_aad_id
	,:date_debut
	,:date_fin
	,:commentaire
	,:libelle
	,1
 );
End;

/**************************************   Schema de medication prise  ************************************************/
create or alter procedure ps_creer_schema_prise(
	T_SCH_MEDICATION_PRODUIT_ID int
	,TYPE_FREQUENCE varchar(3)  --D jour, W semaine, M mois
	,joursemaine int
	,momentjour int
)
as
--declare variable comm varchar(500);
begin

insert into t_sch_medication_prise(
	T_SCH_MEDICATION_PRISE_ID
	,T_SCH_MEDICATION_PRODUIT_ID
	,TYPE_FREQUENCE
	,FREQUENCE_JOURS
	,PRISE_LEVER 
	,PRISE_PTDEJ 
	,TYPE_MOMENT_PTDEJ 
	,PRISE_MIDI 
	,TYPE_MOMENT_MIDI 
	,PRISE_SOUPER 
	,TYPE_MOMENT_SOUPER 
	,PRISE_COUCHER 
	,PRISE_10HEURES 
	,PRISE_16HEURES 
	)
values(
	next value for seq_schem_prise
	,:T_SCH_MEDICATION_PRODUIT_ID
	,case when :TYPE_FREQUENCE = 'D' then 1 when  :TYPE_FREQUENCE = 'W' then 3 when  :TYPE_FREQUENCE = 'M' then 4 else 1 end 
	,case when :joursemaine = 1 then '1000000'
		when :joursemaine = 1 then '0100000'
		when :joursemaine = 1 then '0010000'
		when :joursemaine = 1 then '0001000'
		when :joursemaine = 1 then '0000100'
		when :joursemaine = 1 then '0000010'
		when :joursemaine = 1 then '0000001'
		else null
		end 
	,iif(:momentjour=1, 1, 0) --PRISE_LEVER
	,iif(:momentjour=2 or :momentjour=3 or :momentjour=4, 1, 0)
	,:momentjour -- ça ne marche que pour celui la
	,iif(:momentjour=6 or :momentjour=7 or :momentjour=8, 1, 0) --PRISE_MIDI
	,case when :momentjour=6 then 2  when :momentjour=7 then 3 when :momentjour=8 then 4 else 1 end
	,iif(:momentjour=10 or :momentjour=11 or :momentjour=12, 1, 0) --souper
	,case when :momentjour=10 then 2  when :momentjour=11 then 3 when :momentjour=12 then 4 else 1 end
	,iif(:momentjour=14 or :momentjour=13, 1, 0) --PRISE_COUCHER
	,iif(:momentjour=5, 1, 0)
	,iif(:momentjour=9, 1, 0) 
 );
End;

/**************************************   Histo del magistrale  ************************************************/
/********************************************************************************************************/
/*create or alter procedure ps_creer_histodeldetails(
  
insert into T_HISTODELDETAILS(
   histodeldetails
  ,histodelgeneralID
values(
   'A'||:histodelgeneralID||'B'||:histodeldetails1||'c'||:histodeldetails2
*/

create or alter procedure ps_creer_histodelmagistrale(
   histodeldetails1 int
  ,histodeldetails2 int
  ,histodelgeneralID int
  ,designation varchar(100)
  ,qteFacturee integer
  ,form varchar(5)
	,qtfaire integer
  -- lpad(:cnkProduit,7,'0')||';'||trim(:libproduit)||';'||trim(:complement)||';'||:qtprep||';'||:unite
  ,cnkProduit varchar(10)
  ,libproduit varchar(50) -- cnk en attendant mieux
	,compl integer ---- 1 ana ->3 ,2 ad->2  ,3 ana ad   ,4 qs ->4
	,quantite_prep float ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
	,unit varchar(3) ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
  ,memo varchar(4000) -- contient parfois la formule
)
as
declare unite integer;
declare forme integer;
declare qtprep float;
declare complement integer;


/*greenock table [Greenock].[Mag].[GalformTypes]
GalformCode	ImageName	GalformName
A01A	GalformGelule	Capsule  =  1
A02A	GalformCachet	Tablet  =  3
A08A	GalformSuppoAd	SuppositoryAdult  = 6 
A09A	GalformSuppoEnfant	SuppositoryChild  =  8 
A10A	GalformOvule	Pessary  =  9
A11A	GalformRectiole	Rectiole  =  
A15A	GalformPdrdivUI	PowderDivideInternal  = 14  
A15B	GalformPdrdivUE	PowderDivideExternal  =  15
A20A	GalformSolutionUI	SolutionInternal  =  10
A20B	GalformSirop	Potion  =  10
A20C	GalformSirop	Sirup  =  10
A21A	GalformSolutionUE	SolutionExternal  =  11
A27A	GalformCollyre	OphtalmicDrops  =  17
A28A	GalformLotOpht	OphtalmicLotion  =  18
A30A	GalformPommade	Ointment  =  16
A30B	GalformPomCreme	Cream  =  16
A30C	GalformPomGel	Gel  =  16
A30D	GalformPomOngue	Unguent  = 16 
A30E	GalformPomPate	Pasta  =  16
A30F	GalformPommade	SolidDermatology  = 16 
A31A	GalformPomOph	OphtalmicCream  =  19
A40A	GalformThe	HerbTea  =  13
A40B	GalformMelSemences	SeedBlend  =  
A41A	GalformPdrMelUI	PowderBlendInternal  =  14
A41B	GalformPdrMelUE	PowderBlendExternal  =  15
A71A	GalformGeluleEnrobee	CoatedCapsule  =  
A8AA	GalformHomeo	Homeopathy  =  
A90A	GalformDelivrance	AsIsDelivery  =  20
A9AA	GalformDelivLiquiUI	AsIsInternalSolution  =  20
A9BA	GalformDelivLiquiUE	AsIsExternalSolution  =  20
A9CA	GalformDelivPom	AsIsCream  =  20
A9DA	GalformDelivPoudre	AsIsPowder  = 20 
*/

begin
  forme = case 
            when :form = 'A01A' then 1  
            when :form = 'A02A' then 3  
            when :form = 'A08A' then 6  
            when :form = 'A09A' then 8  
            when :form = 'A10A' then 9 
            when :form = 'A15A' then 14
            when :form = 'A15B' then 15 
            when :form = 'A20A' or :form = 'A20B' or :form = 'A20C' then 10  
            when :form = 'A21A' then 11  
            when :form = 'A27A' then 17  
            when :form = 'A28A' then 18 
            when :form = 'A30A' or :form = 'A30B' or :form = 'A30C' or :form = 'A30D' or :form = 'A30E' or :form = 'A30F' then 16 
            when :form = 'A31A' then 19
            when :form = 'A40A' then 13 
            when :form = 'A41A' then 14 
            when :form = 'A41B' then 15
            when :form = 'A71A' then 2
            when :form = 'A90A' or :form = 'A9AA' or :form = 'A9BA' or :form = 'A9CA' or :form = 'A9DA' then 20
            else null
          end;
  unite = case 
            when :unit = 'cg' then 2-- attention à faire *10 sur la quantité  
            --when :unit = 'dm2' then ????
            when :unit = 'g' then 1
            when :unit = 'gam' then 6
            when :unit = 'gtt' then 4 
            when :unit = 'KUI' then 9 -- *1000
            when :unit = 'l' then 3
            when :unit = 'mg' then 2
            when :unit = 'ml' then 3
            when :unit = 'pce' then 5
            when :unit = 'prc' then 7
            when :unit = 'UI' then 9
            when :unit is null and :forme =20 then 5
            else null
          end;
  qtprep = case 
            when :unit = 'cg' then :quantite_prep*10  
            when :unit = 'KUI' then :quantite_prep*1000  
            when :unit = 'l' then :quantite_prep*1000  
            else :quantite_prep
          end;
  complement = case -- 1 ana ->3 ,2 ad->2 ,3 ana ad   ,4 qs ->4
            when :compl = 1 then 3
            when :compl = 2 then 2
            when :compl = 4 then 4
            else 1
  end;

  if (not exists(select * from t_HISTODELMAGISTRALE where HISTODELMAGISTRALE='A'||:histodelgeneralID||'B'||:histodeldetails1||'C'||:histodeldetails2)) then
    insert into T_HISTODELMAGISTRALE(
      histodelmagistrale
      ,histodelgeneralID
      ,designation
      ,qteFacturee
      ,detail
      ,clemag
    )
    values(
       'A'||:histodelgeneralID||'B'||:histodeldetails1||'C'||:histodeldetails2
      ,:histodelgeneralID||:histodeldetails1
      ,substring(coalesce(:cnkProduit,:memo,:designation) from 1 for 100) -- si pas de produit alors on met le memo
      ,:qteFacturee
      ,substring((:forme||';'||:qtfaire||'<BR>'||lpad(:cnkProduit,7,'0')||';'||trim(:libproduit)||';'||trim(:complement)||';'||:qtprep||';'||:unite||';;<BR>') from 1 for 4000)
      ,iif((:unite is null or :forme is null) and :cnkProduit is not null, null,'1') -- on passe à null pour générer une erreur
      -- le and cnkproduit et la pour gérer le cas du memo juste au dessus , car toute la ligne est vide sauf le memo
    );
  else
    update T_HISTODELMAGISTRALE
    set detail = substring((detail||lpad(:cnkProduit,7,'0')||';'||trim(:libproduit)||';'||trim(:complement)||';'||:qtprep||';'||:unite||';;<BR>') from 1 for 4000), 
    clemag = iif(:unite is null or :forme is null , null,'1')
    where histodelmagistrale='A'||:histodelgeneralID||'B'||:histodeldetails1||'C'||:histodeldetails2;

end;