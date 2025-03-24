create or replace package migration.pk_organismes as

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
	Anocpas in NUMBER,
	Adlg_mttclient_cpas IN VARCHAR2,
    T_ORGANISME_ID OUT NUMBER
) RETURN NUMBER;

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
) RETURN NUMBER;


end;
/