unit mdlMIFirebirdPHA;

interface

uses
  Windows, SysUtils, Classes, mdlPHA, DB, uib, uibdataset,
  IniFiles, Registry, mdlProjet, mdlModuleImportPHA, mydbunit, uibmetadata,
  fbcustomdataset, mdlActionTransaction, Controls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZConnection, Dialogs, ZAbstractConnection;

type
  TdmMIFirebirdPHA = class(TdmModuleImportPHA, IRequeteur)
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
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
    procedure ExecuterScript(AScript : TStrings);
    procedure Commit;
    procedure Rollback;
    function GererExceptionDataSet(E : Exception) : Exception;
    function LibererDataSet(ADataSet : TDataSet) : Boolean;
    function RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
  end;

var
  dmMIFirebirdPHA: TdmMIFirebirdPHA;

implementation

{$R *.dfm}

procedure TdmMIFirebirdPHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmMIFirebirdPHA := Self;

  ZConnection1.User := 'SYSDBA';
  ZConnection1.PassWord := 'masterkey';
end;

procedure TdmMIFirebirdPHA.ConnexionBD;
const
  C_CHAINE_CONNEXION_FB : string = '%s/3050:%s';
begin
  SetCurrentDir(Module.Projet.RepertoireProjet);   // si chemin relatif
  ZConnection1.Database := ParametresConnexion.Values['bd'];
  if ParametresConnexion.Values['connexion_locale'] = '0' then
    ZConnection1.HostName := ParametresConnexion.Values['serveur']
  else
    ZConnection1.HostName := '';

  ZConnection1.Connect;
end;

function TdmMIFirebirdPHA.RenvoyerChaineConnexion : string;
begin
  //Result := dbFirebird.DatabaseName;
  Result := ZConnection1.Database;
end;

procedure TdmMIFirebirdPHA.DeconnexionBD;
begin
  //dbFirebird.Connected := False;
  ZConnection1.Disconnect;
end;

{ IRequeteur }

procedure TdmMIFirebirdPHA.ChargerDataSet(ADataSet: TDataSet;
  ARequeteSQL: string);
begin
  //with TUIBDataSet(ADataSet) do
  with TZQuery(ADataSet) do
  begin
    //if not Transaction.InTransaction then
    //  Transaction.StartTransaction
    if not Connection.InTransaction then
      Connection.StartTransaction
    else
      if Active then
        Close;
    SQL.Text := ARequeteSQL;
    Open;
  end;
end;

procedure TdmMIFirebirdPHA.Commit;
begin
  //if tr.InTransaction then tr.Commit;
  //if trScr.InTransaction then trScr.Commit;
  ZConnection1.Commit;
end;

procedure TdmMIFirebirdPHA.ExecuterScript(AScript: TStrings);
begin
  //if dataset.Active then
  //  dataset.Close;
  if ZQuery1.Active then
    ZQuery1.Close;

  MessageDlg('Fonctionnalité non prise en charge ', mtInformation, [mbOk], 0);
end;

function TdmMIFirebirdPHA.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := EDatabaseError.Create(E.Message)
end;

function TdmMIFirebirdPHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  Result := True;
  //if tr.InTransaction or trScr.InTransaction then
  if ZConnection1.InTransaction then
    case ActionTransaction(Module.Projet.ModuleImport.Description) of
      mrOk : Commit;
      mrAbort : Rollback;
    else
      Result := False;
    end;

  if Result then
    ADataSet.Close;
end;

function TdmMIFirebirdPHA.RenvoyerDataSet: TDataSet;
begin
  //Result := dataset;
  Result := ZQuery1;
end;

function TdmMIFirebirdPHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  ZConnection1.GetTableNames('', Result);
end;

function TdmMIFirebirdPHA.RenvoyerLignesAffectees(ADataSet: TDataSet): Integer;
begin
  Result := 0;
end;

procedure TdmMIFirebirdPHA.Rollback;
begin
  //if tr.InTransaction then tr.Rollback;
  //if trScr.InTransaction then trScr.Rollback;
  ZConnection1.Rollback;
end;

end.
