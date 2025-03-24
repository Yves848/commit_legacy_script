unit mdlPrincipale;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Graphics,
  Dialogs, ActnList, ImgList, ComCtrls, { mdlModuleImport, }
  ExtCtrls, Buttons, StdCtrls, ToolWin, Menus, StrUtils,
  mdlProjet, mdlModule, ShlObj, ActiveX, mdlPHA, IdFTPList, IdBaseComponent,
  IdComponent, IdTCPServer, IdFTPServer, ActnMan,
  JvMenus, AppEvnts, ActnCtrls, mdlConsole, Math, JclPeImage,
  mdlConfiguration, IdCmdTCPServer, IdExplicitTLSClientServerBase,
  IdFTPListOutput, ShellAPI, JclFileUtils, IdRawBase, IdRawClient,
  IdIcmpClient, IdStack, IdStackConsts, JvComponentBase, JvThreadTimer,
  JvWizard, JvExControls, mdlLecteurRSS, IdContext, IdCustomTCPServer,
  ActnColorMaps, Generics.Collections, mdlClientFTP, DB, DBClient, JvBaseDlg,
  JvTipOfDay, mdlPITipOfDay, VirtualTrees, XPStyleActnCtrls, DateUtils, mdlInformationFichier,
  mdlListesFichiers, CommCtrl, JvBalloonHint, mdlFTPDEV;

type
  TfrmPrincipale = class(TForm)
    ilMenuPrincipale: TImageList;
    laMenuPrincipale: TActionList;
    actFichierNouveauProjet: TAction;
    actFichierOuvrirProjet: TAction;
    actFichierFermerProjet: TAction;
    actFichierInformationsModules: TAction;
    actFichierImprimerFiche: TAction;
    actFichierQuitter: TAction;
    actAideMAJ: TAction;
    actAideAProposDe: TAction;
    actReprisePageActiveImport: TAction;
    actReprisePageActiveTransfert: TAction;
    mnuMenuPrincipale: TJvMainMenu;
    mnuFichier: TMenuItem;
    mnuAide: TMenuItem;
    mnuFichierNouveauProjet: TMenuItem;
    mnuFichierOuvrirProjet: TMenuItem;
    mnuFichierFermerProjet: TMenuItem;
    mnuFichierSeparateur_1: TMenuItem;
    mnuFichierSeparateur_3: TMenuItem;
    mnuFichierQuitter: TMenuItem;
    mnuAideMAJ: TMenuItem;
    mnuAideAbout: TMenuItem;
    mnuFileModuleInfo: TMenuItem;
    actRepriseAnnuler: TAction;
    mnuReprise: TMenuItem;
    actRepriseConversionOrgCouv: TAction;
    actRepriseConfigComptes: TAction;
    actRepriseImportOrgAMO: TAction;
    actRepriseImportOrgAMC: TAction;
    actRepriseImportCouvAMO: TAction;
    actRepriseExportOrgAMO: TAction;
    actRepriseExportOrgAMC: TAction;
    actRepriseExportCouvAMO: TAction;
    actRepriseImportComptes: TAction;
    actRepriseExportComptes: TAction;
    actRepriseErreurs: TAction;
    actRepriseConfigCdf: TAction;
    actRepriseInfo: TAction;
    mnuAideSeparator_1: TMenuItem;
    actAideManuelUtilisation: TAction;
    mnuAideManuel: TMenuItem;
    mnuSeparator_2: TMenuItem;
    mnuReprisePageActive: TMenuItem;
    mnuRepriseSeparator_5: TMenuItem;
    actRepriseVisualiserFichiersImport: TAction;
    actRepriseConvProduitsLoc: TAction;
    amMenuPrincipale: TActionManager;
    cbMenuCOMMIT: TCoolBar;
    od: TOpenDialog;
    actRepriseLancerPageActive: TAction;
    mnuFichierSeparateur_2: TMenuItem;
    mnuReprisePageActiveLancer: TMenuItem;
    mnuReprisePageActiveSeparateur_1: TMenuItem;
    mnuReprisePageActiveImport: TMenuItem;
    mnuReprisePageActiveTransfert: TMenuItem;
    actRepriseDonneesEnCours: TAction;
    actRepriseToutesLesDonnees: TAction;
    mnuFichierConsole: TMenuItem;
    actFichierConsole: TAction;
    pnlDockGauche: TPanel;
    pnlDockBas: TPanel;
    splGauche: TSplitter;
    splBas: TSplitter;
    mnuRepriseOptions: TMenuItem;
    actRepriseOptions: TAction;
    ftpServeur: TIdFTPServer;
    mnuFichierActiverServeurFTP: TMenuItem;
    actFichierActiverServeurFTP: TAction;
    mnuFichierClientFTP: TMenuItem;
    actFichierClientFTP: TAction;
    actRepriseTelechargerFichiers: TAction;
    mnuRepriseSeparateur_8: TMenuItem;
    mnuRepriseTelechargerFichiers: TMenuItem;
    atbMenuFichier: TActionToolBar;
    atbMenuReprise: TActionToolBar;
    atbMenuAide: TActionToolBar;
    icmpServeurMAJ: TIdIcmpClient;
    tmPingServeurMAJ: TTimer;
    mnuAideTrucsAstuces: TMenuItem;
    actAideTrucsAstuces: TAction;

    mnuOutils: TMenuItem;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    JvBalloonHint1: TJvBalloonHint;
    tipDay: TJvTipOfDay;
    mnuAnydesk: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure actFichierFermerProjetExecute(Sender: TObject);
    procedure actFichierQuitterExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actAideAProposDeExecute(Sender: TObject);
    procedure actAideMAJExecute(Sender: TObject);
    procedure actFichierNouveauProjetExecute(Sender: TObject);
    procedure actReprisePageActiveImportExecute(Sender: TObject);
    procedure actReprisePageActiveTransfertExecute(Sender: TObject);
    procedure actFichierInformationsModulesExecute(Sender: TObject);
    procedure actFichierImprimerFicheExecute(Sender: TObject);
    procedure actAideModuleEnCoursExecute(Sender: TObject);
    procedure actAideModulesExecute(Sender: TObject);
    procedure actAideManuelUtilisationExecute(Sender: TObject);
    procedure actFichierOuvrirProjetExecute(Sender: TObject);
    procedure mnuOutilsClick(Sender: TObject);
    procedure actRepriseLancerPageActiveExecute(Sender: TObject);
    procedure actRepriseToutesLesDonneesExecute(Sender: TObject);
    procedure aevtCOMMITException(Sender: TObject; E: Exception);
    procedure aevtCOMMITMinimize(Sender: TObject);
    procedure aevtCOMMITRestore(Sender: TObject);
    procedure ProjetSurAvantTraiterDonnees(Sender: TObject);
    procedure ProjetSurApresTraiterDonnees(Sender: TObject; AResultat: TResultatCreationDonnees);
    procedure actRepriseErreursExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actFichierConsoleExecute(Sender: TObject);
    procedure pnlDockBasDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure pnlDockBasUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
    procedure pnlDockBasDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
    procedure pnlDockGaucheDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
    procedure pnlDockGaucheUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
    procedure pnlDockGaucheDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
    procedure actRepriseOptionsExecute(Sender: TObject);
    procedure ftpServeurListDirectory(ASender: TIdFTPServerContext; const APath: string; ADirectoryListing: TIdFTPListOutput;
      const ACmd: String; const ASwitches: String);
    procedure actFichierActiverServeurFTPExecute(Sender: TObject);
    procedure ftpServeurAfterUserLogin(ASender: TIdFTPServerContext);
    procedure ftpServeurRetrieveFile(ASender: TIdFTPServerContext; const AFileName: String; var VStream: TStream);
    procedure ftpServeurStoreFile(ASender: TIdFTPServerContext; const AFileName: String; AAppend: Boolean; var VStream: TStream);
    procedure ftpServeurDeleteFile(ASender: TIdFTPServerContext; const APathName: String);
    procedure ftpServeurMakeDirectory(ASender: TIdFTPServerContext; var VDirectory: String);
    procedure ftpServeurRemoveDirectory(ASender: TIdFTPServerContext; var VDirectory: String);
    procedure ftpServeurChangeDirectory(ASender: TIdFTPServerContext; var VDirectory: String);
    procedure actFichierClientFTPExecute(Sender: TObject);
    procedure actRepriseTelechargerFichiersExecute(Sender: TObject);
    procedure ChangerModeTraitement(Sender: TObject);
    procedure icmpServeurMAJReply(ASender: TComponent; const AReplyStatus: TReplyStatus);
    procedure tmPingServeurMAJTimer(Sender: TObject);
    procedure SurApresChargerFluxRSS(Sender: TObject);
    procedure actItemRSSExecute(Sender: TObject);
    procedure actAideTrucsAstucesExecute(Sender: TObject);
    procedure TrayIcon1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TrayIcon1BalloonClick(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mnuAnydeskClick(Sender: TObject);
  private
    { Private declarations }
    FRSS: TLecteurRSS;
    FProjet: TProjet;
    FSurCreation: Boolean;
    FPositionConsole: Integer;
    FServeursMAJ: TObjectList<TConnexion>;
    FServeurMAJ: Integer;
    FNombreMAJ: Integer;
    FPriorite: Integer;
    Fminimize: Boolean;
    procedure CMConsoleFermee(var Msg: TMessage); message CM_CONSOLE_FERMEE;
    procedure CMModuleAide(var Msg: TMessage); message CM_MODULE_AIDE;
    procedure MAJTitreFenetre;
  public
    { Public declarations }
    property Projet: TProjet read FProjet;
    property PositionConsole: Integer read FPositionConsole;
  end;

const
  C_BANDE_MENU_FICHIER = 0;

  C_BANDE_MENU_REPRISE = 1;
  C_BANDE_MENU_REPRISE_IMPORT = 0;
  C_BANDE_MENU_REPRISE_TRANSFERT = 1;
  C_BANDE_MENU_REPRISE_LANCEMENT = 3;

  C_BANDE_MENU_AIDE = 2;
  C_BANDE_MENU_AIDE_MAJ = 0;
  C_BANDE_MENU_AIDE_QUITTER = 1;

  C_DOCK_CONSOLE_NON_VISIBLE = -1;
  C_DOCK_CONSOLE_AUCUN = 0;
  C_DOCK_CONSOLE_GAUCHE = 1;
  C_DOCK_CONSOLE_BAS = 2;

var
  frmPrincipale: TfrmPrincipale;

implementation

uses mdlAProposDe, mdlModuleImport,
  mdlInformationsModules, ComObj, mdlDetailTraitementEnCours,
  mdlErreurs, mdlOptionsReprise, mdlAide,
  mdlFluxRSS, mdlIcmp, mdlMAJCommit, mdlCreationProjet;
{$R *.dfm}
{$R rdm_commit.res}

function SiParametre(AParametre: string; APartielle: Boolean = False): Integer;
var
  i: Integer;
begin
  i := 0;
  Result := -1;
  while (i < ParamCount) and (Result = -1) do
    if not APartielle then
      if (ParamStr(i + 1) = AParametre) then
        Result := i + 1
      else
        Inc(i)
      else if Pos(AParametre, ParamStr(i + 1)) > 0 then
        Result := i + 1
      else
        Inc(i);
end;

function RenvoyerValeurParametre(AParametre: Integer): Char;
var
  lStrParametre: string;
  lIntPos: Integer;
begin
  if AParametre > 0 then
  begin
    lStrParametre := ParamStr(AParametre);
    lIntPos := Pos('=', lStrParametre);
    if lIntPos > 0 then
      Result := Copy(lStrParametre, lIntPos + 1, 1)[1]
    else
      Result := ' ';
  end
  else
    Result := ' ';
end;

procedure TfrmPrincipale.FormCreate(Sender: TObject);
var
  lIntParamConsole, lIntParamPosConsole, lIntParamPriorite: Integer;
  lIntPosConsole: Integer;
  lDockPermis: Boolean;
  i: Integer;
  rep: string;
  maj: TConnexion;
  fe: TSearchRec;
  info: TJclPeImage;
  ico: TIcon;
  m: TMenuItem;
  dREs: Double;

  procedure AffecterParametrage(AUtilisationServeurFB, AConsole, AUtilisationThread: Boolean;
    APositionConsole, APrioriteProcessus: Integer; AMinimize: Boolean);
  const
    C_PRIORITE_APPLICATION: array [0 .. 5] of DWORD = ($40, $4000, $20, $8000, $80, $100);
  begin
    // Connexion base locale
    FProjet := TProjet.Create(not AUtilisationServeurFB);
    Projet.Minimize := AMinimize;
    // Positionnement console
    if not AConsole then
    begin
      mnuFichierConsole.Checked := False;
      actFichierConsole.Execute;
      FPositionConsole := C_DOCK_CONSOLE_NON_VISIBLE;
    end
    else
    begin
      lDockPermis := True;
      case APositionConsole of
        1:
          begin
            Projet.Console.frmConsole.ManualDock(pnlDockBas);
            pnlDockBasDockDrop(Self, nil, 0, 0);
            FPositionConsole := C_DOCK_CONSOLE_BAS;
          end;

        2:
          begin
            Projet.Console.frmConsole.ManualDock(pnlDockGauche);
            pnlDockGaucheDockDrop(Self, nil, 0, 0);
            FPositionConsole := C_DOCK_CONSOLE_GAUCHE;
          end;
      else
        FPositionConsole := C_DOCK_CONSOLE_AUCUN;
      end;
    end;

    SetPriorityClass(GetCurrentProcess, C_PRIORITE_APPLICATION[APrioriteProcessus]);
  end;

begin
  Top := 0;
  Left := 0;

  try
    FSurCreation := True;

    lIntParamConsole := SiParametre('--console=N');
    if lIntParamConsole = -1 then
    begin
      lIntParamPosConsole := SiParametre('--posconsole', True);
      if lIntParamPosConsole <> -1 then
        case RenvoyerValeurParametre(lIntParamPosConsole) of
          'H':
            lIntPosConsole := 1;
          'V':
            lIntPosConsole := 2;
        else
          lIntPosConsole := 0;
        end
      else
        lIntPosConsole := 1;
      end
    else
      lIntPosConsole := 0;

      lIntParamPriorite := SiParametre('--priorite=', True);
      if lIntParamPriorite <> -1 then
      begin
        if not TryStrToInt(RenvoyerValeurParametre(lIntParamPriorite), FPriorite) then
          FPriorite := 2;
      end
      else
        FPriorite := 2;

      AffecterParametrage(SiParametre('--serveur') <> -1, lIntParamConsole = -1, SiParametre('--thread=N') = -1, lIntPosConsole,
        FPriorite, SiParametre('--nominimize') = -1);

      // frmCreationProjet := TfrmCreationProjet.Create(Application, frmPrincipale.Projet);
      // frmInformationsModules := TfrmInformationsModules.Create(Application, frmPrincipale.Projet);

      FRSS := TLecteurRSS.Create(Self, 'http://repf.groupe.pharmagest.com/maj_commit.xml');
      FRSS.SurApresCharger := SurApresChargerFluxRSS;

      // Lecture des serveurs de MAJ
      FServeursMAJ := TObjectList<TConnexion>.Create;

      with FProjet.FichierParametres.DocumentElement.ChildNodes['ServeursMAJ'] do
        for i := 0 to ChildNodes.Count - 1 do
        begin
          maj := TConnexion.Create;
          maj.Serveur := ChildNodes[i].Attributes['serveur'];
          maj.Port := StrToInt(ChildNodes[i].Attributes['port']);
          maj.Utilisateur := ChildNodes[i].Attributes['utilisateur'];
          maj.MotDePasse := ChildNodes[i].Attributes['mot_de_passe'];
          maj.RepertoireBase := ChildNodes[i].Attributes['repertoire'];
          FServeursMAJ.Add(maj);
        end;

      // Création des item menus outils
      mnuOutils.Clear;
      rep := FProjet.RepertoireApplication + '\Outils\';
      if FindFirst(rep + '*.exe', faAnyFile, fe) = 0 then
      begin
        repeat
          info := TJclPeImage.Create;
          info.FileName := rep + fe.Name;
          if Assigned(info.VersionInfo) and (info.VersionInfo.Items.Values['FileDescription'] <> '') then
          begin
            m := TMenuItem.Create(Self);
            m.Caption := info.VersionInfo.Items.Values['FileDescription'];
            m.Tag := Integer(info);

            // Extraction de l'icone
            ico := TIcon.Create;
            ico.Handle := ExtractIcon(hInstance, PChar(info.FileName), 0);
            m.ImageIndex := ilMenuPrincipale.AddIcon(ico);

            m.OnClick := mnuOutilsClick;
            mnuOutils.Add(m);
          end;
        until FindNext(fe) <> 0;
        FindClose(fe);
      end;
      mnuOutils.Visible := mnuOutils.Count > 0;

      except
        on E: Exception do
        begin
          MessageDlg(E.Message + #10#13#10#13 + 'Impossible de continuer ! Fermeture de l''application !', mtError, [mbOk], 0);
          Application.Terminate;
        end;
      end;
    end;

      procedure TfrmPrincipale.FormClose(Sender: TObject; var Action: TCloseAction);

        function OkPourFermer: Boolean;
        begin
          if FProjet.Ouvert then
            if (Projet.ModuleEnCours.IHM as TfrModule).EnTraitement then
            begin
              MessageDlg('Un traitement est en cours. Vous devez l''annuler avant de quitter COMMIT !', mtWarning, [mbOk], 0);
              Result := False;
            end
            else
              Result := True
            else
              Result := True;
        end;

      begin
        if OkPourFermer then
        begin
          // TfrModule(Projet.ModuleEnCours.IHM).Annulation := True;
          actFichierFermerProjetExecute(Self);
        end
        else
          Action := caNone;
      end;

      procedure TfrmPrincipale.FormDestroy(Sender: TObject);
      begin
        if Assigned(FServeursMAJ) then
          FreeAndNil(FServeursMAJ);
        if Assigned(FRSS) then
          FreeAndNil(FRSS);
        if ftpServeur.Active then
          ftpServeur.Active := False;
        if Assigned(FProjet) then
          FreeAndNil(FProjet);
      end;

      procedure TfrmPrincipale.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      var
        frmFTPDev: tFrmFTPDev;
      begin
        if Shift = [ssAlt, ssCtrl] then
        begin
          if Key = VK_F5 then
          begin
            frmFTPDev := tFrmFTPDev.Create(Self, FProjet);
            frmFTPDev.ShowModal;
            frmFTPDev.Free;
          end;
        end;
      end;

      procedure TfrmPrincipale.actFichierNouveauProjetExecute(Sender: TObject);
      var
        lStrPays, lStrNomFichierProjet: string;
        lModuleImport: TModule;
        lModuleTransfert: TModule;
        ok: Boolean;

        function OkPourCreation: Boolean;
        begin
          if Projet.Ouvert then
          begin
            Result := MessageDlg(
              'La création d''un nouveau projet provoquera la fermeture du projet en cours et l''ouverture du nouveau projet.'#10#13'Voulez-vous continuer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
          end
          else
            Result := True;
        end;

      begin
        if OkPourCreation then
        begin
          actFichierFermerProjet.Execute;

          // Mise à jour avant création d'un projet
          if MessageDlg(
            'Une mise à jour est peut-être nécessaire avant la création d''un nouveau projet. Voulez-vous l''effectuer ?',
            mtInformation, [mbYes, mbNo], 0) = mrYes then
            try
              actAideMAJExecute(Self);
              ok := True;
            except
              ok := MessageDlg('La mise à jour de COMMIT a échoué ! Voulez-vous continuer la création d''un nouveau projet ?',
                mtWarning, [mbYes, mbNo], 0) = mrYes
            end
          else
            ok := True;

          if ok then
            with TfrmCreationProjet.Create(Self, Projet) do
              if ShowModal(lStrPays, lStrNomFichierProjet, lModuleImport, lModuleTransfert) = mrOk then
              begin
                FProjet.CreerProjet(lStrNomFichierProjet, lModuleImport, lModuleTransfert, lStrPays);
                od.FileName := lStrNomFichierProjet;
                actFichierOuvrirProjet.Execute;

                // Lancement de la saisie des options de reprise
                if not Assigned(Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes.FindNode
                    ('options')) then
                  actRepriseOptions.Execute;
              end;
        end;
      end;

      procedure TfrmPrincipale.actFichierFermerProjetExecute(Sender: TObject);
      begin
        if FProjet.Ouvert then
        begin
          // for i := 0 to mnuOutils.Count - 1 do
          // TJclPeImage(mnuOutils.Items[i].Tag).Free;

          with FProjet.FichierProjet.DocumentElement.ChildNodes['parametres_application'] do
          begin
            Attributes['position_console'] := FPositionConsole;
            Attributes['serveur'] := FProjet.PHAConnexion.LibraryName = 'fbembed.dll';
            Attributes['priorite'] := FPriorite;
            Attributes['thread'] := FProjet.Thread;
          end;

          FProjet.FermerProjet;

          while amMenuPrincipale.ActionBars[C_BANDE_MENU_REPRISE].Items[C_BANDE_MENU_REPRISE_IMPORT].Items.Count > 0 do
          begin
            amMenuPrincipale.ActionBars[C_BANDE_MENU_REPRISE].Items[C_BANDE_MENU_REPRISE_IMPORT].Items[0].Action.Free;
            amMenuPrincipale.ActionBars[C_BANDE_MENU_REPRISE].Items[C_BANDE_MENU_REPRISE_IMPORT].Items[0].Free;
          end;

          cbMenuCOMMIT.Bands[C_BANDE_MENU_REPRISE].Visible := FProjet.Ouvert;
          actFichierFermerProjet.Enabled := FProjet.Ouvert;
          mnuReprise.Visible := FProjet.Ouvert;
          // mnuOutils.Visible := FProjet.Ouvert;

          od.FileName := '';
          Caption := Application.Title;
        end;
      end;

      procedure TfrmPrincipale.actFichierInformationsModulesExecute(Sender: TObject);
      begin
        TfrmInformationsModules.Create(Self, Projet).ShowModal;
      end;

      procedure TfrmPrincipale.actReprisePageActiveImportExecute(Sender: TObject);
      begin
        if not(FProjet.ModuleEnCours.IHM as TfrModule).EnTraitement then
        begin
          FProjet.ModuleEnCours := FProjet.ModuleImport;
          actReprisePageActiveImport.Checked := True;
          actReprisePageActiveTransfert.Checked := False;

          MAJTitreFenetre;
        end;
      end;

      procedure TfrmPrincipale.actReprisePageActiveTransfertExecute(Sender: TObject);
      begin
        if not(FProjet.ModuleEnCours.IHM as TfrModule).EnTraitement then
        begin
          FProjet.ModuleEnCours := FProjet.ModuleTransfert;
          actReprisePageActiveImport.Checked := False;
          actReprisePageActiveTransfert.Checked := True;

          MAJTitreFenetre;
        end;
      end;

      procedure TfrmPrincipale.actFichierQuitterExecute(Sender: TObject);
      begin
        Close;
      end;

      procedure TfrmPrincipale.actAideMAJExecute(Sender: TObject);
      var
        lFichiers: TSearchRec;
        lStrRepertoireTMP: string;
        lIntFichiersMAJ: Integer;
        i: Integer;
        d1, d2: TDateTime;
        dREs: Double;

        function OkPourMAJ: Boolean;
        begin
          if Projet.Ouvert then
            Result := MessageDlg('Pour mettre à jour COMMIT, le projet en cours doit être fermer ! Voulez-vous continuer ?',
              mtConfirmation, [mbYes, mbNo], 0) = mrYes
          else
            Result := True;
        end;

        procedure RedemarrerCOMMIT;
        var
          lStrRDMCommit: string;
          lRes: TResourceStream;
        begin
          lStrRDMCommit := FProjet.RepertoireApplication + '\rdm_commit.exe';
          if FileExists(lStrRDMCommit) then
            ShellExecute(0, 'open', PChar(lStrRDMCommit), nil, PChar(FProjet.RepertoireApplication), SW_HIDE);
          end;

      begin
        if OkPourMAJ then
        begin
          actFichierFermerProjet.Execute;

          // Vérification connexion
          i := 0;
          FServeurMAJ := -1;

          while (i < FServeursMAJ.Count) and (FServeurMAJ = -1) do

            if Ping(FServeursMAJ[i].Serveur, 10, dREs) then
              FServeurMAJ := i
            else
              Inc(i);
          FServeurMAJ := 0;
          if FServeurMAJ <> -1 then
          begin
            frmMAJCommit := TfrmMAJCommit.Create(Self);
            // ici, détecter un "serveur temporaire' .....
            frmMAJCommit.Show(Projet, FServeursMAJ[FServeurMAJ]);
            begin
              lStrRepertoireTMP := FProjet.RepertoireApplication + '\TMP\';
              lIntFichiersMAJ := 0;

              if FindFirst(lStrRepertoireTMP + '*.*', faAnyFile, lFichiers) = 0 then
              begin
                repeat
                  if ((lFichiers.Attr and faDirectory) <> faDirectory) then
                  begin
                    FileAge(lStrRepertoireTMP + lFichiers.Name, d1);
                    FileAge(FProjet.RepertoireApplication + '\' + lFichiers.Name, d2);
                    if d1 > d2 then
                      Inc(lIntFichiersMAJ)
                    else
                      DeleteFile(lStrRepertoireTMP + lFichiers.Name);
                  end;
                until FindNext(lFichiers) <> 0;
                FindClose(lFichiers);

                if lIntFichiersMAJ > 0 then
                begin
                  RedemarrerCOMMIT;
                  MessageDlg('COMMIT a besoin de redémarrer pour terminer la mettre à jour.', mtWarning, [mbOk], 0);
                  Application.Terminate;
                end;
              end;

              // Mise  jour du l'objet projet
              FProjet.RafraichirModules;
            end;
          end
          else
            MessageDlg('Aucun serveur de MAJ n''est disponible !', mtInformation, [mbOk], 0);
        end;
      end;

      procedure TfrmPrincipale.actAideAProposDeExecute(Sender: TObject);
      begin
        TfrmAProposDe.Create(Self).ShowModal;
      end;

      procedure TfrmPrincipale.actFichierImprimerFicheExecute(Sender: TObject);
      begin
        Print;
      end;

      procedure TfrmPrincipale.actAideModuleEnCoursExecute(Sender: TObject);
      begin
        // case cbxModuleChoice.ItemIndex of
        // IMPORT_MODULE :
        // Project.ShowHelp(tmIn);
        //
        // TRANSFERT_MODULE :
        // Project.ShowHelp(tmOut);
        // end;
      end;

      procedure TfrmPrincipale.actAideModulesExecute(Sender: TObject);
      begin
        // Project.ShowHelp(tmNone);
      end;

      procedure TfrmPrincipale.actAideTrucsAstucesExecute(Sender: TObject);
      begin
        if tipDay.Execute then
          if FProjet.FichierParametres.DocumentElement.ChildNodes['ASTUCES'].NodeValue = '1' then
            FProjet.FichierParametres.DocumentElement.ChildNodes['ASTUCES'].NodeValue := True;
      end;

      procedure TfrmPrincipale.actAideManuelUtilisationExecute(Sender: TObject);
      begin
        TfrmAide.Create(Self, FProjet).ShowModal('');
      end;

      procedure TfrmPrincipale.actFichierOuvrirProjetExecute(Sender: TObject);
      var
        lIntIndexMenuAide: Integer;

        procedure ConfigurerIntfModule(AIHM: TfrModule; AIdxMenu: Integer);
        var
          i: TModeTraitement;

          function CompterModesGeres(AModesGeres: TModesTraitement): Integer;
          var
            i: TModeTraitement;
          begin
            Result := 0;
            for i := Low(TModeTraitement) to High(TModeTraitement) do
              if i in AModesGeres then
                Inc(Result);
          end;

        begin
          // Config. TrayIcon
          if Assigned(AIHM) then
          begin
            AIHM.SurAvantTraiterDonnees := ProjetSurAvantTraiterDonnees;
            AIHM.SurApresTraiterDonnees := ProjetSurApresTraiterDonnees;
          end;

          // Config. ModeTraitement
          amMenuPrincipale.ActionBars[C_BANDE_MENU_REPRISE].Items[C_BANDE_MENU_REPRISE].Items.Clear;
          if CompterModesGeres(AIHM.ModesGeres) > 1 then
            for i := Low(TModeTraitement) to High(TModeTraitement) do
              if i in AIHM.ModesGeres then
                with amMenuPrincipale.ActionBars[C_BANDE_MENU_REPRISE].Items[AIdxMenu].Items.Add do
                begin
                  Action := TAction.Create(Self);
                  with TAction(Action) do
                  begin
                    AutoCheck := True;
                    Caption := TfrModule.LibelleModeTraitement[i];
                    Checked := i = AIHM.Mode;
                    Tag := AIdxMenu shl 16 + Ord(AIHM.Module.TypeModule) shl 8 + Ord(i);
                    OnExecute := ChangerModeTraitement;
                  end;
                end;
        end;

        function OkPOurOuvrir: Boolean;
        begin
          if FProjet.Ouvert then
            Result := MessageDlg(
              'Un projet est actuellement ouvert. L''ouverture d''un autre projet provoquera la fermeture du projet en cours. Voulez-vous continuer ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
          else
            Result := True;
        end;

        function Ouvrir: Boolean;
        begin
          if od.FileName = '' then
            Result := od.Execute
          else
            Result := True;
        end;

      begin
        try
          if OkPOurOuvrir then
          begin
            actFichierFermerProjet.Execute;

            if Ouvrir then
            begin
              FProjet.OuvrirProjet(od.FileName);

              if FProjet.Ouvert then
              begin

                actReprisePageActiveImport.Enabled := FProjet.ModuleImport.Charge;
                actReprisePageActiveTransfert.Enabled := FProjet.ModuleTransfert.Charge;

                if FProjet.ModuleEnCours.TypeModule = tmImport then
                  actReprisePageActiveImportExecute(Self)
                else
                  actReprisePageActiveTransfertExecute(Self);

                // Config. vnements aprs traitement
                ConfigurerIntfModule((FProjet.ModuleImport.IHM as TfrModule), C_BANDE_MENU_REPRISE_IMPORT);
                ConfigurerIntfModule((FProjet.ModuleTransfert.IHM as TfrModule), C_BANDE_MENU_REPRISE_TRANSFERT);

                atbMenuReprise.RecreateControls;

                lIntIndexMenuAide := mnuMenuPrincipale.Items.IndexOf(mnuAide);
                if lIntIndexMenuAide <> -1 then
                  mnuMenuPrincipale.Items[lIntIndexMenuAide].MenuIndex := mnuMenuPrincipale.Items.Count - 1;

              end
              else
              begin
                FProjet.FermerProjet;
                MessageDlg('Impossible d''ouvrir le projet ' + ExtractFileName(od.FileName) +
                    ' ! Ceci est sans doute lié  une base locale altérée ...', mtError, [mbOk], 0);
                od.FileName := '';
              end;
            end;
          end;

          cbMenuCOMMIT.Bands[C_BANDE_MENU_REPRISE].Visible := FProjet.Ouvert;
          actFichierFermerProjet.Enabled := FProjet.Ouvert;
          mnuReprise.Visible := FProjet.Ouvert;
          if FProjet.Ouvert then
            if Assigned(FProjet.ModuleImport) then
              actRepriseTelechargerFichiers.Visible := Supports(FProjet.ModuleImport.IHM, ITransfertFTP)
            else
              actRepriseTelechargerFichiers.Visible := False
            else
              actRepriseTelechargerFichiers.Visible := False;

          // Affichage des trucs & astuces
          if (FProjet.TrucsAstuces.Count > 0) then
          begin
            tipDay.Tips.AddStrings(FProjet.TrucsAstuces);
            actAideTrucsAstuces.Enabled := True;
            actAideTrucsAstucesExecute(Self);
          end
          else
            actAideTrucsAstuces.Enabled := False;
        except
          on E: Exception do
            ShowMessage(E.message)
        end;
      end;

      procedure TfrmPrincipale.actRepriseLancerPageActiveExecute(Sender: TObject);
      begin (FProjet.ModuleEnCours.IHM as TfrModule)
        .wzDonnees.OnActivePageChanged(nil);
      end;

      procedure TfrmPrincipale.actRepriseToutesLesDonneesExecute(Sender: TObject);
      begin (FProjet.ModuleEnCours.IHM as TfrModule)
        .TraiterToutesLesDonnees;
        Application.Restore;
      end;

      procedure TfrmPrincipale.aevtCOMMITException(Sender: TObject; E: Exception);
      var
        lBureau: IShellFolder;
        lpRepBureau: PItemIDList;
        lRetChaine: TStrRet;

        procedure LiberePIDL(AID: PItemIDList);
        var
          Malloc: IMalloc;
        begin
          if AID = nil then
            Exit;
          OLECheck(SHGetMalloc(Malloc));
          Malloc.Free(AID);
        end;

      begin
        with FProjet do
        begin
          // Sauvegarde LOG
          if Assigned(Console) then
          begin
            OLECheck(SHGetDesktopFolder(lBureau));
            OLECheck(SHGetSpecialFolderLocation(Handle, CSIDL_DESKTOP, lpRepBureau));
            lBureau.GetDisplayNameOf(lpRepBureau, SHGDN_FORPARSING, lRetChaine);

            Console.AjouterLigne(Sender.ClassName + ' ' + E.Message);
            Console.Sauver(lRetChaine.pOleStr + '\commit.log');

            LiberePIDL(lpRepBureau);
            lBureau := nil;
          end;

          // Rinitialisation du projet
          if Ouvert then (ModuleEnCours.IHM as TfrModule)
            .EnTraitement := False;
        end;
      end;

      procedure TfrmPrincipale.aevtCOMMITMinimize(Sender: TObject);
      begin
        if FProjet.Ouvert then
          if (FProjet.ModuleEnCours.IHM as TfrModule).EnTraitement and (FProjet.ModuleEnCours.IHM as TfrModule)
            .TraitementAutomatique then
          begin
            TrayIcon1.Visible := True;
            ShowWindow(Application.Handle, SW_HIDE);

            ProjetSurAvantTraiterDonnees(Self);

            Tag := 1;
          end;
      end;

      procedure TfrmPrincipale.aevtCOMMITRestore(Sender: TObject);
      begin
        if TrayIcon1.Visible then
        begin
          if Assigned(frmDetailTraitementEnCours) then
            FreeAndNil(frmDetailTraitementEnCours);
          TrayIcon1.Visible := False;
          ShowWindow(Application.Handle, SW_SHOW);

          Tag := 0;
        end;
      end;


procedure TfrmPrincipale.ProjetSurApresTraiterDonnees(Sender: TObject; AResultat: TResultatCreationDonnees);
      begin
        if TrayIcon1.Visible then
        begin
          if Assigned(frmDetailTraitementEnCours) then
            FreeAndNil(frmDetailTraitementEnCours);

          case AResultat of
            rcdErreur:
              TrayIcon1.BalloonFlags := bfWarning;
            rcdErreurSysteme:
              TrayIcon1.BalloonFlags := bfError;
          else
            TrayIcon1.BalloonFlags := bfInfo;
          end;
          TrayIcon1.BalloonHint := (FProjet.ModuleEnCours.IHM as TfrModule).wzDonnees.ActivePage.Caption + ' terminés !';
          TrayIcon1.ShowBalloonHint;
        end;
      end;

      procedure TfrmPrincipale.ProjetSurAvantTraiterDonnees(Sender: TObject);
      begin
        with TrayIcon1 do
          if Visible then
          begin
            BalloonFlags := bfInfo;
            BalloonHint := (FProjet.ModuleEnCours.IHM as TfrModule).wzDonnees.ActivePage.Caption + ' en cours ...';
            ShowBalloonHint;
          end;
      end;

      procedure TfrmPrincipale.actRepriseErreursExecute(Sender: TObject);
      begin
        FProjet.AfficherErreurs;
      end;

      procedure TfrmPrincipale.FormActivate(Sender: TObject);
      var
        lIntProjet: Integer;
      begin
        if Assigned(FProjet) then
        begin
          lIntProjet := SiParametre('--projet') + 1;
          if (lIntProjet > 0) and FSurCreation then
          begin
            od.FileName := ParamStr(lIntProjet);
            actFichierOuvrirProjet.Execute;

            FSurCreation := False;
          end;
        end;
      end;

      procedure TfrmPrincipale.actFichierConsoleExecute(Sender: TObject);
      begin
        if actFichierConsole.Checked then
        begin
          if FPositionConsole = C_DOCK_CONSOLE_GAUCHE then
            splGauche.Show;

          pnlDockGauche.Show;
          pnlDockBas.Show;

          if FPositionConsole = C_DOCK_CONSOLE_BAS then
            splBas.Show;

          FProjet.Console.frmConsole.Show;
        end
        else
        begin
          pnlDockGauche.Hide;
          splGauche.Hide;
          pnlDockBas.Hide;
          splBas.Hide;
          FProjet.Console.frmConsole.Hide;

          FPositionConsole := C_DOCK_CONSOLE_NON_VISIBLE;
        end;
      end;

      procedure TfrmPrincipale.pnlDockBasDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState;
        var Accept: Boolean);
      var
        lRect: TRect;
      begin
        Accept := Source.Control is TfrmConsole;
        if Accept then
        begin
          lRect.TopLeft := pnlDockBas.ClientToScreen(Point(0, -129));
          lRect.BottomRight := pnlDockBas.ClientToScreen(Point(pnlDockBas.Width, 0));
          Source.DockRect := lRect;

          splBas.Show;
        end;
      end;

      procedure TfrmPrincipale.pnlDockBasUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
      begin
        pnlDockBas.Height := 0;
        splBas.Hide;

        FPositionConsole := C_DOCK_CONSOLE_AUCUN;
      end;

      procedure TfrmPrincipale.pnlDockBasDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
      begin
        pnlDockBas.Height := 129;
        splBas.Show;
        splBas.Top := ClientHeight - pnlDockBas.Height - splBas.Height;

        FPositionConsole := C_DOCK_CONSOLE_BAS;
      end;

      procedure TfrmPrincipale.pnlDockGaucheDockOver(Sender: TObject; Source: TDragDockObject; X, Y: Integer; State: TDragState;
        var Accept: Boolean);
      var
        lRect: TRect;
      begin
        Accept := Source.Control is TfrmConsole;
        if Accept then
        begin
          lRect.TopLeft := pnlDockGauche.ClientToScreen(Point(0, 0));
          lRect.BottomRight := pnlDockGauche.ClientToScreen(Point(129, pnlDockGauche.Height));
          Source.DockRect := lRect;

          splGauche.Show;
        end;
      end;

      procedure TfrmPrincipale.pnlDockGaucheUnDock(Sender: TObject; Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
      begin
        pnlDockGauche.Width := 0;
        splGauche.Hide;

        FPositionConsole := C_DOCK_CONSOLE_AUCUN;
      end;

      procedure TfrmPrincipale.pnlDockGaucheDockDrop(Sender: TObject; Source: TDragDockObject; X, Y: Integer);
      begin
        pnlDockGauche.Width := 129;
        splGauche.Left := ClientWidth - pnlDockGauche.Width - splGauche.Width;
        splGauche.Show;
        FPositionConsole := C_DOCK_CONSOLE_GAUCHE;
      end;

      procedure TfrmPrincipale.CMConsoleFermee(var Msg: TMessage);
      begin
        actFichierConsole.Checked := False;
        actFichierConsoleExecute(Self);
      end;

      procedure TfrmPrincipale.actRepriseOptionsExecute(Sender: TObject);
      var
        lClasseConfImport, lClasseConfTransfert: TfrConfigurationClasse;
        lConfImport, lConfTransfert: TfrConfiguration;

        procedure RenvoyerInterfaceConf(ANomClasse: string; var AClasse: TfrConfigurationClasse);
        begin
          AClasse := TfrConfigurationClasse(GetClass(ANomClasse));
          if Assigned(AClasse) then
          begin
            if not AClasse.InheritsFrom(TfrConfiguration) then
              raise Exception.Create('Type de configuration erroné !');
          end;
        end;

        function InitOptions(ATabSheet: TTabSheet; AClasseConfiguration: TfrConfigurationClasse): TfrConfiguration;
        var
          lIntH: Integer;
        begin
          if Assigned(AClasseConfiguration) then
          begin
            case ATabSheet.Tag of
              1:
                Result := AClasseConfiguration.Create(frmOptionsReprise, FProjet.ModuleImport);
              2:
                Result := AClasseConfiguration.Create(frmOptionsReprise, FProjet.ModuleTransfert);
            else
              Result := nil;
            end;

            if Assigned(Result) then
              with Result do
              begin
                Parent := ATabSheet;
                Top := 8;
                Left := 8;

                lIntH := ATabSheet.Top + BoundsRect.Bottom + 8;
                if frmOptionsReprise.pCtlOptionsReprise.Height < lIntH then
                  frmOptionsReprise.pCtlOptionsReprise.Height := lIntH;
              end;
          end
          else
          begin
            Result := nil;
            ATabSheet.TabVisible := False;
          end;
        end;

      begin
        lClasseConfImport := nil;
        lClasseConfTransfert := nil;

        if FProjet.Ouvert then
          RenvoyerInterfaceConf('Tfr' + FProjet.ModuleImport.NomModule + 'Configuration', lClasseConfImport);
        RenvoyerInterfaceConf('Tfr' + FProjet.ModuleTransfert.NomModule + 'Configuration', lClasseConfTransfert);
        if Assigned(lClasseConfImport) or Assigned(lClasseConfTransfert) then
        begin
          frmOptionsReprise := TfrmOptionsReprise.Create(Self, FProjet);
          lConfImport := InitOptions(frmOptionsReprise.tshImport, lClasseConfImport);
          lConfTransfert := InitOptions(frmOptionsReprise.tshTransfert, lClasseConfTransfert);

          if frmOptionsReprise.ShowModal = mrOk then
          begin
            if Assigned(lClasseConfImport) then
            begin
              lConfImport.Enregistrer;
              if Assigned((FProjet.ModuleImport.IHM as TfrModule).SurEnregistrerConfiguration) then
  (FProjet.ModuleImport.IHM as TfrModule)
                .SurEnregistrerConfiguration(Self);
            end;
            if Assigned(lClasseConfTransfert) then
            begin
              lConfTransfert.Enregistrer;
              if Assigned((FProjet.ModuleTransfert.IHM as TfrModule).SurEnregistrerConfiguration) then
  (FProjet.ModuleTransfert.IHM as TfrModule)
                .SurEnregistrerConfiguration(Self);
            end;

            Projet.FichierProjet.SaveToFile;
          end;
        end
        // else
        // MessageDlg('Aucune option de reprise disponible.', mtInformation, [mbOk], 0);
      end;

      procedure TfrmPrincipale.ftpServeurListDirectory(ASender: TIdFTPServerContext; const APath: string;
        ADirectoryListing: TIdFTPListOutput; const ACmd: String; const ASwitches: String);
      var
        lStrChemin: string;
        lFich: TSearchRec;
      begin
        lStrChemin := ASender.HomeDir + StringReplace(APath, '/', PathDelim, [rfReplaceAll]);
        if FindFirst(lStrChemin + '\*.*', faAnyFile, lFich) = 0 then
        begin
          // ADirectoryListing.Output := APath;
          repeat
            with ADirectoryListing.Add do
            begin
              FileName := lFich.Name;
              GroupName := 'ftp';
              OwnerName := 'ftp';
              UnixGroupPermissions := '---';
              UnixOwnerPermissions := '---';
              UnixOtherPermissions := '---';
              if (lFich.Attr and faDirectory) = faDirectory then
                ItemType := ditDirectory
              else
                ItemType := ditFile;
              ModifiedDate := FileDateToDateTime(lFich.Time);
              Size := lFich.Size;
            end;
          until FindNext(lFich) <> 0;
          FindClose(lFich);
        end;
      end;

      procedure TfrmPrincipale.actFichierActiverServeurFTPExecute(Sender: TObject);
      begin
        try
          ftpServeur.Active := actFichierActiverServeurFTP.Checked;
          if ftpServeur.Active and not FileExists(Projet.RepertoireApplication + C_REPERTOIRE_FTP) then
            CreateDir(Projet.RepertoireApplication + C_REPERTOIRE_FTP);
        except
          actFichierActiverServeurFTP.Checked := False;
          raise ;
        end;
      end;

      procedure TfrmPrincipale.ftpServeurAfterUserLogin(ASender: TIdFTPServerContext);
      begin
        ASender.CurrentDir := '/';
        ASender.HomeDir := Projet.RepertoireApplication + C_REPERTOIRE_FTP;
      end;

      procedure TfrmPrincipale.ftpServeurRetrieveFile(ASender: TIdFTPServerContext; const AFileName: String; var VStream: TStream);
      var
        lStrFich: string;
      begin
        with ASender do
          lStrFich := HomeDir + StringReplace(AFileName, '/', PathDelim, [rfReplaceAll]);

        if FileExists(lStrFich) then
          VStream := TFileStream.Create(lStrFich, fmOpenRead or fmShareDenyWrite)
        else
          raise Exception.Create('Fichier "' + AFileName + '" inexistant !');
      end;

      procedure TfrmPrincipale.ftpServeurStoreFile(ASender: TIdFTPServerContext; const AFileName: String; AAppend: Boolean;
        var VStream: TStream);
      var
        lStrFich: string;
      begin
        with ASender do
          lStrFich := HomeDir + StringReplace(AFileName, '/', PathDelim, [rfReplaceAll]);

        VStream := TFileStream.Create(lStrFich, fmCreate);
      end;

      procedure TfrmPrincipale.ftpServeurDeleteFile(ASender: TIdFTPServerContext; const APathName: String);
      var
        lStrFich: string;
      begin
        with ASender do
          lStrFich := HomeDir + StringReplace(CurrentDir, '/', PathDelim, [rfReplaceAll]) + PathDelim + APathName;

        if FileExists(lStrFich) then
          DeleteFile(lStrFich)
        else
          raise Exception.Create('Fichier "' + APathName + '" inexistant !');
      end;

      procedure TfrmPrincipale.ftpServeurMakeDirectory(ASender: TIdFTPServerContext; var VDirectory: String);
      var
        lStrDir: string;
      begin
        with ASender do
          lStrDir := HomeDir + StringReplace(VDirectory, '/', PathDelim, [rfReplaceAll]);

        if not DirectoryExists(lStrDir) then
          CreateDir(lStrDir)
        else
          raise Exception.Create('Répertoire "' + VDirectory + '" inexistant !');
      end;

      procedure TfrmPrincipale.ftpServeurRemoveDirectory(ASender: TIdFTPServerContext; var VDirectory: String);
      var
        lStrDir: string;
      begin
        with ASender do
          lStrDir := HomeDir + StringReplace(VDirectory, '/', PathDelim, [rfReplaceAll]);

        if DirectoryExists(lStrDir) then
          RemoveDir(lStrDir)
        else
          raise Exception.Create('Répertoire "' + VDirectory + '" inexistant !');
      end;

      procedure TfrmPrincipale.ftpServeurChangeDirectory(ASender: TIdFTPServerContext; var VDirectory: String);
      begin
        with ASender do
          if not DirectoryExists(HomeDir + StringReplace(VDirectory, '/', PathDelim, [rfReplaceAll])) then
            raise Exception.Create('Répertoire "' + VDirectory + '" inexistant !');
      end;

      procedure TfrmPrincipale.actFichierClientFTPExecute(Sender: TObject);
      begin
        TfrmClientFTP.Create(Self, FProjet).ShowModal;
      end;

      procedure TfrmPrincipale.actRepriseTelechargerFichiersExecute(Sender: TObject);
      var
        lListe: TStrings;
      begin
        lListe := (TfrModuleImport(FProjet.ModuleImport.IHM) as ITransfertFTP).RenvoyerFichiersATelecharger;
        if lListe.Count > 0 then
          if TfrmClientFTP.Create(Self, FProjet).ShowModal(lListe, nil, False, False) = mrOk then
            MessageDlg('Tlchargement de(s) fichier(s) réussi(s)', mtInformation, [mbOk], 0)
          else
            MessageDlg('Téléchargement de(s) fichier(s) interrompu(s)', mtError, [mbOk], 0);
      end;

      procedure TfrmPrincipale.ChangerModeTraitement(Sender: TObject);
      var
        i: Integer;
        lMode: TModeTraitement;
      begin
        with Sender as TAction do
        begin
          with amMenuPrincipale.ActionBars[C_BANDE_MENU_REPRISE].Items[Tag shr 16] do
            for i := 0 to Items.Count - 1 do
              if Items[i].Action <> Sender then
                TAction(Items[i].Action).Checked := False;

          lMode := TModeTraitement(Tag and $00FF);
          case TTypeModule((Tag and $FF00) shr 8) of
            tmImport:
              (FProjet.ModuleImport.IHM as TfrModule).Mode := lMode;
            tmTransfert:
              (FProjet.ModuleTransfert.IHM as TfrModule).Mode := lMode;
        end;

        MAJTitreFenetre;
      end;
    end;

    procedure TfrmPrincipale.MAJTitreFenetre;
    begin
      Caption := Application.Title + ' [' + uppercase(ExtractFileName(od.FileName)) + '][' + TModule.LibelleTypeModule
        [FProjet.ModuleEnCours.TypeModule] + '][' + TfrModule.LibelleModeTraitement[TfrModule(FProjet.ModuleEnCours.IHM).Mode]
        + ']';
    end;

    procedure TfrmPrincipale.mnuAnydeskClick(Sender: TObject);
begin

 ShellExecute(0, 'open', '.\anydesk-launcher.exe', nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmPrincipale.mnuOutilsClick(Sender: TObject);
    var
      info: TJclPeImage;
    begin
      with Sender as TMenuItem do
      begin
        info := TJclPeImage(Tag);
        ShellExecute(0, 'open', PChar(info.FileName), nil, nil, SW_NORMAL);
      end;
    end;

    procedure TfrmPrincipale.icmpServeurMAJReply(ASender: TComponent; const AReplyStatus: TReplyStatus);
    begin
      if AReplyStatus.ReplyStatusType = rsEcho then
        FServeurMAJ := icmpServeurMAJ.Tag;
    end;

    procedure TfrmPrincipale.tmPingServeurMAJTimer(Sender: TObject);
    begin
      if Assigned(Projet) then
      begin
        if not Projet.Ouvert or (Projet.Ouvert and Assigned(Projet.ModuleEnCours) and not TfrModule(Projet.ModuleEnCours.IHM)
            .EnTraitement) then
        begin
          FNombreMAJ := 0;
          FRSS.Rafraichir;
        end;

        // Vrification de la prcense du serveur de MAJ
        try
          if Projet.Ouvert then
          begin
            if not(Projet.ModuleEnCours.IHM as TfrModule).EnTraitement then
              icmpServeurMAJ.Ping;
          end
          else
            icmpServeurMAJ.Ping;
        except
          on E: EIdSocketError do
            actAideMAJ.Enabled := E.LastError <> Id_WSAEHOSTUNREACH
          else
            actAideMAJ.Enabled := False;
        end;
      end;
    end;

    procedure TfrmPrincipale.TrayIcon1BalloonClick(Sender: TObject);
    begin
      if Assigned((FProjet.ModuleEnCours.IHM as TfrModule).TraitementEnCours) then
        if (FProjet.ModuleEnCours.IHM as TfrModule).TraitementEnCours.Fait then
          TrayIcon1DblClick(Self);
    end;

    procedure TfrmPrincipale.TrayIcon1DblClick(Sender: TObject);
    begin
      Application.Restore;
      Application.BringToFront;
    end;

    procedure TfrmPrincipale.TrayIcon1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
      if (Button = mbRight) and Assigned((FProjet.ModuleEnCours.IHM as TfrModule).TraitementEnCours) then
      begin
        frmDetailTraitementEnCours := TfrmDetailTraitementEnCours.Create(Self,
          (FProjet.ModuleEnCours.IHM as TfrModule).TraitementEnCours);
        frmDetailTraitementEnCours.Show;
      end;
    end;

    procedure TfrmPrincipale.CMModuleAide(var Msg: TMessage);
    begin
      TfrmAide.Create(Self, FProjet).ShowModal(Projet.ModuleEnCours.NomModule);
    end;

    procedure TfrmPrincipale.SurApresChargerFluxRSS(Sender: TObject);
    var
      lDtDateDernMAJ: TDateTime;
      lIntNbItem, i: Integer;
      n: PVirtualNode;
      lp: PrecMAJ;
      rss: TItemRSS;
      p: TPoint;
    begin
      if not Assigned(frmMAJCommit) and (not Projet.Ouvert or (Projet.Ouvert and Assigned(Projet.ModuleEnCours) and not TfrModule
            (Projet.ModuleEnCours.IHM).EnTraitement)) then
      begin
        with Projet do
          if Ouvert then
          begin
            if Assigned(ModuleImport) then
              TfrModule(ModuleImport.IHM).vstMAJModule.Clear;
            if Assigned(ModuleTransfert) then
              TfrModule(ModuleTransfert.IHM).vstMAJModule.Clear;
          end;

        lDtDateDernMAJ := IncMonth(Now, -6);

        SetFocus;
        lIntNbItem := amMenuPrincipale.ActionBars[C_BANDE_MENU_AIDE].Items[C_BANDE_MENU_AIDE_MAJ].Items.Count;
        amMenuPrincipale.ActionBars[C_BANDE_MENU_AIDE].Items[C_BANDE_MENU_AIDE_MAJ].Items.Clear;
        for i := 0 to FRSS.Total - 1 do
        begin
          rss := FRSS.Items[i];

          // Accessibilité par menu
          if rss.Publication > lDtDateDernMAJ then
            with amMenuPrincipale.ActionBars[C_BANDE_MENU_AIDE].Items[C_BANDE_MENU_AIDE_MAJ].Items.Add do
            begin
              Action := TAction.Create(Self);
              with TAction(Action) do
              begin
                Caption := FRSS.Items[i].Categorie + ' : ' + FRSS.Items[i].Titre + ' (' + FormatDateTime('DD/MM/YYYY',
                  FRSS.Items[i].Publication) + ')';
                OnExecute := actItemRSSExecute;
                Tag := i;
              end;
            end;

          // Affichage dans projet ouvert
          if Projet.Ouvert then
            with Projet do
            begin
              if Assigned(ModuleImport) and (CompareText(rss.Categorie, ModuleImport.NomModule) = 0) then
                with TfrModule(ModuleImport.IHM) do
                begin
                  n := vstMAJModule.AddChild(nil);
                  lp := vstMAJModule.GetNodeData(n);
                  if Assigned(lp) then
                  begin
                    lp^.NumeroVersion := rss.Version;
                    lp^.DateDiffusion := rss.Publication;
                    lp^.Contenu := rss.Titre;
                  end;
                end;

              if Assigned(ModuleTransfert) and (CompareText(rss.Categorie, ModuleTransfert.NomModule) = 0) then
                with TfrModule(ModuleTransfert.IHM) do
                begin
                  n := vstMAJModule.AddChild(nil);
                  lp := vstMAJModule.GetNodeData(n);
                  if Assigned(lp) then
                  begin
                    lp^.NumeroVersion := rss.Version;
                    lp^.DateDiffusion := rss.Publication;
                    lp^.Contenu := rss.Titre;
                  end;
                end;
            end;
        end;

        atbMenuAide.RecreateControls;
        if amMenuPrincipale.ActionBars[C_BANDE_MENU_AIDE].Items[C_BANDE_MENU_AIDE_MAJ].Items.Count > lIntNbItem then
        begin
          p := Point(atbMenuAide.Left + atbMenuAide.ActionControls[0].Width div 2, atbMenuAide.Top + atbMenuAide.Height);
          JvBalloonHint1.ActivateHintPos(Self, p, 'Mises à jour',
            'De nouvelles mises à jour sont disponibles.' + #13#10 + 'Cliquez sur "Mise à jour" pour les télécharger !');
        end;

        with Projet do
        begin
          if Assigned(ModuleImport) then
            TfrModule(ModuleImport.IHM).spl1.Maximized := TfrModule(ModuleImport.IHM).vstMAJModule.TotalCount > 0;
          if Assigned(ModuleTransfert) then
            TfrModule(ModuleTransfert.IHM).spl1.Maximized := TfrModule(ModuleTransfert.IHM).vstMAJModule.TotalCount > 0;
        end;
      end;
    end;

    procedure TfrmPrincipale.actItemRSSExecute(Sender: TObject);
    begin
      with Sender as TAction do
        frmItemRSS.ShowModal(FRSS, Tag);
    end;

end.
