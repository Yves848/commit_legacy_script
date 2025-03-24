unit mdlImportUltimate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, mdlPIPanel, ToolWin, ComCtrls,
  StdCtrls, Buttons, mdlPISpeedButton, mdlProjet, mdlModuleImport,
  Grids, DB, ActnList, ImgList, PdfDoc, PReport, JvMenus, JvXPCore,
  JvXPContainer, JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, JvXPBar, mdlModule, uib, VirtualTrees,
  JvExExtCtrls, JvNetscapeSplitter, mdlOracleConnexionServeur, Ora, OraClasses;

type
  TfrImportUltimate = class(TfrModuleImport)
  private
    { Déclarations privées }
  protected
    function FaireTraitementDonnees(ADonnees :  TFields) : TResultatCreationDonnees; override;
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

implementation

uses mdlImportUltimatePHA;

{$R *.dfm}
{$R logo.res}

{ TfrImportUltimate }

constructor TfrImportUltimate.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;
  FInterfaceConnexion := TfrmOracleConnexionServeur;

  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;
end;

function TfrImportUltimate.FaireTraitementDonnees(
  ADonnees: TFields): TResultatCreationDonnees;
var
  s : string;
  str : TMemoryStream;
begin

    Result := inherited FaireTraitementDonnees(ADonnees);
end;

procedure TfrImportUltimate.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then PHA.ParametresConnexion.Add('serveur=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin                // recup des infos de connexion de la fenetre
    if HasAttribute('serveur') then
      PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur']
    else
      PHA.ParametresConnexion.Values['serveur'] := '192.168.0.100'; //attribution des valeurs par defaut

    if HasAttribute('utilisateur') then
    PHA.ParametresConnexion.Values['utilisateur'] :=  Attributes['utilisateur']
      else
    PHA.ParametresConnexion.Values['utilisateur'] := 'BEL';

    if HasAttribute('mot_de_passe') then
    PHA.ParametresConnexion.Values['mot_de_passe'] :=  Attributes['mot_de_passe']
      else
    PHA.ParametresConnexion.Values['mot_de_passe'] := 'BEL';
  end;end;

procedure TfrImportUltimate.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

procedure TfrImportUltimate.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Historiques délivrances entêtes']);
  TraiterDonnee(Traitements.Traitements['Historiques délivrances lignes']);
  TraiterDonnee(Traitements.Traitements['Historiques délivrances magistrales']);
  TraiterDonnee(Traitements.Traitements['Attestations patients']);
end;

procedure TfrImportUltimate.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Clients']);
  TraiterDonnee(Traitements.Traitements['Etats pathologies']);
  TraiterDonnee(Traitements.Traitements['Allergies ATC']);
  TraiterDonnee(Traitements.Traitements['Comptes Ristournes']);
  TraiterDonnee(Traitements.Traitements['Cartes Ristournes']);
  TraiterDonnee(Traitements.Traitements['Transactions Ristournes']);
end;

procedure TfrImportUltimate.TraiterDonneesOrganismes;
begin
  inherited;

  {TraiterDonnee(Traitements.Traitements['Destinataires']);
  TraiterDonnee(Traitements.Traitements['Organismes']);
  TraiterDonnee(Traitements.Traitements['Associations AMO AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
  TraiterDonnee(Traitements.Traitements['Taux de prise en charge']);       }
end;

procedure TfrImportUltimate.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Praticiens']);
end;

procedure TfrImportUltimate.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Depots']);
  TraiterDonnee(Traitements.Traitements['Zones géographiques']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Stocks']);
  TraiterDonnee(Traitements.Traitements['Codes Ean13']);
  //TraiterDonnee(Traitements.Traitements['Historiques ventes']);
 // if (dmImportUltimatePHA.VersionLGPI = '104I') and
 //    (dmImportUltimatePHA.VersionLGPI = '104H') then
 { begin
    TraiterDonnee(Traitements.Traitements['Tarifs']);
    Traitements.Traitements['Catalogues'].Fait := True;
    Traitements.Traitements['Classifications fournisseurs'].Fait := True;
    Traitements.Traitements['Lignes catalogues'].Fait := True;
  end                                                       }
  //else
  //begin
    //Traitements.Traitements['Tarifs'].Fait := True;
   // TraiterDonnee(Traitements.Traitements['Classifications fournisseurs']);
  //end;
  //TraiterDonnee(Traitements.Traitements['Historique achats entêtes']);
  //TraiterDonnee(Traitements.Traitements['Historique achats lignes']);
end;

procedure TfrImportUltimate.TraiterDonnee(ATraitement: TTraitement);
begin
    dmImportUltimatePHA.qryUltimate.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);

  inherited TraiterDonnee(ATraitement, dmImportUltimatePHA.qryUltimate);
end;

procedure TfrImportUltimate.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Crédits']);
  TraiterDonnee(Traitements.Traitements['Avances']);
  TraiterDonnee(Traitements.Traitements['Délivrances différées']);
end;

initialization
  RegisterClasses([TfrImportUltimate, TdmImportUltimatePHA]);

finalization
  UnRegisterClasses([TfrImportUltimate, TdmImportUltimatePHA]);

end.
