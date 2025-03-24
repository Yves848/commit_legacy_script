unit mdlOpus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, strutils,
  Grids, DBGrids, Menus, mdlPIPanel, ToolWin, mdlProjet, mdlModuleImport,
  ActnList, ImgList, PdfDoc, PReport, JvMenus, JvXPCore, JvXPContainer,
  JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, mdlPIDBGrid,
  JvExControls, mdlModule, JclFileUtils, mdlPIODBC, DB, JvXPBar, uib,
  mdlConversionsTIFF, mdlInformationFichier, mdlPIDataSet, mdlMIHyperFile,
  mdlMIHyperFilePHA, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, mdlTypes ;

type
  TdmOpusPHA = class(TdmMIHyperfilePHA)
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function CreerDocument(AIDClient: string; ALibelle : string; AFichier: string): TResultatCreationDonnees;
  end;

  TfrOpus = class(TfrMIHyperFile)
    grdProgrammesFidelites: TPIStringGrid;
    wipProgrammesFidelites: TJvWizardInteriorPage;
    procedure wzDonneesActivePageChanged(Sender: TObject);
  public
    { Déclarations publiques }
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    function FaireTraitementDonnees(ADonnees: TFields): TResultatCreationDonnees; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterProgrammesFidelites;
  end;

var
  frOpus: TfrOpus;

implementation

uses mdlOpusConfiguration;

{$R *.dfm}

{ TfrOpus }

function TfrOpus.FaireTraitementDonnees(ADonnees: TFields): TResultatCreationDonnees;
var
  f: string;
begin
  with TTraitementBD(TraitementEnCours) do
  begin
    // si le traitement contient "Documents"
    // traitement special qui integre le chemin complet au fichier
    if (pos('Documents' ,TraitementEnCours.Fichier) > 0) then
    begin
      f := Module.Projet.RepertoireProjet + 'Document\' + Trim(ADonnees.FieldByName('dg_fic').AsString);
      // seuls les fichiers jpg presents sont intégrés
      if (FileExists(f + '.jpg')) then
        Result := TdmOpusPHA(PHA).CreerDocument(ADonnees.FieldByName('du_code').AsString, ADonnees.FieldByName('du_libel').AsString, f + '.jpg')
      else
        begin
          Module.projet.console.Ajouterligne('Fichier:'+ f + '.jpg'+ ' non présent dans le repertoire \Document');
          Result := rcdErreur;
        end;
      end
    // sinon traitement classique ( avec chemin complet + nom du fichier )
    else
      Result := PHA.ExecuterPS(Fichier, ProcedureCreation, ADonnees);
  end;
end;

procedure TfrOpus.TraiterDonnee(ATraitement: TTraitement);
var
  s: string;
begin
  s := Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection;

  // Lancement conversions
  {if ATraitement.Fichier = 'Documents' then
  begin
    frmConversionTIFF.Show;
    frmConversionTIFF.Initialiser(Module.Projet.RepertoireApplication);
  end;
  }

  // Chargement de la requete
  dmMIHyperFilePHA.qryPI.SQL.LoadFromFile(s);
  inherited TraiterDonnee(ATraitement);
end;

procedure TfrOpus.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Comptes']);
  TraiterDonnee(Traitements.Traitements['Clients']);
end;

procedure TfrOpus.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Destinataires']);
  TraiterDonnee(Traitements.Traitements['Organismes AMO']);
  TraiterDonnee(Traitements.Traitements['Organismes AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO']);
  TraiterDonnee(Traitements.Traitements['Couv Org AMO']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
end;

procedure TfrOpus.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Medecins']);
end;

procedure TfrOpus.TraiterDonneesProduits;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Familles']);
  TraiterDonnee(Traitements.Traitements['Zones Géographiques']);
  TraiterDonnee(Traitements.Traitements['Répartiteurs']);
  TraiterDonnee(Traitements.Traitements['Fournisseurs']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Ean']);
  TraiterDonnee(Traitements.Traitements['Historiques Vente']);
  TraiterDonnee(Traitements.Traitements['Lpp']);
end;

procedure TfrOpus.TraiterAutresDonnees;
begin
  TraiterDonnee(Traitements.Traitements['Historiques Délivrance']);
  TraiterDonnee(Traitements.Traitements['Historiques Délivrance Lignes']);
  TraiterDonnee(Traitements.Traitements['Historiques Achats']);
  TraiterDonnee(Traitements.Traitements['Lignes Historiques Achats']);
  TraiterDonnee(Traitements.Traitements['Documents Mut']);
  TraiterDonnee(Traitements.Traitements['Documents Ord']);
end;

procedure TfrOpus.TraiterDonneesEncours;
begin
  TraiterDonnee(Traitements.Traitements['Opérateurs']);
  TraiterDonnee(Traitements.Traitements['Commandes En Cours']);
  TraiterDonnee(Traitements.Traitements['Lignes Commandes En Cours']);
  TraiterDonnee(Traitements.Traitements['Avances Vignettes']);
  TraiterDonnee(Traitements.Traitements['Factures en attente']);
  TraiterDonnee(Traitements.Traitements['Factures en attente lignes']);
  TraiterDonnee(Traitements.Traitements['Crédits']);
end;



procedure TfrOpus.TraiterProgrammesFidelites;
var
  type_avantage, type_objectif : integer ;
  valeur_avantage, valeur_objectif : double ;
begin

  if Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes['carte_avantage'] = True  then
  begin
    type_avantage := Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes['cf_type_avantage'];
    type_objectif :=  Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes['cf_type_objectif'];
    valeur_avantage := Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes['cf_valeur_avantage'];
    valeur_objectif :=  Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes['cf_valeur_objectif'];

    // fonctionne pas , pas trouvé pourquoi ! alors que idem que leo1
//    if PHA.ExecuterPS('Carte Fidélité', 'PS_Opus_CREER_CF', Vararrayof([ type_objectif,  valeur_objectif, type_avantage , valeur_avantage])) = rcdImportee then
  //    Traitements.Traitements['Carte Fidélité'].Fait := True;
  end;
    TraiterDonnee(Traitements.Traitements['Programme relationnel']);
    TraiterDonnee(Traitements.Traitements['Programme avantage']);
    TraiterDonnee(Traitements.Traitements['Encours clients programme avantage']);
    TraiterDonnee(Traitements.Traitements['Produits programme avantage']);
end;


procedure TfrOpus.wzDonneesActivePageChanged(Sender: TObject);
const
  C_INDEX_PAGE_PROGRAMMES_FIDELITES = 7;
  // pages non traites en automatique Programme Fidelite : parce que pas dans module import
  procedure TraiterDonnee;
  begin
    case wzDonnees.ActivePageIndex of C_INDEX_PAGE_PROGRAMMES_FIDELITES: TraiterProgrammesFidelites;
    end;
  end;

begin
  inherited;
  if Assigned(Module) and Module.Projet.Ouvert and (wzDonnees.ActivePageIndex = wipProgrammesFidelites.PageIndex) then
   TraiterDonnees(wipProgrammesFidelites, grdProgrammesFidelites, False, TPIList<Integer>.Create([Ord(suppCarteFidelite)]), TraiterProgrammesFidelites);
end;


{ TdmOpusPHA }

function TdmOpusPHA.CreerDocument(AIDClient: string; ALibelle,
  AFichier: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('Documents', 'PS_Opus_CREER_DOCUMENT',
                       VarArrayOf([AIDClient, ALibelle, AFichier]));
end;

initialization

RegisterClasses([TfrOpus, TdmOpusPHA, TfrOpusConfiguration]);

finalization

unRegisterClasses([TfrOpus, TdmOpusPHA, TfrOpusConfiguration]);

end.
