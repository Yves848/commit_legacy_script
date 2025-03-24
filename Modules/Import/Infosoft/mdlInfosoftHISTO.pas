unit mdlInfosoftHISTO;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier, SysUtils, Windows, JclUnicode;

type
  THISTO = class(TDonneesFormatees)
  private
    FTypeEntete: SmallInt;
    FDateFacture: TDateTime;
    FNumeroOrdo: WORD;
    FIDPraticien: string;
    FDateNaissance: string;
    FPrenomClient: string;
    FNumeroInsee: string;
    FCodeCIP: string;
    FNomClient: string;
    FIDClient: integer;
    FNomPrenomPraticien: string;
    FNumeroFacture: Integer;
    FQuantite: SmallInt;
    FDesignation: string;
    FDatePrescription: TDateTime;
    FPrixVente: Single;
    FActe: string;
    FNumeroFiness: DWORD;
    FCommentaire : string;
  public
    constructor Create(AFichier : TFichierBinaire); override;
    procedure Remplit(var ABuffer); override;
  published
    property TypeEntete : SmallInt read FTypeEntete;
    property DateFacture : TDateTime read FDateFacture;
    property NumeroOrdo : Word read FNumeroOrdo;
    property NomClient : string read FNomClient;
    property PrenomClient : string read FPrenomClient;
    property NumeroInsee : string read FNumeroInsee;
    property DateNaissance : string read FDateNaissance;
    property DatePrescription : TDateTime read FDatePrescription;
    property NumeroFacture : Integer read FNumeroFacture;
    property NomPrenomPraticien : string read FNomPrenomPraticien;
    property IDPraticien : string read FIDPraticien;
    property NumeroFiness : DWORD read FNumeroFiness;
    property IDClient : integer read FIDClient;
    property CodeCIP : string read FCodeCIP;
    property Designation : string read FDesignation;
    property Acte : string read FActe;
    property PrixVente : Single read FPrixVente;
    property Quantite : SmallInt read FQuantite;
    property Commentaire : string read FCommentaire;
  end;

implementation

type
  TrecHISTO_Client = record
    nom : array[0..26] of AnsiChar;
    prenom : array[0..26] of AnsiChar;
    identifiantion : AnsiChar;
    numero_insee : array[0..14] of AnsiChar;
    date_naissance : array[0..7] of AnsiChar;
  end;

  TrecHISTO_Praticien = record
    nom_prenom : array[0..19] of AnsiChar;
    id : array[0..3] of AnsiChar;
    numero_finess : TIntegerInfosoft;
  end;

  TrecHISTO = record
    type_entete : TWordInfosoft;
    date_facture : TDateInfosoft;
    numero_ordo : TWordInfosoft;
    case Integer of
      // histo entete
      1 :
        (filler_1 : array[0..3] of Byte;
         client : TrecHISTO_Client;
         filler_2 : array[0..2] of Byte;
         date_acte : TDateInfosoft;
         date_prescription : TDateInfosoft;
         numero_facture :  TIntegerInfosoft;
         filler_6 : array[0..12] of Byte;
         praticien : TrecHISTO_Praticien;
         filler_7 : array[0..109] of Byte;
         id_client : TIntegerInfosoft;
         filler_4 : array[0..1] of Byte);
      2 :
        (code_cip : TCodeCip;
         designation : array[0..44] of AnsiChar;
         acte : array[0..2] of AnsiChar;
         filler_10 : array[0..5] of Byte;
         prix_vente : TDoubleInfosoft;
         prix_vente2 : TDoubleInfosoft;
         prix_vente3 : TDoubleInfosoft;
         filler_8 : array[0..25] of Byte;
         prix_achat : TDoubleInfosoft;
         quantite : TWordInfosoft;
         filler_9 : array[0..128] of Byte);
      3 :
        (filler_30 : array[0..3] of Byte;
         longueur_com3 : TWordInfosoft;
         commentaire3 : array[0..243] of AnsiChar);
      4 :
        (filler_40 : array[0..3] of Byte;
         longueur_com4 : TWordInfosoft;
         commentaire4 : array[0..243] of AnsiChar;)
    end;

{ THISTO }

constructor THISTO.Create(AFichier: TFichierBinaire);
begin
  inherited;

  FTailleBloc := 256;
end;

procedure THISTO.Remplit(var ABuffer);
var
  longueur_com : integer;
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecHISTO(ABuffer) do
  begin
    FTypeEntete := RenvoyerSInt(type_entete);
    FDateFacture := RenvoyerDate(date_facture);
    FNumeroOrdo := RenvoyerWrd(numero_ordo);
    case FTypeEntete of
      1 :
        begin
          FNomClient := client.nom;
          FPrenomClient := client.prenom;
          FDateNaissance := client.date_naissance;
          FNumeroInsee := client.numero_insee;
          FIDPraticien := praticien.id;
          FNomPrenomPraticien := praticien.nom_prenom;
          FNumeroFiness := RenvoyerDWrd(praticien.numero_finess);
          FDatePrescription := RenvoyerDate(date_prescription);
          FDateFacture := RenvoyerDate(date_facture);
          FIDClient := RenvoyerInt(id_client) + 1;
          FNumeroFacture := Renvoyerint(numero_facture) ;

          FCodeCIP := '';
          FDesignation := '';
          FQuantite := 0;
          FPrixVente := 0;
          FActe := '';
          FCommentaire := '';
        end;

      2 :
        begin
          if ( ord(code_cip[0]) = 243 )  then
            FCodeCip := RenvoyerCodeCIP13(code_cip)
          else
            FCodeCip := code_cip;
          FDesignation := designation;
          FQuantite := RenvoyerSInt(quantite);
          FPrixVente := RenvoyerFloat(prix_vente);
          FActe := acte;
        end;
      3 :
        begin
          longueur_com := RenvoyerSInt(longueur_com3);
          FCommentaire := StringToWideStringEx(copy(commentaire3 ,1, longueur_com) , 850); ;
        end;
      4 :
        begin
          longueur_com := RenvoyerSInt(longueur_com4);
          FCommentaire := StringToWideStringEx(copy(commentaire4 ,1, longueur_com) , 850); ;
        end;
    end;
  end;
end;

end.
