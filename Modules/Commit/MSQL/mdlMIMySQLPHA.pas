unit mdlMIMySQLPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, DB, uib, uibdataset,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, mydbunit, uibmetadata,
  fbcustomdataset, mdlActionTransaction, Controls,
  DBClient, StrUtils, ZAbstractRODataset, ZDataset, ZConnection,
  ZSqlProcessor, ShellAPI, JclShell, JclSysInfo, JclSysUtils, JclFileUtils,
  mdlAttente, ZAbstractConnection, Dialogs;

type
  TParametresRestaurationDump = class
    Commande : string;
    Dump : string;
    BD : string;
    MDP : string
  end;

  TRestaurationDumpMySQL = class(TAttente)
  protected
    procedure LancerExecution; override;
  end;

  TdmMIMySQLPHA = class(TdmModuleImportPHA, IRequeteur)
    dbMySQL: TZConnection;
    qryMySQL: TZReadOnlyQuery;
    dataset: TZReadOnlyQuery;
    script: TZSQLProcessor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
    FRepertoireMySQL : string;
    FMDPMySQL : string;
    procedure DemarrerMySQL;
    procedure RestaurerDumpMySQL;
  public
    { Déclarations publiques }
    procedure ConnexionBD; override;
    function RenvoyerChaineConnexion : string; override;
    procedure DeconnexionBD; override;
    function RenvoyerDataSet : TDataSet;
    function RenvoyerTables : TStringList;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string);
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
    procedure ExecuterScript(AScript : TStrings);
    procedure Commit;
    procedure Rollback;
    function GererExceptionDataSet(E : Exception) : Exception;
    function LibererDataSet(ADataSet : TDataSet) : Boolean;
  end;

var
  dmMIMySQLPHA: TdmMIMySQLPHA;

implementation

uses mdlAttenteModale;

{$R *.dfm}

procedure TdmMIMySQLPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIMySQLPHA := Self;
end;

procedure TdmMIMySQLPHA.ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
begin
  inherited;

  with dataset do
  begin
    if Active then
      Close;
    SQL.Text := ARequeteSQL;
    Open;
  end;
end;

procedure TdmMIMySQLPHA.Commit;
begin
  raise EAbstractError.Create('Fonctionnalité non prise en charge !');
end;

procedure TdmMIMySQLPHA.DemarrerMySQL;
var
  sql, db : string;
  mysqld : string;
  locale : Boolean;
  p : TStringList;
  i : Integer; r : Boolean;

  function ConvertirCharOEM(s : string) : PAnsiChar;
  var
    a : array of AnsiChar;
  begin
    SetLength(a, Length(s));
    CharToOem(PChar(s), @a[0]);
    Result := @a[0];
  end;

begin
  with dbMySQL do
  begin
    db := ParametresConnexion.Values['bd'];
    sql := ParametresConnexion.Values['dump_sql'];
    locale := ParametresConnexion.Values['connexion_locale'] = '1';
    if locale then
    begin
      FRepertoireMySQL := Module.Projet.RepertoireApplication + '\MySQL51';
      FMDPMySQL := 'root';

      // Vérification si le serveur MYSQL de COMMIT est démarré
      mysqld := LowerCase(FRepertoireMySQL + '\Bin\mysqld.exe');
      p := TStringList.Create;
      RunningProcessesList(p);
      i := 0; r := False;
      while (i < p.Count) and not r do
      begin
        if LowerCase(p[i]) = mysqld then
        begin
          DeconnexionBD;
          i := p.Count;
        end
        else
          Inc(i);
      end;
      FreeAndNil(p);

      // Démarrage du serveur Mysql
      if CopyDirectory(FRepertoireMySQL + '\data', Module.Projet.RepertoireProjet) then
      begin
        ShellExecute(0,
                     'open',
                     PChar('"' + mysqld + '"'),
                     PChar('--standalone --basedir="' + FRepertoireMySQL + '" --datadir="' + Module.Projet.RepertoireProjet + '\data"' + ' ' + ParametresConnexion.Values['version']),
                     PChar(Module.Projet.RepertoireApplication),
                     SW_HIDE);
        Sleep(3000);
      end
      else
        ShowMessage(IntToStr(GetLastError));
    end;
  end;
end;

procedure TdmMIMySQLPHA.RestaurerDumpMySQL;
var
  db : string;
  dbs : TStringList;
  i : Integer;
  p : TParametresRestaurationDump;
begin
  with dbMySQL do
  begin
    db := ParametresConnexion.Values['bd'];

    i := 0;
    while not dbMySQL.Connected and (i < 3) do
      try
        Connect;
      except
        Sleep(1000);
        Inc(i);
      end;

    dbs := TStringList.Create;
    qryMySQL.SQL.Clear;
    qryMySQL.SQL.Add('show databases');
    qryMySQL.Open;
    while not qryMySQL.Eof do
    begin
      dbs.Add(qryMySQL.Fields[0].AsString);
      qryMySQL.Next;
    end;
    qryMySQL.Close;

    if dbs.IndexOf(db) <> -1 then
    begin
      // Drop ...
      qryMySQL.SQL.Clear;
      qryMySQL.SQL.Add('drop database ' + db);
      qryMySQL.ExecSQL;
    end;

    // et create
    qryMySQL.SQL.Clear;
    qryMySQL.SQL.Add('create database ' + db);
    qryMySQL.ExecSQL;

    // Importation du dump
    p := TParametresRestaurationDump.Create;
    p.Commande := '"' + FRepertoireMySQL + '\Bin\mysql.exe"';
    p.Dump := ParametresConnexion.Values['dump_sql'];
    p.BD := db;
    p.MDP := FMDPMySQL;
    AttendreFinExecution(Self, taLibelle, TRestaurationDumpMySQL, p, 'Restauration dump ASPLine');
    ParametresConnexion.Values['dump_sql'] := '';
  end;
end;

procedure TdmMIMySQLPHA.ConnexionBD;
var
  locale : Boolean;
begin
  with dbMySQL do
  begin
    locale := ParametresConnexion.Values['connexion_locale'] = '1';
    if locale then
    begin
      TfrmAttenteModale.Create(Self).Show('Démarrage du serveur MySQL local', DemarrerMySQL);
      HostName := 'localhost';
      User := 'root';
      Password := FMDPMySQL;
    end
    else
    begin
      HostName := ParametresConnexion.Values['serveur'];
      User := ParametresConnexion.Values['utilisateur'];
      Password := ParametresConnexion.Values['mot_de_passe'];
    end;

    // Restauration du dump
    if locale and (ParametresConnexion.Values['dump_sql'] <> '') then
      RestaurerDumpMySQL;

    try
      if Connected then
        Disconnect;
      Database := ParametresConnexion.Values['bd'];
      Connect;
    except
      DeconnexionBD;
      raise;
    end;
  end;
end;

function TdmMIMySQLPHA.RenvoyerChaineConnexion : string;
begin
  Result := dbMySQL.User + '@' + dbMySQL.HostName + ':' + dbMySQL.Database;
end;

function TdmMIMySQLPHA.RenvoyerDataSet: TDataSet;
begin
  Result := dataset;
end;

function TdmMIMySQLPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  dataset.RowsAffected;
end;

function TdmMIMySQLPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbMySQL.GetTableNames('',Result);
end;

procedure TdmMIMySQLPHA.Rollback;
begin
  raise EAbstractError.Create('Fonctionnalité non prise en charge !');
end;

procedure TdmMIMySQLPHA.DeconnexionBD;
begin
  dbMySQL.Disconnect;
  if (ParametresConnexion.Values['connexion_locale'] = '1') then
    ShellExecute(0, 'open',
                 PChar('"' + FRepertoireMySQL + '\Bin\mysqladmin.exe"'),
                 PChar('-u root -p' + FMDPMySQL + ' shutdown'),
                 PChar(Module.Projet.RepertoireApplication),
                 SW_HIDE);
end;


procedure TdmMIMySQLPHA.ExecuterScript(AScript: TStrings);
begin
  with script do
  begin
    Script.Clear;
    Script.AddStrings(AScript);
    Execute;
  end;
end;

function TdmMIMySQLPHA.GererExceptionDataSet(E: Exception): Exception;
begin
  Result := E;
end;

function TdmMIMySQLPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  with dataset do
  begin
    if Active then
      Close;
  end;
end;

{ TRestaurationDumpMySQL }

procedure TRestaurationDumpMySQL.LancerExecution;
var
  f : TextFile;

  function ConvertirCharOEM(s : string) : PAnsiChar;
  var
    a : array of AnsiChar;
  begin
    SetLength(a, Length(s));
    CharToOem(PChar(s), @a[0]);
    Result := @a[0];
  end;

begin
  inherited;

  // Importation du dump
  with TParametresRestaurationDump(FParametres) do
  begin
    System.Assign(f, 'tmp.bat');
    Rewrite(f);
    Write(f, ConvertirCharOEM(Commande));
    Write(f, ConvertirCharOEM(' -u root -p' + MDP + ' ' + BD + ' < "' + Dump + '"'));
    CloseFile(f);

    ShellExecAndWait('tmp.bat', '', '', SW_HIDE);
    DeleteFile('tmp.bat');
  end;
end;

end.
