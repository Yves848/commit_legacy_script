unit mdlRechercheFournisseurRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, DB, ExtCtrls, Mask, Buttons,
  dbcgrids, mdlPIDBGrid, StrUtils, mdlBase, mdlProjet, mdlPISpeedButton;

type
  TfrmRechercheFournisseurRef = class(TfrmBase)
    dsFournisseursRef: TDataSource;
    dbGrdFournisseurRef : TPIDBGrid;
    procedure FormDestroy(Sender: TObject);
    procedure dbGrdFournisseurRefDblClick(Sender: TObject);
    procedure dbGrdFournisseurRefKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    destructor Destroy; override;
    function ShowModal(var AFournisseurRef : string) : Integer; reintroduce;
  end;

  function frmRechercheFournisseurRef : TfrmRechercheFournisseurRef;

implementation

uses mdlModuleImportPHA;

{$R *.dfm}

var
  FfrmRechercheFournisseurRef : TfrmRechercheFournisseurRef;

function frmRechercheFournisseurRef : TfrmRechercheFournisseurRef;
begin
  if not Assigned(FfrmRechercheFournisseurRef) then
    FfrmRechercheFournisseurRef := TfrmRechercheFournisseurRef.Create(Application.MainForm, TProjet(nil));
  Result := FfrmRechercheFournisseurRef
end;

procedure TfrmRechercheFournisseurRef.dbGrdFournisseurRefDblClick(
  Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
end;

procedure TfrmRechercheFournisseurRef.dbGrdFournisseurRefKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    ModalResult := mrOk;
end;

procedure TfrmRechercheFournisseurRef.FormDestroy(Sender: TObject);
begin
  inherited;

  if dmModuleImportPHA.setFournisseursRef.Active then dmModuleImportPHA.setFournisseursRef.Close;
end;

procedure TfrmRechercheFournisseurRef.FormCreate(Sender: TObject);
begin
  inherited;

  dsFournisseursRef.DataSet := dmModuleImportPHA.setFournisseursRef;
end;

procedure TfrmRechercheFournisseurRef.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //inherited;
end;

destructor TfrmRechercheFournisseurRef.Destroy;
begin
  FfrmRechercheFournisseurRef := nil;

  inherited;
end;

function TfrmRechercheFournisseurRef.ShowModal(var AFournisseurRef : string) : Integer;
begin
  dmModuleImportPHA.setFournisseursRef.Open;

  Result := inherited ShowModal;
  if Result = mrOk then
    AFournisseurRef := dmModuleImportPHA.setFournisseursRef.FieldByName('CODE').AsString
  else
    AFournisseurRef := '';

end;

initialization
  FfrmRechercheFournisseurRef := nil;

end.
