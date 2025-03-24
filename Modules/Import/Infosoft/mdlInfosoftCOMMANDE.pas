unit mdlInfosoftCOMMANDE;

interface

uses
  Windows, SysUtils, Classes, mdlInfosoftLectureFichier, mdlLectureFichierBinaire;

type
  TCOMMANDE_LST = class(TDonneesFormatees)
  private
    FDate: TDateTime;
    FValidation: string;
    FOperateur: string;
    FID: string;
    FHeure: TDateTime;
    FReception: Integer;
    FFournisseur: string;
    FCommentaire: string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property ID : string read FID;
    property Reception : Integer read FReception;
    property Fournisseur : string read FFournisseur;
    property Date : TDateTime read FDate;
    property Heure : TDateTime read FHeure;
    property Validation : string read FValidation;
    property Commentaire : string read FCommentaire;
    property Operateur : string read FOperateur;
  end;

  TCOMMANDE = class(TDonneesFormatees)
  private
    FPrix4: Single;
    FQuantiteReceptionnee: Integer;
    FCodeCIP: string;
    FCodeEAN13: string;
    FDesignation: string;
    FValidee: AnsiChar;
    FPrix2: Single;
    FPrix3: Single;
    FPrix1: Single;
    FQuantiteCommandee: Integer;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property CodeCIP : string read FCodeCIP;
    property Designation : string read FDesignation;
    property CodeEAN13 : string read FCodeEAN13;
    property Validee : AnsiChar read FValidee;
    property QuantiteCommandee : Integer read FQuantiteCommandee;
    property QuantiteReceptionnee : Integer read FQuantiteReceptionnee;
    property Prix1 : Single read FPrix1;
    property Prix2 : Single read FPrix2;
    property Prix3 : Single read FPrix3;
    property Prix4 : Single read FPrix4;
  end;
implementation

type
  TrecCOMMANDE_LST= record
    id : array[0..2] of AnsiChar;
    reception : Byte;
    filler_1 : array[0..1]of Byte;
    id_fournisseur : array[0..3] of AnsiChar;
    date : TWordInfosoft;
    heure : TWordInfosoft;
    validation : array[0..19] of AnsiChar;
    commentaire : array[0..27] of AnsiChar;
    operateur : array[0..1] of AnsiChar;
  end;

  TrecCOMMANDE = record
    code_cip : TCodeCip;
    designation : array[0..44] of AnsiChar;
    code_ean13 : array[0..12] of AnsiChar;
    filler_1 : array[0..8] of Byte;
    quantite_commandee : TWordInfosoft;
    filler_3 : array[0..1] of Byte;
    quantite_receptionnee : TWordInfosoft;
    filler_4 : TWordInfosoft;
    filler_2 : array[0..5] of Byte;
    prix_1 : TDoubleInfosoft;
    prix_2 : TDoubleInfosoft;
    prix_3 : TDoubleInfosoft;
    prix_4 : TDoubleInfosoft;
  end;

{ TCOMMANDE_LST }

constructor TCOMMANDE_LST.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 64;
end;

procedure TCOMMANDE_LST.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecCOMMANDE_LST(ABuffer) do
  begin
    FID := id;
    FReception:= reception;
    FFournisseur := id_fournisseur;
    FDate := RenvoyerDate(date);
    FHeure := RenvoyerHeure(heure);
    FValidation := validation;
    FCommentaire := commentaire;
    FOperateur := operateur;
  end;
end;

{ TCOMMANDE }

constructor TCOMMANDE.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 255;
end;

procedure TCOMMANDE.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecCOMMANDE(ABuffer) do
  begin
    if ( ord(code_cip[0]) = 243 )  then
      FCodeCip := RenvoyerCodeCIP13(code_cip)
    else
      FCodeCip := code_cip;
    FDesignation := designation;
    FCodeEAN13 := code_ean13;
    FValidee := validee;
    FQuantiteReceptionnee := RenvoyerSInt(quantite_receptionnee);
    FQuantiteCommandee := RenvoyerSInt(quantite_commandee);
    FPrix1 := RenvoyerFloat(prix_1);
    FPrix2 := RenvoyerFloat(prix_2);
    FPrix3 := RenvoyerFloat(prix_3);
    FPrix4 := RenvoyerFloat(prix_4);
  end;
end;

end.
