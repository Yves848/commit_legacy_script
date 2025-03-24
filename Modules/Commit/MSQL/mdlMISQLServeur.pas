unit mdlMISQLServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, mdlMIOLEDB, StdCtrls, VirtualTrees, JvExExtCtrls,
  JvNetscapeSplitter;

type
  TfrMISQLServeur = class(TfrMIOLEDB)
    procedure frMIServeurSQL_AvantConnecter(Sender : TObject; var AAutorise : Boolean);
  private
    { Déclarations privées }
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

implementation

uses mdlMISQLServeurPHA, mdlSQLServeurConnexionServeur;

{$R *.dfm}

{ TfrMISQLServeur }

constructor TfrMISQLServeur.Create(AOwner: TComponent; AModule: TModule);
var
  s : string;
begin
  ModeConnexion := mcServeurSQL;

  inherited;

  SurAvantConnecter := frMIServeurSQL_AvantConnecter;
  FInterfaceConnexion := TfrmSQLServeurConnexionServeur;

  s := '';
  dmMISQLServeurPHA.setFichiersManquants.DisableControls;
  while (s = '') and not dmMISQLServeurPHA.setFichiersManquants.Eof do
    if ExtractFileExt(dmMISQLServeurPHA.setFichiersManquantsAFICHIER.AsString) = '.mdf' then
      s := Module.Projet.RepertoireProjet + dmMISQLServeurPHA.setFichiersManquantsAFICHIER.AsString
    else
      dmMISQLServeurPHA.setFichiersManquants.Next;
  dmMISQLServeurPHA.setFichiersManquants.EnableControls;
  dmMISQLServeurPHA.FichierData := s;
end;

procedure TfrMISQLServeur.frMIServeurSQL_AvantConnecter(Sender: TObject; var AAutorise : Boolean);
begin
  AAutorise := (((PHA.ParametresConnexion.Values['connexion_locale'] = '0') and (PHA.ParametresConnexion.Values['serveur'] <> '')) or
                (PHA.ParametresConnexion.Values['connexion_locale'] = '1')) and
               (PHA.ParametresConnexion.Values['bd'] <> '') and
               (PHA.ParametresConnexion.Values['utilisateur'] <> '');
end;

procedure TfrMISQLServeur.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('authentification_windows') = -1 then PHA.ParametresConnexion.Add('authentification_windows=');
  if PHA.ParametresConnexion.IndexOfName('connexion_locale') = -1 then PHA.ParametresConnexion.Add('connexion_locale=');
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then PHA.ParametresConnexion.Add('bd=');
  if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then PHA.ParametresConnexion.Add('utilisateur=');
  if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then PHA.ParametresConnexion.Add('mot_de_passe=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('authentification_windows') then PHA.ParametresConnexion.Values['authentification_windows'] := Attributes['authentification_windows'] else PHA.ParametresConnexion.Values['authentification_windows'] := '0';
    if HasAttribute('connexion_locale') then PHA.ParametresConnexion.Values['connexion_locale'] := Attributes['connexion_locale'] else PHA.ParametresConnexion.Values['connexion_locale'] := '0';
    if HasAttribute('serveur') then PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur'] else PHA.ParametresConnexion.Values['serveur'] := '192.168.0.10';
    if HasAttribute('utilisateur') then PHA.ParametresConnexion.Values['utilisateur'] :=  Attributes['utilisateur'] else PHA.ParametresConnexion.Values['utilisateur'] := 'sa';
    if HasAttribute('mot_de_passe') then PHA.ParametresConnexion.Values['mot_de_passe'] :=  Attributes['mot_de_passe'] else PHA.ParametresConnexion.Values['mot_de_passe'] := '';
  end;
end;

procedure TfrMISQLServeur.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['authentification_windows'] := PHA.ParametresConnexion.Values['authentification_windows'];
    Attributes['connexion_locale'] := PHA.ParametresConnexion.Values['connexion_locale'];
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

end.
