unit mdlCreditsWinpharma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ioutils, strutils, dateUtils, Dialogs, StdCtrls, JCLPCRE;

const
  iColDate = 0;
  iColNumFact = 1;
  iColClient = 2;
  iColBeneficiaire = 3;
  iColImpaye = 4;
  iColMontant = 5;
  iColMontantDu = 6;
  iColOperateur = 7;

  iNombreChamp = 8;
  iNombreSeparateur = 9;
type
  tCredit = class(tObject)
  private
    fDate: tDateTime;
    fNoFact: Integer;
    fClient: string;
    fBeneficiaire: string;
    fImpaye: string;
    fMontant: Double;
    fMontantDu: Double;
    fOperateur: Integer;
    fTest: boolean;
    fMontantDuCpt: Double;
    function splitString(sDelimiter: char; sString: string): tStrings;
    function convertDate(sDate: string): tDateTime;

  public
    constructor create(Line: string); overload;
    constructor create(sList: tStrings); overload;
    property dateCredit: tDateTime read fDate write fDate;
    property noFact: Integer read fNoFact write fNoFact;
    property client: string read fClient write fClient;
    property beneficiaire: string read fBeneficiaire write fBeneficiaire;
    property impaye: string read fImpaye write fImpaye;
    property montant: Double read fMontant write fMontant;
    property montantDu: Double read fMontantDu write fMontantDu;
    property montantDuCpt: Double read fMontantDuCpt write fMontantDuCpt;
    property operateur: Integer read fOperateur write fOperateur;

  end;

  tFichierCredits = class(tObject)
  private
    fsFichier: tFileStream;
    fBufferSize: Integer;
    fSize: Integer;
    fEof: boolean;
    fBuffer: Ansistring;
    fCursor: Integer;
    pRegEx: TJclRegEx;
    sLines: tStrings;
    fCRLF: String;
    function endOfLine: String;
    function readBuffer: Integer;
    function countChar(car: string; sString: string): Integer;
    function countCharEx(sReg: string; sString: string): Integer;
    function TryStrToFloatMultylang(const S: String; out Value: Extended): boolean;
  public
    constructor create(sfile: string);
    property Size: Integer read fSize write fSize;
    property Eof: boolean read fEof;
    function ReadLine: Ansistring;
    function ReadCredit: tCredit;
  end;

implementation

function tCredit.splitString(sDelimiter: char; sString: string): tStrings;
begin
  result := tStringList.create;
  result.Delimiter := sDelimiter;
  result.StrictDelimiter := true;
  result.DelimitedText := sString;
end;

function tCredit.convertDate(sDate: string): tDateTime;
var
  slDate: tStrings;
  currentYear: word;
  year, month, day: word;
begin
  slDate := splitString('/', sDate);
  try
    year := strtointdef(trim(slDate[2]), 1899) + 2000; // ?? Gestion de l'année
    month := strtointdef(trim(slDate[1]), 1);
    day := strtointdef(trim(slDate[0]), 1);
  except
    year := 1899;
    month := 12;
    day := 30;
  end;
  result := encodedate(year, month, day);

end;

constructor tCredit.create(Line: string);

var
  sList: tStrings;

begin

  if StartsText('|', Line) then
    delete(Line, 1, 1);
  if EndsText('|', Line) then
    delete(Line, Length(Line), 1);

  sList := tStringList.create;
  sList.Clear;
  sList.Delimiter := '|';
  sList.StrictDelimiter := true;
  sList.DelimitedText := Line;

  fDate := convertDate(sList[iColDate]);
  fNoFact := strtointdef(sList[iColNumFact], -1);
  fClient := sList[iColClient];
  fBeneficiaire := sList[iColBeneficiaire];
  fImpaye := sList[iColImpaye];
  fMontant := strToFloatdef(trim(sList[iColMontant]), 0);
  fMontantDu := strToFloatdef(trim(sList[iColMontantDu]), 0);
  fOperateur := strtointdef(sList[iColOperateur], -1);
end;

constructor tCredit.create(sList: tStrings);
begin
  fDate := convertDate(sList[iColDate]);
  fNoFact := strtointdef(sList[iColNumFact], -1);
  fClient := sList[iColClient];
  fBeneficiaire := sList[iColBeneficiaire];
  fImpaye := sList[iColImpaye];
  fMontant := strToFloatdef(trim(sList[iColMontant]), 0);
  fMontantDu := strToFloatdef(trim(sList[iColMontantDu]), 0);
  fMontantDuCpt := 0;
  fOperateur := strtointdef(sList[iColOperateur], -1);
end;

function tFichierCredits.endOfLine: String;
var
  readBuffer: Ansistring;
  iRead: Integer;
  iPos: Integer;
  crlf: String;
begin

  SetLength(readBuffer, fBufferSize);
  fsFichier.Read(pointer(readBuffer)^, fBufferSize);
  crlf := #13 + #10;
  iPos := pos(crlf, readBuffer);
  if iPos = 0 then
  begin
    crlf := #10;
  end;
  result := crlf;
end;

function tFichierCredits.ReadCredit: tCredit;
var
  iPosCRLF: Integer;
  bLigneValide: boolean;
  sLigne: string;
  sLigne2: String;
  sMontant: String;
  bContinue: boolean;
  sList: tStrings;
  vOut: Extended;

  function cleanLine(pLigne: string): string;
  begin
    if StartsText('|', pLigne) then
      delete(pLigne, 1, 1);
    if EndsText('|', pLigne) then
      delete(pLigne, Length(pLigne), 1);
    result := pLigne;
  end;

  function isValidLine: boolean;
  begin
      result := (countChar('|',sLigne) = iNombreSeparateur);
      if result then
         result := not (countChar('-',sLigne) > 5);
  end;

  function isValidList: boolean;
  begin
    result := (sList.Count = iNombreChamp);
    if result then
      result := not(trim(sList[iColMontant]) = 'Montant');
  end;

  function extractAmount(sValue: String): Double;
  begin
      pRegEx.Compile('\d*[,.]\d*',false);
      sMontant := '';
      if pREgEx.Match(sValue) then
         sMontant := Copy(sValue,
                          pREgEx.CaptureRanges[0].FirstPos,
                          pREgEx.CaptureRanges[0].LastPos - pREgEx.CaptureRanges[0].FirstPos + 1);

      TryStrToFloatMultylang(sMontant, vOut);
      result := vOut;
  end;

begin

// ne recoit que les lignes contenant le bon nb de separateurs

  result := nil;
  bContinue := true;
  while not fEof do
  begin
    sLigne := ReadLine;

    if not isValidLine then
      continue; // pas la peine d 'aller plus loin

    sLigne := cleanLine(sLigne);

    sList := tStringList.create;
    sList.Clear;
    sList.Delimiter := '|';
    sList.StrictDelimiter := true;
    sList.DelimitedText := sLigne;

    if not isValidList then
      continue;

    result := tCredit.create(sList);

    if trim(sList[iColMontant]) = '' then
    begin
      sLigne2 := cleanLine(ReadLine);
      sList.Clear;
      sList.Delimiter := '|';
      sList.StrictDelimiter := true;
      sList.DelimitedText := sLigne2;
      result.fMontantDuCpt := extractAmount(sList[iColClient]); // cas special ou le montant se trouve dans la colonne assuré
      result.beneficiaire := sList[iColBeneficiaire];
      result.fImpaye := sList[iColImpaye];
      TryStrToFloatMultylang(sList[iColMontantDu], vOut);
      result.montant := vOut;
      break;
    end
    else
      break;
  end;
end;

function tFichierCredits.ReadLine: Ansistring;
var
  iPos: Integer;
  bValide: boolean;
  iMontant: Extended;
  tempBuffer: String;
  continue: boolean;
begin
  result := '';
  iPos := pos(fCRLF, fBuffer); // Recherche d'une fin de ligne (CRLF)
  if iPos = 0 then // Si il n'y a pas de CRLF, charger un autre bloc
  begin
    readBuffer;
    iPos := pos(fCRLF, fBuffer);
    fEof := (iPos = 0);
  end;
  continue := not fEof;
  while continue do
  begin
    if iPos > 0 then // Fin de ligne trouvé
    begin
      tempBuffer := copy(fBuffer, 1, iPos - 1);
      if countChar('|', tempBuffer) = iNombreSeparateur then
      begin
        result := tempBuffer;
        continue := false;
      end;
      fBuffer := copy(fBuffer, iPos + Length(fCRLF), Length(fBuffer) - Length(fCRLF));
      iPos := pos(fCRLF, fBuffer);
      if iPos = 0 then // Si il n'y a pas de CRLF, charger un autre bloc
      begin
        readBuffer;
        iPos := pos(fCRLF, fBuffer);
        fEof := (iPos = 0);
        continue := false;
      end;
    end;
  end;
end;

constructor tFichierCredits.create(sfile: string);
begin
  sLines := tStringList.create;
  fCursor := 0;
  pRegEx := TJclRegEx.create;
  fsFichier := tFileStream.create(sfile, fmShareDenyNone or fmOpenRead);
  fBufferSize := 4096;
  // Search for the line terminator  CR or CR/LF
  fCRLF := endOfLine;
  fSize := fsFichier.Size;
  fsFichier.Seek(0, soFromBeginning);
  fEof := false;

end;

function tFichierCredits.readBuffer: Integer;
var
  readBuffer: Ansistring;
  iRead: Integer;
begin
  if (fSize < fBufferSize) then
    fBufferSize := fSize;
  SetLength(readBuffer, fBufferSize);
  iRead := fsFichier.Read(pointer(readBuffer)^, fBufferSize);
  fBuffer := fBuffer + readBuffer;
  fSize := fSize - iRead;
end;

function tFichierCredits.TryStrToFloatMultylang(const S: String; out Value: Extended): boolean;
var
  dc: char;
begin
  if S = '' then
  begin
    Value := 0;
    result := true;
  end
  else
  begin
    result := false;
    dc := DecimalSeparator;
    DecimalSeparator := '.';
    result := TryStrToFloat(S, Value);
    if not result then
    begin
      DecimalSeparator := ',';
      result := TryStrToFloat(S, Value);
    end;
    DecimalSeparator := dc;
  end;
end;

function tFichierCredits.countChar(car: string; sString: string): Integer;
var
  i: Integer;
  tempString: string;
begin
  tempString := sString;
  result := 0;
  i := ansipos(car, tempString);
  while i > 0 do
  begin
    inc(result);
    tempString := copy(tempString, i + 1, Length(tempString) - 1);
    i := ansipos(car, tempString);
  end;
end;

function tFichierCredits.countCharEx(sReg: string; sString: string): Integer;
const
  sPatern = '(?:\%s)';
var
  i : Integer;
begin
   //pRegEx.RegEx := format(sPatern,[sReg]);
   pRegEx.Compile(format(sPatern,[sReg]),true);
   //pRegEx.Subject := sString;

   result := 0;
   while pRegEx.Match(sString, result +1) do inc(result);
end;

end.
