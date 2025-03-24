unit mdlImportLGPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, mdlPIPanel, ToolWin, ComCtrls,
  StdCtrls, Buttons, mdlPISpeedButton, mdlProjet, mdlModuleImport,
  Grids, DB, ActnList, ImgList, PdfDoc, PReport, JvMenus, JvXPCore,
  JvXPContainer, JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, DBGrids,
  mdlPIDBGrid, JvExControls, JvXPBar, mdlModule, uib, VirtualTrees,
  JvExExtCtrls, JvNetscapeSplitter, mdlOracleConnexionServeur, Ora, OraClasses;

type
  TfrImportLGPI = class(TfrModuleImport)
  private
    { Déclarations privées }
  protected
    function FaireTraitementDonnees(ADonnees :  TFields) : TResultatCreationDonnees; override;
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonnee(ATraitement : TTraitement); override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
    procedure SaveTextToFile(const FileName, TextToSave: string);
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

implementation

uses mdlImportLGPIPHA;

{$R *.dfm}
{$R logo.res}

constructor TfrImportLGPI.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;
  FInterfaceConnexion := TfrmOracleConnexionServeur;

  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;
end;

procedure TfrImportLGPI.SaveTextToFile(const FileName, TextToSave: string);
var
  FileHandle: TFileStream;
  fullPath: AnsiString;
  fm: word;
begin

    if fileexists(FileName) then
       fm:=fmOpenWrite
    else
      fm:=fmCreate;
      FileHandle := TFileStream.Create(FileName, fm);

  try

      FullPath := '/home/pharmagest/muse/'+TextToSave+#10;
      FileHandle.Seek(0,soFromEnd);
      FileHandle.Write(PChar(FullPath)^, Length(FullPath));

  finally
    FileHandle.Free;
  end;
end;

function TfrImportLGPI.FaireTraitementDonnees(
  ADonnees: TFields): TResultatCreationDonnees;
var
  chemin_fichier, chemin_unix : string;
  str : TMemoryStream;
begin
  if ((pos('Attestations', TraitementEnCours.Fichier)>0) or
      (pos('Scans', TraitementEnCours.Fichier)>0))  then
    with dmImportLGPIPHA.qryLGPI do
    begin
     if (FieldByName('muse_path').AsString > '') then
     begin
        chemin_fichier := Module.Projet.RepertoireProjet + 'muse\' + FieldByName('muse_path').AsString;
        chemin_unix := StringReplace(FieldByName('muse_path').AsString, '\', '/', [rfReplaceAll, rfIgnoreCase]);
        SaveTextToFile(Module.Projet.RepertoireProjet+'scanlist.txt',chemin_unix);
      end
      else
        begin
          chemin_fichier := Module.Projet.RepertoireProjet + 'blob\' + FieldByName('id_doc').AsString+'_'+FieldByName('page').AsString +'.tiff';
          if not(fileexists(chemin_fichier)) then
            GetLob('content').SaveToFile(chemin_fichier);

        end;
        Result := dmImportLGPIPHA.CreerDocument(FieldByName('id_entity').AsInteger,
                                                FieldByName('id_doc').AsInteger,
                                                FieldByName('content_type').AsInteger,
                                                FieldByName('page').AsInteger,
                                                FieldByName('muse_path').AsString,
                                                chemin_fichier,
                                                FieldByName('commentaire').AsString);
    end
  else
    Result := inherited FaireTraitementDonnees(ADonnees);
end;

procedure TfrImportLGPI.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then PHA.ParametresConnexion.Add('serveur=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin                // recup des infos de connexion de la fenetre
    if HasAttribute('serveur') then
      PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur']
    else
      PHA.ParametresConnexion.Values['serveur'] := '192.168.0.100'; //attribution des valeurs par defaut

    if HasAttribute('utilisateur') then
    PHA.ParametresConnexion.Values['utilisateur'] :=  Attributes['utilisateur']
      else
    PHA.ParametresConnexion.Values['utilisateur'] := 'ERP';

    if HasAttribute('mot_de_passe') then
    PHA.ParametresConnexion.Values['mot_de_passe'] :=  Attributes['mot_de_passe']
      else
    PHA.ParametresConnexion.Values['mot_de_passe'] := 'ERP';
  end;
end;

procedure TfrImportLGPI.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

procedure TfrImportLGPI.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Historiques délivrances entêtes']);
  TraiterDonnee(Traitements.Traitements['Historiques délivrances lignes']);
  TraiterDonnee(Traitements.Traitements['Historique achats entêtes']);
  TraiterDonnee(Traitements.Traitements['Historique achats lignes']);
  TraiterDonnee(Traitements.Traitements['Attestations mutuelles']);
  TraiterDonnee(Traitements.Traitements['Scans Ordonnances']);
  TraiterDonnee(Traitements.Traitements['Attestations mutuelles MUSE']);
  TraiterDonnee(Traitements.Traitements['Scans Ordonnances MUSE']);
end;

procedure TfrImportLGPI.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Clients']);
  TraiterDonnee(Traitements.Traitements['Adhérent comptes']);
  TraiterDonnee(Traitements.Traitements['Couvertures clients']);
  TraiterDonnee(Traitements.Traitements['Commentaires clients']);
  TraiterDonnee(Traitements.Traitements['Mandataires']);
end;

procedure TfrImportLGPI.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Destinataires']);
  TraiterDonnee(Traitements.Traitements['Organismes']);
  TraiterDonnee(Traitements.Traitements['Associations AMO AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
  TraiterDonnee(Traitements.Traitements['Taux de prise en charge']);
end;

procedure TfrImportLGPI.TraiterDonneesPraticiens;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Hopitaux']);
  TraiterDonnee(Traitements.Traitements['Praticiens']);
end;

procedure TfrImportLGPI.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Depots']);
  TraiterDonnee(Traitements.Traitements['Fournisseurs directs']);
  TraiterDonnee(Traitements.Traitements['Répartiteurs']);
  TraiterDonnee(Traitements.Traitements['Répartiteurs manquants']);
  TraiterDonnee(Traitements.Traitements['Codifications']);
  TraiterDonnee(Traitements.Traitements['Zones géographiques']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Stocks secondaires']);
  TraiterDonnee(Traitements.Traitements['Codes Ean13']);
  TraiterDonnee(Traitements.Traitements['Codes LPP']);
  TraiterDonnee(Traitements.Traitements['Historiques ventes']);
  if (dmImportLGPIPHA.VersionLGPI = '104I') and
     (dmImportLGPIPHA.VersionLGPI = '104H') then
  begin
    Traitements.Traitements['Catalogues'].Fait := True;
    Traitements.Traitements['Classifications fournisseurs'].Fait := True;
    Traitements.Traitements['Lignes catalogues'].Fait := True;
  end
  else
  begin
    TraiterDonnee(Traitements.Traitements['Catalogues']);
    TraiterDonnee(Traitements.Traitements['Classifications fournisseurs']);
    TraiterDonnee(Traitements.Traitements['Lignes catalogues']);
  end;

end;

procedure TfrImportLGPI.TraiterDonnee(ATraitement: TTraitement);
begin
  if FileExists(Module.RepertoireRessources + '\' +
                dmImportLGPIPHA.VersionLGPI + '_' +
                TTraitementBD(ATraitement).RequeteSelection) then
    dmImportLGPIPHA.qryLGPI.SQL.LoadFromFile(Module.RepertoireRessources + '\' + dmImportLGPIPHA.VersionLGPI + '_' + TTraitementBD(ATraitement).RequeteSelection)
  else
    dmImportLGPIPHA.qryLGPI.SQL.LoadFromFile(Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection);

  inherited TraiterDonnee(ATraitement, dmImportLGPIPHA.qryLGPI);
end;

procedure TfrImportLGPI.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Opérateurs']);
  TraiterDonnee(Traitements.Traitements['Crédits']);
  TraiterDonnee(Traitements.Traitements['Vignettes avancées']);
  TraiterDonnee(Traitements.Traitements['Factures en attente entetes']);
  TraiterDonnee(Traitements.Traitements['Factures en attente lignes']);
end;

initialization
  RegisterClasses([TfrImportLGPI, TdmImportLGPIPHA]);

finalization
  UnRegisterClasses([TfrImportLGPI, TdmImportLGPIPHA]);

end.
