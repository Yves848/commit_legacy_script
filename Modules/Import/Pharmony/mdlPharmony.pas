unit mdlPharmony;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlModule, mdlModuleImport, DB, PdfDoc, PReport, ExtCtrls, Menus,
  JvMenus, JvWizard, JvWizardRouteMapNodes, mdlPIPanel, ComCtrls, Grids,
  mdlProjet, mdlPIStringGrid, DBGrids, mdlPIDBGrid, JvExControls,
  mdlLectureFichierBinaire, uib, JvXPCore, JvXPContainer, ImgList, ActnList,
  JclStrings, StrUtils, JvXPBar, StdCtrls, mdlPIButton, mdlConversionsTIFF,
  mdlInformationFichier, mdlLectureFichierCSV, VirtualTrees, JvExExtCtrls,
  JvNetscapeSplitter, mdlTypes, IOUtils, mdlMIPostgreSQL;

type
  TfrPharmony = class(TfrModuleImport)
  private
    { Déclarations privées }
    procedure TraiterDonnee(ATraitement: TTraitement); override;
  protected
    function FaireTraitementDonnees(ADonnees: TDonneesFormatees): TResultatCreationDonnees; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
  end;

implementation

uses
  mdlPharmonyPHA;

{$R *.dfm}

constructor TfrPharmony.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;

  Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].ChildNodes['saut_ligne'].NodeValue := 1;

  LectureFichierBinaire := TFichierCSV
end;

procedure TfrPharmony.TraiterAutresDonnees;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['history_products.csv']);
  TraiterDonnee(Traitements.Traitements['pending_documents.csv']);
  TraiterDonnee(Traitements.Traitements['history_patients.csv']);
  TraiterDonnee(Traitements.Traitements['preparations.csv']);
end;

procedure TfrPharmony.TraiterDonnee(ATraitement: TTraitement);
begin
    inherited;
end;

procedure TfrPharmony.TraiterDonneesClients;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['collectivities.csv']);
  TraiterDonnee(Traitements.Traitements['patients.csv']);
  TraiterDonnee(Traitements.Traitements['invoice_relationships.csv']);
  TraiterDonnee(Traitements.Traitements['fidelity_profiles.csv']);
  TraiterDonnee(Traitements.Traitements['fidelity_accounts.csv']);
  TraiterDonnee(Traitements.Traitements['fidelity_cards.csv']);
end;

procedure TfrPharmony.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['prescribers.csv']);
end;

procedure TfrPharmony.TraiterDonneesOrganismes;
begin
  inherited;

  //TraiterDonnee(Traitements.Traitements['A_FZDES.D']);
end;

procedure TfrPharmony.TraiterDonneesProduits;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['storage_spaces.csv']);
  TraiterDonnee(Traitements.Traitements['storage_locations.csv']);
  TraiterDonnee(Traitements.Traitements['products.csv']);
  TraiterDonnee(Traitements.Traitements['product_stocks.csv']);
  TraiterDonnee(Traitements.Traitements['schema.csv']);
  TraiterDonnee(Traitements.Traitements['schemadetail.csv']);
  TraiterDonnee(Traitements.Traitements['suppliers.csv']);
  TraiterDonnee(Traitements.Traitements['product_codes.csv']);
  TraiterDonnee(Traitements.Traitements['Analyses.csv']);

end;



function TfrPharmony.FaireTraitementDonnees(ADonnees: TDonneesFormatees): TResultatCreationDonnees;
var
  f: string;
begin
  f := ExtractFileName(ADonnees.Fichier.Fichier);
  if f = 'prescribers.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_medecins', TDonneesCSV(ADonnees), 19);

  if f = 'collectivities.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_collectivites', TDonneesCSV(ADonnees), 20);
  if f = 'patients.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_patients', TDonneesCSV(ADonnees), 45);
  if f = 'invoice_relationships.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_liens', TDonneesCSV(ADonnees), 8);
  if f = 'fidelity_profiles.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_profilremise', TDonneesCSV(ADonnees), 2);
  if f = 'fidelity_accounts.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_compterist', TDonneesCSV(ADonnees), 4);
  if f = 'fidelity_cards.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_carterist', TDonneesCSV(ADonnees), 4);

  if f = 'storage_spaces.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_depots', TDonneesCSV(ADonnees), 4);
  if f = 'storage_locations.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_zonegeo', TDonneesCSV(ADonnees), 3);
  if f = 'products.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_produits', TDonneesCSV(ADonnees), 15);
  if f = 'product_stocks.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_stocks', TDonneesCSV(ADonnees), 8);
  if f = 'suppliers.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_suppliers', TDonneesCSV(ADonnees), 23);
  if f = 'product_codes.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_codesbarres', TDonneesCSV(ADonnees), 2);
  if f = 'schema.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_schema_produit', TDonneesCSV(ADonnees), -1);
  if f = 'schemadetail.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'PS_CREER_SCHEMA_PRISE', TDonneesCSV(ADonnees), -1);

  if f = 'history_products.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_histovente', TDonneesCSV(ADonnees), 5);
  if f = 'pending_documents.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_litiges', TDonneesCSV(ADonnees), 16);
  if f = 'history_patients.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_historique_patient', TDonneesCSV(ADonnees), 11);
  if f = 'preparations.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_magistrale', TDonneesCSV(ADonnees), 8);
  if f = 'Analyses.csv' then
    Result := dmPharmonyPHA.CreerDonnees(f, 'ps_creer_ficheanalyse', TDonneesCSV(ADonnees), 17);

end;

procedure TfrPharmony.TraiterDonneesEnCours;
begin
  inherited;

//  TraiterDonnee(Traitements.Traitements['A_F23.D']);
end;

initialization
  RegisterClasses([TfrPharmony, TdmPharmonyPHA]);


finalization
  UnRegisterClasses([TfrPharmony, TdmPharmonyPHA]);

end.

