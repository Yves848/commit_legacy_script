unit mdlPharmaVitalePHA;

interface

uses
  SysUtils, Classes, mdlPHA, mdlModuleImportPHA, uib,
  uibdataset, mydbunit, fbcustomdataset, mdlModule, DB,
  uibmetadata, ADODB, Dialogs, mdlProjet, Controls;

type
  TTraitementPharmaVitale = class(TTraitement)
  private
    FProcedureCreation: string;
    FIndex: Integer;
    FRequeteSelection: string;
  public
    property Index : Integer read FIndex write FIndex;
    property RequeteSelection : string read FRequeteSelection write FRequeteSelection;
    property ProcedureCreation : string read FProcedureCreation write FProcedureCreation;
  end;

  TdmPharmaVitalePHA = class(TdmModuleImportPHA, IRequeteur)
    dbPharmaVitale: TADOConnection;
    qryPharmaVitale: TADOQuery;
    dataset: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ConnexionPharmaVitale(AChaineConnexion: string): Boolean;
    procedure DeconnexionPharmaVitale;
    procedure CompleterInfoTraitements(ATraitements: TTraitements);
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
  dmPharmaVitalePHA: TdmPharmaVitalePHA;

implementation

uses mdlActionTransaction;

{$R *.dfm}

procedure TdmPharmaVitalePHA.CompleterInfoTraitements(
  ATraitements: TTraitements);
var
  lTraitement : TTraitementPharmaVitale;
begin
  with qryPHA do
  begin
    Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add('select *');
    SQL.Add('from v_pharmavitale_traitement');

    Open;

    while not EOF do
    begin
      lTraitement := TTraitementPharmaVitale(ATraitements.Traitements[Fields.ByNameAsString['NOM_FICHIER']]);

      if Assigned(lTraitement) then
      begin
        lTraitement.Index := Fields.ByNameAsInteger['T_PHARMAVITALE_TRAITEMENT_ID'];
        lTraitement.RequeteSelection := Fields.ByNameAsString['REQUETE_SELECTION'];
        lTraitement.ProcedureCreation := Fields.ByNameAsString['PROCEDURE_CREATION'];
      end;
      Next;
    end;

    Close(etmCommit);
  end;
end;

procedure TdmPharmaVitalePHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  dmPharmaVitalePHA := Self;
end;

procedure TdmPharmaVitalePHA.ChargerDataSet(ADataSet: TDataSet;
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

procedure TdmPharmaVitalePHA.Commit;
begin
  dbPharmaVitale.CommitTrans;
end;

procedure TdmPharmaVitalePHA.ExecuterScript(AScript: TStrings);
begin

end;

function TdmPharmaVitalePHA.GererExceptionDataSet(E: Exception) : Exception;
begin
  Result := EDatabaseError.Create(E.Message)
end;

function TdmPharmaVitalePHA.LibererDataSet(ADataSet: TDataSet): Boolean;
begin
  Result := True;
  if dbPharmaVitale.InTransaction then
    case ActionTransaction of
      mrOk : Commit;
      mrAbort : Rollback;
    else
      Result := False;
    end;

  if Result then
    if dataset.Active then
      dataset.Close;
end;

function TdmPharmaVitalePHA.RenvoyerDataSet: TDataSet;
begin
  if not dbPharmaVitale.Connected then
    with TfrModule(Projet.ModuleEnCours.IHM) do
    begin
      Connecter('', '');
      if Connecte then
        Result := dataset
      else
        Result := nil;
    end
  else
    Result := dataset;
end;

function TdmPharmaVitalePHA.RenvoyerTables: TStringList;
begin
  Result := TStringList.Create;
  dbPharmaVitale.GetTableNames(Result);
end;

function TdmPharmaVitalePHA.RenvoyerLignesAffectees(ADataSet : TDataSet) : Integer;
begin
  Result := dataset.RowsAffected;
end;

procedure TdmPharmaVitalePHA.Rollback;
begin
  dbPharmaVitale.RollbackTrans;
end;

function TdmPharmaVitalePHA.ConnexionPharmaVitale(AChaineConnexion: string): Boolean;
begin
  with dbPharmaVitale do
  begin
    try
      if Connected then
        Connected := False;

      if AChaineConnexion <> '' then
        ConnectionString := AChaineConnexion;
      Connected := True;
      Result := True;
    except
      on E:EDatabaseError do
      begin
        MessageDlg('Impossible de se connecter à la base PharmaVitale !'#13#10#13#10 +
                   'Message : ' + E.Message + #13#10,
                   mtError, [mbOk], 0);

        Result := False;
      end;

      on E:Exception do
      begin
        MessageDlg('Impossible de se connecter à la base PharmaVitale !'#13#10#13#10 +
                   'Message : ' + E.Message + #13#10,
                   mtError, [mbOk], 0);

        Result := False;
      end;
    end;
  end;
end;

procedure TdmPharmaVitalePHA.DeconnexionPharmaVitale;
begin
  dbPharmaVitale.Connected := False;
end;

end.
