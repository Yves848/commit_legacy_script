unit mdlInfosoftMEDECINS;

interface

uses
  Windows, mdlLectureFichierBinaire, mdlInfosoftLectureFichier;

type
  TMEDECINS = class(TDonneesFormatees)
  private
    FNomVille: string;
    FSpecialite: Byte;
    FFax: string;
    FCodePostal: string;
    FPrenom: string;
    FTelephone: string;
    FNom: string;
    FID: string;
    FNumeroFiness: DWORD;
    FRue: string;
  published
    public
      constructor Create(AFichier : TFichierBinaire); override;
      procedure Remplit(var ABuffer); override;
    published
      property ID : string read FID;
      property NumeroFiness : DWORD read FNumeroFiness;
      property Nom : string read FNom;
      property Prenom : string read FPrenom;
      property Specialite : Byte read FSpecialite;
      property Rue : string read FRue;
      property CodePostal : string read FCodePostal;
      property NomVille : string read FNomVille;
      property Telephone : string read FTelephone;
      property Fax : string read FFax;
  end;


implementation

type
  TrecMEDECINS = record
    id : array[0..3] of AnsiCHar;
    numero_finess : TIntegerInfosoft;
    nom : array[0..26] of AnsiCHar;
    prenom : array[0..26] of AnsiCHar;
    specialite : Byte;
    rue : array[0..26] of AnsiCHar;
    code_postal : array[0..4] of AnsiCHar;
    nom_ville : array[0..20] of AnsiCHar;
    filler_1 : array[0..19] of Byte;
    telephone : array[0..14] of AnsiCHar;
    fax : array[0..14] of AnsiCHar;
  end;

{ TMEDECINS }

constructor TMEDECINS.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 320;
end;

procedure TMEDECINS.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecMEDECINS(ABuffer) do
  begin
    FID := id;
    try
      FNumeroFiness := MakeLong(MakeWord(numero_finess[0], numero_finess[1]), MakeWord(numero_finess[2], numero_finess[3]));
    except
      FNumeroFiness := 0;
    end;
    FNom := nom;
    FPrenom := prenom;
    FSpecialite := specialite;
    FRue := rue;
    FCodePostal := code_postal;
    FNomVille := nom_ville;
    FTelephone := telephone;
    FFax := fax;
  end;
end;

end.
