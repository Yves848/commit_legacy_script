unit mdlVindilis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls,strutils, DB, UIBLib,
  Grids, DBGrids, Menus, mdlModule, mdlPIPanel, mdlPHA, JclFileUtils, mdlPIDataset,
  ToolWin, mdlProjet, PdfDoc, PReport, JvMenus, JvWizard, mdlMIPI, mdlMIODBCPHA, mdlPIODBC,
  JvWizardRouteMapNodes, mdlPIStringGrid, mdlPIDBGrid, JvExControls, ComObj,
  ActnList, ImgList, JvXPCore, JvXPContainer, mdlModuleImport, JvXPBar, uib,
  XMLIntf, XMLDoc, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, JclStreams,
  Generics.Collections, JclShell, mdlMIPostgreSQLPHA, mdlMIPostgreSQL;

type
  TdmVindilisPHA = class(TdmMIPostgreSQLPHA);
  TfrVindilis = class(TfrMIPostgreSQL)
  protected
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterDocumentSF(ATraitement: TTraitement; ARepertoire, AFiltre: string; AConversionTIFF, ARecursif: boolean);
      override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

var
  frVindilis : TfrVindilis;

implementation

{$R *.dfm}
{$R logo.res}

procedure TfrVindilis.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Praticiens']);

end;

procedure TfrVindilis.TraiterDonneesOrganismes;
begin
  inherited;
  
  TraiterDonnee(Traitements.Traitements['Destinataires télétrans']);
  TraiterDonnee(Traitements.Traitements['Organismes AMO']);
  TraiterDonnee(Traitements.Traitements['Organismes AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
end;

procedure TfrVindilis.TraiterDocumentSF(ATraitement: TTraitement; ARepertoire, AFiltre: string; AConversionTIFF,
  ARecursif: boolean);
begin
  inherited;

end;

procedure TfrVindilis.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Comptes']);
  TraiterDonnee(Traitements.Traitements['Clients']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO Clients']);
end;

procedure TfrVindilis.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Fournisseurs']);
  TraiterDonnee(Traitements.Traitements['Grossistes']);
  TraiterDonnee(Traitements.Traitements['Codes géo']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Code EAN13']);
  TraiterDonnee(Traitements.Traitements['Stocks']);
  TraiterDonnee(Traitements.Traitements['Historiques ventes']);
end;

procedure TfrVindilis.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Historiques clients']);
  TraiterDonnee(Traitements.Traitements['Historiques lignes']);
  TraiterDonnee(Traitements.Traitements['Historiques achats']);
  TraiterDonnee(Traitements.Traitements['Historiques achats lignes']);
  TraiterDonnee(Traitements.Traitements['Programme Relationnel']);
  
  //TraiterDocumentSF(Traitements.Traitements['SCANS'], Module.Projet.RepertoireProjet, '.jpg', True, True);
end;

procedure TfrVindilis.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Opérateurs']);	
  TraiterDonnee(Traitements.Traitements['Commandes en attente']);
  TraiterDonnee(Traitements.Traitements['Lignes commandes en attente']);

  TraiterDonnee(Traitements.Traitements['Avances vignettes']);
  TraiterDonnee(Traitements.Traitements['Crédits']);
  TraiterDonnee(Traitements.Traitements['Crédits comptes']);
  TraiterDonnee(Traitements.Traitements['Produits dus']);
end;

constructor TfrVindilis.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;

  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;
end;

initialization
  RegisterClasses([TfrVindilis, TdmVindilisPHA]);

finalization
  unRegisterClasses([TfrVindilis, TdmVindilisPHA]);

end.
