unit mdlLeo2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, DB,
  Grids, DBGrids, Menus, mdlModule, mdlModuleImport, mdlLectureFichierBinaire,
  mdlPIPanel, mdlProjet, ActnList, ImgList, PdfDoc, PReport, JvMenus, mdlMISQLServeur, mdlMISQLServeurPHA,
  JvXPCore, JvXPContainer, JvWizard, JvWizardRouteMapNodes, JclAnsiStrings, Generics.Collections,
  mdlPIStringGrid, mdlPIDBGrid, JvExControls, JvXPBar, UIB, mdlInformationFichier,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter;

type
  TdmLeo2PHA = class(TdmMISQLServeurPHA)
  public
    procedure SupprimerDonnees(ADonneesASupprimer : TList<Integer>); override;
    function CreerDocument(AIDClient, AFichier, ALibelle : string) : TResultatCreationDonnees;
  end;

  TfrLeo2 = class(TfrMISQLServeur, IInventaire)
  protected
    function FaireTraitementDonnees(ADonnees : TFields) : TResultatCreationDonnees; override;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    procedure RenvoyerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
    function GenererInventaire : TStrings;
  end;

var
  frLeo2 : TfrLeo2;

implementation

uses mdlLeo2Configuration, mdlConversionsTIFF, mdlLeo2ConnexionServeur;

{$R *.dfm}
{$R logo.res}

{ TfrLeo2}

procedure TfrLeo2.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['COMPTES']);
  TraiterDonnee(Traitements.Traitements['CLIENTS']);
  TraiterDonnee(Traitements.Traitements['GARANTIES PRIMAIRES PATIENTS']);
  TraiterDonnee(Traitements.Traitements['GARANTIES COMPLEMENTAIRES PATIENTS']);
  //TraiterDonnee(Traitements.Traitements['ps_leo2_maj_destinataire']);
end;

procedure TfrLeo2.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['DESTINATAIRES']);
  TraiterDonnee(Traitements.Traitements['CAISSES PRIMAIRES']);
  //TraiterDonnee(Traitements.Traitements['GARANTIES PRIMAIRES']);
  TraiterDonnee(Traitements.Traitements['CAISSES COMPLEMENTAIRES']);
  TraiterDonnee(Traitements.Traitements['GARANTIES COMPLEMENTAIRES']);
  //TraiterDonnee(Traitements.Traitements['EXCEPTIONS TAUX PRIMAIRES']);
  TraiterDonnee(Traitements.Traitements['EXCEPTIONS TAUX COMPLEMENTAIRES']);
end;

procedure TfrLeo2.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ETABLISSEMENTS']);
  TraiterDonnee(Traitements.Traitements['PRESCRIPTEURS']);
end;

procedure TfrLeo2.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['ZONES GEOGRAPHIQUES']);
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);

  TraiterDonnee(Traitements.Traitements['DEPOTS']);
  TraiterDonnee(Traitements.Traitements['PRODUITS']);
  TraiterDonnee(Traitements.Traitements['COMMENTAIRES PRODUITS']);
  TraiterDonnee(Traitements.Traitements['CODES LPP']);
  TraiterDonnee(Traitements.Traitements['STOCKS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES VENTES']);
end;

procedure TfrLeo2.TraiterAutresDonnees;
begin
  inherited;

//  TraiterDonnee(Traitements.Traitements['DOCUMENTS SCANNEES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES CLIENTS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUES CLIENTS LIGNES']);
  TraiterDonnee(Traitements.Traitements['COMMANDES']);
  TraiterDonnee(Traitements.Traitements['COMMANDES LIGNES']);
{  if Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].ChildNodes['provenance_catalogues'].NodeValue = C_PROVENANCE_CAT_COMMANDES then
  begin
    PHA.ExecuterPS('COMMANDES', 'PS_CREER_CATALOGUES', null, True, etmCommit);
    Traitements.Traitements['CATALOGUES'].Fait := True;
  end
  else
    TraiterDonnee(Traitements.Traitements['CATALOGUES']);}
end;

constructor TfrLeo2.Create(AOwner: TComponent; AModule: TModule);
begin
  AModule.Logo.LoadFromResourceName(HInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(HInstance, 'ICONE');
  inherited;

  FInterfaceConnexion := TfrmLeo2ConnexionServeur;

  TdmMISQLServeurPHA(PHA).qryOLEDB.CommandTimeout := 600;
end;

function TfrLeo2.FaireTraitementDonnees(
  ADonnees: TFields): TResultatCreationDonnees;
var
  r, f : string;
begin
  if TraitementEnCours.Fichier = 'DOCUMENTS SCANNEES' then
  begin
    r := Module.Projet.RepertoireProjet + 'AC\';
    f := ADonnees.FieldByName('DCN_NOM').AsString;
    frmConversionTIFF.AjouterDocumentAConvertir(r + f);
    Result := TdmLeo2PHA(PHA).CreerDocument(ADonnees.FieldByName('CLI_ID').AsString, r + ExtractFileNameWExt(f) + '.tif', ADonnees.FieldByName('DCN_DESCRIPTION').AsString);
  end
  else
    with TTraitementBD(TraitementEnCours) do
      Result := TdmLeo2PHA(PHA).ExecuterPS(Fichier, ProcedureCreation, ADonnees);
end;

function TfrLeo2.GenererInventaire : TStrings;
begin
  Result := TStringList.Create;
  with TdmLeo2PHA(PHA).adoDataset do
  begin
    SQL.Clear;
    SQL.Add('select prd.prd_codecip, stp.stp_qteactuelle');
    SQL.Add('from dbo.produit prd');
    SQL.Add('left join dbo.prd_asso_lst stp on (stp.prd_id = prd.prd_id)');
    SQL.Add('left join dbo.lieustockage lst on (lst.lst_id = stp.lst_id)');
    SQL.Add('where lst.lst_priodestock = 1');
    SQL.Add('and stp.stp_qteactuelle > 0');
    Open;
    while not EOF do
    begin
      Result.Add(Fields[0].AsString + ' ' + StrPadLeft(Fields[1].AsString, 7, '0'));
      Next;
    end;
  end;
end;

procedure TfrLeo2.RenvoyerParametresConnexion;
begin
  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    PHA.ParametresConnexion.Values['utilisateur'] := 'sa';
    PHA.ParametresConnexion.Values['mot_de_passe'] := 'local';
    PHA.ParametresConnexion.Values['bd'] := 'LeoNew';

    if HasAttribute('serveur') then PHA.ParametresConnexion.Values['serveur'] := Attributes['serveur'] else PHA.ParametresConnexion.Values['serveur'] := 'LEO00\LEO2014';
  end;
end;

procedure TfrLeo2.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['UTILISATEURS']);
  TraiterDonnee(Traitements.Traitements['CREDITS']);
  TraiterDonnee(Traitements.Traitements['VIGNETTES AVANCEES']);
  TraiterDonnee(Traitements.Traitements['PRODUITS DUS']);
end;

procedure TfrLeo2.TraiterDonnee(ATraitement : TTraitement);
begin
  if ATraitement.Fichier = 'DOCUMENTS SCANNEES' then
  begin
    frmConversionTIFF.Show;
    frmConversionTIFF.Initialiser(Module.Projet.RepertoireApplication);
  end;

  inherited TraiterDonnee(ATraitement);
end;

{ TdmLeo2PHA }

function TdmLeo2PHA.CreerDocument(AIDClient, AFichier,
  ALibelle: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS('DOCUMENTS SCANNEES', 'PS_Leo2_CREER_DOC_SCANNEE',
                       VarArrayOf([AIDClient, AFichier, ALibelle]));
end;

procedure TdmLeo2PHA.SupprimerDonnees(ADonneesASupprimer: TList<Integer>);
var
  i : Integer;
begin
  if ADonneesASupprimer.IndexOf(Ord(suppProduits)) <> -1 then ADonneesASupprimer.Add(101);
  i := ADonneesASupprimer.IndexOf(Ord(suppEnCours)); if i <> -1 then ADonneesASupprimer[i] := 102;
  if ADonneesASupprimer.IndexOf(Ord(suppHistoriques)) <> -1 then ADonneesASupprimer.Add(103);

  inherited;
end;

initialization
  RegisterClasses([TfrLeo2, TdmLeo2PHA, TfrLeo2Configuration]);

finalization
  unRegisterClasses([TfrLeo2, TdmLeo2PHA, TfrLeo2Configuration]);

end.