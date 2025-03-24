unit mdlInfosoftLectureFichier;

interface

uses
  Windows, SysUtils, Classes, DateUtils, Dialogs, mdlLectureFichierBinaire,
  xmlintf, StrUtils, Contnrs, mdlTypes, Generics.Collections, Math ;

type
  TIntegerInfosoft = array[0..3] of Byte;
  TDoubleInfosoft = array[0..7] of Byte;
  TWordInfosoft = array[0..1] of Byte;
  THeureInfosoft = TWordInfosoft;
  TDateInfosoft = TWordInfosoft;
  TCodeCip = array[0..6] of AnsiChar;

  TFichierInfosoft = class(TFichierBinaire)
  protected
    function RenvoyerClasseDonnees : TClasseDonneesFormatees; override;
  public
    function RenvoyerDWrd(ADWORD : TIntegerInfosoft) : DWORD; reintroduce;overload;
    function RenvoyerWrd(AWORD : TWOrdInfosoft) : WORD; reintroduce;overload;
    function RenvoyerInt(AInt : TIntegerInfosoft) : Integer; reintroduce;overload;
    function RenvoyerSInt(ASInt : TWordInfosoft) : SmallInt; reintroduce;overload;
    function RenvoyerFloat(ADouble : TDoubleInfosoft) : Double; reintroduce;
    function RenvoyerDate(ADate : TDateInfosoft) : TDateTime; reintroduce;
    function RenvoyerHeure(AHeure : THeureInfosoft) : TDateTime; reintroduce;
    function RenvoyerCodeCIP13(ACodeCip : TcodeCip) : String; reintroduce;
  end;

implementation

uses mdlInfosoftMEDECINS, mdlInfosoftORGANISM, mdlInfosoftLABFOUR , mdlInfosoftPRODUITS,
  mdlInfosoftASSURE, mdlInfosoftCODEREMB, mdlInfosoftLIBCREMB,
  mdlInfosoftCODESITU, mdlInfosoftHISTO, mdlInfosoftCREDITS, mdlInfosoftAVANCESV ,
  mdlInfosoftSCANCLT, mdlInfosoftCOMMANDE, mdlInfosoftPERSONEL, mdlInfosoftMESSAGES ;

function TFichierInfosoft.RenvoyerClasseDonnees: TClasseDonneesFormatees;
var
  lStrFichier : string;
  i : Integer;
begin
  lStrFichier := UpperCase(ExtractFileName(FFichier)); Result := nil;
  if (lStrFichier = 'MEDECINS.DBI') then Result := TMEDECINS;
  if (lStrFichier = 'ORGANISM.DBI') then Result := TORGANISM;
  if ((lStrFichier = 'LIBCREMB.AMO') or (lStrFichier = 'LIBCREMB.AMC')) then Result := TLIBCREMB;
  if ((lStrFichier = 'CODEREMB.AMO') or (lStrFichier = 'CODEREMB.AMC')) then Result := TCODEREMB;
  if (lStrFichier = 'CODESITU.AMC') then Result := TCODESITU;
  if (lStrFichier = 'ASSURES.DBI') then Result := TASSURES;
  if (lStrFichier = 'HISTO.DBI') then Result := THISTO;
  if (lStrFichier = 'LABFOUR.DBI') then Result := TLABFOUR;
  if (lStrFichier = 'PRODUITS.DBI') then Result := TPRODUITS;
  if (lStrFichier = 'CREDITS.DBI') then Result := TCREDITS;
  if (lStrFichier = 'AVANCESV.DBI') then Result := TAVANCESV;
  if (lStrFichier = 'SCANCLT.IDX') then Result := TSCANCLT;
  if (lStrFichier = 'COMMANDE.LST') then Result := TCOMMANDE_LST;
  if (Copy(lStrFichier, 1, 8) = 'COMMANDE') and TryStrToInt(Copy(lStrFichier, 10, 3), i) then Result := TCOMMANDE;
  if (lStrFichier = 'PERSONEL.IDX') then Result := TPERSONEL;
  if (lStrFichier = 'MESSAGES.PDT') then Result := TMESSAGES;
end;

function TFichierInfosoft.RenvoyerInt(AInt: TIntegerInfosoft): Integer;
begin
  try
    Result := MakeLong(MakeWord(AInt[0], AInt[1]), MakeWord(AInt[2], AInt[3]));
  except
      Result := 0;
  end;
end;


function TFichierInfosoft.RenvoyerWrd(AWord: TWordInfosoft): WORD;
begin
  try
    Result := MakeWord(AWord[0], AWord[1])
  except
    Result := 0
  end;
end;

function TFichierInfosoft.RenvoyerDWrd(ADWORD: TIntegerInfosoft): DWORD;
begin
  Result := DWORD(RenvoyerInt(ADWORD))
end;

function TFichierInfosoft.Renvoyerfloat(ADouble : TDoubleInfosoft ): double;
begin
  move(ADouble,Result , 8);
  // filtrage des valeurs extravagantes
  if ((abs(Result) > 1000000 )or (abs(Result) < 0.00001 ) or isNaN(Result)  ) then  Result := 0;

end;

function TFichierInfosoft.RenvoyerSInt(ASInt: TWordInfosoft): SmallInt;
begin
  Result := SmallInt(RenvoyerWrd(ASInt))
end;

function TFichierInfosoft.RenvoyerDate(ADate : TDateInfosoft) : TDateTime;
var lIntVar, annee, mois , jour : word;
begin
   // extraction des jours / mois / annee   MASQUE + DECALAGE
   // le dernier bit deviens le premier
  // format en bits    M M M M J J J J J A A A A A A A
  // annee             0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 = 127     année de référence = 1980
  // mois              1 1 1 1  = 15  decalé  12
  // jour              0 0 0 0 1 1 1 1 1 = 31 decalé 7



  lIntVar := MakeWord(ADate[1], ADate[0]);
  if lIntVar = 0 then
  begin
    Result := 0 ;
    exit;
  end;

  // on fait passer le dernier bit ( le plus petit ) en premier ( le plus fort )
  lIntVar := ( lIntVar and 1 )*32768 + ( lIntVar shr 1 )  ;
  annee := lIntVar and 127 ;
  mois := ( lIntVar shr 12) and 15 ;
  jour := ( lIntVar shr 7) and 31 ;


  if not TryEncodeDate( 1980+Annee, Mois, Jour, Result) then
    Result := 0;

end;

function TFichierInfosoft.RenvoyerHeure(AHeure : THeureInfosoft) : TDateTime;
var
  v, h, m : word;
begin
   // extraction des jours / mois / annee   MASQUE + DECALAGE
   // le dernier bit deviens le premier
  // format en bits    H H H H H M M M M M M - - - - -

  v := MakeWord(AHeure[1], AHeure[0]);
  if v = 0 then
    Result := 0
  else
  begin
    h := (v shr 11) and $1F;
    m := (v shr 5) and $3F;

    if not TryEncodeTime(h, m, 0, 0, Result) then
      Result := 0;
  end;
end;

function TFichierInfosoft.RenvoyerCodeCIP13(ACodeCip : TcodeCip) : String;
begin
  Result :=copy( inttohex(ord(ACodeCip[0]),2)
                 +inttohex(ord(ACodeCip[1]),2)
                 +inttohex(ord(ACodeCip[2]),2)
                 +inttohex(ord(ACodeCip[3]),2)
                 +inttohex(ord(ACodeCip[4]),2)
                 +inttohex(ord(ACodeCip[5]),2)
                 +inttohex(ord(ACodeCip[6]),2) , 2,13);
end;

end.





