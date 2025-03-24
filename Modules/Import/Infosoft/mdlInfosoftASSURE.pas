unit mdlInfosoftASSURE;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier, mdlTypes, Classes, SysUtils;

type
  TASSURES = class(TDonneesFormatees)
  private
    FnumeroEnregistrement : integer;
    FNomVille: string;
    FRue: string;
    FDateNaissance: string;
    FIDOrganismeAMO: string;
    FIDOrganismeAMC: string;
    FNumeroInsee: string;
    FPrenom: string;
    FNom: string;
    FQualite: Byte;
    FRangGemellaire: AnsiChar;
    FCodePostal: string;
    FNumeroAdherentMutuelle: string;
    FIdentification: string;
    FDebutsDroitsAMO: TPIList<TDateTime>;
    FDebutsDroitsAMC: TPIList<TDateTime>;
    FIDCouvertureAMO: string;
    FCodesSituationsAMO: TPIList<Integer>;
    FNumeroSPSante: string;
    FIDCouvertureAMC: string;
    FCodesSituationsAMC: TPIList<Integer>;
    FALDs: TPIList<Integer>;
    FFinsDroitsAMO: TPIList<TDateTime>;
    FFinsDroitsAMC: TPIList<TDateTime>;
    FFax: string;
    FTelephone: string;
    FPortable: string;
    FSupprime: Boolean;
    FNomJeuneFille: string;
    FCodeSitu : TStringList;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    destructor Destroy; override;
    procedure Remplit(var ABuffer); override;
  published
    property NumeroEnregistrement : integer read FNumeroEnregistrement;
    property Identification : string read FIdentification;
    property NumeroInsee : string read FNumeroInsee;
    property DateNaissance : string read FDateNaissance;
    property RangGemellaire : AnsiChar read FRangGemellaire;
    property Qualite : Byte read FQualite;
    property Nom : string read FNom;
    property NomJeuneFille : string read FNomJeuneFille;
    property Prenom : string read FPrenom;
    property Rue : string read FRue;
    property CodePostal : string read FCodePostal;
    property NomVille : string read FNomVille;
    property Telephone : string read FTelephone;
    property Fax : string read FFax;
    property Portable : string read FPortable;
    property IDOrganismeAMO : string read FIDOrganismeAMO;
    property IDCouvertureAMO : string read FIDCouvertureAMO;
    property CodesSituationsAMO : TPIList<Integer> read FCodesSituationsAMO;
    property ALDs : TPIList<Integer> read FALDs;
    property DebutsDroitsAMO : TPIList<TDateTime> read FDebutsDroitsAMO;
    property FinsDroitsAMO : TPIList<TDateTime> read FFinsDroitsAMO;
    property IDOrganismeAMC : string read FIDOrganismeAMC;
    property IDCouvertureAMC : string read FIDCouvertureAMC;
    property NumeroAdherentMutuelle : string read FNumeroAdherentMutuelle;
    property NumeroSPSante : string read FNumeroSPSante;
    property CodesSituationsAMC : TPIList<Integer> read FCodesSituationsAMC;
    property DebutsDroitsAMC : TPIList<TDateTime> read FDebutsDroitsAMC;
    property FinsDroitsAMC : TPIList<TDateTime> read FFinsDroitsAMC;
    property Supprime : Boolean read FSupprime;
  end;

implementation

uses mdlInfosoftCODESITU;

type
  TrecASSURES_CouvertureAMO = record
    debut_droit : TDateInfosoft;
    fin_droit : TDateInfosoft;
    filler : Byte;
    ald : Byte;
    code_situation : TWordInfosoft;
  end;

  TrecASSURES_CouvertureAMC = record
    debut_droit : TDateInfosoft;
    fin_droit : TDateInfosoft;
    code_situation : TWordInfosoft;
  end;

  TrecASSURES = record
    identification : AnsiChar;
    numero_insee : array[0..14] of AnsiChar;
    date_naissance : array[0..7] of AnsiChar;
    rang_gemellaire : AnsiChar;
    qualite : Byte;
    nom : array[0..26] of AnsiChar;
    nom_jeune_fille : array[0..26] of AnsiChar;
    prenom : array[0..26] of AnsiChar;
    filler_2 : Byte;
    numero_carte_sv : array[0..9] of Byte;
    filler_5 : array[0..3] of Byte;
    rue : array[0..25] of AnsiChar;
    code_postal : array[0..4] of AnsiChar;
    nom_ville : array[0..20] of AnsiChar;
    telephone : array[0..15] of AnsiChar;
    fax : array[0..15] of AnsiChar;
    portable : array[0..15] of AnsiChar;
    id_organisme_amo : array[0..3] of AnsiChar;
    code_gestion_carte_sv : array[0..1] of AnsiChar;
    id_organisme_amc : array[0..3] of AnsiChar;
    codes_situations_amo : array[0..4] of TrecASSURES_CouvertureAMO;
    codes_situations_amc : array[0..2] of TrecASSURES_CouvertureAMC;
    id_couverture_amc : array[0..3] of AnsiChar;
    filler_7 : array[0..5] of AnsiChar;
    numero_adherent_mutuelle : array[0..15] of AnsiChar;
    numero_sp_sante : array[0..9] of AnsiChar;
    praticiens : array[0..4, 0..3] of AnsiChar;
    filler_8 : array[0..27] of Byte;
    id_couverture_amo : array[0..3] of AnsiChar;
    filler_9 : array[0..640] of Byte;
    suppression : Byte;
  end;

{ TASSURE }

constructor TASSURES.Create(AFichier: TFichierBinaire);
begin
  FCodesSituationsAMO := TPIList<Integer>.Create(5);
  FALDs := TPIList<Integer>.Create(5);
  FDebutsDroitsAMO := TPIList<TDateTime>.Create(5);
  FFinsDroitsAMO := TPIList<TDateTime>.Create(5);
  FCodesSituationsAMC := TPIList<Integer>.Create(3);
  FDebutsDroitsAMC := TPIList<TDateTime>.Create(3);
  FFinsDroitsAMC := TPIList<TDateTime>.Create(3);

  inherited;

  FTailleBloc := 1022;

  FCodeSitu := TStringList.Create;
  with TFichierInfosoft.Create(ExtractFilePath(Fichier.Fichier) + 'CODESITU.AMC') do
  begin
    repeat
      Suivant;
      FCodeSitu.Add(IntToStr(TCodeSitu(Donnees).CodeSituation) + '=' + TCodeSitu(Donnees).IDCouverture);
    until EOF;
    Free;
  end;
end;

destructor TASSURES.Destroy;
begin
  if Assigned(FinsDroitsAMC) then FreeAndNil(FFinsDroitsAMC);
  if Assigned(FDebutsDroitsAMC) then FreeAndNil(FDebutsDroitsAMC);
  if Assigned(FCodesSituationsAMC) then FreeAndNil(FCodesSituationsAMC);
  if Assigned(FFinsDroitsAMO) then FreeAndNil(FFinsDroitsAMO);
  if Assigned(FDebutsDroitsAMO) then FreeAndNil(FDebutsDroitsAMO);
  if Assigned(FALDs) then FreeAndNil(FALDs);
  if Assigned(FCodesSituationsAMO) then FreeAndNil(FCodesSituationsAMO);

  if Assigned(FCodeSitu) then FreeAndNil(FCodeSitu);

  inherited;
end;

procedure TASSURES.Remplit(var ABuffer);
var
  i: Integer;
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecASSURES(ABuffer) do
  begin
    FnumeroEnregistrement := EnregNo;
    FIdentification := identification;
    FNumeroInsee := numero_insee;
    FDateNaissance := date_naissance;
    FRangGemellaire := rang_gemellaire;
    FQualite := qualite;
    FNom := nom;
    FNomJeuneFille := nom_jeune_fille;
    FPrenom := prenom;
    FRue := rue;
    FCodePostal := code_postal;
    FNomVille := nom_ville;
    FTelephone := telephone;
    FFax := fax;
    FPortable := portable;
    FIDOrganismeAMO := id_organisme_amo;
    FIDCouvertureAMO := id_couverture_amo;
    FIDOrganismeAMC := id_organisme_amc;
    FNumeroAdherentMutuelle := numero_adherent_mutuelle;
    FNumeroSPSante := numero_sp_sante;

    for i := 0 to 4 do
    begin
      FCodesSituationsAMO[i] := RenvoyerSInt(codes_situations_amo[i].code_situation);
      FALDs[i] := codes_situations_amo[i].ald;
      FDebutsDroitsAMO[i] := RenvoyerDate(codes_situations_amo[i].debut_droit);
      FFinsDroitsAMO[i] := RenvoyerDate(codes_situations_amo[i].fin_droit);
    end;

    for i := 0 to 2 do
    begin
      FCodesSituationsAMC[i] := RenvoyerSInt(codes_situations_amc[i].code_situation);
      FDebutsDroitsAMC[i] := RenvoyerDate(codes_situations_amc[i].debut_droit);
      FFinsDroitsAMC[i] := RenvoyerDate(codes_situations_amc[i].fin_droit);
    end;

    i := FCodeSitu.IndexOfName(IntToStr(FCodesSituationsAMC[0]));
    if i <> -1 then
      FIDCouvertureAMC := FCodeSitu.ValueFromIndex[i]
    else
      FIDCouvertureAMC := '';

    FSupprime := suppression = 1;
  end;
end;

end.
