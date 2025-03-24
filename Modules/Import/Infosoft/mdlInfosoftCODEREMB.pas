unit mdlInfosoftCODEREMB;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier;

type
  TCODEREMB = class(TDonneesFormatees)
  private
    FTaux: Integer;
    FIDCouverture: string;
    FActe: string;
  published
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property IDCouverture : string read FIDCouverture;
    property Acte : string read FActe;
    property Taux : Integer read FTaux;
  end;
implementation

type
  TrecCODEREMB = record
    id_couverture : array[0..3] of AnsiChar;
    acte : array[0..4] of AnsiChar;
    taux : TWordInfosoft;
  end;

{ TCODEREMB }

constructor TCODEREMB.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 16;
end;

procedure TCODEREMB.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecCODEREMB(ABuffer) do
  begin
    FIDCouverture := id_couverture;
    FActe := acte;
    FTaux := RenvoyerSInt(taux);
  end;
end;

end.
