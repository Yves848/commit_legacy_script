unit dumpallcut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IOutils, StrUtils, Types, ShlObj, FileCtrl,
  Dialogs, StdCtrls, ComCtrls, JvExComCtrls, JvProgressBar, Buttons, JvExButtons, JvBitBtn, ZSqlProcessor, ZAbstractConnection,
  ZConnection, DateUtils,
  JvExControls, JvLED, JvExStdCtrls, JvMemo, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, JvExGrids, JvStringGrid,
  ExtCtrls, zlibExGZ, JvExExtCtrls, JvExtComponent, JvItemsPanel, Gauges, JvCaptionPanel, JvAnimatedImage, JvGIFCtrl,
  uDriveChoice, DBGrids, uTypes;

const
  batchName = '%screateDbAuto.bat';
  WM_START = WM_USER + 100;
  OneKB = 1024;
  OneMB = OneKB * OneKB;
  OneGB = OneKB * OneMB;
  OneTB = Int64(OneKB) * OneGB;
  sWin1252 = 'WIN1252';
  sUTF8 = 'UTF8';

type
  tBuffer = array [0 .. 32767] of byte;
  TArg<T> = reference to procedure(const Arg: T);
  TByteStringFormat = (bsfDefault, bsfBytes, bsfKB, bsfMB, bsfGB, bsfTB);
  tFyleType = (ftGZ, ftSQL);

  tLog = class(tObject)
  private
    fLog: tStrings;
    fMemo: tStrings;
    fFormat: String;
  protected
    procedure clear;
    procedure setFormat(sFormat: String);
    procedure print(sMessage: String); overload;
    procedure print(iMessage: Integer); overload;
    procedure print(eMessage: extended; nDecimal: Integer = 2); overload;
    Procedure WriteToFile(aFile: string);
  public
    constructor create(aMemo: tjvMemo = Nil);
    destructor Free;
  end;

  tInputFile = class(tObject)
  private
    fDrive: String;
    fDriveOut: String;
    fPath: String;
    fFile: String;
    fExtension: String;
    fType: Integer;
  public
    constructor create(sFile: String);
  end;

  tDrive = class(tObject)
  private
    fLetter: String;
    fSize: Int64;
    fFree: Int64;
    fOldFree: Int64;
    function fGetPercentFree: extended;
    function fIsChanged: Boolean;
  public
    constructor create(sDrive: String);
    function GetDiskFreeSpace: Int64;

    property Letter: string read fLetter write fLetter;
    property Size: Int64 read fSize;
    property Free: Int64 read fFree;
    property OldFree: Int64 read fOldFree;
    property Changed: Boolean read fIsChanged;
    property PercentFree: extended read fGetPercentFree;
  end;

  TDriveDynArray = array of tDrive;
{$EXTERNALSYM TDriveDynArray}

  tDrives = class(tObject)
  private
    gDrives: tJvStringGrid;
    aDrives: TDriveDynArray;
    procedure initGrid;
  public
    constructor create(DriveGrid: tJvStringGrid);
    procedure addDrive(aDrive: string);
    procedure Refresh; overload;
    procedure Refresh(iDrive: Integer); overload;
    function getDriveNum(sDrive: String): Integer;
    function getNewRow: Integer;
    function GetFreeSpace(sDrive: String): Int64;
  end;

  TfDumpAllCut = class(tForm)
    Button1: TButton;
    JvBitBtn1: TJvBitBtn;
    ZConnection1: TZConnection;
    Button2: TButton;
    ZQuery1: TZQuery;
    Memo1: tjvMemo;
    pb1: TGauge;
    sLabel1: TLabel;
    sgDrives: tJvStringGrid;
    JvGIFAnimator1: TJvGIFAnimator;
    Panel1: TPanel;
    ZSQLProcessor1: TZSQLProcessor;
    Button3: TButton;
    procedure Button1Click(Sender: tObject);
    procedure JvBitBtn1Click(Sender: tObject);
    procedure Button2Click(Sender: tObject);
    procedure FormShow(Sender: tObject);
    procedure FormCreate(Sender: tObject);
    procedure sgDrivesDrawCell(Sender: tObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormDestroy(Sender: tObject);
    procedure Button3Click(Sender: tObject);
  private
    { Déclarations privées }
    pInputFile: tInputFile;
    batchFile: String;
    pDrives: tDrives;
    function decompGZ(sFile: String): string;
    procedure restoreDump;
    function formatVersion(iVersion: String): String;
    function getPostGresVersion: string;
    Function checkDBExists: Boolean;
    Function CheckFreeSpace: Integer;

  public
    { Déclarations publiques }
    DB: String;
    gzIn: string;
    sqlIn: string;
    sqlOut: string;
    iFileSize: Int64;
    autostart: Boolean;
    user: String;
    password: String;
    folder: string;
    bPartiel: Integer;
    pLog: tLog;
    sPgBinPath: String;
    bStopDecomp: Boolean;
    RepertoireProjet: String;
    bNoCut: Boolean;
    function MakeOutputFileName: Integer;
    function ChangeDrive(iFileSize: Int64): Integer;
    function TestAvailableFreeSpace(sDrive: String): Boolean;
    procedure onStart(var Msg: TMessage); message WM_START;
    procedure start;
    procedure CaptureConsoleOutput(const ACommand, AParameters: String; CallBack: TArg<PAnsiChar>);
  end;

var
  fDumpAllCut: TfDumpAllCut;

implementation

function FormatByteString(Bytes: UInt64; Format: TByteStringFormat = bsfDefault): string;
begin
  if Format = bsfDefault then
  begin
    if Bytes < OneKB then
    begin
      Format := bsfBytes;
    end
    else if Bytes < OneMB then
    begin
      Format := bsfKB;
    end
    else if Bytes < OneGB then
    begin
      Format := bsfMB;
    end
    else if Bytes < OneTB then
    begin
      Format := bsfGB;
    end
    else
    begin
      Format := bsfTB;
    end;
  end;

  case Format of
    bsfBytes:
      Result := SysUtils.Format('%d bytes', [Bytes]);
    bsfKB:
      Result := SysUtils.Format('%.1n KB', [Bytes / OneKB]);
    bsfMB:
      Result := SysUtils.Format('%.1n MB', [Bytes / OneMB]);
    bsfGB:
      Result := SysUtils.Format('%.1n GB', [Bytes / OneGB]);
    bsfTB:
      Result := SysUtils.Format('%.1n TB', [Bytes / OneTB]);
  end;
end;

constructor tLog.create(aMemo: tjvMemo = Nil);
begin
  fLog := tStringList.create;
  if aMemo <> Nil then
    fMemo := aMemo.Lines;
  setFormat('yyyy/mm/dd hh:nn:ss:zzz # ');
  clear;
end;

destructor tLog.Free;
begin
  if fMemo <> Nil then
    fMemo := Nil;
  fLog.Free;
end;

Procedure tLog.WriteToFile(aFile: string);
begin
  // Ecriture du log dans un fichier.
end;

procedure tLog.setFormat(sFormat: String);
begin
  fFormat := sFormat;
end;

procedure tLog.clear;
begin
  fMemo.clear;
end;

procedure tLog.print(sMessage: String);
var
  sDate: String;
begin
  sDate := formatDateTime(fFormat, now);
  if fMemo <> Nil then
  begin
    fMemo.Add(sMessage);
  end;
  fLog.Add(sDate + sMessage);
end;

procedure tLog.print(iMessage: Integer);
begin
  print(inttostr(iMessage));
end;

procedure tLog.print(eMessage: extended; nDecimal: Integer = 2);
var
  sDec: String;
  i: Integer;
begin
  sDec := dupestring('0', nDecimal);
  print(formatFloat(Format('#,%s', [sDec]), eMessage));
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
      if CreateProcess(nil, PChar(ACommand + ' ' + AParameters), @saSecurity, @saSecurity, True, NORMAL_PRIORITY_CLASS, nil, nil, suiStartup,
        piProcess) then
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

(*
  tInputFile Section
  ******************
*)

constructor tInputFile.create(sFile: String);
var
  sExtension: String;
  cDrive: Char;
begin
  ProcessPath(sFile, cDrive, fPath, fFile);
  fDrive := cDrive;
  fDriveOut := cDrive;
  fFile := tPath.GetFileNameWithoutExtension(sFile);
  fExtension := ExtractFileExt(sFile);
  if pos('GZ', uppercase(fExtension)) > 0 then
    fType := 0
  else
    fType := 1;
end;

(*
  tDrives Section
  ***************
*)

constructor tDrives.create(DriveGrid: tJvStringGrid);
begin
  gDrives := DriveGrid;
  initGrid;
end;

function tDrives.getDriveNum(sDrive: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  i := 0;
  while i <= length(aDrives) - 1 do
  begin
    if sDrive = tDrive(aDrives[i]).fLetter then
    begin
      Result := i;
      i := length(aDrives);
    end;
    inc(i);
  end;
end;

function tDrives.GetFreeSpace(sDrive: String): Int64;
var
  i: Integer;
begin
  Result := -1;
  i := 0;
  while i <= length(aDrives) - 1 do
  begin
    if sDrive = aDrives[i].fLetter then
    begin
      Result := aDrives[i].fFree;
      i := length(aDrives);
    end;
    inc(i);
  end;
end;

procedure tDrives.initGrid;
var
  iRow, iCol: Integer;

  procedure cleanRow;
  begin
    iCol := 0;
    while iCol <= gDrives.ColCount do
    begin
      gDrives.Cells[iRow, iCol] := '';
      inc(iCol);
    end;
  end;

begin
  iRow := 0;
  while iRow <= gDrives.RowCount - 1 do
  begin
    if gDrives.Objects[0, iRow] <> Nil then
      gDrives.Objects[0, iRow].Free;
    cleanRow;
    inc(iRow);
  end;
end;

function tDrives.getNewRow;
begin
  Result := gDrives.RowCount - 1;
  if gDrives.Objects[0, Result] <> Nil then
  begin
    inc(Result);
    gDrives.RowCount := Result + 1;
  end;
end;

procedure tDrives.addDrive(aDrive: string);
var
  pDrive: tDrive;
  iRow: Integer;
begin
  if (GetDriveType(PChar(aDrive)) = (DRIVE_FIXED)) then
  begin
    pDrive := tDrive.create(aDrive);
    iRow := getNewRow;
    setLength(aDrives, iRow + 1);
    aDrives[iRow] := pDrive;
    gDrives.Objects[0, iRow] := pDrive;
    gDrives.Cells[0, iRow] := pDrive.Letter;
    gDrives.Cells[1, iRow] := FormatByteString(pDrive.fSize);
    gDrives.Cells[2, iRow] := FormatByteString(pDrive.fFree);
  end;
end;

procedure tDrives.Refresh(iDrive: Integer);
var
  bChanged: Boolean;
begin
  bChanged := False;

  aDrives[iDrive].GetDiskFreeSpace;
  bChanged := bChanged or aDrives[iDrive].Changed;

  if bChanged then
  begin
    gDrives.Refresh;
  end;
end;

procedure tDrives.Refresh;
var
  i: Integer;
  bChanged: Boolean;
begin
  bChanged := False;
  for i := 0 to length(aDrives) - 1 do
  begin
    Refresh(i);
  end;
end;

(*
  tDrive section
  **************                                                                             +
*)

constructor tDrive.create(sDrive: String);
begin
  fLetter := sDrive;
  fSize := -1;
  fFree := -1;
  GetDiskFreeSpace;
  fOldFree := fFree;
end;

function tDrive.fIsChanged: Boolean;
var
  Percent1, Percent2: Integer;
begin
  Percent1 := Round(fSize / fFree * 100);
  Percent2 := Round(fSize / fOldFree * 100);
  Result := Percent1 <> Percent2;
  if Result then
    fOldFree := fFree;
end;

function tDrive.fGetPercentFree: extended;
begin
  Result := fFree / fSize;
end;

function tDrive.GetDiskFreeSpace: Int64;
var
  TailleTotale, EspaceUtilise, EspaceLibre: Int64;
begin
  if GetDiskFreeSpaceEx(PChar(fLetter), EspaceUtilise, TailleTotale, @EspaceLibre) then
  begin
    fSize := TailleTotale;
    fFree := EspaceLibre;
  end;
end;

procedure TfDumpAllCut.onStart(var Msg: TMessage);
begin
  Refresh;
  Application.ProcessMessages;
  start;
end;

function TfDumpAllCut.formatVersion(iVersion: String): string;
var
  lStrings: tStrings;
  i: Integer;
begin
  lStrings := tStringList.create;
  lStrings.Delimiter := '\';
  lStrings.StrictDelimiter := True;
  lStrings.DelimitedText := uppercase(iVersion);
  i := lStrings.IndexOf('POSTGRESQL');
  Result := '';
  if (i <> 0) and (i < lStrings.Count - 1) then
    Result := lStrings[i + 1];
  lStrings.Free;
end;

procedure TfDumpAllCut.FormCreate(Sender: tObject);
var
  drives: tStringDynArray;
  pDrive: tDrive;
  i: Integer;
begin
  bNoCut := False;
  pLog := tLog.create(Memo1);
  pLog.setFormat('hh:nn:ss:zzz - ');
  pDrives := tDrives.create(sgDrives);
  drives := TDirectory.GetLogicalDrives;
  setLength(pDrives.aDrives, length(drives));
  for i := 0 to length(drives) - 1 do
  begin
    pDrives.addDrive(drives[i]);
  end;

  autostart := True;
end;

procedure TfDumpAllCut.FormDestroy(Sender: tObject);
begin
  pLog.Free;
end;

procedure TfDumpAllCut.FormShow(Sender: tObject);
var
  iCol: Integer;
begin
  pInputFile := tInputFile.create(gzIn);
  Panel1.Visible := not autostart;
  if autostart then
    postMessage(self.Handle, WM_START, 0, 0);
end;

procedure TfDumpAllCut.restoreDump;
var
  sCmd: String;
  CallBack: TArg<PAnsiChar>;
  time1: tDateTime;
begin
  getPostGresVersion;
  time1 := now;
  CallBack := procedure(const Line: PAnsiChar)
  begin
    pLog.print(String(Line));
    if SecondsBetween(now, time1) >= 10 then
    begin
      pDrives.Refresh;
      Application.ProcessMessages;
      time1 := now;
    end;
  end;

  sCmd := Format('%s %s %s %s', [batchFile, password, user, DB]);
  CaptureConsoleOutput(sCmd, '', CallBack);
end;

function TfDumpAllCut.getPostGresVersion: string;
const
  createdbString = '"%s"%s -U %%2 -w -E %s -T template0 %%3';
  psqlString0 = '"%s"%s -U %%2 -w -d %%3 -f "%s%%3.dump.sql"';
  psqlString1 = '"%s"%s -U %%2 -w -d %%3 -f "%s"';

  procedure MakeBatch(sPath: String);
  var
    sBat: tStrings;
    sBinPath: String;
  begin
    sBinPath := IncludeTrailingBackslash(sPath);
    sBat := tStringList.create;
    sBat.Add('@echo off');
    sBat.Add('set PGPASSWORD=%1');
    sBat.Add(Format('PATH = %%PATH%%;%s', [sBinPath]));

    sBat.Add(Format('"%s"createuser.exe -s postgres', [sBinPath]));
    sBat.Add(Format('"%s"createuser.exe -s bcb', [sBinPath]));
    sBat.Add(Format('"%s"createuser.exe -s alliance', [sBinPath]));

    sBat.Add(Format(createdbString, [sBinPath, 'createdb.exe', sEncoding]));
    sBat.Add(Format(psqlString1, [sBinPath, 'psql.exe', sqlOut]));

    sBat.SaveToFile(batchFile);

  end;

begin
  Result := '';
  MakeBatch(sPgBinPath);
  Result := 'Version inconnue';

end;

procedure TfDumpAllCut.sgDrivesDrawCell(Sender: tObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  lRect: TRect;
  s: String;
  c: tCanvas;
  percent: extended;
  pDrive: tDrive;

  procedure DrawTheText(const hDC: hDC; const Font: TFont; var Text: string; aRect: TRect);
  var
    lRect: TRect;
    width, heigth: Integer;
  begin
    with TBitmap.create do
      try
        width := aRect.Right - aRect.Left;
        Height := aRect.Bottom - aRect.Top;
        lRect := Rect;
        lRect.Right := width;
        lRect.Bottom := Height;
        Canvas.Font.Assign(Font);
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(lRect);
        Canvas.Font.Color := clWhite;
      finally
        Free;
      end;
  end;

begin
  //

  if ACol = 3 then
  begin
    percent := tDrive(sgDrives.Objects[0, ARow]).PercentFree;
    c := sgDrives.Canvas;
    lRect := Rect;
    lRect.Right := Round(lRect.Left + (lRect.Right - lRect.Left) * percent);
    inflaterect(lRect, -1, -1);
    case Round(percent * 100) of
      0 .. 15:
        c.Brush.Color := clRed;
      16 .. 49:
        c.Brush.Color := $000080FF;
      50 .. 100:
        c.Brush.Color := clGreen;
    end;
    c.Brush.Style := bsSolid;
    c.Pen.Color := clBlack;
    c.FillRect(lRect);
    s := formatFloat('0 %', percent * 100);
    DrawTheText(c.Handle, sgDrives.Font, s, Rect);
    c.Brush.Style := bsClear;
    c.TextRect(Rect, s, [tfCenter, tfVerticalCenter, tfSingleLine]);
  end;
end;

procedure TfDumpAllCut.start;
var
  iVersion: string;
  bContinue: Boolean;
  dStart, dEnd: tDateTime;

  function DropDB(sBinPath: String; sDB: String): String;
  const
    sDrop = '%s -U %s -w %s';
  var
    sDropDb: String;
    CallBack: TArg<PAnsiChar>;
  begin

    sDropDb := Format(sDrop, [tPath.Combine(sBinPath, 'dropdb.exe'), user, sDB]);
    CallBack := procedure(const Line: PAnsiChar)
    begin
      Application.ProcessMessages;
    end;

    CaptureConsoleOutput(sDropDb, '', CallBack);

  end;

begin
  if MakeOutputFileName = mrOk then
  begin
    batchFile := Format(batchName, [IncludeTrailingBackslash(folder)]);
    show;
    Memo1.clear;
    dStart := now;
    pLog.print('Début : ' + formatDateTime('hh:nn:ss:zzz', dStart));
    Application.ProcessMessages;

    bContinue := True;
    if checkDBExists then
    begin
      bContinue := (MessageDlg(Format('Une DB %s est déjà présente sur le serveur.' + #13 + 'Voulez-vous la supprimer ?', [DB]), mtWarning,
          [mbOk, mbCancel], 0) = mrOk);
      if bContinue then
      begin
        DropDB(sPgBinPath, DB);
      end
    end;

    if bContinue then
    begin
      {
        Mettre un encodage par défaut pour NEV
        L'encodage du dump étant récupéré pendant le dumpcut, pour NEV, il faut fixer l'encodage de la DB avant.
        }
      sEncoding := sUTF8;
      if not bNoCut then
      begin
        sLabel1.Caption := 'Découpage de ' + gzIn;
        // récupérer l'encodage de la DB.
        sEncoding := decompGZ(gzIn);
      end;
      sLabel1.Caption := 'Restauration DB ....';
      Application.ProcessMessages;
      restoreDump;
      dEnd := now;
      pLog.print('Fin : ' + formatDateTime('hh:nn:ss:zzz', dEnd));
      pLog.print('Durée : ' + formatDateTime('hh:nn:ss:zzz', dEnd - dStart));
    end;
  end;
  close;
end;

function FileSize(const aFilename: String): Int64;
var
  info: TWin32FileAttributeData;
begin
  Result := -1;

  if NOT GetFileAttributesEx(PWideChar(aFilename), GetFileExInfoStandard, @info) then
    EXIT;

  Result := Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);
end;

function TfDumpAllCut.TestAvailableFreeSpace(sDrive: String): Boolean;
var
  iFreespace: Int64;
begin
  iFreespace := pDrives.GetFreeSpace(sDrive + ':\');
  Result := iFreespace > iFileSize * 20;
end;

function TfDumpAllCut.ChangeDrive(iFileSize: Int64): Integer;
var
  fDriveChoice: TfDriveChoice;
  i: Integer;
  index: Integer;
begin
  fDriveChoice := TfDriveChoice.create(self);
  i := 0;
  index := 0;
  while i <= length(pDrives.aDrives) - 1 do
  begin
    fDriveChoice.cbDrives.Items.Add(pDrives.aDrives[i].Letter);
    if TestAvailableFreeSpace(copy(pDrives.aDrives[i].Letter, 1, 1)) then
      Index := i;
    inc(i);
  end;
  fDriveChoice.cbDrives.ItemIndex := index;
  fDriveChoice.Label1.Caption := Format(fDriveChoice.Label1.Caption, [pInputFile.fDriveOut + ':\']);
  Result := fDriveChoice.ShowModal;
  if Result = mrOk then
    pInputFile.fDriveOut := copy(fDriveChoice.cbDrives.Text, 1, 1);
  fDriveChoice.Free;
end;

function TfDumpAllCut.CheckFreeSpace: Integer;
begin
  Result := mrOk;
  while True do
  begin
    iFileSize := FileSize(gzIn);
    if (not TestAvailableFreeSpace(pInputFile.fDriveOut)) then
    begin
      Result := ChangeDrive(iFileSize);
      if Result = mrAbort then
        break;
    end
    else
      break;
  end;
end;

Function TfDumpAllCut.MakeOutputFileName: Integer;
var
  sFolder: String;
begin
  if FileExists(gzIn) then
  begin
    Result := CheckFreeSpace;
    if Result = mrOk then
    begin
      sFolder := pInputFile.fDriveOut + ':' + pInputFile.fPath + '\';
      if not TDirectory.Exists(sFolder) then
        TDirectory.CreateDirectory(sFolder);
      sqlOut := Format('%s%s.dump.sql', [sFolder, DB]);
    end;
  end
  else
    Result := mrAbort;  // Si le fichier n'est pas trouvé, ne rien faire.
end;

procedure TfDumpAllCut.Button1Click(Sender: tObject);
begin
  if MakeOutputFileName = mrOk then
  begin
    batchFile := batchName;
    sLabel1.Caption := 'Décompression de ' + gzIn;
    decompGZ(gzIn);
  end;
  sLabel1.Caption := 'Terminé';
end;

procedure TfDumpAllCut.Button2Click(Sender: tObject);
var
  drives: tStringDynArray;
  i: Integer;
begin
  // getPostGresVersion;
  pLog.print('Ouverture de la DB');
  ZQuery1.close;
  ZQuery1.SQL.clear;
  ZQuery1.SQL.Add(Format('select count(*) from pg_database where datname = ''%s''', [DB]));
  ZQuery1.Active := True;
  pLog.print(ZQuery1.RecordCount);
end;

procedure TfDumpAllCut.Button3Click(Sender: tObject);
begin
  bStopDecomp := True;
end;

Function TfDumpAllCut.checkDBExists: Boolean;
begin
  Result := False;
  ZConnection1.user := user;
  ZConnection1.password := password;
  ZConnection1.Connect;
  if ZConnection1.Connected then
  begin
    pLog.print(Format('Connection au serveur [%s] réussie.', [ZConnection1.HostName]));
    ZQuery1.SQL.Text := Format('SELECT 1 FROM pg_database WHERE datname=''%s''', [DB]);
    pLog.print(Format('Nous vérifions si une DB [%s] est déjà présente sur le serveur .....', [DB]));
    try
      ZQuery1.Connection := ZConnection1;
      ZQuery1.Active := True;
      if ZQuery1.RecordCount = 1 then
      begin
        pLog.print(Format('   Une DB [%s] existe déjà sur le serveur.', [DB]));
        Result := True;
      end
      else
      begin
        pLog.print(Format('   Pas de DB [%s] déjà présente sur le serveur.', [DB]));
      end;
    except
    end;
    ZQuery1.close;
  end;
end;

function TfDumpAllCut.decompGZ(sFile: String): string;
var
  decomp: TGZDecompressionStream;
  fsIn: tFileStream;
  fsOut: tFileStream;
  readStream: tStream;
  B: tBuffer;
  B2: tBuffer;
  sString: String;
  R: Int64;
  s: Int64;
  iCount: Int64;
  i, j, j2: Integer;
  bFilter: Boolean;
  bEncoding: Boolean;
  iPercent: Integer;
  sSearch: AnsiString;
  N: Integer;
  OldPercent: Integer;
  iDrive: Integer;
begin
  sSearch := 'SET statement_timeout = 0;';
  Result := sUTF8;
  fsIn := tFileStream.create(gzIn, fmOpenRead + fmShareDenyNone);
  s := fsIn.Size;
  fsIn.Position := 0;

  fsOut := tFileStream.create(sqlOut, fmCreate);
  if ExtractFileExt(gzIn) = '.gz' then
  begin
    decomp := TGZDecompressionStream.create(fsIn);
    readStream := decomp;
  end
  else
    readStream := fsIn;
  iCount := 0;
  bFilter := True;
  bEncoding := True;
  OldPercent := -1;
  bStopDecomp := False;
  iDrive := pDrives.getDriveNum(TDirectory.GetDirectoryRoot(sqlOut));
  repeat
    R := readStream.Read(B, SizeOf(B));
    if R > 0 then
    begin
      iCount := fsIn.Position;
      iPercent := Round(iCount / s * 100);
      if (iPercent mod 5) = 0 then
      begin
        pDrives.Refresh(iDrive);
      end;

      pb1.Progress := iPercent;
      i := -1;
      if bFilter then
      begin
        SetString(sString, PAnsiChar(@B[0]), length(B));
        i := pos(sSearch, sString);
      end;

      if bEncoding then
      begin
        SetString(sString, PAnsiChar(@B[0]), length(B));
        j := pos('SET client_encoding = ', sString);
        if j > -1 then
        begin
          bEncoding := False;
          j2 := pos(sWin1252, sString);
          if j2 > 0 then
            Result := sWin1252;
        end;
      end;

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
  until (R < SizeOf(B)) or bStopDecomp;
  if ExtractFileExt(gzIn) = '.gz' then
    decomp.Free;
  fsIn.Free;
  fsOut.Free;

end;

procedure TfDumpAllCut.JvBitBtn1Click(Sender: tObject);
begin
  start;
end;
{$R *.dfm}

end.
