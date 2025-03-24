unit mdlLectureFichierPrologue;

interface

uses
  Windows, Classes, SysUtils, StrUtils, DateUtils, mdlLectureFichierBinaire;

type
  TDatePrologue = record
    case Boolean of
      False :
        (Date : array[0..2] of Byte);
      True :
        (Annee, Mois, Jour : Byte);
  end;

  TDecimal3 = array[0..2] of Byte;
  TSinglePrologue = array[0..3] of Byte;
  TDecimal5 = array[0..4] of Byte;
  TDecimal6 = array[0..5] of Byte;
  TTauxRemboursement = array[0..5] of Byte;
  TDoublePrologue = array[0..7] of Byte;
  TWordPrologue = array[0..1] of Byte;
  TDWordPrologue = record
    case Boolean of
      False : (DWORD : array[0..3] of Byte);
      True : (Fort, Faible : TWordPrologue);
  end;
  TSmallIntPrologue = array[0..1] of Byte;

  TFichierPrologue = class(TFichierBinaire)
  public
    function RenvoyerFloat(AFloat : PByte; ATaille : Integer): Double; reintroduce;
    function RenvoyerInt(AInt : TDWordPrologue) : Integer; reintroduce; overload;
    function RenvoyerInt(AInt : TWordPrologue) : Integer; reintroduce; overload;
    function RenvoyerInt(ASInt : TSmallIntPrologue) : SmallInt; reintroduce; overload;
  end;

implementation

{ TFichierAlliance }

function TFichierPrologue.RenvoyerFloat(AFloat : PByte; ATaille : Integer): Double;
var
  i : Integer;
  lIntTaille : Integer;
  lStrFloat : string;
begin
  inherited;

  lStrFloat := '';
  for i := 0 to ATaille - 1 do
  begin
    lStrFloat := lStrFloat + IntToHex(AFloat^, 2);
    Inc(AFloat);
  end;


  // Signe
  if lStrFloat[1] = 'B' then
    lStrFloat[1] := '-'
  else
    lStrFloat[1] := ' ';

  lIntTaille := Length(lStrFloat);
  for i := 1 to lIntTaille do
    case lStrFloat[i] of
      'A' : lStrFloat[i] := DecimalSeparator;
      'B'..'E' : lStrFloat[i] := ' ';
    end;

  // Après 'F' => ne pas tenir compte
  i := Pos('F', lStrFloat);
  if i > 0 then
    lStrFloat := Copy(lStrFloat, 1, i - 1);

  if lStrFloat = ' ' then
    Result := 0
  else
    if not TryStrToFloat(StringReplace(lStrFloat, ' ', '', [rfReplaceAll]), Result) then
      Result := 0;
end;

function TFichierPrologue.RenvoyerInt(AInt: TWordPrologue): Integer;
begin
  Result := MakeWord(AInt[1], AInt[0]);
end;

function TFichierPrologue.RenvoyerInt(ASInt: TSmallIntPrologue): SmallInt;
var
  lBtHi : Byte;
begin
  lBtHi := ASInt[0];
  ASInt[0] := ASInt[1];
  ASInt[1] := lBtHi;
  Move(ASInt, Result, 2);
end;

function TFichierPrologue.RenvoyerInt(AInt: TDWordPrologue): Integer;
begin
  Result := MakeLong(RenvoyerInt(AInt.Faible), RenvoyerInt(AInt.Fort));
end;

end.
