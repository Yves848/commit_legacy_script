unit mdlVisualisation_be;

interface

uses
  SysUtils, Classes, mdlProjet, ImgList, Controls, Menus, Dialogs,
  mdlPIImpression, DB, uibdataset, uib, mdlModuleOutils, Forms,
  JvMenus, mdlModule, mdlModuleImport;

type
  TdmVisualisation_be = class(TdmModuleOutils)
    mnuOutils: TMenuItem;
    mnuOutilsVisuFichiersOrig: TMenuItem;
    mnuOutilsVisualisation: TMenuItem;
    mnuReprise: TMenuItem;
    mnuSeparateur: TMenuItem;
    procedure DataModuleCreate(Sender: TObject);
    procedure mnuOutilsVisualisationClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  dmVisualisation_be: TdmVisualisation_be;

implementation

uses mdlFenetreVisualisation_be, mdlVisualisationPHA_be
  //,mdlOrganismes, mdlPraticiens,mdlClients
  ;

{$R *.dfm}

{ TdmVisualisation_be }


procedure TdmVisualisation_be.DataModuleCreate(Sender: TObject);
begin
  inherited;

  if not Assigned(TfrModuleImport(Projet.ModuleImport.IHM).LectureFichierBinaire) then
    mnuOutilsVisuFichiersOrig.Visible := False;

  dmVisualisationPHA_be := TdmVisualisationPHA_be.Create(Self, Projet);
end;

procedure TdmVisualisation_be.mnuOutilsVisualisationClick(Sender: TObject);
begin
  inherited;

  frmFenetreVisualisation(Projet).ShowModal;
end;

initialization
  RegisterClasses([TdmVisualisation_be]);

finalization
  UnRegisterClasses([TdmVisualisation_be]);

end.
