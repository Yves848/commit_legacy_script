unit mdlRechercheCouverturesAMORef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, DB, ExtCtrls, Mask, Buttons,
  dbcgrids, mdlPIDBGrid, StrUtils, mdlBase, mdlProjet, mdlPISpeedButton;

type
  TfrmRechercheCouverturesAMORef = class(TfrmBase)
    dbGrdCouverturesRefAMO: TPIDBGrid;
    pnlOrganisme: TPanel;
    gBoxSelection: TGroupBox;
    lblCritere: TLabel;
    edtCritere: TEdit;
    gBoxCouvAMO: TGroupBox;
    edtCodeCouvertureAMO: TDBEdit;
    edtLibelleCouvertureAMO: TDBEdit;
    gBoxOrgAMO: TGroupBox;
    lblIdentifiantNational: TLabel;
    lblNom: TLabel;
    edtNom: TDBEdit;
    edtIdNational: TDBEdit;
    dsCouverturesAMORef: TDataSource;
    Label1: TLabel;
    edtNatureAssurance: TDBEdit;
    Label2: TLabel;
    bvlSeparateur_1: TBevel;
    grdPrestations: TPIDBGrid;
    dsPrestationsAMO: TDataSource;
    btnChercher: TPISpeedButton;
    dsCouvertureAMO: TDataSource;
    DBEdit1: TDBEdit;
    procedure FormDestroy(Sender: TObject);
    procedure dbGrdCouverturesRefAMODblClick(Sender: TObject);
    procedure dbGrdCouverturesRefAMOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCritereKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnChercherClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(ACritere : string;
      var ACodeCouverture: string) : Integer; reintroduce;
    destructor Destroy; override;
  end;

  function frmRechercheCouverturesAMORef : TfrmRechercheCouverturesAMORef;

implementation

uses mdlModuleImportPHA;

{$R *.dfm}

var
  FfrmRechercheCouverturesAMORef : TfrmRechercheCouverturesAMORef;

function frmRechercheCouverturesAMORef : TfrmRechercheCouverturesAMORef;
begin
  if not Assigned(FfrmRechercheCouverturesAMORef) then
    FfrmRechercheCouverturesAMORef := TfrmRechercheCouverturesAMORef.Create(Application.MainForm, TProjet(nil));
  Result := FfrmRechercheCouverturesAMORef
end;

procedure TfrmRechercheCouverturesAMORef.edtCritereKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    btnChercher.Click;
end;

procedure TfrmRechercheCouverturesAMORef.dbGrdCouverturesRefAMODblClick(
  Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
end;

procedure TfrmRechercheCouverturesAMORef.dbGrdCouverturesRefAMOKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    ModalResult := mrOk;
end;

procedure TfrmRechercheCouverturesAMORef.FormDestroy(Sender: TObject);
begin
  inherited;

  if dmModuleImportPHA.setCouverturesAMORef.Active then dmModuleImportPHA.setCouverturesAMORef.Close;
end;

function TfrmRechercheCouverturesAMORef.ShowModal(ACritere : string;
  var ACodeCouverture: string) : Integer;
var
  lWrdTouche : WORD;
begin
  if VarIsNull(dmModuleImportPHA.setConversionsCouverturesAMOCODE_COUVERTURE.OldValue) then
    edtCritere.Text := ''
  else
    edtCritere.Text := dmModuleImportPHA.setConversionsCouverturesAMOCODE_COUVERTURE.OldValue;

  lWrdTouche := VK_RETURN; edtCritere.Text := ACritere;
  edtCritereKeyDown(Self, lWrdTouche, []);
  Result := inherited ShowModal;
  if Result = mrOk then
    ACodeCouverture := dmModuleImportPHA.setCouverturesAMORef.FieldByName('Code SV').AsWideString
  else
    ACodeCouverture := '';
end;

procedure TfrmRechercheCouverturesAMORef.FormCreate(Sender: TObject);
begin
  inherited;

  dsCouvertureAMO.DataSet := dmModuleImportPHA.setConversionsCouverturesAMO;
  dsCouverturesAMORef.DataSet := dmModuleImportPHA.setCouverturesAMORef;
  dsPrestationsAMO.DataSet := dmModuleImportPHA.setPrestations;
end;

procedure TfrmRechercheCouverturesAMORef.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //inherited;
end;

procedure TfrmRechercheCouverturesAMORef.btnChercherClick(Sender: TObject);
var
  lStrCritere : string;
begin
  inherited;

  with dmModuleImportPHA.setCouverturesAMORef do
  begin
    Close;
    lStrCritere := StringReplace(edtCritere.Text, '*', '%', [rfReplaceAll]);
    Params.ByNameAsString['AREGIME'] := Copy(edtIdNational.Text, 1, 2);
    Params.ByNameAsString['ACODECOUVERTURE'] := Copy(lStrCritere, 1, 5);
    Open;

    dbGrdCouverturesRefAMO.Columns[0].Visible := False;
    dbGrdCouverturesRefAMO.AjusterLargeurColonnes;
  end;
end;

destructor TfrmRechercheCouverturesAMORef.Destroy;
begin
  FfrmRechercheCouverturesAMORef := nil;

  inherited;
end;

initialization
  FfrmRechercheCouverturesAMORef := nil;

end.
