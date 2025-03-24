unit mdlConfiguration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlProjet, XMLIntf, mdlModule;

type
  TfrConfiguration = class(TFrame)
  private
    FProjet: TProjet;
    { Déclarations privées }
  public
    { Déclarations publiques }
    property Projet : TProjet read FProjet;
    constructor Create(Aowner : TComponent; AModule : TModule); reintroduce; virtual;
    procedure Enregistrer; virtual; abstract;
    procedure Initialiser(AOptions : IXMLNode); virtual; abstract;
  end;
  TfrConfigurationClasse = class of TfrConfiguration;

implementation

{$R *.dfm}

{ TfrConfiguration }
constructor TfrConfiguration.Create(Aowner: TComponent; AModule: TModule);
begin
  inherited Create(Aowner);

  FProjet := AModule.Projet;
  with FProjet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes[LowerCase(AModule.LibelleTypeModule[AModule.TypeModule])] do
    if not Assigned(GetChildNodes.FindNode('options')) then
    begin
      Initialiser(ChildNodes['options']);
      FProjet.FichierProjet.SaveToFile;
    end;
end;

end.
