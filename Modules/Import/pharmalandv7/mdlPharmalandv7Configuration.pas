unit mdlPharmalandv7Configuration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConfiguration, StdCtrls, mdlProjet, XMLIntf, ShellAPI;

type
  TfrPharmalandv7Configuration = class(TfrConfiguration)
    gBoxMotsDePasses: TGroupBox;
    lblPARAM: TLabel;
    edtPARAM: TEdit;
    lblLisezMoi: TLabel;
    procedure lblLisezMoiClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AModule : TModule); override;
    procedure Enregistrer; override;
    procedure Initialiser(AOptions : IXMLNode); override;
  end;

implementation

{$R *.dfm}


{ TfrPharmalandv7Configuration }

constructor TfrPharmalandv7Configuration.Create(Aowner: TComponent;
  AModule: TModule);
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
      if HasAttribute('mot_de_passe') then edtPARAM.Text := Attributes['mot_de_passe'] else edtPARAM.Text := '';
end;

procedure TfrPharmalandv7Configuration.Enregistrer;
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
    Attributes['mot_de_passe'] := edtPARAM.Text;
end;

procedure TfrPharmalandv7Configuration.Initialiser(AOptions: IXMLNode);
begin
  inherited;

  AOptions.Attributes['mot_de_passe'] := '';
end;

procedure TfrPharmalandv7Configuration.lblLisezMoiClick(Sender: TObject);
begin
  inherited;

 // ShellExecute(0, 'open', 'ftp://commitv2:commitv2@10.200.120.181/outils/Pharmaland/HFPass_v1.0.zip', nil, PChar(Projet.RepertoireApplication), SW_NORMAL);
end;

end.
