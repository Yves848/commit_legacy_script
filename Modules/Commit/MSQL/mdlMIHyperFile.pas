unit mdlMIHyperFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport, Menus,
  JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer, JvWizard,
  JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids, mdlPIDBGrid,   mdlMIOLEDB,
  JvExControls, StdCtrls, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter;

type
  TfrMIHyperFile = class(TfrMIOLEDB)
    procedure frMIHyperFile_AvantConnecter(Sender : TObject; var AAutorise: Boolean);
    procedure actAccesBDParametresExecute(Sender: TObject); override;
  private
    { Déclarations privées }
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

var
  frMIHyperFile: TfrMIHyperFile;

implementation

uses mdlMIHyperFilePHA, mdlHyperFileConnexionServeur;

{$R *.dfm}

{ TfrMIHyperFile }

procedure TfrMIHyperFile.actAccesBDParametresExecute(Sender: TObject);
begin
  inherited;
  (PHA as TdmMIHyperFilePHA).setFichiersManquants.Params.ByNameAsString['AREPERTOIRE'] := IncludeTrailingPathDelimiter(PHA.ParametresConnexion.Values['bd']);
  (PHA as TdmMIHyperFilePHA).setFichiersManquants.CloseOpen();
end;


constructor TfrMIHyperFile.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;

  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('bd') then (PHA as TdmMIHyperFilePHA).setFichiersManquants.Params.ByNameAsString['AREPERTOIRE'] := IncludeTrailingPathDelimiter(Attributes['bd']);
    (PHA as TdmMIHyperFilePHA).setFichiersManquants.CloseOpen();
  end;

  SurAvantConnecter := frMIHyperFile_AvantConnecter;

  FInterfaceConnexion := TfrmHyperFileConnexionServeur;
end;

procedure TfrMIHyperFile.RenvoyerParametresConnexion;
begin
  //if PHA.ParametresConnexion.IndexOfName('connexion_locale') = -1 then PHA.ParametresConnexion.Add('connexion_locale=');
  //if PHA.ParametresConnexion.IndexOfName('analyse') = -1 then PHA.ParametresConnexion.Add('analyse=');
 // if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then PHA.ParametresConnexion.Add('bd=');
 // if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then PHA.ParametresConnexion.Add('utilisateur=');
  //if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then PHA.ParametresConnexion.Add('mot_de_passe=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
   // if HasAttribute('connexion_locale') then PHA.ParametresConnexion.Values['connexion_locale'] :=  Attributes['connexion_locale'] else PHA.ParametresConnexion.Values['connexion_locale'] := '1';
   // if HasAttribute('analyse') then PHA.ParametresConnexion.Values['analyse'] :=  Attributes['analyse'] else PHA.ParametresConnexion.Values['analyse'] := 'pharma.wdd';
   // if HasAttribute('serveur') then PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur'] else PHA.ParametresConnexion.Values['serveur'] := '127.0.0.1';
    if HasAttribute('bd') then
      PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd']
    else
      PHA.ParametresConnexion.Values['bd'] := module.Projet.RepertoireProjet;
   // if HasAttribute('utilisateur') then PHA.ParametresConnexion.Values['utilisateur'] :=  Attributes['utilisateur'] else PHA.ParametresConnexion.Values['utilisateur'] := 'Admin';
   // if HasAttribute('mot_de_passe') then PHA.ParametresConnexion.Values['mot_de_passe'] :=  Attributes['mot_de_passe'] else PHA.ParametresConnexion.Values['mot_de_passe'] := '';
  end;
end;

procedure TfrMIHyperFile.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
   // Attributes['connexion_locale'] := PHA.ParametresConnexion.Values['connexion_locale'];
    //Attributes['analyse'] := PHA.ParametresConnexion.Values['analyse'];
   // Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    //Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
   // Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

procedure TfrMIHyperFile.frMIHyperFile_AvantConnecter(Sender: TObject;
  var AAutorise: Boolean);
begin
  AAutorise :=    (PHA.ParametresConnexion.Values['bd'] <> '');
 { ((PHA.ParametresConnexion.Values['connexion_locale'] = '1') and (PHA.ParametresConnexion.Values['analyse'] <> '') and (PHA.ParametresConnexion.Values['bd'] <> '')) or
               ((PHA.ParametresConnexion.Values['connexion_locale'] = '0') and (PHA.ParametresConnexion.Values['analyse'] <> '') and (PHA.ParametresConnexion.Values['bd'] <> '') and
                (PHA.ParametresConnexion.Values['serveur'] <> '') and (PHA.ParametresConnexion.Values['utilisateur'] <> ''));    }
end;

end.
