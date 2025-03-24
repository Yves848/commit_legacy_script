unit mdlConversionsOrganismesAMO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConversions, DB, Grids, DBGrids, mdlPIDBGrid, mdlProjet, mdlGrille,
  StrUtils;

type
  TfrConversionsOrganismesAMO = class(TfrConversions)
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

uses mdlModuleImportPHA, mdlRechercheOrganismesAMORef, mdlLIsteClients;

{$R *.dfm}

{ TfrConversionOrganismesAMO }

constructor TfrConversionsOrganismesAMO.Create(AOwner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  dsConversions.DataSet := dmModuleImportPHA.setConversionsOrganismesAMO;
end;

procedure TfrConversionsOrganismesAMO.grdConversionsSurAppliquerProprietesCellule(
  Sender: TObject; ACol, ALig: Integer; ARect: TRect; var AFond: TColor;
  APolice: TFont; var AAlignement: TAlignment; AEtat: TGridDrawState);
begin
  inherited;

  if ALig > C_LIGNE_TITRE then
    with dmModuleImportPHA.setConversionsOrganismesAMO do
    begin
      // Organisme non converti
      if FieldByName('T_REF_ORGANISME_AMO_ID').IsNull then
      begin
        AFond := clRed;
        APolice.Color := clWindow;
      end;

      // Organisme non repri
      if FieldByName('REPRIS').AsWideString = '0' then
      begin
        AFond := clWindow;
        APolice.Color := clWindowText;
        APolice.Style := APolice.Style + [fsStrikeOut];
      end;
    end;
end;

procedure TfrConversionsOrganismesAMO.grdConversionsDblClick(Sender: TObject);
begin
  inherited;
  frmListeClients.Show;
end;

procedure TfrConversionsOrganismesAMO.grdConversionsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  lStrIdentifiantNational : string;
begin
  inherited;

  if (Column.FieldName = 'IDENTIFIANT_NATIONAL') then
    if (gdFocused in State) then
      with dmModuleImportPHA do
        if (RightStr(setConversionsOrganismesAMOIDENTIFIANT_NATIONAL.AsString, 1) = '*') and not frmRechercheOrganismesAMORef.Visible then
          if frmRechercheOrganismesAMORef.ShowModal(setConversionsOrganismesAMOIDENTIFIANT_NATIONAL.AsWideString, lStrIdentifiantNational) = mrOk then
            with setConversionsOrganismesAMO do
            begin
              Edit;
              setConversionsOrganismesAMOIDENTIFIANT_NATIONAL.AsWideString := lStrIdentifiantNational;
              Post;
              //Next;
            end
          else
            setConversionsOrganismesAMO.Cancel;
end;

destructor TfrConversionsOrganismesAMO.Destroy;
begin
  if frmRechercheOrganismesAMORef <> nil then
    frmRechercheOrganismesAMORef.Free;

  inherited;
end;

procedure TfrConversionsOrganismesAMO.dsConversionsDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  // Liste des clients
  if frmListeClients.Visible then
    dmModuleImportPHA.OuvrirListeClients;
end;

procedure TfrConversionsOrganismesAMO.Fermer;
begin
  inherited;

  if not dmModuleImportPHA.setConversionsOrganismesAMO.Active then
    frmListeClients.dsListeClients.DataSet := nil;
end;

procedure TfrConversionsOrganismesAMO.Ouvrir;
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
