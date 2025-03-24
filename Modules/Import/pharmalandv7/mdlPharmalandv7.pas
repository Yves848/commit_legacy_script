unit mdlPharmalandV7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls,strutils, DB,
  Grids, DBGrids, Menus, mdlPIPanel, ToolWin, mdlProjet, mdlModuleImport,
  ActnList, ImgList, PdfDoc, PReport, JvMenus, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, mdlPIDBGrid, Generics.Collections,
  JvExControls, mdlModule, uib, JclShell, DBTables,
  mdlMIHyperFile, mdlMIHyperFilePHA, JvXPBar, VirtualTrees, JvExExtCtrls,
  JvNetscapeSplitter;

type
  TdmPharmalandV7PHA = class(TdmMIHyperFilePHA)
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure SupprimerDonnees(ADonneesASupprimer : TList<Integer>); override;
    function CreerDocument( ALibelle : string; AFichier: string): TResultatCreationDonnees;

  end;

  TfrPharmalandV7 = class(TfrMIHyperFile)
  protected
    { Déclarations publiques }
    procedure StockerParametresConnexion; override;
    procedure RenvoyerParametresConnexion; override;
    procedure TraiterDonnee(ATraitement : TTraitement); reintroduce;
  public
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
    function FaireTraitementDocumentSF(ARepertoire, afichier: string): TResultatCreationDonnees; override;
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

var
  frPharmalandV7 : TfrPharmalandV7;

implementation

{$R *.dfm}

{ TfrPharmalandV7 }

constructor TfrPharmalandV7.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;
  ModesGeres := [mtNormal];
end;

procedure TfrPharmalandV7.RenvoyerParametresConnexion;
begin
  inherited;

  PHA.ParametresConnexion.Values['connexion_locale'] := '1';
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('analyse') then PHA.ParametresConnexion.Values['analyse'] :=  Attributes['analyse'] else PHA.ParametresConnexion.Values['analyse'] := Module.Projet.RepertoireProjet + 'PHARML.WDD';
    if HasAttribute('bd') then PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd'] else PHA.ParametresConnexion.Values['bd'] := Module.Projet.RepertoireProjet;
  end;
end;

procedure TfrPharmalandV7.StockerParametresConnexion;
begin
  inherited;

end;

procedure TfrPharmalandV7.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Historique clients']);
  TraiterDonnee(Traitements.Traitements['Commandes']);
  TraiterDonnee(Traitements.Traitements['Commandes lignes']);
end;

procedure TfrPharmalandV7.TraiterDonnee(ATraitement: TTraitement);
begin
  dmMIHyperFilePHA.qryPI.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);
  inherited TraiterDonnee(ATraitement);
end;

procedure TfrPharmalandV7.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Clients']);
end;

procedure TfrPharmalandV7.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Organismes AMO et AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
  TraiterDonnee(Traitements.Traitements['MAJ Couvertures AMC']);
  TraiterDonnee(Traitements.Traitements['MAJ Taux AMC']);
end;

procedure TfrPharmalandV7.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Medecins']);
end;

procedure TfrPharmalandV7.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Fournisseurs']);
  TraiterDonnee(Traitements.Traitements['Zones geographiques']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Historique ventes']);
end;


procedure TfrPharmalandV7.TraiterDonneesEncours;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Operateurs']);
  TraiterDonnee(Traitements.Traitements['Credits']);
  TraiterDonnee(Traitements.Traitements['Factures en attente']);
  TraiterDonnee(Traitements.Traitements['Lignes factures en attente']);
end;
{ TdmPharmalandV7PHA }

procedure TdmPharmalandV7PHA.SupprimerDonnees(
  ADonneesASupprimer: TList<Integer>);
begin
  if ADonneesASupprimer.IndexOf(Ord(suppProduits)) <> -1 then
    ADonneesASupprimer.Add(101);

  inherited;
end;

function TfrPharmalandV7.FaireTraitementDocumentSF(ARepertoire, afichier: string): TResultatCreationDonnees;
var
  s: string;
  i: Integer;
begin

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import']  do
  begin

    with ChildNodes['options'].ChildNodes['scan'] do
    begin
      Attributes['chemin'] := Module.Projet.RepertoireProjet +'scans\';
      Attributes['recursif'] := true;
      Attributes['type'] := 'JPG|PDF';
    end;
  end;
  s := ExtractFileName(Copy(ARepertoire, 1, Length(ARepertoire) - 1));

  if ((pos('.PDF',UpperCase(afichier))>0) or (pos('.JPG',UpperCase(afichier))>0)) then
  begin
    // debug a virer quand tests PROD OK
    Module.Projet.Console.Ajouterligne('IMPORT de '+afichier);
    Result := TdmPharmalandV7PHA(PHA).CreerDocument( afichier, ARepertoire )
  end
  else
  begin
    // debug a virer quand tests PROD OK
    Module.Projet.Console.Ajouterligne('Non traité '+afichier);
    Result := rcdRejetee;
  end;
end;


function TdmPharmalandV7PHA.CreerDocument(ALibelle : string; AFichier: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('SCANS', 'PS_PHARMALANDV7_CREER_DOCUMENT', VarArrayOf([ALibelle, AFichier]));
end;

initialization
  RegisterClasses([TfrPharmalandV7, TdmPharmalandV7PHA]);

finalization
  unRegisterClasses([TfrPharmalandV7, TdmPharmalandV7PHA]);

end.
