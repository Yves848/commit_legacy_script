unit mdlInfosoftAVANCESV;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier, SysUtils, Windows;

type
  TAVANCESV = class(TDonneesFormatees)
  private
    FIDAvance: string;
    FIDClient : integer;
    FCodeCIP: string;
    FDesignation: string;
    FQuantite : integer;
    FPrixAchat : double;
    FBaseRemboursement : double;
    FPrixVente : double;
    FPrestation : string;
    FOperateur : string;
    FDateAvance : TDateTime;
  published
    public
      constructor Create(AFichier : TFichierBinaire); override;
      procedure Remplit(var ABuffer); override;

    published
      property IDAvance : string read FIDAvance;
      property IDClient : integer read FIDClient;
      property CodeCip : string read FCodeCip;
      property Designation : string read FDesignation;
      property Quantite : integer read FQuantite;
      property PrixAchat : double read FPrixAchat;
      property BaseRemboursement : double read FBaseRemboursement;
      property PrixVente : double read FPrixVente;
      property Prestation : string read FPrestation;
      property Operateur : string read FOperateur;
      property DateAvance : TDateTime read FDateAvance;
  end;



implementation

type
  TrecAVANCESV = record
    id_avance : array[0..5] of AnsiChar;
    code_cip : TCodeCip;
    designation : array[0..44] of AnsiChar;
    id_client : TIntegerInfosoft;
    quantite : TWordInfosoft;
    montant_1 : TDoubleInfosoft;
    montant_2 : TDoubleInfosoft;
    montant_3 : TDoubleInfosoft;
    filler_2 : array[0..1] of AnsiChar;
    prestation : array[0..2] of AnsiChar;
    filler_3 : array[0..2] of AnsiChar;
    operateur : array[0..1] of AnsiChar;
    date_avance : TDateInfosoft;
  end;


constructor TAVANCESV.Create(AFichier: TFichierBinaire);
begin

  inherited;
  FTailleBloc := 128;
end;

procedure TAVANCESV.Remplit(var ABuffer);
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecAVANCESV(ABuffer) do
  begin
    FIDAvance := id_avance;
    FIDClient := RenvoyerInt(id_client)+1;
    if ( ord(code_cip[0]) = 243 )  then
      FCodeCip := RenvoyerCodeCIP13(code_cip)
    else
      FCodeCip := code_cip;
    FDesignation := designation;
    FPrestation := prestation;

    FBaseRemboursement := RenvoyerFloat(montant_3);
    FPrixAchat := RenvoyerFloat(montant_2);
    FPrixVente := RenvoyerFloat(montant_1);
    FQuantite := RenvoyerSInt(quantite);
    FOperateur := operateur;

    FDateAvance := RenvoyerDate(date_avance);
  end;

end;




end.
