unit mdlInfosoftORGANISM;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier;

type
  TORGANISM = class(TDonneesFormatees)
  private
    FTypeContrat: string;
    FNomVille: string;
    FFax: string;
    FCodePostal: string;
    FIdentifiantNationalAMO: string;
    FTelephone: string;
    FNom: string;
    FID: string;
    FIdentifiantNationalAMC: string;
    FRue2: string;
    FRue1: string;
  published
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : string read FID;
    property Nom : string read FNom;
    property Rue1 : string read FRue1;
    property Rue2 : string read FRue2;
    property CodePostal : string read FCodePostal;
    property NomVille : string read FNomVille;
    property Telephone : string read FTelephone;
    property Fax : string read FFax;
    property IdentifiantNationalAMO : string read FIdentifiantNationalAMO;
    property IdentifiantNationalAMC : string read FIdentifiantNationalAMC;
    property TypeContrat : string read FTypeContrat;
  end;

implementation

type
  TrecORGANISM = record
    id : array[0..3] of AnsiCHar;
    nom : array[0..27] of AnsiCHar;
    rue_1 : array[0..31] of AnsiCHar;
    rue_2 : array[0..31] of AnsiCHar;
    code_postal : array[0..4] of AnsiCHar;
    nom_ville : array[0..25] of AnsiCHar;
    filler_1 : array[0..1] of AnsiCHar;
    contact : array[0..15] of AnsiChar;
    telephone : array[0..15] of AnsiCHar;
    fax : array[0..15] of AnsiCHar;
    identifiant_national_amo : array[0..8] of AnsiCHar;
    identifiant_national_amc : array[0..9] of AnsiCHar;
    filler_2 : array[0..51] of AnsiCHar;
    type_contrat : array[0..1] of AnsiCHar;
  end;

{ TORGANISM }

constructor TORGANISM.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 512;
end;

procedure TORGANISM.Remplit(var ABuffer);
begin
  inherited;

  with TFichierBinaire(Fichier), TrecORGANISM(ABuffer) do
  begin
    FID := id;
    FNom := nom;
    FRue1 := rue_1;
    FRue2 := rue_2;
    FCodePostal := code_postal;
    FNomVille := nom_ville;
    FTelephone := telephone;
    FFax := fax;
    FIdentifiantNationalAMO := identifiant_national_amo;
    FIdentifiantNationalAMC := identifiant_national_amc;
    FTypeContrat := type_contrat;
  end;
end;

end.
