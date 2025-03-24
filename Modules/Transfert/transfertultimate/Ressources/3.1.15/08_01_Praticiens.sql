create or replace package migration.pk_praticiens as
  
  function creer_praticien (
    ANom in varchar2,
    APrenom in varchar2,
    ACommentaires in varchar2,
    AIdentifiant in varchar2,
    AMatricule in varchar2,
    ASpecialite in varchar2,
    ARue1 in varchar2,
    ARue2 in varchar2,
    ACodePostal in varchar2,
    ANomVille in varchar2,
    ACodePays in varchar2,
    ATelPersonnel in varchar2,
    ATelStandard in varchar2,
    ATelMobile in varchar2,
    AEmail in varchar2,
    AFax in varchar2,
    ASiteWeb in varchar2,
    ADentiste in varchar2,
    AMedecinFrontalier in varchar2,
    ACategorie in number,
	AFusion in char) return number;
end;
/