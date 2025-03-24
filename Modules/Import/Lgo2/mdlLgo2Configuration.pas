unit mdlLgo2Configuration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConfiguration, StdCtrls, mdlProjet, XMLIntf, ShellAPI, Mask,
  JvExMask, JvSpin, ExtCtrls, JvToolEdit, JvMaskEdit, JvCheckedMaskEdit,
  JvDatePickerEdit, DateUtils, ComCtrls, JvExComCtrls, JvDateTimePicker;

type
  TCfgCodificationProduit = (ccpInterne, ccpGammeFournisseurs, ccpGeneriques, ccpGestionMarge, ccpLibre);

  TfrLgo2Configuration = class(TfrConfiguration)
    GroupBox2: TGroupBox;
    chkScanAUTO: TCheckBox;
    Label1: TLabel;
    edtRegex: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner: TComponent; AModule: TModule); override;
    procedure Enregistrer; override;
    procedure Initialiser(AOptions: IXMLNode); override;
  end;

const
  C_CFG_REGEX_SCAN = '(\d+)';

implementation

{$R *.dfm}
{ TfrLgo2Configuration }


procedure TfrLgo2Configuration.Button1Click(Sender: TObject);
begin
  inherited;

  edtRegex.Text := C_CFG_REGEX_SCAN;
end;

constructor TfrLgo2Configuration.Create(Aowner: TComponent; AModule: TModule);
var
  d: TDateTime;
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
  begin
    if HasAttribute('scan_auto') then
      chkScanAUTO.Checked := StrToBool(Attributes['scan_auto'])
    else
      chkScanAUTO.Checked := False;

    if HasAttribute('regex_scan') then
       edtRegex.Text := Attributes['regex_scan']
  end;
end;

procedure TfrLgo2Configuration.Enregistrer;
begin
  inherited;
     with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
    begin
      Attributes['scan_auto'] := BoolToStr(chkScanAUTO.Checked);
      Attributes['regex_scan'] := edtRegex.Text;
    end;
end;

procedure TfrLgo2Configuration.Initialiser(AOptions: IXMLNode);
begin
  inherited;

  AOptions.Attributes['scan_auto'] := False;
  AOptions.Attributes['regex_scan'] := C_CFG_REGEX_SCAN;

end;

end.
