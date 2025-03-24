program install_odbc;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,
  StrUtils,
  Classes,
  Generics.Collections,
  IniFiles,
  Registry,
  Dialogs;

procedure InstallerAccesODBC(ANom, ADriver, ASetup,
  AParametresODBC : string);
var
  r : TRegistry;
  p : TStringList;
  i: Integer;
begin
  // Copie de l'analyse WINDEV
  r := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_32KEY);
  with r do
  begin
    // Installation driver ODBC
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('SOFTWARE\ODBC\ODBCINST.INI\' + ANom, True) then
    begin
      if ValueExists('Setup') then DeleteValue('Setup');
      if ValueExists('Driver') then DeleteValue('Driver');

      WriteString('Driver', ADriver);
      WriteString('Setup', ASetup);

      if (Trim(AParametresODBC) <> '') then
      begin
        p := TStringList.Create;
        ExtractStrings([';'], [], PChar(AParametresODBC), p);
        for i := 0 to p.Count - 1 do
          WriteString(p.Names[i], p.ValueFromIndex[i]);
      end;
      CloseKey;

      if OpenKey('SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers', True) then
        WriteString(ANom, 'Installed')
      else
        raise Exception.Create('Impossible d''installer le driver ODBC ' + ANom + ' !');
    end
    else
      raise Exception.Create('Impossible d''installer le driver ODBC ' + ANom + ' !');

    Free;
  end;
end;

procedure InstallerDSN(ANom, AODBC : string;
  AParametres: TDictionary<string, string>);
var
  p : TPair<string, string>;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('Software\Wow6432Node\ODBC\ODBC.INI\' + ANom, True) then
    begin
      for p in AParametres do
        WriteString(p.Key, p.Value);
      CloseKey;
    end;

    if OpenKey('Software\Wow6432Node\ODBC\ODBC.INI\ODBC Data Sources', False) then
    begin
      WriteString(ANom, AODBC);
    end;

    Free;
  end;
end;

var
  p : TStringList;
  i : Integer;
  autres_p : Boolean;
begin
  try
    if FindCmdLineSwitch('install', ['-'], True) then
    begin
      // On suppose que '-install' est le 1er paramètres ! ! !
      p := TStringList.Create;

      for i := 2 to ParamCount do
        p.Add(LowerCase(ParamStr(i)));
      i := p.Count - 1;
      autres_p := (p.Names[i] <> 'nom') and (p.Names[i] <> 'driver') and (p.Names[i] <> 'setup');

      InstallerAccesODBC(p.Values['nom'],
                         p.Values['driver'],
                         p.Values['setup'],
                         ifThen(autres_p, p[p.Count - 1], ''));
    end;

  except
    on E: Exception do
      ShowMessage(E.ClassName + ' : ' + E.Message);
  end;
end.
