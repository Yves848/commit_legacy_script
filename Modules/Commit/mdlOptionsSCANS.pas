unit mdlOptionsSCANS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, ExtCtrls, mdlProjet;

type
  TfrmOptionsSCANS = class(TForm)
    GroupBox1: TPanel;
    chkConversion: TCheckBox;
    chkRecursif: TCheckBox;
    Label1: TLabel;
    edtRepertoire: TJvDirectoryEdit;
    cbxFiltre: TComboBox;
    btnAnnuler: TButton;
    btnOK: TButton;
    Label2: TLabel;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    constructor Create(AOwner : TComponent; AProjet : TProjet); reintroduce;
  end;

var
  frmOptionsSCANS: TfrmOptionsSCANS;

implementation

{$R *.dfm}

constructor TfrmOptionsSCANS.Create(AOwner: TComponent; AProjet: TProjet);
begin
  inherited Create(AOwner);

  with AProjet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'] do
  begin

    with ChildNodes['options'].ChildNodes['scan'] do
    begin
      if HasAttribute('chemin') then
         edtRepertoire.Directory := includetrailingbackslash(Attributes['chemin'])
      else
         edtRepertoire.Directory := includetrailingbackslash(AProjet.RepertoireProjet);

      if HasAttribute('recursif') then
        chkRecursif.Checked := strtobool(Attributes['recursif'])
      else
        chkRecursif.Checked := false;

      if HasAttribute('type') then
        cbxFiltre.ItemIndex := cbxFiltre.Items.IndexOf(Attributes['type'])
      else
        cbxFiltre.ItemIndex := -1;
    end;

  end;

  chkConversion.Checked := False;

end;

end.
