 unit mdlIPharma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, DB,
  Grids, DBGrids, Menus, mdlModule, mdlModuleImport, uiblib, uibase, uib,
  mdlPIPanel, mdlProjet, ActnList, ImgList, PdfDoc, PReport, JvMenus,
  JvXPCore, JvXPContainer, JvWizard, JvWizardRouteMapNodes, JclFileUtils,
  mdlPIStringGrid, mdlPIDBGrid, JvExControls, JvXPBar, mdlMIFirebird,
  mdlMIFirebirdPHA, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter,
  mdlConversionsTIFF, mdlInformationFichier, ZConnection, ZDataset;

type
  TdmIPharmaPHA = class(TdmMIFirebirdPHA)
    ZConnection2 : TZConnection;
    ZQuery2 : TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender : TObject);
    procedure ZConnection1AfterDisconnect(Sender : TObject);
  public
    procedure ConnexionBD; override;
    procedure DeconnexionBD; override;
    function RenvoyerChaineConnexion : string; override;
  end;

  TfrIPharma = class(TfrMIFirebird)
  protected
    function FaireTraitementDonnees(
      ADonnees: TFields): TResultatCreationDonnees; override;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

var
  frIPharma : TfrIPharma;
  dmIPharmaPHA : TdmIPharmaPHA;

const
  C_TRAITEMENT_MEDECINS = 'MEDECINS';
  C_TRAITEMENT_PROFILSREMISES = 'PROFILSREMISES';
  C_TRAITEMENT_GROUPES = 'GROUPES';
  C_TRAITEMENT_CLIENTS = 'CLIENTS';
  C_TRAITEMENT_PHARMACIENREFERENT = 'PHARMACIEN_REFERENT';
  C_TRAITEMENT_NOTES = 'NOTES';
  C_TRAITEMENT_CLIENTSOA = 'CLIENTSOA';
  C_TRAITEMENT_CLIENTSOC = 'CLIENTSOC';
  C_TRAITEMENT_CLIENTSVIRTUELS = 'CLIENTSVIRTUEL';
 // C_TRAITEMENT_CARTESRISTOURNES = 'CARTESRISTOURNES';
  C_TRAITEMENT_COMPTESRISTOURNES = 'COMPTESRISTOURNES';
  C_TRAITEMENT_TRANSACTIONSRISTOURNES = 'TRANSACTIONSRISTOURNES';
  C_TRAITEMENT_TARIFSPRODUITS = 'TARIFSPRODUITS';
  C_TRAITEMENT_FOURNISSEURS = 'FOURNISSEURS';
  C_TRAITEMENT_ZONESGEOGRAPHIQUES = 'ZONESGEOGRAPHIQUES';
  C_TRAITEMENT_STOCK = 'STOCKS';
  C_TRAITEMENT_CODESBARRES = 'CODESBARRES';
  C_TRAITEMENT_PRIX = 'PRIX';
  C_TRAITEMENT_DESIGNATION = 'DESIGNATION';
  C_TRAITEMENT_HISTORIQUEVENTE = 'HISTORIQUEVENTE';
  C_TRAITEMENT_ATTESTATIONS = 'ATTESTATIONS';
  C_TRAITEMENT_HISTORIQUEENTETES = 'HISTORIQUEENTETES';
  C_TRAITEMENT_HISTORIQUELIGNES = 'HISTORIQUELIGNES';
  C_TRAITEMENT_HISTORIQUEMAGIS = 'HISTORIQUEMAGIS';
  C_TRAITEMENT_DELDIF = 'DELDIF';
  C_TRAITEMENT_CREDIT = 'CREDIT';
  C_TRAITEMENT_AVANCEPRODUIT = 'AVANCEPRODUIT';


implementation

uses mdlIIPharmaConnexionServeur;

{$R *.dfm}

procedure TfrIPharma.TraiterDonnee(ATraitement : TTraitement);
begin
  if (ATraitement.Fichier = C_TRAITEMENT_MEDECINS) or
     (ATraitement.Fichier = C_TRAITEMENT_PROFILSREMISES) or (ATraitement.Fichier = C_TRAITEMENT_GROUPES ) or (ATraitement.Fichier = C_TRAITEMENT_CLIENTS) or
     (ATraitement.Fichier = C_TRAITEMENT_NOTES) or
     (ATraitement.Fichier = C_TRAITEMENT_CLIENTSOA) or (ATraitement.Fichier = C_TRAITEMENT_CLIENTSOC) or (ATraitement.Fichier = C_TRAITEMENT_CLIENTSVIRTUELS) or
     //(ATraitement.Fichier = C_TRAITEMENT_CARTESRISTOURNES) or
     (ATraitement.Fichier = C_TRAITEMENT_COMPTESRISTOURNES) or (ATraitement.Fichier = C_TRAITEMENT_TRANSACTIONSRISTOURNES) or
     (ATraitement.Fichier = C_TRAITEMENT_TARIFSPRODUITS) or (ATraitement.Fichier = C_TRAITEMENT_FOURNISSEURS) or
     (ATraitement.Fichier = C_TRAITEMENT_ZONESGEOGRAPHIQUES) or (ATraitement.Fichier = C_TRAITEMENT_STOCK) or (ATraitement.Fichier = C_TRAITEMENT_ATTESTATIONS) or
     (ATraitement.Fichier = C_TRAITEMENT_HISTORIQUEVENTE) or (ATraitement.Fichier = C_TRAITEMENT_HISTORIQUEENTETES) or
     (ATraitement.Fichier = C_TRAITEMENT_HISTORIQUELIGNES) or (ATraitement.Fichier = C_TRAITEMENT_HISTORIQUEMAGIS) or
     (ATraitement.Fichier = C_TRAITEMENT_DELDIF) or (ATraitement.Fichier = C_TRAITEMENT_CREDIT) or (ATraitement.Fichier = C_TRAITEMENT_AVANCEPRODUIT)
     or (ATraitement.Fichier = C_TRAITEMENT_PHARMACIENREFERENT)
      then

    inherited TraiterDonnee(ATraitement)
  else
  begin
    dmIPharmaPHA.ZQuery2.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);
    inherited TraiterDonnee(ATraitement, dmIPharmaPHA.ZQuery2);
  end;
end;

constructor TfrIPharma.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;

  FInterfaceConnexion := TfrmIIPharmaConnexionServeur;
end;

function TfrIPharma.FaireTraitementDonnees(
  ADonnees: TFields): TResultatCreationDonnees;
begin
  with TTraitementBD(TraitementEnCours) do
    Result := TdmIPharmaPHA(PHA).ExecuterPS(Fichier, ProcedureCreation, ADonnees);
end;

procedure TdmIPharmaPHA.ConnexionBD;
begin
  inherited;

  ZConnection2.Database := ParametresConnexion.Values['bd_tarif'];
  if ParametresConnexion.Values['connexion_locale'] = '0' then
    ZConnection2.HostName := ParametresConnexion.Values['serveur']
  else
    ZConnection2.HostName := '';
  ZConnection2.Connect;
end;

procedure TdmIPharmaPHA.ZConnection1AfterConnect(Sender : TObject);
begin
//  FileCopy(Module.Projet.RepertoireApplication + '\fb206\UDF\GDS32.DLL', Module.Projet.RepertoireApplication + '\GDS32.DLL', True);
end;

procedure TdmIPharmaPHA.ZConnection1AfterDisconnect(Sender: TObject);
begin
//  FileDelete(Module.Projet.RepertoireApplication + '\GDS32.DLL');
end;

procedure TdmIPharmaPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmIPharmaPHA := Self;

  ZConnection1.LibraryLocation := Module.Projet.RepertoireApplication + '\fb\fbclient.dll';
  ZConnection1.Protocol := 'firebirdd-2.5';
  ZConnection1.AfterConnect := ZConnection1AfterConnect;
  ZConnection1.AfterDisconnect := ZConnection1AfterDisconnect;

  //ZConnection1.Properties.Add('Path=' + Module.Projet.RepertoireApplication + '\fb215');
  //ZConnection1.Protocol := 'firebirdd-2.1';

  ZConnection2 := TZConnection.Create(Self);
  //ZConnection2.Properties.Add('Path=' + Module.Projet.RepertoireApplication + '\fb215');
  //ZConnection2.Protocol := 'firebirdd-2.1';
  ZConnection2.LibraryLocation := Module.Projet.RepertoireApplication + '\fb\fbclient.dll';
  ZConnection2.Protocol := 'firebirdd-2.5';
  ZConnection2.User := 'sysdba';
  ZConnection2.Password := 'masterkey';

  ZQuery2 := TZQuery.Create(Self);
  ZQuery2.Connection := ZConnection2;
end;

{ TfrCaduciel V6}

procedure TfrIPharma.RenvoyerParametresConnexion;
begin
  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('bd') then PHA.ParametresConnexion.Values['bd'] :=  Attributes['bd'] else PHA.ParametresConnexion.Values['bd'] := Module.Projet.RepertoireProjet + 'OFFICINE.FDB';
    if HasAttribute('bd_tarif') then PHA.ParametresConnexion.Values['bd_tarif'] :=  Attributes['bd_tarif'] else PHA.ParametresConnexion.Values['bd_tarif'] := Module.Projet.RepertoireProjet + 'TARIF.FDB';
  end;
end;

procedure TfrIPharma.StockerParametresConnexion;
begin
  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['bd_tarif'] := PHA.ParametresConnexion.Values['bd_tarif'];
  end;
end;

procedure TfrIPharma.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['MEDECINS']);

end;

procedure TfrIPharma.TraiterDonneesOrganismes;
begin
  inherited;

end;

procedure TfrIPharma.TraiterDonneesEncours;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['DELDIF']);
  TraiterDonnee(Traitements.Traitements['CREDIT']);
  TraiterDonnee(Traitements.Traitements['AVANCEPRODUIT']);

end;

procedure TfrIPharma.TraiterDonneesClients;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['PROFILSREMISES']);
  TraiterDonnee(Traitements.Traitements['GROUPES']);
  TraiterDonnee(Traitements.Traitements['CLIENTS']);
  TraiterDonnee(Traitements.Traitements['PHARMACIEN_REFERENT']);
  TraiterDonnee(Traitements.Traitements['NOTES']);
  TraiterDonnee(Traitements.Traitements['CLIENTSOA']);
  TraiterDonnee(Traitements.Traitements['CLIENTSOC']);
 // TraiterDonnee(Traitements.Traitements['CLIENTSVIRTUELS']);
  //TraiterDonnee(Traitements.Traitements['CARTESRISTOURNES']);
  TraiterDonnee(Traitements.Traitements['COMPTESRISTOURNES']);
  TraiterDonnee(Traitements.Traitements['TRANSACTIONSRISTOURNES']);

end;


procedure TfrIPharma.TraiterDonneesProduits;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['TARIFSPRODUITS']);
  TraiterDonnee(Traitements.Traitements['FOURNISSEURS']);
  TraiterDonnee(Traitements.Traitements['ZONESGEOGRAPHIQUES']);
  TraiterDonnee(Traitements.Traitements['STOCKS']);
  TraiterDonnee(Traitements.Traitements['CODESBARRES']);
  TraiterDonnee(Traitements.Traitements['PRIX']);
  TraiterDonnee(Traitements.Traitements['DESIGNATIONS']);
  TraiterDonnee(Traitements.Traitements['ATTESTATIONS']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUEVENTE']);

end;

procedure TfrIPharma.TraiterAutresDonnees;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['HISTORIQUEENTETES']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUELIGNES']);
  TraiterDonnee(Traitements.Traitements['LIBELLECHIMIQUE']);
  TraiterDonnee(Traitements.Traitements['HISTORIQUEMAGIS']);

end;

procedure TdmIPharmaPHA.DeconnexionBD;
begin
  ZConnection2.Disconnect;

  inherited;
end;

function TdmIPharmaPHA.RenvoyerChaineConnexion: string;
begin
  Result := ZConnection1.Database + '/' + ZConnection2.Database;
end;

initialization
  RegisterClasses([TfrIPharma, TdmIPharmaPHA]);

finalization
  unRegisterClasses([TfrIPharma, TdmIPharmaPHA]);

end.
