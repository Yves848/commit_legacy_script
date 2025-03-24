unit mdlRechercheOrganismesAMORef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Grids, DBGrids, Buttons, ExtCtrls, DBCtrls, Mask,
  mdlPIDBGrid, mdlBase, mdlPISpeedButton, mdlProjet, StrUtils;

type
  TfrmRechercheOrganismesAMORef = class(TfrmBase)
    dbGrdOrganismesRefAMO: TPIDBGrid;
    dsOrganismesAMORef: TDataSource;
    pnlCritere: TPanel;
    gBoxOrgAMO: TGroupBox;
    dsOrganismeAMO: TDataSource;
    lblNomReduit: TLabel;
    edtNomReduit: TDBEdit;
    lblIdentifiantNational: TLabel;
    lblAdresse: TLabel;
    edtRue1: TDBEdit;
    edtRue2: TDBEdit;
    edtCP: TDBEdit;
    lblCP: TLabel;
    edtNomVille: TDBEdit;
    mmCommentaire: TDBMemo;
    lblCommentaire: TLabel;
    lblNom: TLabel;
    edtNom: TDBEdit;
    lblVille: TLabel;
    bvlSeparateur_1: TBevel;
    bvlSeparateur_2: TBevel;
    gBoxSelection: TGroupBox;
    lblCritere: TLabel;
    edtCritere: TEdit;
    edtIdNational: TEdit;
    btnChercher: TPISpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure dbGrdOrganismesRefAMODblClick(Sender: TObject);
    procedure dbGrdOrganismesRefAMOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCritereKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnChercherClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(ACritere : string; var AIdentifiantNational: string) : Integer; reintroduce;
    destructor Destroy; override;
  end;

  function frmRechercheOrganismesAMORef: TfrmRechercheOrganismesAMORef;

implementation

uses mdlModuleImportPHA;

{$R *.dfm}

var
  FfrmRechercheOrganismesAMORef : TfrmRechercheOrganismesAMORef;

function frmRechercheOrganismesAMORef: TfrmRechercheOrganismesAMORef;
begin
  if not Assigned(FfrmRechercheOrganismesAMORef) then
    FfrmRechercheOrganismesAMORef := TfrmRechercheOrganismesAMORef.Create(Application.MainForm, TProjet(nil));
  Result := FfrmRechercheOrganismesAMORef;
end;

procedure TfrmRechercheOrganismesAMORef.FormDestroy(Sender: TObject);
begin
  inherited;

  if dmModuleImportPHA.setOrganismesAMORef.Active then dmModuleImportPHA.setOrganismesAMORef.Close;
end;

procedure TfrmRechercheOrganismesAMORef.edtCritereKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    btnChercher.Click;
end;

procedure TfrmRechercheOrganismesAMORef.dbGrdOrganismesRefAMODblClick(
  Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
end;

procedure TfrmRechercheOrganismesAMORef.dbGrdOrganismesRefAMOKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if key = VK_RETURN then
    ModalResult := mrOk;
end;

function TfrmRechercheOrganismesAMORef.ShowModal(ACritere : string;
  var AIdentifiantNational: string) : Integer;
var
  lWrdTouche : WORD;
begin
  if VarIsNull(dmModuleImportPHA.setConversionsOrganismesAMOIDENTIFIANT_NATIONAL.OldValue) then
    edtIdNational.Text := ''
  else
    edtIdNational.Text := dmModuleImportPHA.setConversionsOrganismesAMOIDENTIFIANT_NATIONAL.OldValue;

  // Lancement de la recherche
  lWrdTouche := VK_RETURN; edtCritere.Text := ACritere;
  edtCritereKeyDown(Self, lWrdTouche, []);
  Result := inherited ShowModal;
  if Result = mrOk then
    AIdentifiantNational := dmModuleImportPHA.setOrganismesAMORefREGIME.AsString +
                            dmModuleImportPHA.setOrganismesAMORefCAISSE_GESTIONNAIRE.AsString +
                            dmModuleImportPHA.setOrganismesAMORefCENTRE_GESTIONNAIRE.AsString
  else
    AIdentifiantNational := '';
end;

procedure TfrmRechercheOrganismesAMORef.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //inherited;
end;

procedure TfrmRechercheOrganismesAMORef.FormCreate(Sender: TObject);
begin
  inherited;

  dsOrganismeAMO.DataSet := dmModuleImportPHA.setConversionsOrganismesAMO;
  dsOrganismesAMORef.DataSet := dmModuleImportPHA.setOrganismesAMORef;
end;

procedure TfrmRechercheOrganismesAMORef.btnChercherClick(Sender: TObject);
begin
  inherited;

  with dmModuleImportPHA.setOrganismesAMORef do
  begin
    Close;
    Params.ByNameAsString['ANOM'] := Copy(StringReplace(edtCritere.Text, '*', '%', [rfReplaceAll]), 1, 50);
    Params.ByNameAsString['AIDENTIFIANTNATIONAL'] := Copy(StringReplace(edtCritere.Text, '*', '%', [rfReplaceAll]), 1, 9);
    Open;

    //dbGrdOrganismesRefAMO.SetFocus;
  end;
end;

destructor TfrmRechercheOrganismesAMORef.Destroy;
begin
  FfrmRechercheOrganismesAMORef := nil;
  
  inherited;
end;

initialization
  FfrmRechercheOrganismesAMORef := nil;

end.
