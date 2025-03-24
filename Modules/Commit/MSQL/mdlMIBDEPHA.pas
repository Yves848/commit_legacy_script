unit mdlMIBDEPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, DB, uib, uibdataset,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, mydbunit, uibmetadata,
  fbcustomdataset, mdlActionTransaction, Controls, DBTables;

type
  TdmMIBDEPHA = class(TdmModuleImportPHA, IRequeteur)
    qryBDE: TQuery;
    dataset: TQuery;
    dbBDE: TDatabase;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure ConnexionBD; override;
    procedure DeconnexionBD; override;
    function RenvoyerDataSet : TDataSet;
    function RenvoyerTables : TStringList;
    procedure ChargerDataSet(ADataSet : TDataSet; ARequeteSQL : string);
    procedure ExecuterScript(AScript : TStrings);
    procedure Commit;
    procedure Rollback;
    function GererExceptionDataSet(E : Exception) : Exception;
    function LibererDataSet(ADataSet : TDataSet) : Boolean;
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
  end;

var
  dmMIBDEPHA: TdmMIBDEPHA;

implementation

{$R *.dfm}

procedure TdmMIBDEPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIBDEPHA := Self;

  if not (DirectoryExists(GetEnvironmentVariable('ProgramFiles')+'\Common Files\Borland Shared\BDE')
      or DirectoryExists(GetEnvironmentVariable('ProgramFiles')+'\Fichiers communs\Borland Shared\BDE')
      or DirectoryExists(GetEnvironmentVariable('ProgramFiles(x86)')+'\Fichiers communs\Borland Shared\BDE')
      or DirectoryExists(GetEnvironmentVariable('ProgramFiles(x86)')+'\Fichiers communs\Borland Shared\BDE')) then
    raise EProjet.Create('Attention : le répertoire BDE n''a pas été trouvé, pour lancer l''import il faut d''abord installer setup_bde.exe');
end;

procedure TdmMIBDEPHA.DeconnexionBD;
begin
  inherited;

end;

{ IRequeteur }

procedure TdmMIBDEPHA.ChargerDataSet(ADataSet: TDataSet;
  ARequeteSQL: string);
begin
  with dataset do
  begin
    if Active then
      Close;

    SQL.Text := ARequeteSQL;
    Open;
  end;
end;

procedure TdmMIBDEPHA.Commit;
begin
  raise EAbstractError.Create('Fonctionnalité non-prise en charge');
end;

procedure TdmMIBDEPHA.ConnexionBD;
begin
  inherited;
  if (dbBDE.Connected) then
    dbBDE.Close;
  dbBDE.Params.Values['PATH'] := ParametresConnexion.Values['bd'];
  dbBDE.Open;
end;

procedure TdmMIBDEPHA.ExecuterScript(AScript: TStrings);
begin
  raise EAbstractError.Create('Fonctionnalité non-prise en charge');
end;

function TdmMIBDEPHA.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := EDatabaseError.Create(E.Message)
end;

function TdmMIBDEPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  if dataset.Active then
    dataset.Close;
end;

function TdmMIBDEPHA.RenvoyerDataSet: TDataSet;
begin
  Result := dataset;
end;

function TdmMIBDEPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbBDE.GetTableNames(Result);
end;

function TdmMIBDEPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := -1;
end;

procedure TdmMIBDEPHA.Rollback;
begin
    raise EAbstractError.Create('Fonctionnalité non-prise en charge');
end;

end.
