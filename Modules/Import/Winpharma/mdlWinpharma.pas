unit mdlWinpharma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, StdCtrls, Buttons, ComCtrls, ExtCtrls, strutils, DB, UIBLib,
  Grids, DBGrids, Menus, mdlModule, mdlPIPanel, mdlPHA, JclFileUtils, mdlPIDataset,
  ToolWin, mdlProjet, PdfDoc, PReport, JvMenus, JvWizard, mdlMIPI, mdlMIODBCPHA, mdlPIODBC,
  JvWizardRouteMapNodes, mdlPIStringGrid, mdlPIDBGrid, JvExControls, ComObj,
  ActnList, ImgList, JvXPCore, JvXPContainer, mdlModuleImport, JvXPBar, uib,
  XMLIntf, XMLDoc, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, JclStreams,
  Generics.Collections, JclShell, dateutils, mdlCreditsWinpharma;

type
  TTraitementWinpharma = class(TTraitementBD)
  private
    FChampFacteurDecoupage: string;
  public
    property ChampFacteurDecoupage: string read FChampFacteurDecoupage write FChampFacteurDecoupage;
    procedure CompleterTraitement(F: TSQLResult); override;
  end;

  TdmWinpharmaPHA = class(TdmMIODBCPHA)
  public
    { Déclarations publiques }
    procedure ConnexionBD; override;
    function RenvoyerChaineConnexion: string; override;
    function CreerDocument(ATypeID, AID1, AID2, ADateModification, AFichier: string): TResultatCreationDonnees;
    procedure SupprimerDonnees(ADonneesASupprimer: TList<Integer>); override;
  end;

  TfrWinpharma = class(TfrMIPI)
  private
    FBLOBBINS: TDictionary<Char, TJclFileStream>;
    function ExtraireDocumentTIFF(AID: Integer; AOffset, ATaille: DWORD): string;
  protected
    function RenvoyerClasseTraitement: TClasseTraitement; override;
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    function FaireTraitementDonnees(ADonnees: TPIChamps): TResultatCreationDonnees; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    procedure TraiterCredits(ATraitement: TTraitement);
    function TraiterDonneesCredits(aCredit: TCredit): TResultatCreationDonnees;
  public
    { Déclarations publiques }

    constructor Create(AOwner: TComponent; AModule: TModule); override;
    destructor Destroy; override;
  end;

const
  C_CHAINE_CONNEXION_WINPHARMA = 'DRIVER=WinPharma;Channel=%s;UID=%s;PWD=%s';

  C_TRAITEMENT_CODIFICATIONS = 'Codifications';
  C_TRAITEMENT_CODIFICATIONS_PRODUIT = 'Codifications produits';
  C_TRAITEMENT_CREDITS = 'CREDITS.TXT';
  C_TRAITEMENT_CREDITS_COMPTES = 'CREDITS_COMPTES.TXT';

  C_TRAITEMENT_DOCUMENTS_TIFF = 'Documents scannés';

var
  frWinpharma: TfrWinpharma;

implementation

uses mdlWinPharmaConnexionServeur, mdlWinPharmaConfiguration;
{$R *.dfm}
{$R logo.res}

function TfrWinpharma.FaireTraitementDonnees(ADonnees: TPIChamps): TResultatCreationDonnees;
var
  F: string;
  test1: TDateTime;
  str1: string;
  test2: TDateTime;
  str2: string;
  iCodif : Integer;
  bCodifDefaut : boolean;
begin
  if (TraitementEnCours.Fichier = C_TRAITEMENT_DOCUMENTS_TIFF) then
  begin
    // test1 := FormatDateTime('YYYYMMDD', ADonnees.ChampParNom('TMCREATE').AsDateTime) ;
    // str1 := FormatDateTime('YYYYMMDD',ADonnees.ChampParNom('TMCREATE').AsDateTime);
    // test2 := Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes[C_CFG_SCANS_DATE_IMPORT];
    // str2 :=FormatDateTime('YYYYMMDD', Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes[C_CFG_SCANS_DATE_IMPORT]);
    if (FormatDateTime('YYYYMMDD', ADonnees.ChampParNom('TMCREATE').AsDateTime) >= FormatDateTime('YYYYMMDD',
        Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes
          [C_CFG_SCANS_DATE_IMPORT])) then
    // FormatDateTime('DD-MM-YYYY', Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes[C_CFG_SCANS_DATE_IMPORT])) then
    begin
      F := ExtraireDocumentTIFF(ADonnees.ChampParNom('BLOB_TI').AsInteger, DWORD(ADonnees.ChampParNom('OFFSET').AsInteger),
        ADonnees.ChampParNom('SIZE_FILECODE').AsInteger);
      if F <> '' then
      begin
        Result := TdmWinpharmaPHA(PHA).CreerDocument(ADonnees.ChampParNom('TBLN').AsString, ADonnees.ChampParNom('TI').AsString,
          ADonnees.ChampParNom('SKEY').AsString, ADonnees.ChampParNom('TMCREATE').AsString, F);
      end
      else
        Result := rcdErreur;
      // PHA.CreerErreur('Documents TIFF', 'Fichier TIFF inexistant', -1, ieNonBloquant, nil);
    end
    else
      Result := rcdRejetee;
  end
  else if TraitementEnCours.Fichier = C_TRAITEMENT_CODIFICATIONS_PRODUIT then
  begin
    iCodif := 4; // Par défaut, codification libre.....
    bCodifDefaut := False;
    if Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].hasAttribute(C_CFG_CODIFICATION_PRODUIT) then // paramètre présetn dans le XML
    begin
       iCodif := Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes[C_CFG_CODIFICATION_PRODUIT];
       if iCodif = -1  then
       begin
          iCodif := 4; // Présent mais pas initialisé => utiliser défaut.
          bCodifDefaut := true;
       end;
    end
    else bCodifDefaut := True;

    if bCodifDefaut then
         Module.Projet.Console.AjouterLigne(
        '*** AUCUNE codification produit sélectionnée *** Codification "Libre" utilisée par défaut.'
        );
    Result := PHA.ExecuterPS(C_TRAITEMENT_CODIFICATIONS_PRODUIT, TTraitementBD(TraitementEnCours).ProcedureCreation,
      VarArrayOf([ADonnees.ChampParNom('cip').AsInteger, ADonnees.ChampParNom('ti').AsInteger,
        ADonnees.ChampParNom('libelle_n').AsString, ADonnees.ChampParNom('libelle_n1').AsString,
        ADonnees.ChampParNom('libelle_n2').AsString, ADonnees.ChampParNom('libelle_n3').AsString,
        ADonnees.ChampParNom('libelle_n4').AsString,
        iCodif]))
  end
  else
    Result := inherited;
end;

procedure TfrWinpharma.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Hopitaux']);
  TraiterDonnee(Traitements.Traitements['Praticiens']);
end;

procedure TfrWinpharma.TraiterDonneesOrganismes;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Organismes AMO']);
  TraiterDonnee(Traitements.Traitements['Organismes AMC']);
  TraiterDonnee(Traitements.Traitements['Couvertures']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMO']);
  TraiterDonnee(Traitements.Traitements['Couvertures AMC']);
  PHA.ExecuterPS('Destinataire', 'PS_WP_FORCETRANS', null, True, etmCommit);
end;

procedure TfrWinpharma.TraiterDonneesClients;
var
  cf: Integer;

begin
  inherited;

  // Carte de fidélité
  //TODO est ce que ça sert encore ?????????????????????????????????????????????????????????????????????? mis en commentaire pour voir si ça manque :)
  {with dmMIODBCPHA.qryPI do
  begin
    SQL.Clear;
    SQL.Add('select opt4 from system');
    Ouvrir;
    cf := Champs[0].AsInteger;
    Fermer;

    if (cf and $100) = $100 then
      dmPHA.ExecuterPS('CARTEFI', 'PS_WP_CREER_CARTE_FI', null, True, etmCommit);
  end;}

  TraiterDonnee(Traitements.Traitements['Clients Assures']);
  TraiterDonnee(Traitements.Traitements['Clients Beneficiaires']);
  TraiterDonnee(Traitements.Traitements['Clients Comptes']);
  TraiterDonnee(Traitements.Traitements['Clients Comptes adherents']);
  TraiterDonnee(Traitements.Traitements['Commentaires']);
end;

procedure TfrWinpharma.TraiterDonneesProduits;
var
  lBoolPrixDom, lBoolDepot: boolean;
begin
  inherited;

  lBoolPrixDom := strtobool(Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes
      ['options'].Attributes['prixdom']);
  lBoolDepot := strtobool(Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes
      ['options'].Attributes['depot']);

  TraiterDonnee(Traitements.Traitements['Dépots']);
  TraiterDonnee(Traitements.Traitements['Prestations']);
  TraiterDonnee(Traitements.Traitements['Répartiteurs']);
  TraiterDonnee(Traitements.Traitements['Fournisseurs']);
  TraiterDonnee(Traitements.Traitements['Zones géographiques']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Stocks']);
  TraiterDonnee(Traitements.Traitements[C_TRAITEMENT_CODIFICATIONS]);
  TraiterDonnee(Traitements.Traitements[C_TRAITEMENT_CODIFICATIONS_PRODUIT]);
  TraiterDonnee(Traitements.Traitements['Codes LPP']);
  TraiterDonnee(Traitements.Traitements['Codes EAN13']);
  TraiterDonnee(Traitements.Traitements['Historiques ventes']);
  TraiterDonnee(Traitements.Traitements['Catalogues']);

  if lBoolPrixDom then
    PHA.ExecuterPS('Destinataire', 'PS_WP_PRIX_DOM', null, True, etmCommit);
end;

procedure TfrWinpharma.TraiterAutresDonnees;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Historiques délivrances entêtes']);
  TraiterDonnee(Traitements.Traitements['Historiques délivrances lignes']);
  TraiterDonnee(Traitements.Traitements[C_TRAITEMENT_CREDITS]);
  TraiterDonnee(Traitements.Traitements[C_TRAITEMENT_CREDITS_COMPTES]);
  TraiterDonnee(Traitements.Traitements['Commandes']);
  TraiterDonnee(Traitements.Traitements['Commandes lignes']);
  TraiterDonnee(Traitements.Traitements['Commandes lignes groupe']);
  TraiterDonnee(Traitements.Traitements['Programmes Avantages']);
  TraiterDonnee(Traitements.Traitements['Cartes Programme Relationnel']);
end;

procedure TfrWinpharma.TraiterDonneesEncours;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Opérateurs']);
  TraiterDonnee(Traitements.Traitements['Vignettes Avancées']);
  TraiterDonnee(Traitements.Traitements['Factures en attente']);
  TraiterDonnee(Traitements.Traitements['Factures en attente lignes']);
  Traitements.Traitements['Produits dus'].Fait := True;
  Module.Projet.Console.AjouterLigne('*** la reprise des produits dus doit se faire manuellement');
end;

function TfrWinpharma.TraiterDonneesCredits(aCredit: TCredit): TResultatCreationDonnees;
var
  dMontant: Double;
begin
  try
    // Si c'est bien un CREDIT contient "Diff"
    if (( aCredit.montantDu <> 0 ) and (pos('Diff',aCredit.impaye ) > 0)) or (( aCredit.montantDu <> 0 ) and (pos('EC',aCredit.impaye ) > 0)) then
    begin
      dMontant := aCredit.montantDu;
      Result := PHA.ExecuterPS(C_TRAITEMENT_CREDITS, 'ps_wp_credit2',
        VarArrayOf([aCredit.dateCredit, aCredit.noFact, dMontant, aCredit.client, aCredit.beneficiaire]));
    end
    else
    begin
      result := rcdErreur;  // ligne filtrée
    end;
  except
    on E: Exception do
    begin
      (*
        A affiner.
        La lecture du fichier TXT renvoit une exception sur la dernière ligne du fichier.
        *)
      Result := rcdImportee;
    end;
  end;
end;

function TfrWinpharma.RenvoyerClasseTraitement: TClasseTraitement;
begin
  Result := TTraitementWinpharma;
end;

procedure TfrWinpharma.TraiterCredits(ATraitement: TTraitement);
var
  FichierCredits: tFichierCredits;
  fCredits: TCredit;
  i: Integer;
begin
  FichierCredits := tFichierCredits.Create(Module.Projet.RepertoireProjet + ATraitement.Fichier);
  i := 0;
  TraitementEnCours := ATraitement;
  TraitementEnCours.Fait := False;
  while not FichierCredits.Eof do
  begin
    inc(i);
    fCredits := FichierCredits.ReadCredit;
    if fCredits <> nil  then
    begin
      FResultat := TraiterDonneesCredits(fCredits);
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

      if i mod 20000 = 0 then
        PHA.DePreparerCreationDonnees(True);
    end;
  end;
  PHA.DePreparerCreationDonnees(FResultat <> rcdErreurSysteme);

  if Assigned(TraitementEnCours) then
    TraitementEnCours.Fait := (FResultat <> rcdErreurSysteme) and not Annulation;

  FichierCredits.Free;
end;

procedure TfrWinpharma.TraiterDonnee(ATraitement: TTraitement);
const
  C_TYPE_SCANS_AM = 1;
  C_TYPE_SCANS_ORDONNANCE = 6;
  C_TYPE_SCANS_FOURNISSEURS = 20;
  C_TYPE_SCANS_BL = 21;
var
  lStrSQL: string;
  s: string;
  p, i, F: Integer;
  bGestionStock: boolean;
  bAnnuler: boolean;
  totalCount: Integer;
  processedCount: Integer;
  currentCount: Integer;

  procedure AjouterWhere(AWhere: string; ASQL: TStrings);
  var
    s: string;
  begin
    s := ASQL.GetText;
    p := Pos('where', s);
    if ((p = 1) and (CharInSet(s[p + 5], [#32, #13]))) or 
       ((p > 1) and (CharInSet(s[p - 1], [#32, #10])) and (CharInSet(s[p + 5], [#32, #13]))) then
      ASQL.Add('and ')
    else
      ASQL.Add('where ');
    ASQL.Add(AWhere);
  end;

begin
  if Pos('.TXT', uppercase(ATraitement.Fichier)) > 0 then
  begin
    if fileexists(Module.Projet.RepertoireProjet + ATraitement.Fichier) then
      TraiterCredits(ATraitement)
    else
      Module.Projet.Console.AjouterLigne('Fichier '+ ATraitement.Fichier+' non trouvé. Traitement automatique poursuivi');
  end
  else
  begin
    lStrSQL := Module.RepertoireRessources + '\' + TTraitementBD(ATraitement).RequeteSelection;
    lStrSQL := ExtractFilePath(lStrSQL) + PathExtractFileNameNoExt(lStrSQL);

    bGestionStock := False;

    if Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].HasAttribute('gestionstock') then
      bGestionStock := strtobool(Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes['gestionstock']);

    if Pos('PRODUITS', uppercase(ATraitement.Fichier)) > 0 then
    begin
      if bGestionStock then
      begin
        lStrSQL := lStrSQL + '_PGS';
        Module.Projet.Console.AjouterLigne(
          'Option ''Pas de gestion de stock'' sélectionnée. Ne pas oublier d''effectuer une purge des produits AVANT le TRANSFERT');
      end;
      dmMIODBCPHA.qryPI.SQL.LoadFromFile(lStrSQL + '.sql');
    end;

    if TTraitementWinpharma(ATraitement).ChampFacteurDecoupage <> '' then
    begin
      F := Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes['facteur_decoupage'];
      
      // Décompte initial avant découpage
      dmMIODBCPHA.qryPI.SQL.LoadFromFile(lStrSQL + '.sql');
      totalCount := 0;
      try
        dmMIODBCPHA.qryPI.Preparer;
        dmMIODBCPHA.qryPI.Ouvrir;
        while not dmMIODBCPHA.qryPI.EOF do
        begin
          Inc(totalCount);
          dmMIODBCPHA.qryPI.Suivant;
        end;
        dmMIODBCPHA.qryPI.Fermer;
        dmMIODBCPHA.qryPI.DePreparer;
      except
        on E: Exception do
        begin
          Module.Projet.Console.AjouterLigne('Erreur dans le décompte total : ' + E.Message);
          totalCount := -1;
        end;
      end;
      processedCount := 0;
    end
    else
      F := 1;

    bAnnuler := False;
    if not bAnnuler then
    begin
      for i := 1 to F do
      begin
        dmMIODBCPHA.qryPI.SQL.LoadFromFile(lStrSQL + '.sql');
        
        if TTraitementWinpharma(ATraitement).ChampFacteurDecoupage <> '' then
        begin
          s := dmMIODBCPHA.qryPI.SQL.Text;
          AjouterWhere(TTraitementWinpharma(ATraitement).ChampFacteurDecoupage + '%' + IntToStr(F) + ' = ' + IntToStr(i - 1),
            dmMIODBCPHA.qryPI.SQL);
            
          // Décompte des enregistrements dans la partition
          currentCount := 0;
          try
            dmMIODBCPHA.qryPI.Preparer;
            dmMIODBCPHA.qryPI.Ouvrir;
            while not dmMIODBCPHA.qryPI.EOF do
            begin
              Inc(currentCount);
              dmMIODBCPHA.qryPI.Suivant;
            end;
            dmMIODBCPHA.qryPI.Fermer;
            dmMIODBCPHA.qryPI.DePreparer;
            
            Inc(processedCount, currentCount);
          except
            on E: Exception do
              Module.Projet.Console.AjouterLigne('Erreur dans le décompte de la partition ' + IntToStr(i) + ': ' + E.Message);
          end;
          
          dmMIODBCPHA.qryPI.SQL.LoadFromFile(lStrSQL + '.sql');
          AjouterWhere(TTraitementWinpharma(ATraitement).ChampFacteurDecoupage + '%' + IntToStr(F) + ' = ' + IntToStr(i - 1),
            dmMIODBCPHA.qryPI.SQL);
        end;


        if (ATraitement.Fichier = C_TRAITEMENT_DOCUMENTS_TIFF) then
        with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'] do
        begin
          // Type d'import
          s := '';
          if strtobool(Attributes[C_CFG_SCANS_AM]) then
            s := s + IntToStr(C_TYPE_SCANS_AM) + ', ';
          if strtobool(Attributes[C_CFG_SCANS_ORDONNANCES]) then
            s := s + IntToStr(C_TYPE_SCANS_ORDONNANCE) + ', ';
          if strtobool(Attributes[C_CFG_SCANS_FOURNISSEURS]) then
            s := s + IntToStr(C_TYPE_SCANS_FOURNISSEURS) + ', ';
          if strtobool(Attributes[C_CFG_SCANS_BL]) then
            s := s + IntToStr(C_TYPE_SCANS_BL) + ', ';
          Delete(s, Length(s) - 1, 2);
          if s <> '' then
            AjouterWhere('i.tbln in (' + s + ')', dmMIODBCPHA.qryPI.SQL);
          if s <> '' then
            dmMIODBCPHA.qryPI.SQL.Add('order by i.tmCreate desc');
        end;

        inherited TraiterDonnee(ATraitement);
      end;

      // Vérifier le décompte total
      if (TTraitementWinpharma(ATraitement).ChampFacteurDecoupage <> '') and 
         (totalCount > 0) and 
         (processedCount <> totalCount) then
      begin
        Module.Projet.Console.AjouterLigne(Format(
          'Attention : nombre de lignes différent dans %s. Attendu : %d, Total : %d', 
          [ATraitement.Fichier, totalCount, processedCount]));
      end;
    end;
  end;
end;

procedure TfrWinpharma.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('bd') = -1 then
    PHA.ParametresConnexion.Add('bd=');
  if PHA.ParametresConnexion.IndexOfName('utilisateur') = -1 then
    PHA.ParametresConnexion.Add('utilisateur=');
  if PHA.ParametresConnexion.IndexOfName('mot_de_passe') = -1 then
    PHA.ParametresConnexion.Add('mot_de_passe=');
  if PHA.ParametresConnexion.IndexOfName('cheminBLOB') = -1 then
    PHA.ParametresConnexion.Add('cheminBLOB=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('bd') then
      PHA.ParametresConnexion.Values['bd'] := Attributes['bd']
    else
      PHA.ParametresConnexion.Values['bd'] := 'WP17';
    if HasAttribute('utilisateur') then
      PHA.ParametresConnexion.Values['utilisateur'] := Attributes['utilisateur']
    else
      PHA.ParametresConnexion.Values['utilisateur'] := 'Admin';
    if HasAttribute('mot_de_passe') then
      PHA.ParametresConnexion.Values['mot_de_passe'] := Attributes['mot_de_passe']
    else
      PHA.ParametresConnexion.Values['mot_de_passe'] := '';
    if HasAttribute('cheminBLOB') then
      PHA.ParametresConnexion.Values['cheminBLOB'] := Attributes['cheminBLOB']
    else
      PHA.ParametresConnexion.Values['cheminBLOB'] := 'c:\WPHARMA';
  end;
end;

procedure TfrWinpharma.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
    Attributes['cheminBLOB'] := PHA.ParametresConnexion.Values['cheminBLOB'];
  end;
end;

constructor TfrWinpharma.Create(AOwner: TComponent; AModule: TModule);
begin
  ModeConnexion := mcServeurSQL;
  FInterfaceConnexion := TfrmWinPharmaConnexionServeur;

  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;
  { // si on teste hasattributes ici cela créé le noeud "options" et la fenetre de config ne s'ouvre par défaut que si le noeuf n'existe pas
  if Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].HasAttribute
    ('gestionstock') then
    if strtobool(Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options']
        .Attributes['gestionstock']) then
      Module.Projet.Console.AjouterLigne(
        '!! Option ''Pas de gestion de stock'' sélectionnée. Ne pas oublier d''effectuer une purge des produits AVANT le TRANSFERT'
        );

  if not Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].HasAttribute
    (C_CFG_CODIFICATION_PRODUIT) then
    Module.Projet.Console.AjouterLigne(
        '!! Option '' AUCUNE codification produit sélectionnée.  "Codification Libre" utilisée par défaut'
        )
  else
    if Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['options'].Attributes
    [C_CFG_CODIFICATION_PRODUIT] = -1 then
    Module.Projet.Console.AjouterLigne(
        '!! Option '' AUCUNE codification produit sélectionnée.  Veuillez spécifier une codification dans les Options.'
        );

       }


  FBLOBBINS := TDictionary<Char, TJclFileStream>.Create;
end;

destructor TfrWinpharma.Destroy;
begin
  if Assigned(FBLOBBINS) then
    FreeAndNil(FBLOBBINS);

  inherited;
end;

function TfrWinpharma.ExtraireDocumentTIFF(AID: Integer; AOffset, ATaille: DWORD): string;
const
  C_FICHIER_BLOB = 'BLOBBIN';
  C_LONGUEUR_ENTETE = 28;
  C_ENTETE = $624C6250;

type
  TEntete = record
    debut_1: DWORD;
    numero_blob: DWORD;
    taille_blob: DWORD;
    filler: array [0 .. 11] of Byte;
    debut_2: DWORD;
  end;

var
  chLettreFichier: Char;
  F: TJclFileStream;
  b: TEntete;
  doc: TFileStream;
  strFichier: string;
  rep_blob: string;

  procedure ChangerFichier;
  begin
    if (chLettreFichier <> ' ') then
      repeat
        inc(chLettreFichier);
        if (chLettreFichier = 'Z') then
          chLettreFichier := ' ';
      until FileExists( { Module.Projet.RepertoireProjet + } rep_blob + C_FICHIER_BLOB + chLettreFichier + '.MB')
        else chLettreFichier := 'I';

      if (chLettreFichier <> ' ') then
      begin
        if not FBLOBBINS.TryGetValue(chLettreFichier, F) then
      //  begin
         // if chLettreFichier <> 'L' then      // pourquoi L ?????
          begin
            FBLOBBINS.Add(chLettreFichier, TJclFileStream.Create(
                { Module.Projet.RepertoireProjet + } rep_blob + C_FICHIER_BLOB + chLettreFichier + '.MB', fmOpenRead+fmShareDenyNone));
            F := FBLOBBINS.Items[chLettreFichier];
          end;
      //  end
      end
      else
        F := nil;
  end;

begin
  rep_blob := IncludeTrailingPathDelimiter(PHA.ParametresConnexion.Values['cheminBLOB']) + 'DB\';
  if (ATaille > 0) then
    try
      chLettreFichier := ' ';
      ChangerFichier;
      while Assigned(F) and (Result = '') do
      begin
        if Assigned(F) then
        begin

          F.Seek(AOffset, soBeginning);
          F.Read(b, C_LONGUEUR_ENTETE);

          if (b.taille_blob > 0) and (b.taille_blob = (DWORD(ATaille) div 100)) then
          begin
            strFichier := Module.Projet.RepertoireProjet + 'blob\' + IntToStr(AID) + '.tiff';
            if FileExists(strFichier) then
              DeleteFile(strFichier);
            doc := TFileStream.Create(strFichier, fmCreate);
            doc.CopyFrom(F, b.taille_blob);
            Result := doc.FileName;
            doc.Free;
          end
          else
          begin
            // Module.Projet.Console.AjouterLigne( ' probleme extraction tif BLOBBINJ.MB, ID :'+IntToStr(AID)+' offset:['+IntToStr(AOffset)+'] taille :['+ IntToStr(ATaille)+'] taille entete : '+IntToStr(b.taille_blob)  );
            ChangerFichier;
          end;
        end;
      end;
    except
      on E: EJclStreamError do
        Module.Projet.Console.AjouterLigne(E.Message + E.StackTrace + ' : BLOBBIN' + chLettreFichier + '.MB, [offset:' + IntToStr
            (AOffset) + '] [taille:' + IntToStr(ATaille) + ']')
    end
  else
    Result := '';
end;

{ TdmWinpharmaPHA }

function TdmWinpharmaPHA.RenvoyerChaineConnexion: string;
begin
  Result := ParametresConnexion.Values['utilisateur'] + '@' + ParametresConnexion.Values['bd'];
end;

procedure TdmWinpharmaPHA.SupprimerDonnees(ADonneesASupprimer: TList<Integer>);
begin
  if ADonneesASupprimer.IndexOf(Ord(suppProduits)) <> -1 then
    ADonneesASupprimer.Add(101);
  if ADonneesASupprimer.IndexOf(Ord(suppClients)) <> -1 then
    ADonneesASupprimer.Add(Ord(suppCarteFidelite)); ;//on laisse cartefidelité ici parce que ça vient de projet
  if ADonneesASupprimer.IndexOf(Ord(suppHistoriques)) <> -1 then   // pour suppr les credits
    ADonneesASupprimer.Add(102);
  inherited;
end;

procedure TdmWinpharmaPHA.ConnexionBD;
var
  d: string;
begin
  inherited;

  d := Module.Projet.RepertoireApplication + '\WPODBC3.DLL';
  ShellExec(0, 'open', Module.Projet.RepertoireApplication + '\Outils\install_odbc.exe',
    '-install nom=winpharma driver="' + d + '" setup="' + d + '"', 'apilevel=2;sqllevel=1', SW_NORMAL);

  TPIODBCConnexion(dbPI).ChaineConnexion := Format(C_CHAINE_CONNEXION_WINPHARMA, [ParametresConnexion.Values['bd'],
    ParametresConnexion.Values['utilisateur'], ParametresConnexion.Values['mot_de_passe']]);
  try
   TPIODBCConnexion(dbPI).Connected := True;
  except

  end;
end;

{ TTraitementWinpharma }

procedure TTraitementWinpharma.CompleterTraitement(F: TSQLResult);
begin
  ChampFacteurDecoupage := F.ByNameAsString['CHAMP_FACTEUR_DECOUPAGE'];
end;

function TdmWinpharmaPHA.CreerDocument(ATypeID, AID1, AID2, ADateModification, AFichier: string): TResultatCreationDonnees;
begin
  Result := ExecuterPS(C_TRAITEMENT_DOCUMENTS_TIFF, 'PS_WP_CREER_DOCUMENT',
    VarArrayOf([ATypeID, AID1, AID2, ADateModification, AFichier]));
end;

initialization

RegisterClasses([TfrWinpharma, TdmWinpharmaPHA, TfrWinPharmaConfiguration]);

finalization

unRegisterClasses([TfrWinpharma, TdmWinpharmaPHA, TfrWinPharmaConfiguration]);

end.
