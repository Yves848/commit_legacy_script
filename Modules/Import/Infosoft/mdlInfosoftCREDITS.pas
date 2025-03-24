unit mdlInfosoftCREDITS;

interface

uses mdlLectureFichierBinaire, mdlInfosoftLectureFichier, SysUtils, Windows;

type
   TCREDITS = class(TDonneesFormatees)
  private
    FIDClient: Integer;
    FMontant: Single;
    FDateTime: TDateTime;
  published
   public
     constructor Create(AFichier : TFichierBinaire); override;
     procedure Remplit(var ABuffer); override;
   published
     property IDClient : Integer read FIDClient;
     property DateCredit : TDateTime read FDateTime;
     property Montant : Single read FMontant;
   end;

implementation

type
  TrecCREDITS = record
    id_client : TIntegerInfosoft;
    filler_1 : array[0..3] of Byte;
    montant : TDoubleInfosoft;
    filler_2 : array[0..1] of Byte;
    date_credit : TDateInfosoft;
  end;
{ TCREDITS }

constructor TCREDITS.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 20;
end;

procedure TCREDITS.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecCREDITS(ABuffer) do
  begin
    FIDClient := RenvoyerInt(id_client) + 1;
    FDateTime := RenvoyerDate(date_credit);
    FMontant := RenvoyerFloat(montant);
  end;
end;

end.
