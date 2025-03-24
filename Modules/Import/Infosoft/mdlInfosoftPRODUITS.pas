unit mdlInfosoftPRODUITS;

interface

uses
  mdlLectureFichierBinaire, mdlInfosoftLectureFichier , mdlTypes , sysutils ;

type
  TPRODUITS = class(TDonneesFormatees)
  private
    FnumeroEnregistrement : integer;
    FCodeCip: string;
    FCodeEan: string;
    FDesignation: string;
    FPrestation : string;
    Fliste : string;
    FCodetva : string;
    FCodeLabo : string;
    FCodeTipsLpp : string;
    FPrixAchat : double;
    FPrixAchatRemise : double;
    FBaseRemboursement : double;
    FPrixVente : double;
    FPamp : double;
    FFournisseur1 : string;
    FFournisseur2 : string;
    FFournisseur3 : string;
    FDatetest : integer;
    FDateDerniereVente : TDateTime;
    FZoneGeo : string;
    FStock : integer;
    FStockMini : integer;
    FStockMaxi : integer;
    FVente: TPIList<Integer>;
    FAchatFournisseur: TPIList<string>;
    FAchatPrix: TPIList<double>;
    FAchatDate: TPIList<Tdatetime>;
    FAchatQuantite: TPIList<integer>;
    Frepartiteur : string;
    FSupprime : boolean;
  published
    public
      constructor Create(AFichier : TFichierBinaire); override;
      procedure Remplit(var ABuffer); override;
      destructor Destroy; override;
    published
      property NumeroEnregistrement : integer read FNumeroEnregistrement;
      property CodeCip : string read FCodeCip;
      property CodeEan : string read FCodeEan;
      property Designation : string read FDesignation;
      property Prestation : string read FPrestation;
      property liste : string read FListe;
      property CodeTva : string read FCodeTva;
      property CodeLabo : string read FCodeLabo;
      property CodeTipsLpp : string read FCodeTipsLpp;
      property BaseRemboursement : double read FBaseRemboursement;
      property PrixAchat : double read FPrixAchat;
      property PrixAchatRemise : double read FPrixAchatRemise;
      property PrixVente : double read FPrixVente;
      property Pamp : double read Fpamp;
      property fournisseur1 : string read Ffournisseur1;
      property fournisseur2 : string read Ffournisseur2;
      property fournisseur3 : string read Ffournisseur3;
      property DateDerniereVente : TDatetime read FDateDerniereVente;
      property datetest : integer read FDatetest;
      property zonegeo: string read Fzonegeo;
      property stock : integer read Fstock;
      property stockMini : integer read FstockMini;
      property stockMaxi : integer read FstockMaxi;
      property Repartiteur: string read FRepartiteur;
      property Vente : TPIList<Integer> read FVente;
      property AchatFournisseur : TPIList<string> read FAchatFournisseur;
      property AchatPrix : TPIList<double> read FAchatPrix;
      property AchatDate : TPIList<TdateTime> read FAchatDate;
      property AchatQuantite : TPIList<Integer> read FAchatQuantite;
      property supprime : boolean read FSupprime;
  end;


implementation

type
  TrecACHATS = record
    fournisseur : array[0..3] of AnsiChar;
    prix_achat : TDoubleinfosoft;
    date_achat : TDateInfosoft;
    Quantite : TWordInfosoft;
    filler :  array[0..5] of byte;
  end;

  TrecPRODUITS = record
    code_cip : TCodeCip;
    code_ean : array[0..12] of AnsiChar;
    designation : array[0..44] of AnsiChar;
    code_prestation : array[0..2] of AnsiChar;
    filler_1 : array[0..1] of AnsiChar;
    liste : AnsiChar;
    code_tva : AnsiChar;
    code_labo : AnsiChar;
    filler_2 :  array[0..3] of AnsiChar;
    code_tips_lpp : array[0..12] of AnsiChar;
    base_remboursement : TDoubleinfosoft;
    prix_vente : TDoubleinfosoft;
    //prix_3 : TDoubleinfosoft;
    filler_3 : array[0..9] of AnsiChar;
    zone_geo : array[0..4] of AnsiChar;
    filler_3bis : AnsiChar;
    fournisseur_1 : array[0..3] of AnsiChar;
    fournisseur_2 : array[0..3] of AnsiChar;
    fournisseur_3 : array[0..3] of AnsiChar;
    filler_4 :  array[0..13] of AnsiChar;
    date_derniere_vente : TDateInfosoft;
    ventes : Array[0..23] of TWordInfosoft;
    filler_7 :  array[0..457] of AnsiChar;
    achats :  array[0..17] of TrecACHATS;
    quantite_stock : TWordInfosoft;
    filler_8 :  array[0..5] of AnsiChar;
    stock_mini : TWordInfosoft;
    stock_maxi : TWordInfosoft;
    filler_9 :  array[0..5] of AnsiChar;
    prix_achat_1  : TDoubleinfosoft;
    prix_achat_2  : TDoubleinfosoft;
    filler_10 :  array[0..3] of AnsiChar;
    prix_achat : TDoubleinfosoft;
    prix_vente_2 : TDoubleinfosoft;
    filler_11 :  array[0..17] of AnsiChar;
    repartiteur : array[0..3] of AnsiChar;
    filler_12 :  array[0..252] of AnsiChar;
    Flag_supprime : byte;
  end;

  TrecComProd = record
    code_cip : TCodeCip;
    numero : AnsiChar;
    flag1 : byte;
    flag2 : byte;
    longueur : TWordInfosoft;
    commentaire :  array[0..191] of AnsiChar;
  end;

constructor TPRODUITS.Create(AFichier: TFichierBinaire);
begin
  FVente := TPIList<Integer>.Create(24);
  FAchatFournisseur := TPIList<string>.Create(18);
  FAchatPrix := TPIList<double>.Create(18);
  FAchatQuantite := TPIList<integer>.Create(18);
  FAchatDate := TPIList<TDateTime>.Create(18);

  inherited;

  FTailleBloc := 1408;
end;

procedure TPRODUITS.Remplit(var ABuffer);
var i : integer;
begin
  inherited;

  with TFichierInfosoft(Fichier), TrecPRODUITS(ABuffer) do
  begin
    FnumeroEnregistrement := EnregNo;
    // si le premier demi octet est F ( de F0 a FF ) alors c'est un codecip13
    if ( ord(code_cip[0]) >= 240 )  then
      FCodeCip := RenvoyerCodeCIP13(code_cip)
    else
      FCodeCip := code_cip;

    FCodeEan := code_ean;
    FDesignation := designation;
    FPrestation := code_prestation;
    FListe := liste;
    FCodetva := code_tva;
    FCodeLabo := code_labo;
    FCodeTipsLpp := code_tips_lpp;
    FBaseRemboursement := RenvoyerFloat(base_remboursement);
    FPrixAchat := RenvoyerFloat(prix_achat);
    FPrixAchatRemise := RenvoyerFloat(prix_achat_1);
    FPrixVente := RenvoyerFloat(prix_vente);
    FDateDerniereVente := RenvoyerDate(date_derniere_vente);
    FPamp :=  RenvoyerFloat(prix_achat_2);
    FFournisseur1 := fournisseur_1;
    FFournisseur2 := fournisseur_2;
    FFournisseur3 := fournisseur_3;
    FZoneGeo := zone_geo;
    FStock := RenvoyerSInt(quantite_stock);
    FStockMini := RenvoyerSInt(stock_mini);
    FStockMaxi := RenvoyerSInt(stock_maxi);
    for i := 0 to 23 do FVente[i]  := RenvoyerSInt(Ventes[i]);

  with TrecACHATS(ABuffer) do
  begin
    for i := 0 to 17 do
    begin
      FAchatFournisseur[i] := trim(achats[i].fournisseur);
      if copy(FAchatFournisseur[i],1,1) <> 'A' then  FAchatFournisseur[i] := '';

      FAchatPrix[i] := RenvoyerFloat(achats[i].prix_achat);
      FAchatQuantite[i] := RenvoyerSInt(achats[i].quantite);
      FAchatDate[i] := RenvoyerDate(achats[i].date_achat);
      if FAchatDate[i] >= now then  FAchatDate[i]:=0;

    end;
  end;

    Frepartiteur := repartiteur;
    FSupprime := flag_supprime =1 ;
  end;



end;

destructor TPRODUITS.Destroy;
begin
  if Assigned(FVente) then FreeAndNil(FVente);
  if Assigned(FAchatFournisseur) then FreeAndNil(FAchatFournisseur);
  if Assigned(FAchatPrix) then FreeAndNil(FAchatPrix);
  if Assigned(FAchatQuantite) then FreeAndNil(FAchatQuantite);
  if Assigned(FAchatDate) then FreeAndNil(FAchatDate);
  inherited;
end;


end.
