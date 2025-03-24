unit mdlLeo2Configuration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, mdlConfiguration, StdCtrls, mdlProjet, xmlintf;

type
  TfrLeo2Configuration = class(TfrConfiguration)
    gbxCatalogues: TGroupBox;
    lblProvenanceCat: TLabel;
    cbxProvenanceCat: TComboBox;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AModule : TModule); override;
    procedure Enregistrer; override;
    procedure Initialiser(AOptions : IXMLNode); override;
  end;

const
  C_PROVENANCE_CAT_COMMANDES = 0;
  C_PROVENANCE_CAT_REF_FOURNISSEURS = 1;

implementation

{$R *.dfm}

{ TLeo2Configuration }

constructor TfrLeo2Configuration.Create(Aowner: TComponent; AModule: TModule);
begin
  inherited;

  with Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
    if ChildNodes.IndexOf('provenance_catalogues') <> -1 then cbxProvenanceCat.ItemIndex := ChildNodes['provenance_catalogues'].NodeValue;
end;

procedure TfrLeo2Configuration.Enregistrer;
begin
  inherited;

  Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].ChildNodes['provenance_catalogues'].NodeValue := cbxProvenanceCat.ItemIndex;
end;

procedure TfrLeo2Configuration.Initialiser(AOptions: IXMLNode);
begin
  inherited;

  Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].ChildNodes['provenance_catalogues'].NodeValue := C_PROVENANCE_CAT_COMMANDES;
end;

end.
 