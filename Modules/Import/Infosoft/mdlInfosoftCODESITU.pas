unit mdlInfosoftCODESITU;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier, Windows, SysUtils;

type
  TCODESITU = class(TDonneesFormatees)
  private
    FCodeSituation: Integer;
    FIDCouverture: string;
  published
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property CodeSituation : Integer read FCodeSituation;
    property IDCouverture : string read FIDCouverture;
  end;
implementation

type
  TrecCODESITU = record
    code_situation : TWordInfosoft;
    filler : array[0..2] of Byte;
    id_couverture : array[0..3] of AnsiChar;
  end;
{ TCODESITU }

constructor TCODESITU.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 16;
end;

procedure TCODESITU.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecCODESITU(ABuffer) do
  begin
    FCodeSituation := MakeWord(code_situation[1], code_situation[0]);
    FIDCouverture := id_couverture;
  end;
end;

end.
