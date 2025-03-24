unit mdlOutilsERP_fr;

interface

uses
  SysUtils, Classes, Menus, Dialogs, ActnList, ImgList, Controls, Variants,
  mdlProjet, Ora, mdlModuleOutils, mdlModule, JvMenus;

type
  TdmOutilsERP_fr = class(TdmModuleOutils)
    Statistiques1: TMenuItem;
    N2: TMenuItem;
    Positionnementdesndelots1: TMenuItem;
    Sequenceordonanciersfactures1: TMenuItem;
    procedure DataModuleCreate(Sender : TObject);
    procedure mnuPosNoLotClick(Sender: TObject);
    procedure mnuERPToolsSeqOrdoClick(Sender: TObject);
    procedure mnuERPToolsStatClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  dmOutilsERP_fr: TdmOutilsERP_fr;

implementation

uses mdlStatistiques, mdlOutilsERPERP_fr, mdlNoLot,
  mdlSequenceOrdonnancier_fr;

{$R *.dfm}

procedure TdmOutilsERP_fr.DataModuleCreate(Sender : TObject);
begin
  inherited;
  
  dmOutilsERP_fr := Self;
  dmOutilsERPERP_fr := TdmOutilsERPERP_fr.Create(Self, Projet);
end;

procedure TdmOutilsERP_fr.mnuPosNoLotClick(Sender: TObject);
begin
  if not (Projet.ERPConnexion as TOraSession).Connected then
    (Projet.ModuleTransfert.IHM as TfrModule).Connecter;
  TfrmNoLot.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsERP_fr.mnuERPToolsSeqOrdoClick(Sender: TObject);
begin
  if not (Projet.ERPConnexion as TOraSession).Connected then
    (Projet.ModuleTransfert.IHM as TfrModule).Connecter;
  TfrmSequenceOrdonnancier.Create(Self, Projet).ShowModal;
end;

procedure TdmOutilsERP_fr.mnuERPToolsStatClick(Sender: TObject);
begin
  if not (Projet.ERPConnexion as TOraSession).Connected then
    (Projet.ModuleTransfert.IHM as TfrModule).Connecter;
  TfrmStatistiques.Create(Self, Projet).ShowModal;
end;

initialization
  RegisterClasses([TdmOutilsERP_fr, TdmOutilsERPERP_fr]);

finalization
  UnRegisterClasses([TdmOutilsERP_fr, TdmOutilsERPERP_fr]);

end.
