unit mdlMISQLServeurPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, DB, uib, uibdataset, mdlMIOLEDBPHA,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, mydbunit, uibmetadata,
  fbcustomdataset, mdlActionTransaction, Controls, ADODB, Dialogs, StrUtils,
  DBClient, JclSysInfo;

type
  TdmMISQLServeurPHA = class(TdmMIOLEDBPHA, IRequeteur)
    procedure DataModuleCreate(Sender: TObject);
  private
    FFichierData: string;
    procedure SetFichierData(const Value: string);
    { Déclarations privées }
  public
    { Déclarations publiques }
    property FichierData : string read FFichierData write SetFichierData;
    procedure ConnexionBD; override;
    procedure DeconnexionBD; override;
    function RenvoyerChaineConnexion : string; override;
    function RenvoyerDataSet : TDataSet; override;
    function RenvoyerTables : TStringList; override;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string); override;
    procedure ExecuterScript(AScript : TStrings); override;
    procedure Commit; override;
    procedure Rollback; override;
    function GererExceptionDataSet(E : Exception) : Exception; override;
    function LibererDataSet(ADataSet : TDataSet) : Boolean; override;
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer; override;
  end;

var
  dmMISQLServeurPHA: TdmMISQLServeurPHA;

implementation

{$R *.dfm}

procedure TdmMISQLServeurPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMISQLServeurPHA := Self;
end;

function TdmMISQLServeurPHA.RenvoyerChaineConnexion : string;
var
  bd : string;
begin
  bd := ParametresConnexion.Values['serveur'] + ':' + ParametresConnexion.Values['bd'];
  Result := IfThen(ParametresConnexion.Values['authentification_windows'] = '0',
                   ParametresConnexion.Values['utilisateur'] + '@' + bd, bd);
end;

procedure TdmMISQLServeurPHA.ConnexionBD;
const
  C_DRIVER_ADO_SQLOLEDB = 'SQLOLEDB';
  C_DRIVER_ADO_SQL_NATIVE = 'SQLNCLI';
  C_SQL_SERVER_CHAINE_CONNEXION = 'Provider=%s.1;%sPersist Security Info=False;User ID=%s;Password=%s;Initial Catalog=%s;%sData Source=%s';
  C_SQL_SERVER_SECURITE_NT = 'Integrated Security=SSPI;';
  C_SQL_SERVER_INITIAL_FILE_NAME = 'Initial File Name=%s;';
var
  p : TStringList;
begin
  with dbOLEDB do
  begin
    if Connected then
      Connected := False;

    // Recherche d'un serveur SQL Server
    p := TStringList.Create;
    RunningProcessesList(p, False);
    if (p.IndexOf('sqlservr.exe') <> -1) and (ParametresConnexion.Values['authentification_windows'] = '1') and (FFichierData <> '') then
    begin
        ConnectionString := Format(C_SQL_SERVER_CHAINE_CONNEXION, [IfThen(ParametresConnexion.Values['connexion_locale'] = '0', C_DRIVER_ADO_SQLOLEDB, C_DRIVER_ADO_SQL_NATIVE),
                                                                   C_SQL_SERVER_SECURITE_NT, '', '', 'master', '',
                                                                   ParametresConnexion.Values['serveur']]);
        Connected := True;
        with qryOLEDB do
        begin
          SQL.Clear;
          SQL.Add('select count(*) from sys.databases where name = ' + '''' + ParametresConnexion.Values['bd'] + '''');
          Open;
          if Fields[0].AsInteger = 1 then
          begin
            Close;
            SQL.Clear;
            SQL.Add('alter database ' + ParametresConnexion.Values['bd'] + ' set offline');
            ExecSQL;
            SQL.Clear;
            SQL.Add('exec sys.sp_detach_db ' + QuotedStr(ParametresConnexion.Values['bd']) + ', true');
            ExecSQL;
          end
          else
            Close;
        end;
        Close;
      //end
      //else
      //  raise EDatabaseError.Create('Le fichier de base données que vous essayez d''attacher n''existe pas !');
    end;

    ConnectionString := Format(C_SQL_SERVER_CHAINE_CONNEXION, [IfThen(ParametresConnexion.Values['connexion_locale'] = '0', C_DRIVER_ADO_SQLOLEDB, C_DRIVER_ADO_SQL_NATIVE),
                                                               IfThen(ParametresConnexion.Values['authentification_windows'] = '1', C_SQL_SERVER_SECURITE_NT),
                                                               ParametresConnexion.Values['utilisateur'],
                                                               ParametresConnexion.Values['mot_de_passe'],
                                                               ParametresConnexion.Values['bd'],
                                                               IfThen((FFichierData <> '') and (ParametresConnexion.Values['authentification_windows'] = '1'), Format(C_SQL_SERVER_INITIAL_FILE_NAME, [FFichierData])),
                                                               ParametresConnexion.Values['serveur']]);
    FreeAndNil(p);

    Connected := True;
  end;
end;

procedure TdmMISQLServeurPHA.DeconnexionBD;
begin
  dbOLEDB.Connected := False;
end;

{ IRequeteur }

procedure TdmMISQLServeurPHA.ChargerDataSet(ADataSet: TDataSet;
  ARequeteSQL: string);
begin
  with adoDataset do
  begin
    if Active then
      Close;

    SQL.Text := ARequeteSQL;
    Open;
  end;
end;

procedure TdmMISQLServeurPHA.Commit;
begin
  dbOLEDB.CommitTrans;
end;

procedure TdmMISQLServeurPHA.ExecuterScript(AScript: TStrings);
begin
  raise EAbstractError.Create('Fonctionnalité non-prise en charge');
end;

function TdmMISQLServeurPHA.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := EDatabaseError.Create(E.Message)
end;

function TdmMISQLServeurPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  Result := True;
  if dbOLEDB.InTransaction then
    case ActionTransaction(ParametresConnexion.Values['bd']) of
      mrOk : Commit;
      mrAbort : Rollback;
    else
      Result := False;
    end;

  if Result then
    if adoDataset.Active then
      adoDataset.Close;
end;

function TdmMISQLServeurPHA.RenvoyerDataSet: TDataSet;
begin
  Result := adoDataset;
end;

function TdmMISQLServeurPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbOLEDB.GetTableNames(Result);
end;

function TdmMISQLServeurPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := -1;
end;

procedure TdmMISQLServeurPHA.Rollback;
begin
  dbOLEDB.RollbackTrans;
end;

procedure TdmMISQLServeurPHA.SetFichierData(const Value: string);
begin
  if FileExists(Value) then
    FFichierData := Value
  else
    FFichierData := '';
end;

end.
