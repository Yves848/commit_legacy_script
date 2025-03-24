unit mdlConversionsCouverturesAMO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConversions, DB, Grids, DBGrids, mdlPIDBGrid, mdlProjet, mdlGrille,
  StrUtils, StdCtrls, DBCtrls, Mask, ExtCtrls, mdlAttente;

type
  TfrConversionsCouverturesAMO = class(TfrConversions)
    procedure grdConversionsSurAppliquerProprietesCellule(Sender: TObject;
      ACol, ALig: Integer; ARect: TRect; var AFond: TColor; APolice: TFont;
      var AAlignement: TAlignment; AEtat: TGridDrawState);
    procedure grdConversionsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dsConversionsDataChange(Sender: TObject; Field: TField);
    procedure grdConversionsDblClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AProjet : TProjet); override;
    destructor Destroy; override;
    procedure Ouvrir; override;
    procedure Fermer; override;
  end;

implementation

uses mdlModuleImportPHA, mdlRechercheCouverturesAMORef, mdlLIsteClients;

{$R *.dfm}

{ TfrConversionCouverturesAMO }

constructor TfrConversionsCouverturesAMO.Create(AOwner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  dsConversions.DataSet := dmModuleImportPHA.setConversionsCouverturesAMO;
end;

procedure TfrConversionsCouverturesAMO.grdConversionsSurAppliquerProprietesCellule(
  Sender: TObject; ACol, ALig: Integer; ARect: TRect; var AFond: TColor;
  APolice: TFont; var AAlignement: TAlignment; AEtat: TGridDrawState);
begin
  inherited;

  if ALig > C_LIGNE_TITRE then
    with dmModuleImportPHA.setConversionsCouverturesAMO do
    begin
      // Couverture non converti
      if FieldByName('T_REF_Couverture_AMO_ID').IsNull and (FieldByName('ALD').AsString = '0') then
      begin
        AFond := clRed;
        APolice.Color := clWindow;
      end;

      // Couverture non repri
      if FieldByName('REPRIS').AsWideString = '0' then
      begin
        AFond := clWindow;
        APolice.Color := clWindowText;
        APolice.Style := APolice.Style + [fsStrikeOut];
      end;
    end;
end;

procedure TfrConversionsCouverturesAMO.grdConversionsDblClick(Sender: TObject);
begin
  inherited;
  frmListeClients.Show;
end;

procedure TfrConversionsCouverturesAMO.grdConversionsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  lStrCodeCouverture : string;
begin
  inherited;

  if (Column.FieldName = 'CODE_COUVERTURE') then
    if (gdFocused in State) then
      with dmModuleImportPHA do
        if (RightStr(setConversionsCouverturesAMOCODE_COUVERTURE.AsString, 1) = '*') and not frmRechercheCouverturesAMORef.Visible then
          if frmRechercheCouverturesAMORef.ShowModal(setConversionsCouverturesAMOCODE_COUVERTURE.AsWideString, lStrCodeCouverture) = mrOk then
            with setConversionsCouverturesAMO do
            begin
              Edit;
              setConversionsCouverturesAMOCODE_COUVERTURE.AsWideString := lStrCodeCouverture;
              Post;
              //Next;
            end
          else
            setConversionsCouverturesAMO.Cancel;
end;

destructor TfrConversionsCouverturesAMO.Destroy;
begin
  if frmRechercheCouverturesAMORef <> nil then
    frmRechercheCouverturesAMORef.Free;

  inherited;
end;

procedure TfrConversionsCouverturesAMO.dsConversionsDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  // Liste des clients
  if frmListeClients.Visible then
    dmModuleImportPHA.OuvrirListeClients;
end;

procedure TfrConversionsCouverturesAMO.Fermer;
begin
  inherited;

  if not dmModuleImportPHA.setConversionsCouverturesAMO.Active then
    frmListeClients.dsListeClients.DataSet := nil;
end;

procedure TfrConversionsCouverturesAMO.Ouvrir;
begin
  inherited;

  with frmListeClients do
  begin
    dsListeClients.DataSet := dmModuleImportPHA.setListeClients;
    //Show;
    pnlRecherche.Hide;
    Caption := 'Liste des clients';

    dsConversionsDataChange(nil, nil);
  end;
end;

end.
