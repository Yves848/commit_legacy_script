unit mdlOutilsPHA_be;

interface

uses
  Windows, SysUtils, Classes, mdlModuleOutils, Menus, JvMenus, Dialogs, Controls,
  mdlModule;

type
  TdmOutilsPHA_be = class(TdmModuleOutils)
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
  dmOutilsPHA_be: TdmOutilsPHA_be;

implementation

uses mdlPurges, mdlOutilsPHAPHA_be,
  mdlRepartiteurDefaut, mdlIncoherence,
  mdlAuditHomeo, mdlTeletransmission, mdlSantePHARMA, mdlChoixDate,
  mdlChoixID, mdlProjet, mdlInventaire;

{$R *.dfm}

procedure TdmOutilsPHA_be.mnuOutilsPurgesClick(Sender: TObject);
begin
  inherited;

  TfrmPurges.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_be.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmOutilsPHA_be := Self;
  dmOutilsPHAPHA_be := TdmOutilsPHAPHA_be.Create(Self, Projet);
end;

procedure TdmOutilsPHA_be.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(frmChoixDate) then FreeAndNil(frmChoixDate);
  if Assigned(frmChoixID) then FreeAndNil(frmChoixID);
  if Assigned(dmOutilsPHAPHA_be) then FreeAndNil(dmOutilsPHAPHA_be);
  
  inherited;
end;

procedure TdmOutilsPHA_be.mnuOutilsProduitsReDefautClick(Sender: TObject);
begin
  inherited;

  TfrmRepartiteurDefaut.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_be.mnuOutilsIncoherencesClick(Sender: TObject);
begin
  inherited;

  TfrmIncoherence.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_be.mnuOutilsProduitsAuditHomeoClick(Sender: TObject);
begin
  inherited;

  TfrmAuditHomeo.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_be.mnuOutilsOrganismesDestinatairesClick(
  Sender: TObject);
begin
  inherited;

  TfrmTeletransmission.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_be.mnuOutilsOrganismesSantePHARMAClick(
  Sender: TObject);
begin
  inherited;

  TfrmSantePHARMA.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsPHA_be.mnuRepriseInitialisationClick(
  Sender: TObject);
var
  i : Integer;
begin
  inherited;

  if MessageDlg('L''initialisation de la base locale supprimera toutes les données ! Voulez-vous continuer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with Projet  do
      try
        DeConnecterPHA;
        Projet.CreerPHA(ModuleImport.NomModule, ModuleTransfert.NomModule, Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['Pays']);

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

procedure TdmOutilsPHA_be.mnuProduitsInventaireClick(Sender: TObject);
begin
  inherited;

  TfrmInventaire.Create(Self, Projet).ShowModal;
end;

initialization
  RegisterClasses([TdmOutilsPHA_be, TdmOutilsPHAPHA_be]);

finalization
  UnRegisterClasses([TdmOutilsPHA_be, TdmOutilsPHAPHA_be]);

end.
