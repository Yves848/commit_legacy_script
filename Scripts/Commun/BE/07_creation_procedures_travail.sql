set sql dialect 3;

/******************************************************************************/
create or ALTER PROCEDURE SELECTFOURNISSEUR
RETURNS(
  AFOURNISSEUR VARCHAR(50),
  ANUMAPB dm_num_apb4,
  ANOM VARCHAR(150) ,
  ARUE VARCHAR(300) ,
  ACP VARCHAR(6) ,
  ALOCALITE VARCHAR(50) ,
  ATR_FOURNISSEUR VARCHAR(50) ,
  ACOUNT INTEGER)
AS
BEGIN
for select fournisseur,
		       numapb,
           nomfourn,
           coalesce(Ruefourn,'')||' '||coalesce(rue2fourn,''),
           cpfourn,
           locfourn,
           tr_fournisseur,
           nbPdtsAssocies
           from t_fournisseur into
           :AFOURNISSEUR,
		       :ANUMAPB,
           :ANOM,
           :ARUE,
           :ACP,
           :ALOCALITE,
           :ATR_FOURNISSEUR,
           :ACOUNT do
 Begin
  SUSPEND;
 End
END;


/******************************************************************************/
create or ALTER PROCEDURE SELECTREPARTITEUR
RETURNS(
  AREPARTITEUR VARCHAR(50) ,
  ANOM VARCHAR(150) ,
  ARUE VARCHAR(300) ,
  ACP VARCHAR(5) ,
  ALOCALITE VARCHAR(50) ,
  ATR_REPARTITEUR VARCHAR(50) ,
  ACOUNT INTEGER)
AS
BEGIN
for select repartiteur,
           nomrepart,
           coalesce(Ruerepart,'')||' '||coalesce(rue2repart,''),
           cprepart,
           locrepart,
           TR_repartiteur,
           nbPdtsAssocies
           from T_REPARTITEUR into
           :AREPARTITEUR,
           :ANOM,
           :ARUE,
           :ACP,
           :ALOCALITE,
           :ATR_REPARTITEUR,
           :ACOUNT    do
begin
  SUSPEND;
end
END;

/******************************************************************************/
create or ALTER PROCEDURE SELECTREFERENCEANALYTIQUE
RETURNS(
	AREFERENCEANALYTIQUE VARCHAR(50)
	,ATR_REFERENCEANALYTIQUE varchar(10)
  )
AS
BEGIN
for select distinct F.REFERENCEANALYTIQUE
           ,F.TR_REFERENCEANALYTIQUE
    from T_FICHEANALYSE F
	into	:AREFERENCEANALYTIQUE
			,:ATR_REFERENCEANALYTIQUE
			DO
begin
  SUSPEND;
end
END;

/******************************************************************************/
create or ALTER PROCEDURE CONVFOURNISSEUR
AS
 DECLARE VARIABLE ANUMAPB dm_num_apb4 ;
 DECLARE VARIABLE AFOURNISSEUR VARCHAR(50) ;
 DECLARE VARIABLE ATR_FOURNISSEUR VARCHAR(50) ;
BEGIN
 for select
   fournisseur
  ,tr_fournisseur
  ,numAPB
 from
  t_fournisseur
 into
   :AFOURNISSEUR
  ,:ATR_FOURNISSEUR
  ,:ANUMAPB
 do
 begin

  IF ((:ATR_FOURNISSEUR IS NULL) and (:ANUMAPB IS NOT NULL)) then
  BEGIN
  	select fournisseur FROM tr_fournisseur WHERE numapb = :ANUMAPB INTO :ATR_FOURNISSEUR;
  	UPDATE t_fournisseur SET tr_fournisseur = :ATR_FOURNISSEUR WHERE fournisseur = :AFOURNISSEUR;
	 END
 END
END;

/******************************************************************************/
create or ALTER PROCEDURE CONVREPARTITEUR
AS
 DECLARE VARIABLE AREPARTITEUR VARCHAR(50) ;
 DECLARE VARIABLE ANOM VARCHAR(150) ;
 DECLARE VARIABLE ATR_REPARTITEUR VARCHAR(50) ;
BEGIN
 for select
   repartiteur
  ,nomrepart
  ,TR_repartiteur
 from T_REPARTITEUR into
   :AREPARTITEUR
  ,:ANOM
  ,:ATR_REPARTITEUR
 do
 begin
  IF ((:ATR_REPARTITEUR IS NULL) and (:ANOM IS NOT NULL)) then
  BEGIN
  	select repartiteur FROM tr_repartiteur WHERE trim(nomrepart) = trim(:ANOM) INTO :ATR_REPARTITEUR;
  	UPDATE t_repartiteur SET TR_repartiteur = :ATR_REPARTITEUR WHERE repartiteur = :AREPARTITEUR;
  END
 end
END;

/******************************************************************************/
create or ALTER PROCEDURE CONVREFERENCEANALYTIQUE
AS
	 DECLARE VARIABLE AREFERENCEANALYTIQUE VARCHAR(50);
	 DECLARE VARIABLE ATR_REFERENCEANALYTIQUE varchar(10);
BEGIN
for select distinct
	REFERENCEANALYTIQUE
	,TR_REFERENCEANALYTIQUE
from T_FICHEANALYSE
into
	:AREFERENCEANALYTIQUE
	,:ATR_REFERENCEANALYTIQUE
do
	begin
		IF (:ATR_REFERENCEANALYTIQUE IS NULL) then
			BEGIN
				select first 1 REFERENCEANALYTIQUE FROM tr_REFERENCEANALYTIQUE_INDEX
					WHERE REFERENCEANALYTIQUE_IMPORT = lower(replace(replace(:AREFERENCEANALYTIQUE,'.',''),' ','')) INTO :ATR_REFERENCEANALYTIQUE;
				UPDATE T_FICHEANALYSE SET TR_REFERENCEANALYTIQUE = :ATR_REFERENCEANALYTIQUE
					WHERE trim(REFERENCEANALYTIQUE) = trim(:AREFERENCEANALYTIQUE);
			END
	 end
END;

/******************************************************************************/
create or ALTER PROCEDURE MAJFOURNISSEUR(
  AFOURNISSEUR VARCHAR(50) ,
  ATR_FOURNISSEUR VARCHAR(50) )
AS
BEGIN
     update t_fournisseur
     set tr_fournisseur=:ATR_FOURNISSEUR
     where fournisseur=:AFOURNISSEUR;

END;

/******************************************************************************/
create or ALTER PROCEDURE MAJREPARTITEUR(
  AREPARTITEUR VARCHAR(50) ,
  ATR_REPARTITEUR VARCHAR(50) )
AS
BEGIN
     update t_repartiteur
     set tr_repartiteur=:ATR_REPARTITEUR
     where repartiteur=:AREPARTITEUR;

END;

/******************************************************************************/
create or ALTER PROCEDURe MAJREFERENCEANALYTIQUE(
  AREFERENCEANALYTIQUE VARCHAR(50) ,
  ATR_REFERENCEANALYTIQUE varchar(10))
AS
BEGIN
     update T_FICHEANALYSE
     set tr_REFERENCEANALYTIQUE=:ATR_REFERENCEANALYTIQUE
     where REFERENCEANALYTIQUE=:AREFERENCEANALYTIQUE;

END;

/**************************************************************/
create or alter procedure RechercheFournisseur
returns (
	code varchar(50),
	nom varchar(50),
	rue varchar(50),
	codepostal varchar(10),
	localite varchar(40))
as
begin
	for SELECT fournisseur,
						 nomFourn,
						 rueFourn,
						 cpFourn,
						 locFourn
			FROM tr_fournisseur
			ORDER BY nomFourn ASC
			INTO 	:code,
       			:nom,
       			:rue,
       			:codepostal,
       			:localite
  do
	suspend;
END;


/******************************************************************************/
create or alter procedure RechercheRepartiteur
returns (
  code varchar(50),
	nom varchar(50),
	rue varchar(40),
	codepostal varchar(10),
	localite varchar(40))
as
begin
  for select repartiteur,
         nomRepart,
         rueRepart,
         cpRepart,
         locRepart
  from tr_repartiteur
  ORDER BY nomRepart ASC
  into :code,
       :nom,
       :rue,
       :codepostal,
       :localite
  do
  suspend;
END;

/******************************************************************************/
create or alter procedure RechercheREFERENCEANALYTIQUE
returns (
  REFERENCEANALYTIQUE varchar(10),
	NOM varchar(50))
as
begin
  for select REFERENCEANALYTIQUE,
         NOM
  from tr_REFERENCEANALYTIQUE
  ORDER BY REFERENCEANALYTIQUE ASC
  into :REFERENCEANALYTIQUE,
       :NOM
  do
  suspend;
END;

/********************************************************************************************************/
/**************************************   LIENF   *******************************************************/
/********************************************************************************************************/
create or alter procedure PS_UPDATE_LIENF
as
begin --met à jour la famille pour les hcef de famille
 update t_client c1 set c1.idfamille=c1.client where c1.idfamille is null and c1.client =
 (SELECT c2.idfamille from t_client c2 where c2.idfamille=c1.client group by c2.idfamille);
end;

/********************************************************************************************************/
/**************************************   DEPOT ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_depot
as
begin
	--delete  from t_depot;
	if ((select count(*) from t_depot)<3) then
        begin
		if ((select count(*) from t_depot where upper(libelle)='PHARMACIE')=0) then
			INSERT INTO t_depot (depot,libelle,automate) VALUES('1','PHARMACIE',NULL);
		if ((select count(*) from t_depot where upper(libelle)='RESERVE')=0) then
			INSERT INTO t_depot (depot,libelle,automate) VALUES('2','RESERVE',NULL);
		if ((select count(*) from t_depot where upper(libelle)='ROBOT')=0) then
			INSERT INTO t_depot (depot,libelle,automate) VALUES('3','ROBOT',NULL);
	end
end;

/**************************************  MAJ PRIORITE STOCK ************************************************/
create or alter procedure ps_maj_priorite_stock
as
begin --met la priorite à 1 quand le produit n'a qu'un stock et priorite=2
	update T_STOCK set priorite = 1 where priorite = 2 and produit not in 
	(select produit
	from T_STOCK group by produit
	having (count(produit) > 1)
	);
end;

/**************************************  Ajout flag schema posologie dans clients ****************************/
create or alter procedure ps_ajout_schema_poso_client
as 
begin
	update T_CLIENT set SCH_POSOLOGIE=1 where client in (select t_aad_id from t_sch_medication_produit);
end;
