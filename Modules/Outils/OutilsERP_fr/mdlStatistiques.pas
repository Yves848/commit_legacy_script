unit mdlStatistiques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ImgList, ComCtrls, DBGrids, DB, mdlPIDBGrid, StdCtrls,
  mdlDialogue, ActnList, ExtCtrls;

type
  TfrmStatistiques = class(TfrmDialogue)
    tShClients: TTabSheet;
    tShProduits: TTabSheet;
    iLstPageControl: TImageList;
    pCtrlStat: TPageControl;
    dbGrdStatCliOrg: TPIDBGrid;
    dsOrgStat: TDataSource;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActionList2: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    grdInventaire: TPIDBGrid;
    pnlTotaux: TPanel;
    lblTotaux: TLabel;
    txtTotalPAHT: TStaticText;
    txtTotalPVTCC: TStaticText;
    txtTotalPAMP: TStaticText;
    txtTotalNbProduits: TStaticText;
    txtTotalNbUnites: TStaticText;
    rgPriorite: TRadioGroup;
    dsInventaire: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure rgPrioriteClick(Sender: TObject);
    procedure pCtrlStatChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pCtrlStatChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmStatistiques: TfrmStatistiques;

const
  C_PAGE_STATISTIQUE_ORGANISMES = 0;
  C_PAGE_STATISTIQUE_PRODUITS = 1;

implementation

uses mdlOutilsERPERP_fr, DBAccess;

{$R *.dfm}

procedure TfrmStatistiques.FormCreate(Sender: TObject);
begin
  inherited;

  // Page de démarrage
  pCtrlStat.ActivePageIndex := 0;
  pCtrlStatChange(Self);
end;

procedure TfrmStatistiques.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmStatistiques.FormDestroy(Sender: TObject);
begin
  // Fermeture des vues
  with dmOutilsERPERP_fr do
  begin
    if qryOrgStat.Active then qryOrgStat.Close;
    if qryProdStat.Active then qryProdStat.Close;
  end;
end;

procedure TfrmStatistiques.rgPrioriteClick(Sender: TObject);
const
  C_PRIORITE_TOUS_DEPOT = 0;
  C_PRIORITE_DEPOT_PHARMACIE = 1;
  C_PRIORITE_DEPOT_RESERVE = 2;
var
  lSgTotalPAHT, lSgTotalPVTTC, lSgTotalPAMP : Single;
  lIntTotalNbProduits, lIntTotalNbUnites : Integer;
begin
  inherited;

  with dmOutilsERPERP_fr.qryProdStat do
  begin
    Close;
    DeleteWhere;
    case rgPriorite.ItemIndex of
      C_PRIORITE_DEPOT_PHARMACIE : AddWhere('priorite = 1');
      C_PRIORITE_DEPOT_RESERVE : AddWhere('priorite = 0');
    end;
    Open;
  end;

  // Calcul des totaux
  with dmOutilsERPERP_fr.qryProdStat do
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

procedure TfrmStatistiques.pCtrlStatChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;

  case pCtrlStat.ActivePageIndex of
    C_PAGE_STATISTIQUE_ORGANISMES : dmOutilsERPERP_fr.qryOrgStat.Close;
    C_PAGE_STATISTIQUE_PRODUITS : dmOutilsERPERP_fr.qryProdStat.Close;
  end;
end;

procedure TfrmStatistiques.pCtrlStatChange(Sender: TObject);
begin
  inherited;

  case pCtrlStat.ActivePageIndex of
    C_PAGE_STATISTIQUE_ORGANISMES : dmOutilsERPERP_fr.qryOrgStat.Open;
    C_PAGE_STATISTIQUE_PRODUITS : rgPrioriteClick(Self);
  end;
end;

end.
