unit mdlFarmadTWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, DB,
  Grids, DBGrids, Menus, mdlModule, mdlModuleImport, uiblib, uibase, uib,
  mdlPIPanel, mdlProjet, ActnList, ImgList, PdfDoc, PReport, JvMenus,
  JvXPCore, JvXPContainer, JvWizard, JvWizardRouteMapNodes, JclFileUtils,
  mdlPIStringGrid, mdlPIDBGrid, JvExControls, JvXPBar, mdlMIFirebird,
  mdlMIFirebirdPHA, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, mdlModuleimportPHA;

type
  TdmFarmadTWinPHA = class(TdmMIFirebirdPHA)
    procedure DataModuleCreate(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender : TObject);
    procedure ZConnection1AfterDisconnect(Sender : TObject);
  private
    AlterOk : Boolean;
  end;

  TfrFarmadTWin = class(TfrMIFirebird)
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
  end;

var
  frFarmadTWin : TfrFarmadTWin;

implementation

{$R *.dfm}

{ TdmFarmadTWinPHA }

procedure TdmFarmadTWinPHA.ZConnection1AfterConnect(Sender : TObject);
begin

  ZConnection1.Connect;
  if (not AlterOk ) then
    begin
      //ZConnection1.ExecuteDirect('ALTER EXTERNAL FUNCTION rtrim ENTRY_POINT ''IB_UDF_rtrim'' MODULE_NAME ''ib_udf''');
      //ZConnection1.ExecuteDirect('ALTER EXTERNAL FUNCTION f_truncate ENTRY_POINT ''fbtruncate'' MODULE_NAME ''fbudf''');
      //ZConnection1.ExecuteDirect('ALTER EXTERNAL FUNCTION boolstring2int ENTRY_POINT ''IB_UDF_rtrim'' MODULE_NAME ''ib_udf''');
      //ZConnection1.Commit;
      // !!!!!!!!!  A remettre pour les ANCIENNES DB Farmad (d'avant janvier 2023) !!!!!!!!!!!
      AlterOk:=true;
      ZConnection1.Disconnect;
      ZConnection1.Connect;
    end;

//  FileCopy(Module.Projet.RepertoireApplication + '\fb206\UDF\GDS32.DLL', Module.Projet.RepertoireApplication + '\GDS32.DLL', True);
end;

procedure TdmFarmadTWinPHA.ZConnection1AfterDisconnect(Sender: TObject);
begin
//  FileDelete(Module.Projet.RepertoireApplication + '\GDS32.DLL');
end;

procedure TdmFarmadTWinPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ZConnection1.LibraryLocation := Module.Projet.RepertoireApplication + '\fb\fbclient.dll';
  //ZConnection1.LibraryLocation := Module.Projet.RepertoireApplication + '\fbembed.dll';
  ZConnection1.Protocol := 'firebirdd-2.5';
  ZConnection1.AfterConnect := ZConnection1AfterConnect;
  ZConnection1.AfterDisconnect := ZConnection1AfterDisconnect;
end;

{ TfrCaduciel V6}

procedure TfrFarmadTWin.RenvoyerParametresConnexion;
begin
  inherited;
  // aller recuperer le nom de fichier dans la liste des trtr plutot que en dur
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
    if HasAttribute('bd') then
      PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd']
    else
      PHA.ParametresConnexion.Values['bd'] := Module.Projet.RepertoireProjet +   mdlModuleImportPHA.dmModuleImportPHA.setFichiersManquants.FieldByName('AFICHIER').Value;
end;

procedure TfrFarmadTWin.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['HISTORIQUES_DELIVRANCES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES_DELIVRANCES_LIGNES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES_DELIVRANCES_MAG']);
  TraiterDonnee(Traitements.Traitements['ANALYSES_CHIMIQUES']);
  TraiterDonnee(Traitements.Traitements['ATTESTATIONS_PRODUITS']);
end;

procedure TfrFarmadTWin.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['PROFILS_REMISES']);
  TraiterDonnee(Traitements.Traitements['COLLECTIVITES']);
  TraiterDonnee(Traitements.Traitements['PATIENTS']);
  TraiterDonnee(Traitements.Traitements['PHARMACIEN_REFERENCE']);
  TraiterDonnee(Traitements.Traitements['COMPTES_RISTOURNES']);
  TraiterDonnee(Traitements.Traitements['CARTES_RISTOURNES']);
  TraiterDonnee(Traitements.Traitements['TRANSACTIONS_RISTOURNES']);
end;

procedure TfrFarmadTWin.TraiterDonneesEnCours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['CREDITS']);
  TraiterDonnee(Traitements.Traitements['LITIGES']);
  TraiterDonnee(Traitements.Traitements['DELIVRANCES_DIFFEREES']);
 // TraiterDonnee(Traitements.Traitements['AUTRES_LITIGES']);
end;

procedure TfrFarmadTWin.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['LANGUE']);
  TraiterDonnee(Traitements.Traitements['MEDECINS']);
end;

procedure TfrFarmadTWin.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['TEL FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['ZONES_GEOGRAPHIQUES']);
  TraiterDonnee(Traitements.Traitements['PRODUITS']);
  TraiterDonnee(Traitements.Traitements['CODES_BARRES']);
  TraiterDonnee(Traitements.Traitements['TARIFS_PRODUITS']);
  TraiterDonnee(Traitements.Traitements['MAJ_FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES_VENTES']);
  TraiterDonnee(Traitements.Traitements['SCHEMA_PRODUIT']);
  TraiterDonnee(Traitements.Traitements['SCHEMA_PRISE']);
end;

initialization
  RegisterClasses([TfrFarmadTWin, TdmFarmadTWinPHA]);

finalization
  unRegisterClasses([TfrFarmadTWin, TdmFarmadTWinPHA]);

end.