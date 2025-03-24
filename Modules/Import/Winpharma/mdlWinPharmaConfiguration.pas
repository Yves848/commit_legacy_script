unit mdlWinPharmaConfiguration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConfiguration, StdCtrls, mdlProjet, XMLIntf, ShellAPI, Mask,
  JvExMask, JvSpin, ExtCtrls, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit, DateUtils, ComCtrls, JvExComCtrls, JvDateTimePicker;

type
  TCfgCodificationProduit = (ccpInterne, ccpGammeFournisseurs, ccpGeneriques, ccpGestionMarge, ccpLibre);

  TfrWinPharmaConfiguration = class(TfrConfiguration)
    gBoxVersion: TGroupBox;
    GroupBox1: TGroupBox;
    cbxPrixDOM: TCheckBox;
    lblFacteurDecoupage: TLabel;
    edtFacteurDecoupage: TJvSpinEdit;
    grdCodifPrd: TRadioGroup;
    GroupBox2: TGroupBox;
    edtDateImportScans: TJvDateTimePicker;
    chkScanAM: TCheckBox;
    chkScanOrdonnances: TCheckBox;
    chkScanFournisseurs: TCheckBox;
    chkScanBL: TCheckBox;
    cbxDepot: TCheckBox;
    Label2: TLabel;
    cbxGestionStock: TCheckBox;
    procedure cbxGestionStockMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner: TComponent; AModule: TModule); override;
    procedure Enregistrer; override;
    procedure Initialiser(AOptions: IXMLNode); override;
  end;

const
  C_CFG_CODIFICATION_PRODUIT = 'codification_produit';

  C_CFG_SCANS_DATE_IMPORT = 'scans.date_import';
  C_CFG_SCANS_AM = 'scans.am';
  C_CFG_SCANS_ORDONNANCES = 'scans.ordonnances';
  C_CFG_SCANS_FOURNISSEURS = 'scans.fournisseurs';
  C_CFG_SCANS_BL = 'scans.bl';
  C_CFG_GESTION_STOCK = 'gestionstock';

implementation

{$R *.dfm}
{ TfrWinPharmaConfiguration }

procedure TfrWinPharmaConfiguration.cbxGestionStockMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if cbxGestionStock.Checked then
    ShowMessage('Option ''Pas de gestion de stock'' sélectionnée' + #13 +
        'Ne pas oublier d''effectuer une purge des produits AVANT le TRANSFERT');
end;

constructor TfrWinPharmaConfiguration.Create(Aowner: TComponent; AModule: TModule);
var
  d: TDateTime;
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
  begin
    if HasAttribute('facteur_decoupage') then
      edtFacteurDecoupage.Value := Attributes['facteur_decoupage']
    else
      edtFacteurDecoupage.Value := 10;
    if HasAttribute('prixdom') then
      cbxPrixDOM.Checked := StrToBool(Attributes['prixdom'])
    else
      cbxPrixDOM.Checked := False;
    if HasAttribute('depot') then
      cbxDepot.Checked := StrToBool(Attributes['depot'])
    else
      cbxDepot.Checked := False;
    if HasAttribute(C_CFG_CODIFICATION_PRODUIT) then
      grdCodifPrd.ItemIndex := Attributes[C_CFG_CODIFICATION_PRODUIT];
    if HasAttribute(C_CFG_SCANS_DATE_IMPORT) then
      edtDateImportScans.DateTime := StrToFloat(Attributes[C_CFG_SCANS_DATE_IMPORT])
    else
      edtDateImportScans.Date := IncMonth(Now, -18);
    if HasAttribute(C_CFG_SCANS_AM) then
      chkScanAM.Checked := StrToBool(Attributes[C_CFG_SCANS_AM])
    else
      chkScanAM.Checked := True;
    if HasAttribute(C_CFG_SCANS_ORDONNANCES) then
      chkScanOrdonnances.Checked := StrToBool(Attributes[C_CFG_SCANS_ORDONNANCES])
    else
      chkScanOrdonnances.Checked := True;
    if HasAttribute(C_CFG_SCANS_FOURNISSEURS) then
      chkScanFournisseurs.Checked := StrToBool(Attributes[C_CFG_SCANS_FOURNISSEURS])
    else
      chkScanFournisseurs.Checked := True;
    if HasAttribute(C_CFG_SCANS_BL) then
      chkScanBL.Checked := StrToBool(Attributes[C_CFG_SCANS_BL])
    else
      chkScanBL.Checked := True;
    if HasAttribute(C_CFG_GESTION_STOCK) then
      cbxGestionStock.Checked := StrToBool(Attributes[C_CFG_GESTION_STOCK])
    else
      cbxGestionStock.Checked := False;

  end;
end;

procedure TfrWinPharmaConfiguration.Enregistrer;
begin
  inherited;
     with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
    begin
      Attributes['facteur_decoupage'] := edtFacteurDecoupage.Value;
      Attributes['prixdom'] := BoolToStr(cbxPrixDOM.Checked);
      Attributes['depot'] := BoolToStr(cbxDepot.Checked);
      Attributes[C_CFG_CODIFICATION_PRODUIT] := grdCodifPrd.ItemIndex;
      Attributes[C_CFG_SCANS_DATE_IMPORT] := FloatToStr(edtDateImportScans.Date);
      Attributes[C_CFG_SCANS_AM] := BoolToStr(chkScanAM.Checked);
      Attributes[C_CFG_SCANS_ORDONNANCES] := BoolToStr(chkScanOrdonnances.Checked);
      Attributes[C_CFG_SCANS_FOURNISSEURS] := BoolToStr(chkScanFournisseurs.Checked);
      Attributes[C_CFG_SCANS_BL] := BoolToStr(chkScanBL.Checked);
      Attributes[C_CFG_GESTION_STOCK] := BoolToStr(cbxGestionStock.Checked);
    end;
end;

procedure TfrWinPharmaConfiguration.Initialiser(AOptions: IXMLNode);
begin
  inherited;

  AOptions.Attributes['facteur_decoupage'] := 10;
  AOptions.Attributes['prixdom'] := False;
  AOptions.Attributes['depot'] := False;
  AOptions.Attributes[C_CFG_CODIFICATION_PRODUIT] := ccpLibre;
  AOptions.Attributes[C_CFG_SCANS_DATE_IMPORT] := FloatToStr(IncMonth(Now, -18));
  AOptions.Attributes[C_CFG_SCANS_AM] := True;
  AOptions.Attributes[C_CFG_SCANS_ORDONNANCES] := True;
  AOptions.Attributes[C_CFG_SCANS_FOURNISSEURS] := True;
  AOptions.Attributes[C_CFG_SCANS_BL] := True;
  AOptions.Attributes[C_CFG_GESTION_STOCK] := False;

end;

end.
