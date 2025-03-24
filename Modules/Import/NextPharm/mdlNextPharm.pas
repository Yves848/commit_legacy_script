unit mdlNextPharm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, strutils,
  Grids, DBGrids, Menus, mdlPIPanel, ToolWin, ActnList, ImgList, PdfDoc,
  PReport, JvMenus, JvXPCore, JvXPContainer, JvWizard, JvWizardRouteMapNodes,
  mdlPIStringGrid, mdlPIDBGrid, mdlProjet, mdlModule, mdlModuleImport,
  mdlMIHyperFile, mdlMIHyperFilePHA,
  JvExControls, JclFileUtils, DB, JvXPBar, uib, mdlInformationFichier,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter;

type
  TdmNextPharmPHA = class(TdmMIHyperfilePHA);
  TfrNextPharm = class(TfrMIHyperFile)
  private
  protected
    procedure TraiterDonnee(ATraitement : TTraitement); override;
  public
    { Déclarations publiques }
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

var
  frNextPharm: TfrNextPharm;

implementation

//uses mdlNextPharmaConnexionServeur;

{$R *.dfm}
{$r logo.res}

{ TfrNextPharm }

procedure TfrNextPharm.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['MEDECINS']);
end;

procedure TfrNextPharm.TraiterDonnee(ATraitement: TTraitement);
begin
  dmMIHyperFilePHA.qryPI.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);

  inherited TraiterDonnee(ATraitement);
end;

procedure TfrNextPharm.TraiterDonneesClients;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['PROFILREMISE']);
  TraiterDonnee(Traitements.Traitements['PATIENTS']);
  TraiterDonnee(Traitements.Traitements['CLIENTS']);
  TraiterDonnee(Traitements.Traitements['ATTESTATION']);
  TraiterDonnee(Traitements.Traitements['PHARMACIEN_REFERENCE']);
end;

procedure TfrNextPharm.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ZONEGEO']);
  TraiterDonnee(Traitements.Traitements['PRODUITS']);
  TraiterDonnee(Traitements.Traitements['PRODUITFOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['FOUREP']);
  TraiterDonnee(Traitements.Traitements['CODESBARRES']);
  TraiterDonnee(Traitements.Traitements['PRODUITPEREMPTION']);
  TraiterDonnee(Traitements.Traitements['SCHEMA_PRODUIT']);
  TraiterDonnee(Traitements.Traitements['SCHEMA_PRISE']);

  (*
    SCHEMA_PRISE :
    PriseAuLever   = nb au Lever
    SPPDnbAv       = Petit déjeuner - Avant
    SPPDnbPendant  = Petit Déjeuner - Pendant
    SPPDnbApres    = Petit Déjeuner - Après
    Prise10h00     = 10h00
    SPDNnbAv       = Dîner - Avant
    SPDNnbPendant  = Dîner - Pendant
    SPDNnbApres    = Dîner - Après
    Prise16h00     = 16h00
    SPSPnbAv       = Souper - Avant
    SPSPnbPendant  = Souper - Pendant
    SPSPnbApres    = Souper - Après
    Prise20H       = nb à 20H
    PriseAuCoucher = nb au coucher
    Typechema :
      1 = Quotidien
      2 = Hebdomadaire / Mensuelle
  *)


end;

constructor TfrNextPharm.Create(AOwner: TComponent; AModule: TModule);
begin
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');
  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');

  inherited;
end;

procedure TfrNextPharm.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['COMPTERIST']);
  TraiterDonnee(Traitements.Traitements['CARTERIST']);
  TraiterDonnee(Traitements.Traitements['HISTODELGENERAL']);
  TraiterDonnee(Traitements.Traitements['HISTODELDETAILS']);
  TraiterDonnee(Traitements.Traitements['HISTODELMAGIS']);
  TraiterDonnee(Traitements.Traitements['HISTOVENTE']);

end;

procedure TfrNextPharm.TraiterDonneesEncours;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['AVANCEPRODUIT']);
  TraiterDonnee(Traitements.Traitements['DELDIF']);
  TraiterDonnee(Traitements.Traitements['CREDITCLIENT']);
  TraiterDonnee(Traitements.Traitements['MEMOPATIENT']);
end;

initialization

RegisterClasses([TfrNextPharm, TdmNextPharmPHA]);

finalization

unRegisterClasses([TfrNextPharm, TdmNextPharmPHA]);

end.
