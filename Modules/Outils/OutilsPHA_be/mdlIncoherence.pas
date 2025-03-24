unit mdlIncoherence;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlDialogue, StdCtrls, ExtCtrls, ComCtrls, ImgList, ToolWin,
  Grids, DBGrids, mdlPIDBGrid, DB, uibdataset, ActnList;

type
  TfrmIncoherence = class(TfrmDialogue)
    pCtlIncohDonnees: TPageControl;
    tShIncohClients: TTabSheet;
    rgIncohClients: TRadioGroup;
    tShPurgeProduits: TTabSheet;
    rgIncohProduits: TRadioGroup;
    dsClients: TDataSource;
    dsProduits: TDataSource;
    iLstPageControl: TImageList;
    grdPurgeClients: TPIDBGrid;
    grdPurgeProduits: TPIDBGrid;
    procedure rgIncoherenceClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pCtlIncohDonneesChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure actImprimerExecute(Sender: TObject);
  private
    { Déclarations privées }
    FSQLClients, FSQLProduits : string;
    procedure ResetEtatIncoherence;
  public
    { Déclarations publiques }
  end;

var
  frmIncoherence: TfrmIncoherence;

const
  C_PAGE_CLIENTS = 0;
  C_PAGE_PRODUITS = 1;

  C_INHERENCE_CLIENTS_CLESS = 0;

  C_INHERENCE_PRODUITS_CLECIP = 0;
  C_INHERENCE_PRODUITS_PRIX = 1;

implementation

uses mdlPHA, mdlOutilsPHAPHA_be;

{$R *.dfm}

procedure TfrmIncoherence.pCtlIncohDonneesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;

  ResetEtatIncoherence;
end;

procedure TfrmIncoherence.rgIncoherenceClick(Sender: TObject);
begin
  inherited;

  if not dmOutilsPHAPHA_be.trDataset.InTransaction then
    dmOutilsPHAPHA_be.trDataset.StartTransaction;

  case pCtlIncohDonnees.ActivePageIndex of
    C_PAGE_CLIENTS :
      case rgIncohClients.ItemIndex of
        C_INHERENCE_CLIENTS_CLESS :
          with dmOutilsPHAPHA_be, setClients do
          begin
            Params.ByNameIsNull['ATYPE'] := True;
            Params.ByNameIsNull['APARAMETRE'] := True;
            AjouterWhere(SQL, 'f_cle_ss(substring(ANUMEROINSEE from 1 for 13)) = -1 and anumeroinsee is not null and anumeroinsee <> ' + '''' + '''');
            Open;
          end;
      end;

    C_PAGE_PRODUITS :
      case rgIncohProduits.ItemIndex of
        C_INHERENCE_PRODUITS_CLECIP :
          with dmOutilsPHAPHA_be, setProduits do
          begin
            Params.ByNameIsNull['ATYPE'] := True;
            Params.ByNameIsNull['APARAMETRE'] := True;
            AjouterWhere(SQL, 'f_cle_cip(substring(ACODECIP from 1 for 6)) = -1');
            Open;
          end;

        C_INHERENCE_PRODUITS_PRIX :
          with dmOutilsPHAPHA_be, setProduits do
          begin
            Params.ByNameIsNull['ATYPE'] := True;
            Params.ByNameIsNull['APARAMETRE'] := True;
            AjouterWhere(SQL, '(aprixvente < aprixachatcatalogue) or (aprixvente < apamp) or (aprixvente < aprixachatremise)');
            Open;
          end;
      end;
  end;
end;

procedure TfrmIncoherence.FormCreate(Sender: TObject);
begin
  inherited;

  pCtlIncohDonnees.ActivePageIndex := C_PAGE_CLIENTS;
  FSQLClients := dmOutilsPHAPHA_be.setClients.SQL.Text;
  FSQLProduits := dmOutilsPHAPHA_be.setProduits.SQL.Text;
end;

procedure TfrmIncoherence.FormDestroy(Sender: TObject);
begin
  dmOutilsPHAPHA_be.setProduits.SQL.Text := FSQLProduits;
  dmOutilsPHAPHA_be.setClients.SQL.Text := FSQLClients;

  ResetEtatIncoherence;

  inherited;
end;

procedure TfrmIncoherence.ResetEtatIncoherence;
begin
  with dmOutilsPHAPHA_be do
  begin
    if setProduits.Active then
      setProduits.Close;

    if setClients.Active then
      setClients.Close;

    if trDataset.InTransaction then
      trDataset.Commit;
  end;

  rgIncohClients.ItemIndex := -1;
  rgIncohProduits.ItemIndex := -1;
end;

procedure TfrmIncoherence.actImprimerExecute(Sender: TObject);
begin
  inherited;

  case pCtlIncohDonnees.ActivePageIndex of
    C_PAGE_CLIENTS : dmOutilsPHAPHA_be.impDonnees.Imprimer(grdPurgeClients.GenererImpression);
    C_PAGE_PRODUITS : dmOutilsPHAPHA_be.impDonnees.Imprimer(grdPurgeProduits.GenererImpression);
  end;
end;

end.
