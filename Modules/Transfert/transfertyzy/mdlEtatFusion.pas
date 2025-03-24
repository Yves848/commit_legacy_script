unit mdlEtatFusion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, DB, MemDS, DBAccess,
  Ora, OraSmart, mdlBase, mdlPIDBGrid, JvDBGridFooter, JvExStdCtrls, JvEdit,
  JvDBSearchEdit;

type
  TEtatFusion = (efTous, efCree, efFusionne, efReconnu);
  TCodeEtatFusion = array[TEtatFusion] of string;

  TfrmEtatFusion = class(TfrmBase)
    DataSource1: TDataSource;
    SmartQuery1: TSmartQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TPIDBGrid;
    Button1: TButton;
    SmartQuery2: TSmartQuery;
    DataSource2: TDataSource;
    RadioGroup1: TRadioGroup;
    DBGrid2: TPIDBGrid;
    SmartQuery1T_CLIENT_ID: TIntegerField;
    SmartQuery1NUMERO_INSEE: TStringField;
    SmartQuery1DATE_NAISSANCE: TStringField;
    SmartQuery1RANG_GEMELLAIRE: TIntegerField;
    SmartQuery1AMO: TStringField;
    SmartQuery1AMC: TStringField;
    SmartQuery1DECODEETATFFUSIONNÉRRECONNUCRÉE: TStringField;
    SmartQuery2T_PRODUIT_ID: TFloatField;
    SmartQuery2CODE_CIP: TStringField;
    SmartQuery2CODE_CIP7: TStringField;
    SmartQuery2DESIGNATION: TStringField;
    SmartQuery2DECODEETATFFUSIONNÉRRECONNUCRÉE: TStringField;
    SmartQuery1NOM_PRENOM: TStringField;
    SmartQuery1ETAT: TStringField;
    SmartQuery2ETAT: TStringField;
    HeaderControl1: THeaderControl;
    Panel1: TPanel;
    JvDBSearchEdit1: TJvDBSearchEdit;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    JvDBSearchEdit2: TJvDBSearchEdit;
    JvDBSearchEdit3: TJvDBSearchEdit;
    JvDBSearchEdit4: TJvDBSearchEdit;
    JvDBSearchEdit5: TJvDBSearchEdit;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Déclarations privées }
    FNbClientsFusionnes, FNbClientsCrees, FNbClientsReconnus : Integer;
    FNbProduitsFusionnes, FNbProduitsCrees, FNbProduitsReconnus : Integer;
    const CodeEtatFusion : TCodeEtatFusion = ('', 'C', 'F', 'R');
    procedure CalculerEtatFusion;
  public
    { Déclarations publiques }
  end;

var
  frmEtatFusion: TfrmEtatFusion;

implementation

{$R *.dfm}

const
  C_RADIO_ETAT_TOUS = 0;
  C_RADIO_ETAT_CREE = 1;
  C_RADIO_ETAT_FUSIONNEE = 2;
  C_RADIO_ETAT_RECONNU = 3;

  C_PAGE_CLIENTS_FUSIONNES = 0;
  C_PAGE_PRODUITS_FUSIONNES = 1;

procedure TfrmEtatFusion.CalculerEtatFusion;
begin
  // Clients
  with SmartQuery1 do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if SmartQuery1ETAT.AsString = 'C' then
        Inc(FNbClientsCrees)
      else if SmartQuery1ETAT.AsString = 'F' then
        Inc(FNbClientsFusionnes)
      else if SmartQuery1ETAT.AsString = 'R' then
        Inc(FNbClientsReconnus);
      Next;
    end;
    First;
    EnableControls;
  end;

  // Produits
  with SmartQuery1 do
  begin
    DisableControls;
    First;
    while not EOF do
    begin
      if SmartQuery2ETAT.AsString = 'C' then
        Inc(FNbProduitsCrees)
      else if SmartQuery2ETAT.AsString = 'F' then
        Inc(FNbProduitsFusionnes)
      else if SmartQuery2ETAT.AsString = 'R' then
        Inc(FNbProduitsReconnus);
      Next;
    end;
    First;
    EnableControls;
  end;
  PageControl1Change(nil);
end;

procedure TfrmEtatFusion.FormCreate(Sender: TObject);
begin
  SmartQuery1.Session := Projet.ERPConnexion as TOraSession;
  SmartQuery1.Open;

  SmartQuery2.Session := Projet.ERPConnexion as TOraSession;
  SmartQuery2.Open;

  CalculerEtatFusion;
end;

procedure TfrmEtatFusion.FormDestroy(Sender: TObject);
begin
  inherited;

  SmartQuery2.Close;
  SmartQuery1.Close;
end;

procedure TfrmEtatFusion.PageControl1Change(Sender: TObject);
const
  C_STATUSBAR_FUSIONNES = 1;
  C_STATUSBAR_CREES = 3;
  C_STATUSBAR_RECONNUS = 5;
begin
  inherited;

  case PageControl1.ActivePageIndex of
    C_PAGE_CLIENTS_FUSIONNES :
      begin
        HeaderControl1.Sections[C_STATUSBAR_CREES].Text := IntToStr(FNbClientsCrees);
        HeaderControl1.Sections[C_STATUSBAR_FUSIONNES].Text := IntToStr(FNbClientsFusionnes);
        HeaderControl1.Sections[C_STATUSBAR_RECONNUS].Text := IntToStr(FNbClientsReconnus);
      end;

    C_PAGE_PRODUITS_FUSIONNES :
      begin
        HeaderControl1.Sections[C_STATUSBAR_CREES].Text := IntToStr(FNbProduitsCrees);
        HeaderControl1.Sections[C_STATUSBAR_FUSIONNES].Text := IntToStr(FNbProduitsFusionnes);
        HeaderControl1.Sections[C_STATUSBAR_RECONNUS].Text := IntToStr(FNbProduitsReconnus);
      end;
  end;
end;

procedure TfrmEtatFusion.RadioGroup1Click(Sender: TObject);
const
  C_CHAINE_VIDE = '''''';
var
  e : string;
begin
  e := '''' + CodeEtatFusion[TEtatFusion(RadioGroup1.ItemIndex)] + '''';

  case PageControl1.ActivePageIndex of
    C_PAGE_CLIENTS_FUSIONNES :
      begin
        SmartQuery1.DeleteWhere();
        if e <> C_CHAINE_VIDE then
          SmartQuery1.AddWhere('etat = ' + e);
        SmartQuery1.Open;
      end;

    C_PAGE_PRODUITS_FUSIONNES :
      begin
        SmartQuery2.DeleteWhere();
        if e <> C_CHAINE_VIDE then
          SmartQuery2.AddWhere('etat = ' + e);
        SmartQuery2.Open;
      end;
  end;
end;

end.
