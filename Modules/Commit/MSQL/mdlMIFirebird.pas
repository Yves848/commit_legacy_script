unit mdlMIFirebird;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, mdlProjet, mdlModule, mdlModuleImport, DB, ActnList, ImgList, PdfDoc, PReport,
  Menus, JvMenus, ExtCtrls, mdlPIPanel, JvXPBar, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, ComCtrls, Grids, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, StdCtrls, VirtualTrees, JvExExtCtrls,
  JvNetscapeSplitter, Sockets;

type
  TfrMIFirebird = class(TfrModuleImport)
    procedure frMIFirebird_AvantConnecter(Sender : TObject; var AAutorise : Boolean);
  private
    { Déclarations privées }
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

implementation

uses mdlMIFirebirdPHA, mdlFirebirdConnexionServeur;

{$R *.dfm}

{ TfrFirebird }

constructor TfrMIFirebird.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;

  inherited;

  SurAvantConnecter := frMIFirebird_AvantConnecter;
  FInterfaceConnexion := TfrmFirebirdConnexionServeur;
end;

procedure TfrMIFirebird.frMIFirebird_AvantConnecter(Sender: TObject;
  var AAutorise: Boolean);
begin
  AAutorise := ((PHA.ParametresConnexion.Values['connexion_locale'] = '1') or (PHA.ParametresConnexion.Values['serveur'] <> '')) and
               (PHA.ParametresConnexion.Values['bd'] <> '');
end;

procedure TfrMIFirebird.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('connexion_locale') = -1 then PHA.ParametresConnexion.Add('connexion_locale=');
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then PHA.ParametresConnexion.Add('bd=');
  if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then PHA.ParametresConnexion.Add('utilisateur=');
  if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then PHA.ParametresConnexion.Add('mot_de_passe=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('connexion_locale') then PHA.ParametresConnexion.Values['connexion_locale'] := Attributes['connexion_locale'] else PHA.ParametresConnexion.Values['connexion_locale'] := '0';
    if HasAttribute('serveur') then PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur'] else PHA.ParametresConnexion.Values['serveur'] := '127.0.0.1';
    if HasAttribute('utilisateur') then PHA.ParametresConnexion.Values['utilisateur'] :=  Attributes['utilisateur'] else PHA.ParametresConnexion.Values['utilisateur'] := 'SYSDBA';
    if HasAttribute('mot_de_passe') then PHA.ParametresConnexion.Values['mot_de_passe'] :=  Attributes['mot_de_passe'] else PHA.ParametresConnexion.Values['mot_de_passe'] := 'masterkey';
  end;
end;

procedure TfrMIFirebird.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['connexion_locale'] := PHA.ParametresConnexion.Values['connexion_locale'];
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

procedure TfrMIFirebird.TraiterDonnee(ATraitement: TTraitement);
begin
  if TTraitementBD(ATraitement).RequeteSelection <> '' then
  begin
    //dmMIFirebirdPHA.qryFirebird.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);
    //inherited TraiterDonnee(ATraitement, dmMIFirebirdPHA.qryFirebird);
    dmMIFirebirdPHA.ZQuery1.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);
    inherited TraiterDonnee(ATraitement, dmMIFirebirdPHA.ZQuery1);
  end
  else
    inherited TraiterDonnee(ATraitement);
end;

end.
