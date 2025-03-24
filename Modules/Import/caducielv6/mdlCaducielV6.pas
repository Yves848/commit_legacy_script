unit mdlCaducielV6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, DB,
  Grids, DBGrids, Menus, mdlModule, mdlModuleImport, uiblib, uibase, uib,
  mdlPIPanel, mdlProjet, ActnList, ImgList, PdfDoc, PReport, JvMenus,
  JvXPCore, JvXPContainer, JvWizard, JvWizardRouteMapNodes, JclFileUtils,
  mdlPIStringGrid, mdlPIDBGrid, JvExControls, JvXPBar, mdlMIFirebird,
  mdlMIFirebirdPHA, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter,
  mdlConversionsTIFF, mdlInformationFichier;

type
  TdmCaducielV6PHA = class(TdmMIFirebirdPHA)
    procedure DataModuleCreate(Sender: TObject);
  public
    function CreerDocument(AIDClient, AFichier, ALibelle: string): TResultatCreationDonnees;
  end;

  TfrCaducielV6 = class(TfrMIFirebird)
  protected
    function FaireTraitementDonnees(ADonnees: TFields): TResultatCreationDonnees; override;
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    procedure RenvoyerParametresConnexion; override;
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

var
  frCaducielV6: TfrCaducielV6;

implementation

{$R *.dfm}
{$R logo.res}

procedure TfrCaducielV6.TraiterDonnee(ATraitement: TTraitement);
begin
  if ATraitement.Fichier = 'DOCUMENTS SCANNEES' then
  begin
    frmConversionTIFF.Show;
    frmConversionTIFF.Initialiser(Module.Projet.RepertoireApplication);
  end;

  inherited TraiterDonnee(ATraitement);
end;

function TfrCaducielV6.FaireTraitementDonnees(ADonnees: TFields): TResultatCreationDonnees;
var
  repertoire, Fichier, fichier_scan, fichier_converti: string;

begin
  SetCurrentDir(Module.Projet.RepertoireProjet);
  if TraitementEnCours.Fichier = 'DOCUMENTS SCANNEES' then
  begin
    repertoire := Module.Projet.RepertoireProjet + 'Scan';
    Fichier := uppercase(ADonnees.FieldByName('ADS_CAR_NOMFICHIER').AsString);
    if (pos('.ZLI', Fichier) > 0) then
    begin
      Fichier := '\' + Fichier;
      //Module.Projet.Console.AjouterLigne(' position zli   '+ repertoire + Fichier);
      if Fileexists(repertoire + Fichier) then
      begin
        fichier_scan := repertoire + Fichier;
        fichier_converti := repertoire + ChangeFileExt(Fichier, '.jpg');
      //Module.Projet.Console.AjouterLigne(fichier_scan + '    ' + fichier_converti);
      end;
    end
    else
    begin
      fichier_scan := repertoire + Fichier;
      fichier_converti := repertoire + ChangeFileExt(Fichier, '.tif');
    end;

    if not(Fileexists(fichier_converti)) then
    begin
      if Fileexists(fichier_scan) then // on ajoute que les fichier presents
      begin
        //Module.Projet.Console.AjouterLigne(' conversion de ' + fichier_scan);
        frmConversionTIFF.AjouterDocumentAConvertir(fichier_scan);
        Result := TdmCaducielV6PHA(PHA).CreerDocument(ADonnees.FieldByName('ADS_NUM_ASSURE_FK').AsString, fichier_converti,
          ADonnees.FieldByName('ADS_CAR_COMMENTAIRE').AsString)
      end
      else
      begin
        //frmConversionTIFF.AjouterDocumentAConvertir(fichier_scan);
        Result := rcdErreur;
      end;
    end
    else
    begin
      Module.Projet.Console.AjouterLigne(fichier_converti + ' deja converti');
      Result := TdmCaducielV6PHA(PHA).CreerDocument(ADonnees.FieldByName('ADS_NUM_ASSURE_FK').AsString, fichier_converti,
        ADonnees.FieldByName('ADS_CAR_COMMENTAIRE').AsString)
    end

  end
  else
    with TTraitementBD(TraitementEnCours) do
      Result := TdmCaducielV6PHA(PHA).ExecuterPS(Fichier, ProcedureCreation, ADonnees);
end;

function TdmCaducielV6PHA.CreerDocument(AIDClient, AFichier, ALibelle: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('DOCUMENTS SCANNEES', 'PS_CADUCIELV6_CREER_DOCUMENT', VarArrayOf([AIDClient, AFichier, ALibelle]));
end;

procedure TdmCaducielV6PHA.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ZConnection1.LibraryLocation := Module.Projet.RepertoireApplication + '\fb\fbclient.dll';
  ZConnection1.Protocol := 'firebirdd-2.5';
end;

{ TfrCaduciel V6 }

constructor TfrCaducielV6.Create(AOwner: TComponent; AModule: TModule);
begin
  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;

  ModesGeres := [mtNormal, mtMAJ];
end;

procedure TfrCaducielV6.RenvoyerParametresConnexion;
begin
  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
    if HasAttribute('bd') then
    begin
      PHA.ParametresConnexion.Values['bd'] := Module.Projet.RepertoireProjet+'BDCADV6.FDB';
    end
    else
      PHA.ParametresConnexion.Values['bd'] := 'C:\Program Files\Caduciel\Caduciel v6\db\BDCADV6.FDB';
end;

procedure TfrCaducielV6.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['HOPITAUX']);
  TraiterDonnee(Traitements.Traitements['MEDECINS']);
end;

procedure TfrCaducielV6.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['DESTINATAIRES']);
  TraiterDonnee(Traitements.Traitements['ORGANISMES AMO']);
  TraiterDonnee(Traitements.Traitements['ORGANISMES AMC']);
  TraiterDonnee(Traitements.Traitements['COUVERTURES']);
  TraiterDonnee(Traitements.Traitements['TAUX PRISE EN CHARGE']);
end;

procedure TfrCaducielV6.TraiterDonneesClients;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['COMPTES']);
  TraiterDonnee(Traitements.Traitements['CLIENTS']);
  TraiterDonnee(Traitements.Traitements['PS_CADUCIEL_SP_SANTE']);

end;

procedure TfrCaducielV6.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['OPERATEURS']);
  TraiterDonnee(Traitements.Traitements['CREDITS CLIENTS']);
  TraiterDonnee(Traitements.Traitements['CREDITS COMPTES']);
  TraiterDonnee(Traitements.Traitements['VIGNETTES AVANCEES']);
  TraiterDonnee(Traitements.Traitements['PRODUITS DUS']);
end;

procedure TfrCaducielV6.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['LINEAIRES']);
  TraiterDonnee(Traitements.Traitements['CATEGORIES']);
  TraiterDonnee(Traitements.Traitements['FAMILLES']);
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['PRODUITS']);
  TraiterDonnee(Traitements.Traitements['CODES PRODUITS']);
  TraiterDonnee(Traitements.Traitements['CODES LPPR']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES VENTE']);
end;

procedure TfrCaducielV6.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['DOCUMENTS SCANNEES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES CLIENTS ENTETES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES CLIENTS LIGNES']);
  TraiterDonnee(Traitements.Traitements['COMMANDES ENTETES']);
  TraiterDonnee(Traitements.Traitements['COMMANDES LIGNES']);
end;

initialization

RegisterClasses([TfrCaducielV6, TdmCaducielV6PHA]);

finalization

unRegisterClasses([TfrCaducielV6, TdmCaducielV6PHA]);

end.
