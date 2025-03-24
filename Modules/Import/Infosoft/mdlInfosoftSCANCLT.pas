unit mdlInfosoftSCANCLT;

interface

uses
  Windows, Classes, SysUtils, mdlLectureFichierBinaire, mdlInfosoftLectureFichier;

type
  TSCANCLT = class(TDonneesFormatees)
  private
    FDate: TDateTime;
    FOperateur: string;
    FHeure: TDateTime;
    FIDDocument: string;
    FNumeroDocument: Integer;
    FIDClient: Integer;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property IDDocument : string read FIDDocument write FIDDocument;
    property IDClient : Integer read FIDClient;
    property NumeroDocument : Integer read FNumeroDocument;
    property Date : TDateTime read FDate;
    property Heure : TDateTime read FHeure;
    property Operateur : string read FOperateur;
  end;

implementation

type
  TrecSCANCLT = record
    id_document : array[0..5] of AnsiChar;
    id_client : TWordInfosoft;
    filler_1 : array[0..1] of Byte;
    numero_document : Byte;
    date : TDateInfosoft;
    heure : TWordInfosoft;
    operateur : array[0..1] of AnsiChar;
    filler_2 : array[0..10] of Byte;
  end;

{ TSCANCLT }

constructor TSCANCLT.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 48;
end;

procedure TSCANCLT.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecSCANCLT(ABuffer) do
  begin
    FIDDocument := id_document;
    FIDClient := RenvoyerSInt(id_client) + 1;
    FNumeroDocument := numero_document;
    FDate := RenvoyerDate(date);
    FHeure := RenvoyerHeure(heure);
    FOperateur := operateur;
  end;
end;

end.
