create or replace package body migration.pk_organismes as
  
FUNCTION CreationOrganismeCPAS_OA(
    AOrganismeCPAS IN VARCHAR2,
    ANom IN VARCHAR2,
    ANomReduit IN VARCHAR2,
    AOrgReference IN VARCHAR2,
    ATypeOA IN VARCHAR2,
    AEmail IN VARCHAR2,
    AGsm IN VARCHAR2,
    ATel1 IN VARCHAR2,
    ATel2 IN VARCHAR2,
    ARue1 IN VARCHAR2,
    ARue2 IN VARCHAR2,
    AUrl IN VARCHAR2,
    ALocalite IN VARCHAR2,
    ACp IN VARCHAR2,
    AFax IN VARCHAR2,
	Anocpas IN NUMBER,
	Adlg_mttclient_cpas IN VARCHAR2,
    T_ORGANISME_ID OUT NUMBER
) RETURN NUMBER
AS
    idTypeOA bel.t_typeoa.t_typeoa_id%TYPE;
    idCateg bel.t_categoriebenef.t_categoriebenef_id%TYPE;
    idAdr bel.t_adresse.t_adresse_id%TYPE;
BEGIN
    savepoint orga;
    idTypeOA := NULL;
    idCateg := NULL;
    idAdr := NULL;
    SELECT t_typeoa_id INTO idTypeOA FROM bel.t_typeoa WHERE libelle_fr = ATypeOA;
    SELECT t_categoriebenef_id INTO idCateg FROM bel.t_categoriebenef WHERE libelle_fr = ATypeOA;
	
    idAdr := pk_commun.creer_adresse(ARue1,ARue2,ACp,ALocalite,ATel1,ATel2,AGsm,AEmail,AFax,NULL);

    INSERT INTO bel.t_organismeamo(t_organismeamo_id,nom,nomreduit,orgreference,datemajorganisme,identifiant,t_adresse_id,t_typeoa_id,t_categoriebenef,tierspayant_interdit, nocpas, dlg_mttclient_cpas )
    VALUES(bel.seq_organisme.nextval,ANom,ANomReduit,AOrgReference,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),'998',idAdr,idTypeOA,idCateg,'0', Anocpas, Adlg_mttclient_cpas)
    RETURNING t_organismeamo_id INTO T_ORGANISME_ID;
	
    RETURN T_ORGANISME_ID;

  EXCEPTION
    WHEN OTHERS then
      ROLLBACK to orga;
      raise;
END CreationOrganismeCPAS_OA;

FUNCTION CreationOrganismeCPAS_OC(
    AOrganismeCPAS IN VARCHAR2,
    ANom IN VARCHAR2,
    ANomReduit IN VARCHAR2,
    AOrgReference IN VARCHAR2,
    ATypeOA IN VARCHAR2,
    AEmail IN VARCHAR2,
    AGsm IN VARCHAR2,
    ATel1 IN VARCHAR2,
    ATel2 IN VARCHAR2,
    ARue1 IN VARCHAR2,
    ARue2 IN VARCHAR2,
    AUrl IN VARCHAR2,
    ALocalite IN VARCHAR2,
    ACp IN VARCHAR2,
    AFax IN VARCHAR2,
	Anocpas in NUMBER,
	Adlg_mttclient_cpas IN VARCHAR2,
    T_ORGANISME_ID OUT NUMBER
) RETURN NUMBER
AS
    idTypeOA bel.t_typeoa.t_typeoa_id%TYPE;
    idCateg bel.t_categoriebenef.t_categoriebenef_id%TYPE;
    idAdr bel.t_adresse.t_adresse_id%TYPE;
BEGIN
    savepoint orga;
    idTypeOA := NULL;
    idCateg := NULL;
    idAdr := NULL;
    SELECT t_typeoa_id INTO idTypeOA FROM bel.t_typeoa WHERE libelle_fr = ATypeOA;
    SELECT t_categoriebenef_id INTO idCateg FROM bel.t_categoriebenef WHERE libelle_fr = ATypeOA;
	
    idAdr := pk_commun.creer_adresse(ARue1,ARue2,ACp,ALocalite,ATel1,ATel2,AGsm,AEmail,AFax,NULL);

    INSERT INTO bel.t_organismeamc(t_organismeamc_id,nom,nomreduit,orgreference,datemajorganisme,identifiant,t_adresse_id,t_typeoa_id,t_categoriebenef, nocpas, dlg_mttclient_cpas)
    VALUES(bel.seq_organisme.nextval,ANom,ANomReduit,AOrgReference,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),'998',idAdr,idTypeOA,idCateg, Anocpas, Adlg_mttclient_cpas)
    RETURNING t_organismeamc_id INTO T_ORGANISME_ID;

    RETURN T_ORGANISME_ID;

  EXCEPTION
    WHEN OTHERS then
      ROLLBACK to orga;
      raise;
END CreationOrganismeCPAS_OC;

  
end;
/