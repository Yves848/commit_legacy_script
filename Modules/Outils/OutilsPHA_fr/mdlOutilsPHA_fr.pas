unit mdlOutilsPHA_fr;

interface

uses
  Windows, SysUtils, Classes, mdlModuleOutils, Menus, JvMenus, Dialogs, Controls,
  mdlModule, Variants;

type
  TdmOutilsPHA_fr = class(TdmModuleOutils)
    mnuOutils: TMenuItem;
    mnuOutilsPurges: TMenuItem;
    mnuSeparateur_1: TMenuItem;
    mnuOutilsProduits: TMenuItem;
    mnuOutilsProduitsReDefaut: TMenuItem;
    mnuOutilsIncoherences: TMenuItem;
    mnuOutilsProduitsAuditHomeo: TMenuItem;
    mnuOutilsOrganismes: TMenuItem;
    mnuOutilsOrganismesDestinataires: TMenuItem;
    mnuOutilsOrganismesSantePHARMA: TMenuItem;
    mnuRepriseInitialisation: TMenuItem;
    N1: TMenuItem;
    mnuSeparateur_2: TMenuItem;
    mnuReprise: TMenuItem;
    mnuSeparateur3: TMenuItem;
    mnuProduitsInventaire: TMenuItem;
    procedure mnuOutilsPurgesClick(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure mnuOutilsProduitsReDefautClick(Sender: TObject);
    procedure mnuOutilsIncoherencesClick(Sender: TObject);
    procedure mnuOutilsProduitsAuditHomeoClick(Sender: TObject);
    procedure mnuOutilsOrganismesDestinatairesClick(Sender: TObject);
    procedure mnuOutilsOrganismesSantePHARMAClick(Sender: TObject);
    procedure mnuRepriseInitialisationClick(Sender: TObject);
    procedure mnuProduitsInventaireClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  dmOutilsPHA_fr: TdmOutilsPHA_fr;

implementation

uses mdlPurges, mdlOutilsPHAPHA_fr,
  mdlRepartiteurDefaut, mdlIncoherence,
  mdlAuditHomeo, mdlTeletransmission, mdlSantePHARMA, mdlChoixDate,
  mdlChoixID, mdlProjet, mdlInventaire;

{$R *.dfm}

procedure TdmOutilsPHA_fr.mnuOutilsPurgesClick(Sender: TObject);
begin
  inherited;

  TfrmPurges.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_fr.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmOutilsPHA_fr := Self;
  dmOutilsPHAPHA_fr := TdmOutilsPHAPHA_fr.Create(Self, Projet);
end;

procedure TdmOutilsPHA_fr.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(frmChoixDate) then FreeAndNil(frmChoixDate);
  if Assigned(frmChoixID) then FreeAndNil(frmChoixID);
  if Assigned(dmOutilsPHAPHA_fr) then FreeAndNil(dmOutilsPHAPHA_fr);
  
  inherited;
end;

procedure TdmOutilsPHA_fr.mnuOutilsProduitsReDefautClick(Sender: TObject);
begin
  inherited;

  TfrmRepartiteurDefaut.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_fr.mnuOutilsIncoherencesClick(Sender: TObject);
begin
  inherited;

  TfrmIncoherence.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_fr.mnuOutilsProduitsAuditHomeoClick(Sender: TObject);
begin
  inherited;

  TfrmAuditHomeo.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_fr.mnuOutilsOrganismesDestinatairesClick(
  Sender: TObject);
begin
  inherited;

  TfrmTeletransmission.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_fr.mnuOutilsOrganismesSantePHARMAClick(
  Sender: TObject);
begin
  inherited;

  TfrmSantePHARMA.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_fr.mnuRepriseInitialisationClick(
  Sender: TObject);
var
  i : Integer;
begin
  inherited;

  if MessageDlg('L''initialisation de la base locale supprimera toutes les données ! Voulez-vous continuer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with Projet  do
      try
        DeConnecterPHA;
        Projet.CreerPHA(ModuleImport.NomModule, ModuleTransfert.NomModule, Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['pays']);

        with FichierProjet.DocumentElement.ChildNodes['informations_generales'] do
        begin
          Attributes['module_en_cours'] := Ord(tmImport);
          Attributes['page_en_cours'] := 0;
          Attributes['date_conversions'] := '';
        end;

        for i := 0 to (ModuleImport.IHM as TfrModule).Traitements.Count - 1 do
          (ModuleImport.IHM as TfrModule).Traitements[i].InitialisationResultat
      except
        MessageDlg('Erreur durant la ré-initialisation de la base locale ! Vous devriez fermer le projet, il est devenu instable !', mtError, [mbOk], 0);
      end;
end;

procedure TdmOutilsPHA_fr.mnuProduitsInventaireClick(Sender: TObject);
begin
  inherited;

  TfrmInventaire.Create(Self, Projet).ShowModal;
end;

initialization
  RegisterClasses([TdmOutilsPHA_fr, TdmOutilsPHAPHA_fr]);

finalization
  UnRegisterClasses([TdmOutilsPHA_fr, TdmOutilsPHAPHA_fr]);

end.
