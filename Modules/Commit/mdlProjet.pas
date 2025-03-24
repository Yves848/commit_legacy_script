unit mdlProjet;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Controls, Forms, Menus, IniFiles, ComCtrls,
  Registry, StrUtils, mdlInformationFichier, Graphics, Contnrs, mdlLectureFichierBinaire,
  DB,  mdlAttente, XMLDoc, mdlConsole, XMLIntf, Variants, UIB, UIBLib, mdlUIBThread,
  UIBSQLParser, JclPeImage, XMLDom;

type

  tConsoleToDB = procedure(sMessage : String;const bVisual:Boolean=true) of Object;
  // Pré-déclaration
  TProjet = class;

  // Type
  TConversion = (cnvOrganismesAMO, cnvOrganismesAMC, cvnCouverturesAMO, cnvCouverturesAMC, cnvComptes, cnvMaterielsLocation);
  TConversions = set of TConversion;

  TSuppression = (suppParametre, suppPraticiens, suppOrganismes, suppClients, suppProduits, suppEnCours, suppCarteFidelite, suppLocation, suppHistoriques);
  TSuppressions = set of TSuppression;

  TResultatCreationDonnees = (rcdImportee, rcdTransferee, rcdAvertissement, rcdRejetee, rcdErreur, rcdErreurSysteme);
  TTypeModule = (tmCommit, tmImport, tmTransfert, tmOutils);
  TLibelleTypeModule = array[TTypeModule] of string;
  TImportanceErreur = (ieNonBloquant, ieBloquant, ieCritique);

  // Evénements
  TConversionEvent = procedure(Sender  : TObject; ADonnee : TConversion; AParams : Pointer;
                                 var AAccept : Boolean) of object;

  // Exception
  EModule = class(Exception);
  EProjet = class(Exception);
  TVersionObject = class(tObject)
    public
      pays: String;
      version : String;
      constructor create(pPays, pVersion : string);
  end;
  TModule = class
  private
    FHandle: HModule;
    FNomModule: string;
    FTypeModule: TTypeModule;
    FFichier : string;
    FProjet: TProjet;
    FCharge: Boolean;
    FIHM: TComponent;
    FRepertoireRessources: string;
    FPays: string;
    FVersion: string;
    FDerniereModification: TDateTime;
    FDescription: string;
    procedure SetCharge(const Value: Boolean);
  protected
    FLogo: TBitmap;
    FIcone: TIcon;
    property Fichier : string read FFichier;
  public
    const LibelleTypeModule : TLibelleTypeModule = ('', 'Import', 'Transfert', 'Outils');
    property Charge : Boolean read FCharge write SetCharge;
    property TypeModule : TTypeModule read FTypeModule;
    property NomModule : string read FNomModule;
    property Description : string read FDescription;
    property Version : string read FVersion;
    property DerniereModification : TDateTime read FDerniereModification;
    property Pays : string read FPays;
    property Handle : HModule read FHandle;
    property Projet : TProjet read FProjet;
    property IHM : TComponent read FIHM;
    property Logo : TBitmap read FLogo write FLogo;
    property Icone : TIcon read FIcone write FIcone;
    property RepertoireRessources : string read FRepertoireRessources write FRepertoireRessources;
    constructor Create(AProjet : TProjet; ANomModule : string; ATypeModule : TTypeModule); virtual;
    destructor Destroy; override;
    procedure ChargerModule; virtual;
    procedure DeChargerModule; virtual;
    procedure MergeMenuPrincipale(AParentItem : TMenuItem; AMenu : TMenuItem);
    procedure DeMergeMenuPrincipale;
  end;
  TModuleClasse = class of TModule;

  TProjet = class
  private
    FPHAConnexion: TUIBDatabase;
    FPHATransaction : TUIBTransaction;
    FRepertoireProjet: string;
    FRepertoireApplication: string;
    FModules : TObjectList;
    FModuleImport: TModule;
    FModuleEnCours: TModule;
    FModuleTransfert: TModule;
    FFichierProjet: TXMLDocument;
    FOuvert: Boolean;
    FConsole: TConsole;
    FThread: Boolean;
    FERPConnexion: TComponent;
    FFichierParametres: TXMLDocument;
    FListePays: TStringList;
    FVersionsKit: TStringList;
    FInstructionSQL : string;
    FTrucsAstuces: TStringList;
    FValidVersions : TStringList;
    FMinimize : Boolean;
    qConsole : TUIBQuery;
    procedure RenvoieModules(ATypeModule : TTypeModule; var AListe : TObjectList);
    function GetModule(IdxType : TTypeModule; IdxNom : string): TModule;
    function GetModuleParIndex(Index : Integer) : TModule;
    function GetTotalModules: Integer;
    procedure SetModuleEnCours(AValue : TModule);
    procedure ScriptOnParse(Sender: TObject; NodeType: TSQLStatement;
      const Statement: string);
  public
    property Console : TConsole read FConsole;
    property Thread : Boolean read FThread write FThread;
    property Ouvert : Boolean read FOuvert;
    property Minimize : Boolean read FMinimize write FMinimize;
    property FichierProjet : TXMLDocument read FFichierProjet;
    property FichierParametres : TXMLDocument read FFichierParametres;
    property RepertoireApplication : string read FRepertoireApplication;
    property ModuleEnCours : TModule read FModuleEnCours write SetModuleEnCours;
    property RepertoireProjet : string read FRepertoireProjet;
    property PHAConnexion : TUIBDatabase read FPHAConnexion;
    property ERPConnexion : TComponent read FERPConnexion write FERPConnexion;
    property ModuleImport : TModule read FModuleImport;
    property Modules[IdxType : TTypeModule; IdxNom : string] : TModule read GetModule;
    property ModulesParIndex[Index : Integer] : TModule read GetModuleParIndex;
    property ListePays : TStringList read FListePays;
    property VersionsKit : TStringList read FVersionsKit;
    property TotalModules : Integer read GetTotalModules;
    property ModuleTransfert : TModule read FModuleTransfert;
    property TrucsAstuces : TStringList read FTrucsAstuces;
    property ValidVersions : TStringList read FValidVersions;

    constructor Create(AConnexionLocal : Boolean = True);
    destructor Destroy; override;
    procedure CreerPHA(ANomModulesImport : array of string; ANomModuleTransfert : string;
      APays : string);
    procedure ConnecterPHA(AUtilisateur, AMotdePasse : string);
    procedure DeConnecterPHA;
    procedure CreerProjet(ANomProjet : string; AModuleImport : TModule;
      AModuleTransfert : TModule; APays : string);
    procedure OuvrirProjet(ANomProjet : string);
    procedure FermerProjet;
    procedure AfficherErreurs(ATypeModule : TTypeModule = tmCommit; AFichier : string = '');
    procedure RenvoyerListePays;
    procedure RenvoyerListeVersions;
    procedure RafraichirModules;
    procedure Console2DB(sMessage : String;const bVisual:Boolean=true);
//    property OnApresOuvertureProjet : TNotifyEvent read FOnApresOuvertureProjet write FOnApresOuvertureProjet;}
  end;

implementation

uses mdlPHA, mdlModule, mdlModuleOutils, mdlErreurs, mdlConfiguration;

{ TModule }

procedure TModule.MergeMenuPrincipale(AParentItem : TMenuItem; AMenu : TMenuItem);
var
  i : Integer;
  lItem : TMenuItem;
begin
  if not Assigned(AParentItem) then
    AParentItem := Application.MainForm.Menu.Items;

  for i := 0 to AMenu.Count - 1 do
  begin
    lItem := Application.MainForm.Menu.Items.Find(AMenu[i].Caption);
    if not Assigned(lItem) then
    begin
      lItem := TMenuItem.Create(Application);
      if Assigned(AMenu[i].Action) then
        lItem.Action := AMenu[i].Action
      else
      begin
        lItem.Caption := AMenu[i].Caption;
        lItem.Checked := AMenu[i].Checked;
        lItem.Enabled := AMenu[i].Enabled;
        lItem.GroupIndex := AMenu[i].GroupIndex;
        lItem.RadioItem := AMenu[i].RadioItem;
        lItem.ShortCut := AMenu[i].ShortCut;
        lItem.Tag := 1;
        lItem.Visible := AMenu[i].Visible;

        lItem.OnClick := AMenu[i].OnClick;
      end;
      AParentItem.Add(lItem);
    end;

    if AMenu[i].Count > 0 then
      MergeMenuPrincipale(lItem, AMenu[i]);
  end;
end;

procedure TModule.ChargerModule;
var
  lClasse : TClass;
begin
  // Déchargement du paquet si existant
  if FHandle <> 0 then
    DeChargerModule;

  try
    FHandle := LoadPackage(Projet.RepertoireApplication + '\Modules\' + LibelleTypeModule[FTypeModule] + '\' + FNomModule + '.bpl');
    if FHandle = 0 then
      raise EPackageError.Create('Impossible de charger le module ' + FNomModule + ' (' + IntToStr(GetLastError) + ') !')
    else
    begin
      case FTypeModule of
        tmImport, tmTransfert :
          begin
            // Chargement de la Frame "Tfr..."
            lClasse := GetClass('Tfr' + FNomModule);
            if Assigned(lClasse) then
            begin
              FIHM := TfrModuleClasse(lClasse).Create(Application, Self);
              if FIHM is TfrModule then
              begin
                TfrModule(FIHM).Minimize := FProjet.Minimize;
                TfrModule(FIHM).InitialisationAffichage;
                MergeMenuPrincipale(nil, TfrModule(FIHM).mnuMenuPrincipale.Items);
              end
              else
                raise EModule.Create('Classe Tfr ' + FNomModule + ' de type incorrecte !');
            end
            else
              raise EModule.Create('Classe Tfr' + FNomModule + ' introuvable !');
          end;

        tmOutils :
          begin
            // Chargement de la Frame "Tdm..."
            lClasse := GetClass('Tdm' + FNomModule);
            if Assigned(lClasse) then
            begin
               FIHM := TdmModuleOutilsClasse(lClasse).Create(Application, FProjet) as TDataModule;
              if FIHM is TdmModuleOutils then
                MergeMenuPrincipale(nil, TdmModuleOutils(FIHM).mnuMenuPrincipale.Items)
              else
                EModule.Create('Classe Tdm ' + FNomModule + ' de type incorrecte !');
            end
            else
              raise EModule.Create('Classe Tdm' + FNomModule + ' introuvable !');
          end;
      end;

      FCharge := True;
    end;
  except
    on E:Exception do
    begin
      FProjet.Console.AjouterLigne(E.Message);
      DeChargerModule;

      FCharge := False;
    end;
  end;
end;

//* ************************************************************************** *
constructor TModule.Create(AProjet : TProjet; ANomModule: string; ATypeModule: TTypeModule);
var
  lStrSuffixeRep : string;
  lInfo : TJclPeImage;
begin
  if ANomModule = ''  then raise EModule.Create('Nom de module incorrecte !');
  if not Assigned(AProjet) then raise EModule.Create('Gestionnaire de projet inexistant !');

  FProjet := AProjet;
  FTypeModule := ATypeModule;
  FNomModule := ANomModule;
  case FTypeModule of
    tmImport : lStrSuffixeRep := '\Modules\Import\';
    tmTransfert : lStrSuffixeRep := '\Modules\Transfert\';
    tmOutils : lStrSuffixeRep := '\Modules\Outils\' ;
  end;
  FFichier := FProjet.RepertoireApplication + lStrSuffixeRep + FNomModule + '.bpl';
  FRepertoireRessources := FProjet.RepertoireApplication + lStrSuffixeRep + 'Ressources\' + FNomModule;

  // Lecture information BPL
  lInfo := TJclPeImage.Create;
  lInfo.FileName := FFichier;
  FDescription := lInfo.VersionInfo.FileDescription;
  FVersion := lInfo.VersionInfo.FileVersion;
  FDerniereModification := lInfo.FileProperties.LastWriteTime;
  FPays := lInfo.VersionInfo.Items.Values['Pays'];
  FreeAndNil(lInfo);

  FLogo := TBitmap.Create;
  FIcone := TIcon.Create;
  FCharge := False;
end;

//* ************************************************************************** *
procedure TModule.DeChargerModule;
begin
  if Assigned(FIHM) and not Application.Terminated then
  begin
    DeMergeMenuPrincipale;
    try
      FreeAndNil(FIHM);
    except
      on EAccessViolation do
        //
    end;
  end;

  if FHandle <> 0 then
  begin
    UnloadPackage(FHandle);
    FHandle := 0;
  end;

  FCharge := False;
end;

//* ************************************************************************** *
destructor TModule.Destroy;
begin
  if Assigned(FIcone) then FreeAndNil(FIcone);
  if Assigned(FLogo) then FreeAndNil(FLogo);

  DeChargerModule;

  inherited;
end;

//* ************************************************************************** *
procedure TModule.SetCharge(const Value: Boolean);
begin
  if FCharge <> Value then
    if Value then
      ChargerModule
    else
      DeChargerModule;
end;

procedure TModule.DeMergeMenuPrincipale;
var
  i, j : Integer;
begin
  if Assigned(Application.MainForm.Menu) then
    with Application.MainForm.Menu do
    begin
      i := 0;
      while i < Items.Count  do
      begin
        j := 0;
        while j < Items[i].Count do
          if Items[i][j].Tag = 1 then
            Items[i][j].Free
          else
            Inc(j);

        if Items[i].Tag = 1 then
          Items[i].Free
        else
          Inc(i);
      end;
    end;
end;

{ TProjet }

procedure TProjet.AfficherErreurs(ATypeModule : TTypeModule = tmCommit; AFichier : string = '');
begin
  TfrmErreurs.Create(Application.MainForm, Self.ModuleEnCours).ShowModal(ATypeModule, AFichier);
end;

procedure TProjet.ConnecterPHA(AUtilisateur, AMotdePasse: string);
begin
  if Assigned(FPHAConnexion) then
    with FPHAConnexion do
    begin
      UserName := AUtilisateur;
      PassWord := AMotdePasse;
      CharacterSet := csUTF8;

      Connected := True;
    end
  else
    raise EProjet.Create('Instance de TUIBDatabase introuvable !');
end;

procedure TProjet.Console2DB(sMessage: String; const bVisual:Boolean=true);
const
  sInsert = 'insert into T_FCT_CONSOLE (t_FCT_CONSOLE_ID,DATE_CONSOLE,MSG,VISUEL) Values (gen_id(seq_fct_console, 1),''%s'',''%s'',''%s'')';
var
  sSQL : String;
  stemp : string;
  sVisuel : String;
begin
   // Ecriture de la console dans la table t_fct_console de la base locale
   try
     sVisuel := '1';
     (*
       Si bVisual est passé à False, la fonction écrira un "0" dans la colonne 'VISUEL'.
       Ca permettra de placer des logs "invisible" sans passer par la console.
     *)
     if not bVisual then sVisuel := '0';

     stemp := StringReplace(sMessage,chr(39),' ',[rfReplaceAll]); // Suppression des simple quotes
     stemp := StringReplace(sTemp,chr(34),' ',[rfReplaceAll]); // Suppression des doubles quotes
     stemp := StringReplace(sTemp,chr(10),' ',[rfReplaceAll]); // Suppression des LF
     stemp := StringReplace(sTemp,chr(13),' ',[rfReplaceAll]); // Suppression des CR
     sSQL := format(sInsert,[datetimetostr(Now),sTemp,sVisuel]);
     qConsole.SQL.Text := sSQL;
     qConsole.ExecSQL;
     qConsole.Transaction.CommitRetaining;
   except on e : Exception do
       // Je laisse lexception silencieuse.
       // Dans tous les cas, ce sera écrit dans la console.
   end;

end;

constructor TProjet.Create(AConnexionLocal : Boolean = True);
var
  lProcessus : TStrings;
  i: Integer;
  f, s: string;
begin
  FRepertoireApplication := ExtractFileDir(ParamStr(0));
  f := FRepertoireApplication + '\commit.xml';
  if not FileExists(f) then
    raise EProjet.Create('Impossible de démarrer COMMIT, fichier de configuration manquant !')
  else
  begin
    FOuvert := False;
    FThread := True;

    // Lecture des parametres
    FFichierParametres := TXMLDocument.Create(Application);
    FFichierParametres.FileName := f;
    FFichierParametres.Active := True;
  //  FFichierParametres.NodeIndentStr := '      ';
  //  FFichierParametres.Options := FFichierParametres.Options + [doNodeAutoIndent];
    FFichierParametres.ParseOptions := FFichierParametres.ParseOptions + [poPreserveWhiteSpace];
    FListePays := TStringList.Create;
    FValidVersions := TStringList.Create;
    RenvoyerListePays;
    RenvoyerListeVersions;

    // Préparation connexion à la base locale
    FPHAConnexion := TUIBDatabase.Create(Application);
    with FPHAConnexion do
    begin
      SQLDialect := 3;
      CharacterSet := csUTF8;
      if AConnexionLocal then
        LibraryName  := FRepertoireApplication + '\fbembed.dll'
      else
      begin
        LibraryName := 'fbclient.dll';

        // Vérification du lancement du serveur
        lProcessus := RenvoyerListeProcessus;
        if Pos('FBSERVER.EXE', UpperCase(lProcessus.Text)) = 0 then
          raise EProjet.Create('Serveur Firebird 2.x introuvable !');
      end;

      UserName := 'sysdba';
      PassWord := 'masterkey';
    end;

    FPHATransaction := TUIBTransaction.Create(Application);
    FPHATransaction.DataBase := FPHAConnexion;


    // Affichage console
    qConsole := TUIBQuery.Create(nil);
    qConsole.DataBase := FPHAConnexion;
    qConsole.Transaction := FPHATransaction;
    FConsole := TConsole.Create;
    FConsole.Console2DB := Console2DB;
    s := StringReplace(FFichierParametres.DocumentElement.ChildNodes['Console'].ChildNodes['Message'].NodeValue, '|', Char(13) + Char(10), [rfReplaceAll]) + Chr(13) + Chr(10);
    for i := 0 to FFichierParametres.DocumentElement.ChildNodes['Console'].ChildNodes['Telephones'].ChildNodes.Count - 1 do
      s := s + FFichierParametres.DocumentElement.ChildNodes['Console'].ChildNodes['Telephones'].ChildNodes[i].NodeValue;
    FConsole.InitConsole(FFichierParametres.DocumentElement.ChildNodes['Console'].ChildNodes['Couleur'].NodeValue, s);

    // Recherche des modules
    FModules := TObjectList.Create;
    RafraichirModules;

    FTrucsAstuces := TStringList.Create;
  end;
end;

procedure TProjet.CreerPHA(ANomModulesImport : array of string; ANomModuleTransfert : string;
  APays : string);
var
  lStrPHA : string;
  i : Integer;
  m : TModule;

  function OkPourCreation : Boolean;
  begin
    if FileExists(lStrPHA) then
      if MessageDlg('Une base locale existe déjà. Voulez-vous supprimer la base existante ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Result := DeleteFile(lStrPHA);
        if not Result then
           raise EProjet.Create('Impossible de supprimer PHA.FDB (Erreur n° ' + IntToStr(GetLastError) + ') !');
      end
      else
        Result := True
    else
      Result := True;
  end;

  procedure ExecuterScripts(ARepertoire : string; AFilter : string = '*.sql');
  const
    C_SQL_INSERER_INFO_SCRIPT = '';
    C_INCLUDE_SCRIPT = '@include';
  var
    lScriptSQL : TSearchRec;
    lParametresThreadScriptFB : TParametresThreadScriptFB;
    q : TUIBQuery;
    i, d, f :Integer;
    s : string;
    scr, sl, tmp : TStringList;
  begin
    lParametresThreadScriptFB := TParametresThreadScriptFB.Create(FPHAConnexion);
    if FindFirst(ARepertoire + AFilter, faAnyFile, lScriptSQL) = 0 then
    begin
      q := TUIBQuery.Create(nil);
      q.DataBase := FPHAConnexion;
      q.Transaction := FPHATransaction;
      q.SQL.Add('execute procedure ps_inserer_info_script(:s, :d)');

      scr := TStringList.Create;
      repeat
        // Construction du script
        tmp := TStringList.Create;
        tmp.LoadFromFile(ARepertoire + lScriptSQL.Name, TEncoding.UTF8);

        i := 0; scr.Clear;
        while i < tmp.Count do
        begin
          // Recherche de l'inclusion
          d := Pos(C_INCLUDE_SCRIPT, tmp[i]);
          if (d > 0) then
          begin
            Inc(d, Length(C_INCLUDE_SCRIPT) + 2);
            f := PosEx('>', tmp[i], d);
            if (f > d) then
            begin
              s := Copy(tmp[i], d, f - d);

              // Copie du script inclu
              sl := TStringList.Create;
              sl.LoadFromFile(ARepertoire + s, TEncoding.UTF8);
              scr.AddStrings(sl);
            end
            else
              scr.Add(tmp[i]);
          end
          else
            scr.Add(tmp[i]);

          Inc(i);
        end;

        if FThread then
        begin
          lParametresThreadScriptFB.BD := FPHAConnexion;
          lParametresThreadScriptFB.Script := scr;
          AttendreFinExecution(Application.MainForm, taLibelle, TThreadScriptFB, lParametresThreadScriptFB, 'Exécution du script ' + lScriptSQL.Name)
        end
        else
          with TUIBScript.Create(nil) do
          begin
            try
              OnParse := ScriptOnParse;
              Transaction := FPHATransaction;
              Script.AddStrings(scr);
              ExecuteScript;
              lParametresThreadScriptFB.Erreur.Etat := True;
            except
              on E:EUIBError do
              begin
                lParametresThreadScriptFB.Erreur.Etat := False;
                lParametresThreadScriptFB.Erreur.Message := E.Message;
                lParametresThreadScriptFB.Erreur.Instruction := FInstructionSQL;

                Console.AjouterLigne(E.Message);
              end;
            end;
            Free;
          end;

        if lParametresThreadScriptFB.Erreur.Etat then
        begin
          q.Params.ByNameAsString['s'] := lScriptSQL.Name;
          q.Params.ByNameAsInteger['d'] := lScriptSQL.Time;
          q.Execute;
        end;
      until (FindNext(lScriptSQL) <> 0) or not lParametresThreadScriptFB.Erreur.Etat;
      q.Close(etmCommit);
      FreeAndNil(q);

      with lParametresThreadScriptFB do
        if not Erreur.Etat then
        begin
          FPHAConnexion.Connected := False;
          raise EProjet.Create('Erreur lors de la construction de la base locale !' +
                                 #13#10'Script : ' + lScriptSQL.Name +
                                 #13#10'Erreur : ' + Erreur.Message +
                                 #13#10'Instruction : ' + Erreur.Instruction);
        end;

      FreeAndNil(lParametresThreadScriptFB);
    end;
    FindClose(lScriptSQL);
  end;

begin
  lStrPHA := FRepertoireProjet + '\PHA.FDB';
  if OkPourCreation then
  begin
    // Création de la base
    with FPHAConnexion do
    begin
      DatabaseName := lStrPHA;
      UserName := 'sysdba';
      PassWord := 'masterkey';
      SQLDialect := 3;
      CreateDatabase(csUTF8, 16384);
    end;

    // Script de base
    ExecuterScripts(FRepertoireApplication + '\Scripts\Commun\');
    ExecuterScripts(FRepertoireApplication + '\Scripts\Commun\' + APays + '\');
    for i := 0 to High(ANomModulesImport) do
      ExecuterScripts(FRepertoireApplication + '\Scripts\Modules\Import\', ANomModulesImport[i] + '*.sql');
    ExecuterScripts(FRepertoireApplication + '\Scripts\Modules\');
    ExecuterScripts(FRepertoireApplication + '\Scripts\Modules\Transfert\', ANomModuleTransfert + '*.sql');
    for i := 0 to TotalModules - 1 do
    begin
      m := ModulesParIndex[i];
      if (m.TypeModule = tmOutils) and
         (m.Pays = APays) then
        ExecuterScripts(FRepertoireApplication + '\Scripts\Modules\Outils\', m.NomModule + '*.sql');
    end;
  end;

  if FOuvert then
  begin
    ModuleEnCours := ModuleImport;
    if Assigned(ModuleEnCours) then
      with TfrModule(ModuleEnCours.IHM) do
      begin
        wzDonnees.ActivePage := wipBienvenue;
        wzDonnees.OnActivePageChanged(Self);
      end;

  end;
end;

procedure TProjet.CreerProjet(ANomProjet: string;
  AModuleImport : TModule; AModuleTransfert: TModule; APays : string);

  function OkPourCreation : Boolean;
  begin
    if FileExists(ANomProjet) then
      if MessageDlg('Un fichier projet ayant le même nom existe déjà. Voulez-vous supprimer le projet existant ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        Result := DeleteFile(ANomProjet);
        if not Result then
          raise EProjet.Create('Impossible de supprimer le fichier projet existant (Erreur n° ' + IntToStr(GetLastError) + ') !');
      end
      else
        Result := True
    else
      Result := True;
  end;

begin
  // Création du répertoire
  FRepertoireProjet := ExtractFileDir(ANomProjet);
  if not ForceDirectories(FRepertoireProjet + '\erreurs') or
     not ForceDirectories(FRepertoireProjet + '\rejets') or
     not ForceDirectories(FRepertoireProjet + '\blob')then
    raise EProjet.Create('Création du répertoire d''accueil du projet impossible (' + IntToStr(GetLastError) + ') !');

  // Création de la structure XML
  if OkPOurCreation then
  begin
    FFichierProjet := TXMLDocument.Create(Application);
    FFichierProjet.Active := True;
//    FFichierProjet.NodeIndentStr := '      ';
//    FFichierProjet.Options := FFichierProjet.Options  + [doNodeAutoIndent];
    FFichierProjet.DocumentElement := FFichierProjet.CreateElement('projet', '');
    with FFichierProjet.DocumentElement do
    begin
      with AddChild('informations_generales') do
      begin
        Attributes['pays'] := APays;
        Attributes['date_creation'] := Now;
        Attributes['module_en_cours'] := Ord(tmImport);
        Attributes['page_en_cours'] := 0;
        Attributes['date_conversions'] := '';
      end;

      with AddChild('modules') do
      begin
        with AddChild('import'), AModuleImport do
        begin
          Attributes['nom'] := NomModule;
          Attributes['date'] := DerniereModification;
          Attributes['version'] := Version;
          Attributes['mode'] := 0;
        end;

        with AddChild('transfert'), AModuleTransfert do
        begin
          Attributes['nom'] := NomModule;
          Attributes['date'] := DerniereModification;
          Attributes['version'] := Version;
          Attributes['mode'] := 0;
        end;
      end;
    end;
    FFichierProjet.SaveToFile(ANomProjet);

    // Ajout de la version XML
    with TStringList.Create do
    begin
      Assign(FFichierProjet.XML);
      Insert(0,'<?xml version="1.0" encoding="UTF-8"?>');
      SaveToFile(ANomProjet, TEncoding.UTF8);
      Free;
    end;

    //Création de la base locale
    CreerPHA(AModuleImport.NomModule, AModuleTransfert.NomModule, APays);
  end;
end;

procedure TProjet.DeConnecterPHA;
var
  i : Integer;
begin
  try
    if FPHAConnexion.Connected then
    begin
      for i := 0 to FPHAConnexion.TransactionsCount - 1 do
        if FPHAConnexion.Transactions[i].InTransaction then
          FPHAConnexion.Transactions[i].RollBack;
      FPHAConnexion.Connected := False;
    end;
  except
    on E:Exception do
      MessageDlg(E.Message, mtError, [mbOk], 0);
  end;
end;

destructor TProjet.Destroy;
begin
  if Assigned(FTrucsAstuces) then FreeAndNil(FTrucsAstuces);
  if Assigned(FListePays) then FreeAndNil(FListePays);
  if FOuvert then FermerProjet;
  if Assigned(FConsole) then begin
    qConsole.Free;
    FreeAndNil(FConsole);
  end;
  if Assigned(FModules) then FreeAndNil(FModules);

  inherited;
end;

procedure TProjet.FermerProjet;
var
  i, lIntNbOcc : Integer;
begin
  DeConnecterPHA;
  FTrucsAstuces.Clear;

  if Assigned(ModuleEnCours) then
  begin
    with FFichierProjet.DocumentElement.ChildNodes['informations_generales'] do
    begin
      Attributes['module_en_cours'] := Ord(ModuleEnCours.TypeModule);
      Attributes['page_en_cours'] := TfrModule(ModuleEnCours.IHM).wzDonnees.ActivePageIndex;
    end;
  end;

  lIntNbOcc := TotalModules - 1;
  for i := 0 to lIntNbOcc do
    if ModulesParIndex[i].TypeModule = tmOutils then
      ModulesParIndex[i].DeChargerModule;

  if Assigned(FModuleTransfert) then
  begin
    FModuleTransfert.DeChargerModule;
    FModuleTransfert := nil;
  end;
  if Assigned(FModuleImport) then
  begin
    FModuleImport.DeChargerModule;
    FModuleImport := nil;
  end;

  FFichierProjet.XML.SaveToFile(FFichierProjet.FileName, TEncoding.UTF8);

  FModuleEnCours := nil;
  FOuvert := False;
end;

function TProjet.GetModule(IdxType : TTypeModule; IdxNom : string): TModule;
var
  i : Integer;
begin
  i := 0; Result := nil;
  while (i < FModules.Count) and not Assigned(Result) do
    with TModule(FModules[i]) do
      if (TypeModule = IdxType) and (LowerCase(NomModule) = LowerCase(IdxNom)) then
        Result := TModule(FModules[i])
      else
        Inc(i);

end;

function TProjet.GetModuleParIndex(Index : Integer) : TModule;
begin
  Result := TModule(FModules[Index]);
end;

function TProjet.GetTotalModules: Integer;
begin
  Result := FModules.Count;
end;

procedure TProjet.OuvrirProjet(ANomProjet: string);
var
  i, lIntNbOcc : Integer;
  lBoolChargementMdlOutils : Boolean;
  lStrVerImport, lStrVerTransfert : string;
  m : TModule;
  s : string;

  function ChargerModule(ATypeModule : TTypeModule; ANomModule : string) : TModule;
  begin
    Result := TModule(Modules[ATypeModule, ANomModule]);

    if Assigned(Result) then
      Result.ChargerModule
    else
      FConsole.AjouterLigne('Module ' + ANomModule + ' introuvable !');
  end;

  function VerifierMAJScripts(ARepertoire : string; AFilter : string = '*.sql') : Boolean; overload;
  var
    r : TSearchRec;
    q : TUIBQuery;
  begin
    Result := True;
    if FindFirst(ARepertoire + AFilter, faAnyFile, r) = 0 then
    begin
      q := TUIBQuery.Create(nil);
      q.DataBase := FPHAConnexion;
      q.Transaction := FPHATransaction;
      q.BuildStoredProc('PS_RENVOYER_DATE_MAJ_SCRIPT');
        q.Prepare;

      repeat
        q.Params.ByNameAsString['ANomScript'] := r.Name;
        q.Open;
        Result := (q.Fields.ByNameAsInteger['ADateHeure'] = r.Time) and (q.Fields.ByNameAsInteger['ADateHeure'] > 0);
      until (FindNext(r) <> 0) or not Result;
      q.Close(etmCommit);
      FindClose(r);
      FreeAndNil(q);
    end;
  end;

  function VerifierMAJScripts : Boolean; overload;
  begin
    with FFichierProjet.DocumentElement do
    begin
      Result := VerifierMAJScripts(FRepertoireApplication + '\Scripts\Commun\' + ChildNodes['informations_generales'].Attributes['pays']);
      with ChildNodes['modules'] do
      begin
        if Result then Result := VerifierMAJScripts(FRepertoireApplication + '\Scripts\Import\', ChildNodes['import'].Attributes['nom'] + '*.sql');
        if Result then Result := VerifierMAJScripts(FRepertoireApplication + '\Scripts\Transfert\', ChildNodes['transfert'].Attributes['nom'] + '*.sql');
      end;
    end;
  end;

begin
  FRepertoireProjet := ExtractFileDir(ANomProjet) + '\';

  // Ouverture du fichier projet
  FFichierProjet := TXMLDocument.Create(Application);
  FichierProjet.DOMVendor := DOMVendors.Find('MSXML');
  FFichierProjet.FileName := ANomProjet;
  FFichierProjet.Active := True;
//  FFichierProjet.NodeIndentStr := '      ';
//  FFichierProjet.Options := FFichierProjet.Options + [doNodeAutoIndent];
  // Connexion à la base locale
  FPHAConnexion.DatabaseName := FRepertoireProjet + '\PHA.FDB';
  try
    FPHAConnexion.Connected := True;
  except
    on E:Exception do
    begin
      FConsole.AjouterLigne('Erreur d''initialisation de la base locale :');
      FConsole.AjouterLigne(E.Message);
      FFichierProjet.Active := False;
    end;
  end;

  // Chargement des modules
  if FPHAConnexion.Connected and FFichierProjet.Active then
  begin
    if not VerifierMAJScripts then
      MessageDlg('Les scripts de création de la base locale ont été mis à jour. Vous devriez reconstruire la base locale et réimportez les données.',
                 mtInformation,
                 [mbOk],
                 0);

      with FFichierProjet.DocumentElement.ChildNodes['modules'] do
        try
          FModuleImport := ChargerModule(tmImport, ChildNodes['import'].Attributes['nom']);
          FModuleTransfert := ChargerModule(tmTransfert, ChildNodes['transfert'].Attributes['nom']);

          // Vérification version
          lStrVerImport := VarAsType(ChildNodes['import'].Attributes['version'], varString);
          lStrVerTransfert := VarAsType(ChildNodes['transfert'].Attributes['version'], varString);

          if (FModuleImport.Version <> lStrVerImport) or
             (FModuleTransfert.Version <> lStrVerTransfert) then
             MessageDlg('Les modules d''import et/ou transfert ont été mis à jour. Vous devriez réimportez/retransferez les donnnées.',
                        mtInformation,
                        [mbOk],
                        0);

          case TTypeModule(StrToInt(FFichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['module_en_cours'])) of
            tmImport : ModuleEnCours := FModuleImport;
            tmTransfert : ModuleEnCours := FModuleTransfert;
          end;

          lBoolChargementMdlOutils := False;
          if Assigned(FModuleImport) then
          begin
            lBoolChargementMdlOutils := FModuleImport.Charge;
            if Assigned(FModuleTransfert) and lBoolChargementMdlOutils then
              lBoolChargementMdlOutils := FModuleImport.Charge
            else
              lBoolChargementMdlOutils := False;
          end;

          if lBoolChargementMdlOutils then
            if FModuleImport.Charge or FModuleTransfert.Charge then
            begin
              lIntNbOcc := TotalModules - 1;
              for i := 0 to lIntNbOcc do
              begin
                m := ModulesParIndex[i];
                if (m.TypeModule = tmOutils) and
                   ((m.Pays = FFichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['pays']) or (m.Pays = '')) then
                  m.ChargerModule;
              end;
              FOuvert := True;
            end;
        except
          on E:Exception do
            FConsole.AjouterLigne(E.Message);
        end;
  end;

  // Chargement des astuces
  if (FichierParametres.DocumentElement.ChildNodes['ASTUCES'].NodeValue = '1') then
    with TUIBQuery.Create(nil) do
    begin
      DataBase := FPHAConnexion;
      Transaction := FPHATransaction;
      SQL.Add('select message, type_astuce from v_astuce');
      Open;

      while not Eof do
      begin
        s := Fields.ByNameAsString['type_astuce'] + '|' + Fields.ByNameAsString['message'];
        FTrucsAstuces.Add(s);
        Next;
      end;
      Close(etmCommit);
      Free;
    end;
end;

procedure TProjet.RafraichirModules;
begin
  FModules.Clear;
  RenvoieModules(tmImport, FModules);
  RenvoieModules(tmTransfert, FModules);
  RenvoieModules(tmOutils, FModules);
end;

procedure TProjet.RenvoieModules(ATypeModule: TTypeModule; var AListe : TObjectList);
var
  lStrRepertoireRech : string;
  lFichierRech : TSearchRec;
begin
  case ATypeModule of
    tmImport : lStrRepertoireRech := FRepertoireApplication + '\Modules\Import';
    tmTransfert : lStrRepertoireRech := FRepertoireApplication + '\Modules\Transfert';
    tmOutils : lStrRepertoireRech := FRepertoireApplication + '\Modules\Outils';
  else
    raise EProjet.Create('Critère de recherche de modules invalide !');
  end;

   if FindFirst(lStrRepertoireRech + '\*.bpl', faAnyFile, lFichierRech) = 0 then
   begin
     repeat
       AListe.Add(TModuleClasse.Create(Self, ExtractFileNameWExt(lFichierRech.Name), ATypeModule));
     until FindNext(lFichierRech) <> 0;
     FindClose(lFichierRech);
   end
   else
     if ATypeModule <> tmOutils then
       raise EProjet.Create('Aucun Module de type ' + TModule.LibelleTypeModule[ATypeModule] + ' référencé !');
end;
                                              procedure TProjet.SetModuleEnCours(AValue: TModule);

  procedure ChangerModuleEnCours(AModule : TModule);
  begin
    if AModule.Charge then
      ModuleEnCours := AModule
    else
      FermerProjet;
  end;

begin
  if Assigned(AValue) then
  begin
    if FModuleEnCours <> AValue then
      if Assigned(FModuleEnCours) then
        (FModuleEnCours.IHM as TfrModule).Hide;

      if AValue.Charge then
      begin
        FModuleEnCours := AValue;
        with (FModuleEnCours.IHM as TfrModule) do
        begin
          Show;
          if not FOuvert and (FModuleEnCours.TypeModule = TTypeModule(Ord(StrToInt(FFichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['module_en_cours'])))) then
            wzDonnees.ActivePageIndex := FFichierProjet.DocumentElement.ChildNodes['informations_generales'].Attributes['page_en_cours'];
        end;
      end
      else
        if AValue.TypeModule = tmImport then
          ChangerModuleEnCours(FModuleTransfert)
        else
          ChangerModuleEnCours(FModuleImport);
  end;
end;

procedure TProjet.RenvoyerListePays;
var
  i : Integer;
begin
  FListePays.Clear;
  with FFichierParametres.DocumentElement.ChildNodes['ListePays'] do
    for i := 0 to ChildNodes.Count - 1 do
      FListePays.Add(ChildNodes[i].Attributes['code'] + '=' + ChildNodes[i].Attributes['libelle']);
end;

procedure TProjet.RenvoyerListeVersions;
var
  iPays : integer;
  iVersion : integer;
  pVersionObj : TVersionObject;
  pays, version : string;

begin
   FValidVersions.Clear;
   with FFichierParametres.DocumentElement.ChildNodes['transfert'] do
   begin

      pays := 'be';
      iVersion := 0;
      while (iVersion <= ChildNodes[pays].ChildNodes.count -1) do
      begin
        version := ChildNodes[pays].ChildNodes[iVersion].NodeValue;
        pVersionObj := TVersionObject.create(pays,version);
        FValidVersions.addObject('',pVersionObj);
        inc(iVersion)
      end;

      pays := 'fr';
      iVersion := 0;
      while (iVersion <= ChildNodes[pays].ChildNodes.count -1) do
      begin
        version := ChildNodes[pays].ChildNodes[iVersion].NodeValue;
        pVersionObj := TVersionObject.create(pays,version);
        FValidVersions.addObject('',pVersionObj);
        inc(iVersion)
      end;


   end;


end;



procedure TProjet.ScriptOnParse(Sender: TObject; NodeType: TSQLStatement;
  const Statement: string);
begin
  FInstructionSQL := Statement;
end;

constructor tVersionObject.create(pPays, pVersion : string);
begin
  pays := pPays;
  version := pVersion;
end;

end.
