program rdm_commit;
{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,
  Classes,
  JclSysInfo,
  JclFileUtils,
  TlHelp32,
  DateUtils,
  ShellAPI;

var
  lListeProcessus: TStringList;
  lBoolOK: Boolean;
  lFichiers: TSearchRec;
  lStrRep: string;

function KillProcess: Boolean;
var
  Snapshot: THandle;
  pe: TProcessEntry32;
  iRes: Integer;
  sProcessName: string;

  procedure AddLog(sString: string);
  begin
    Writeln(sString);
  end;

  function KillTask(ExeFileName: string): Integer;
  const
    PROCESS_TERMINATE = $0001;
  var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
  begin
    Result := 0;
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

    while Integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
            (ExeFileName))) then
        Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    CloseHandle(FSnapshotHandle);
  end;

  function isProcessAlive(ExeFileName: string): Boolean; overload;
  begin
    Result := False;
    Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
    try
      pe.dwSize := SizeOf(pe);
      if Process32First(Snapshot, pe) then
        while Process32Next(Snapshot, pe) do
        begin
          if UpperCase(pe.szExeFile) = UpperCase(ExeFileName) then
          begin
            Result := True;
            exit;
          end;

        end;
    finally
      CloseHandle(Snapshot);
    end;
  end;

  function isProcessAlive(ExeFileName: string; iTimeout: Int64): Boolean; overload;
  var
    iStart: tDateTime;
  begin
    iStart := Now;
    Result := True;
    while (MilliSecondsBetween(Now, iStart) < iTimeout) and Result do
    begin
      if not isProcessAlive(sProcessName) then
      begin
        Result := False;
      end;
    end;
  end;

begin
  Result := True;
  sProcessName := 'commit.exe';
  if isProcessAlive(sProcessName) then
  begin
    AddLog(Format('Process %s is running', [sProcessName]));
    KillTask(sProcessName);
    if not isProcessAlive(sProcessName, 15000) then
      AddLog(Format('  Process %s killed successfully', [sProcessName]))
    else
    begin
      AddLog(Format('  Failed to kill %s process', [sProcessName]));
      Result := False;
    end;
  end
  else
    AddLog(Format('Process %s is not running', [sProcessName]));

end;

begin

  if KillProcess then
  begin
    lStrRep := ExtractFilePath(ParamStr(0));
    // Copie des fichiers racines
    if FindFirst(lStrRep + 'TMP\*.*', faAnyFile, lFichiers) = 0 then
    begin
      repeat
        if (lFichiers.Attr and faDirectory) <> faDirectory then
          FileMove(lStrRep + 'TMP\' + lFichiers.Name, PChar(lStrRep + lFichiers.Name), True);
      until FindNext(lFichiers) <> 0;
      FindClose(lFichiers);
    end;

    // Rédémarrage de COMMIT.EXE
    ShellExecute(0, 'open', PChar(lStrRep + '\commit.exe'), nil, PChar(lStrRep), SW_NORMAL);
  end;

end.

