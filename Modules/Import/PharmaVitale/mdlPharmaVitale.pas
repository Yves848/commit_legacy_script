unit mdlPharmaVitale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, DB,
  Grids, DBGrids, Menus, mdlModule, mdlModuleImport, mdlLectureFichierBinaire,
  mdlPIPanel, mdlProjet, ActnList, ImgList, PdfDoc, PReport, JvMenus,
  JvXPCore, JvXPContainer, JvWizard, JvWizardRouteMapNodes, JclAnsiStrings,
  mdlPIStringGrid, mdlPIDBGrid, JvExControls, JvXPBar, mdlConversionsTIFF,
  mdlMISQLServeur, mdlMISQLServeurPHA, VirtualTrees, JvExExtCtrls,
  JvNetscapeSplitter;

type
  TdmPharmaVitalePHA = class(TdmMISQLServeurPHA)
  public
    function CreerDonnees(AIDClient,AIDFacture : Integer; ALibelle,AFichierScan : string;ATypeScan : Integer): TResultatCreationDonnees; reintroduce;
  end;

  TfrPharmaVitale = class(TfrMISQLServeur, IInventaire)
    actAccesPharmaVitaleConnexion: TAction;
    actAccesPharmaVitaleDeconnexion: TAction;
    actAccesPharmaVitaleParametres: TAction;
  protected
    procedure RenvoyerParametresConnexion; override;
    function FaireTraitementDonnees(ADonnees : TFields) : TResultatCreationDonnees; override;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEnCours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
    function GenererInventaire : TStrings;
  end;

var
  frPharmaVitale : TfrPharmaVitale;

implementation

uses mdlPharmaVitaleConnexionServeur;

{$R *.dfm}
{$R logo.res}

{ TfrPharmaVitale }

procedure TfrPharmaVitale.TraiterDonnee(ATraitement: TTraitement);
begin
//  if ATraitement.Fichier = 'DOCUMENTS SCANNES' then
//  begin
//    frmConversionTIFF.Show;
//    frmConversionTIFF.Initialiser(Module.Projet.RepertoireApplication);
//  end;

  inherited;
end;

procedure TfrPharmaVitale.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ASSURES']);
end;

procedure TfrPharmaVitale.TraiterDonneesEnCours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['OPERATEURS']);
  TraiterDonnee(Traitements.Traitements['VIGNETTES AVANCEES']);
  TraiterDonnee(Traitements.Traitements['CREDITS']);
end;

procedure TfrPharmaVitale.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['DESTINATAIRES']);
  TraiterDonnee(Traitements.Traitements['ORGANISMES']);
  TraiterDonnee(Traitements.Traitements['MUTUELLES']);
  TraiterDonnee(Traitements.Traitements['GRILLES MUTUELLES']);
end;

procedure TfrPharmaVitale.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['MEDECINS']);
end;

procedure TfrPharmaVitale.TraiterDonneesProduits;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['DEPOTS']);
  TraiterDonnee(Traitements.Traitements['ZONES GEOGRAPHIQUES']);
  TraiterDonnee(Traitements.Traitements['CATEGORIES']);
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['PRODUITS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES VENTES']);
end;

procedure TfrPharmaVitale.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['DOCUMENTS SCANNES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES CLIENTS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES ACHATS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES ACHATS LIGNES']);
end;

procedure TfrPharmaVitale.RenvoyerParametresConnexion;
begin
  inherited;

  PHA.ParametresConnexion.Values['utilisateur'] := 'cepi';
  PHA.ParametresConnexion.Values['mot_de_passe'] := '';
  PHA.ParametresConnexion.Values['bd'] := 'PHARMAVITALEBD';

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
    if HasAttribute('serveur')then
    begin
      PHA.ParametresConnexion.Values['serveur'] := Attributes['serveur'];
      PHA.ParametresConnexion.Values['mot_de_passe'] := Attributes['mot_de_passe']
    end
    else
      PHA.ParametresConnexion.Values['serveur'] := 'SERVEUR';

end;

constructor TfrPharmaVitale.Create(AOwner: TComponent; AModule: TModule);
begin
  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;

  FInterfaceConnexion := TfrmPharmaVitaleConnexionServeur;
end;

function TfrPharmaVitale.FaireTraitementDonnees(
  ADonnees: TFields): TResultatCreationDonnees;
var
  fichier_scan : string;
begin
  if TraitementEnCours.Fichier = 'DOCUMENTS SCANNES' then
  begin
    fichier_scan := Module.Projet.RepertoireProjet
                    + 'Scans\'
                    + ADonnees.FieldByName('chemin').AsString
                    + ADonnees.FieldByName('nom_fichier').AsString;

    if FileExists(fichier_scan) then
    begin
      Result := TdmPharmaVitalePHA(dmMISQLServeurPHA).CreerDonnees(ADonnees.FieldByName('id_Client').AsInteger,
                                                                   ADonnees.FieldByName('id_Facture').AsInteger,
                                                                   ADonnees.FieldByName('nom_fichier').AsString,
                                                                   fichier_scan,
                                                                   ADonnees.FieldByName('type_scan').AsInteger);
    end
    else
      Result := rcdRejetee
    end
  else
    Result := inherited FaireTraitementDonnees(ADonnees);
end;

function TfrPharmaVitale.GenererInventaire : TStrings;
begin
  Result := TStringList.Create;
  with dmMISQLServeurPHA.adoDataset do
  begin
    SQL.Clear;
    Open;
    while not EOF do
    begin
      Result.Add(Fields[0].AsString + ' ' + StrPadLeft(Fields[1].AsString, 7, '0'));
      Next;
    end;
  end;
end;

{ TdmPharmaVitalePHA }

function TdmPharmaVitalePHA.CreerDonnees(AIDClient,AIDFacture : Integer; ALibelle, AFichierScan : string;ATypeScan : Integer): TResultatCreationDonnees;
begin
  Result := ExecuterPS('DOCUMENTS SCANNES', 'PS_PHARMAVITALE_CREER_SCAN',
                       VarArrayOf([AIDClient, AIDFacture, ALibelle, AFichierScan, ATypeScan]));
end;

initialization
  RegisterClasses([TfrPharmaVitale, TdmPharmaVitalePHA]);

finalization
  unRegisterClasses([TfrPharmaVitale, TdmPharmaVitalePHA]);

end.
