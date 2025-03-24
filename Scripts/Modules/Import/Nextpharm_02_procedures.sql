set sql dialect 3;

/********************************************************************************************************/
/**************************************   PROFILEREMISE *************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_profilremise(
 TAUXREGLEGEN int
)
as
declare variable typer char(1);
declare variable profil varchar(50);
declare variable taux int;
declare variable lib varchar(30);

begin

if (:TAUXREGLEGEN > 0) then
 begin
  taux = :TAUXREGLEGEN;
  profil='pat-rem-'||:taux;
  typer='0';
  lib='PATIENT '||:taux||'%';
 end
else
 begin
  taux = :TAUXREGLEGEN*-1;
  profil='pat-rist-'||:taux;
  typer='1';
  lib='PATIENT '||:taux||'%';
 end

INSERT INTO T_PROFILREMISE (
 PROFILREMISE
,DEFAULTOFFICINE
,LIBELLE
,TAUXREGLEGEN
,TYPERISTOURNE
)
VALUES(
  :profil
,'0'
,:lib
,:taux
,:typer
);
end;

/********************************************************************************************************/
/**************************************   Medecins   ****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_medecin(
	 MEDECIN int
	,NOM varchar(60)
	,RUE1 varchar(50)
	,CP varchar(10)
	,VILLE varchar(50)
	,CODEPAYS varchar(2)
	,TEL1 varchar(15)
	,GSM varchar(15)
	,FAX varchar(15)
  ,EMAIL varchar(100)
	,MATRICULE varchar(8)
	,IDENTIFIANT varchar(11)
	--,COMMENTAIRES varchar(5000)
	)

as
declare variable StrNom varchar(60);
declare variable StrPrenom varchar(60);
declare variable StrNjf varchar(60);
begin

execute procedure ps_separer_nom_prenom(:NOM, ' ') returning_values :StrNom, :StrPrenom, :StrNjf;

insert into T_MEDECIN(
	MEDECIN
	,NOM
	,PRENOM
	,RUE1
	,TEL1
	,FAX
	,GSM
	,IDENTIFIANT
	,CODESPEC
	,MATRICULE
	--,COMMENTAIRES
	,EMAIL
	,VILLE
	,CP
	,CODEPAYS
	,CATEGORIE
	,ISMEDFRONT
)
values(
	:MEDECIN
	,substring(:StrNom from 1 for 50)
	,substring(:StrPrenom from 1 for 50)
	,:RUE1
	,:TEL1
	,:FAX
	,:GSM
	,iif(:IDENTIFIANT not similar to '[[:DIGIT:]]*','99999999999',:IDENTIFIANT)
	,iif(:IDENTIFIANT not similar to '[[:DIGIT:]]*','999',substring(:IDENTIFIANT from 9 for 3))
	,iif(:MATRICULE not similar to '[[:DIGIT:]]*','99999999',:MATRICULE)
	--,substring(f_rtf_vers_text(:COMMENTAIRES) from 1 for 200)
	,substring(:EMAIL from 1 for 50)
	,:VILLE
	,:CP
	,:CODEPAYS
	,case when (trim(:IDENTIFIANT))='10000007999' then '2'
	   	  when (:MATRICULE)='90000000' then '3'
		  else '1'
	 end
	,iif(trim(:IDENTIFIANT)='10000007999',1,0)
  );
end;

/********************************************************************************************************/
/***********************************  Client / Patient   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_patient(
  CLIENT int
 ,NOM varchar(40)
 ,PRENOM1 varchar(100)
 ,SEXE int
 ,LANGUE int
 ,DATENAISSANCE varchar(10)
 ,RUE1 varchar(50)
 ,CP varchar(10)
 ,LOCALITE varchar(50)
 ,CODEPAYS varchar(2)
 ,TEL1 varchar(15)
 ,GSM varchar(15)
 ,FAX varchar(15)
 ,EMAIL varchar(100)
 ,OA int
 ,MATOA varchar(15)--13
 ,CT1 int
 ,CT2 int
 ,DATEDEBOA varchar(10)
 ,DATEFINOA varchar(10)
 ,OC int
 ,MATOC varchar(15)--13
 ,CATOC int
 ,VERSIONASSURABILITE varchar(2)  --isnumeric
 ,NUM_TVA varchar(15)
 ,NUMEROCARTESIS varchar(10) ---isnumerci
 ,NISS varchar(11)
 ,CERTIFICAT varchar(32)
 ,DERNIERE_LECTURE varchar(10)
 ,COMMENTAIREINDIV varchar(8191)
 ,DATEDERNIEREVISITE varchar(10)  ----------VERIFIER si date = 0000-00-00 au lieu de vide ou null
 ,COLLECTIVITE varchar(1)
 ,NUMGROUPE int                    --'99999'+
 ,IDPROFILREMISE int
 ,type_rem int
 --,CPAS
 ,EDITIONBVAC int
 ,EDITIONCBL int
 ,EDITION704 int
 
 --,TYPEPROFILFACTURATION int
 --,COPIESCANEVASFACTURE
 ,NUMCHAMBRE varchar(15)  --
 ,IDFAMILLE int
 ,sch_commentaire varchar(2000)
 ,numero_passport_cni varchar(20)
 )
as
declare variable StrNom varchar(40);
declare variable StrPrenom varchar(40);
declare variable strNjf varchar(40);
declare variable dnaissance date;
declare variable ddeboa date;
declare variable dfinoa date;
declare variable ddlecture date;
declare variable ddernierevisite date;

begin

StrNom = NOM;
StrPrenom = PRENOM1;
if ((StrPrenom is null OR trim(StrPrenom) ='' ) AND :COLLECTIVITE='0') then
	execute procedure ps_separer_nom_prenom(StrNom, ' ') returning_values :StrNom, :StrPrenom, :strNjf;

execute procedure ps_conv_chaine_en_date_format(:DATENAISSANCE,'AAAAMMJJ') returning_values :dnaissance;
execute procedure ps_conv_chaine_en_date_format(:DATEDEBOA,'AAAAMMJJ') returning_values :ddeboa;
execute procedure ps_conv_chaine_en_date_format(:DATEFINOA,'AAAAMMJJ') returning_values :dfinoa;
execute procedure ps_conv_chaine_en_date_format(:DERNIERE_LECTURE,'AAAAMMJJ') returning_values :ddlecture;
execute procedure ps_conv_chaine_en_date_format(:DATEDERNIEREVISITE,'AAAAMMJJ') returning_values :ddernierevisite;

 insert into T_CLIENT(
 CLIENT
 ,NOM
 ,PRENOM1
 ,SEXE --varchar5
 ,LANGUE --varchar5
 ,DATENAISSANCE
 ,RUE1
 ,CP
 ,LOCALITE
 ,CODEPAYS
 ,TEL1
 ,GSM
 ,FAX
 ,EMAIL
 ,OA
 ,MATOA
 ,DATEDEBOA
 ,DATEFINOA
 ,OC
 ,MATOC
 ,CATOC
 ,CT1
 ,CT2
 ,VERSIONASSURABILITE
 ,NUM_TVA
 ,NUMEROCARTESIS
 ,NISS
 ,CERTIFICAT
 ,DERNIERE_LECTURE
 ,NATPIECEJUSTIFDROIT
 ,COMMENTAIREINDIV
 ,PAYEUR
 ,DATEDERNIEREVISITE
 ,COLLECTIVITE
 ,NUMGROUPE
 ,IDPROFILREMISE
 ,IDFamille
 ,EDITIONBVAC
 ,EDITIONCBL
 ,EDITION704
 ,NUMCHAMBRE
 ,sch_commentaire
 ,numero_passport_cni
 )
 values(
  iif(:COLLECTIVITE='1','99999'||:CLIENT,:CLIENT)
 ,substring(trim(:StrNom) from 1 for 30)
 ,iif(:COLLECTIVITE='1','',substring(trim(:StrPrenom) from 1 for 20))
 ,iif(:SEXE=1,1,2)
 ,iif((:LANGUE-1)<0,0,:LANGUE-1)
 ,:dnaissance
 ,:RUE1
 ,substring(trim(:CP) from 1 for 6)
 ,:LOCALITE
 ,:CODEPAYS
 ,:TEL1
 ,:GSM
 ,:FAX
 ,substring(trim(:EMAIL) from 1 for 50)
 ,:OA
 ,substring(trim(:MATOA) from 1 for 13)
 ,:ddeboa
 ,:dfinoa
 ,:OC
 ,substring(trim(:MATOC) from 1 for 13)
 ,:CATOC
 ,:CT1
 ,:CT2
 ,iif((:VERSIONASSURABILITE similar to '[[:DIGIT:]]*') and  (trim(:VERSIONASSURABILITE) <> ''),:VERSIONASSURABILITE,0)
 ,iif((:NUM_TVA similar to '[[:DIGIT:]]*') and  (trim(:NUM_TVA) <> ''),:NUM_TVA,0)
 ,iif((:NUMEROCARTESIS similar to '[[:DIGIT:]]*') and  (trim(:NUMEROCARTESIS) <> ''),:NUMEROCARTESIS,0)
 ,iif(trim(:NISS)='',null,:NISS)
 ,:CERTIFICAT
 ,:ddlecture
 ,case when (:DERNIERE_LECTURE is null and (:CT1>0) and (:CT2>0) and :DATEFINOA is null ) then '2'
       when (:DERNIERE_LECTURE is null) then '0'
       when (:CERTIFICAT='') then '2'
       else 1
  end
 ,substring(trim(f_rtf_vers_text(:COMMENTAIREINDIV)) from 1 for 500)
 ,'A'
 ,:ddernierevisite
 ,:COLLECTIVITE
 ,iif(:NUMGROUPE<>0,'99999'||:NUMGROUPE,0)
 ,case when (:COLLECTIVITE='1') and (:type_rem=4) and (:IDPROFILREMISE > 0) then 'cli-rem-'||:IDPROFILREMISE
       when (:COLLECTIVITE='1') then '0'
       when (:IDPROFILREMISE > 0) then 'pat-rem-'||:IDPROFILREMISE
       when (:IDPROFILREMISE < 0) then 'pat-rist'||:IDPROFILREMISE
       else '0'
  end
 ,iif(:IDFamille<>:CLIENT and :idfamille>0,:IDFamille,null)
 ,iif(:EDITIONBVAC <0 , 0, :EDITIONBVAC)
 ,iif(:EDITIONCBL < 0, 0, :EDITIONCBL)
 ,iif(:EDITION704 < 0, 0, :EDITION704)
 ,SUBSTRING(trim(:NUMCHAMBRE) from 1 for 6)
 ,:sch_commentaire
 ,:numero_passport_cni
 );

End;

/********************************************************************************************************/
/**************************************   COMPTE / TRANSACTION RISTOURNE  *******************************/
/********************************************************************************************************/
create or alter procedure ps_creer_compterist(
  compte int
 ,cliID int
 ,solde float
 ,liberType varchar(50)
 ,liberVal varchar(50)
 ,liberNbrV varchar(50)
)
as

/*******************************************************************************************************************************A FINIR AVEC VM*/
/* Dans les paramètres : séction = fidélité
typedécomptefidélité
nbrvisitepourdécompte
montantcomptepourdécompte = liberVal
typeactionqdsoldeatteind

Type de lybération :
Par période fixe : D, val = mois ?
Par montant fixe : E , val / 100
Une fois par an , à date fixe : C , val = date mm/jj   08/17
A partir d'un montant : A, val / 100
A partir d'un nombre de visites : B, val
*/

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
   when :liberType ='B' then :liberNbrV
   when :liberType ='C' then substring(:liberVal from 4 for 2)||substring(:liberVal from 1 for 2)
   when :liberType ='D' then :liberval
   when :liberType ='E' then iif(:liberVal similar to '[[:DIGIT:]]*', cast(substring(:liberVal from 1 for 3) as integer)/100, null)
   else substring(:liberVal from 1 for 3)
   end
 ,'1'
);

  insert into T_TRANSACTIONRIST( 	 transactionrist	,compteID	,montantRist	,typeTransact	,tauxTVA	,justificatif	,dateTicket  )
  values( :compte||'06'   ,:compte   ,:solde   ,'0'   ,6   ,'REPRISE DONNEES'   ,current_date  );

end;

/********************************************************************************************************/
/**************************************   CARTES RISTOURNE  *********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_carterist(
  carterist int
 ,numCarte varchar(20)
 ,cliID int
 ,compteID int
)
as
begin


insert into T_CARTERIST(
	 carterist
	,compteID
	,cliID
	,dateEmis
	,numCarte
	,virtuel
	,etat
	)
	values (
	:carterist
	,:compteID
	,:cliID
	,current_date
	,substring(trim(:numCarte) from 1 for 13)
	,'0'
	,'1'
	);

end;


/********************************************************************************************************/
/**************************************   Attestations  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_attestation(
	 attestation int
	,cliID int
	,speID int
	,numAtt varchar(20)
	,dateLimite varchar(10)
	,catRemb varchar(1)
	,condRemb varchar(1)
	,nbCond int
	,nbMaxCond int
)
as
declare variable comm varchar(500);
declare variable t_cat int;
declare variable dlimite date;

begin

execute procedure ps_conv_chaine_en_date_format(:dateLimite,'AAAAMMJJ') returning_values :dlimite;

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

if (char_length(:numAtt)<>0) then
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
			,codAssurSocial
			,nbCond
			,nbMaxCond
		)
		values(
			 :attestation
			,:speID
			,:cliID
			,trim(:numAtt)
			,0
			,:dlimite
			,:t_cat
			,case
				when :condRemb  = '?' then 2
				when :condRemb  = 'N' then 3
				when :condRemb  = 'v' then 4
				when :condRemb  = 'A' then 5
				when :condRemb  = '$' then 5
				when :condRemb  = 'I' then 6
				when :condRemb  = 'E' then 7
				when :condRemb  = 'K' then 8
				when :condRemb  = 't' then 9
				when :condRemb  = 'J' then 10
				when :condRemb  = 'n' then 11
				else 1
			end			
			,'0'
			,:nbCond
			,:nbMaxCond
		 );
	else
		begin
			comm = 'Attest. N°'||trim(:numAtt);
      if (speID is not null) then comm = comm||' CNK:'||speID;
      if (dateLimite is not null) then comm =comm||' Date Fin:'||:dlimite;
			update t_client set COMMENTAIREINDIV = (iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500),substring(COMMENTAIREINDIV||' - '||:comm from 1 for 500))) where client=:cliID;
		end
end;

/* condRemb
1 => Pas de condition
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

/********************************************************************************************************/
/**************************************   ZONEGEO ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_zonegeo(
	zonegeo int
	,libelle varchar(20)
)
as
begin
	INSERT INTO t_zonegeo(
		 zonegeo
		,libelle
	)
	VALUES(
		 :zonegeo
		,:zonegeo
	);
end;

/********************************************************************************************************/
/**************************************   CODEBARRE ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_codesbarre(
	 produit int
	,codebarre varchar(15)
)
as
begin
if (char_length(trim(:codebarre))=13) then
	INSERT INTO T_CODEBARRE(
		 codebarre
		,produit
		,code
		,ean13
		,cbu
	)
	VALUES(
		 :codebarre
		,:produit
		,:codebarre
		,1
		,0
	);
end;

/********************************************************************************************************/
/**************************************   PRODUITS - STOCK **********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_produit(
	codeCNK_prod int
	,designCNKFR_prod varchar(50)
	,designCNKNL_prod varchar(50)
	,categ_prod varchar(1)
	,prixvente float
	,labo varchar(4)
	,concess int
	,dateDernDeliv varchar(10)
	,usage_prod varchar(1)
	,tva float
	,commentairevente varchar(2000)
	,zoneGeo int
	,stkRay int
	,stkMinRay int
	,stkOptRay int     ------------ on commande de quoi atteindre le max une fois inf au min
	,zonegeoCave int
	,stkRes int
	,stkMinRes int
	,qtAComRes int
	,qteMaxRay int
	,qtMinAComDsRes int
	,qtRobot int
	,isRobot int
	,prixachatcatalogue float
	,typePrixBloque int
	,designationBloquee int
)

as
declare variable nomNL varchar(50);
declare variable nomFR varchar(50);
declare variable iStkRay int;
declare variable iStkMinRay int;
declare variable istkOptRay int;
declare variable iStkRes int;
declare variable iStkMinRes int;
declare variable iQtAComRes int;
declare variable iQteMaxRay int;
declare variable iQtMinAComDsRes int;
declare variable isDblStk int;
declare variable seuilMaxReappro int;
declare variable seuilMinReappro int;
declare variable qtGlobal int;
declare variable seuilMaxLGPI int;
declare variable seuilMinLGPI int;
declare variable dDernDeliv date;

begin

nomNL=designCNKNL_prod;
nomFR=designCNKFR_prod;
if (trim(nomNL)='') then
 nomNL = nomFR;
else if (trim(nomFR)='') then
 nomFR = nomNL;

execute procedure ps_conv_chaine_en_date_format(:dateDernDeliv,'AAAAMMJJ') returning_values :dDernDeliv;

iStkRay = stkRay;
iStkMinRay = stkMinRay;
istkOptRay= stkOptRay;
iStkRes = stkRes;
iStkMinRes = stkMinRes;
iQtAComRes = qtAComRes;
iQteMaxRay = qteMaxRay;
iQtMinAComDsRes = qtMinAComDsRes;

-- Gestion double stock si au moins une des 3 conditions suivantes est respectée:
--	1) Stk Réserve > 0
--	2) (Stk min réserve > 0 AND qte à commander > 0)
--	3) (Qte min à commander en réserve <= Stk min <= Stk max en rayon)
--	   AND Stock max en rayon > 0


--Le stock réserve n'est pas censé avoir une valeur négative (=> erreur d'une récupération précédente)
if (iStkRes < 0) then iStkRes = 0;
if (iStkRay < 0) then iStkRay = 0;


--------------------------------------------------------------****************** A RE VERIFIER
--Cas gestion double du stock : 1) Stk Réserve > 0    OU   2) (Stk min réserve > 0 AND qte à commander > 0)
if ((iStkRes > 0) OR ((iStkMinRes > 0) AND (iQtAComRes > 0))) then
	begin
	isDblStk = 1;
    if (iQteMaxRay > iQtMinAComDsRes) then
		begin
		seuilMaxReappro = iQteMaxRay;
        seuilMinReappro = iQteMaxRay - iQtMinAComDsRes;
		end
	else
		begin
		seuilMaxReappro = iQteMaxRay;
        seuilMinReappro = iQteMaxRay;
		end
	end
else
    isDblStk = 0;

--si stock double on additionne les stock
if (isDblStk = 1) then
	qtGlobal = iStkRay + iStkRes;
else
    qtGlobal = iStkRay;

if (qtGlobal >= 0) then
begin
   if (iStkMinRay > 0) then
   begin
		if (qtGlobal < iStkMinRay) then
		begin
			 --cas 1 - voir feuille  ****impossible ?
			 if (istkOptRay < (iStkMinRay - qtGlobal)) then
			 begin
				seuilMinLGPI = iStkMinRay - 1;
				seuilMaxLGPI = iStkMinRay; -- donc seuilMaxLGPI > 0
			 end

			 --cas 2 - voir feuille
			 else
			 begin
				seuilMinLGPI = iStkMinRay - 1;
				seuilMaxLGPI = qtGlobal + istkOptRay; -- donc seuilMaxLGPI > 0
			 end
		end
		else -- qtGlobal >= iStkMinRay
		begin
		   --cas 3 - voir feuille
		   if (istkOptRay >= (iStkMinRay - qtGlobal)) then
		   begin
			   seuilMinLGPI = iStkMinRay - 1; -- donc seuilMinLGPI >=0
			   if (istkOptRay > 0) then
				  seuilMaxLGPI = seuilMinLGPI + istkOptRay; --donc seuilMaxLGPI > 0
			   else
				  seuilMaxLGPI = seuilMinLGPI + 1;  --donc seuilMaxLGPI > 0
		   end
		   else
				--On gènère volontairement une insertion fausse pour remonter une erreur
				insert into t_stock(stock,produit ) values(:codeCNK_prod,'Cas non pris en compte: istkOptRay < (iStkMinRay - qtGlobal) => appeler le développeur !');

		end
   end

   --cas 4 - voir feuille
   -- Si il y a du stock et stkminray nul
   else if (iStkMinRay = 0) then
   begin
	   seuilMinLGPI = 0;
	   if (qtGlobal = 0) then
		  seuilMaxLGPI = 0;
	   else
	   begin
		  if (istkOptRay > 0) then
			 seuilMaxLGPI = istkOptRay;
		  else
			  seuilMaxLGPI = 0;           --cas ou min = max = 0
			 --seuilMaxLGPI = 1;
   ------------------------------------------------------------------------BUG dans l'autre prog pas pareil pour le seuil max si stock ou vente sup >3ans
	   end
   end
   else
		--On gènère volontairement une insertion fausse pour remonter une erreur
		insert into t_stock(stock,produit ) values(:codeCNK_prod,'Cas non pris en compte: Stk Min Rayon négatif => appeler le développeur!');

end
else --qte global stock négative
begin
	 qtGlobal = 0;
	 seuilMinLGPI = 0;           -- CAS maxi=0 et mini =0
	 seuilMaxLGPI = 0;
end

INSERT INTO T_PRODUIT(
		produit
		,codeCNK_prod
		,isPdtPropre
		,designCNKFR_prod
		,designCNKNL_prod
		,categ_prod
		,prixvente
		,labo
		,concess
		,dateDernDeliv
		,usage_prod
		,tva
		,commentairevente
		,prixachatcatalogue
		,stockmini
		,stockmaxi
		,typePrixBloque
		,designationBloquee
	)
VALUES(
		:codeCNK_prod
		,:codeCNK_prod
		,iif(:codeCNK_prod>100 and :codeCNK_prod<10000,'1','0')
		,:nomFR
		,:nomNL
		,iif(char_length(trim(:categ_prod))=1,:categ_prod,'S')
		,iif(:prixvente<:prixachatcatalogue,:prixachatcatalogue,:prixvente)
		,lpad(:labo,4,'0')
		,lpad(:concess,4,'0')
        ,:dDernDeliv
		,iif(char_length(trim(:usage_prod))=1,:usage_prod,null)
		,round(:tva, 0) --ok
		,substring(trim(f_rtf_vers_text(:commentairevente)) from 1 for 200)
		,:prixachatcatalogue
		,:seuilMinLGPI
		,:seuilMaxLGPI
		,case when :typePrixBloque=2 then 3
			when :typePrixBloque=3 then 2
			else 1
			end
		,:designationBloquee
		);

insert into t_stock (
	stock
	,produit
	,zoneGeo
	,depotvente
	,priorite
	,qteEnStk
	,depot
	,stkMin
	,stkMax
	)
values (
	:codeCNK_prod
	,:codeCNK_prod
	,:zoneGeo
	,'1'
	,'1'
	,iif(:isRobot=0,:iStkRay,:qtRobot)
	,iif(:isRobot=0,'1','3')
	,iif(:isDblStk=0,0,iif(:isRobot=0,:seuilMinReappro,0))
	,iif((:isDblStk=1 and :isRobot=0),:seuilMaxReappro,null)
);

if (isRobot=1) then
	insert into t_stock(
		stock
		,produit
		,zoneGeo
		,depotvente
		,priorite
		,qteEnStk
		,depot
		,stkMin
		,stkMax
		)
	values(
		:codeCNK_prod||'-1'
		,:codeCNK_prod
		,''
		,iif(:isDblStk=0,'0','1')
		,'2'
		,:iStkRay - :qtRobot
		,iif(:isDblStk=0,'2','1')
		,iif(:isDblStk=0,0,:seuilMinReappro)
		,iif(:isDblStk=0,null,:seuilMaxReappro)
	);


if (isDblStk=1) then
	insert into t_stock (
		stock
		,produit
		,zoneGeo
		,depotvente
		,priorite
		,qteEnStk
		,depot
		,stkMin
		,stkMax
		)
	values (
		:codeCNK_prod||'-2'
		,:codeCNK_prod
		,:zonegeoCave
		,'0'
		,'2'
		,:iStkRes
		,'2'
		,'0'
		,null
	);

end;

/********************************************************************************************************/
/**************************************   PRODUITS PEREMPTION  ******************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_produit_peremption(
      produit int
      ,datePeremption varchar(10)
)
as
declare variable pp varchar(50);
declare variable dperemption date;

begin
pp= cast( produit as varchar(50));
execute procedure ps_conv_chaine_en_date_format(:datePeremption ,'AAAAMMJJ') returning_values :dperemption;
update T_PRODUIT set datePeremption=:dperemption where produit=:pp;
end;

/********************************************************************************************************/
/**************************************   TARIF PRODUITS ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_tarif_produit(
      produit int,
      fou varchar(4),
	  typefou int 
)
as
begin
insert into T_TARIFPDT(
  tarifpdt,
  produit,
  fou,
  isRepart,
  isAttitre
)
values(
  next value for seq_tarif_produit,
 :produit,
 :fou,
 iif(:typefou=1,1,0),
 1
);
end;


/********************************************************************************************************/
/***********************************      Fournisseur - Repartiteurs   **********************************/
/********************************************************************************************************/
create or alter procedure ps_creer_fourep(
  NUMAPB dm_num_apb4
  ,NOM varchar(50)
  ,RUE varchar(50) --40
  ,CP varchar(10) --6
  ,VILLE varchar(50) --40
  ,TEL varchar(15)
  ,GSM varchar(15)
  ,FAX varchar(15)
  ,EMAIL varchar(100) --50
  ,TypeF int
  )
as
declare variable nb_prod integer;
declare variable code varchar(50);
Begin

select count(*)
from T_TARIFPDT
where fou=:NUMAPB
into :nb_prod;

select max(fournisseur)
from tr_fournisseur
where numapb=:NUMAPB
into :code;

if (Typef=2) then
		INSERT INTO T_FOURNISSEUR(
		   FOURNISSEUR
		  ,TR_FOURNISSEUR
		  ,NOMFOURN
		  ,RUEFOURN
		  ,LOCFOURN
		  ,CPFOURN
		  ,TEL
		  ,FAX
		  ,GSM
		  ,EMAIL
		  ,NUMAPB
		  ,NBPDTSASSOCIES
		)
		VALUES (
		   :NUMAPB
		  ,:code
		  ,:NOM
		  ,substring(:RUE from 1 for 40)
		  ,substring(trim(:VILLE) from 1 for 6)
		  ,substring(trim(:CP) from 1 for 6)
		  ,:TEL
		  ,:FAX
		  ,:GSM
		  ,substring(trim(:EMAIL) from 1 for 50)
		  ,:NUMAPB
		  ,:nb_prod
		);
else
		INSERT INTO T_REPARTITEUR(
		   repartiteur
		  ,nomRepart
		  ,rueRepart
		  ,locRepart
		  ,cpRepart
		  ,TEL
		  ,FAX
		  ,GSM
		  ,EMAIL
		  ,nbPdtsAssocies
		)
		VALUES (
		   :NUMAPB
		  ,:NOM
		  ,substring(:RUE from 1 for 40)
		  ,substring(trim(:VILLE) from 1 for 6)
		  ,substring(trim(:CP) from 1 for 6)
		  ,:TEL
		  ,:FAX
		  ,:GSM
		  ,substring(trim(:EMAIL) from 1 for 50)
		  ,:nb_prod
		);
End;

/********************************************************************************************************/
/**************************************   Credit Client  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_creditclient(
	 credit int
	,client int
	,montant float
	,datecredit varchar(10)
)
as
declare variable dcredit date;

begin

execute procedure ps_conv_chaine_en_date_format(:datecredit,'AAAAMMJJ') returning_values :dcredit;

insert into t_CREDIT(
 credit
,montant
,datecredit
,client
)
values(
 :credit
,:montant
,:dcredit
,:client
);
End;

/********************************************************************************************************/
/**************************************   DELDIF    *****************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_deldif(
	 deldif int
	,produit int
	,client int
	,medecin varchar(11)
	,noOrdon int
	,dateDeliv varchar(10)
	,qttDiff varchar(1)
--	,diff varchar(1)
--	,dateOrdon date = datedeliv
)
as
declare variable ddeliv date;

begin

execute procedure ps_conv_chaine_en_date_format(:dateDeliv,'AAAAMMJJ') returning_values :ddeliv;

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
,:ddeliv
,:ddeliv
,iif(:qttDiff similar to '[[:DIGIT:]]*', :qttDiff,1)
,:ddeliv
);
end;

/********************************************************************************************************/
/**************************************   AVANCE PRODUIT ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_avance_produit(
  litige int
 ,client int
 ,produit int
 ,qtedelivree int
 ,prixClient float -- Montant que le client paye (tva comprise) sans le montant payé par le tiers payant
 ,nomPdt varchar(50)
 ,dateVente varchar(10)
 ,cdbu varchar(16)
 ,gtin varchar(14)
 ,numero_serie varchar(20)
 ,typep int 
 )
as
declare variable dvente date;
declare variable comm varchar(500);
begin

execute procedure ps_conv_chaine_en_date_format(:dateVente,'AAAAMMJJ') returning_values :dvente;

-- si type = 3  avance produit magistrale
if (typep =3) then 
	begin
		comm = 'Avance Prd Mag : ';
		if (:nomPdt is not null) then comm = comm||qtedelivree||' * '||trim(:nomPdt);
		if (dvente is not null) then  comm = comm||'Date:'||substring(:dvente from 1 for 10);
		update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null,substring(:comm from 1 for 500), substring(COMMENTAIREINDIV||'  -  '||:comm from 1 for 500)) where client=:client;
		update t_client set COMMENTAIREBLOQU=1 where client=:client;
	end
else
	if (exists(select * from t_litige where litige = :litige)) then
		begin
			if ((cdbu is not null) and (trim(cdbu)<>'')) then 
				update t_litige set cdbu=cdbu||';'||:cdbu where litige = :litige;
	
			if ((gtin is not null) and (trim(gtin)<>'')
			
			 and (numero_serie is not null) and (trim(numero_serie)<>'')) then 
				update t_litige set gtin=gtin||';'||:gtin, numero_serie=numero_serie||';'||:numero_serie  where litige = :litige;
		end
	else
		insert into t_litige(
			litige
			,client
			,typeLitige  -- 1 => Manque ordonnance
			,nomPdt
			,produit
			,prixClient -- Montant que le client paye (tva comprise) sans le montant payé par le tiers payant
			,qtedelivree
			,dateVente
			,isFacture
			,cdbu
			,gtin
			,numero_serie
		)
		values(
			:litige
			,:client
			,1
			,:nomPdt
			,:produit
			,:prixClient
			,iif(:qtedelivree>0,iif(:qtedelivree>99,99,:qtedelivree),0)
			,:dvente
			,1
			,iif((:cdbu is not null) and (trim(:cdbu)<>'') ,:cdbu, null)
			,iif((:gtin is not null) and (trim(:gtin)<>'') and (:numero_serie is not null) and (trim(:numero_serie)<>''),:gtin, null) 
			,iif((:gtin is not null) and (trim(:gtin)<>'') and (:numero_serie is not null) and (trim(:numero_serie)<>'') ,:numero_serie, null)
		);
end;
/********************************************************************************************************/
/**************************************   Memo Patient  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_memopatient(
  memo int
  ,mem_type int
  ,patient int
  ,cnk_prd varchar(50)
  ,date_echeance varchar(10)
  ,qte int
  )
as
  declare variable comm varchar(500);
  declare variable blo int;
  declare variable decheance date;

begin
  execute procedure ps_conv_chaine_en_date_format(:date_echeance,'AAAAMMJJ') returning_values :decheance;
  
  comm = case
          when :mem_type = '2' then 'Attestation Manq. '
        end;

  if (cnk_prd<>'' and cnk_prd is not null) then comm = comm||'CNK: '||trim(:cnk_prd);
  if (qte<>0 and qte is not null) then comm = comm||' Qte: '||:qte;
  if (date_echeance is not null) then  comm = comm||' Date: '||:decheance;
  
  update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null or trim(COMMENTAIREINDIV)='',substring(:comm from 1 for 500),
         substring(COMMENTAIREINDIV||' - '||:comm from 1 for 500)) where client=:patient;

  update t_client set COMMENTAIREBLOQU=1 where client=:patient;

end;

/********************************************************************************************************/
/**************************************   HISTOVENTE   **************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histovente(
 histovente int
 ,speSerie int
 ,dateM varchar(2)
 ,dateA varchar(4)
 ,qteVendue int
 ,nbVentes int
)
as
begin
if (qteVendue>0) then
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
	 :histovente
	,:dateM
	,:dateA
	,'01/'||:dateM||'/'||:dateA
	,:speSerie
	,:qteVendue
	,:nbVentes
	);
end;

/********************************************************************************************************/
/**************************************   HISTODELGENERAL ***********************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histodelgeneral(
	 NumTicket int
	,patientID int
	,clientID int
	,facture int
	,date_acte varchar(24)    -- 04d-2012-11 19:13:54.000
	,nom_medecin varchar(40)
	,theTypeFactur int
	)
as
declare variable StrNom varchar(40);
declare variable StrPrenom varchar(40);
declare variable StrNjf varchar(40);
declare dacte date;
begin
execute procedure ps_separer_nom_prenom(:nom_medecin, ' ') returning_values :StrNom, :StrPrenom, :strNjf;
--execute procedure ps_conv_chaine_en_date_format(:date_acte,'AAAAMMJJ') returning_values :dacte;
--dacte = cast(substring(:date_acte from 5 for 4)||'-'||substring(:date_acte from 10 for 2)||'-'||substring(:date_acte from 1 for 2) as date);
--EXECUTE PROCEDURE "PS_CREER_HISTODELGENERAL" (189955,11086,0,0,'04/01/2017 10:12:27',null,1)
--04/01/2017 10:12:27
dacte = cast(substring(:date_acte from 7 for 4)||'-'||substring(:date_acte from 4 for 2)||'-'||substring(:date_acte from 1 for 2) as date);

if (patientID>0 or clientID>0) then
	insert into T_HISTODELGENERAL(
		 histodelgeneral
		,clientID
		,facture
		,date_acte
		,date_prescription
		,nom_medecin
		,prenom_medecin
		,theTypeFactur -- 2 => Ordonnance, 3 => Vte Directe
	)
	values(
		:NumTicket||'-'||:patientID||'-'||:clientID||'-'||:facture||'-'||:theTypeFactur
		,iif(:patientID>0,:patientID,'99999'||:clientID)
		,:facture
		,:dacte
		,:dacte
		,:StrNom
		,:StrPrenom
		,iif(:theTypeFactur=1,3,2)
	);
end;

/********************************************************************************************************/
/**************************************  Histo Details   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histodeldetails(
    histodeldetails int
	,NumTicket int
	,patientID int
	,clientID int
	,facture int
	,theTypeFactur int	
    ,cnkProduit int
    ,designation varchar(50)
    ,qteFacturee int
    ,prixVte float
)
as
begin
if ((qteFacturee>=0) and (patientID>0 or clientID>0)) then
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
	  ,:NumTicket||'-'||:patientID||'-'||:clientID||'-'||:facture||'-'||:theTypeFactur
	  ,:cnkProduit
	  ,:designation
	  ,:qteFacturee
	  ,:prixVte
	  ,:cnkProduit
	);
end;

/********************************************************************************************************/
/**************************************  Histo Magistrale   ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_histodelmagistrale(
     histodelmagistrale int
	,NumTicket int
	,patientID int
	,clientID int
	,facture int
	,theTypeFactur int	
    ,designation varchar(50)
    ,qteFacturee int	
	,forme varchar(2)
	,qtfaire float
	,cnkProduit int
    ,libproduit varchar(50)
	,complement int ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
	,qtprep float ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
	,unite int ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
	,qte_gr float ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
	,qte_a_pesee float ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
)
as
declare variable nb integer;
begin
nb=0;
if ((qteFacturee>=0) and (patientID>0 or clientID>0)) then
	begin
		select 1 from rdb$database where EXISTS(select * from t_HISTODELMAGISTRALE where HISTODELMAGISTRALE=:histodelmagistrale) into:nb;
		if (nb=0) then
			insert into T_HISTODELMAGISTRALE(
			   histodelmagistrale
			  ,histodelgeneralID
			  ,designation
			  ,qteFacturee
			  ,detail
			  ,clemag
			)
			values(
			   :histodelmagistrale
			  ,:NumTicket||'-'||:patientID||'-'||:clientID||'-'||:facture||'-'||:theTypeFactur
			  ,:designation
			  ,:qteFacturee
			  ,substring((:forme||';'||:qtfaire||'<BR>'||lpad(:cnkProduit,7,'0')||';'||trim(:libproduit)||';'||trim(:complement)||';'||:qtprep||';'||:unite||';'||:qte_gr||';'||:qte_a_pesee||'<BR>') from 1 for 4000)
			  ,:histodelmagistrale
			);
		else
			update T_HISTODELMAGISTRALE
			set detail = substring((detail||lpad(:cnkProduit,7,'0')||';'||trim(:libproduit)||';'||trim(:complement)||';'||:qtprep||';'||:unite||';'||:qte_gr||';'||:qte_a_pesee||'<BR>') from 1 for 4000)
			where histodelmagistrale=:histodelmagistrale;
	end
end;



create or alter procedure ps_creer_schema_produit(
	t_sch_medication_produit_id int,
	t_produit_id int,
	t_aad_id int,
	date_debut date,
	date_fin date,
	commentaire varchar(200),
	libelle varchar(50)
) as --declare variable comm varchar(500);
begin
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
		null,
		null,
		substring(:commentaire from 1 for 200),
		substring(:libelle from 1 for 50),
		1
	);

update t_client set SCH_POSOLOGIE = 1 where client = :t_aad_id;

end;


CREATE PROCEDURE PS_CREER_SCHEMA_PRISE
 (
  SCHEMA_ID Integer, 
  TYPESCHEMA Integer, 
	FREQUENCE Integer,
	TYPE_FREQUENCE Integer,
  JOUR_SEMAINE1 Integer, 
  JOUR_SEMAINE2 Integer, 
  JOUR_SEMAINE3 Integer, 
  JOUR_SEMAINE4 Integer, 
  JOUR_SEMAINE5 Integer, 
  JOUR_SEMAINE6 Integer, 
  JOUR_SEMAINE7 Integer, 
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
declare variable FREQUENCE_JOURS varchar(7);
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

FREQUENCE_JOURS = '0000000'; 

if (JOUR_SEMAINE1 <> 0) then BEGIN 
  FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from 1);
END 

if (JOUR_SEMAINE2 <> 0) then BEGIN 
  FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from 2);
END 

if (JOUR_SEMAINE3 <> 0) then BEGIN 
  FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from 3);
END 

if (JOUR_SEMAINE4 <> 0) then BEGIN 
  FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from 4);
END 

if (JOUR_SEMAINE5 <> 0) then BEGIN 
  FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from 5);
END 

if (JOUR_SEMAINE6 <> 0) then BEGIN 
  FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from 6);
END 

if (JOUR_SEMAINE7 <> 0) then BEGIN 
  FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from 7);
END

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
    LIBELLE_HEURE1
  )
values
  (
    :SCHEMA_ID,
    :SCHEMA_ID,
    case when :TYPE_FREQUENCE = 1 then 1 when  :TYPE_FREQUENCE = 2 then 3 when  :TYPE_FREQUENCE = 3 then 4 else 1 end, 
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
    '2000'
  );
End;

create or alter procedure ps_nextpharm_upd_pha_ref(
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
/**************************************   fiche analyse  ************************************************/
/********************************************************************************************************/
/*create or alter procedure ps_creer_ficheanalyse(
--   fiche_analyse_id dm_code NOT NULL
   no_analyse int
  ,cnk_produit int
  ,no_autorisation varchar(20)
  ,ReferenceAnalytique varchar(20)
  ,date_entree varchar(8)
  ,fabricant_id varchar(4)
  ,grossiste_id varchar(4)
  ,no_lot varchar(20)
  ,prix_achat_total float
 -- ,cnk_lie dm_varchar7 NOT NULL
  ,no_bon_livraison varchar(20)
  ,date_ouverture varchar(8)
  ,date_peremption varchar(8)
  ,date_fermeture varchar(8)
--  ,etat dm_numeric1 DEFAULT 0
  ,quantite_initial float
--  ,quantite_restante dm_float7_2
  ,remarques varchar(5000)
--  ,datemaj dm_dateheure NOT NULL
)
as
declare variable dentree date;
declare variable douverture date;
declare variable dperemption date;
declare variable dfermeture date;

begin

execute procedure ps_conv_chaine_en_date_format(:date_entree,'AAAAMMJJ') returning_values :dentree;
execute procedure ps_conv_chaine_en_date_format(:date_ouverture,'AAAAMMJJ') returning_values :douverture;
execute procedure ps_conv_chaine_en_date_format(:date_peremption,'AAAAMMJJ') returning_values :dperemption;
execute procedure ps_conv_chaine_en_date_format(:date_fermeture,'AAAAMMJJ') returning_values :dfermeture;

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
  ,remarques
  ,datemaj
)
values(
   :no_analyse
  ,:no_analyse
  ,:cnk_produit
  ,:no_autorisation
  ,:ReferenceAnalytique
  ,coalesce(:dentree, coalesce(:douverture,current_date))
  ,:fabricant_id
  ,:grossiste_id
  ,:no_lot
  ,iif(:quantite_initial=0,:prix_achat_total,:prix_achat_total/:quantite_initial)
  ,:no_bon_livraison
  ,:douverture
  ,:dperemption
  ,:dfermeture
  ,iif(:dfermeture is not null or :quantite_initial=0,2,iif(:douverture is not null,1,0))
  ,:quantite_initial
  ,:quantite_initial
  ,substring(:remarques from 1 for 500)
  ,current_date
);
end;*/