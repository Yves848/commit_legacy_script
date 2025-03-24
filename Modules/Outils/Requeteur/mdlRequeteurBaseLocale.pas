unit mdlRequeteurBaseLocale;

interface

uses
  SysUtils, Classes, uib, DB, uibdataset, mdlPHA, mdlModuleOutils,
  Menus, JvMenus, Controls, UIBMetaData;

type
  TdmRequeteurBaseLocale = class(TdmModuleOutils, IRequeteur)
    setResultat: TUIBDataSet;
    trResultat: TUIBTransaction;
    scr: TUIBScript;
    trScr: TUIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function RenvoyerDataSet : TDataSet;
    function RenvoyerTables : TStringList;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string);
    procedure ExecuterScript(AScript : TStrings);
    function GererExceptionDataSet(E : Exception) : Exception;
    procedure Commit;
    procedure Rollback;
    function LibererDataSet(ADataSet : TDataSet) : Boolean;
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
  end;

var
  dmRequeteurBaseLocale: TdmRequeteurBaseLocale;

implementation

uses mdlProjet, mdlActionTransaction;

{$R *.dfm}

{ TdmRequeteurBaseLocale }

procedure TdmRequeteurBaseLocale.ChargerDataSet(ADataSet: TDataSet;
  ARequeteSQL: string);
begin
  with TUIBDataSet(ADataSet) do
  begin
    if not Transaction.InTransaction then
      Transaction.StartTransaction
    else
      if Active then
        Close;
    SQL.Text := ARequeteSQL;
    Open;
  end;
end;

procedure TdmRequeteurBaseLocale.ExecuterScript(AScript: TStrings);
begin
  if setResultat.Active then
    setResultat.Close;

  with scr do
  begin
    Script.Clear;
    Script.AddStrings(AScript);
    ExecuteScript;
 end;
end;

function TdmRequeteurBaseLocale.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := E;
end;

function TdmRequeteurBaseLocale.RenvoyerDataSet: TDataSet;
begin
  Result := setResultat;
end;

function TdmRequeteurBaseLocale.RenvoyerTables: TStringList;
var
  lMetaDonnees : TMetaDataBase;
  i : Integer;
begin
  Result := TStringList.Create;
  lMetaDonnees := TMetaDataBase(Projet.PHAConnexion.GetMetadata);
  for i := 0 to lMetaDonnees.TablesCount - 1 do Result.Add(lMetaDonnees.Tables[i].Name);
  for i := 0 to lMetaDonnees.ViewsCount - 1 do Result.Add(lMetaDonnees.Views[i].Name);

  // Procédures sélectables
  with TUIBQuery.Create(Self) do
  begin
    Database := Projet.PHAConnexion;
    Transaction := TUIBTransaction.Create(Self);
    Transaction.DataBase := Projet.PHAConnexion;
    SQL.Add('select trim(rdb$procedure_name)');
    SQL.Add('from rdb$procedures');
    SQL.Add('where rdb$procedure_inputs is null');
    SQL.Add('  and rdb$procedure_type = 1');
    Open;

    while not EOF do
    begin
      Result.Add(Fields.AsString[0]);
      Next;
    end;
    Close(etmCommit);
    Transaction.Free;
    Free;
  end;

  Result.Sort;
end;

procedure TdmRequeteurBaseLocale.DataModuleCreate(Sender: TObject);
begin
  inherited;

  setResultat.Database := Projet.PHAConnexion;
  trResultat.DataBase := Projet.PHAConnexion;
  trScr.DataBase := Projet.PHAConnexion;
end;

procedure TdmRequeteurBaseLocale.Commit;
begin
  if trResultat.InTransaction then trResultat.Commit;
  if trScr.InTransaction then trScr.Commit;
end;

procedure TdmRequeteurBaseLocale.Rollback;
begin
  if trResultat.InTransaction then trResultat.Rollback;
  if trScr.InTransaction then trScr.Rollback;
end;

function TdmRequeteurBaseLocale.LibererDataSet(ADataSet: TDataSet) : Boolean;
begin
   Result := True;
  if trResultat.InTransaction or trScr.InTransaction then
    case ActionTransaction('Base locale') of
      mrOk : Commit;
      mrAbort : Rollback;
    else
      Result := False;
    end;

  if Result then
    ADataSet.Close;
end;

function TdmRequeteurBaseLocale.RenvoyerLignesAffectees(
  ADataSet: TDataSet): Integer;
begin
  Result := TUIBDataSet(ADataSet).RowsAffected;
end;

end.

