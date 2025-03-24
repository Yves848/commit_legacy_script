unit mdlInfosoftPERSONEL;

interface

uses
  Windows, Classes, SysUtils, mdlInfosoftLectureFichier, mdlLectureFichierBinaire;

type
  TPERSONEL = class(TDonneesFormatees)
  private
    FPrenom: string;
    FNom: string;
    FCodeOperateur: string;
  published
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property CodeOperateur : string read FCodeOperateur;
    property Nom : string read FNom;
    property Prenom : string read FPrenom;
  end;

implementation

type
  TrecPERSONEL = record
    code_operateur : array[0..1] of AnsiChar;
    nom : array[0..13] of AnsiChar;
    prenom : array[0..13] of AnsiChar;
    filler : array[0..209] of Byte;
  end;

{ TPERSONNEL }

constructor TPERSONEL.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 240;
end;

procedure TPERSONEL.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecPERSONEL(ABuffer) do
  begin
    FCodeOperateur := code_operateur;
    FNom := nom;
    FPrenom := prenom;
  end;
end;

end.
