unit mdlMIPostgreSQLPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, DB, uib, uibdataset,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, mydbunit, uibmetadata,
  fbcustomdataset, mdlActionTransaction, Controls,
  DBClient, StrUtils, ZAbstractRODataset, ZDataset, ZConnection,
  ZSqlProcessor, ShellAPI, JclShell, JclSysInfo, JclSysUtils,
  mdlAttente, ZAbstractConnection;

type
  TdmMIPostgreSQLPHA = class(TdmModuleImportPHA, IRequeteur)
    dbPostgreSQL: TZConnection;
    qryPostgreSQL: TZReadOnlyQuery;
    dataset: TZReadOnlyQuery;
    script: TZSQLProcessor;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
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
  dmMIPostgreSQLPHA: TdmMIPostgreSQLPHA;

implementation

uses mdlAttenteModale;

{$R *.dfm}

procedure TdmMIPostgreSQLPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIPostgreSQLPHA := Self;
end;

procedure TdmMIPostgreSQLPHA.ChargerDataSet(ADataSet: TDataSet; ARequeteSQL: string);
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

procedure TdmMIPostgreSQLPHA.Commit;
begin
  raise EAbstractError.Create('Fonctionnalité non prise en charge !');
end;

procedure TdmMIPostgreSQLPHA.ConnexionBD;
begin
  with dbPostgreSQL do
  begin
    if Connected then
      Disconnect;
    HostName := ParametresConnexion.Values['serveur'];
    Database := ParametresConnexion.Values['bd'];
    User := ParametresConnexion.Values['utilisateur'];
    Password := ParametresConnexion.Values['mot_de_passe'];
    Connect;
  end;
end;

function TdmMIPostgreSQLPHA.RenvoyerChaineConnexion : string;
begin
  Result := dbPostgreSQL.User + '@' + dbPostgreSQL.HostName + ':' + dbPostgreSQL.Database;
end;

function TdmMIPostgreSQLPHA.RenvoyerDataSet: TDataSet;
begin
  Result := dataset;
end;

function TdmMIPostgreSQLPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  dataset.RowsAffected;
end;

function TdmMIPostgreSQLPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbPostgreSQL.GetTableNames('',Result);
end;

procedure TdmMIPostgreSQLPHA.Rollback;
begin
  raise EAbstractError.Create('Fonctionnalité non prise en charge !');
end;

procedure TdmMIPostgreSQLPHA.DeconnexionBD;
begin
  dbPostgreSQL.Disconnect;
end;


procedure TdmMIPostgreSQLPHA.ExecuterScript(AScript: TStrings);
begin
  with script do
  begin
    Script.Clear;
    Script.AddStrings(AScript);
    Execute;
  end;
end;

function TdmMIPostgreSQLPHA.GererExceptionDataSet(E: Exception): Exception;
begin
  Result := E;
end;

function TdmMIPostgreSQLPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  with dataset do
  begin
    if Active then
      Close;
  end;
end;

end.
