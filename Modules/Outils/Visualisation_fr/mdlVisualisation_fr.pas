unit mdlVisualisation_fr;

interface

uses
  SysUtils, Classes, mdlProjet, ImgList, Controls, Menus, Dialogs,
  mdlPIImpression, DB, uibdataset, uib, mdlModuleOutils, Forms,
  JvMenus, mdlModule, mdlModuleImport;

type
  TdmVisualisation_fr = class(TdmModuleOutils)
    mnuOutils: TMenuItem;
    mnuOutilsVisuFichiersOrig: TMenuItem;
    mnuOutilsVisualisation: TMenuItem;
    mnuReprise: TMenuItem;
    mnuSeparateur: TMenuItem;
    procedure mnuOutilsVisuFichiersOrigClick(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure mnuOutilsVisualisationClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  dmVisualisation_fr: TdmVisualisation_fr;

implementation

uses mdlFenetreVisualisation_fr, mdlClients_fr, mdlVisualisationPHA_fr,
  mdlOrganismes_fr, mdlPraticiens_fr,
  mdlFichiersOrig_fr;

{$R *.dfm}

{ TdmVisualisation_fr }

procedure TdmVisualisation_fr.mnuOutilsVisuFichiersOrigClick(Sender: TObject);
begin
  inherited;

  TfrmFichiersOrig.Create(Self, Projet).ShowModal;
end;

procedure TdmVisualisation_fr.DataModuleCreate(Sender: TObject);
begin
  inherited;

  if not Assigned(TfrModuleImport(Projet.ModuleImport.IHM).LectureFichierBinaire) then
    mnuOutilsVisuFichiersOrig.Visible := False;

  dmVisualisationPHA_fr := TdmVisualisationPHA_fr.Create(Self, Projet);
end;

procedure TdmVisualisation_fr.mnuOutilsVisualisationClick(Sender: TObject);
begin
  inherited;

  frmFenetreVisualisation(Projet).ShowModal;
end;

initialization
  RegisterClasses([TdmVisualisation_fr, TfrClients, TfrOrganismes, TfrPraticiens]);

finalization
  UnRegisterClasses([TdmVisualisation_fr, TfrClients, TfrOrganismes, TfrPraticiens]);

end.
