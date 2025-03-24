unit mdlLIsteClients;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, mdlGrille, mdlPIDBGrid, DB, StdCtrls, ExtCtrls, Buttons,
  mdlPISpeedButton, Mask, DBCtrls, mdlPIPanel;

type
  TfrmListeClients = class(TForm)
    dsListeClients: TDataSource;
    grdListeClients: TPIDBGrid;
    pnlRecherche: TPIPanel;
    edtCritere: TEdit;
    lblCritere: TLabel;
    btnChercher: TPISpeedButton;
    pnlDetailsClient: TPIPanel;
    lblOrganismeAMO: TLabel;
    lblOrganismeAMC: TLabel;
    edtOrganismeAMO: TDBEdit;
    edtOrganismeAMC: TDBEdit;
    lblDerniereDateFinDroitAMO: TLabel;
    edtDerniereDateFinDroitAMO: TDBEdit;
    bvlSeparateur_1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnChercherClick(Sender: TObject);
    procedure edtCritereKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdListeClientsDblClick(Sender: TObject);
    procedure grdListeClientsSurAppliquerProprietesCellule(Sender: TObject;
      ACol, ALig: Integer; ARect: TRect; var AFond: TColor; APolice: TFont;
      var AAlignement: TAlignment; AEtat: TGridDrawState);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    destructor Destroy; override;
  end;

  function frmListeClients : TfrmListeClients;
  function frmExiste : Boolean;

const
  CM_SELECTION_CLIENT = WM_USER + $10;

implementation

uses mdlModuleImportPHA, Math;

{$R *.dfm}

var
  FfrmListeClients : TfrmListeClients;

function frmListeClients : TfrmListeClients;
begin
  if not Assigned(FfrmListeClients) and not Application.Terminated then
    FfrmListeClients := TfrmListeClients.Create(Application.MainForm);
  Result := FfrmListeClients
end;

function frmExiste : Boolean;
begin
  Result := Assigned(FfrmListeClients);
end;

procedure TfrmListeClients.FormCreate(Sender: TObject);
begin
  dsListeClients.DataSet := dmModuleImportPHA.setListeClients;
end;

procedure TfrmListeClients.FormShow(Sender: TObject);
begin
  SetBounds(Screen.Width - Width, 0, Width, Height);
end;

procedure TfrmListeClients.btnChercherClick(Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  with dmModuleImportPHA.setListeClients do
  begin
    if Active then
     Close;

    // Sépération des paramètres
    lStrNom := StringReplace(edtCritere.Text, '*', '', [rfReplaceAll]);;
    lIntPos := Pos('+', lStrNom);
    if lIntPos > 0 then
    begin
      lStrPrn := Copy(lStrNom, lIntPos + 1, Length(lStrNom));
      lStrNom := Copy(lStrNom, 1, lIntPos - 1);
    end
    else
      lStrPrn := '';

    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;
end;

procedure TfrmListeClients.edtCritereKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnChercher.Click
end;

procedure TfrmListeClients.grdListeClientsDblClick(Sender: TObject);
begin
  PostMessage(Application.MainForm.ActiveControl.Handle, WM_KEYDOWN, VK_F24, 0)
end;
  
destructor TfrmListeClients.Destroy;
begin
  FfrmListeClients := nil;

  inherited;
end;

procedure TfrmListeClients.grdListeClientsSurAppliquerProprietesCellule(
  Sender: TObject; ACol, ALig: Integer; ARect: TRect; var AFond: TColor;
  APolice: TFont; var AAlignement: TAlignment; AEtat: TGridDrawState);
begin
  if ALig > C_LIGNE_TITRE then
    if dmModuleImportPHA.setListeClientsDERNIERE_DATE_FIN_DROIT_AMO.AsDateTime < Date then
      AFond := clRed
    else
      AFond := clGreen;
end;

initialization
  FfrmListeClients := nil;

end.
