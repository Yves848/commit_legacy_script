unit mdlOutilsERP_be;

interface

uses
  SysUtils, Classes, Menus, Dialogs, ActnList, ImgList, Controls, Variants,
  mdlProjet, Ora, mdlModuleOutils, mdlModule, JvMenus;

type
  TdmOutilsERP_be = class(TdmModuleOutils)
    N2: TMenuItem;
    Sequenceordonanciersfactures1: TMenuItem;
    Gestiondescartesristournes1: TMenuItem;
    EnrNumBlocTUH: TMenuItem;
    procedure DataModuleCreate(Sender : TObject);
    procedure mnuERPToolsSeqOrdoClick(Sender: TObject);
    procedure mnuERPToolsGestionCartesRistournes(Sender: TObject);
    procedure EnrNumBlocTUHClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  dmOutilsERP_be: TdmOutilsERP_be;

implementation

uses mdlOutilsERPERP_be,  mdlSequenceOrdonnancier_be, mdlGestionCarteRistourne, mdlSequenceTUH_be;

{$R *.dfm}

procedure TdmOutilsERP_be.DataModuleCreate(Sender : TObject);
begin
  inherited;
  
  dmOutilsERP_be := Self;
  dmOutilsERPERP_be := TdmOutilsERPERP_be.Create(Self, Projet);
end;

procedure TdmOutilsERP_be.mnuERPToolsSeqOrdoClick(Sender: TObject);
begin
  if not (Projet.ERPConnexion as TOraSession).Connected then
    (Projet.ModuleTransfert.IHM as TfrModule).Connecter;
  TfrmSequenceOrdonnancier.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsERP_be.EnrNumBlocTUHClick(Sender: TObject);
begin
   if not (Projet.ERPConnexion as TOraSession).Connected then
    (Projet.ModuleTransfert.IHM as TfrModule).Connecter;
  TfrmSequenceTUH.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsERP_be.mnuERPToolsGestionCartesRistournes(
  Sender: TObject);
begin
  if not (Projet.ERPConnexion as TOraSession).Connected then
    (Projet.ModuleTransfert.IHM as TfrModule).Connecter;
  TfrmGestionCarteRistourne.Create(Self, Projet).ShowModal;
end;

initialization
  RegisterClasses([TdmOutilsERP_be, TdmOutilsERPERP_be]);

finalization
  UnRegisterClasses([TdmOutilsERP_be, TdmOutilsERPERP_be]);

end.
