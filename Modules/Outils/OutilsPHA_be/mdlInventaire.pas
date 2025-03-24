unit mdlInventaire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlDialogue, DB, Grids, DBGrids, mdlPIDBGrid, ActnList, ImgList,
  StdCtrls, ExtCtrls, uibdataset, mdlPHA;

type
  TfrmInventaire = class(TfrmDialogue)
    grdInventaire: TPIDBGrid;
    dsInventaire: TDataSource;
    pnlTotaux: TPanel;
    txtTotalPAHT: TStaticText;
    txtTotalPVTCC: TStaticText;
    txtTotalPAMP: TStaticText;
    txtTotalNbProduits: TStaticText;
    txtTotalNbUnites: TStaticText;
    lblTotaux: TLabel;
    rgPriorite: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
    procedure rgPrioriteClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmInventaire: TfrmInventaire;

implementation

uses mdlOutilsPHAPHA_be;

{$R *.dfm}

procedure TfrmInventaire.FormCreate(Sender: TObject);
begin
  inherited;

  dmOutilsPHAPHA_be.setInventaire.Transaction.StartTransaction;
  rgPrioriteClick(Self);
end;

procedure TfrmInventaire.FormDestroy(Sender: TObject);
begin
  inherited;

  with dmOutilsPHAPHA_be.setInventaire do
    if Active then
    begin
      Close;
      Transaction.Commit;
    end;
end;

procedure TfrmInventaire.actImprimerExecute(Sender: TObject);
begin
  inherited;

  grdInventaire.Imprimer;
end;

procedure TfrmInventaire.rgPrioriteClick(Sender: TObject);
const
  C_PRIORITE_TOUS_DEPOT = 0;
  C_PRIORITE_DEPOT_PHARMACIE = 1;
  C_PRIORITE_DEPOT_RESERVE = 2;
var
  lSgTotalPAHT, lSgTotalPVTTC, lSgTotalPAMP : Single;
  lIntTotalNbProduits, lIntTotalNbUnites : Integer;
begin
  inherited;

  with dmOutilsPHAPHA_be.setInventaire do
  begin
    Close;
    case rgPriorite.ItemIndex of
      C_PRIORITE_TOUS_DEPOT : AjouterWhere(SQL, '');
      C_PRIORITE_DEPOT_PHARMACIE : AjouterWhere(SQL, 'priorite = 1');
      C_PRIORITE_DEPOT_RESERVE : AjouterWhere(SQL, 'priorite = 0');
    end;
    Open;
  end;

  // Calcul des totaux
  with dmOutilsPHAPHA_be.setInventaire do
  begin
    DisableControls;
    First;

    lSgTotalPAHT := 0; lSgTotalPVTTC := 0; lSgTotalPAMP := 0;
    lIntTotalNbProduits := 0; lIntTotalNbUnites := 0;
    while not EOF do
    begin
      lSgTotalPAHT := lSgTotalPAHT + FieldByName('TOTAL_PRIX_ACHAT_CATALOGUE').AsFloat;
      lSgTotalPVTTC := lSgTotalPVTTC + FieldByName('TOTAL_PRIX_ACHAT_CATALOGUE').AsFloat;
      lSgTotalPAMP := lSgTotalPAMP + FieldByName('TOTAL_PRIX_ACHAT_CATALOGUE').AsFloat;

      lIntTotalNbProduits := lIntTotalNbProduits + FieldByName('NB_PRODUITS').AsInteger;
      lIntTotalNbUnites := lIntTotalNbUnites + FieldByName('NB_UNITES').AsInteger;
      Next;
    end;
    First;
    EnableControls;
  end;

  txtTotalPAHT.Caption := FormatFloat('#.00', lSgTotalPAHT);
  txtTotalPVTCC.Caption := FormatFloat('#.00', lSgTotalPVTTC);
  txtTotalPAMP.Caption := FormatFloat('#.00', lSgTotalPAMP);
  txtTotalNbProduits.Caption := IntToStr(lIntTotalNbProduits);
  txtTotalNbUnites.Caption := IntToStr(lIntTotalNbUnites);
end;

end.
