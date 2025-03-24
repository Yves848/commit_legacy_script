unit mdlVisioPharm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, DB,
  Grids, DBGrids, Menus, mdlModule, mdlModuleImport,
  mdlPIPanel, mdlProjet, ActnList, ImgList, PdfDoc, PReport, JvMenus,
  JvXPCore, JvXPContainer, JvWizard, JvWizardRouteMapNodes,
  mdlPIStringGrid, mdlPIDBGrid, JvExControls, JvXPBar, VirtualTrees,
  JvExExtCtrls, JvNetscapeSplitter, mdlMIFirebird, mdlMIfirebirdPHA;

type
  TdmVisioPharmPHA = class(TdmMIFirebirdPHA)
    procedure DataModuleCreate(Sender: TObject);
  public
    function CreerDocument( ALibelle : string; AFichier: string): TResultatCreationDonnees;

  end;

  TfrVisioPharm = class(TfrMIFirebird)
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
    function FaireTraitementDocumentSF(ARepertoire, afichier: string): TResultatCreationDonnees; override;


  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
      end;

var
  frVisioPharm : TfrVisioPharm;

implementation

{$R *.dfm}

{ TfrVisioPharm}

procedure TfrVisioPharm.RenvoyerParametresConnexion;
begin
  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
    if HasAttribute('bd') then PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd'] else PHA.ParametresConnexion.Values['bd'] := Module.Projet.RepertoireProjet + '\PHARMACIE.FDB';
end;

constructor TfrVisioPharm.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;

  ModesGeres := [mtNormal];

end;

procedure TfrVisioPharm.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ASSURES']);
  TraiterDonnee(Traitements.Traitements['BENEFICIAIRES']);
end;


procedure TfrVisioPharm.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['MEDECINS']);
end;

procedure TfrVisioPharm.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ORGANISMES']);
  TraiterDonnee(Traitements.Traitements['COUVERTURES']);
  //TraiterDonnee(Traitements.Traitements['TAUX PRISE EN CHARGE']);
end;



procedure TfrVisioPharm.TraiterDonneesProduits;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['ZONES GEOGRAPHIQUES']);
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['PRODUITS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES VENTES']);
end;

procedure TfrVisioPharm.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['HISTORIQUES CLIENTS ENTETES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES CLIENTS LIGNES']);
  TraiterDonnee(Traitements.Traitements['COMMANDES']);
  TraiterDonnee(Traitements.Traitements['COMMANDES LIGNES']);
  PHA.ExecuterPS('Création des catalogues (1.0.4j et +)','PS_CREER_CATALOGUES', null, True);

end;


procedure TfrVisioPharm.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['OPERATEURS']);
  TraiterDonnee(Traitements.Traitements['AVANCES VIGNETTES']);
  TraiterDonnee(Traitements.Traitements['CREDITS']);
end;

{ TdmVisioPharmPHA }

procedure TdmVisioPharmPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;
   ZConnection1.LibraryLocation := Module.Projet.RepertoireApplication + '\fb\fbclient.dll';
   ZConnection1.Protocol := 'firebirdd-2.5';
end;

function TfrVisioPharm.FaireTraitementDocumentSF(ARepertoire, afichier: string): TResultatCreationDonnees;
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


  if ((pos('-1.pdf',afichier)>0) or (pos('#.jpg',afichier)>0)) then
  begin
    // debug a virer quand tests PROD OK
    Module.Projet.Console.Ajouterligne('IMPORT de '+afichier);
    Result := TdmVisioPharmPHA(PHA).CreerDocument( afichier, ARepertoire )
  end
  else
  begin
    // debug a virer quand tests PROD OK
    Module.Projet.Console.Ajouterligne('Non traité '+afichier);
    Result := rcdRejetee;
  end;
end;

function TdmVisioPharmPHA.CreerDocument(ALibelle : string; AFichier: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('SCANS', 'PS_VISIOPHARM_CREER_DOCUMENT', VarArrayOf([ALibelle, AFichier]));
end;


initialization
  RegisterClasses([TfrVisioPharm, TdmVisioPharmPHA]);

finalization
  unRegisterClasses([TfrVisioPharm, TdmVisioPharmPHA]);

end.