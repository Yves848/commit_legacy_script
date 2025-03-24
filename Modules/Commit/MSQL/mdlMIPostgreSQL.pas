unit mdlMIPostgreSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, mdlPostgreSQLConnexionServeur, StdCtrls,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter,jclSecurity, WIdeStrUtils;

type
  TfrMIPostgreSQL = class(TfrModuleImport)
    procedure frMIPostgreSQL_AvantConnecter(Sender : TObject; var AAutorise : Boolean);
    procedure actAccesBDParametresExecute(Sender: TObject);
  private
    { Déclarations privées }
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
    procedure Connecter; override;
  end;

implementation

uses mdlMIPostgreSQLPHA;

{$R *.dfm}

{ TfrPostgreSQL }

procedure TfrMIPostgreSQL.TraiterDonnee(ATraitement: TTraitement);
begin
  if TTraitementBD(ATraitement).RequeteSelection <> '' then
  begin
    dmMIPostgreSQLPHA.qryPostgreSQL.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);
    inherited TraiterDonnee(ATraitement, dmMIPostgreSQLPHA.qryPostgreSQL);
  end
  else
    inherited;
end;

procedure TfrMIPostgreSQL.actAccesBDParametresExecute(Sender: TObject);
begin
  if IsAdministrator then
    inherited
  else
    showMessage('Vous devez démarrer commit en mode ''Administrateur'' pour avoir accès aux paramètres');

end;

procedure TfrMIPostgreSQL.Connecter;
begin
  inherited;

  if FConnecte then
    StockerParametresConnexion;
end;

constructor TfrMIPostgreSQL.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;

  inherited;

  FInterfaceConnexion := TfrmPostgreSQLConnexionServeur;
  SurAvantConnecter := frMIPostgreSQL_AvantConnecter;
end;

procedure TfrMIPostgreSQL.frMIPostgreSQL_AvantConnecter(Sender: TObject;
  var AAutorise: Boolean);
begin
  AAutorise := ((PHA.ParametresConnexion.Values['serveur'] <> '') and (PHA.ParametresConnexion.Values['bd'] <> '') and (PHA.ParametresConnexion.Values['utilisateur'] <> ''));
end;

procedure TfrMIPostgreSQL.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then PHA.ParametresConnexion.Add('bd=');
  if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then PHA.ParametresConnexion.Add('utilisateur=');
  if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then PHA.ParametresConnexion.Add('mot_de_passe=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('serveur') then PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur'] else PHA.ParametresConnexion.Values['serveur'] := '192.168.0.10';
    if HasAttribute('bd') then PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd'] else PHA.ParametresConnexion.Values['bd'] := 'vindilis';
    if HasAttribute('utilisateur') then PHA.ParametresConnexion.Values['utilisateur'] :=  Attributes['utilisateur'] else PHA.ParametresConnexion.Values['utilisateur'] := 'postgres';
    if HasAttribute('mot_de_passe') then PHA.ParametresConnexion.Values['mot_de_passe'] :=  Attributes['mot_de_passe'] else PHA.ParametresConnexion.Values['mot_de_passe'] := 'vindilis';
  end;
end;

procedure TfrMIPostgreSQL.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

end.
