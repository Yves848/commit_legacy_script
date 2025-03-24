unit mdlRechercheRepartiteurRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, DB, ExtCtrls, Mask, Buttons,
  dbcgrids, mdlPIDBGrid, StrUtils, mdlBase, mdlProjet, mdlPISpeedButton;

type
  TfrmRechercheRepartiteurRef = class(TfrmBase)
    dsRepartiteursRef: TDataSource;
    dbGrdRepartiteurRef : TPIDBGrid;
    procedure FormDestroy(Sender: TObject);
    procedure dbGrdRepartiteurRefDblClick(Sender: TObject);
    procedure dbGrdRepartiteurRefKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    destructor Destroy; override;
    function ShowModal(var ARepartiteurRef : string) : Integer; reintroduce;
  end;

  function frmRechercheRepartiteurRef : TfrmRechercheRepartiteurRef;

implementation

uses mdlModuleImportPHA;

{$R *.dfm}

var
  FfrmRechercheRepartiteurRef : TfrmRechercheRepartiteurRef;

function frmRechercheRepartiteurRef : TfrmRechercheRepartiteurRef;
begin
  if not Assigned(FfrmRechercheRepartiteurRef) then
    FfrmRechercheRepartiteurRef := TfrmRechercheRepartiteurRef.Create(Application.MainForm, TProjet(nil));
  Result := FfrmRechercheRepartiteurRef
end;

procedure TfrmRechercheRepartiteurRef.dbGrdRepartiteurRefDblClick(
  Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
end;

procedure TfrmRechercheRepartiteurRef.dbGrdRepartiteurRefKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    ModalResult := mrOk;
end;

procedure TfrmRechercheRepartiteurRef.FormDestroy(Sender: TObject);
begin
  inherited;

  if dmModuleImportPHA.setRepartiteursRef.Active then dmModuleImportPHA.setRepartiteursRef.Close;
end;

procedure TfrmRechercheRepartiteurRef.FormCreate(Sender: TObject);
begin
  inherited;

  dsRepartiteursRef.DataSet := dmModuleImportPHA.setRepartiteursRef;
end;

procedure TfrmRechercheRepartiteurRef.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //inherited;
end;

destructor TfrmRechercheRepartiteurRef.Destroy;
begin
  FfrmRechercheRepartiteurRef := nil;

  inherited;
end;

function TfrmRechercheRepartiteurRef.ShowModal(var ARepartiteurRef : string) : Integer;
begin
  dmModuleImportPHA.setRepartiteursRef.Open;

  Result := inherited ShowModal;
  if Result = mrOk then
    ARepartiteurRef := dmModuleImportPHA.setRepartiteursRef.FieldByName('CODE').AsString
  else
    ARepartiteurRef := '';

end;

initialization
  FfrmRechercheRepartiteurRef := nil;

end.
