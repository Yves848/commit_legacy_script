unit mdlLgo2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IOUtils,
  Dialogs, mdlModule, mdlModuleImport, DB, PdfDoc, PReport, ExtCtrls, Menus,
  JvMenus, JvWizard, JvWizardRouteMapNodes, mdlPIPanel, ComCtrls, Grids, mdlProjet,
  mdlPIStringGrid, DBGrids, mdlPIDBGrid, JvExControls, uib,
  JvXPCore, JvXPContainer, ImgList, ActnList, JclStrings, StrUtils, JvXPBar,
  StdCtrls, mdlPIButton, mdlConversionsTIFF, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter,
  mdlTypes, mdlMIPostgreSQL, XMLIntf, JclFileUtils, jclpcre, Generics.Collections;

type
  TfrLgo2 = class(TfrMIPostgreSQL)
    grdProgrammesFidelites: TPIStringGrid;
    wipProgrammesFidelites: TJvWizardInteriorPage;
    procedure wzDonneesActivePageChanged(Sender: TObject);
  private
    { Déclarations privées }
    procedure jfif2Jpeg(pSource,pDestination: String; pDeleteSource: boolean = false);
  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDocumentSF(ATraitement: TTraitement; ARepertoire, AFiltre: string; AConversionTIFF, ARecursif: boolean);
      override;
    procedure TraiterProgrammesFidelites;
    function FaireTraitementDocumentSF(ARepertoire, AFichier: string): TResultatCreationDonnees; override;

  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
  end;

implementation

uses mdlLgo2PHA , mdlLgo2configuration;
{$R *.dfm}

constructor TfrLgo2.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;
  ModeConnexion := mcServeurSQL;
end;

procedure TfrLgo2.wzDonneesActivePageChanged(Sender: TObject);
const
  C_INDEX_PAGE_PROGRAMMES_FIDELITES = 7;
  // pages non traites en automatique Programme Fidelites : parce que pas dans module import
  procedure TraiterDonnee;
  begin
    case wzDonnees.ActivePageIndex of
      C_INDEX_PAGE_PROGRAMMES_FIDELITES:
        TraiterProgrammesFidelites;
    end;
  end;

begin
  inherited;
  if Assigned(Module) and Module.Projet.Ouvert and (wzDonnees.ActivePageIndex = wipProgrammesFidelites.PageIndex) then
    TraiterDonnees(wipProgrammesFidelites, grdProgrammesFidelites, false, TPIList<integer>.Create([Ord(suppCarteFidelite)]),
      TraiterProgrammesFidelites);
  // on ne touche pas à suppCarteFidelite (qui devrait être suppprogrammefidelits car ça vient de projet
end;

procedure TfrLgo2.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then
    PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then
    PHA.ParametresConnexion.Add('bd=');
  if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then
    PHA.ParametresConnexion.Add('utilisateur=');
  if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then
    PHA.ParametresConnexion.Add('mot_de_passe=');
  if PHA.ParametresConnexion.IndexOfName('dump_postgres') = -1 then
    PHA.ParametresConnexion.Add('dump_postgres=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('serveur') then
      PHA.ParametresConnexion.Values['serveur'] := Attributes['serveur']
    else
      PHA.ParametresConnexion.Values['serveur'] := '127.0.0.1';
    if HasAttribute('bd') then
      PHA.ParametresConnexion.Values['bd'] := Attributes['bd']
    else
      PHA.ParametresConnexion.Values['bd'] := changeFileExt(ExtractFileName(Module.Projet.FichierProjet.FileName), ''); // 'Lgo2';
    if HasAttribute('utilisateur') then
      PHA.ParametresConnexion.Values['utilisateur'] := Attributes['utilisateur']
    else
      PHA.ParametresConnexion.Values['utilisateur'] := 'postgres';
    if HasAttribute('mot_de_passe') then
      PHA.ParametresConnexion.Values['mot_de_passe'] := Attributes['mot_de_passe']
    else
      PHA.ParametresConnexion.Values['mot_de_passe'] := 'postgres';

    if HasAttribute('dump_postgres') then
      PHA.ParametresConnexion.Values['dump_postgres'] := Attributes['dump_postgres']
    else
      PHA.ParametresConnexion.Values['dump_postgres'] := Module.Projet.RepertoireProjet + 'global.dumpall.gz';
  end;
end;

procedure TfrLgo2.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

procedure TfrLgo2.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Hopitaux']);
  TraiterDonnee(Traitements.Traitements['Praticiens']);
end;

procedure TfrLgo2.TraiterDonneesOrganismes;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Destinataires']);
  TraiterDonnee(Traitements.Traitements['Organismes AMO']);
  TraiterDonnee(Traitements.Traitements['Organismes AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
end;

procedure TfrLgo2.TraiterDocumentSF(ATraitement: TTraitement; ARepertoire, AFiltre: string; AConversionTIFF, ARecursif: boolean);
var
  i: integer;
  sTemp : String;

  procedure ChercherDocuments(r, f: string);
  var
    ext: string;
    sr: TSearchRec;
  begin
    Module.Projet.Console.AjouterLigne('Reprise et conversion des scans du repertoire '+ r);
    if (f = '.') or (f = '') then
      Module.Projet.Console.AjouterLigne('fichiers SANS extensions')
    else
      Module.Projet.Console.AjouterLigne('fichiers ayant une extention '+ f);

    if ARecursif then
     Module.Projet.Console.AjouterLigne('mode recursif ( parcours des sous dossiers )' );


    if FindFirst(r + '*.*', faAnyFile, sr) = 0 then
    begin

      repeat
        ext := tPath.GetExtension(sr.Name);


        if (sr.Name <> '.') and (sr.Name <> '..') then
          if ARecursif and ((sr.Attr and faDirectory) = faDirectory) then
            ChercherDocuments(r + sr.Name + '\', f)
          else
          begin
            if ((sr.Attr and faDirectory) <> faDirectory) then
            begin
              if ((ext = '') and (f = '.')) or ( ext = f ) then
                FResultat := FaireTraitementDocumentSF(r, sr.Name)
              else
                FResultat := rcdRejetee;

              case FResultat of
                rcdImportee:
                  TraitementEnCours.Succes := TraitementEnCours.Succes + 1;
                rcdAvertissement:
                  TraitementEnCours.Avertissements := TraitementEnCours.Avertissements + 1;
                rcdRejetee:
                  TraitementEnCours.Rejets := TraitementEnCours.Rejets + 1;
                rcdErreur:
                  TraitementEnCours.Erreurs := TraitementEnCours.Erreurs + 1;
              else
                Abort;
              end;

              Inc(i);
              if i mod 20000 = 0 then
                dmLgo2PHA.DePreparerCreationDonnees(True);
            end;
          end;
      until (FindNext(sr) <> 0) or Annulation;
      FindClose(sr);
    end;
  end;


begin

  if not Annulation then
  begin
    try
      SurAnnulerTraitement := SurAnnulation;

      TraitementEnCours := ATraitement;
      TraitementEnCours.Fait := false;

      ChercherDocuments(IncludeTrailingBackslash(ARepertoire), AFiltre);
    except
      on E: Exception do
      begin
        Module.Projet.Console.AjouterLigne(ATraitement.Fichier + ' : ' + E.Message);
        FResultat := rcdErreurSysteme;
      end;
    end;
    FinTraitementDocumentsSF;
  end;
end;

procedure TfrLgo2.TraiterDonneesClients;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Comptes']);
  TraiterDonnee(Traitements.Traitements['Clients']);
  TraiterDonnee(Traitements.Traitements['Commentaires Clients']);
  TraiterDonnee(Traitements.Traitements['Rattachement']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO Clients']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC Clients']);

end;

procedure TfrLgo2.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Zones Géographiques']);
  TraiterDonnee(Traitements.Traitements['Fournisseurs - Repartiteurs']);
  // TraiterDonnee(Traitements.Traitements['Familles Internes']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  // TraiterDonnee(Traitements.Traitements['Stocks']);
  // TraiterDonnee(Traitements.Traitements['Codes Produits']);
  TraiterDonnee(Traitements.Traitements['Historiques Ventes']);
  // TraiterDonnee(Traitements.Traitements['Produits - Lpp']);
end;

procedure TfrLgo2.TraiterDonneesEncours;
begin
  inherited;

  // TraiterDonnee(Traitements.Traitements['Produits Dus']);

  TraiterDonnee(Traitements.Traitements['Opérateurs']); 
  TraiterDonnee(Traitements.Traitements['Crédits']);
  TraiterDonnee(Traitements.Traitements['Avances']);  
  TraiterDonnee(Traitements.Traitements['Attentes']); 
  TraiterDonnee(Traitements.Traitements['Attentes Lignes']); 
  TraiterDonnee(Traitements.Traitements['Produits dus']); 
end;

procedure TfrLgo2.TraiterAutresDonnees;
var
  scan_auto : boolean;
begin
  inherited;
  // TraiterDonnee(Traitements.Traitements['Opérateurs']);
  TraiterDonnee(Traitements.Traitements['Historique clients']);
  TraiterDonnee(Traitements.Traitements['Historique clients lignes']);
  TraiterDonnee(Traitements.Traitements['Commandes']);
  TraiterDonnee(Traitements.Traitements['Commandes lignes']);
  // TraiterDonnee(Traitements.Traitements['Catalogues fournisseurs']);
  // TraiterDonnee(Traitements.Traitements['Catalogues fourn - Prod']);

  // pas de traitement auto en OPTION DE REPRISE Import pour les scans

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
  begin
    if HasAttribute('scan_auto') then
      Scan_auto := Attributes['scan_auto']
    else
      Scan_auto := False;
  end;

  if scan_auto then
   if (DirectoryExists(Module.Projet.RepertoireProjet+'Doc')) then
      TraiterDocumentSF(Traitements.Traitements['SCANS'], Module.Projet.RepertoireProjet+'Doc', '', True, True)
   else
      Module.Projet.Console.AjouterLigne('Repertoire "Doc" manquant dans le dossier du projet ! '+Module.Projet.RepertoireProjet);
end;

procedure TfrLgo2.TraiterProgrammesFidelites;
begin

  // TraiterDonnee(Traitements.Traitements['Programmes Avantages']);
  // TraiterDonnee(Traitements.Traitements['Programmes Avantages Clients']);
  // TraiterDonnee(Traitements.Traitements['Programmes Avantages Produits']);
  // TraiterDonnee(Traitements.Traitements['Cartes Programmes Relationnels']);
end;

procedure TfrLgo2.jfif2Jpeg(pSource ,pDestination: String; pDeleteSource: boolean = false);
var
  sIn, sOut: tFileStream;
  iSize: integer;
  ch1, ch2: byte;
  iOffSet, icurrentOffset: integer;
  index : integer;
  listOffset: TList<Integer>;
  // rechercher les octets  FF D8 et couper tout ce qui se trouve avant

begin
  listOffset := TList<Integer>.Create;
  // 4 endroits possibles trouvés dans les exemples de scans , d'autres possibles ...
  listOffset.AddRange([ 19, 20, 74, 78, 83 ,88, 92]);

  try
    iOffSet := -1;
    sIn := tFileStream.Create(pSource, fmOpenRead + fmShareDenyNone);
    sIn.Position := 0;
    // methode 1 pour les Scanxxx , acces direct
    sIn.Seek(0, soFromBeginning);  // LECTURE DU PREMIER MOT = LONGUEUR DE CHAINE
    sIn.Read(ch1, 1);
    sIn.Read(ch2, 1);
    icurrentOffset := ch1+ch2*256 +9;
    sIn.Seek(ch1+ch2*256 +9, soFromCurrent); // decalage de la longueur de chaine  + 9 octets
    sIn.Read(ch1, 1);
    sIn.Read(ch2, 1);
    if (ch1 = 255) and (ch2 = 216) then
      begin
        iOffset := icurrentOffset + 2;
      end;

    // methode 2 parcours a plusieurs endroits
    if iOffSet = -1 then
    for Index := 0 to listOffset.Count - 1 do
    begin
      sOut := nil;
      sIn.Seek(listOffset.Items[Index], soFromBeginning);
      sIn.Read(ch1, 1);
      sIn.Read(ch2, 1);
      if (ch1 = 255) and (ch2 = 216) then
      begin
        iOffset := listOffset.Items[Index];
        break;
      end;
    end;

    // la creation d un nouveau fichier ne se fera que si un fichier scan est reconnu
    if iOffSet > 0 then
    begin
      //Module.Projet.Console.AjouterLigne('offset '+ IntToStr(iOffSet ));

      iSize := sIn.Size - iOffset;
      sIn.Position := 0;
      sOut := tFileStream.Create(pDestination, fmCreate);
      sIn.Seek(iOffset, 0);
      sOut.CopyFrom(sIn, iSize);
    end;
  finally
    if sOut <> nil then
      sOut.Free
    else
      Module.Projet.Console.AjouterLigne('Echec de conversion de '+pSource);
    sIn.Free;
    if pDeleteSource then
      DeleteFile(pSource);
  end;
end;

function TfrLgo2.FaireTraitementDocumentSF(ARepertoire, AFichier: string): TResultatCreationDonnees;
var
  s: string;
  i: integer;
  afile: String;
  aExt : String;
  aRegex: String;
  pRegEx : TJclRegEx;

  function extractId(sValue: String): Integer;
  var
    sResult : String;
  begin
      pRegEx.Compile(aRegex,false);
      sResult := '-1';
      if pREgEx.Match(sValue) then
         sResult := pREgEx.Captures[0];

      result := strToIntDef(sResult,-1);
  end;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
  begin
    if HasAttribute('regex_scan') then
      aRegex := Attributes['regex_scan'];
  end;

  pREgEx := TJclRegEx.Create;
  s := ExtractFileName(Copy(ARepertoire, 1, Length(ARepertoire) - 1));
  afile := ARepertoire + AFichier;
  aExt := uppercase(tPath.GetExtension(aFichier));
  if (aExt = '.') or  (aExt = '') then  // trt seulement des fichiers sans extension
  begin
     jfif2Jpeg(afile, afile + '.jpg', False ); // delete a remplacer par une option
  end;
  i := extractId(aFichier);
  pRegEx.Free;
  if (aExt = '.') and (aExt = '') then
    Result := dmLgo2PHA.CreerDocument(i, PathRemoveExtension(AFichier), ARepertoire + AFichier)
  else
    Result := dmLgo2PHA.CreerDocument(i, PathRemoveExtension(AFichier), ARepertoire + PathRemoveExtension(AFichier) + '.jpg');
end;




initialization

RegisterClasses([TfrLgo2, TdmLgo2PHA, TfrLgo2Configuration]);

finalization

UnRegisterClasses([TfrLgo2, TdmLgo2PHA, TfrLgo2Configuration]);

end.
