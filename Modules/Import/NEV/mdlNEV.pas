unit mdlNEV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ioutils,
  Dialogs, mdlModule, mdlModuleImport, DB, PdfDoc, PReport, ExtCtrls, Menus, mdlAttente,
  JvMenus, JvWizard, JvWizardRouteMapNodes, mdlPIPanel, ComCtrls, Grids, mdlProjet,
  mdlPIStringGrid, DBGrids, mdlPIDBGrid, JvExControls, uib,
  JvXPCore, JvXPContainer, ImgList, ActnList, JclStrings, StrUtils, JvXPBar,
  StdCtrls, mdlPIButton, mdlConversionsTIFF, VirtualTrees, JvExExtCtrls, JvNetscapeSplitter,
  mdlTypes, mdlMIPostgreSQL, XMLIntf, JclFileUtils, jclPcre, ZSqlProcessor, ZAbstractConnection, ZConnection, Types, Registry, DateUtils;

type

  tSearchPj4 = class(tThread)
  protected
    Procedure Execute; override;
    Procedure DoTerminate; override;
  end;

  TfrNEV = class(TfrMIPostgreSQL)
    grdProgrammesFidelites: TPIStringGrid;
    wipProgrammesFidelites: TJvWizardInteriorPage;
    ZConnection1: TZConnection;
    ZSQLProc: TZSQLProcessor;
    procedure wzDonneesActivePageChanged(Sender: TObject);
  private
    { Déclarations privées }

  protected
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    procedure TraiterProgrammesFidelites;
    procedure AddPathToEnvironmentVariable(const NewPath: string);
    function readline(var stream: tStream; var sLine: String): Boolean;

  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
    procedure MakeTemplate(csvFile: String);
  end;

implementation

uses mdlNEVPHA, uImportCSV;
{$R *.dfm}

constructor TfrNEV.Create(AOwner: TComponent; AModule: TModule);
begin
  inherited;
  ModeConnexion := mcServeurSQL;
end;

procedure TfrNEV.wzDonneesActivePageChanged(Sender: TObject);
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
    TraiterDonnees(wipProgrammesFidelites, grdProgrammesFidelites, false, TPIList<Integer>.Create([Ord(suppCarteFidelite)]),
      TraiterProgrammesFidelites);
  // on ne touche pas à suppCarteFidelite (qui devrait être suppprogrammefidelits car ça vient de projet
end;

procedure TfrNEV.RenvoyerParametresConnexion;
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
      PHA.ParametresConnexion.Values['bd'] := changeFileExt(ExtractFileName(Module.Projet.FichierProjet.FileName), '');
    // 'NEV';
    if HasAttribute('utilisateur') then
      PHA.ParametresConnexion.Values['utilisateur'] := Attributes['utilisateur']
    else
      PHA.ParametresConnexion.Values['utilisateur'] := 'postgres';
    if HasAttribute('mot_de_passe') then
      PHA.ParametresConnexion.Values['mot_de_passe'] := Attributes['mot_de_passe']
    else
      PHA.ParametresConnexion.Values['mot_de_passe'] := 'postgres';

    // if HasAttribute('dump_postgres') then
    // PHA.ParametresConnexion.Values['dump_postgres'] := Attributes['dump_postgres']
    // else

    // PHA.ParametresConnexion.Values['dump_postgres'] := Module.Projet.RepertoireProjet + 'dump.sql';
    // YG : temporaire.  Le temps de résoudre jira REPF-2995
    PHA.ParametresConnexion.Values['dump_postgres'] := IncludeTrailingBackslash(Module.RepertoireRessources) + 'dump.sql'
  end;
end;

procedure TfrNEV.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['import'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['bd'] := PHA.ParametresConnexion.Values['bd'];
    Attributes['utilisateur'] := PHA.ParametresConnexion.Values['utilisateur'];
    Attributes['mot_de_passe'] := PHA.ParametresConnexion.Values['mot_de_passe'];
  end;
end;

procedure TfrNEV.TraiterDonneesPraticiens;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Praticiens']);
end;

procedure TfrNEV.TraiterDonneesOrganismes;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Destinataires']);
  TraiterDonnee(Traitements.Traitements['Organismes']);
  TraiterDonnee(Traitements.Traitements['Contrats']);
end;

procedure TfrNEV.AddPathToEnvironmentVariable(const NewPath: string);
var
  Reg: TRegistry;
  CurrentPath: string;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Environment', True) then
    begin
      if Reg.ValueExists('Path') then
        CurrentPath := Reg.ReadString('Path')
      else
        CurrentPath := '';
      if Pos(LowerCase(NewPath), LowerCase(CurrentPath)) = 0 then
      begin
        Reg.WriteString('Path', CurrentPath + ';' + NewPath);
        SendMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0, LPARAM(PChar('Environment')));
      end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TfrNEV.MakeTemplate(csvFile: String);
  const
    CReadBuffer = 2400;
    WatchdogTimeout = 5;
  var
    saSecurity: TSecurityAttributes;
    hRead, hWrite: THandle;
    suiStartup: TStartupInfo;
    piProcess: TProcessInformation;
    dRunning: DWORD;
    aCommand: string;
    pgpath: string;
    initialWriteTime, currentWriteTime, startTime: TDateTime;
    LogMessage: string;
begin
  try
    csvFile := StringReplace(csvFile, ' ', '` ', [rfReplaceAll]);
    AddPathToEnvironmentVariable('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe');
    aCommand := Format('powershell -noprofile -ExecutionPolicy Bypass -File "%s\Modules\Import\Ressources\NEV\make_pg.ps1" -path "%s" -projetPath "%s"',
      [Module.Projet.RepertoireApplication, csvFile, ExcludeTrailingPathDelimiter(Module.Projet.RepertoireProjet)]);
    pgpath := Module.Projet.RepertoireProjet + 
              TPath.GetFileNameWithoutExtension(csvFile) + '.pg';
    // Récupérer l'horodatage initial de $pgpath
    if TFile.Exists(pgpath) then
    begin
      initialWriteTime := TFile.GetLastWriteTime(pgpath);
    end
    else
    begin
      initialWriteTime := 0;
    end;
    
    saSecurity.nLength := SizeOf(TSecurityAttributes);
    saSecurity.bInheritHandle := True;
    saSecurity.lpSecurityDescriptor := nil;

    FillChar(suiStartup, SizeOf(TStartupInfo), #0);
    suiStartup.cb := SizeOf(TStartupInfo);
    suiStartup.dwFlags := STARTF_USESHOWWINDOW;
    suiStartup.wShowWindow := SW_HIDE;
    // TODO: Build ACommand
   if CreateProcess(nil, PChar(ACommand), nil, nil, False, CREATE_NO_WINDOW, nil, PChar(Module.Projet.RepertoireApplication), suiStartup, piProcess) then
    begin
      try
        repeat
          dRunning := WaitForSingleObject(piProcess.hProcess, 100);
          Application.ProcessMessages;
        until (dRunning <> WAIT_TIMEOUT);
      finally
        CloseHandle(piProcess.hProcess);
        CloseHandle(piProcess.hThread);
      end;
    end
    else
    begin
      Module.Projet.Console.AjouterLigne('Erreur lors du lancement du processus PowerShell.');
      Exit;
    end;
    startTime := Now;
    // Attendre que $pgpath soit mis à jour
    while True do
    begin
      if TFile.Exists(pgpath) then
      begin
        currentWriteTime := TFile.GetLastWriteTime(pgpath);
        // Module.Projet.Console.AjouterLigne(LogMessage);

        // Vérifier si l'horodatage a changé
        if (currentWriteTime > initialWriteTime) then
        begin
          // Module.Projet.Console.AjouterLigne('pgpath a été mis à jour.');
          Break;
        end
        else
        begin
          Module.Projet.Console.AjouterLigne('pgpath pas encore été mis à jour.');
        end;
      end
      else
      begin
        Module.Projet.Console.AjouterLigne('pgpath n existe pas.');
      end;

      if SecondsBetween(Now, startTime) > WatchdogTimeout then
      begin
        Module.Projet.Console.AjouterLigne(Format('Timeout. La génération de pgpath a pris plus de %d secondes.', [WatchdogTimeout]));
        Break;
      end;
      Sleep(1000);
      Application.ProcessMessages;
    end;
  except
    on E: Exception do
    begin
      Module.Projet.Console.AjouterLigne(Format('Exception dans MakeTemplate : %s', [E.Message]));
    end;
  end;
end;


procedure TfrNEV.TraiterDonnee(ATraitement: TTraitement);
var
  sPAth: String;

  Function GetHeaders(csvFile: String): String;
  var
    fCSV: tStream;
  begin
    fCSV := TFileStream.Create(csvFile, fmOpenRead);
    readline(fCSV, result);
    fCSV.free;
  end;

  Procedure SetHeaders(sStrings: tStrings; Headers: String);
  var
    i: Integer;
  begin
    i := 0;
    while i <= sStrings.Count - 1 do
    begin
      if pos('##FIELDS##', sStrings[i]) > 0 then
      begin
        sStrings[i] := StringReplace(sStrings[i], '##FIELDS##', Headers, [rfReplaceAll, rfIgnoreCase]);
        i := sStrings.Count;
      end;
      inc(i);
    end;
  end;

  procedure Execute;
  begin
    ZSQLProc.Connection := ZConnection1;
    if not ZConnection1.Connected then
    begin
      ZConnection1.HostName := PHA.ParametresConnexion.Values['serveur'];
      ZConnection1.Port := 5432;
      ZConnection1.Database := PHA.ParametresConnexion.Values['bd'];
      ZConnection1.Connect;
    end;
    ZSQLProc.Execute;
  end;

  procedure RemoveStartingNewLineFromFile(const FileName: string);
  var
    Reader: TStreamReader;
    Writer: TStreamWriter;
    Line: String;
    DoSearch: Boolean;
    DoWrite: Boolean;

  begin
    Reader := TStreamReader.Create(FileName);
    Writer := TStreamWriter.Create(TPath.ChangeExtension(FileName, '.new'));
    try
      DoSearch := True;
      DoWrite := True;
      while Reader.Peek >= 0 do
      begin
        Line := Reader.readline;
        if DoSearch then
        begin
          DoSearch := not(Line = '');
          DoWrite := DoSearch;
        end;
        if DoWrite then
          Writer.WriteLine(Line)
        else
          DoWrite := True;
      end;
    finally
      Reader.free;
      Writer.free;
      DeleteFile(FileName);
      RenameFile(TPath.ChangeExtension(FileName, '.new'), FileName);
    end;
  end;

  procedure importCSV(csvFile: String);
  var
    sCsv: String;
    sHeaders: String;
    tfImportCSV: TtfImportCSV;
  begin
    screen.Cursor := crSQLWait;
    tfImportCSV := TtfImportCSV.Create(self);
    tfImportCSV.Caption := 'Import CSV en cours';
    tfImportCSV.lblCSV.Caption := Format('%s : %s', [ATraitement.Fichier, csvFile]);
    tfImportCSV.Show;
    Application.ProcessMessages;
    sCsv := Format('%s%s.csv', [sPAth, csvFile]);
    ZSQLProc.Script.LoadFromFile(Format('%s\%s.pg', [Module.Projet.RepertoireProjet, csvFile]));
    // set fields list.
    RemoveStartingNewLineFromFile(sCsv);
    sHeaders := GetHeaders(sCsv);
    SetHeaders(ZSQLProc.Script, sHeaders);
    Execute;

    ZSQLProc.Script.Clear;
    ZSQLProc.Script.Text := Format('select fctCreate%s(''%s'')', [csvFile, sCsv]);
    Execute;
    screen.Cursor := crDefault;
    tfImportCSV.free;
  end;


  procedure LaunchImport(csvFile: String);
  var
    filepath : string;
  begin
    filepath := Format('%s%s.csv', [sPAth, csvFile]);
    if fileExists(filepath) then
    begin
      MakeTemplate(filepath);
      importCSV(csvFile);
    end;
  end;

begin
  // traiter les csv;
  sPAth := IncludeTrailingBackslash(Module.Projet.RepertoireProjet);

  if ATraitement.Fichier = 'Praticiens' then
  begin
    LaunchImport('af05');
    LaunchImport('af07');
    LaunchImport('af09');
  end;

  if ATraitement.Fichier = 'Clients' then
  begin
    LaunchImport('af04');
    LaunchImport('afconta');
    LaunchImport('afnota');
  end;

  if ATraitement.Fichier = 'Liaisons' then
  begin
    LaunchImport('af08');
  end;

  if ATraitement.Fichier = 'Maj Org clients' then
  begin
    LaunchImport('afsass');
  end;

  if ATraitement.Fichier = 'Maj Couv clients' then
  begin
    LaunchImport('afsben');
  end;

  if ATraitement.Fichier = 'Destinataires' then
  begin
    LaunchImport('afzdes');
  end;

  if ATraitement.Fichier = 'Organismes' then
  begin
    LaunchImport('af50');
  end;

  if ATraitement.Fichier = 'Organismes' then
  begin
    LaunchImport('af15');
  end;

  if ATraitement.Fichier = 'Produits' then
  begin
    LaunchImport('afb1');
    LaunchImport('afztab');
    LaunchImport('afnotap');
  end;

  if ATraitement.Fichier = 'Stocks' then
  begin
    LaunchImport('afb1');
  end;

  if ATraitement.Fichier = 'Codes Produits' then
  begin
    LaunchImport('afb1cod');
  end;

  if ATraitement.Fichier = 'Fournisseurs - Répartiteurs' then
  begin
    LaunchImport('afb5');
    LaunchImport('af30');
    LaunchImport('af07');
    LaunchImport('af09');
    LaunchImport('afnota');
  end;

  if ATraitement.Fichier = 'Familles Internes' then
  begin
    LaunchImport('afalfam');
  end;

  if ATraitement.Fichier = 'Zones Geo' then
  begin
    LaunchImport('afcgeo');
  end;

  if ATraitement.Fichier = 'Stocks' then
  begin
    LaunchImport('afb1');
  end;

  if ATraitement.Fichier = 'Vignettes Avancées' then
  begin
    LaunchImport('af37');
  end;

  if ATraitement.Fichier = 'Produits Dus' then
  begin
    LaunchImport('af37');
  end;

  if ATraitement.Fichier = 'Factures en attente' then
  begin
    LaunchImport('af21');
  end;

  if ATraitement.Fichier = 'Credits' then
  begin
    LaunchImport('af04');
  end;

  if ATraitement.Fichier = 'Historique délivrances entêtes' then
  begin
    LaunchImport('af21');
  end;

  if ATraitement.Fichier = 'Historique délivrances lignes' then
  begin
    LaunchImport('af25');
  end;

  if ATraitement.Fichier = 'Commandes' then
  begin
    LaunchImport('af31');
  end;

  if ATraitement.Fichier = 'Commandes lignes' then
  begin
    LaunchImport('af32');
  end;

  if ATraitement.Fichier = 'Catalogues fournisseurs' then
  begin
    LaunchImport('aff5');
  end;

  if ATraitement.Fichier = 'Catalogues fourn - Prod' then
  begin
    LaunchImport('aff81lp');
    LaunchImport('aff82ps');
  end;

  if ATraitement.Fichier = 'Opérateurs' then
  begin
    LaunchImport('af23');
  end;

  if ATraitement.Fichier = 'Cartes Programmes Relationnels' then
  begin
    LaunchImport('fidrxcartes');
  end;

  if ATraitement.Fichier = 'Documents scannés'  then
  begin
    if (GetKeyState(VK_SHIFT) and $8000) = 0 then  // maintient de shift bypass la remontée de csv
      LaunchImport('afpsdic');
    if not(DirectoryExists(Module.Projet.RepertoireProjet + 'scan')) then
      Module.Projet.Console.AjouterLigne('Attention le dossier scan est absent, il faudra le copier dans le repertoire de projet pour transferer');
  end;

  inherited TraiterDonnee(ATraitement);

end;

procedure TfrNEV.TraiterDonneesClients;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Clients']);
  TraiterDonnee(Traitements.Traitements['Liaisons']);
  TraiterDonnee(Traitements.Traitements['Contrats clients']);
  TraiterDonnee(Traitements.Traitements['Maj Org clients']);
  TraiterDonnee(Traitements.Traitements['Maj Couv clients']);
end;

procedure TfrNEV.TraiterDonneesProduits;
begin
  inherited;

  TraiterDonnee(Traitements.Traitements['Fournisseurs - Répartiteurs']);
  TraiterDonnee(Traitements.Traitements['Familles Internes']);
  TraiterDonnee(Traitements.Traitements['Zones Geo']);
  TraiterDonnee(Traitements.Traitements['Produits']);
  TraiterDonnee(Traitements.Traitements['Stocks']);
  TraiterDonnee(Traitements.Traitements['Codes Produits']);
  TraiterDonnee(Traitements.Traitements['Histo Ventes']);
  TraiterDonnee(Traitements.Traitements['Produits - Lpp']);
end;

procedure TfrNEV.TraiterDonneesEncours;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Vignettes Avancées']);
  TraiterDonnee(Traitements.Traitements['Produits Dus']);
  TraiterDonnee(Traitements.Traitements['Credits']);
  // TraiterDonnee(Traitements.Traitements['Factures en attente']);
end;

procedure TfrNEV.TraiterAutresDonnees;
begin
  inherited;
  TraiterDonnee(Traitements.Traitements['Opérateurs']);
  TraiterDonnee(Traitements.Traitements['Historique délivrances entêtes']);
  TraiterDonnee(Traitements.Traitements['Historique délivrances lignes']);
  TraiterDonnee(Traitements.Traitements['Commandes']);
  TraiterDonnee(Traitements.Traitements['Commandes lignes']);
  TraiterDonnee(Traitements.Traitements['Catalogues fournisseurs']);
  TraiterDonnee(Traitements.Traitements['Catalogues fourn - Prod']);
  TraiterDonnee(Traitements.Traitements['Documents scannés']);

end;

procedure TfrNEV.TraiterProgrammesFidelites;
begin
  TraiterDonnee(Traitements.Traitements['Cartes Programmes Relationnels']);
end;


function TfrNEV.readline(var stream: tStream; var sLine: String): Boolean;
var
  ligne: String;
  ch: AnsiChar;
begin
  result := false;
  ch := #0;
  while (stream.read(ch, 1) = 1) and (ch <> #10) do
  begin
    result := True;
    ligne := ligne + ch;
  end;
  sLine := ligne;
  if ch = #10 then
  begin
    result := True;
    // if (stream.read(ch, 1) = 1) and (ch <> #10) then
    // stream.Seek(-1, soCurrent)
  end;
end;

{ tSearchPj4 }

procedure tSearchPj4.DoTerminate;
begin
  inherited;

end;

procedure tSearchPj4.Execute;
begin
  inherited;
  Application.ProcessMessages;
end;

initialization

RegisterClasses([TfrNEV, TdmNEVPHA]);

finalization

UnRegisterClasses([TfrNEV, TdmNEVPHA]);

end.
