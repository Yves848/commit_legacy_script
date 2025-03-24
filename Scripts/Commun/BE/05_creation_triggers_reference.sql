/**************************************/
/*   SCRIPT DE CREATION DES TRIGGERS  */
/*  DES TABLES DE REFERENCES          */
/**************************************/

/* Option générale */
set sql dialect 3;

/******************************/
/*       Création triggers    */
/*       de références        */
/******************************/

CREATE TRIGGER trig_repartiteur FOR tr_repartiteur
ACTIVE BEFORE INSERT AS
BEGIN
	IF (NEW.nomRepart IS NULL) THEN
		NEW.repartiteur = NULL;
END;