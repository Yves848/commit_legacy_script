unit mdlMIASAPHA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlModuleImportPHA, mdlMIODBCPHA, DB, fbcustomdataset, mydbunit, uib, uibdataset,
  IniFiles, Registry, StrUtils, DBClient, mdlProjet, mdlMIOLEDBPHA,
  ADODB, JclSysInfo, JCLShell, ZConnection;

type
  TdmMIASAPHA = class(TdmMIOLEDBPHA)
    procedure DataModuleCreate(Sender: TObject);
  private
    FFichierBD: string;
    { Déclarations privées }
  public
    { Déclarations publiques }
    property FichierBD : string read FFichierBD write FFichierBD;
    procedure ConnexionBD; override;
  end;

var
  dmMIASAPHA: TdmMIASAPHA;

implementation

{$R *.dfm}

procedure TdmMIASAPHA.ConnexionBD;
const
  C_CHAINE_CONNEXION_ASA = 'Provider=MSDASQL.1;Persist Security Info=False;Extended Properties="UID=DBA;PWD=ISA;Start=%sdbeng50.exe -c 4096K -gb high;DatabaseFile=%s;DatabaseName=Pharma;AutoStop=yes;Driver=ASA"';
  C_SQL_ANYWHERE_ENGINE = 'dbeng50.exe';
var
  loc, d : string;
  lp : TStringList;
  pid : Cardinal;
begin
  if dbOLEDB.Connected then
    dbOLEDB.Connected := False;

  with TRegistry.Create do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('Software\Sybase\SQL Anywhere\Sybase SQL Anywhere 5.0', False) then
    begin
      loc := ReadString('Location') + '\win32\';
      d := loc + 'WOD50T.dll';
      ShellExec(0, 'open', Module.Projet.RepertoireApplication + '\Outils\install_odbc.exe', '-install nom=asa driver=' + d + ' setup=' + d, '', SW_NORMAL);

      lp := TStringList.Create;
      RunningProcessesList(lp, False);
      if Assigned(lp) then
      begin
        if lp.IndexOf(C_SQL_ANYWHERE_ENGINE) <> -1 then
        begin
          pid := GetPidFromProcessName(C_SQL_ANYWHERE_ENGINE);
          if pid <> 0 then
          begin
            TerminateApp(pid, 0);
            Sleep(2000);
          end;
        end;

        ShellExec(0, 'open', loc + C_SQL_ANYWHERE_ENGINE, '"' + FFichierBD + '"  -c 128M -gb high', '', 0);
        Sleep(5000);
      end;

      dbOLEDB.ConnectionString := Format(C_CHAINE_CONNEXION_ASA, [loc, FFichierBD]);
      dbOLEDB.Connected := True;
    end
    else
      MessageDlg('SQL Anywhere 5.0 n''est pas installé ! Installez le avant de faire une reprise ASA', mtError, [mbOk], 0);
  end;
end;

procedure TdmMIASAPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIASAPHA := Self;
end;

end.
