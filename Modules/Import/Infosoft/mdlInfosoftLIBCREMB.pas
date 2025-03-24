unit mdlInfosoftLIBCREMB;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier;

type
  TLIBCREMB = class(TDonneesFormatees)
  private
    FID: string;
    FLibelle: string;
  published
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : string read FID;
    property Libelle : string read FLibelle;
  end;
implementation

type
  TrecLIBCREMB = record
    libelle : array[0..39] of AnsiChar;
    id : array[0..3] of AnsiChar;
  end;
{ TLIBCREMB }

constructor TLIBCREMB.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 44;
end;

procedure TLIBCREMB.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecLIBCREMB(ABuffer) do
  begin
    FID := id;
    FLibelle := libelle;
  end;
end;

end.
