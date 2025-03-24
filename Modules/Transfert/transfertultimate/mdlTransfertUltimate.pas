unit mdlTransfertUltimate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, IniFiles, StdCtrls, Buttons, DB, ExtCtrls, Grids, uib, uibase,
  ComCtrls, mdlProjet, mdlModule, ActnList, JvXPBar, ImgList,
  PdfDoc, PReport, Menus, JvMenus, mdlPIPanel, JvXPCore, JvXPContainer, mdlLectureFichierBinaire,
  JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, JvExControls, uibLib, SynHighlighterSQL,
  mdlModuleImport, mdlModuleTransfert, Ora, mdlTypes, XMLIntf, mdlModuleTransfertPHA, Generics.Collections,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, OraError;

type
  TdmTransfertUltimatePHA = class(TdmModuleTransfertPHA)
    procedure frTransfertLGPIPHA_AvantSelectionDonnees(
      Sender: TObject; ATraitement : TTraitement);
  public
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

  TfrTransfertUltimate = class(TfrModuleTransfert)
    wipCartesFidelites: TJvWizardInteriorPage;
    grdCartesFidelites: TPIStringGrid;
    procedure wzDonneesActivePageChanged(Sender: TObject);
  private
    { Déclarations privées }
  protected
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterCartesFidelites;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
  end;

const
  C_INDEX_PAGE_CARTES_FIDELITES = 7;

var
  frTransfertUltimate : TfrTransfertUltimate;

implementation

{$R *.dfm}
{$R logo.res}

constructor TdmTransfertUltimatePHA.Create(AOwner: TComponent; AModule : TModule);
begin
  inherited;

  SurAvantSelectionDonnees := frTransfertLGPIPHA_AvantSelectionDonnees;
end;

procedure TdmTransfertUltimatePHA.frTransfertLGPIPHA_AvantSelectionDonnees(
  Sender: TObject; ATraitement : TTraitement);
begin
  with dbLGPI.SQL do
  begin
      SQL.Clear;
      SQL.Add('begin');
      SQL.Add('  pk_commun.initialiser_transfert;');
      SQL.Add('end;');

      try
        Execute;
      except
        on E:EOraError do
        begin
          FBaseAlteree := True;
          MessageDlg('Impossible de continuer le transfert, base altérée !'#13#10#13#10'Message : ' + E.Message,
                     mtError, [mbOk], 0);
        end;

        on E:Exception do
          raise;
      end;
    end;
end;

{ TfrTransfertUltimate }

constructor TfrTransfertUltimate.Create(AOwner: TComponent; AModule: TModule);
begin
  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;

  grdPraticiens.Tag := Ord(suppPraticiens);
  grdOrganismes.Tag := Ord(suppOrganismes);
  grdClients.Tag := Ord(suppClients);
  grdProduits.Tag := Ord(suppProduits);
  grdAutresDonnees.Tag := Ord(suppHistoriques);
  grdEnCours.Tag := Ord(suppEnCours);
  grdCartesFidelites.Tag := Ord(suppCarteFidelite);
  ModesGeres := [Mtnormal, mtmaj, mtFusion];
  wipCartesFidelites.PageIndex := wipRecapitulatif.PageIndex;
end;

procedure TfrTransfertUltimate.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['PRATICIENS']);
end;

procedure TfrTransfertUltimate.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['PROFILREMISE']);
  TraiterDonnee(Traitements.Traitements['PATIENTS']);
  TraiterDonnee(Traitements.Traitements['MAJ_CPAS']);
  TraiterDonnee(Traitements.Traitements['PATHOLOGIE']);
  TraiterDonnee(Traitements.Traitements['ALLERGIE']);
end;

procedure TfrTransfertUltimate.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['DEPOT']);
  TraiterDonnee(Traitements.Traitements['ZONES GEOGRAPHIQUES']);
  TraiterDonnee(Traitements.Traitements['PRODUITS']);
  TraiterDonnee(Traitements.Traitements['STOCKS']);
  TraiterDonnee(Traitements.Traitements['REPARTITEURS']);
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['PRODUITSFOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['CODESBARRES']);
  TraiterDonnee(Traitements.Traitements['FICHEANALYSE']);
  TraiterDonnee(Traitements.Traitements['FORMULAIRE']);
  TraiterDonnee(Traitements.Traitements['FORMULE']);
  TraiterDonnee(Traitements.Traitements['FORMULE_LIGNE']);

end;

procedure TfrTransfertUltimate.TraiterCartesFidelites;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['COMPTERIST']);
  TraiterDonnee(Traitements.Traitements['CARTERIST']);
  TraiterDonnee(Traitements.Traitements['TRANSACTIONRIST']);
end;

procedure TfrTransfertUltimate.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['PARAMETRES']);
  TraiterDonnee(Traitements.Traitements['HISTODELENTETE']);
  TraiterDonnee(Traitements.Traitements['HISTODELLIGNE']);
  TraiterDonnee(Traitements.Traitements['HISTODELMAGISTRALE']);
  TraiterDonnee(Traitements.Traitements['HISTOVENTE']);
  TraiterDonnee(Traitements.Traitements['HISTOACHAT']);
  TraiterDonnee(Traitements.Traitements['MEDICATION_PRODUIT']);
  TraiterDonnee(Traitements.Traitements['MEDICATION_PRISE']);
  TraiterDonnee(Traitements.Traitements['SOLDE_TUH_PATIENT']);
  TraiterDonnee(Traitements.Traitements['SOLDE_TUH_BOITE']);

  end;

procedure TfrTransfertUltimate.wzDonneesActivePageChanged(Sender: TObject);

  // pages non traites en automatique Carte Fidelite, location ...
  procedure TraiterDonnee;
  begin
     case wzDonnees.ActivePageIndex of
       C_INDEX_PAGE_CARTES_FIDELITES : TraiterCartesFidelites;
     end;
  end;

begin
  inherited;

  if Assigned(Module) then
    if Module.Projet.Ouvert and (wzDonnees.ActivePageIndex >= C_INDEX_PAGE_CARTES_FIDELITES) and (wzDonnees.ActivePageIndex < wzDonnees.PageCount - 1) then
      if rmnDonnees.Enabled then
      begin
        if MessageDlg('Transférer les ' + LowerCase(wzDonnees.ActivePage.Caption) + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
           TraiterDonnee;
      end
      else
        TraiterDonnee;
end;

procedure TfrTransfertUltimate.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['AVANCEPRODUIT']);
  TraiterDonnee(Traitements.Traitements['DELDIF']);
  TraiterDonnee(Traitements.Traitements['CREDITCLIENT']);
  TraiterDonnee(Traitements.Traitements['ATTESTATION']);
end;

procedure TfrTransfertUltimate.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ORGANISME CPAS OA']);
  TraiterDonnee(Traitements.Traitements['ORGANISME CPAS OC']);
end;

initialization
  RegisterClasses([TfrTransfertUltimate, TdmTransfertUltimatePHA]);

finalization
  UnRegisterClasses([TfrTransfertUltimate, TdmTransfertUltimatePHA]);

end.

