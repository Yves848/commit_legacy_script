unit mdlMIOLEDBPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, DB, uib, uibdataset, mdlMIODBCPHA,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, mydbunit, uibmetadata,
  fbcustomdataset, mdlActionTransaction, Controls, ADODB, DBClient;

type
  TdmMIOLEDBPHA = class(TdmMIODBCPHA)
    dbOLEDB: TADOConnection;
    qryOLEDB: TADOQuery;
    adoDataset: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure DeconnexionBD; override;
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
  dmMIOLEDBPHA: TdmMIOLEDBPHA;

implementation

{$R *.dfm}

procedure TdmMIOLEDBPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIOLEDBPHA := Self;
end;

procedure TdmMIOLEDBPHA.DeconnexionBD;
begin
  if dbOLEDB.Connected then
    dbOLEDB.Close;
end;

{ IRequeteur }

procedure TdmMIOLEDBPHA.ChargerDataSet(ADataSet: TDataSet;
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

procedure TdmMIOLEDBPHA.Commit;
begin
  dbOLEDB.CommitTrans;
end;

procedure TdmMIOLEDBPHA.ExecuterScript(AScript: TStrings);
begin
  raise EAbstractError.Create('Fonctionnalité non-prise en charge');
end;

function TdmMIOLEDBPHA.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := EDatabaseError.Create(E.Message)
end;

function TdmMIOLEDBPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
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

function TdmMIOLEDBPHA.RenvoyerDataSet: TDataSet;
begin
  Result := adoDataset;
end;

function TdmMIOLEDBPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbOLEDB.GetTableNames(Result);
end;

function TdmMIOLEDBPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := -1;
end;

procedure TdmMIOLEDBPHA.Rollback;
begin
  dbOLEDB.RollbackTrans;
end;

end.
