unit mdlMIMySQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, mdlMySQLConnexionServeur, StdCtrls,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, WIdeStrUtils;

type
  TfrMIMySQL = class(TfrModuleImport)
    procedure frMIMySQL_AvantConnecter(Sender : TObject; var AAutorise : Boolean);
  private
    { Déclarations privées }
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
    procedure Connecter; override;
  end;

implementation

uses mdlMIMySQLPHA;

{$R *.dfm}

{ TfrMySQL }

procedure TfrMIMySQL.Connecter;
begin
  inherited;

  if FConnecte then
    StockerParametresConnexion;
end;

constructor TfrMIMySQL.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;

  inherited;

  FInterfaceConnexion := TfrmMySQLConnexionServeur;
  SurAvantConnecter := frMIMySQL_AvantConnecter;
end;

procedure TfrMIMySQL.frMIMySQL_AvantConnecter(Sender: TObject;
  var AAutorise: Boolean);
begin
  AAutorise := ((PHA.ParametresConnexion.Values['connexion_locale'] = '1') and (PHA.ParametresConnexion.Values['bd'] <> '')) or
               ((PHA.ParametresConnexion.Values['serveur'] <> '') and (PHA.ParametresConnexion.Values['bd'] <> '') and (PHA.ParametresConnexion.Values['utilisateur'] <> ''));
end;

procedure TfrMIMySQL.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('connexion_locale') = -1 then PHA.ParametresConnexion.Add('connexion_locale=');
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then PHA.ParametresConnexion.Add('bd=');
  if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then PHA.ParametresConnexion.Add('utilisateur=');
  if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then PHA.ParametresConnexion.Add('mot_de_passe=');
  if PHA.ParametresConnexion.IndexOfName('options') = -1 then PHA.ParametresConnexion.Add('options=');
  if PHA.ParametresConnexion.IndexOfName('version_serveur') = -1 then PHA.ParametresConnexion.Add('version_serveur=');
  if PHA.ParametresConnexion.IndexOfName('dump_sql') = -1 then PHA.ParametresConnexion.Add('dump_sql=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('connexion_locale') then PHA.ParametresConnexion.Values['connexion_locale'] := Attributes['connexion_locale'] else PHA.ParametresConnexion.Values['connexion_locale'] := '0';
    if HasAttribute('serveur') then PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur'] else PHA.ParametresConnexion.Values['serveur'] := '192.168.0.10';
    if HasAttribute('utilisateur') then PHA.ParametresConnexion.Values['utilisateur'] :=  Attributes['utilisateur'] else PHA.ParametresConnexion.Values['utilisateur'] := 'root';
    if HasAttribute('mot_de_passe') then PHA.ParametresConnexion.Values['mot_de_passe'] :=  Attributes['mot_de_passe'] else PHA.ParametresConnexion.Values['mot_de_passe'] := '';
    if HasAttribute('options') then PHA.ParametresConnexion.Values['options'] :=  Attributes['options'] else PHA.ParametresConnexion.Values['options'] := '';
    if HasAttribute('version_serveur') then PHA.ParametresConnexion.Values['version_serveur'] :=  Attributes['version_serveur'] else PHA.ParametresConnexion.Values['version_serveur'] := '0';
    if HasAttribute('dump_sql') then PHA.ParametresConnexion.Values['dump_sql'] :=  Attributes['dump_sql'] else PHA.ParametresConnexion.Values['dump_sql'] := '';
  end;
end;

procedure TfrMIMySQL.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['connexion_locale'] := PHA.ParametresConnexion.Values['connexion_locale'];
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
    Attributes['version_serveur'] := PHA.ParametresConnexion.Values['version_serveur'];
    Attributes['options'] := PHA.ParametresConnexion.Values['options'];
    Attributes['dump_sql'] := PHA.ParametresConnexion.Values['dump_sql'];
  end;
end;

end.
