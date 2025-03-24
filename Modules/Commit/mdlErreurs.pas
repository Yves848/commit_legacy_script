unit mdlErreurs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlDialogue, ComCtrls, ActnList, ImgList, JvExControls,
  JvDBLookupTreeView, DB, mdlBase, JvXPBar, JvXPCore, StrUtils, Math,
  JvXPContainer, Grids, DBGrids, mdlPIDBGrid, mdlProjet, ShellAPI,
  uib, uibdataset, StdCtrls, DBCtrls, dbcgrids, ExtCtrls, JvExExtCtrls,
  JvNetscapeSplitter, mdlUIBThread, mdlAttente, Mask;

type
  TfrmErreurs = class(TfrmDialogue)
    dsErreurs: TDataSource;
    dsDonnees: TDataSource;
    pnlErreurs: TPanel;
    spl1: TJvNetscapeSplitter;
    grdErreurs: TPIDBGrid;
    grdDonnees: TDBCtrlGrid;
    mmDonnees: TDBMemo;
    pnl: TPanel;
    pnlErreursTransfert: TPanel;
    pnlErreursImport: TPanel;
    xpbTitreErreursImport: TJvXPBar;
    sbxErreursImport: TScrollBox;
    xpbErreursImport: TJvXPBar;
    xpbTitreErreursTransfert: TJvXPBar;
    sbxErreursTransfert: TScrollBox;
    xpbErreursTransfert: TJvXPBar;
    actExporterToutesErreurs: TAction;
    actFichierEnCours: TAction;
    pnlCommandes: TPanel;
    btnVoirRejets: TButton;
    mmInstruction: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure actExporterToutesErreursExecute(Sender: TObject);
    procedure xpbErreursImportMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actFichierEnCoursExecute(Sender: TObject);
    procedure grdErreursMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnVoirRejetsClick(Sender: TObject);
  private
    { Déclarations privées }
    FParametresTH : TParametresThreadRequeteFB;
    FItemEnCours : TJvXPBarItem;
    procedure AfficherErreurs(AFichier : TJvXPBarItem); overload;
    procedure AfficherErreurs(ATypeModule : TTypeModule; AFichier: string); overload;
    procedure ExporterErreurs(AFichier : string);
  public
    { Déclarations publiques }
    function ShowModal(ATypeModule : TTypeModule; AFichier : string = '') : Integer; reintroduce;
  end;

var
  frmErreurs: TfrmErreurs;

implementation

uses mdlPHA;

{$R *.dfm}

procedure TfrmErreurs.ExporterErreurs(AFichier : string);
begin
  FParametresTH.ParametresProc[0] := AFichier;
  AttendreFinExecution(Self, taLibelle, TThreadRequeteFB, FParametresTH, 'Export des erreurs ' + FParametresTH.ParametresProc[0] + ' ...');
end;

procedure TfrmErreurs.actExporterToutesErreursExecute(Sender: TObject);
var
  i: Integer;
begin
  inherited;

  for i := 0 to xpbErreursImport.Items.Count - 1 do
    ExporterErreurs(xpbErreursImport.Items[i].Caption);
end;

procedure TfrmErreurs.actFichierEnCoursExecute(Sender: TObject);
begin
  inherited;

  ExporterErreurs(FItemEnCours.Caption);
end;

procedure TfrmErreurs.AfficherErreurs(AFichier : TJvXPBarItem);
var
  f : string;
begin
  FItemEnCours := AFichier;
  with dmPHA.setErreurs do
  begin
    if Active then Close;
    Params.ByNameAsInteger['AFICHIERID'] := AFichier.Tag;
    Open;

    Caption := 'Table des erreurs - ' + AFichier.Caption;
  end;

  spl1.Maximized := True;

  f := Projet.RepertoireProjet + '\rejets\' + FItemEnCours.Caption + '0.rejets.xml';
  pnlCommandes.Visible := FileExists(f);
end;

procedure TfrmErreurs.AfficherErreurs(ATypeModule : TTypeModule; AFichier: string);
var
  c : TJvXPBar;
  lIntTagFichier : Integer;

  function ChercherTag : Integer;
  var
    i : Integer;
  begin
    i := 0; Result := -1;
    while (i < c.Items.Count) and (Result = -1) do
      if c.Items[i].Caption = AFichier then
        Result := c.Items[i].Index
      else
        Inc(i);
  end;

begin
  if ATypeModule = tmImport then
    c := xpbErreursImport
  else
    c := xpbErreursTransfert;

  lIntTagFichier := ChercherTag;
  AfficherErreurs(c.Items[lIntTagFichier]);
end;

procedure TfrmErreurs.FormCreate(Sender: TObject);

  procedure AjouterItem(AParent : TJvXPBar);
  begin
    with AParent.Items.Add do
    begin
      Caption := dmPHA.qry.Fields.ByNameAsString['NOM'];
      Tag := dmPHA.qry.Fields.ByNameAsInteger['T_FCT_FICHIER_ID'];
    end;
  end;

begin
  inherited;

  dmPHA.trErreurs.StartTransaction;
  with dmPHA.qry do
  begin
    SQL.Clear;
    SQL.Add('select t_fct_fichier_id, nom, type_fichier');
    SQL.Add('from v_fichier');
    Open;

    while not Eof do
    begin
      if (Fields.ByNameAsString['TYPE_FICHIER'] = '11') or (Fields.ByNameAsString['TYPE_FICHIER'] = '12') then AjouterItem(xpbErreursImport);
      if (Fields.ByNameAsString['TYPE_FICHIER'] = '21') or (Fields.ByNameAsString['TYPE_FICHIER'] = '22') then AjouterItem(xpbErreursTransfert);
      Next;
    end;

    Close(etmStayIn);
  end;

  with xpbErreursImport do sbxErreursImport.VertScrollBar.Range := ItemHeight * Items.Count + 5 ;
  with xpbErreursTransfert do sbxErreursTransfert.VertScrollBar.Range := ItemHeight * Items.Count + 5;

  dsErreurs.DataSet := dmPHA.setErreurs;
  dsDonnees.DataSet := dmPHA.setDonnees;

  FParametresTH := TParametresThreadRequeteFB.Create(Projet.PHAConnexion, 'PS_EXPORTER_ERREURS', 2);
  FParametresTH.ParametresProc[1] := Projet.RepertoireProjet + '\erreurs\';
end;

procedure TfrmErreurs.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FParametresTH) then FreeAndNil(FParametresTH);

  if dmPHA.setErreurs.Active then
    dmPHA.setErreurs.Close;
end;

procedure TfrmErreurs.FormResize(Sender: TObject);
var
  h, r : Integer;
begin
  inherited;

  h := pnl.Height div 2;
  with sbxErreursImport do
    r := VertScrollBar.Range + Top + Margins.Bottom;

  if r > h then
    pnlErreursImport.Height := h
  else
    pnlErreursImport.Height := r;

end;

procedure TfrmErreurs.grdErreursMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  c : TGridCoord;
begin
  inherited;

  c := grdErreurs.MouseCoord(X, Y);

  if ((dgIndicator in grdErreurs.Options) and (c.X > 0)) and
     ((dgTitles in grdErreurs.Options) and (c.Y > 0)) then
    grdErreurs.Hint := grdErreurs.Columns[c.X - Ord(dgIndicator in grdErreurs.Options)].Field.DisplayText
  else
    grdErreurs.Hint := '';
end;

procedure TfrmErreurs.btnVoirRejetsClick(Sender: TObject);
begin
  inherited;

  ShellExecute(0, 'open', PChar(Projet.RepertoireProjet + '\rejets\' + FItemEnCours.Caption + '0.rejets.xml'), nil, nil, SW_NORMAL);
end;

function TfrmErreurs.ShowModal(ATypeModule : TTypeModule; AFichier: string): Integer;
begin
  if AFichier <> '' then
    AfficherErreurs(ATypeModule, AFichier);
  Result := inherited ShowModal;
end;

procedure TfrmErreurs.xpbErreursImportMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  FItemEnCours := (Sender as TJvXPBar).Items.Items[(Y-5) div (Sender as TJvXPBar).ItemHeight];
  if Assigned(FItemEnCours) then
    AfficherErreurs(FItemEnCours);
end;

end.
