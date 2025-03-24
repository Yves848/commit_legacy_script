create or replace package migration.pk_praticiens as

  /* ********************************************************************************************** */
  function creer_structure(AIDStructureLGPI in integer,
                           ASecteur in varchar2, 
                           ANom in varchar2,
                           ACommentaire in varchar2,
                           ANoFiness in varchar2,
                           ARue1 in varchar2,
                           ARue2 in varchar2,
                           ACodePostal in varchar2,
                           ANomVille in varchar2,
                           ATelPersonnel in varchar2,
                           ATelStandard in varchar2,
                           ATelMobile in varchar2,
                           AFax in varchar2,
                           AFusion in char)
                          return integer; 

  /* ********************************************************************************************** */
  function creer_hopital(AIDHopitalLGPI in integer,
                         ANom in varchar2,
                         ACommentaire in varchar2,
                         ANoFiness in varchar2,
                         ARue1 in varchar2,
                         ARue2 in varchar2,
                         ACodePostal in varchar2,
                         ANomVille in varchar2,
                         ATelPersonnel in varchar2,
                         ATelStandard in varchar2,
                         ATelMobile in varchar2,
                         AFax in varchar2,
                         AFusion in char)
                        return integer; 
                       
  /* ********************************************************************************************** */
  function creer_praticien(AIDPraticienLGPI in integer,
                           ATypePraticien in varchar2,                          
                           ANom in varchar2,
                           APrenom in varchar2,
                           ASpecialite in varchar2,
                           ARue1 in varchar2,
                           ARue2 in varchar2,
                           ACodePostal in varchar2,
                           ANomVille in varchar2,
                           ATelPersonnel in varchar2,
                           ATelStandard in varchar2,
                           ATelMobile in varchar2,
                           AFax in varchar2,
                           AIDHopital in number,
                           ACommentaire in varchar2,
                           ANoFiness in varchar2,
                           ANumRPPS in varchar2,
                           AVeterinaire in char,
                           AFusion in char)
                         return number;
                         
end; 
/
