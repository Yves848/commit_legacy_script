unit mdlConversionsComptes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, mdlLIsteClients,
  Dialogs, mdlConversions, DB, Grids, DBGrids, mdlPIDBGrid, mdlProjet, mdlGrille, StrUtils;

type
  TfrConversionsComptes = class(TfrConversions)
    procedure grdConversionsSurAppliquerProprietesCellule(Sender: TObject;
      ACol, ALig: Integer; ARect: TRect; var AFond: TColor; APolice: TFont;
      var AAlignement: TAlignment; AEtat: TGridDrawState);
    procedure grdConversionsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdConversionsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Déclarations privées }
    procedure CMSelectionClient(var Msg : TMessage); message CM_SELECTION_CLIENT;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AProjet : TProjet); override;
    procedure Ouvrir; override;
    procedure Fermer; override;
  end;

implementation

uses mdlModuleImportPHA, DateUtils;

{$R *.dfm}

{ TfrConversionsComptes }

constructor TfrConversionsComptes.Create(AOwner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  dsConversions.DataSet := dmModuleImportPHA.setConversionsComptes;
end;

procedure TfrConversionsComptes.Fermer;
begin
  inherited;

  if dmModuleImportPHA.setConversionsComptes.Active then
    frmListeClients.dsListeClients.DataSet := nil;
end;

procedure TfrConversionsComptes.grdConversionsSurAppliquerProprietesCellule(
  Sender: TObject; ACol, ALig: Integer; ARect: TRect; var AFond: TColor;
  APolice: TFont; var AAlignement: TAlignment; AEtat: TGridDrawState);
begin
  inherited;

  if ALig > C_LIGNE_TITRE then
    with dmModuleImportPHA.setConversionsComptes do
      // Organisme non repri
      if FieldByName('REPRIS').AsWideString = '0' then
      begin
        AFond := clWindow;
        APolice.Color := clWindowText;
        APolice.Style := APolice.Style + [fsStrikeOut];
      end;
end;

procedure TfrConversionsComptes.Ouvrir;
begin
  inherited;

  with frmListeClients do
  begin
    dsListeClients.DataSet := dmModuleImportPHA.setListeClients;

    Hide;
    pnlRecherche.Show;
    Caption := 'Sélection d''un client';
  end;
end;

procedure TfrConversionsComptes.CMSelectionClient(var Msg: TMessage);
begin

end;

procedure TfrConversionsComptes.grdConversionsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_F24 then
    with dmModuleImportPHA.setConversionsComptes do
    begin
      Edit;
      FieldByName('T_CLIENT_ID').AsWideString := dmModuleImportPHA.setListeClientsT_CLIENT_ID.AsString;
      Post;
    end;
end;

procedure TfrConversionsComptes.grdConversionsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if (Column.FieldName = 'NOM_PRENOM_CLIENT') then
    if (gdFocused in State) then
      with dmModuleImportPHA do
        if (RightStr(setConversionsComptesNOM_PRENOM_CLIENT.AsString, 1) = '*') then
        begin
          frmListeClients.edtCritere.Text := setConversionsComptesNOM_PRENOM_CLIENT.AsWideString;
          frmListeClients.btnChercher.Click;
          frmListeClients.Show;
        end;
end;

end.
