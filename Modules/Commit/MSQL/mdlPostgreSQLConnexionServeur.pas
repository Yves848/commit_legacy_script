unit mdlPostgreSQLConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils, Generics.collections, IOUtils,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, Mask, JvExMask, JvToolEdit, dumpallcut, Buttons, JvLED, JvExControls, JvLabel,
  ZAbstractConnection, ZConnection, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZSqlProcessor, ComCtrls, PNGimage,
  PerlRegEx,jclSvcCtrl, winsvc, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP,
  JvSpecialProgress, uTypes, mdlPostgresClean;

const
    WM_CHECKPGSTATE = WM_USER + 100;

type
  tBatchExec = procedure(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>) of object;



  TfrmPostgreSQLConnexionServeur = class(TfrmConnexionServeur)
    edtDumpSQL: TJvFilenameEdit;
    lblDumpSQL: TLabel;
    Button1: TButton;
    btExtract: TBitBtn;
    ZQuery1: TZQuery;
    ZConnection1: TZConnection;
    lStatusDB: TLabel;
    pgVersion: TLabel;
    Bevel1: TBevel;
    btnInstallPg: TButton;
    IdFTP1: TIdFTP;
    pgDownload: TJvSpecialProgress;
    Shape1: TShape;
    lblDump: TLabel;
    Bevel2: TBevel;
    Shape2: TShape;
    Label2: TLabel;
    Button2: TButton;
    lStatusDump: TLabel;
    procedure btExtractClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtDumpSQLChange(Sender: TObject);
    procedure edtBDChange(Sender: TObject);
    function readline(var stream: tStream; var sLine: String): Boolean;
    procedure btnInstallPgClick(Sender: TObject);
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
    fDumpAllCut: TfDumpAllCut;
    sBinPath : String;
    Function SetPGPath: Boolean;
    procedure CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
  public
    { Déclarations publiques }
    dFields: tDictionary<string, integer>;
    function ShowModal(AParametres: TStringList): integer; override;
    procedure CheckPGState(var msg : TMessage); Message WM_CHECKPGSTATE;
  end;

var
  frmPostgreSQLConnexionServeur: TfrmPostgreSQLConnexionServeur;

implementation

{$R *.dfm}

function TfrmPostgreSQLConnexionServeur.readline(var stream: tStream; var sLine: String): Boolean;
var
  ligne: String;
  ch: ansiChar;
begin
  result := false;
  ch := #0;
  while (stream.read(ch, 1) = 1) and (ch <> #10) do
  begin
    result := true;
    ligne := ligne + ch;
  end;
  sLine := ligne;
  if ch = #10 then
  begin
    result := true;
  end;
end;

procedure TfrmPostgreSQLConnexionServeur.CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
const
  CReadBuffer = 2400;
var
  saSecurity: TSecurityAttributes;
  hRead: THandle;
  hWrite: THandle;
  suiStartup: TStartupInfo;
  piProcess: TProcessInformation;
  pBuffer: array [0 .. CReadBuffer] of AnsiChar;
  dBuffer: array [0 .. CReadBuffer] of AnsiChar;
  dRead: DWORD;
  dRunning: DWORD;
  dAvailable: DWORD;
begin
  saSecurity.nLength := SizeOf(TSecurityAttributes);
  saSecurity.bInheritHandle := True;
  saSecurity.lpSecurityDescriptor := nil;
  if CreatePipe(hRead, hWrite, @saSecurity, 0) then
    try
      FillChar(suiStartup, SizeOf(TStartupInfo), #0);
      suiStartup.cb := SizeOf(TStartupInfo);
      suiStartup.hStdInput := hRead;
      suiStartup.hStdOutput := hWrite;
      suiStartup.hStdError := hWrite;
      suiStartup.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      suiStartup.wShowWindow := SW_HIDE;
      if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity, @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil,
        suiStartup, piProcess) then
        try
          repeat
            dRunning := WaitForSingleObject(piProcess.hProcess, 100);
            PeekNamedPipe(hRead, nil, 0, nil, @dAvailable, nil);
            if (dAvailable > 0) then
              repeat
                dRead := 0;
                ReadFile(hRead, pBuffer[0], CReadBuffer, dRead, nil);
                pBuffer[dRead] := #0;
                OemToCharA(pBuffer, dBuffer);
                CallBack(dBuffer);
              until (dRead < CReadBuffer);
              Application.ProcessMessages;
          until (dRunning <> WAIT_TIMEOUT);
        finally
          CloseHandle(piProcess.hProcess);
          CloseHandle(piProcess.hThread);
        end;
    finally
      CloseHandle(hRead);
      CloseHandle(hWrite);
    end;
end;


procedure TfrmPostgreSQLConnexionServeur.CheckPGState(var msg: TMessage);
begin
  //
   if SetPGPath then
    edtBDChange(Self);
end;

procedure TfrmPostgreSQLConnexionServeur.btnInstallPgClick(Sender: TObject);
const
  pgFile = 'postgresql.zip';
var
  sFTP: String;
  sPort: String;
  sLogin: String;
  sPass: String;
  sDirectory: String;

  Procedure SetLAbel(sCaption : String);
  begin
     pgVersion.Font.Color := clNavy;
     pgVersion.Font.Style := [fsItalic];
     pgVersion.Caption := sCaption;
     Application.ProcessMessages;
  end;

  function getSize(sEntry: String): integer;
  const
    regEx = '\d{5,}';
  var
    RE: tPerlRegEx;
  begin
    result := high(integer);
    RE := tPerlRegEx.Create;
    RE.regEx := regEx;
    RE.Subject := sEntry;
    if RE.Match then
      result := strtointdef(RE.MatchedText, high(integer));
    RE.Free;
  end;

  function unzipPG : boolean;
  const
    sUnzip = 'unzip.exe %s %s'; // unzip.exe pg.zip c:\opt
  var
    sCmdUnzip : String;
    batchExec: tBatchExec;
    CallBack: TArg<PAnsiChar>;
  begin
    batchExec := CaptureConsoleOutput;
    sCmdUnzip := format(sUnzip,[pgFile,'c:\opt']);

    CallBack := procedure(const Line: PAnsiChar)
    begin
      Application.ProcessMessages;
    end;
    batchExec(sCmdUnzip, '', CallBack);
    result := true;
  end;



  function installPg(sBasePath: String): integer;
  const
    sMkDir = 'cmd.exe /c mkdir c:\opt\pgsql\data'; // mkdir c:\opt\pgsql\data
    sInitDb = '%sinitdb.exe -E UTF-8 -D %s'; // initdb.exe -E UTF-8 -D c:\opt\pgsql\data
    sCreateUser = '%screateuser.exe -s %s'; // C:\opt\pgsql\bin\createuser.exe -s postgres
    sRegisterService = '%spg_ctl.exe register -D %s -N %s -S a'; // pg_ctl.exe register -D C:\opt\pgsql\data\ -N postgresqlcommit -S a
    sStartService = 'net start %s'; // net start postgresqlcommit
    sServiceName = 'postgresqlcommit';
  var
    sbinPath: String;
    sDataPath: String;
    sCmdInitDb, sCmdRegisterService, sCmdStartService : String;
    batchExec: tBatchExec;
    CallBack: TArg<PAnsiChar>;
    sResults: tStrings;
  begin

    sbinPath := IncludeTrailingBackslash(IncludeTrailingBackslash(sBasePath) + 'bin');
    sDataPath := IncludeTrailingBackslash(sBasePath) + 'data';

    sCmdInitDb := format(sInitDb, [sbinPath, sDataPath]);
    sCmdRegisterService := format(sRegisterService, [sbinPath, sDataPath, sServiceName]);
    sCmdStartService := format(sStartService, [sServiceName]);



    batchExec := CaptureConsoleOutput;
    sResults := TStringList.Create;

    CallBack := procedure(const Line: PAnsiChar)
    begin
      sResults.add(Line);
      Application.ProcessMessages;
    end;

    batchExec(sMkDir, '', CallBack);
    batchExec(sCmdInitDb, '', CallBack);
    batchExec(sCmdRegisterService, '', CallBack);
    batchExec(sCmdStartService, '', CallBack);

    SetLabel('Create Users ......');

    batchExec(format(sCreateUser,[sBinPath,'postgres']), '', CallBack);
    batchExec(format(sCreateUser,[sBinPath,'bcb']), '', CallBack);
    batchExec(format(sCreateUser,[sBinPath,'alliance']), '', CallBack);


    FreeandNil(sResults);

  end;



begin
  inherited;
  // if the file is not present .......
  if not fileexists(pgFile) then
  begin
    // ..... Download it
    SetLabel('Téléchargement ......');
    with module.Projet.FichierParametres.DocumentElement.ChildNodes['ServeursMAJ'] do
    begin
      sFTP := ChildNodes['ServeurMAJ'].Attributes['serveur'];
      sPort := ChildNodes['ServeurMAJ'].Attributes['port'];
      sLogin := ChildNodes['ServeurMAJ'].Attributes['utilisateur'];
      sPass := ChildNodes['ServeurMAJ'].Attributes['mot_de_passe'];
    end;
    IdFTP1.userNAme := sLogin;
    IdFTP1.Host := sFTP;
    IdFTP1.Port := strtointdef(sPort, 21);
    IdFTP1.Password := sPass;
    IdFTP1.Connect;
    if IdFTP1.Connected then
    begin
      try
        IdFTP1.Login;
        IdFTP1.ChangeDir('/pgInstall');
        IdFTP1.List;
        pgDownload.Maximum := getSize(IdFTP1.ListResult[0]);
        pgDownload.Visible := true;
        IdFTP1.Get(pgFile, pgFile);
      finally
        IdFTP1.Quit;
        IdFTP1.Disconnect;
        pgDownload.Visible := false;
      end;
    end;
  end;
  // .... unzip it ......
  Screen.Cursor := crHourGlass;
  SetLabel('Décompression ......');
  unzipPG;
  Screen.Cursor := crDefault;

  // ..... and now, ** install **

  SetLabel('Installation ......');
  installPg('c:\opt\pgsql');



  if SetPGPath then edtBDChange(Nil);
  

end;

procedure TfrmPostgreSQLConnexionServeur.Button1Click(Sender: TObject);
begin
  inherited;
  fDumpAllCut.gzIn := edtDumpSQL.Text;
  fDumpAllCut.folder := module.Projet.RepertoireProjet;
  fDumpAllCut.DB := edtBD.Text;
  fDumpAllCut.Password := edtMotDePasse.Text;
  fDumpAllCut.user := edtUtilisateur.Text;
  fDumpAllCut.autostart := false;
  fDumpAllCut.ShowModal;
end;

procedure TfrmPostgreSQLConnexionServeur.Button2Click(Sender: TObject);
var
  frmPostgresClean: TfrmPostgresClean;
begin
  inherited;
  frmPostgresClean := TfrmPostgresClean.Create(self);
  frmPostgresClean.ShowModal;
  frmPostgresClean.Free;
end;

procedure TfrmPostgreSQLConnexionServeur.edtBDChange(Sender: TObject);
begin
  inherited;
  lStatusDB.Visible := false;
  if edtUtilisateur.Text <> '' then
  begin
    ZConnection1.user := edtUtilisateur.Text;
    ZConnection1.Password := edtMotDePasse.Text;
    ZConnection1.Connect;
    ZQuery1.SQL.Text := format('SELECT 1 FROM pg_database WHERE datname=''%s''', [edtBD.Text]);

    try
      ZQuery1.Connection := ZConnection1;
      ZQuery1.Active := true;
      if ZQuery1.RecordCount = 1 then
      begin
        lStatusDB.Caption := 'Une Base de donnée portant le même nom existe déjà';
        lStatusDB.Visible := true;
      end;
    except
    end;
    ZQuery1.Close;
  end;
end;

procedure TfrmPostgreSQLConnexionServeur.edtDumpSQLChange(Sender: TObject);
var
  iDiskfree, iUncompSize: Int64;
begin
  inherited;
  lStatusDump.Visible := False;
  if FileExists(edtDumpSQL.Text) then
  begin
    // Vérifier le type de dump à restaurer ....
    if pos('.GZ', uppercase(edtDumpSQL.Text)) > 0 then
    begin
      btExtract.Caption := 'Extraire le Dump';
      btExtract.Tag := 1;
    end
    else
    begin
      btExtract.Caption := 'Restaurer le Dump';
      btExtract.Tag := 1;
    end;
  end
  else
  begin
    lStatusDump.Caption := 'fichier dump introuvable';
    lStatusDump.Font.Color := clRed;
    lStatusDump.Visible := True;
  end;

end;

procedure TfrmPostgreSQLConnexionServeur.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  inherited;
  //
  if AWorkMode = TWorkMode.wmRead then
  begin
    pgDownload.Position := AWorkCount;
  end;
end;

procedure TfrmPostgreSQLConnexionServeur.IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  inherited;
  //
  if AWorkMode = TWorkMode.wmRead then
  begin
    pgDownload.Position := 0;
  end;
end;

function TfrmPostgreSQLConnexionServeur.SetPGPath: Boolean;
var
  sPgPath: String;

  function getVersion(sEntry: String): String;
  const
    regEx = '\d{1,2}\.\d{1,2}';
  var
    RE: tPerlRegEx;
  begin
    result := 'N/A';
    RE := tPerlRegEx.Create;
    RE.regEx := regEx;
    RE.Subject := sEntry;
    if RE.Match then
      result := RE.MatchedText;
    RE.Free;
  end;

  function GetPGVersion(sBinPath : String) : String;
  const
    sVers = '%spsql.exe -V'; // unzip.exe pg.zip c:\opt
  var
    sCmdVersion : String;
    batchExec: tBatchExec;
    CallBack: TArg<PAnsiChar>;
    sVersion : String;
  begin
    batchExec := CaptureConsoleOutput;
    sCmdVersion := format(sVers,[sBinPath]);
    sVersion := 'N/A';
    CallBack := procedure(const Line: PAnsiChar)
    begin
      sVersion := Line;
      Application.ProcessMessages;
    end;

    batchExec(sCmdVersion, '', CallBack);
    sVersion := GetVersion(sVersion);
    result := sVersion;
  end;

  function getPostgreSQLPAth: String;
  const
    TIMEOUT = 30;
  var
    scManager: TJclSCManager;
    NtSvc: TJclNtService;
    i: integer;
    RE: tPerlRegEx;
    _start : Integer;
    _duration : Integer;
  begin
    scManager := TJclSCManager.Create('', SC_MANAGER_ALL_ACCESS);
    try
      scManager.refresh(true);
      RE := tPerlRegEx.Create;
      RE.regEx := '[\w\s\:\\]*pg_ctl.exe';
      RE.Study;
    finally
      i := 0;
      result := '';
      while i <= scManager.ServiceCount - 1 do
      begin
        NtSvc := TJclNtService(scManager.services[i]);
        if pos('postgresql', NtSvc.DisplayName) > 0 then
        begin
          RE.Subject := NtSvc.FileName;
          if RE.Match then
          begin
            if NtSvc.ServiceState <> TJclServiceState.ssRunning then
            begin
              NtSvc.Start(true);
              _start := GetTickCount;
              _Duration := 0;
              while (not (NtSvc.Servicestate in [TJclServiceState.ssRunning]))  do
              begin
                _Duration := GetTickCount - _Start;
                if (_Duration div 200) = 0 then
                begin
                   NtSvc.Refresh;
                   Application.ProcessMessages;
                end;
                if _Duration > (TIMEOUT * 1000) then
                  Break;
              end;
            end;

            if NtSvc.ServiceState = TJclServiceState.ssRunning then
            begin
              result := IncludeTrailingBackslash(tPath.GetDirectoryName(RE.MatchedText));
              i := scManager.ServiceCount;
            end;
          end;

        end;
        inc(i);
      end;
      RE.Free;
    end;
    scManager.Free;
  end;

  procedure setLabelError;
  begin
    pgVersion.Font.Style := [fsBold];
    pgVersion.Font.Color := clRed;
    btnInstallPg.Visible := true;
  end;

  procedure setLabelOk;
  begin
    pgVersion.Font.Style := [];
    pgVersion.Font.Color := clGreen;
    btnInstallPg.Visible := false;
  end;

begin
  result := false;
  sPgPath := getPostgreSQLPAth;
  if trim(sPgPath) = '' then
  begin
    pgVersion.Caption := 'Aucun serveur PostgreSQL détécté';
    setLabelError;
  end
  else
  begin
    //pgVersion.Caption := 'PostgreSQL détécté';
    pgVersion.Caption := format('PostgreSQL version %s',[GetPGVersion(sPgPath)]);
    //fDumpAllCut.sPgBinPath := sPgPath;
    sBinPath := sPgPath;
    setLabelOk;
    result := true;
  end;
end;

procedure TfrmPostgreSQLConnexionServeur.btExtractClick(Sender: TObject);

begin
  inherited;
  if fileexists(edtDumpSQL.Text) then
  begin
    fDumpAllCut := TfDumpAllCut.Create(nil);
    lStatusDB.Visible := false;
    fDumpAllCut.gzIn := edtDumpSQL.Text;
    // Si c'est un "NEV", pas de découpe de dump
    fDumpAllCut.bNoCut := (Module.NomModule = 'NEV');
    fDumpAllCut.folder := module.Projet.RepertoireProjet;
    fDumpAllCut.DB := edtBD.Text;
    fDumpAllCut.Password := edtMotDePasse.Text;
    fDumpAllCut.user := edtUtilisateur.Text;
    fDumpAllCut.bPartiel := btExtract.Tag;
    fDumpAllCut.sPgBinPath := sBinPath;
  {$IFNDEF DEGBUG}
    fDumpAllCut.autostart := true;
  {$ENDIF}
    fDumpAllCut.ShowModal;
    fDumpAllCut.Free;
  end
  else
  begin
    ShowMessage('Fichier dump introuvable');
    Module.Projet.Console.Ajouter('Le fichier dumpallcut spécifié est introuvable');
    Module.Projet.Console.Ajouter(format('=> %s',[edtDumpSQL.Text]));
  end;

end;

function TfrmPostgreSQLConnexionServeur.ShowModal(AParametres: TStringList): integer;
begin
  edtServeur.Text := AParametres.Values['serveur'];
  edtBD.Text := AParametres.Values['bd'];
  edtUtilisateur.Text := AParametres.Values['utilisateur'];
  edtMotDePasse.Text := AParametres.Values['mot_de_passe'];
  edtDumpSQL.Text := AParametres.Values['dump_postgres'];
  PostMessage(self.Handle,WM_CHECKPGSTATE,0,0);

  encodingInit;
  sModule := uppercase(Module.Projet.ModuleEnCours.NomModule);
  tPgEncoding.TryGetValue(sModule,sEncoding);

  lblDump.Caption := 'Dump '+Module.Projet.ModuleEnCours.NomModule;

  result := inherited ShowModal(AParametres);
  AParametres.Values['bd'] := edtBD.Text;
  AParametres.Values['serveur'] := edtServeur.Text;
  AParametres.Values['utilisateur'] := edtUtilisateur.Text;
  AParametres.Values['mot_de_passe'] := edtMotDePasse.Text;
  AParametres.Values['dump_postgres'] := edtDumpSQL.Text;
end;

end.
