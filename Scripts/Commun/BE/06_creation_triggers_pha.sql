set sql dialect 3;

CREATE GENERATOR t_profilremisesuppl_GenId;

CREATE OR ALTER TRIGGER trig_profilremise FOR t_profilremise
ACTIVE BEFORE INSERT AS
BEGIN
	IF (NEW.TYPERISTOURNE <> 0 AND NEW.TYPERISTOURNE <>1 ) THEN
		NEW.TYPERISTOURNE = 0;
END;

CREATE OR ALTER TRIGGER trig_profilremisesuppl_GenId FOR t_profilremisesuppl
ACTIVE BEFORE INSERT AS
BEGIN
	IF (NEW.profilremisesuppl IS NULL) THEN
		NEW.profilremisesuppl = GEN_ID(t_profilremisesuppl_GenId,1);
END;

create or alter trigger trg_prat_mise_en_forme for t_medecin
active before insert or update as
begin
  if ((new.prenom is null) or (new.prenom = '')) then new.prenom = '_';
  if (new.ismedfront like '1') then new.identifiant = '10000007999';
  if ((new.CODEPAYS is null) or (new.CODEPAYS = '')) then new.CODEPAYS = 'BE';
  
  new.identifiant = replace(new.identifiant,' ','0');
  new.matricule = replace(new.matricule,' ','0');
  new.codespec = replace(new.codespec,' ','0');
  
  new.nom = upper(new.nom);
  new.prenom = f_maj_lettre_1(new.prenom);
end;

CREATE OR ALTER TRIGGER trig_t_carterist FOR t_carterist
ACTIVE BEFORE INSERT AS
BEGIN
	IF(NEW.virtuel IS NULL or NEW.virtuel like '') THEN
		NEW.virtuel = '0';
	IF(NEW.dateEmis is null or NEW.dateEmis like'') THEN
		NEW.dateEmis ='2000/01/01';
	IF(NEW.cliID is null or NEW.cliID ='0') then 
		NEW.cliID = (select max(c.cliID) from t_compte c where c.compte = NEW.compteID);
END;

--valeur par defaut du liberval si =0 selon le type
CREATE OR ALTER TRIGGER trig_t_compte FOR t_compte
ACTIVE BEFORE INSERT AS
BEGIN
	if(new.liberval = '0' ) then
		new.liberval = case
                    when new.libertype='1' then '5'
                    when new.libertype='2' then '10'
                    when new.libertype='3' then '0101'
                    when new.libertype='4' then '5'
                    else null
                  end;
end;


CREATE OR ALTER TRIGGER trig_t_client FOR t_client
ACTIVE BEFORE INSERT AS
BEGIN
	new.nom = upper(new.nom);
 new.prenom1 = f_maj_lettre_1(new.prenom1);
 
	--Passe le niss null si doublon
	if ((NEW.niss is not null) and (TRIM(NEW.niss) not like '')) then
		 if (exists(select * from t_client
				 where niss = new.niss)) then
			  NEW.niss = null;


	IF (NEW.ETAT not in ('0','1','2','3')) THEN
		NEW.ETAT = '0';
	IF (NEW.sexe IS NULL or NEW.sexe like '') THEN
	  NEW.SEXE = '0';
	IF (NEW.CODEPAYS IS NULL or NEW.CODEPAYS like '') THEN
	  NEW.CODEPAYS = 'BE';
	IF (NEW.collectivite IS NULL or NEW.collectivite like '') THEN
	  NEW.collectivite = '0';

	IF (NEW.numgroupe ='0') THEN
	  NEW.numgroupe = null;
	IF (NEW.IDFamille like '' or NEW.IDFamille ='0') THEN
	  NEW.IDFamille = null;
	IF ((NEW.collectivite IS NOT NULL) AND (NEW.collectivite like '1')) THEN 	
	BEGIN
		IF (NEW.EDITIONIMMEDIATE is null) THEN
		--La condition est rajouté pour multipharma, pour éviter de passer dans ce triggers et parce que ieditionimmediate n'est pas utilisé dans d'autrs module 
			NEW.PAYEUR = 'C';
		
		NEW.TYPEPROFILFACTURATION = '2';
		NEW.COPIESCANEVASFACTURE = '1';
	END

	IF (NEW.langue IS NULL or NEW.langue like '') THEN
	  NEW.langue = '0';

		--validité carte sis  
	
	IF ((NEW.NUMEROCARTESIS NOT SIMILAR TO '[[:DIGIT:]]*') OR (trim(NEW.NUMEROCARTESIS) = '')) THEN
		NEW.NUMEROCARTESIS = NULL;
		  
	IF (NEW.NATPIECEJUSTIFDROIT LIKE '1') THEN --1 =  Bulletin salaire,attestation droits,prise en charge
	BEGIN
		IF ((NEW.CT1 IS NULL) OR (NEW.CT2 IS NULL) OR (NEW.DATEFINOA IS NULL)) THEN  --(NEW.MATOA IS NULL) OR
		BEGIN
			NEW.OA = NULL;
			NEW.MATOA = NULL;
			NEW.CT1 = NULL;
			NEW.CT2 = NULL;
			NEW.DATEDEBOA = NULL;
			NEW.DATEFINOA = NULL;
		END
		ELSE IF (NEW.DATEDEBOA IS NULL) THEN
		BEGIN
			NEW.DATEDEBOA = '01/01/1900';
		END
	END
	ELSE IF (NEW.NATPIECEJUSTIFDROIT LIKE '2') THEN --2 =  Attestation carte assuré,consultation télématique
	BEGIN
		NEW.CERTIFICAT = NULL; /* derniere modif */
		IF ((NEW.CT1 IS NULL) OR (NEW.CT2 IS NULL) OR (NEW.DATEFINOA IS NULL) OR (NEW.DATENAISSANCE IS NULL)
		OR (NEW.NOM IS NULL) OR (NEW.PRENOM1 IS NULL) OR (NEW.SEXE LIKE '0')) THEN   --(NEW.MATOA IS NULL) OR
		BEGIN
			NEW.OA = NULL;
			NEW.MATOA = NULL;
			NEW.CT1 = NULL;
			NEW.CT2 = NULL;
			NEW.NATPIECEJUSTIFDROIT = 0; /* derniere modif */
		END
		ELSE
		BEGIN
			IF (NEW.DATEDEBOA IS NULL) THEN
			BEGIN
				NEW.DATEDEBOA = '01/01/1900';
			END

			IF (NEW.DATEDEBUTVALIDITEPIECE IS NULL) THEN
			BEGIN
				NEW.DATEDEBUTVALIDITEPIECE = '01/01/1900';
			END

			IF (NEW.DATEFINVALIDITEPIECE IS NULL) THEN
			BEGIN
				NEW.DATEFINVALIDITEPIECE = NEW.DATEFINOA;
			END
		END
	  END
  /*ELSE IF (NEW.NATPIECEJUSTIFDROIT LIKE '0') THEN
  BEGIN
    --Les ONIG n ont pas de documents d assurabilite (ils viennent à la pharmacie
    --avec des ordonnances spécifiques (roses))
    IF (NEW.OA LIKE '994') THEN
    BEGIN
      IF ((NEW.MATOA IS NULL) OR (NEW.CATOA IS NULL)) THEN
      	NEW.OA = NULL;
		END
		ELSE
  		NEW.OA = NULL;
  END*/

	/*IF (NEW.MATAT IS NULL) THEN
	BEGIN
		NEW.OAT = NULL;
  	NEW.MATAT = NULL;
  	NEW.CATAT = NULL;
  	NEW.DATEDEBAT = NULL;
  	NEW.DATEFINAT = NULL;
	END*/

	/*IF (NEW.MATOC IS NULL) THEN
	BEGIN
		NEW.OC = NULL;
  	NEW.MATOC = NULL;
  	NEW.CATOC = NULL;
  	NEW.DATEDEBOC = NULL;
  	NEW.DATEFINOC = NULL;
	END*/

	IF (NEW.COMMENTAIREBLOQU IS NULL OR NEW.COMMENTAIREBLOQU like '') THEN
		NEW.COMMENTAIREBLOQU = '0';

  if ((new.occpas is not null) and ((new.matoc is null) or (new.matoc = ''))) then
    new.matoc = lpad(new.matoc, 13, '0');

	IF (NEW.NB_TICKET_NOTEENVOI <0 or NEW.NB_TICKET_NOTEENVOI is null ) THEN
	  NEW.NB_TICKET_NOTEENVOI = 0;
	
	IF (NEW.NB_ETIQ_NOTEENVOI <0 or NEW.NB_ETIQ_NOTEENVOI is null) THEN
	  NEW.NB_ETIQ_NOTEENVOI = 0;
	
END;

create or alter trigger trg_pat_pat_mise_en_forme for t_patient_pathologie
active before insert or update
as
begin
  new.t_patient_pathologie_id = next value for seq_patient_pathologie;
  new.pathologie = upper(new.pathologie);
end;

create or alter trigger trg_pat_all_atc_mise_en_forme for t_patient_allergie_atc
active before insert or update
as
begin
  new.t_patient_allergie_atc_id = next value for seq_patient_allergie_atc;
  new.classification_atc = upper(new.classification_atc);
end;

CREATE OR ALTER TRIGGER trig_t_attestation FOR t_attestation
ACTIVE BEFORE INSERT AS
BEGIN
	/* Categories Remb. : (A => 1),(B => 2),(C => 3),(S => 4),(X => 5),(D => 6),(G => 7) */
	IF ((NEW.catRemb IS NOT NULL) AND ((NEW.catRemb < 1) OR (NEW.catRemb > 9)) AND NEW.catRemb <> 99) THEN
		NEW.catRemb = 99;

	/* Conditions Remb. : (' ' => 1),(? => 2),(N => 3),(V => 4),(A => 5),(I => 6),(E => 7),(K => 8),
                          (T => 9),(J => 10) */
 IF ((NEW.condRemb IS NOT NULL) AND ((NEW.condRemb < 1) OR (NEW.condRemb > 11)) AND NEW.condRemb <> 99) THEN
		NEW.condRemb = 99;

 IF (NEW.scanne IS NULL) THEN
 	NEW.scanne = '0';

 IF (NEW.nbCond >99) THEN
 	NEW.nbCond = 99;

IF (NEW.nbMaxCond >99) THEN
 	NEW.nbMaxCond = 99;
		
END;

CREATE OR ALTER TRIGGER trig_T_ORGANISMECPAS FOR T_ORGANISMECPAS
ACTIVE BEFORE INSERT AS
BEGIN
 IF (NEW.dlg_mttclient_cpas <> '0' AND NEW.dlg_mttclient_cpas <> '1') THEN
 	NEW.dlg_mttclient_cpas = '0';
END;

CREATE OR ALTER TRIGGER trig_t_stock FOR t_stock
ACTIVE BEFORE INSERT AS
BEGIN

  IF ((NEW.depot IS NULL) OR (NEW.depot like '')) then
   NEW.depot = 'PHARMACIE';

  IF ((NEW.depotvente IS NULL) OR (NEW.depotvente like '')) then
   NEW.depotvente = '1';

  IF ((NEW.priorite IS NULL) OR (NEW.priorite like '')) then
   NEW.priorite = 1;

  IF ((NEW.qteEnStk IS NULL) OR (NEW.qteEnStk like '')) then
   NEW.qteEnStk = 0;
  ELSE IF (NEW.qteEnStk <0) THEN
	BEGIN
		update t_produit p set p.commentairevente = substring('Produit en stock negatif ( '||new.qteEnStk||' ) lors de la reprise fichier. '||p.commentairevente from 1 for 200)
			where p.produit = new.produit;
		NEW.qteEnStk = 0;		
	END

  IF ((NEW.stkMin IS NULL) OR (NEW.stkMin like '') or (new.stkmin < 0)) then
  begin  
    if (new.stkmin < 0) then
      new.stkmax = new.stkmax - new.stkmin;
    NEW.stkMin = 0;
  end

  IF ((NEW.stkMax IS NOT NULL) AND (NEW.stkMax like '0')) then
   NEW.stkMax = NULL;
END;


CREATE OR ALTER TRIGGER trig_t_tarifpdt FOR t_tarifpdt
ACTIVE BEFORE INSERT AS
BEGIN

  IF ((NEW.remise IS NULL) OR (NEW.remise like '')) then
   NEW.remise = 0;

  IF ((NEW.prxAchtRemise IS NULL) OR (NEW.prxAchtRemise like '')) then
   NEW.prxAchtRemise = NEW.prxAchat;

  IF ((NEW.gereofficentral IS NULL) OR (NEW.gereofficentral like '')) then
   NEW.gereofficentral = '0';

END;


CREATE OR ALTER TRIGGER trig_t_histodelgeneral FOR t_histodelgeneral
ACTIVE BEFORE INSERT AS
BEGIN
	IF ((NEW.codeOperateur IS NULL) OR (NEW.codeOperateur like '')) then
		NEW.codeOperateur = '.';
	IF (NEW.facture IS NULL) then
		NEW.facture = 0;
		
END;


CREATE OR ALTER TRIGGER trig_t_transactrist FOR T_TRANSACTIONRIST
ACTIVE BEFORE INSERT AS
BEGIN
	IF ((NEW.tauxTVA IS NULL) OR (NEW.tauxTVA like '') OR (NEW.tauxTVA <> '6' and NEW.tauxTVA <> '12' and NEW.tauxTVA <> '21')) THEN
   NEW.tauxTVA = 6;
   
  IF ((NEW.justificatif IS NULL) OR (NEW.justificatif like '')) THEN
  	NEW.justificatif = 'REPRISE DONNEES';
END;


CREATE OR ALTER TRIGGER trig_t_produit FOR t_produit
ACTIVE BEFORE INSERT AS
BEGIN

 IF (new.codeCNK_prod not similar to '[[:DIGIT:]]*') THEN
	BEGIN
		NEW.commentairevente = NEW.commentairevente||' - CNK: '||NEW.codeCNK_prod;
		NEW.codeCNK_prod = null;
	END

 IF ((NEW.categ_prod IS NULL) OR (NEW.categ_prod like '')) then
   NEW.categ_prod = 'O';
 ELSE IF (NOT ((NEW.categ_prod like 'S') OR (NEW.categ_prod LIKE 'H') OR (NEW.categ_prod LIKE 'C') OR
      (NEW.categ_prod like 'E') OR (NEW.categ_prod like 'M') OR (NEW.categ_prod like 'B') OR
      (NEW.categ_prod like 'I') OR (NEW.categ_prod like 'A') OR (NEW.categ_prod like 'R') OR
      (NEW.categ_prod like 'F') OR (NEW.categ_prod like 'G') OR (NEW.categ_prod like 'T') OR
      (NEW.categ_prod like 'D'))) THEN
   NEW.categ_prod = 'O';


	IF ((NEW.usage_prod IS NULL) OR (NEW.usage_prod like '')) THEN
	BEGIN
		IF (NEW.categ_prod LIKE 'E') then
			NEW.usage_prod = 'E';  /* Usage entretien surface et matériel */
		ELSE IF (NEW.categ_prod LIKE 'F') then
			NEW.usage_prod = 'F';  /* Usage Phytopharmacie */
		ELSE
		NEW.usage_prod = 'H';  /* usage humain */

	/*comme la catégorie vétérinaire de farmix n'est plus reprise ds LGPI en tant que catégorie mais est en tant qu'usage
	on fixe direct usage_prod = 'V' ds le delphi */
	END


	IF ((NEW.codeCNK_prod IS NULL) OR (NEW.codeCNK_prod like '')) THEN
		NEW.isPdtPropre = 1;

	IF ((NEW.isPdtPropre IS NOT NULL) AND (NEW.isPdtPropre like '1')) THEN
	BEGIN
		--NEW.codeCNK_prod = NULL;
		NEW.categ_prod = 'O';
		NEW.usage_prod = 'H';
		NEW.baseremboursement = NEW.prixvente;
	END


  IF ((NEW.statuscomm_prod IS NULL) OR (NEW.statuscomm_prod like '')) THEN
    NEW.statuscomm_prod = 'M';  /*M = Sur le marché */
  ELSE IF (NOT ((NEW.statuscomm_prod = 'M') OR (NEW.statuscomm_prod = 'S') OR (NEW.statuscomm_prod = 'I')
   OR (NEW.statuscomm_prod = 'O') OR (NEW.statuscomm_prod = 'U'))) THEN
    NEW.statuscomm_prod = 'M';

  IF ((NEW.tva IS NULL) OR (NEW.tva <> 6 and NEW.tva <> 12 and NEW.tva <> 21)) THEN
   NEW.tva = 6;

  IF ((NEW.prixvente IS NULL) OR (NEW.prixvente like '')) THEN
  	NEW.prixvente = 0;

  IF ((NEW.prixachatcatalogue IS NULL) OR (NEW.prixachatcatalogue like '')) THEN
  	NEW.prixachatcatalogue = 0;

  IF ((NEW.baseremboursement IS NULL) OR (NEW.baseremboursement like '')) THEN
  	NEW.baseremboursement = 0;

  IF ((NEW.avec_cbu IS NULL) OR (NEW.avec_cbu like '')) THEN
    NEW.avec_cbu = 0;

  IF ((NEW.gereinteressement IS NULL) OR (NEW.gereinteressement like '')) THEN
    NEW.gereinteressement = 0;

  IF ((NEW.geresuiviclient IS NULL) OR (NEW.geresuiviclient like '')) THEN
    NEW.geresuiviclient = 0;

  IF ((NEW.tracabilite IS NULL) OR (NEW.tracabilite like '')) THEN
    NEW.tracabilite = 0;

  IF ((NEW.profilgs IS NULL) OR (NEW.profilgs like '')) THEN
    NEW.profilgs = 0;

  IF ((NEW.veterinaire IS NULL) OR (NEW.veterinaire like '')) THEN
    NEW.veterinaire = 0;

  IF ((NEW.video IS NULL) OR (NEW.video like '')) THEN
    NEW.video = 0;

	IF (NEW.tva = 0) THEN
		NEW.tva = 6;

  IF ((NEW.designationlibrepossible IS NULL) OR (NEW.designationlibrepossible like '')) THEN
    NEW.designationlibrepossible = 0;

  IF ((NEW.frigo IS NULL) OR (NEW.frigo like '')) THEN
    NEW.frigo = 0;

  IF ((NEW.peremption_courte IS NULL) OR (NEW.peremption_courte like '')) THEN
    NEW.peremption_courte = 0;

  IF ((NEW.remise_interdite IS NULL) OR (NEW.remise_interdite like '')) THEN
    NEW.remise_interdite = 0;

  IF ((NEW.ristourne_interdite IS NULL) OR (NEW.ristourne_interdite like '')) THEN
    NEW.ristourne_interdite = 0;

  IF (char_length(NEW.labo) <> 4) THEN
  	NEW.labo = NULL;

  IF (char_length(NEW.concess) <> 4) THEN
  	NEW.concess = NULL;

  IF (NEW.designCNKNL_prod is NULL) then
  	NEW.designCNKNL_prod = NEW.designCNKFR_prod;

 IF (NEW.designCNKFR_prod IS NULL) THEN
 	 NEW.designCNKFR_prod = NEW.designCNKNL_prod;

END;


create or alter trigger trig_rep_mise_en_fome for t_repartiteur
active before insert or update as
begin
	if ((new.vitesse is null) or (new.vitesse like '')) then new.vitesse = 0;
	if ((new.pause is null) or (new.pause like '')) then new.pause = '0';
	if ((new.nbtentatives is null) or (new.nbtentatives like '')) then new.nbtentatives = 0;
 if ((new.modetransmission is null) or (new.modetransmission like '') or (new.modetransmission not in ('1', '2', '3', '4', '5'))) then new.modetransmission = '5';
	if ((new.repdefaut is null) or (new.repdefaut like '')) then new.repdefaut = '0';
	if ((new.objmensuel is null) or (new.objmensuel like '')) then new.objmensuel = 0;

 new.nomRepart = upper(new.nomRepart);
end;

create or alter trigger trig_fourn_mise_en_forme for t_fournisseur
active before insert or update as
begin
	if ((new.vitesse is null) or (new.vitesse like '')) then new.vitesse = 0;
	if ((new.pause is null) or (new.pause like '')) then new.pause = '0';
	if ((new.nbtentatives is null) or (new.nbtentatives like '')) then new.nbtentatives = 0;
 if ((new.modetransmission is null) or (new.modetransmission like '') or (new.modetransmission not in ('1', '2', '3', '4', '5'))) then new.modetransmission = '5';
	if ((new.foupartenaire is null) or (new.foupartenaire like '')) then new.foupartenaire = '0';
	if ((new.monogamme is null) or (new.monogamme like '')) then new.monogamme = '0';
 
 new.nomFourn = upper(new.nomFourn);
end;

create or alter trigger trg_repartiteur_ref for tw_repartiteur
active after insert as
begin
  update t_repartiteur
  set tr_repartiteur = new.repart_lgpi
  where repartiteur = new.repart;
end;


create or alter trigger trig_T_MAGISTRALE_FORMULE for T_MAGISTRALE_FORMULE
active before insert or update as
begin
	if ((new.UNITEQUANTITE is null) or (new.UNITEQUANTITE =0)) then new.UNITEQUANTITE = 99;
end;

create or alter trigger trig_T_MAGISTRALE_FORMULE_LIGNE for T_MAGISTRALE_FORMULE_LIGNE
active before insert or update as
begin
	if ((new.UNITEQUANTITE is null) or (new.UNITEQUANTITE =0)) then new.UNITEQUANTITE = 99;
end;


create or alter trigger trig_T_CREDIT for T_CREDIT
active before insert or update as
begin
	new.montant = round(new.montant,2);
end;

create or alter trigger trig_T_DELDIF for T_DELDIF
active before insert or update as
begin
	if (new.dateprescr is null) then new.dateprescr=current_date;
end;

CREATE OR ALTER TRIGGER trig_litige FOR t_litige
ACTIVE BEFORE INSERT AS
begin
	--le gtin ET le numero de serie vont de paire
	IF (NEW.GTIN IS NULL OR NEW.NUMERO_SERIE IS NULL OR TRIM(NEW.GTIN)=''  OR TRIM(NEW.NUMERO_SERIE)='') THEN
		NEW.GTIN = null;
		NEW.NUMERO_SERIE = NULL;
END;