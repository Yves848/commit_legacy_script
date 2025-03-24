unit dumpallcut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IOutils, Types, ShlObj,
  Dialogs, StdCtrls, ComCtrls, JvExComCtrls, JvProgressBar, Buttons, JvExButtons, JvBitBtn, ZSqlProcessor, ZAbstractConnection,
  ZConnection,
  JvExControls, JvLED, JvExStdCtrls, JvMemo, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, JvExGrids, JvStringGrid,
  ExtCtrls, zlibExGZ, JvExExtCtrls, JvExtComponent, JvItemsPanel, Gauges, JvCaptionPanel, JvAnimatedImage, JvGIFCtrl, PerlRegEx,
  jclSvcCtrl, winsvc;

const
  batchName = 'createDbAuto.bat';
  WM_START = WM_USER + 100;

type
  tBuffer = array [0 .. 4095] of byte;
  TArg<T> = reference to procedure(const Arg: T);

  TfDumpAllCut = class(TForm)
    Button1: TButton;
    JvBitBtn1: TJvBitBtn;
    ZConnection1: TZConnection;
    Button2: TButton;
    ZQuery1: TZQuery;
    Memo1: TJvMemo;
    pb1: TGauge;
    cp1: TJvCaptionPanel;
    Gauge1: TGauge;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    sStart: TEdit;
    sStop: TEdit;
    sDuree: TEdit;
    sLabel1: TLabel;
    JvGIFAnimator1: TJvGIFAnimator;
    procedure Button1Click(Sender: TObject);
    procedure JvBitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Déclarations privées }

    batchFile: String;
    procedure decompGZ(sFile: String);
    procedure cutDump;
    procedure restoreDump;
    procedure ExecuteAndWait(const aCommando: string);
    function formatVersion(sBinPath: String): String;
    function getPostGresVersion: string;
    Function checkDBExists: Boolean;
    procedure dropDB;
    function GetDiskFreeSpace(sDrive: String): int64;

  public
    { Déclarations publiques }
    DB: String;
    gzIn: string;
    sqlIn: string;
    sqlOut: string;
    autostart: Boolean;
    user: String;
    password: String;
    folder: string;
    bPartiel: Integer;
    sPgBinPath : String;
    // procedure itemProgress(sender : tObject; item : tAbArchiveItem; progress : byte; var abort: boolean);
    // procedure archiveProgress(sender : tObject; progress : byte; var abort: boolean);
    procedure CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
    procedure onStart(var Msg: TMessage); message WM_START;
    function getFreeDiskSpace: int64;
    procedure start;
  end;

var
  fDumpAllCut: TfDumpAllCut;

implementation

function TfDumpAllCut.getFreeDiskSpace: int64;
begin
  result := GetDiskFreeSpace('C:');
end;

procedure TfDumpAllCut.CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
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

function TfDumpAllCut.GetDiskFreeSpace(sDrive: String): int64;
var
  TailleTotale, EspaceUtilise, EspaceLibre: int64;
  iPercent: Integer;
begin
  if GetDiskFreeSpaceEx(PChar(sDrive), EspaceUtilise, TailleTotale, @EspaceLibre) then
  begin
    iPercent := round((EspaceUtilise) / TailleTotale * 100);
    if iPercent in [0 .. 25] then
    begin
      Gauge1.ForeColor := clRed;
    end;
    if iPercent in [26 .. 75] then
    begin
      Gauge1.ForeColor := clYellow;
    end;
    if iPercent in [76 .. 100] then
    begin
      Gauge1.ForeColor := clLime;
    end;
    Gauge1.Progress := iPercent;
    result := EspaceLibre;
  end;
end;

procedure TfDumpAllCut.onStart(var Msg: TMessage);
begin
  refresh;
  Application.ProcessMessages;
  start;
end;

function TfDumpAllCut.formatVersion(sBinPath: String): string;
var
  lStrings: tStrings;
  i: Integer;
begin
  lStrings := tStringList.Create;
  lStrings.Delimiter := '\';
  lStrings.StrictDelimiter := True;
  lStrings.DelimitedText := uppercase(sBinPath);
  i := lStrings.IndexOf('POSTGRESQL');
  result := '';
  if (i <> 0) and (i < lStrings.Count - 1) then
    result := lStrings[i + 1];
  lStrings.Free;
end;

procedure TfDumpAllCut.FormCreate(Sender: TObject);
begin
  autostart := False;
end;

procedure TfDumpAllCut.FormShow(Sender: TObject);
begin
  //
  if autostart then
    postMessage(self.Handle, WM_START, 0, 0);
end;

procedure TfDumpAllCut.restoreDump;
var
  sCmd: String;
begin
  sCmd := format('%s %s %s %s', [batchFile, password, user, DB]);
  CaptureConsoleOutput(sCmd, '', procedure(const Line: PAnsiChar)begin Memo1.Lines.Add(String(Line)); GetDiskFreeSpace('c:');
    Application.ProcessMessages; end);
  deletefile(batchFile);
end;

function TfDumpAllCut.getPostGresVersion: string;
const
  createdbString = '"%s"%s -U %%2 -w -E UTF-8 -T template0 %%3';
  psqlString0 = '"%s"%s -U %%2 -w -d %%3 -f "%s%%3.dump.sql"';
  psqlString1 = '"%s"%s -U %%2 -w -d %%3 -f "%s"';

  procedure MakeBatch(sPath: String);
  var
    sBat: tStrings;
    sBinPath: String;
  begin
    sBinPath := IncludeTrailingBackslash(sPath);
    sBat := tStringList.Create;
    sBat.Add('@echo off');
    sBat.Add('set PGPASSWORD=%1');
    sBat.Add(format('PATH = %%PATH%%;%s', [sBinPath]));

    sBat.Add(format('%screateuser.exe -s postgres', [sBinPath]));
    sBat.Add(format('%screateuser.exe -s bcb', [sBinPath]));
    sBat.Add(format('%screateuser.exe -s alliance', [sBinPath]));

    sBat.Add(format(createdbString, [sBinPath, 'createdb.exe']));
    if bPartiel = 0 then
      sBat.Add(format(psqlString0, [sBinPath, 'psql.exe', folder]))
    else
      sBat.Add(format(psqlString1, [sBinPath, 'psql.exe', gzIn]));

    sBat.SaveToFile(batchFile);
    //LED1.Active := False;

  end;



begin
  //Label1.Caption := 'Détection de la version Postgres en cours ....';
  result := '';
  //JvLED1.Active := True;
  MakeBatch(sPgBinPath);
  result := 'Version inconnue';

end;

procedure TfDumpAllCut.ExecuteAndWait(const aCommando: string);
var
  tmpStartupInfo: TStartupInfo;
  tmpProcessInformation: TProcessInformation;
  tmpProgram: String;
begin
  tmpProgram := trim(aCommando);
  FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
  with tmpStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    wShowWindow := SW_HIDE;
  end;

  if CreateProcess(nil, PChar(tmpProgram), nil, nil, True, CREATE_NEW_CONSOLE
    (* CREATE_NO_WINDOW *) , nil, nil, tmpStartupInfo, tmpProcessInformation) then
  begin
    while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
    end;
    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);
  end
  else
  begin
    RaiseLastOSError;
  end;
end;

procedure TfDumpAllCut.start;
var
  iVersion: string;
  bContinue: Boolean;
  dStart, dEnd: tDateTime;
begin
  sqlOut := format('%s%s.dump.sql', [folder, DB]);
  batchFile := IncludeTrailingBackslash(folder) + batchName;
  show;
  Memo1.Clear;
  dStart := now;
  Memo1.Lines.Add('Début : ' + formatdatetime('hh:nn:ss:zzz', dStart));
  Application.ProcessMessages;
  // A changer
  iVersion := getPostGresVersion;
  if trim(iVersion) <> '' then
  begin
    bContinue := True;
    if checkDBExists then
    begin
      bContinue := (MessageDlg(format('Une DB %s est déjà présente sur le serveur.' + #13 + 'Voulez-vous la supprimer ?', [DB]),
          mtWarning, [mbOk, mbCancel], 0) = mrOk);
      if bContinue then
      begin
        dropDB;
      end
    end;

    if bContinue then
    begin
      //Label1.Caption := iVersion;
      if bPartiel = 0 then
      begin
        sLabel1.Caption := 'Découpage de ' + gzIn;
        decompGZ(gzIn);
      end;
      sLabel1.Caption := 'Restauration DB ....';
      Application.ProcessMessages;
      restoreDump;
      dEnd := now;
      Memo1.Lines.Add('Fin : ' + formatdatetime('hh:nn:ss:zzz', dEnd));
      Memo1.Lines.Add('Durée : ' + formatdatetime('hh:nn:ss:zzz', dEnd - dStart));
      // Sauvegarde dans le log ....
    end;
  end;
  close;
end;

procedure TfDumpAllCut.Button1Click(Sender: TObject);
begin
  sLabel1.Caption := 'Décompression de ' + gzIn;
  decompGZ(gzIn);
  sLabel1.Caption := 'Découpage du dump';
  cutDump;
  sLabel1.Caption := 'Terminé';
end;

procedure TfDumpAllCut.Button2Click(Sender: TObject);
begin
  formatVersion(getPostGresVersion);
end;

procedure TfDumpAllCut.Button3Click(Sender: TObject);
var
  i: Integer;
begin

end;

Function TfDumpAllCut.checkDBExists: Boolean;
begin
  result := False;
  ZConnection1.user := user;
  ZConnection1.password := password;
  ZConnection1.Connect;
  if ZConnection1.Connected then
  begin
    Memo1.Lines.Add('Connection au serveur réussie.');
    ZQuery1.SQL.Text := format('SELECT 1 FROM pg_database WHERE datname=''%s''', [DB]);
    Memo1.Lines.Add(format('Vérifier si la DB %s est déjà présente sur le serveur .....', [DB]));
    try
      ZQuery1.Connection := ZConnection1;
      ZQuery1.Active := True;
      ZQuery1.ExecSQL;
      if ZQuery1.RowsAffected = 1 then
      begin
        Memo1.Lines.Add(format('La DB %s existe déjà sur le serveur.', [DB]));
        result := True;
      end;
    except
    end;
  end;
end;

procedure TfDumpAllCut.dropDB;
begin
  ZQuery1.SQL.Text := format('DROP database %s', [DB]);
  ZQuery1.Active := True;
  Memo1.Lines.Add(format('La DB %s a été supprimée.', [DB]));
end;

procedure TfDumpAllCut.cutDump;
const
  sLabel = 'Découpage du dump.  %d %%';
var
  fileOut: textfile;
  bstart, bend: Boolean;
  iTotSize: int64;
  iRead, iReadSize: int64;
  iPos: Integer;
  Block: Integer;
  _buffer: TBytes;
  Temp: string;
  fsIn: tFileStream;
  iPercent: Integer;
  oldPercent: Integer;

begin
  Block := 8182 * 8;
  fsIn := tFileStream.Create(sqlIn, fmOpenRead);
  AssignFile(fileOut, sqlOut);
  rewrite(fileOut);
  iTotSize := fsIn.Size;
  fsIn.Position := 0;
  SetLength(_buffer, Block);
  iReadSize := Block;
  iRead := 0;
  oldPercent := -1;
  bstart := False;
  bend := False;
  iPercent := 0;
  sLabel1.Caption := format(sLabel, [iPercent]);
  while iReadSize = Block do
  begin
    Application.ProcessMessages;
    iReadSize := fsIn.Read(_buffer[0], Block);
    iRead := iRead + iReadSize;
    Temp := TEncoding.Default.GetString((_buffer));
    if not bstart then
    begin
      iPos := pos('SET statement_timeout = 0;', Temp);
      bstart := (iPos > 0);
      delete(Temp, 1, iPos - 1);
    end;
    if bstart then
    begin
      iPos := pos('\connect bcb', Temp);
      bend := (iPos > 0);
    end;

    if (bstart and not bend) then
    begin
      iPercent := round(iRead / iTotSize * 100);
      sLabel1.Caption := format(sLabel, [iPercent]);
      if (iPercent mod 10) = 0 then
      begin
        if oldPercent <> iPercent then
        begin
          // pb1.Position := iPercent;
          oldPercent := iPercent;
        end;
      end;
      write(fileOut, Temp);
    end;
  end;
  fsIn.Free;
  closefile(fileOut);
  deletefile(sqlIn);
end;

procedure TfDumpAllCut.decompGZ(sFile: String);
var
  decomp: TGZDecompressionStream;
  fsIn: tFileStream;
  fsOut: tFileStream;
  B: tBuffer;
  B2: tBuffer;
  sString: String;
  R: int64;
  S: int64;
  iCount: int64;
  i: Integer;
  bFilter: Boolean;
  iPercent: Integer;
  sSearch: AnsiString;
  N: Integer;

begin
  sSearch := 'SET statement_timeout = 0;';

  fsIn := tFileStream.Create(gzIn, fmOpenRead);
  S := fsIn.Size;
  // sLabel1.Caption := inttostr(S);
  fsIn.Position := 0;

  fsOut := tFileStream.Create(sqlOut, fmCreate);
  decomp := TGZDecompressionStream.Create(fsIn);
  // bCont := True;
  iCount := 0;
  bFilter := True;
  repeat

    R := decomp.Read(B, SizeOf(B));
    if R > 0 then
    begin
      SetString(sString, PAnsiChar(@B[0]), length(B));
      iCount := fsIn.Position;
      iPercent := round(iCount / S * 100);
      if (iPercent mod 10) = 0 then
        GetDiskFreeSpace('c:');
      pb1.Progress := iPercent;
      i := -1;
      if bFilter then
        i := pos(sSearch, sString);

      if i > -1 then
      begin
        N := i - 1;
        Move(B[N], B2[0], R - N);
        fsOut.Write(B2, R - N);
        bFilter := False;
      end
      else
      begin
        fsOut.Write(B, R);
      end;
      Application.ProcessMessages;
    end;
  until (R < SizeOf(B));
  decomp.Free;
  fsIn.Free;
  fsOut.Free;

end;

procedure TfDumpAllCut.JvBitBtn1Click(Sender: TObject);
begin
  start;
end;
{$R *.dfm}

end.
