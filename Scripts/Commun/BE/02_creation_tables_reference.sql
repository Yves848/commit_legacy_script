set sql dialect 3;


CREATE TABLE tr_repartiteur(
	repartiteur dm_code NOT NULL
	,nomRepart dm_varchar50
	,rueRepart dm_varchar40
	,locRepart dm_varchar40
	,cpRepart dm_varchar10
	);
CREATE INDEX idx_repartiteur ON tr_repartiteur(repartiteur);


CREATE TABLE tr_fournisseur(
 fournisseur dm_code NOT NULL
 ,nomFourn dm_varchar50
 ,rueFourn dm_varchar100
 ,locFourn dm_varchar40
 ,cpFourn dm_varchar10
 ,numapb dm_num_apb4 NOT NULL
);
CREATE INDEX idx_fournisseur ON tr_fournisseur(fournisseur);


CREATE TABLE tr_REFERENCEANALYTIQUE(
 REFERENCEANALYTIQUE dm_numeric1 NOT NULL
 ,NOM dm_varchar50
 );
CREATE INDEX idx_REFERENCEANALYTIQUE ON tr_REFERENCEANALYTIQUE(NOM);

 CREATE TABLE tr_REFERENCEANALYTIQUE_INDEX(
 REFERENCEANALYTIQUE dm_numeric1 NOT NULL
 ,REFERENCEANALYTIQUE_IMPORT dm_varchar50
 );
CREATE INDEX idx_REFERENCEANALYTIQUE_index ON tr_REFERENCEANALYTIQUE_INDEX(REFERENCEANALYTIQUE_IMPORT);

 
CREATE TABLE tr_unite(
 unite dm_varchar16 NOT NULL
 ,unite_base dm_varchar3
 ,coefficient dm_monetaire3 --6 chiffre derrière la virgule, coefficient multiplicateur de transformation de unite vers unite_base
 ,reference_magistrale dm_numpos2 -- reference pour la magistrale de unite et non unite_base 
 );
CREATE INDEX idx_unite ON tr_unite(unite);
 
commit;