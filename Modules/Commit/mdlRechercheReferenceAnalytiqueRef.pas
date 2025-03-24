unit mdlRechercheReferenceAnalytiqueRef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, DB, ExtCtrls, Mask, Buttons,
  dbcgrids, mdlPIDBGrid, StrUtils, mdlBase, mdlProjet, mdlPISpeedButton;

type
  TfrmRechercheReferenceAnalytiqueRef = class(TfrmBase)
    dsReferenceAnalytiquesRef: TDataSource;
    dbGrdReferenceAnalytiqueRef : TPIDBGrid;
    procedure FormDestroy(Sender: TObject);
    procedure dbGrdReferenceAnalytiqueRefDblClick(Sender: TObject);
    procedure dbGrdReferenceAnalytiqueRefKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    destructor Destroy; override;
    function ShowModal(var AReferenceAnalytiqueRef : string) : Integer; reintroduce;
  end;

  function frmRechercheReferenceAnalytiqueRef : TfrmRechercheReferenceAnalytiqueRef;

implementation

uses mdlModuleImportPHA;

{$R *.dfm}

var
  FfrmRechercheReferenceAnalytiqueRef : TfrmRechercheReferenceAnalytiqueRef;

function frmRechercheReferenceAnalytiqueRef : TfrmRechercheReferenceAnalytiqueRef;
begin
  if not Assigned(FfrmRechercheReferenceAnalytiqueRef) then
    FfrmRechercheReferenceAnalytiqueRef := TfrmRechercheReferenceAnalytiqueRef.Create(Application.MainForm, TProjet(nil));
  Result := FfrmRechercheReferenceAnalytiqueRef
end;

procedure TfrmRechercheReferenceAnalytiqueRef.dbGrdReferenceAnalytiqueRefDblClick(
  Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
end;

procedure TfrmRechercheReferenceAnalytiqueRef.dbGrdReferenceAnalytiqueRefKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
    ModalResult := mrOk;
end;

procedure TfrmRechercheReferenceAnalytiqueRef.FormDestroy(Sender: TObject);
begin
  inherited;

  if dmModuleImportPHA.setReferenceAnalytiquesRef.Active then dmModuleImportPHA.setReferenceAnalytiquesRef.Close;
end;

procedure TfrmRechercheReferenceAnalytiqueRef.FormCreate(Sender: TObject);
begin
  inherited;

  dsReferenceAnalytiquesRef.DataSet := dmModuleImportPHA.setReferenceAnalytiquesRef;
end;

procedure TfrmRechercheReferenceAnalytiqueRef.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //inherited;
end;

destructor TfrmRechercheReferenceAnalytiqueRef.Destroy;
begin
  FfrmRechercheReferenceAnalytiqueRef := nil;

  inherited;
end;

function TfrmRechercheReferenceAnalytiqueRef.ShowModal(var AReferenceAnalytiqueRef : string) : Integer;
begin
  dmModuleImportPHA.setReferenceAnalytiquesRef.Open;

  Result := inherited ShowModal;
  if Result = mrOk then
    AReferenceAnalytiqueRef := dmModuleImportPHA.setReferenceAnalytiquesRef.FieldByName('REFERENCEANALYTIQUE').AsString
  else
    AReferenceAnalytiqueRef := '';

end;

initialization
  FfrmRechercheReferenceAnalytiqueRef := nil;

end.
